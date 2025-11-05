class DoctorModel {
  String? name;
  String? email;
  String? image;
  String? phone1;
  String? bio;
  String? uid;
  String? specialization;
  int? rating;
  String? phone2;
  String? openHour;
  String? closeHour;
  String? address;

  DoctorModel({
    this.name,
    this.email,
    this.image,
    this.phone1,
    this.bio,
    this.uid,
    this.specialization,
    this.rating,
    this.phone2,
    this.openHour,
    this.closeHour,
    this.address,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    name: json['name'],
    email: json['email'],
    image: json['image'],
    phone1: json['phone1'],
    bio: json['bio'],
    uid: json['uid'],
    specialization: json['specialization'],
    rating: json['rating'],
    phone2: json['phone2'],
    openHour: json['openHour'],
    closeHour: json['closeHour'],
    address: json['address'],
  );

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name; 
    data['image'] = image;
    data['email'] = email;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['bio'] = bio;
    data['specialization'] = specialization;
    data['rating'] = rating;
    data['openHour'] = openHour;
    data['closeHour'] = closeHour;
    data['address'] = address;
    return data;
  }
  Map<String, dynamic> updateData() => {
    if (name != null) 'name': name,
    if (email != null) 'email': email,
    if (image != null) 'image': image,
    if (phone1 != null) 'phone1': phone1,
    if (bio != null) 'bio': bio,
    if (uid != null) 'uid': uid,
    if (specialization != null) 'specialization': specialization,
    if (rating != null) 'rating': rating,
    if (phone2 != null) 'phone2': phone2,
    if (openHour != null) 'openHour': openHour,
    if (closeHour != null) 'closeHour': closeHour,
    if (address != null) 'address': address,
  };
}
