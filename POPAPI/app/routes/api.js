var express = require('express');

var router = express.Router();

router.route('/')

    .get(function(req, res) {
        res.json({ message: "It's alive!" });
    });
    
module.exports = router;