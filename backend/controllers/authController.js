const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const { OAuth2Client } = require('google-auth-library');
const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

exports.login = async (req, res) => {
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
exports.googleLogin = async(req,res) =>{
try{
    const { idToken } = req.body;

    if(!idToken){
        return res.status(400).json({
            success: false,
            message: 'Google ID token is required'
        });
    }
    const ticket = await googleClient.verifyIdToken({
        idToken: idToken,
        audience: process.env.GOOGLE_CLIENT_ID,
    });
    const payload = ticket.getPayload();
    const { sub: googleId, email,name :fullName , picture} = payload;
    let user = await User.findOne({email});
    if(!user){
        user = await User.create({
            fullName,
            email:email.toLowerCase(),
            googleId,
            profilePicture: picture
        });
    }
    const token = jwt.sign(
        {userId:user._id},
        process.env.JWT_SECRET || 'your-secret-key',
        {expiresIn: '7d'}
    );
    res.json({
        success:true,
        message: 'Google login successful',
        token,
        user:{
            id: user._id,
            fullName: user.fullName,
            email: user.email,
            profilePicture: user.profilePicture
        }
    });
} catch(error){
    console.error('Google Login Error:', error);
    res.status(401).json({
        success: false,
        message: 'Google login failed'
    });
}
}
exports.facebookLogin = async(req,res) =>{

}