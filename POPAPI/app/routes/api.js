var express = require('express');
var Task = require('../models/task');

var router = express.Router();

router.route('/')

    .get(function(req, res) {
        res.json({ message: "It's alive!" });
    });

router.route('/tasks')

	.get(function(req, res) {
		Task.find(function(err, tasks) {
			if(err) {
				res.send(err);
			}
			res.json(tasks);
		});
	})

	.post(function(req, res) {
		var task = new Task({ 
			taskName: req.body.taskName,
			description: req.body.description,
			complexity: req.body.complexity,
			priority: req.body.priority
		});

		task.save(function(err) {
			if(err) {
				res.send(err);
			}
			res.json({ message: 'Task Saved! ID:' + task.id  });
		});
	});
    
module.exports = router;