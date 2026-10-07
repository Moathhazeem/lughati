const express = require('express');

const { register , login , googleLogin,facebookLogin } = require('../controllers/authController');
const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/google', googleLogin);
router.post('/facebook', facebookLogin);

module.exports = router;