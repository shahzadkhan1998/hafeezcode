import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userscreen/state/authstate.dart';
import 'package:userscreen/state/updatestate.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState?>((ref) {
  return AuthNotifier();
});
final profileUpdaterProvider = StateNotifierProvider<ProfileUpdater, ProfileUpdaterState>((ref) {
  return ProfileUpdater();
});