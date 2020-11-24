class CustomUser{

  final String uid;


  CustomUser({this.uid});

 // CustomUser(this.uid,this.name,this.country);

}

class CustomUserFields{
  String name;
  String country;

  CustomUserFields(this.name,this.country);

  Map<String, dynamic> toJson() => {
    'country': country,
    'name': name,
  };

}