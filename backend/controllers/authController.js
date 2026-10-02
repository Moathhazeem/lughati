const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

exports.register = async (req, res) => {
    try{
        const { fullName, email, password } = req.body;

        if(!fullName || !email || !password){
            return res.status(400).json({
                success:false,
                message:'Please provide all required fields'
            });
        }
        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({
                success:false,
                message: 'Email address is already registered'
            });
        }
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const newUser = await User.create({
            fullName,
            email: email.toLowerCase(),
            password: hashedPassword,
        });

        const token = jwt.sign(
            {userId: newUser._id}, 
            process.env.JWT_SECRET || 'your-secret-key', 
            {expiresIn: '7d'});
            res.status(201).json({
                success: true,
                message:'Account created successfully',
                token,
                user:{
                    id: newUser._id,
                    fullName: newUser.fullName,
                    email:newUser.email,
                },
            });
    }
    catch(error){
        console.error('Registration Error:', error);
        res.status(500).json({
            success: false,
            message: 'Server error, please try again later'
        });
    }
};