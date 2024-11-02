import 'package:flutter/material.dart';
import '../home/mainstyles.dart'; // Impor file mainstyles.dart
import '../main.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < 600; // Cek ukuran layar
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Stack(
          children: [
            Container(
              decoration: appBarGradient,
              width: double.infinity,
              height: 50.0,
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  ),
                  if (isMobile) ...[
                    // Icon untuk membuka menu
                    PopupMenuButton<String>(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onSelected: (value) {
                        switch (value) {
                          case 'home':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyApp()), // Ganti dengan halaman register
                            );
                            break;
                          case 'about':
                            // Aksi untuk About Us
                            break;
                          case 'contact':
                            // Aksi untuk Contact Us
                            break;
                          case 'signup':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register()), // Ganti dengan halaman register
                            );
                            break;
                          case 'login':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Login()), // Ganti dengan halaman login
                            );
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            value: 'home',
                            child: Text(
                              'Home',
                            ),
                          ),
                          PopupMenuItem(
                            value: 'about',
                            child: Text('About Us'),
                          ),
                          PopupMenuItem(
                            value: 'contact',
                            child: Text('Contact Us'),
                          ),
                          PopupMenuItem(
                            value: 'signup',
                            child: Text('Sign Up'),
                          ),
                          PopupMenuItem(
                            value: 'login',
                            child: Text('Login'),
                          ),
                        ];
                      },
                    ),
                  ] else ...[
                    // Menu untuk tampilan desktop
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyApp()), // Ganti dengan halaman register
                            );
                          },
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 150),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register()), // Ganti dengan halaman register
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Color.fromARGB(255, 58, 99, 169)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minimumSize: Size(120, 45),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 58, 99, 169),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minimumSize: Size(120, 45),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 63, 215, 207),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.png'), // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 475,
            width: 400, // Atur lebar kotak registrasi
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            // Register Box
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome to AIGO',
                      style: TextStyle(
                          fontFamily: 'Sitka-light',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Have an account?',
                        style:
                            TextStyle(fontFamily: 'Saira-Light', fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(fontFamily: 'Sitka', fontSize: 30),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontFamily: 'Saira-Light',
                              color: Colors.blue,
                              fontSize: 12),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your username or email address',
                  style: TextStyle(
                      fontFamily: 'Saira-Light', fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username or email address',
                      hintStyle: TextStyle(
                          fontFamily: 'Saira-Light',
                          color: const Color.fromARGB(77, 0, 0, 0),
                          fontWeight: FontWeight.w100,
                          fontSize: 13)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Menjaga jarak antara elemen
                  children: [
                    Expanded(
                      // Tambahkan Expanded di sini
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                                fontFamily: 'Saira-Light',
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  fontFamily: 'Saira-Light',
                                  color: const Color.fromARGB(77, 0, 0, 0),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 20), // Jarak antara Username dan Contact Number
                    Expanded(
                      // Tambahkan Expanded di sini
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Number',
                            style: TextStyle(
                                fontFamily: 'Saira-Light',
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Contact Number',
                              hintStyle: TextStyle(
                                  fontFamily: 'Saira-Light',
                                  color: const Color.fromARGB(77, 0, 0, 0),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your Password',
                  style: TextStyle(
                      fontFamily: 'Saira-Light', fontWeight: FontWeight.bold),
                ),
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(77, 0, 0, 0),
                      fontWeight: FontWeight.w100,
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromRGBO(47, 93, 153, 1), // Warna tombol
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Sesuaikan padding vertikal
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 50), // Ukuran minimum
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Saira-Light'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
