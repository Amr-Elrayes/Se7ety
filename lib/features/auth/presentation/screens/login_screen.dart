import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/components/buttons/custom_buttom.dart';
import 'package:sa7ety/components/inputs/custom_text_field.dart';
import 'package:sa7ety/components/inputs/password_text_field.dart';
import 'package:sa7ety/core/constants/app_images.dart';
import 'package:sa7ety/core/functions/app_regex.dart';
import 'package:sa7ety/core/functions/showdialog.dart';
import 'package:sa7ety/core/functions/snackbar.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/features/auth/models/user_type_enum.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_state.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.userType});
  final usertype userType;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 60),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
                        if (state is AuthLoadingState) {
              showloadingDialog(context);
            } else if (state is AuthSuccessState) {
              pop(context);
              if(state.role == "doctor") 
              {
                pushAndRemoveUntil(context, Routes.doctor_main);
              }
              else
              {
                pushAndRemoveUntil(context, Routes.patent_main);
              }
            } else if (state is AuthFailureState) {
              Navigator.pop(context);
              showSnakBar(context, Colors.red, state.errorMessage);
            }
          },
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppImages.logo, width: 250, height: 250),
                  Gap(20),
                  Text(
                    userType == usertype.patient
                        ? "سجل دخول الان ك \"مريض\""
                        : "سجل دخول الان ك \"دكتور\"",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),
                  customTextformfield(
                    controller: cubit.emailController,
                    hintText: "amr@gmail.com",
                    maxlines: 1,
                    Picon: Icon(Icons.email, color: AppColors.primaryColor),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!AppRegex().isValidEmail(p0)) {
                        return 'من فضلك ادخل الايميل بشكل صحيح';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  PasswordTextField(
                    controller: cubit.passwordController,
                    hintText: "********",
                    maxlines: 1,
                    Picon: Icon(Icons.lock, color: AppColors.primaryColor),
                    textAlign: TextAlign.end,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'من فضلك ادخل كلمة السر';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      " نسيت كلمة السر؟",
                      style: TextStyles.textSize15.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ),
                  Gap(20),
                  customButtom(
                    txt: "تسجيل الدخول",
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.login(type: userType);
                      }
                    },
                  ),
                  Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لديك حساب؟ ",
                        style: TextStyles.textSize15.copyWith(
                          color: AppColors.darkColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pushReplacment(
                            context,
                            Routes.register,
                            extra: userType,
                          );
                        },
                        child: Text(
                          "انشاء حساب",
                          style: TextStyles.textSize15.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
