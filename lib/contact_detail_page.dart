import 'package:flutter/material.dart';
import 'package:sqlflite_crud/sql_helper.dart';
import 'edit_contact_page.dart'; // Import your EditContactPage

class ContactDetailPage extends StatelessWidget {
  final Map<String, dynamic> contact;

  const ContactDetailPage({Key? key, required this.contact}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey, // Default color for the avatar
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['name'],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['surname'],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Surname',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['job'],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Job',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['phone'],
              readOnly: true,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['email'],
              readOnly: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: contact['website'],
              readOnly: true,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Website',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Is Favorite: ${contact['isFavorite'] == 1 ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
            const Divider(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactPage(
                    id: contact['id'].toString(),
                    name: contact['name'],
                    surname: contact['surname'],
                    job: contact['job'],
                    phone: contact['phone'],
                    email: contact['email'],
                    website: contact['website'],
                    isFavorite: contact['isFavorite'] == 1,
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await SQLHelper.delete('contacts', contact['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact deleted")),
              );
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
