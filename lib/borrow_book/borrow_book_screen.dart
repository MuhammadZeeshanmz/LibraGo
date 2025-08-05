import 'package:flutter/material.dart';

class BorrowBooksScreen extends StatefulWidget {
  const BorrowBooksScreen({super.key});

  @override
  State<BorrowBooksScreen> createState() => _BorrowBooksScreenState();
}

class _BorrowBooksScreenState extends State<BorrowBooksScreen> {
  // Sample list of books
  final List<Map<String, dynamic>> books = [
    {
      'title': 'Flutter for Beginners',
      'author': 'John Doe',
      'isAvailable': true
    },
    {'title': 'Advanced Flutter', 'author': 'Jane Smith', 'isAvailable': false},
    {'title': 'Cooking 101', 'author': 'Alice Brown', 'isAvailable': true},
    {
      'title': 'Mystery of the Night',
      'author': 'Bob Clark',
      'isAvailable': true
    },
    {
      'title': 'History of Art',
      'author': 'Chris Johnson',
      'isAvailable': false
    },
  ];

  // Function to borrow a book
  void _borrowBook(int index) {
    if (books[index]['isAvailable']) {
      setState(() {
        books[index]['isAvailable'] = false;
      });

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('You have successfully borrowed "${books[index]['title']}"'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${books[index]['title']}" is already borrowed.'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Borrow Books',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.blueAccent),
                title: Text(
                  book['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Author: ${book['author']}'),
                trailing: ElevatedButton(
                  onPressed: () => _borrowBook(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: book['isAvailable']
                        ? Colors.blueAccent
                        : Colors.grey, // Disable button if unavailable
                  ),
                  child: Text(
                    book['isAvailable'] ? 'Borrow' : 'Unavailable',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
