import 'package:flutter/material.dart';
import 'sql_helper.dart'; 

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final jobController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();

  void addContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        final contactData = {
          'name': nameController.text.trim(),
          'surname': surnameController.text.trim(),
          'job': jobController.text.trim(),
          'phone': phoneController.text.trim(),
          'email': emailController.text.trim(),
          'website': websiteController.text.trim(),
          'isFavorite': 0, // Add this line
        };

        await SQLHelper.insert('contacts', contactData);

        Navigator.pop(context); 
      } catch (e) {
        print("Failed to add contact: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add contact")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    jobController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: surnameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Surname",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: jobController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Job",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Phone",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.url,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: websiteController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Website",
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addContact,
                    child: const Text("Add Contact"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
