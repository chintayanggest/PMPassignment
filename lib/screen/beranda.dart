// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:my_first_flutter_app/services/firestore_service.dart';
//
// class BerandaScreen extends StatefulWidget {
//   const BerandaScreen({super.key});
//
//   @override
//   State<BerandaScreen> createState() => _BerandaState();
// }
//
// class _BerandaState extends State<BerandaScreen> {
//   final FirestoreService firestoreService = FirestoreService();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController pointController = TextEditingController();
//
//   // Function to show the "Add Item" popup
//   void openNoteBox() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Tambah Item"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Nama Item"),
//             ),
//             TextField(
//               controller: pointController,
//               decoration: const InputDecoration(labelText: "Poin"),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               // Save to Firestore
//               firestoreService.addItem(nameController.text, pointController.text);
//
//               // Clear text fields
//               nameController.clear();
//               pointController.clear();
//
//               // Close box
//               Navigator.pop(context);
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             child: const Text("Simpan", style: TextStyle(color: Colors.white)),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Daftar Item", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//         automaticallyImplyLeading: false, // Removes back button
//       ),
//
//       // Floating Button to Add Data
//       floatingActionButton: FloatingActionButton(
//         onPressed: openNoteBox,
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//
//       // THE LIST (READ DATA)
//       body: StreamBuilder<QuerySnapshot>(
//         stream: firestoreService.getItems(),
//         builder: (context, snapshot) {
//           // If loading...
//           if (snapshot.hasData) {
//             List itemsList = snapshot.data!.docs;
//
//             return ListView.builder(
//               itemCount: itemsList.length,
//               itemBuilder: (context, index) {
//                 // Get each document
//                 DocumentSnapshot document = itemsList[index];
//                 String docID = document.id;
//
//                 // Get data from each document
//                 Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//                 String noteText = data['name'];
//                 String pointText = data['points'];
//
//                 // Display as a Card
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(noteText, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Text("Poin: $pointText"),
//                     trailing: const Icon(Icons.check_circle, color: Colors.green),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text("Belum ada data..."));
//           }
//         },
//       ),
//     );
//   }
// }