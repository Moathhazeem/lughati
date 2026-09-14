import 'package:flutter/material.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;
  
  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  
  final List<OnboardingItem> _items = [
    OnboardingItem(
      image: 'assets/photo/intro.jpg',
      title: 'Speak with confidence from day one!',
      description: 'Go beyond memorizing words. Develop your conversational skills with quick, interactive lessons that fit into your day.',
    ),
    OnboardingItem(
      image: 'assets/photo/Introduction page Two.jpg',
      title: 'Smart lessons to suit your lifestyle',
      description: '5 minutes a day is all it takes. Get personalized, AI-driven lessons tailored to your pace and goals.',
    ),
    OnboardingItem(
      image: 'assets/photo/intro.jpg',
      title: 'Track your progress seamlessly',
      description: 'Stay motivated with daily streaks and clear insights into your language mastery journey.',
    ),
  ];
  
  void _onNextPressed() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate when screens are finished
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lughati',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Column(
                      children: [
                        const Spacer(),
                        Center(
                          child: Image.asset(
                            item.image,
                            height: 280,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8,
                    width: _currentIndex == index ? 32 : 20,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? const Color(0xFF3B82F6) : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE0F2FE),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Color(0xFF2563EB),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
