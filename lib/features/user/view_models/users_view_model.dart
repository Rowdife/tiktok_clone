import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:tiktok_clone/features/user/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _authenticationRepository = ref.read(authRepo);
    _usersRepository = ref.read(userRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anon.com",
      uid: credential.user!.uid,
      name: form["name"] ?? "Anonymous",
      birthday: form["birthday"],
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> onProfileChange(String bio, String link) async {
    state = AsyncValue.data(state.value!.copyWith(bio: bio, link: link));
    await _usersRepository.updateUser(state.value!.uid, {
      "bio": bio,
      "link": link,
    });
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);