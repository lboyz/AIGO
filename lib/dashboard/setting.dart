import 'package:aigo/dashboard/chat.dart';
import 'package:aigo/dashboard/recomendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'activity.dart';
import 'analytics.dart';
import 'consultation.dart';
import 'schedule.dart';

void main() {
  runApp(const SettingDashboard());
}

class SettingDashboard extends StatelessWidget {
  const SettingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setting',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Setting(),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 233, 244, 1),
      appBar: isSmallScreen
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
                      Scaffold.of(context).openDrawer(); // Open Drawer
                    },
                  );
                },
              ),
            )
          : null,
      body: Center(
          child: isSmallScreen
              ? Container(
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  padding: EdgeInsets.only(left: 15, right: 15),
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
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        _buildProfileSettings(
                            context), // Add profile settings section
                      ])),
                )
              : Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSidebar(context),
                      Container(
                        constraints:
                            const BoxConstraints(maxWidth: 975, maxHeight: 900),
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProfileSettings(
                                context), // Add profile settings section
                          ],
                        ),
                      )
                    ],
                  ),
                )),
      drawer: _buildSidebar(context),
    );
  }

  Widget _buildProfileSettings(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Profile Setting',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Update your profile settings here',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 2, color: Colors.grey),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(
                            text: 'duta'), // Mengatur nilai default
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Mengatur ukuran radius
                          ),
                          hintText: 'Enter your username',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // Aksi ketika ikon ditekan
                            },
                            child: const Icon(
                              Icons.help_outline, // Ikon tanda tanya
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: TextEditingController(
                              text: 'duta'), // Mengatur nilai default
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mengatur ukuran radius
                            ),
                            hintText: 'Enter your username',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // Aksi ketika ikon ditekan
                              },
                              child: const Icon(
                                Icons.help_outline, // Ikon tanda tanya
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
          ),
          const Divider(
            height: 32, // Tinggi divider
            color: Colors.grey, // Warna divider
          ),

          // Phone Number Section
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      IntlPhoneField(
                        controller: TextEditingController(
                            text: '85163296410'), // Mengatur nilai default
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Mengatur ukuran radius
                          ),
                        ),
                        initialCountryCode: 'ID',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: IntlPhoneField(
                          controller: TextEditingController(
                              text: '85163296410'), // Mengatur nilai default
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Mengatur ukuran radius
                            ),
                          ),
                          initialCountryCode: 'ID',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
          ),
          // Divider
          const Divider(
            height: 32,
            color: Colors.grey,
          ),

          // Profile Picture Section
          Container(
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Profile Picture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30, // Ukuran lingkaran
                            backgroundImage: AssetImage(
                                'assets/images/dokter.png'), // Ganti dengan gambar Anda
                            backgroundColor: Colors
                                .grey, // Warna latar belakang jika gambar tidak tersedia
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol edit ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blue[900], // Warna biru tua
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol delete ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Warna biru tua
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Profile Picture',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30, // Ukuran lingkaran
                              backgroundImage: AssetImage(
                                  'assets/images/dokter.png'), // Ganti dengan gambar Anda
                              backgroundColor: Colors
                                  .grey, // Warna latar belakang jika gambar tidak tersedia
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Aksi ketika tombol edit ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue[900], // Warna biru tua
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Aksi ketika tombol delete ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Warna biru tua
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),

          const Divider(
            height: 32,
            color: Colors.grey,
          ),

          const Divider(
            height: 32,
            color: Colors.grey,
          ),
          NotificationSettings(),
        ],
      ),
    );
  }

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
              // isActive: true,
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
                  MaterialPageRoute(
                      builder: (context) => const Recomendation()),
                );
              },
            ),
            const SectionTitle(title: 'SUPPORT'),
            SidebarButton(
                icon: Icons.comment,
                label: 'Chat',
                onPressed: () {
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
              onPressed: () {},
              isActive: true,
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

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _emailNotification = false;
  bool _soundNotification = false;
  bool _subscriptionNotification = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width <
        600; // Check if the device is mobile

    return Container(
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notification',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16), // Add spacing after the title
                // Checkbox 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _emailNotification,
                      onChanged: (value) {
                        setState(() {
                          _emailNotification = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7), // Set radius
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Email Notification',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            'You will be notified when a new email arrives',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Checkbox 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _soundNotification,
                      onChanged: (value) {
                        setState(() {
                          _soundNotification = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7), // Set radius
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Sound Notification',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            'You will be notified with sound when someone messages you',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Checkbox 3
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _subscriptionNotification,
                      onChanged: (value) {
                        setState(() {
                          _subscriptionNotification = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7), // Set radius
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Subscription',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            'You will be notified when you subscribe to an account',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: const Text(
                    'Notification',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Checkbox 1
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _emailNotification,
                            onChanged: (value) {
                              setState(() {
                                _emailNotification = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(7), // Set radius
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Email Notification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'You will be notified when a new email arrives',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Checkbox 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _soundNotification,
                            onChanged: (value) {
                              setState(() {
                                _soundNotification = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(7), // Set radius
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Sound Notification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'You will be notified with sound when someone messages you',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Checkbox 3
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _subscriptionNotification,
                            onChanged: (value) {
                              setState(() {
                                _subscriptionNotification = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(7), // Set radius
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Subscription',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'You will be notified when you subscribe to an account',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
