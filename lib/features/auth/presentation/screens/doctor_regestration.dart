import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sa7ety/components/buttons/custom_buttom.dart';
import 'package:sa7ety/components/inputs/custom_text_field.dart';
import 'package:sa7ety/core/constants/app_images.dart';
import 'package:sa7ety/core/constants/specializations.dart';
import 'package:sa7ety/core/functions/showloadingdialog.dart';
import 'package:sa7ety/core/functions/snackbar.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_state.dart';

class DoctorRegestration extends StatefulWidget {
  const DoctorRegestration({super.key});

  @override
  State<DoctorRegestration> createState() => _DoctorRegestrationState();
}

class _DoctorRegestrationState extends State<DoctorRegestration> {
  File? imagePath;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthLoadingState) {
          showloadingDialog(context);
        } else if (state is AuthSuccessState) {
          pop(context);
          pushReplacment(context, Routes.doctor_main);
        } else if (state is AuthFailureState) {
          pop(context);
          showSnakBar(context, Colors.red, state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "استكمال التسجيل",
            style: TextStyles.textSize18.copyWith(color: AppColors.whiteColor),
          ),
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      customButtom(
                                        txt: "الكاميرا",
                                        onPressed: () {
                                          uploadImages(isCamera: true);
                                        },
                                        txtColor: AppColors.whiteColor,
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                      Gap(10),
                                      customButtom(
                                        txt: "المعرض",
                                        onPressed: () {
                                          uploadImages(isCamera: false);
                                        },
                                        txtColor: AppColors.whiteColor,
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage: (imagePath != null)
                                ? FileImage(imagePath!)
                                : const AssetImage(AppImages.docg),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "التخصص",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButton<String?>(
                      icon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: AppColors.primaryColor,
                      ),
                      iconEnabledColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: Text("اختر التخصص"),
                      value: cubit.specialization,
                      items: [
                        for (var specializat in specializations)
                          DropdownMenuItem(
                            value: specializat,
                            child: Text(specializat),
                          ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          cubit.specialization = newValue;
                        });
                      },
                    ),
                  ),
                  Gap(10),
                  Text(
                    "نبذة عني",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  customTextformfield(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    hintText:
                        "سجل المعلومات الطبيه العامه مثل تعليمك الاكاديمي و خبراتك السابقة",
                    maxlines: 5,
                    controller: cubit.bioController,
                  ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  Text(
                    "العنوان",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  customTextformfield(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.start,
                    hintText: "ادخل العنوان",
                    controller: cubit.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "برجاء ادخال العنوان";
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ساعات العمل من",
                              style: TextStyles.textSize18.copyWith(
                                color: AppColors.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            customTextformfield(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "برجاء ادخال ساعة بدء العمل ";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hintText: '10:00 صباحاً',
                              readonly: true,
                              Sicon: Icon(
                                Icons.access_time,
                                color: AppColors.primaryColor,
                              ),
                              ontap: () async {
                                // Pick a full time first
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    // Force 24-hour format in the dialog
                                    return MediaQuery(
                                      data: MediaQuery.of(
                                        context,
                                      ).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );

                                if (selectedTime != null) {
                                  // Extract ONLY the hour (0–23)
                                  int hour24 = selectedTime.hour;

                                  // Format it as HH:00  (24-hour system)
                                  cubit.openHourController.text =
                                      '${hour24.toString().padLeft(2, '0')}:00';
                                }
                              },
                              controller: cubit.openHourController,
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "إلى",
                              style: TextStyles.textSize18.copyWith(
                                color: AppColors.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            customTextformfield(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "برجاء ادخال ساعة انتهاء العمل ";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hintText: '10:00 مساءً',
                              readonly: true,
                              Sicon: Icon(
                                Icons.access_time,
                                color: AppColors.primaryColor,
                              ),
                              ontap: () async {
                                // Pick a full time first
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    // Force 24-hour format in the dialog
                                    return MediaQuery(
                                      data: MediaQuery.of(
                                        context,
                                      ).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );

                                if (selectedTime != null) {
                                  // Extract ONLY the hour (0–23)
                                  int hour24 = selectedTime.hour;

                                  // Format it as HH:00  (24-hour system)
                                  cubit.closeHourController.text =
                                      '${hour24.toString().padLeft(2, '0')}:00';
                                }
                              },
                              controller: cubit.closeHourController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Text(
                    "رقم الهاتف الأول",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  customTextformfield(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hintText: '+20xxxxxxxxxxx',
                    controller: cubit.phone1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "برجاء ادخال رقم الهاتف";
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Text(
                    "رقم الهاتف الثاني",
                    style: TextStyles.textSize18.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  customTextformfield(
                    controller: cubit.phone2Controller,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hintText: '+20xxxxxxxxxxx',
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: customButtom(
            txt: "تسجيل",
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                if (imagePath != null) {
                  cubit.updateDoctorData(imagePath);
                } else {
                  showSnakBar(
                    context,
                    Colors.red,
                    'برجاء اختيار صورة الملف الشخصي.',
                  );
                }
              }
            },
            color: AppColors.primaryColor,
            txtColor: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  Future<void> uploadImages({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        pop(context);
        imagePath = File(file.path);
      });
    }
  }
}
