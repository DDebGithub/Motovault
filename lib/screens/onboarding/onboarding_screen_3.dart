import 'package:flutter/material.dart';
import 'package:motovault/screens/onboarding/onboarding_screen_4.dart';
import 'package:motovault/screens/sign_in_screen.dart';

import '../../widgets/animated_fade_slide.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ub3.jpg'),
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
                      child: const Text("3 / 4"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AnimatedFadeSlide(
                  delay: 200,
                  child: Text(
                    "Never Miss a Deadline",
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
                    "Set reminders for insurance, PUC, services, and more.",
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
                        MaterialPageRoute(builder: (_) => const OnboardingScreen4()),
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