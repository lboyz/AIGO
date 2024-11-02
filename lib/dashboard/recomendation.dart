import 'package:aigo/dashboard/chat.dart';
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
  runApp(const RecomendationDashboard());
}

class RecomendationDashboard extends StatelessWidget {
  const RecomendationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recomendation',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Recomendation(),
    );
  }
}

class Recomendation extends StatelessWidget {
  const Recomendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

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
                        Container(
                          margin: const EdgeInsets.only(right: 1.0, left: 1.0),
                          padding: const EdgeInsets.all(1.0),
                          child: Expanded(child: RecomendationTable()),
                        )
                      ])),
                )
              : Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSidebar(context),
                      // SizedBox(width: 10,),
                      Container(
                        // padding: const EdgeInsets.all(30.0),
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
                            Expanded(child: RecomendationTable()),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
      drawer: _buildSidebar(context),
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
              isActive: true,
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

class RecomendationTable extends StatelessWidget {
  const RecomendationTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  // Fungsi _buildDataTable sekarang mengembalikan DataTable
  Widget _buildDataTable(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.5;

    // Define the button width based on the device type
    final double buttonWidth = width < 600 ? width * 0.35 : width * 0.09;
    return DataTable(
      columnSpacing: defaultPadding,
      columns: [
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                "Nama Dokter",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                "Jenis Konsultasi",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                "Jadwal",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                "Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.swap_vert_sharp),
                onPressed: () {},
              ),
            ],
          ),
        ),
        DataColumn(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Action",
                style: TextStyle(fontWeight: FontWeight.bold),
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
              return Colors.grey.shade100; // Warna abu-abu untuk baris ganjil
            },
          ),
          cells: [
            DataCell(Text("10/05/2024")),
            DataCell(Text("Dr. Dwi Hariyanti")),
            DataCell(Text("Online")),
            DataCell(Text("19.00 WIB")),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 252, 217, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Pending",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: buttonWidth, // Responsive button width
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(55, 179, 183, 1),
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.015,
                    ),
                  ),
                  child: const Text(
                    'Download Invoice',
                    style: TextStyle(
                      color: Color.fromRGBO(55, 179, 183, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.white; // Warna putih untuk baris genap
            },
          ),
          cells: [
            DataCell(Text("05/05/2024")),
            DataCell(Text("Dr. Dwi Hariyanti")),
            DataCell(Text("Online")),
            DataCell(Text("19.00 WIB")),
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: buttonWidth, // Responsive button width
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(55, 179, 183, 1),
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.015,
                    ),
                  ),
                  child: const Text(
                    'Download Invoice',
                    style: TextStyle(
                      color: Color.fromRGBO(55, 179, 183, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.grey.shade100; // Warna abu-abu untuk baris ganjil
            },
          ),
          cells: [
            DataCell(Text("28/04/2024")),
            DataCell(Text("Dr. Dwi Hariyanti")),
            DataCell(Text("Online")),
            DataCell(Text("19.00 WIB")),
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
            DataCell(
              SizedBox(
                width: buttonWidth, // Responsive button width
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(55, 179, 183, 1),
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.015,
                    ),
                  ),
                  child: const Text(
                    'Download Invoice',
                    style: TextStyle(
                      color: Color.fromRGBO(55, 179, 183, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.white; // Warna putih untuk baris genap
            },
          ),
          cells: [
            DataCell(Text("28/04/2024")),
            DataCell(Text("Dr. Dwi Hariyanti")),
            DataCell(Text("Online")),
            DataCell(Text("19.00 WIB")),
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
            DataCell(
              SizedBox(
                width: buttonWidth, // Responsive button width
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(55, 179, 183, 1),
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.015,
                    ),
                  ),
                  child: const Text(
                    'Download Invoice',
                    style: TextStyle(
                      color: Color.fromRGBO(55, 179, 183, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
