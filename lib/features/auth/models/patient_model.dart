class PatientModel {
  final String? uid;
  final String? name;
  final String? age;
  final String? image;
  final String? email;
  final String? phone;
  final int? gender;
  final String? bio;
  final String? city;

  const PatientModel({
    this.uid,
    this.name,
    this.age,
    this.image,
    this.email,
    this.phone,
    this.gender,
    this.bio,
    this.city,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {

    return PatientModel(
      uid: json['uid'],
      name: json['name'],
      age: json['age'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      bio: json['bio'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String , dynamic>{};
    data['uid'] = uid;
    data['name'] = name; 
    data['age'] = age;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['bio'] = bio;
    data['city'] = city;
    return data;
      }
}