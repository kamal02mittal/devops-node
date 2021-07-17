var app = require('express')();
var router = require('./lib/routers/calcRouter');
app.use("/calculator", router);
app.listen(1700);
exports.app = app;

