import 'package:flutter/material.dart';
import 'sql_helper.dart'; 
import 'package:sqlflite_crud/theme/theme.dart';

class EditContactPage extends StatefulWidget {
  final String id;
  final String name;
  final String surname;
  final String job;
  final String phone;
  final String email;
  final String website;
  final bool isFavorite;

  const EditContactPage({
    required this.id,
    required this.name,
    required this.surname,
    required this.job,
    required this.phone,
    required this.email,
    required this.website,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController jobController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  late bool isFavorite;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    surnameController = TextEditingController(text: widget.surname);
    jobController = TextEditingController(text: widget.job);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    websiteController = TextEditingController(text: widget.website);
    isFavorite = widget.isFavorite;
    super.initState();
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

  void editContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await SQLHelper.update(
          'contacts',
          {
            'id': int.parse(widget.id),
            'name': nameController.text.trim(),
            'surname': surnameController.text.trim(),
            'job': jobController.text.trim(),
            'phone': phoneController.text.trim(),
            'email': emailController.text.trim(),
            'website': websiteController.text.trim(),
            'isFavorite': isFavorite ? 1 : 0,
          },
        );

        Navigator.pop(context); // Return to the previous screen after editing
      } catch (e) {
        // Handle exceptions or errors if any
        print("Failed to edit contact: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to edit contact")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
    }
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
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
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text("Favorite"),
                  value: isFavorite,
                  onChanged: (newValue) {
                    setState(() {
                      isFavorite = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: editContact,
                    child: const Text("Edit Contact"),
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
