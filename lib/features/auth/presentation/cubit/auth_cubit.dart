import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  register() async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      await user?.updateDisplayName(nameController.text);
      log("Success");
      FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        "name": nameController.text,
        "email": emailController.text,
        "uid": credential.user?.uid,
      });
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState('كلمة المرور ضعيفة جدا.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState('الايميل مستخدم بالفعل من قبل.'));
      } else {
        emit(AuthFailureState(e.message ?? 'حدث خطأ ما، حاول مرة أخرى.'));
      }
    } catch (e) {
      emit(AuthFailureState('حدث خطأ ما، حاول مرة أخرى.'));
    }
  }

  login() async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      log("Success");
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState('لا يوجد مستخدم بهذا الايميل.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState('كلمة المرور غير صحيحة.'));
      } else {
        emit(AuthFailureState(e.message ?? 'حدث خطأ ما، حاول مرة أخرى.'));
      }
    }
  }
}
