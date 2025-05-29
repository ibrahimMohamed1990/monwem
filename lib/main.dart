import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monwem App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  int _selectedIndex = 0;

  final List<String> _urls = [
    'https://monwem.com/',
    'https://monwem.com/cart',
    'https://monwem.com/redirect/categories/218909636',
    'https://monwem.com/%D8%A7%D9%84%D8%B4%D8%B1%D9%88%D8%B7-%D9%88%D8%A7%D9%84%D8%A7%D8%AD%D9%83%D8%A7%D9%85/page-1430101127',
  ];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_urls[_selectedIndex]));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.loadRequest(Uri.parse(_urls[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'الرئيسية',
            icon: Icon(Icons.home, size: 30, color: Colors.deepPurple),
            activeIcon: Icon(Icons.home, size: 30, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'السلة',
            icon: Icon(Icons.shopping_cart, size: 30, color: Colors.deepPurple),
            activeIcon:
                Icon(Icons.shopping_cart, size: 30, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'التصنيفات',
            icon: Icon(Icons.category, size: 30, color: Colors.deepPurple),
            activeIcon: Icon(Icons.category, size: 30, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: 'الشروط والاحكام',
            icon: Icon(Icons.description, size: 30, color: Colors.deepPurple),
            activeIcon: Icon(Icons.description, size: 30, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
