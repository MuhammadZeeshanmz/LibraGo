import 'package:flutter/material.dart';

class ReturnBookScreen extends StatefulWidget {
  const ReturnBookScreen({super.key});

  @override
  State<ReturnBookScreen> createState() => _ReturnBookScreenState();
}

class _ReturnBookScreenState extends State<ReturnBookScreen> {
  // List of borrowed books
  final List<Map<String, dynamic>> borrowedBooks = [
    {'title': 'Advanced Flutter', 'author': 'Jane Smith'},
    {'title': 'Mystery of the Night', 'author': 'Bob Clark'},
    {'title': 'History of Art', 'author': 'Chris Johnson'},
  ];

  void _returnBook(int index) {
    final book = borrowedBooks[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Return Confirmation'),
        content: Text('Are you sure you want to return "${book['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel return
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                borrowedBooks.removeAt(index); // Remove the book from the list
              });
              Navigator.pop(context);
              _showSuccessMessage(book['title']);
            },
            child: const Text('Return'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String bookTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$bookTitle" has been successfully returned!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Return Books',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF007BFF),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: borrowedBooks.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 16),
                  Text(
                    'No borrowed books to return!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: borrowedBooks.length,
                itemBuilder: (context, index) {
                  final book = borrowedBooks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.book,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                      title: Text(
                        book['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text('Author: ${book['author']}'),
                      trailing: ElevatedButton(
                        onPressed: () => _returnBook(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Return'),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
