import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers لجمع البيانات من المدخلات
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  
  // Password requirement states
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasStartedTyping = false;
  late FocusNode _passwordFocusNode;
  
  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
      return;
    }
    final url = Uri.parse('https://lughati.com/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'password_confirmation': _confirmPasswordController.text.trim()
        })
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201 && data['success'] == true) {
        String token = data['token'];
        debugPrint('User registered successfully! Token: $token');
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Failed to register user')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. اللوجو العلوي
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6A1B9A), // لون أرجواني متناسب مع التصميم
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. العنوان والوصف
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start your language journey today.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // 3. حقل Full Name
                _buildFieldLabel('Full name'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  decoration: _buildInputDecoration(
                    hintText: 'Moath hazeem',
                    prefixIcon: Icons.person_outline,
                  ),
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'Please enter your full name';
                    }
                    if(!RegExp(r'[a-zA-Z\s]+$').hasMatch(value.trim())){
                      return 'Name can only contain letters and spaces';
                    }
                    if (value.trim().split(' ').length < 2){
                      return 'Please enter at least a first and last name';
                    }
                    if(value.trim().length < 3){
                      return 'Name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 4. حقل Email Address
                _buildFieldLabel('Email Address'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(
                    hintText: 'Moathhazeem661@gmail.com',
                    prefixIcon: Icons.email_outlined,
                  ),
                  validator:(value){
                    if(value == null || value.trim().isEmpty){
                      return 'Please enter your email';
                    }
                    if(!value.toLowerCase().contains('@gmail.com')){
                      return 'Email must contain @gmail.com';
                    }
                    if(value.trim().length < 3){
                      return 'Email must be at least 3 characters long';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 16),

                // 5. حقل Password
                _buildFieldLabel('Password'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: _isPasswordObscured,
                  decoration: _buildInputDecoration(
                    hintText: '****************',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      hasStartedTyping = value.isNotEmpty;
                      hasMinLength = value.length >= 8;
                      hasUppercase = value.contains(RegExp(r'[A-Z]'));
                      hasLowercase = value.contains(RegExp(r'[a-z]'));
                      hasNumber = value.contains(RegExp(r'[0-9]'));
                      hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 8 ||
                        !value.contains(RegExp(r'[A-Z]')) ||
                        !value.contains(RegExp(r'[a-z]')) ||
                        !value.contains(RegExp(r'[0-9]')) ||
                        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Please meet all password requirements';
                    }
                    return null;
                  },
                ),
                if(_passwordController.text.isNotEmpty || _passwordFocusNode.hasFocus) ...[
                  const SizedBox(height:8),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PasswordRequirement(
                      text: 'At least 8 characters',
                      isValid: hasMinLength,
                      hasStartedTyping: _passwordController.text.isNotEmpty,
                    ),
                    PasswordRequirement(
                      text: 'One uppercase letter',
                      isValid: hasUppercase,
                      hasStartedTyping: _passwordController.text.isNotEmpty,
                    ),
                    PasswordRequirement(
                      text: 'One lowercase letter',
                      isValid: hasLowercase,
                      hasStartedTyping: _passwordController.text.isNotEmpty,
                    ),
                    PasswordRequirement(
                      text: 'One number',
                      isValid: hasNumber,
                      hasStartedTyping: _passwordController.text.isNotEmpty,
                    ),
                    PasswordRequirement(
                      text: 'One special character',
                      isValid: hasSpecialChar,
                      hasStartedTyping: _passwordController.text.isNotEmpty,
                    ),
                  ],
                ),
              ],
                const SizedBox(height: 16),

                // 6. حقل Confirm Password
                _buildFieldLabel('Confirm Password'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isConfirmPasswordObscured,
                  decoration: _buildInputDecoration(
                    hintText: '059##\$\$%^^#@ssdswwe21',
                    prefixIcon: Icons.key_outlined,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                        });
                      },
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please confirm your password';
                    }
                    if(value != _passwordController.text){
                      return 'Password do not match';
                    }
                    return null; 
                  }
                ),
                const SizedBox(height: 16),

                // 7. شروط الاستخدام والخصوصية
                Wrap(
                  children: [
                    const Text(
                      'By creating an account you agree to our ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(fontSize: 12, color: Color(0xFF0066FF), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      ' and ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Privacy Policy.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF0066FF), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 8. زر Sign Up
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 9. فاصل "or continue with"
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('or continue with', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                  ],
                ),
                const SizedBox(height: 24),

                // 10. أزرار التسجيل عبر Google و Facebook
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Google',
                        icon: Icons.g_mobiledata, // يمكنك استبدالها بـ Image.asset للوجو Google
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSocialButton(
                        label: 'Facebook',
                        icon: Icons.facebook,
                        color: const Color(0xFF4267B2),
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 11. رابط Log In
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Log In.',
                          style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ودجت مخصصة لعناوين الحقول
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // تنسيق حقول المدخلات (TextFields)
  InputDecoration _buildInputDecoration({required String hintText, required IconData prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: Colors.grey, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE9ECEF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
      ),
    );
  }

  // ودجت مخصصة لأزرار التواصل الاجتماعي
  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    Color? color,
    Color textColor = Colors.black,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: color ?? Colors.white,
        side: BorderSide(color: color != null ? Colors.transparent : const Color(0xFFE9ECEF)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, color: textColor),
      label: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget لعرض متطلبات كلمة المرور
class PasswordRequirement extends StatelessWidget {
  final String text;
  final bool isValid;
  final bool hasStartedTyping;

  const PasswordRequirement({
    super.key,
    required this.text,
    required this.isValid,
    required this.hasStartedTyping,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;
    if(!hasStartedTyping){
      icon = Icons.radio_button_unchecked;
      iconColor = Colors.grey;
    } else if(isValid){
      icon = Icons.check_circle;
      iconColor = Colors.green;
    } else {
      icon = Icons.cancel;
      iconColor = Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: !hasStartedTyping ? Colors.grey : (isValid ? Colors.green : Colors.red),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}