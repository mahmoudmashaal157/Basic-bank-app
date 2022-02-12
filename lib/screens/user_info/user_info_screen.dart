import 'package:basic_bank_app/screens/all_users/all_users_screen.dart';
import 'package:basic_bank_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  late String name;
  late String phone;
  late String id;
  late String email;
  double? balance;
  UserInfoScreen({
    required String name,
    required String email,
    required String phone,
    required String id,
    double? balance,
  }) {
    this.id = id;
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.balance = balance;
  }

  TextEditingController amountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(title: "User Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfoDesign(context),
          ],
        ),
      ),
    );
  }

  Widget userInfoDesign(BuildContext context) {
    return Column(
      children: [
        Text(
          "Name: $name",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Email: $email",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Phone: $phone",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Id: $id",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Balance: $balance\$",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: ElevatedButton(
            child: const Text("Send Money"),
            onPressed: () {
              showDialogg(context);
            },
          ),
        ),
      ],
    );
  }

  void showDialogg(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: 150,
            height: 100,
            child: alertDialog(context),
          );
        });
  }

  Widget alertDialog(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text("Transfer Money"),
      actions: [
        Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount of Money",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The amount of money";
                    }
                    if (double.parse(value) > balance!) {
                      return "You can't transfer all this amount of money";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            navigateTo(
                                AllUsersScreen(
                                  isTransfer: true,
                                  senderId: id,
                                  amountTransfered:
                                      double.parse(amountController.text),
                                  senderBalance: balance,
                                  senderName: name,
                                ),
                                context);
                          }
                        },
                        child: const Text("Transfer")),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cnacel")),
                  ],
                ),
              ],
            ),
            key: formKey,
          ),
        )
      ],
    );
  }
}
