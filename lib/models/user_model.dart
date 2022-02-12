class UserModel {
  String? name;
  String? email;
  String? phone;
  String? id;
  double? balance;

  UserModel({
    required String name,
    required String email,
    required String phone,
    required String id,
    required double balance,
})
  {
    this.name=name;
    this.email=email;
    this.phone=phone;
    this.id=id;
    this.balance=balance;
  }

  UserModel.fromDatabase(Map<String,dynamic>data){
    id = data['id'];
    name = data['name'];
    email=data['email'];
    phone = data['phone'];
    balance = data['balance'];
  }

}