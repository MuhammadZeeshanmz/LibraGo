import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _name = "User";
  String _email = "Email";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            _name = userDoc['name'] ?? "User";
            _email = userDoc['email'] ?? "Email";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _deleteUserAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Delete the Firestore document
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete the user account from Firebase Auth
        await user.delete();

        // Sign out after deletion
        await _auth.signOut();

        // Navigate to login screen
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print("Error deleting user account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Failed to delete account. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Dashboard",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 1:
                  // Navigate to Profile and pass user data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(name: _name, email: _email),
                    ),
                  );
                  break;
                case 2:
                  // Delete user account
                  _deleteUserAccount();
                  break;
              }
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ), // User profile icon
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.blueAccent),
                  title: Text("Profile"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.redAccent),
                  title: Text("Logout"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: _features.length,
                itemBuilder: (context, index) {
                  return _buildFeatureCard(
                    context,
                    title: _features[index]['title'] as String,
                    icon: _features[index]['icon'] as IconData,
                    route: _features[index]['route'] as String,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Feature list for the dashboard
final List<Map<String, dynamic>> _features = [
  {
    'title': 'Search Books',
    'icon': Icons.search,
    'route': '/search_books',
  },
  {
    'title': 'Book List',
    'icon': Icons.library_books,
    'route': '/book_list',
  },
  {
    'title': 'Borrow Books',
    'icon': Icons.book_online,
    'route': '/borrow_books',
  },
  {
    'title': 'Return Books',
    'icon': Icons.assignment_return,
    'route': '/return_books',
  },
  {
    'title': 'Profile',
    'icon': Icons.person,
    'route': '/profile',
  },
  {
    'title': 'Notifications',
    'icon': Icons.notifications,
    'route': '/notifications',
  },
  {
    'title': 'Favorites',
    'icon': Icons.favorite,
    'route': '/favorites',
  },
  {
    'title': 'Borrowing History',
    'icon': Icons.history,
    'route': '/borrowing_history',
  },
];

// Profile Page to Display User Info
class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  const ProfilePage({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User Information",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: $name",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Email: $email",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
