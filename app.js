var express 	= require("express"),
	mysql   	= require("mysql"),
	bodyParser 	= require("body-parser");

var	app 		= express();

//Connect to mySQL Database
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'project'
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
	res.send("Welcome to Database project");
});
//index Route
app.get("/Welcome", function(req, res){
	res.render("index");
});





//Listen on localhost:8000
app.listen(8000, 'localhost', function(){
   console.log("The Service is running");
});