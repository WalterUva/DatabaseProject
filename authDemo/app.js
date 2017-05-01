var express = require("express"),
	bodyParser = require("body-parser"),
	passport = require("passport"),
	passportConfig = require("./config/passport.js");

var mysql = require('mysql');

var connection = mysql.createConnection({
      host     : 'localhost',
      user     : 'root',
      password : 'project',
      database : 'Project'
});

var app = express();
//set up view engine
app.set('view engine','ejs');
//configure passport
passportConfig(passport);

app.get("/",function(req,res){
	res.render("index");
});

app.get("/register", function(req, res){
	res.render("register");
});
app.POST("/register", function(req, res){

})

app.get("/login", function(req, res){
	res.render("/login");
});

app.get("/logout", function(req, res){
	res.send("You've logged out!");
});

//Listen on localhost:8000
app.listen(8000, 'localhost', function(){
   console.log("The Service is running");
});