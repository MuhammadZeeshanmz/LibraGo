import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Sample list of favorite books
  List<Map<String, dynamic>> favorites = [
    {'title': 'Flutter for Beginners', 'author': 'John Doe'},
    {'title': 'Advanced Flutter', 'author': 'Jane Smith'},
    {'title': 'Mystery of the Night', 'author': 'Bob Clark'},
  ];

  void _removeFromFavorites(int index) {
    setState(() {
      favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
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
        child: favorites.isEmpty
            ? const Center(
                child: Text(
                  'No favorite books yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final book = favorites[index];
                  return _buildFavoriteCard(book, index);
                },
              ),
      ),
    );
  }

  // Widget for individual favorite book cards
  Widget _buildFavoriteCard(Map<String, dynamic> book, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.favorite, color: Colors.redAccent, size: 40),
        title: Text(
          book['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('Author: ${book['author']}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.grey),
          onPressed: () => _removeFromFavorites(index),
        ),
      ),
    );
  }
}
