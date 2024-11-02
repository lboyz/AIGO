import 'package:aigo/dashboard/chat.dart';
import 'package:aigo/dashboard/recomendation.dart';
import 'package:aigo/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'package:aigo/dashboard/analytics.dart';
import 'package:aigo/dashboard/consultation.dart';
import 'schedule.dart';

// import 'package:video_player/video_player.dart';

void main() {
  runApp(const ActivityDashboard());
}

class ActivityDashboard extends StatelessWidget {
  const ActivityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Activity(),
    );
  }
}

class Activity extends StatelessWidget {
  const Activity({super.key});

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
              child: _buildMainContent(context),
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

// Main Content Section
Widget _buildMainContent(BuildContext context) {
  // Mendapatkan ukuran layar
  final isMobile = MediaQuery.of(context).size.width < 600;

  return SingleChildScrollView(
    child: Column(
      children: [
        if (isMobile) ...[
          Row(
            children: [
              Expanded(
                child: _buildActivityStats(
                    context, 'Sleep Time', '8', 'hours', 'sleep.png'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildActivityStats(context, 'Running Distance', '5',
                    'Kilometer', 'running.png'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildActivityStats(
                    context, 'Calories', '2.500', 'Cal', 'calories.png'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.01), // Responsif
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),

                  // Ubah Row menjadi Column
                  child: Column(
                    children: [
                      _buildScheduleItems(
                          context), // Tampilkan _scheduleItems di atas
                      SizedBox(height: 10), // Beri jarak
                      Divider(),
                      SizedBox(height: 10), // Beri jarak
                      Container(
                        height: MediaQuery.of(context).size.width * 0.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/video-player.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: RecentFiles(),
              ),
            ],
          ),
        ] else ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      // height: 100, // Sesuaikan tinggi sesuai kebutuhan
                      child: _buildActivityStats(
                          context, 'Sleep Time', '8', 'hours', 'sleep.png'),
                    ),
                  ),
                  // SizedBox(width: 5),
                  Expanded(
                    child: SizedBox(
                      // height: 100, // Sesuaikan tinggi sesuai kebutuhan
                      child: _buildActivityStats(context, 'Running Distance',
                          '5', 'Kilometer', 'running.png'),
                    ),
                  ),
                  // SizedBox(width: 5),
                  Expanded(
                    child: SizedBox(
                      // height: 100, // Sesuaikan tinggi sesuai kebutuhan
                      child: _buildActivityStats(
                          context, 'Calories', '2.500', 'Cal', 'calories.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(
                          // vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.width *
                              0.01), // Responsif
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          // SizedBox(width: 7),
                          Expanded(
                              // flex: 15,
                              child: _buildScheduleItems(context)),
                          // Expanded(
                          // flex: 1,
                          // child:
                          Container(
                            margin:
                                EdgeInsetsDirectional.only(start: 30, end: 20),
                            width: 1, // Lebar garis pemisah
                            height: MediaQuery.of(context).size.height *
                                0.3, // Sesuaikan tinggi dengan elemen lain
                            color: const Color.fromARGB(
                                255, 189, 183, 183), // Warna garis pemisah
                          ),
                          // ),
                          Expanded(
                            // flex: 15,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.18,
                              // width: MediaQuery.of(context).size.width * 0.048,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/video-player.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RecentFiles(),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _buildActivityStats(
    BuildContext context, String label, String value, String unit, String img) {
  return ActivityStat(
    label: label,
    value: value,
    unit: unit,
    img: img,
  );
}

Widget _buildScheduleItems(BuildContext context) {
  return Column(
    // Use Column to stack items vertically
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Top margin

      ScheduleItem(
        activity: 'Stretch',
        time: 'At 08:00',
        count: '20 Pieces',
        imageAssetPath: 'assets/images/stretch.png',
      ),

      SizedBox(height: 10), // Add space between the items

      ScheduleItem(
        activity: 'Back Stretch',
        time: 'At 08:00',
        count: '10 Rounds',
        imageAssetPath: 'assets/images/stretch.png',
      ),
      SizedBox(height: 10),
      ScheduleItem(
        activity: 'Back Stretch',
        time: 'At 08:00',
        count: '10 Rounds',
        imageAssetPath: 'assets/images/stretch.png',
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Top margin
    ],
  );
}

// Acticity Stat
class ActivityStat extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String img;

  const ActivityStat({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          //     // vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.01), // Responsif
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth;

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/$img",
                  width: containerWidth * 0.15, // Responsif
                  height: containerWidth * 0.15, // Responsif
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildStatItem(label, value, unit, containerWidth)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, String unit, double containerWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Row untuk menampilkan value dan unit bersebelahan
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Untuk memastikan di tengah
          crossAxisAlignment:
              CrossAxisAlignment.baseline, // Menyelaraskan secara vertikal
          textBaseline: TextBaseline
              .alphabetic, // Menyelaraskan berdasarkan baseline teks
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: containerWidth * 0.08, // Ukuran font responsif
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
                width:
                    containerWidth * 0.02), // Spasi kecil antara value dan unit
            Text(
              unit,
              style: TextStyle(
                fontSize: containerWidth * 0.05, // Ukuran font responsif
                color: Colors.grey, // Warna unit lebih terang
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: containerWidth * 0.07, // Ukuran font responsif
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String activity;
  final String time;
  final String count;
  final String imageAssetPath;

  const ScheduleItem({
    super.key,
    required this.activity,
    required this.time,
    required this.count,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Menyelaraskan secara vertikal
        children: [
          // Image section
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imageAssetPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment
                  .center, // Menyelaraskan secara vertikal di dalam kolom
              children: [
                Text(
                  activity,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          // Count section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // Sesuaikan warna latar belakang
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

// vidio player jika perlu
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({super.key, required this.videoUrl});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(
//       Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//       ),
//     );
//     _controller.initialize().then((_) {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: VideoPlayer(_controller),
//     );
//   }
// }

const double defaultPadding = 16.0;
const Color secondaryColor =
    Colors.white; // Misalkan ini warna sekunder yang Anda inginkan

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "History",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            width: double.infinity,
            child: isSmallScreen
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildDataTable(context),
                  )
                : _buildDataTable(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(BuildContext contaxt) {
    return DataTable(
      columnSpacing: defaultPadding,
      columns: [
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {
                  // Logika sorting untuk descending
                },
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Olahraga",
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {
                  // Logika sorting untuk descending
                },
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jarak",
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {
                  // Logika sorting untuk descending
                },
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Durasi",
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {
                  // Logika sorting untuk descending
                },
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target",
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
      rows: [
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.grey.shade100;
            },
          ),
          cells: [
            DataCell(Text("13/05/2024")),
            DataCell(Text("Joging")),
            DataCell(Text("3 Km")),
            DataCell(Text("01.30.00")),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Success",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.white;
            },
          ),
          cells: [
            DataCell(Text("22/05/2024")),
            DataCell(Text("Stretch")),
            DataCell(Text("-")),
            DataCell(Text("00.15.00")),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Success",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.grey.shade100;
            },
          ),
          cells: [
            DataCell(Text("15/06/2024")),
            DataCell(Text("Back Stretch")),
            DataCell(Text("-")),
            DataCell(Text("00.15.00")),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Process",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
