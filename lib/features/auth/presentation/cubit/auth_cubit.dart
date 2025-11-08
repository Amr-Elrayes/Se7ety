import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/core/functions/upload_image.dart';
import 'package:sa7ety/features/auth/models/doctor_model.dart';
import 'package:sa7ety/features/auth/models/patient_model.dart';
import 'package:sa7ety/features/auth/models/user_type_enum.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var bioController = TextEditingController();
  var phone1Controller = TextEditingController();
  var phone2Controller = TextEditingController();
  var addressController = TextEditingController();
  var openHourController = TextEditingController();
  var closeHourController = TextEditingController();
  String? specialization;

  register({required usertype type}) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      await user?.updateDisplayName(nameController.text);
      user?.updatePhotoURL(type == usertype.doctor ? "doctor" : "patient");
      if (type == usertype.doctor) {
        var doctor = DoctorModel(
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection("doctor")
            .doc(user?.uid)
            .set(doctor.toJson());
      } else {
        var patient = PatientModel(
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection("patient")
            .doc(user?.uid)
            .set(patient.toJson());
      }
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

  login({required usertype type}) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(AuthSuccessState(role: credential.user?.photoURL));
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

  updateDoctorData(File? pickedImage) async {
    emit(AuthLoadingState());
    try {
      String? imageUrl = await updateImageToCloudinary(pickedImage!);
      if (imageUrl == null) {
        emit(AuthFailureState('فشل في رفع الصورة. حاول مرة أخرى.'));
        return;
      }
      User? user = FirebaseAuth.instance.currentUser;
      var doctor = DoctorModel(
        uid: user?.uid,
        bio: bioController.text,
        phone1: phone1Controller.text,
        phone2: phone2Controller.text,
        address: addressController.text,
        specialization: specialization,
        openHour: openHourController.text,
        closeHour: closeHourController.text,
        image: imageUrl,
        rating: 3,
      );
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(user?.uid)
          .update(doctor.updateData());
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthFailureState('حدث خطأ ما، حاول مرة أخرى.'));
    }
  }
}
