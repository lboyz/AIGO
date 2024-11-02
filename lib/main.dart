import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home/mainstyles.dart'; // impor file mainstyles.dart
import 'login-register/login.dart';
import 'login-register/register.dart';
import 'dashboard/dashboard.dart'; // Pastikan untuk mengimpor file AigoDashboard

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                            // Aksi untuk Home
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
                          onPressed: () {},
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                reversedImage(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: isMobile
                      ? MediaQuery.of(context).size.height * 1.3
                      : MediaQuery.of(context).size.height,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.078,
                              right: MediaQuery.of(context).size.width * 0.078,
                              top: MediaQuery.of(context).size.width * 0.078,
                              bottom:
                                  MediaQuery.of(context).size.width * 0.042),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: isMobile
                                        ? MediaQuery.of(context).size.width *
                                            0.07
                                        : MediaQuery.of(context).size.width *
                                            0.02),
                                child: titleText(
                                    'Cegah sebelum Terlambat.', context),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 1,
                                color: Colors.white,
                                // margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: isMobile
                                        ? MediaQuery.of(context).size.width *
                                            0.01
                                        : 32.5),
                                child: subtitleText(
                                  'Kenali Risiko dan Amati Pola Makan Serta Gaya Hidup Anda.',
                                  context,
                                ),
                              ),
                              SizedBox(
                                  height: isMobile
                                      ? MediaQuery.of(context).size.width * 0.03
                                      : 85),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AigoDashboard()), // Navigasi ke AigoDashboard
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 58, 99, 169),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 30 : 65,
                                      vertical: isMobile ? 15 : 25),
                                  foregroundColor:
                                      const Color.fromARGB(255, 63, 215, 207),
                                ),
                                child: Text('Kenali Tubuhmu'),
                              ),
                            ],
                          ),
                        ),
                        // Cek Tingkat Obesitas
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 10 : 50,
                              vertical: isMobile ? 10 : 20),
                          color: Color.fromRGBO(217, 217, 217, 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Mengubah menjadi 'center' agar teks di tengah gambar
                            children: [
                              // Gambar di sebelah kiri
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    20), // Sesuaikan nilai radius di sini
                                child: Image.asset(
                                  'assets/images/obesitas.png', // Gambar timbangan
                                  height: isMobile
                                      ? MediaQuery.of(context).size.height * 0.3
                                      : 350,
                                  width: isMobile
                                      ? MediaQuery.of(context).size.width * 0.5
                                      : 450, // Gambar persegi
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width: isMobile
                                      ? 10
                                      : 65), // Spasi antara gambar dan teks
                              // Teks di sebelah kanan
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    subMenuTitle(
                                        'Cek Tingkat Obesitas', context),
                                    SizedBox(height: isMobile ? 5 : 25),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: subMenuText(
                                            'Obesitas merupakan kondisi kelebihan lemak tubuh yang dapat meningkatkan risiko berbagai penyakit serius. Dengan AIGO, kamu dapat mengecek tingkat obesitas kamu menggunakan AI yang telah dirancang khusus.',
                                            context)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Rekomendasi Pengelola Kesehatan
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 10 : 50,
                              vertical: isMobile ? 10 : 20),
                          color: Color.fromRGBO(192, 192, 192, 1),
                          width: MediaQuery.of(context)
                              .size
                              .width, // Mengambil seluruh lebar layar
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Agar teks sejajar di tengah secara vertikal
                            children: [
                              // Kolom teks di sebelah kiri
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Agar teks di tengah secara vertikal
                                  children: [
                                    subMenuTitle(
                                        'Rekomendasi Pengelola Kesehatan',
                                        context),
                                    SizedBox(
                                        height: isMobile
                                            ? 5
                                            : 25), // Jarak antara judul dan deskripsi
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.5,
                                        child: subMenuText(
                                            'Pengelolaan kesehatan yang baik memerlukan pola hidup sehat, aktivitas fisik teratur, dan pemeriksaan medis berkala. Untuk memudahkan kamu, AIGO selalu memberi rekomendasi untuk mengelola kesehatan kamu.',
                                            context)),
                                  ],
                                ),
                              ),

                              SizedBox(
                                  width: isMobile
                                      ? 10
                                      : 65), // Spasi antara teks dan gambar
                              ClipRRect(
                                // Gambar di sebelah kanan
                                borderRadius: BorderRadius.circular(
                                    20), // Sesuaikan nilai radius di sini
                                child: Image.asset(
                                  'assets/images/healthy_food.png', // Gambar timbangan
                                  height: isMobile
                                      ? MediaQuery.of(context).size.height * 0.3
                                      : 350,
                                  width: isMobile
                                      ? MediaQuery.of(context).size.width * 0.5
                                      : 450, // Gambar persegi
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Konsultasi dokter
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 10 : 50,
                              vertical: isMobile ? 10 : 20),
                          color: Color.fromRGBO(217, 217, 217, 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Gambar di sebelah kiri
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    20), // Sesuaikan nilai radius di sini
                                child: Image.asset(
                                  'assets/images/dokter.png', // Gambar timbangan
                                  height: isMobile
                                      ? MediaQuery.of(context).size.height * 0.3
                                      : 350,
                                  width: isMobile
                                      ? MediaQuery.of(context).size.width * 0.5
                                      : 450, // Gambar persegi
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(
                                  width: isMobile
                                      ? 10
                                      : 65), // Spasi antara gambar dan teks
                              // Teks di sebelah kanan
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Menempatkan teks di tengah secara vertikal
                                  children: [
                                    subMenuTitle('Konsultasi Dokter', context),
                                    // SizedBox(height: 25),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: subMenuText(
                                            'Konsultasi dengan dokter secara langsung untuk mendapatkan panduan kesehatan yang sesuai dengan kondisi tubuhmu. Dokter siap membantu agar kamu bisa mencapai performa terbaik dan menjaga kebugaran secara optimal.',
                                            context)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Section-3: Text dan Button dengan background biru muda
                        Center(
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Lebar sesuai layar
                            height: isMobile
                                ? MediaQuery.of(context).size.height * 0.5
                                : MediaQuery.of(context)
                                    .size
                                    .height, // Tinggi sesuai layar
                            color: Color.fromARGB(
                                255, 233, 239, 255), // Background biru muda
                            padding: EdgeInsets.symmetric(
                                vertical: isMobile
                                    ? 5
                                    : 10), // Padding atas dan bawah
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: isMobile
                                        ? 0
                                        : MediaQuery.of(context).size.height *
                                            0.25),
                                SizedBox(
                                  width: isMobile
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Obesitas bukan hanya masalah penampilan, tapi juga kesehatan. Perubahan kecil dalam gaya hidup dapat membuat perbedaan besar.',
                                    textAlign:
                                        TextAlign.center, // Rata tengah teks
                                    style: TextStyle(
                                      fontFamily: 'Sitka',
                                      fontSize: isMobile ? 18 : 30,
                                      color: const Color.fromARGB(
                                          255, 3, 89, 159), // Warna teks
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: isMobile
                                        ? 40
                                        : MediaQuery.of(context).size.height *
                                            0.2), // Jarak antara teks dan tombol
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 58, 99, 169),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: Size(195, 55),
                                  ),
                                  child: Text(
                                    'Kenali Tubuhmu',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 63, 215, 207),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: isMobile
                                        ? 0
                                        : MediaQuery.of(context).size.height *
                                            0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Footer
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 10 : 20, horizontal: isMobile ? 10 : 50),
              color: Color.fromARGB(255, 58, 99, 169), // Sesuaikan warna footer
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo di sebelah kiri dengan latar belakang dan radius
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Warna latar belakang
                      borderRadius: BorderRadius.circular(10), // Radius sudut
                    ),
                    padding: EdgeInsets.all(
                        isMobile ? 2 : 8), // Padding di sekitar logo
                    child: Image.asset(
                      'assets/images/logo.png', // Ganti dengan path logo Anda
                      height: isMobile ? 60 : 90, // Atur ukuran logo
                      width: isMobile ? 100 : 160, // Atur ukuran logo
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Teks dan ikon di sebelah kanan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Ikon media sosial di atas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              const url = 'https://twitter.com/dutzii27';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            icon: FaIcon(FontAwesomeIcons
                                .twitter), // Menggunakan FontAwesomeIcons
                            color: Colors.white,
                            iconSize:
                                isMobile ? 20 : 35, // Sesuaikan ukuran ikon
                          ),
                          IconButton(
                            onPressed: () async {
                              const url =
                                  'https://www.facebook.com/duta.razaq/';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }, // Aksi untuk Facebook
                            icon: FaIcon(FontAwesomeIcons
                                .facebook), // Menggunakan FontAwesomeIcons
                            color: Colors.white,
                            iconSize:
                                isMobile ? 20 : 35, // Sesuaikan ukuran ikon
                          ),
                          IconButton(
                            onPressed: () async {
                              const url =
                                  'https://www.instagram.com/duta.razaq/';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }, // Aksi untuk Instagram
                            icon: FaIcon(FontAwesomeIcons
                                .instagram), // Menggunakan FontAwesomeIcons
                            color: Colors.white,
                            iconSize:
                                isMobile ? 20 : 35, // Sesuaikan ukuran ikon
                          ),
                          IconButton(
                            onPressed: () async {
                              const url = 'https://github.com/lboyz';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }, // Aksi untuk GitHub
                            icon: FaIcon(FontAwesomeIcons
                                .github), // Menggunakan FontAwesomeIcons
                            color: Colors.white,
                            iconSize:
                                isMobile ? 20 : 35, // Sesuaikan ukuran ikon
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              isMobile ? 3 : 10), // Jarak antara ikon dan teks
                      // Links di bawah
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'About us',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 6 : 12),
                          ),
                          SizedBox(
                              width: isMobile ? 5 : 20), // Jarak antar teks
                          Text(
                            'Contact',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 6 : 12),
                          ),
                          SizedBox(
                              width: isMobile ? 5 : 20), // Jarak antar teks
                          Text(
                            'Privacy policy',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 6 : 12),
                          ),
                          SizedBox(
                              width: isMobile ? 5 : 20), // Jarak antar teks
                          Text(
                            'Sitemap',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 6 : 12),
                          ),
                          SizedBox(
                              width: isMobile ? 5 : 20), // Jarak antar teks
                          Text(
                            'Terms of Use',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 6 : 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
