import 'package:flutter/material.dart';
import 'package:motovault/screens/onboarding/onboarding_screen_3.dart';
import 'package:motovault/screens/sign_in_screen.dart';
import '../../widgets/animated_fade_slide.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ub2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        );
                      },
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        child: const Text("Skip"),
                      ),
                    ),
                    const Spacer(),
                    DefaultTextStyle.merge(
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      child: const Text("2 / 4"),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                AnimatedFadeSlide(
                  delay: 200,
                  child: Text(
                    "Track Every Ride",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedFadeSlide(
                  delay: 400,
                  child: Text(
                    "Automatically log your kilometers, fuel, and maintenance data.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OnboardingScreen3()),
                      );// This will be handled from parent
                    },
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}