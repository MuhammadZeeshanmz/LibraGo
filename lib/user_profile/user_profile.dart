import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  // Sample user data
  final Map<String, String> userDetails = {
    'name': 'Ekhtisham Ahmad',
    'email': 'shamahmad5434@gmail.com',
    'phone': '+92 340 0905434',
  };

  // Current borrowed books
  final List<Map<String, dynamic>> currentBorrowedBooks = [
    {
      'title': 'Flutter for Beginners',
      'dueDate': '2025-01-25',
    },
    {
      'title': 'Advanced Flutter',
      'dueDate': '2025-01-30',
    },
  ];

  // Borrowing history
  final List<Map<String, dynamic>> borrowingHistory = [
    {
      'title': 'Mystery of the Night',
      'returnedDate': '2025-01-15',
    },
    {
      'title': 'Operating System',
      'returnedDate': '2025-01-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to edit profile screen
              Navigator.pushNamed(context, '/edit_profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Current Borrowed Books'),
              const SizedBox(height: 10),
              _buildCurrentBorrowedBooks(),
              const SizedBox(height: 20),
              _buildSectionTitle('Borrowing History'),
              const SizedBox(height: 10),
              _buildBorrowingHistory(),
            ],
          ),
        ),
      ),
    );
  }

  // User information section
  Widget _buildUserInfoSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDetails['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Email: ${userDetails['email']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phone: ${userDetails['phone']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  // Current borrowed books widget
  Widget _buildCurrentBorrowedBooks() {
    if (currentBorrowedBooks.isEmpty) {
      return const Center(
        child: Text(
          'No currently borrowed books.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentBorrowedBooks.length,
      itemBuilder: (context, index) {
        final book = currentBorrowedBooks[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: const Icon(
              Icons.book,
              color: Colors.blueAccent,
              size: 40,
            ),
            title: Text(
              book['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Due Date: ${book['dueDate']}'),
          ),
        );
      },
    );
  }

  // Borrowing history widget
  Widget _buildBorrowingHistory() {
    if (borrowingHistory.isEmpty) {
      return const Center(
        child: Text(
          'No borrowing history available.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: borrowingHistory.length,
      itemBuilder: (context, index) {
        final history = borrowingHistory[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.blueAccent,
              size: 40,
            ),
            title: Text(
              history['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Returned Date: ${history['returnedDate']}'),
          ),
        );
      },
    );
  }
}
