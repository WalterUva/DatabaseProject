var express 	= require("express"),
	mysql   	= require("mysql"),
	session = require('express-session'),
	bodyParser 	= require("body-parser");
	crypto = require('crypto');
	
var MySQLStore = require('express-mysql-session')(session);

var options = {
  host     : 'localhost',
  user	   : 'dbproject',
  password : 'project',
  database : 'Project'
  //  host     : 'localhost',
//  user     : 'root',
//  password : 'project',
//  database : 'Project'
};

//Connect to mySQL Database
var connection = mysql.createConnection(options);
var sessionStore = new MySQLStore({}, connection);

var	app = express();

app.use(session({
    key: 'session_cookie_name',
    secret: 'session_cookie_secret',
    store: sessionStore,
    resave: true,
    saveUninitialized: true
}));

connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  console.log('connected as id ' + connection.threadId);
});

//set up bodyParser and view engine
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");

//Root Routes
app.get("/", function(req, res){
	res.redirect("/Welcome");
});
//index Route
app.get("/Welcome", function(req, res){
	console.log(req.session.username)
	res.render("index", {username: req.session.username, welcome: true});
});

app.get("/signup", function(req, res){
	res.render("signUp");
});

app.get("/login", function(req, res){
	if (typeof req.session.username == 'undefined') {
		res.render("login");
	}
	else {
		res.redirect("/Welcome");
	}
});

app.get("/logout", function(req, res){
	delete req.session.username;
	res.redirect("/Welcome");
});

app.get("/Car/new", function(req, res){
	res.render("newCar")
});

app.get("/Car/:id", function(req, res){
	res.render("show");
});
app.post("/Car", function(req,res){
	newCar = {
		Brand : req.body.Brand,
		Model : req.body.Model,
		Year  : req.body.Year,
		Type  : req.body.Type,
		Title : req.body.Title,
		Price : req.body.Price,
		Mileage : req.body.Mileage,
		Image : req.body.Image,
		Description : req.body.Description
	};
	connection.query("show databases", function(err, results, fields){
		if(err) throw err;
		else {
			res.send(newCar);
		}
	});
});

app.post("/login", function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	connection.query('select password from User where username = "' + username + '"' , function(err, results, fields){
		if(err) 
			throw err;
		else {
			const hash = crypto.createHash('sha256');
			hash.update(username+password+username.length.toString());
			var hashed_password = hash.digest('hex');
			if (results[0] != null && hashed_password === results[0].password.toString('hex')) {
				req.session.username = username;
				res.redirect("/Welcome");
			} else {
				res.render("login", {error: "Username or password is incorrect."});
			}
		}
	});
});

app.post("/NewUser", function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var password2 = req.body.password2;
	var fname = req.body.firstname;
	var lname = req.body.lastname;
	var phone = req.body.phone;
	var email = req.body.email;
	var zipcode = req.body.zipcode;
	
	if (!res.headersSent && password != password2) {
		res.render("signUp", {error: "Password does not match"});
		res.end();
	}
	
	if (!res.headersSent) {
		const hash = crypto.createHash('sha256');
		hash.update(username+password+username.length.toString());
		var hashed_password = hash.digest('hex');
	
		connection.query('insert into User (username, password, firstname, lastname, phone, email, zipcode, register_date) values ("' 
		+ username + '", UNHEX("' + hashed_password + '"), "' + fname + '", "' + lname + '", "' + phone + '", "' 
		+ email + '", "' + zipcode + '", ' + "CURDATE()" + ');',
		function (err, results, fields) {
			if (err) {
				res.render("signUp", {error: "Username is taken.", 
				firstname: fname,
				lastname: lname,
				phone: phone,
				email: email,
				zipcode: zipcode
				});
				//console.log('this.sql', this.sql);
			}
			else {
				connection.query('insert into Customer (username) values ("' + username + '")',
				function (err, results, fields) {
					if (err) throw err;
					else return res.render("login");
				});
			}
		});
	}
});

//Listen on localhost:8000
app.listen(8000, 'localhost', function(){
   console.log("The Service is running");
});