import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sa7ety/components/cards/doctor_card.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/features/auth/models/doctor_model.dart';
import 'package:sa7ety/services/firebase/firestore_services.dart';

class HomeSearchSearchScreen extends StatelessWidget {
  const HomeSearchSearchScreen({super.key, required this.searchKey});
  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        title: Text("ابحث عن دكتور"),
      ),
      body: FutureBuilder(
        future: FirestoreServices.getDoctorsByName(searchKey),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data?.docs.isEmpty == true
              ? EmptyWidget()
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      return DoctorCard(doctor: doctor);
                    },
                  ),
                );
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/no-search.svg', width: 250),
            Text(
              'لا يوجد دكتور بهذا الاسم حاليا',
              style: TextStyles.textSize18,
            ),
          ],
        ),
      ),
    );
  }
}
