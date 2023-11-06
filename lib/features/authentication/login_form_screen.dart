import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSubmitTap() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size28,
          horizontal: Sizes.size32,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                validator: (value) => "I don't like your email",
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                validator: (value) => "Wrong Password",
              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false)),
            ],
          ),
        ),
      ),
    );
  }
}
