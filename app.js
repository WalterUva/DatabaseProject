var express 	= require("express"),
	mysql   	= require("mysql"),
	bodyParser 	= require("body-parser");

var	app 		= express();

//Connect to mySQL Database
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'project',
  database : 'Project'
});
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
	res.render("index");
});

app.get("/signup", function(req, res){
	res.render("SignUp");
});
app.get("/signin", function(req, res){
	res.render("SignIn");
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

app.post("/signin", function(req, res){
	var Username = req.body.Username;
	var Password = req.body.Password;
	connection.query('select Password from User where Username = "' + Username +'"' , function(err, results, fields){
		if(err) throw err;
		else {
			if (Password === results[0].Password){
				res.send("Log In successfully!");
			} else {
				res.send(results[0].Password);
			}
		}
	});
});

app.post("/NewUser", function(req, res){
	var Username = req.body.Username;
	var Password = req.body.Password;
	var Phone = req.body.Phone;
	var Email = req.body.Email;
	connection.query('insert into User (Username, Password, Phone, Email) values ("' + Username + '", "' + Password + '", "' + Phone + '", "' + Email + '")',
	function (err, results, fields) {
	    if (err) throw err;
	    else res.send('success');
	});
});




//Listen on localhost:8000
app.listen(8000, 'localhost', function(){
   console.log("The Service is running");
});