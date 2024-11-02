import 'package:aigo/dashboard/recomendation.dart';
import 'package:aigo/dashboard/schedule.dart';
import 'package:aigo/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'activity.dart';
import 'analytics.dart';
import 'consultation.dart';

void main() {
  runApp(const ChatDashboard());
}

class ChatDashboard extends StatelessWidget {
  const ChatDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Chat(),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

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
                      Scaffold.of(context).openDrawer(); // Membuka Drawer
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
                child: ChatScreen(),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ChatScreen(),
                                  )
                                ],
                              )),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                _buildChatHeader(),
                                Expanded(
                                  child: _buildChatArea(context),
                                ),
                                _buildMessageInput(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
      drawer: isSmallScreen ? _buildSidebar(context) : null,
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
            },
              isActive: true,

            ),
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

Widget _buildChatHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    color: Colors.white,
    child: Row(
      children: [
        // Gambar profil di sebelah kiri
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(
              'assets/images/dokter.png'), // Ganti dengan path gambar
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 10),

        // Nama dan spesialisasi
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Dr. Dwi Hariyanti',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(152, 155, 161, 1),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Spesialisasi Gizi',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(152, 155, 161, 1),
              ),
            ),
          ],
        ),

        // Ikon titik tiga di pojok kanan
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Logika untuk aksi lebih lanjut
          },
        ),
      ],
    ),
  );
}

Widget _buildChatArea(BuildContext context) {
  final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: ListView.builder(
      shrinkWrap: true, // Memastikan ListView bisa cocok di dalam widget lain
      physics: const BouncingScrollPhysics(), // Untuk scrolling yang halus
      itemCount: 3, // Contoh jumlah pesan
      itemBuilder: (context, index) {
        bool isUserMessage =
            index % 2 == 1; // Pesan dari user jika index ganjil
        String timeStamp = '10:${index % 60} AM'; // Format waktu pesan

        // Contoh tanggal pesan
        DateTime messageDate =
            DateTime.now().subtract(Duration(days: index ~/ 2));
        String formattedDate =
            "${messageDate.day} ${_getMonthName(messageDate.month)} ${messageDate.year}";

        // Cek apakah ini adalah pesan pertama untuk tanggal tersebut
        bool showDateDivider = index == 0 ||
            (index > 0 &&
                (messageDate.day !=
                    DateTime.now()
                        .subtract(Duration(days: (index - 1) ~/ 2))
                        .day));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDateDivider)
              Row(
                children: [
                  const Expanded(child: Divider()), // Garis pemisah di kiri
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 163, 160, 160),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()), // Garis pemisah di kanan
                ],
              ),
            Row(
              mainAxisAlignment: isUserMessage
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUserMessage)
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        AssetImage('assets/images/dokter.png'), // Ganti path
                    backgroundColor: Colors.grey,
                  ),

                // Bubble chat
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  padding: const EdgeInsets.all(10),
                  width: isSmallScreen
                      ? MediaQuery.of(context).size.width * 0.5
                      : 400,
                  decoration: BoxDecoration(
                    color: isUserMessage
                        ? Colors.green.shade50
                        : Colors.blue.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomLeft: isUserMessage
                          ? const Radius.circular(10)
                          : Radius.zero,
                      bottomRight: isUserMessage
                          ? Radius.zero
                          : const Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        timeStamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                if (isUserMessage)
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        AssetImage('assets/images/healthy_food.png'),
                    backgroundColor: Colors.grey,
                  ),
              ],
            ),
          ],
        );
      },
    ),
  );
}

// Fungsi untuk mendapatkan nama bulan berdasarkan angka
String _getMonthName(int month) {
  const monthNames = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  return monthNames[month];
}

Widget _buildMessageInput(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: Colors.white,
    child: Row(
      children: [
        // Expanded widget agar field bisa menyesuaikan ukuran
        Expanded(
          child: Row(
            children: [
              // Ikon file
              IconButton(
                icon: const Icon(Icons.attach_file, color: Colors.blue),
                onPressed: () {
                  // Logika untuk meng-upload file
                },
                padding: EdgeInsets.zero, // Menghilangkan padding default
              ),
              // Ikon emoji
              IconButton(
                icon: const Icon(Icons.emoji_emotions, color: Colors.blue),
                onPressed: () {
                  // Logika untuk membuka emoji
                },
                padding: EdgeInsets.zero, // Menghilangkan padding default
              ),
              // TextField untuk mengetik pesan
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'write a message', // Mengubah hint text
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Tombol kirim
        IconButton(
          icon: const Icon(Icons.send, color: Colors.blue),
          onPressed: () {
            // Logika kirim pesan
          },
        ),
      ],
    ),
  );
}

class User {
  final String name;
  final String specialization;
  final String profileImage; // Path ke gambar profil

  User({
    required this.name,
    required this.specialization,
    required this.profileImage,
  });
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int? selectedIndex; // Menyimpan indeks item yang dipilih
  // Definisikan daftar pengguna di sini
  final List<User> users = [
    User(
      name: 'Dr. Jacob Jones',
      specialization: 'Spesialis Ortopedi',
      profileImage: 'assets/images/obesitas.png', // Ganti dengan path gambar
    ),
    User(
      name: 'Dr. Dwi Hariyanti',
      specialization: 'Spesialis Gizi',
      profileImage: 'assets/images/dokter.png', // Ganti dengan path gambar
    ),
    User(
      name: 'Dr. Eleanor Pena',
      specialization: 'Spesialis Fisioterapi',
      profileImage: 'assets/images/consul_food.jpg', // Ganti dengan path gambar
    ),
    // Tambahkan pengguna lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChatList(),
      // child: Text('tes'),
    );
  }

  Widget _buildChatList() {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    // Cek apakah users memiliki data
    if (users.isEmpty) {
      return Center(child: Text('No users found.'));
    }

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Chat',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(165, 206, 255, 1),
                    borderRadius: BorderRadius.circular(12)),
                child: const Text('2 New',
                    style: TextStyle(fontSize: 10, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
            ),
            style: TextStyle(color: Colors.black),
            onChanged: (value) {},
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSmallScreen) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreenOverlay()));
                          } else {
                            selectedIndex = index;
                          }
                        });
                      },
                      child: Container(
                        color: selectedIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  backgroundImage:
                                      AssetImage(user.profileImage)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: selectedIndex == index
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    152, 155, 161, 1))),
                                    const SizedBox(height: 4),
                                    Text(user.specialization,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: selectedIndex == index
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    152, 155, 161, 1))),
                                    const SizedBox(height: 8),
                                    Text('Lorem ipsum dolor sit amet.',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: selectedIndex == index
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    152, 155, 161, 1)),
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              Text('5m',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Color.fromRGBO(152, 155, 161, 1))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (index < users.length - 1) Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Overlay ChatScreen for small screens
class ChatScreenOverlay extends StatelessWidget {
  const ChatScreenOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: const Color(0xFF222B33),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChatHeader(),
            _buildChatArea(context),
            _buildMessageInput(context),
          ],
        ),
      ),
      // Tampilkan layar chat di overlay ini
    );
  }
}
