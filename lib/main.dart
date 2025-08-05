import 'package:flutter/material.dart';
import 'package:libraryapp/borrowing_history/borrowing_histrory.dart';
import 'package:libraryapp/favorite_screen/favorite_screen.dart';
import 'package:libraryapp/login/login_view.dart';
import 'package:libraryapp/notification_screen/notification_screen.dart';
import 'package:libraryapp/retrun_book/return_book.dart';
import 'package:libraryapp/signup/signup_view.dart';
import 'package:libraryapp/splash_screen/splash_screen.dart';
import 'package:libraryapp/user_dashboard/user_dashboard.dart';
import 'package:libraryapp/search_book/search_book.dart'; // Import the BookSearchScreen
import 'package:libraryapp/book_list_screen/book_list_screen.dart';
import 'package:libraryapp/borrow_book/borrow_book_screen.dart';
import 'package:libraryapp/retrun_book/return_book.dart';
import 'package:libraryapp/user_profile/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const UserDashboard(),
        '/search_books': (context) =>
            const BookSearchScreen(), // Add this route
        '/book_list': (context) => const BookListScreen(),
        '/borrow_books': (context) => const BorrowBooksScreen(),
        '/return_books': (context) => const ReturnBookScreen(),
        '/profile': (context) => UserProfileScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/borrowing_history': (context) => const BorrowingHistoryScreen(),
      },
    );
  }
}
