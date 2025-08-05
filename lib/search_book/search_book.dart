import 'package:flutter/material.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "Title";
  List<Map<String, String>> books = [
    {
      'title': 'Flutter for Beginners',
      'author': 'John Doe',
      'category': 'Tech'
    },
    {'title': 'Advanced Flutter', 'author': 'Jane Smith', 'category': 'Tech'},
    {'title': 'Cooking 101', 'author': 'Alice Brown', 'category': 'Cooking'},
    {
      'title': 'Mystery of the Night',
      'author': 'Bob Clark',
      'category': 'Fiction'
    },
  ];
  List<Map<String, String>> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = books; // Initially show all books
  }

  void _filterBooks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredBooks = books;
      } else {
        filteredBooks = books.where((book) {
          if (_selectedFilter == "Title") {
            return book['title']!.toLowerCase().contains(query);
          } else if (_selectedFilter == "Author") {
            return book['author']!.toLowerCase().contains(query);
          } else if (_selectedFilter == "Category") {
            return book['category']!.toLowerCase().contains(query);
          }
          return false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Search',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar and Filter Dropdown
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _filterBooks(),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: const TextStyle(color: Colors.blueAccent),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.blueAccent),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: const [
                    DropdownMenuItem(value: "Title", child: Text("Title")),
                    DropdownMenuItem(value: "Author", child: Text("Author")),
                    DropdownMenuItem(
                        value: "Category", child: Text("Category")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                      _filterBooks();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Search Results
            Expanded(
              child: filteredBooks.isEmpty
                  ? const Center(
                      child: Text(
                        'No books found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: ListTile(
                            leading: const Icon(Icons.book,
                                color: Colors.blueAccent),
                            title: Text(book['title']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                'Author: ${book['author']} \nCategory: ${book['category']}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
