import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  // Sample notification data
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'overdue',
      'message': 'The book "Flutter for Beginners" is overdue!',
      'date': '2025-01-15',
    },
    {
      'type': 'dueSoon',
      'message': 'The book "Advanced Flutter" is due on 2025-01-20.',
      'date': '2025-01-18',
    },
    {
      'type': 'general',
      'message': 'Check out the latest additions to our library!',
      'date': '2025-01-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
        child: notifications.isEmpty
            ? const Center(
                child: Text(
                  'No notifications available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(notification);
                },
              ),
      ),
    );
  }

  // Notification card widget
  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    IconData icon;
    Color iconColor;

    switch (notification['type']) {
      case 'overdue':
        icon = Icons.error;
        iconColor = Colors.red;
        break;
      case 'dueSoon':
        icon = Icons.warning;
        iconColor = Colors.orange;
        break;
      case 'general':
      default:
        icon = Icons.info;
        iconColor = Colors.blueAccent;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 40),
        title: Text(
          notification['message'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Date: ${notification['date']}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.grey),
          onPressed: () {
            // Handle delete notification
          },
        ),
      ),
    );
  }
}
