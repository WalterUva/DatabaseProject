<<<<<<< HEAD
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

//Root Routes
// =====================================
// HOME PAGE (with login links) ========
// =====================================
app.get('/', function(req, res) {
	connection.query("SELECT * from Car", function (err, results, fields) {
		if(!err){
			res.render("index",{Cars:results});
		} 
		else {
			console.log(this.sql);
		}
	});
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

app.get("/customers", function(req, res) {
	if (typeof req.session.username == 'undefined') {
		res.render("login");
	}
	else if (req.session.authority === 'DBManager') {
		var add = req.query.add;
		var username = req.session.username;
		var selectQuery = 'select * from User natural join Customer;'
		connection.query(selectQuery, function(err, results, fields) {
			if(err) console.log(this.sql);
			console.log(results[0]);
			res.render("admin_customers", {customers: results, addMode: add});
		});
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
		var add = req.query.add;
		var selectQuery = 'select * from User natural join Dealer;'
		connection.query(selectQuery, function(err, results, fields) {
			if(err) console.log(this.sql);
			res.render("admin_dealers", {dealers: results, addMode: add});
		});
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
				console.log(results[0]);
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

//Add a new Car to database
app.get("/Car/new", function (req, res) {
	res.render("newCar")
});
	    //Process the add Car Form
app.post("/Car", function (req, res) {
	var car_id = Math.floor(Math.random() * 1000000);
    newCar = {
        Brand: req.body.Brand,
        Model: req.body.Model,
        Year: req.body.Year,
        Type: req.body.Type,
        Price: req.body.Price,
        Mileage: req.body.Mileage,
        Image: req.body.Image,
   };
	var query = "insert into Car(car_id, model_name, type_name, brand_name, year_of_production, mileage, imageURL, price)values("+car_id+",'"+newCar.Model+"','" + newCar.Type+"','" + newCar.Brand + "'," + newCar.Year + "," + newCar.Mileage + ",'" + newCar.Image + "'"+ newCar.Price +")";
    connection.query(query, function (err, results, fields) {   
		if(!err){
			res.redirect("/");
		} 
		else {
			console.log(this.sql);
		}
    });
});
	
//show the detail of a Car
app.get("/Car/:id", function (req, res) {
	connection.query("SELECT * from Car WHERE car_id="+ req.params.id, function (err, rows, fields){
		if(!err) {
			res.render("show",{Car:rows[0]});
		} 
		else {
			console.log('Error while performing Query');
		}
	});
});
	
app.get("/Car/:id/update", function (req, res) {
	res.send("Update");
		// connection.query(" * from Car WHERE car_id="+ req.params.id, function (err, rows, fields){
		// 	if(!err){
		// 		res.render("show",{Car:rows[0]});
		// 	} else {
		// 		console.log('Error while performing Query');
		// 	}
		// });
});

app.get("/Car/:id/delete", function (req, res) {
	// res.send("delete");
	connection.query("DELETE from Car WHERE car_id="+ req.params.id, function (err, rows, fields){
		if(!err){
			res.redirect("/");
		} else {
			console.log('Error while performing Query');
		}
	});
});
	
//Search a car
app.get("/search", function (req, res){
	res.render("search");
});
	
app.post("/search", function (req, res){
	var brand = req.body.Brand;
	var model = req.body.Model;
	var query = "SELECT * from Car WHERE brand_name= '"+brand+"' and model_name= '"+model+"'";
	connection.query(query, function (err, rows, fields){
		if(!err){
			res.render("results",{Cars:rows});
		}
		else {
			console.log(this.sql);
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
				var insertQuery = 'insert into User (username, password, register_date) values ("' + username + '", UNHEX("' + hashed_password + '")' + ', CURDATE());';
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
	var name = req.body.name;
	var phone = req.body.phone;
	var email = req.body.email;
	var zipcode = req.body.zipcode;
	
	var updateQuery = 'update User set name="' + name
		+ '", phone="' + phone + '", email="' + email + '", zipcode=' + zipcode + ', register_date=' + 'CURDATE() '
		+ 'where username="' + username + '";'
	
	connection.query(updateQuery, function (err, results, fields) {
		if (err) console.log('this.sql', this.sql);
		else {
			req.session.tempName = null;
			res.redirect("login");
		}
	});
});

app.post("/newDealer", function(req, res) {
	var username = req.body.username;
	var passwd = req.body.passwd;
	var name = req.body.name;
	var phone = req.body.phone;
	var email = req.body.email;
	var zipcode = req.body.zipcode;
	
	var selectQuery = 'select * from User where username="' + username + '";';
	connection.query(selectQuery, function addUser(err, results, fields) {
		if(err) console.log(this.sql);
		else if (results[0] != null) {
			res.render("admin_dealers", {addMode: true, errorAddDealer: "Username is taken."});
		}	
		else {
			const hash = crypto.createHash('sha256');
			hash.update(username+passwd+username.length.toString());
			var hashed_password = hash.digest('hex');
			var insertQuery = 'insert into User (username, password, name, phone, email, zipcode, register_date, authority) values ("' 
				+ username + '", UNHEX("' + hashed_password + '"), "' + name + '", "' +  phone + '", "' +  email + '", ' +  zipcode + ', CURDATE(), "Dealer");'
			connection.query(insertQuery, function(err, results, fields) {
				if (err) console.log(this.sql);
				else {
					var insertQuery2 = 'insert into Dealer (username) values ("' + username + '");'
					connection.query(insertQuery2, function (err, results, fields) {
						if (err) throw err;
						else {
							res.redirect("dealers");
						}
					});
				}
			});
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
				var insertQuery = 'insert into User (username, password, register_date, authority) values ("' + username + '", UNHEX("' + hashed_password + '"), CURDATE(), "DBManager");';
				connection.query(insertQuery, function(err, results, fields) {
					if (err) {
						console.log(this.sql);
					}
					else {
						res.redirect("login");
					}
				});
			}
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

app.post("/editProfile", function(req, res) {
	var username = req.session.username;
	//var newusername = req.body.username;
	var curpasswd = req.body.currentpasswd;
	var newpasswd = req.body.newpasswd;
	var newpasswd2 = req.body.newpasswd2;
	var name = req.body.name;
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
				var updateQuery = 'update User set name="' + name
					+ '", phone="' + phone + '", email="' + email + '", zipcode=' + zipcode + ' '
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
				
				var updateQuery = 'update User set password=UNHEX("' + hashed_password2 + '"), name="' + name  
					+ '", phone="' + phone + '", email="' + email + '", zipcode=' + zipcode + ' '
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
app.listen(port);
console.log('The magic happens on port ' + port);