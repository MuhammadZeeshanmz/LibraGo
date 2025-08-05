import 'package:flutter/material.dart';

class BorrowingHistoryScreen extends StatefulWidget {
  const BorrowingHistoryScreen({super.key});

  @override
  State<BorrowingHistoryScreen> createState() => _BorrowingHistoryScreenState();
}

class _BorrowingHistoryScreenState extends State<BorrowingHistoryScreen> {
  // Sample data for borrowing history
  final List<Map<String, dynamic>> borrowingHistory = [
    {
      'title': 'Flutter for Beginners',
      'author': 'John Doe',
      'dueDate': '2025-01-25',
      'isOverdue': false,
    },
    {
      'title': 'Advanced Flutter',
      'author': 'Jane Smith',
      'dueDate': '2025-01-15',
      'isOverdue': true,
    },
    {
      'title': 'Mystery of the Night',
      'author': 'Bob Clark',
      'dueDate': '2025-01-30',
      'isOverdue': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Borrowing History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
        child: borrowingHistory.isEmpty
            ? const Center(
                child: Text(
                  'No borrowed books yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: borrowingHistory.length,
                itemBuilder: (context, index) {
                  final book = borrowingHistory[index];
                  return _buildBorrowingCard(book);
                },
              ),
      ),
    );
  }

  // Widget for individual borrowing record cards
  Widget _buildBorrowingCard(Map<String, dynamic> book) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Author: ${book['author']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date: ${book['dueDate']}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: book['isOverdue'] ? Colors.red : Colors.green,
                  ),
                ),
                if (book['isOverdue'])
                  const Text(
                    'Overdue',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
