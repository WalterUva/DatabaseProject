// app/routes.js
module.exports = function(app, passport, connection) {

	// =====================================
	// HOME PAGE (with login links) ========
	// =====================================
	app.get('/', function(req, res) {
		connection.query("SELECT * from Car", function (err, rows, fields){
			if(!err){
				res.render("index",{Cars:rows});
			} else {
				console.log('Error while performing Query');
			}
		});
	});

	// =====================================
	// LOGIN ===============================
	// =====================================
	// show the login form
	app.get('/login', function(req, res) {
		// render the page and pass in any flash data if it exists
		res.render('login.ejs', { message: req.flash('loginMessage') });
	});

	// process the login form
	app.post('/login', passport.authenticate('local-login', {
            successRedirect : '/', // redirect to the secure profile section
            failureRedirect : '/login', // redirect back to the signup page if there is an error
            failureFlash : true // allow flash messages
		}),
        function(req, res) {
            console.log("hello");

            if (req.body.remember) {
              req.session.cookie.maxAge = 1000 * 60 * 3;
            } else {
              req.session.cookie.expires = false;
            }
        res.redirect('/');
    });

	// =====================================
	// SIGNUP ==============================
	// =====================================
	// show the signup form
	app.get('/signup', function(req, res) {
		// render the page and pass in any flash data if it exists
		res.render('signup.ejs', { message: req.flash('signupMessage') });
	});

	// process the signup form
	app.post('/signup', passport.authenticate('local-signup', {
		successRedirect : '/profile', // redirect to the secure profile section
		failureRedirect : '/signup', // redirect back to the signup page if there is an error
		failureFlash : true // allow flash messages
	}));

	// =====================================
	// PROFILE SECTION =========================
	// =====================================
	// we will want this protected so you have to be logged in to visit
	// we will use route middleware to verify this (the isLoggedIn function)
	app.get('/profile', isLoggedIn, function(req, res) {
		res.render('profile.ejs', {
			user : req.user // get the user out of session and pass to template
		});
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
		console.log(query);
        connection.query(query, function (err, results, fields) {   
            if(!err){
				res.redirect("/");
			} else {
				console.log('Error while performing Query');
			}
        });
    });
    //show the detail of a Car
    app.get("/Car/:id", function (req, res) {
		connection.query("SELECT * from Car natural join Inventory natural join Dealer natural join user WHERE car_id="+ req.params.id, function (err, rows, fields){
			if(!err){
				res.render("show",{Car:rows[0]});
			} else {
				console.log('Error while performing Query');
			}
		});
    });
	app.get("/Car/:id/update", function (req, res) {
		connection.query("SELECT * from Car WHERE car_id="+ req.params.id, function (err, rows, fields){
			if(!err){
				res.render("edit",{Car:rows[0]});
			} else {
				console.log('Error while performing Query');
			}
		});
    });

	app.put("/Car/:id", function(req, res){
		var query = "update Car set price =" +req.body.Price+ ", mileage = " + req.body.Mileage + " where car_id ="+ req.params.id;
		console.log(query);
		connection.query(query, function (err, rows, fields){
			if(!err){
				res.redirect("/Car/"+req.params.id);
			} else {
				console.log('Error while performing Query');
			}
		});
	});

	app.get("/Car/:id/delete", function (req, res) {
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
		console.log(query);
		connection.query(query, function (err, rows, fields){
			if(!err){
				res.render("results",{Cars:rows});
			} else {
				console.log('Error while performing Query');
			}
		});
	});
	//Dealer
	app.get("/User/:id", function(req, res){
		var query = "SELECT * from Dealer natural join User natural join review WHERE username='"+req.params.id +"'";
		console.log(query);
		connection.query(query, function(err, rows, fields){
			if(!err){
				console.log(rows[0]);
				res.render("user",{user:rows[0]});
			} else {
				console.log('Error while performing Query');
			}
		})
	});
	// =====================================
	// LOGOUT ==============================
	// =====================================
	app.get('/logout', function(req, res) {
		req.logout();
		res.redirect('/');
	});
};

// route middleware to make sure
function isLoggedIn(req, res, next) {

	// if user is authenticated in the session, carry on
	if (req.isAuthenticated())
		return next();

	// if they aren't redirect them to the home page
	res.redirect('/');
}
