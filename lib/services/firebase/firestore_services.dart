import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa7ety/features/patient/booking/data/appoitment_model.dart';

class FirestoreServices {
  static final CollectionReference _doctorsCollection = FirebaseFirestore
      .instance
      .collection('doctor');
  static final CollectionReference _appointmentCollection = FirebaseFirestore
      .instance
      .collection('appointment');

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

  static Future<void> createAppointment(AppointmentModel appointment) {
    return _appointmentCollection.doc(appointment.id).set(appointment.toJson());
  }

  static Future<QuerySnapshot> getAppointmentsByPatientId() {
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    return _appointmentCollection
        .where('patientID', isEqualTo: patientId)
        .get();
  }

  static Future<QuerySnapshot> getAppointmentsByDoctorId() {
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    return _appointmentCollection.where('doctorID', isEqualTo: patientId).get();
  }

  static Future<void> deleteAppointment(String appointmentId) {
    return _appointmentCollection.doc(appointmentId).delete();
  }
}
