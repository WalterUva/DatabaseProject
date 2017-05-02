var express = require("express"),
	mysql = require("mysql"),
	passport = require("passport"),
	passportConfig = require("./config/passport.js"),
	session  = require('express-session'),
	cookieParser = require('cookie-parser'),
	bodyParser = require('body-parser'),
	morgan = require('morgan'),
	methodOverride = require("method-override"),
	app      = express(),
	port     = process.env.PORT || 8080;

	var passport = require('passport');
	var flash    = require('connect-flash');
	var dbconfig = require('./config/database.js');
	var connection = mysql.createConnection(dbconfig.connection);
	connection.query("USE project2");
require('./config/passport')(passport); // pass passport for configuration
// set up our express application
app.use(morgan('dev')); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)
app.use(bodyParser.urlencoded({
	extended: true
}));
app.use(express.static(__dirname + "/public"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
app.set('view engine', 'ejs'); // set up ejs for templating

// required for passport
app.use(session({
	secret: 'vidyapathaisalwaysrunning',
	resave: true,
	saveUninitialized: true
 } )); // session secret
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages stored in session

//set up bodyParser and view engine

//Root Routes
// routes ======================================================================
require('./routes.js')(app, passport, connection); // load our routes and pass in our app and fully configured passport

//Listen on localhost:8000
app.listen(port);
console.log('The magic happens on port ' + port);