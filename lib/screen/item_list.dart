import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/services/firestore_service.dart';
// ^ IF RED: Hover and Fix Import

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();

  void _showDialog() {
    _nameController.clear();
    _pointController.clear();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Tambah Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Item'),
              ),
              TextField(
                controller: _pointController,
                decoration: const InputDecoration(labelText: 'Poin Item'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final int point = int.tryParse(_pointController.text) ?? 0;

                if (name.isNotEmpty) {
                  _firestoreService.addItem(name, point);
                  Navigator.pop(context);
                }
              },
              child: const Text("Simpan"),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Item'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: StreamBuilder(
          stream: _firestoreService.getItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final items = snapshot.data as List;
              if (items.isEmpty) return const Center(child: Text("Tidak ada item"));

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item.id),
                      trailing: Text("${item.point} Poin"),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Error loading data"));
          },
        )
    );
  }
}