import 'package:flutter/material.dart';
import 'package:myapp/models/contact.dart';
import 'package:myapp/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ManageContactScreen extends StatelessWidget {
  const ManageContactScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    final existingContact =
        ModalRoute.of(context)?.settings.arguments as Contact?;
    final isEdit = existingContact != null;

    if (isEdit) {
      nameController.text = existingContact.name;
      emailController.text = existingContact.email;
      phoneController.text = existingContact.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Contact' : 'Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;
                final phone = phoneController.text;

                final newContact = Contact(
                  id: isEdit
                      ? existingContact.id
                      : DateTime.now().millisecondsSinceEpoch,
                  name: name,
                  email: email,
                  phone: phone,
                );
                if (isEdit) {
                  context.read<ContactProvider>().editContact(newContact);
                } else {
                  context.read<ContactProvider>().addContact(newContact);
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
