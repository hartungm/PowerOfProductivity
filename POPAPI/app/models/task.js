var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var TaskSchema = new Schema({
	taskName: String,
	description: String,
	priority: {type: Number, min: 1, max: 10},
	complexity: {type: Number, min: 1, max: 10}
});

module.exports = mongoose.model('Task', TaskSchema);