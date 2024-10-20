import 'package:flutter/material.dart';
import 'package:myapp/providers/contact_provider.dart';
import 'package:myapp/screens/manage_contact_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => context.read<ContactProvider>().clearContacts(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageContactScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, _) {
          if (value.contacts.isEmpty) {
            return const Center(
              child: Text('No contacts found'),
            );
          }

          return ListView.builder(
            itemCount: value.contacts.length,
            itemBuilder: (context, index) {
              final contact = value.contacts[index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.email),
                leading: CircleAvatar(
                  child: Text(contact.name[0].toUpperCase()),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    value.removeContact(contact);
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageContactScreen(),
                    settings: RouteSettings(arguments: contact),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
