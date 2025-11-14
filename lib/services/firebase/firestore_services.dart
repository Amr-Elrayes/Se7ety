import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static final CollectionReference _doctorsCollection = FirebaseFirestore
      .instance
      .collection('doctor');

  static final CollectionReference _patientsCollection = FirebaseFirestore
      .instance
      .collection('patient');

  static Future<QuerySnapshot> sortDoctorsByRating() {
    return _doctorsCollection
        .orderBy('rating', descending: true)
        .where("specialization", isNull: false)
        .get();
  }

  static Future<QuerySnapshot> filterDoctorsBySpecilization(
    String specialization,
  ) {
    return _doctorsCollection
        .where("specialization", isEqualTo: specialization, isNull: false)
        .get();
  }

  static Future<QuerySnapshot> getDoctorsByName(String searchKey) {
    return _doctorsCollection
        .orderBy("name")
        .where('specialization', isNull: false)
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get();
  }
}
