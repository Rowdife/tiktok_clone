import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size28,
          horizontal: Sizes.size32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v12,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            FractionallySizedBox(
              widthFactor: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.size5),
                  color: _username.isEmpty
                      ? Colors.grey.shade100
                      : Theme.of(context).primaryColor,
                ),
                child: Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        _username.isEmpty ? Colors.grey.shade400 : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
