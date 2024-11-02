import 'package:aigo/dashboard/chat.dart';
import 'package:aigo/dashboard/recomendation.dart';
import 'package:aigo/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'activity.dart';
import 'analytics.dart';
import 'formPesan.dart';
import 'schedule.dart';

void main() {
  runApp(const ConsultationDashboard());
}

class ConsultationDashboard extends StatelessWidget {
  const ConsultationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consultation',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Consultation(),
    );
  }
}

class Consultation extends StatelessWidget {
  const Consultation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 233, 244, 1),
      appBar: MediaQuery.of(context).size.width <
              600 // Tampilkan AppBar hanya pada perangkat kecil
          ? AppBar(
              title: const Text('Dashboard'),
              backgroundColor: const Color(0xFF222B33),
              titleTextStyle: const TextStyle(color: Colors.white),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Membuka Drawer
                    },
                  );
                },
              ),
            )
          : null, // Jika ukuran layar lebih besar, tidak ada AppBar
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Section
          if (MediaQuery.of(context).size.width >
              600) // Tampilkan sidebar hanya di ukuran layar besar
            _buildSidebar(context),

          // Main Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MainContentWidget(),
            ),
          ),
        ],
      ),
      drawer: _buildSidebar(
          context), // Menggunakan sidebar sebagai Drawer untuk perangkat kecil
    );
  }

  // Sidebar Widget
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height, // Atur tinggi maksimum
      ),
      color: const Color(0xFF222B33),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        // Tambahkan ScrollView untuk menghindari overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            const SectionTitle(title: 'MENU'),
            SidebarButton(
              icon: FontAwesomeIcons.grip,
              label: 'Dashboard',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              },
              isActive: true,
            ),
            _buildSidebarLink(context, 'Activity'),
            _buildSidebarLink(context, 'Analytics'),
            _buildSidebarLink(context, 'Consultation'),
            SidebarButton(
              icon: FontAwesomeIcons.calendar,
              label: 'Schedule',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Schedule()),
                );
              },
            ),
            SidebarButton(
              icon: Icons.archive,
              label: 'Recommendation',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recomendation()),
                );
              },
            ),
            const SectionTitle(title: 'SUPPORT'),
            SidebarButton(icon: Icons.comment, label: 'Chat', onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chat()),
                );
            }),
            SidebarButton(
              icon: FontAwesomeIcons.history,
              label: 'Static',
              onPressed: () {},
            ),
            const SectionTitle(title: 'OTHERS'),
            SidebarButton(
              icon: FontAwesomeIcons.cog,
              label: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
            ),
            SidebarButton(
              icon: FontAwesomeIcons.signOutAlt,
              label: 'Log Out',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/dokter.png'),
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Duta', style: TextStyle(color: Colors.white)),
            Text('razaqduta@gmail.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildSidebarLink(context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {
              if (label == 'Activity') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Activity()),
                );
              } else if (label == 'Analytics') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Analytics()),
                );
              } else if (label == 'Consultation') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Consultation()),
                );
              }
            },
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class MainContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildMainContent(context);
  }

  Widget _buildMainContent(BuildContext context) {
    // Mendapatkan ukuran layar
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.4, // Responsive width
        constraints: BoxConstraints(
          maxHeight: isMobile
              ? MediaQuery.of(context).size.height *
                  1.68 // Maximum height for mobile
              : MediaQuery.of(context).size.height *
                  1.2, // Maximum height for larger screens
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height: 20), // Spacing between text and profile cards
            const Text(
              'Pilih Konsultan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(55, 179, 183, 1),
              ),
            ),
            const SizedBox(
                height: 20), // Spacing between text and profile cards
            isMobile
                ? Column(
                    children: [
                      // Mobile layout
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                name: 'Dr. Maulana Fauzan',
                                specialization: 'Spesialis Gizi',
                                experienceYears: '5',
                                consultations: '92',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                name: 'Dr. Maulana Fauzan',
                                specialization: 'Spesialis Gizi',
                                experienceYears: '5',
                                consultations: '92',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                name: 'Dr. Maulana Fauzan',
                                specialization: 'Spesialis Gizi',
                                experienceYears: '5',
                                consultations: '92',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      // For larger screens
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Dwi Hariyati',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Spacing between profile cards
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Maulana Fauzan',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Spacing between profile cards
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Maulana Fauzan',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height:
                              20), // Spacing between first row and second row
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Maulana Fauzan',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Spacing between profile cards
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Maulana Fauzan',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                          const SizedBox(
                              width: 20), // Spacing between profile cards
                          Expanded(
                            child: SizedBox(
                              child: ProfileCard(
                                  name: 'Dr. Maulana Fauzan',
                                  specialization: 'Spesialis Gizi',
                                  experienceYears: '5',
                                  consultations: '92'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String experienceYears;
  final String consultations;

  const ProfileCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.experienceYears,
    required this.consultations,
  });

  @override
  Widget build(BuildContext context) {
    // Get the container's width and height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.5; // Adjusted height

    // Define the button width based on the device type
    final double buttonWidth = width < 600
        ? width * 0.3
        : width * 0.08; // Assuming mobile if width < 600

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Top section (green)
              Container(
                height: height * 0.25,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(55, 179, 183, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
              // Bottom section (white)
              Container(
                height: height * 0.75,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.1,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      // Name
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(55, 179, 183, 1),
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Specialization
                      Text(
                        specialization,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(55, 179, 183, 1),
                        ),
                      ),
                      const SizedBox(height: 23),
                      // Experience and consultations columns
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '$experienceYears Tahun',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Pengalaman',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                consultations,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Consultations',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 23),
                      // Button Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: buttonWidth, // Responsive button width
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const formPesan()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(55, 179, 183, 1),
                                  width: 2,
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(55, 179, 183, 1),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.015,
                                ),
                              ),
                              child: const Text(
                                'Konsul',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: buttonWidth, // Responsive button width
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const formPesan()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(55, 179, 183, 1),
                                  width: 2,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.015,
                                ),
                              ),
                              child: const Text(
                                'Pesan',
                                style: TextStyle(
                                  color: Color.fromRGBO(55, 179, 183, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              width: height * 0.3,
              height: height * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 7,
                ),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/dokter.png'), // Update image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
