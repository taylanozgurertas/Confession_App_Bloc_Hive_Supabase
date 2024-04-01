import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itiraf/core/common/widgets/loader.dart';
import 'package:itiraf/core/themes/app_pallete.dart';
import 'package:itiraf/core/utils/show_snackbar.dart';
import 'package:itiraf/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:itiraf/features/auth/presentation/pages/signup_page.dart';
import 'package:itiraf/features/auth/presentation/widgets/auth_field.dart';
import 'package:itiraf/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:itiraf/features/blog/presentation/pages/blog_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, state.messsage);
            } else if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.25),
                children: [
                  const Center(
                    child: Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  smallSpace(),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  smallSpace(),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  smallSpace(),
                  AuthGradientButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                            AuthLogin(email: emailController.text.trim(), password: passwordController.text.trim()));
                      }
                    },
                  ),
                  smallSpace(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          SignUpPage.route(),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox smallSpace() {
    return const SizedBox(
      height: 10,
    );
  }
}
