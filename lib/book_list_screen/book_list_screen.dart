import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
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

  void _toggleAvailability(int index) {
    setState(() {
      books[index]['isAvailable'] = !books[index]['isAvailable'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF007BFF),
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
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewPadding.bottom + 8.0,
        ),
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
                  book['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1,
                ),
                subtitle: Text(
                  'Author: ${book['author']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: SizedBox(
                  width: 120, // Set a fixed width for trailing content
                  child: SingleChildScrollView(
                    // Prevent overflow
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book['isAvailable'] ? 'Available' : 'Borrowed',
                          style: TextStyle(
                            color:
                                book['isAvailable'] ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        IconButton(
                          icon: Icon(
                            book['isAvailable']
                                ? Icons.check_circle
                                : Icons.cancel,
                            color:
                                book['isAvailable'] ? Colors.green : Colors.red,
                          ),
                          onPressed: () => _toggleAvailability(index),
                        ),
                      ],
                    ),
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
