import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/user/view_models/users_view_model.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(usersProvider.notifier).onProfileChange(
              formData["bio"]!,
              formData["link"]!,
            );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(usersProvider).value;
    return Scaffold(
      body: Column(
        children: [
          Gaps.v20,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bio"),
                  TextFormField(
                    initialValue: userProfile!.bio,
                    decoration: InputDecoration(
                      hintText: userProfile.bio,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['bio'] = newValue;
                      }
                    },
                  ),
                  Gaps.v20,
                  const Text("Link"),
                  TextFormField(
                    initialValue: userProfile.link,
                    decoration: InputDecoration(
                      hintText: userProfile.link,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['link'] = newValue;
                      }
                    },
                  ),
                  Gaps.v20,
                  GestureDetector(
                      onTap: _onSubmitTap,
                      child: const FormButton(disabled: false, text: "Submit"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
