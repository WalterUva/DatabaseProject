var express 	= require("express"),
	mysql   	= require("mysql"),
	session = require('express-session'),
	bodyParser 	= require("body-parser"),
	path = require('path'),
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

//css
app.use(express.static(path.join(__dirname, 'public')));

//set up bodyParser and view engine
app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");

//Root Routes
app.get("/", function(req, res){
	res.redirect("/Welcome");
});
//index Route
app.get("/Welcome", function(req, res){
	console.log(req.session.username);
	console.log(req.session.authority);
	res.render("index", {username: req.session.username, welcome: true});
});

app.get("/sign-up", function(req, res) {
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

//For debugging purposes only
app.get("/create-admin", function(req, res) {
	res.render("createAdmin");
});

app.get("/admin", function(req, res) {
	if (typeof req.session.username == 'undefined') {
		res.render("login");
	}
	else if (req.session.authority === 'DBManager') {
		res.render("admin");
	}
	else {
		res.redirect("/Welcome");
	}
});

app.get("/dealers", function(req, res) {
	if (typeof req.session.username == 'undefined') {
		res.render("login");
	}
	else if (req.session.authority === 'DBManager') {
		res.render("admin_dealers");
	}	
	else {
		res.redirect("/Welcome");
	}
	
});

app.get("/profile", function(req, res) {
	if (typeof req.session.username == 'undefined') {
		res.render("login");
	}
	else {
		var edit = req.query.edit;
		var username = req.session.username;
		var selectQuery = 'select * from User where username = "' + username + '";' 
		connection.query(selectQuery, function(err, results, fields) {
			if(err) console.log(this.sql);
			else if (results[0] != null) {
				res.render("profile", {user: results[0], editMode: edit});
			}
		});
	}
});

app.get("/logout", function(req, res){
	delete req.session.username;
	delete req.session.authority;
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

app.post("/newUser", function(req, res) {
	var username = req.body.username;
	var passwd = req.body.passwd;
	var passwd2 = req.body.passwd2;	
	
	var selectQuery = 'select * from User where username="' + username + '";';
	connection.query(selectQuery, function addUser(err, results, fields) {
		if(err) console.log(this.sql);
		else if (results[0] != null) {
			res.render("signUp", {errorSignUp: "Username is taken."});
		}	
		else {
			if (passwd != passwd2) {
				res.render("signUp", {errorSignUp: "Passwords do not match"});
			}
			else {
				const hash = crypto.createHash('sha256');
				hash.update(username+passwd+username.length.toString());
				var hashed_password = hash.digest('hex');
				var insertQuery = 'insert into User (username, password) values ("' + username + '", UNHEX("' + hashed_password + '"));'
				connection.query(insertQuery, function(err, results, fields) {
					if (err) {
						console.log(this.sql);
					}
					else {
						var insertQuery2 = 'insert into Customer (username) values ("' + username + '");'
						connection.query(insertQuery2, function (err, results, fields) {
							if (err) throw err;
							else {
								req.session.tempName = username;
								res.render("signUp2");
							}
						});
					}
				});
			}
		}
	});
});

app.post("/newUser2", function(req, res){
	var username = req.session.tempName;
	var fname = req.body.firstname;
	var lname = req.body.lastname;
	var phone = req.body.phone;
	var email = req.body.email;
	var zipcode = req.body.zipcode;
	
	var updateQuery = 'update User set firstname="' + fname + '", lastname="' + lname 
		+ '", phone="' + phone + '", email="' + email + '", zipcode="' + zipcode + '", register_date=' + "CURDATE() "
		+ 'where username="' + username + '";'
	
	connection.query(updateQuery, function (err, results, fields) {
		if (err) console.log('this.sql', this.sql);
		else {
			req.session.tempName = null;
			res.redirect("login");
		}
	});
});

app.post("/login", function(req, res){
	var username = req.body.username;
	var passwd = req.body.passwd;
	
	var selectQuery = 'select password, authority from User where username = "' + username + '";' 
	connection.query(selectQuery, function(err, results, fields) {
		if (err) {
			console.log(this.sql);
		}
		else {
			const hash = crypto.createHash('sha256');
			hash.update(username+passwd+username.length.toString());
			var hashed_password = hash.digest('hex');
			if (results[0] != null && hashed_password === results[0].password.toString('hex')) {
				req.session.username = username;
				req.session.authority = results[0].authority;
				if(req.session.authority === "DBManager") {
					res.redirect("admin");
				}
				else {
					res.redirect("/Welcome");
				}
				
			} else {
				res.render("login", {errorLogin: "Username or password is incorrect."});
			}
		}
	});
});

//For debugging purposes only
app.post("/newAdmin", function(req, res) {
	var username = req.body.username;
	var passwd = req.body.passwd;
	var passwd2 = req.body.passwd2;	
	
	var selectQuery = 'select * from User where username="' + username + '";';
	connection.query(selectQuery, function addUser(err, results, fields) {
		if(err) console.log(this.sql);
		else if (results[0] != null) {
			res.render("createAdmin", {error: "Username is taken."});
		}	
		else {
			if (passwd != passwd2) {
				res.render("createAdmin", {error: "Passwords do not match"});
			}
			else {
				const hash = crypto.createHash('sha256');
				hash.update(username+passwd+username.length.toString());
				var hashed_password = hash.digest('hex');
				var insertQuery = 'insert into User (username, password, authority) values ("' + username + '", UNHEX("' + hashed_password + '"), "DBManager");';
				connection.query(insertQuery, function(err, results, fields) {
					if (err) {
						console.log(this.sql);
					}
					else {
						var insertQuery2 = 'insert into Customer (username) values ("' + username + '");'
						connection.query(insertQuery2, function (err, results, fields) {
							if (err) throw err;
							else {
								res.redirect("login");
							}
						});
					}
				});
			}
		}
	});
});

app.post("/editProfile", function(req, res) {
	var username = req.session.username;
	//var newusername = req.body.username;
	var curpasswd = req.body.currentpasswd;
	var newpasswd = req.body.newpasswd;
	var newpasswd2 = req.body.newpasswd2;
	var fname = req.body.firstname;
	var lname = req.body.lastname;
	var phone = req.body.phone;
	var email = req.body.email;
	var zipcode = req.body.zipcode;
	
	var selectQuery = 'select * from User where username="' + username + '";';
	
	connection.query(selectQuery, function (err, results, fields) {
		const hash = crypto.createHash('sha256');
		hash.update(username+curpasswd+username.length.toString());
		var hashed_password = hash.digest('hex');
		var user = results[0];
		if (results[0] != null && hashed_password === results[0].password.toString('hex')) {
			if(newpasswd.length == 0 && newpasswd2.length == 0) {
				var updateQuery = 'update User set firstname="' + fname + '", lastname="' + lname 
					+ '", phone="' + phone + '", email="' + email + '", zipcode="' + zipcode + '" '
					+ 'where username="' + username + '";'
				connection.query(updateQuery, function(err, results, fields) {
					if (err) {
						console.log(this.sql);
					}
					else {
						res.redirect("profile");
					}
				});	
			}		
			else if(newpasswd !== newpasswd2) {
				res.render("/profile?edit=true", {errorEditing: "New password does not match."});
			}	
			else {
				const hash2 = crypto.createHash('sha256');
				hash2.update(username+newpasswd+username.length.toString());
				var hashed_password2 = hash2.digest('hex');
				
				var updateQuery = 'update User set password=UNHEX("' + hashed_password2 + '"), firstname="' + fname + '", lastname="' + lname 
					+ '", phone="' + phone + '", email="' + email + '", zipcode="' + zipcode + '" '
					+ 'where username="' + username + '";'
				connection.query(updateQuery, function(err, results, fields) {
					if (err) {
						console.log(this.sql);
					}
					else {
						res.redirect("profile");
					}
				});
			}
		}
		else {
			res.render("profile", {user: user, editMode: true, errorEditing: "Incorrect password."});
		}
	});
});

//Listen on localhost:8000
app.listen(8000, 'localhost', function(){
   console.log("The Service is running");
});