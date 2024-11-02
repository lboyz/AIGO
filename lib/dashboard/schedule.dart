import 'package:aigo/dashboard/chat.dart';
import 'package:aigo/dashboard/recomendation.dart';
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
  runApp(const ScheduleDashboard());
}

class ScheduleDashboard extends StatelessWidget {
  const ScheduleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Schedule(),
    );
  }
}

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

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
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Jadwal',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const DateList(),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: const Text(
                                  '1.30s',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(132, 132, 132, 1),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 10, end: 10),
                                width: 2, // Lebar garis pemisah
                                height: MediaQuery.of(context).size.height *
                                    0.09, // Sesuaikan tinggi dengan elemen lain
                                color: const Color.fromARGB(
                                    255, 189, 183, 183), // Warna garis pemisah
                              ),
                              Expanded(
                                flex: 12,
                                child: ScheduleActivity(
                                  activity: 'Konsultasi - Dr. Dwi Hariyanti',
                                  value: '15.45',
                                  status: 'pending',
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: const Text(
                                  '1.30s',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(132, 132, 132, 1),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 10, end: 10),
                                width: 2, // Lebar garis pemisah
                                height: MediaQuery.of(context).size.height *
                                    0.09, // Sesuaikan tinggi dengan elemen lain
                                color: const Color.fromARGB(
                                    255, 189, 183, 183), // Warna garis pemisah
                              ),
                              Expanded(
                                flex: 12,
                                child: ScheduleActivity(
                                  activity: 'Joging',
                                  value: '3 Km',
                                  status: 'sukses',
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: const Text(
                                  '1.30s',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(132, 132, 132, 1),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 10, end: 10),
                                width: 2, // Lebar garis pemisah
                                height: MediaQuery.of(context).size.height *
                                    0.09, // Sesuaikan tinggi dengan elemen lain
                                color: const Color.fromARGB(
                                    255, 189, 183, 183), // Warna garis pemisah
                              ),
                              Expanded(
                                flex: 12,
                                child: ScheduleActivity(
                                  activity: 'Joging',
                                  value: '3 Km',
                                  status: 'sukses',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 1.0, left: 1.0),
                          padding: const EdgeInsets.all(1.0),
                          child: Expanded(child: ScheduleTable()),
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
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Jadwal',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const DateList(),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 24.0, left: 24.0),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: const Text(
                                      '1.30s',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(132, 132, 132, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                        start: 10, end: 30),
                                    width: 2, // Lebar garis pemisah
                                    height: MediaQuery.of(context).size.height *
                                        0.07, // Sesuaikan tinggi dengan elemen lain
                                    color: const Color.fromARGB(255, 189, 183,
                                        183), // Warna garis pemisah
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: ScheduleActivity(
                                      activity:
                                          'Konsultasi - Dr. Dwi Hariyanti',
                                      value: '15.45',
                                      status: 'pending',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 24.0, left: 24.0),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: const Text(
                                      '1.30s',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(132, 132, 132, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                        start: 10, end: 30),
                                    width: 2, // Lebar garis pemisah
                                    height: MediaQuery.of(context).size.height *
                                        0.07, // Sesuaikan tinggi dengan elemen lain
                                    color: const Color.fromARGB(255, 189, 183,
                                        183), // Warna garis pemisah
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: ScheduleActivity(
                                      activity: 'Joging',
                                      value: '3 Km',
                                      status: 'sukses',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 24.0, left: 24.0),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: const Text(
                                      '1.30s',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(132, 132, 132, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                        start: 10, end: 30),
                                    width: 2, // Lebar garis pemisah
                                    height: MediaQuery.of(context).size.height *
                                        0.07, // Sesuaikan tinggi dengan elemen lain
                                    color: const Color.fromARGB(255, 189, 183,
                                        183), // Warna garis pemisah
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: ScheduleActivity(
                                      activity: 'Joging',
                                      value: '3 Km',
                                      status: 'sukses',
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Expanded(child: ScheduleTable()),

                            // Expanded(
                            //   child: Center(child: _FormContent()),
                            // ),
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
              onPressed: () {},
              isActive: true,
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

// Daftar hari dan tanggal
class DateList extends StatefulWidget {
  const DateList({Key? key}) : super(key: key);

  @override
  _DateListState createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  int? selectedIndex; // Menyimpan indeks elemen yang diklik

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dates = [
      {"day": "Sen", "date": "7"},
      {"day": "Sel", "date": "8"},
      {"day": "Rab", "date": "9"},
      {"day": "Kam", "date": "10"},
      {"day": "Jum", "date": "11"},
      {"day": "Sab", "date": "12"},
      {"day": "Min", "date": "13"},
      {"day": "Sen", "date": "14"},
      {"day": "Sel", "date": "15"},
      {"day": "Rab", "date": "16"},
      {"day": "Kam", "date": "17"},
      {"day": "Jum", "date": "18"},
      {"day": "Sab", "date": "19"},
      {"day": "Min", "date": "20"},
      {"day": "Sen", "date": "21"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: dates.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> value = entry.value;
            bool isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index; // Mengubah elemen yang diklik
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 13.0, left: 13.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromRGBO(59, 97, 147, 1)
                      : Colors.transparent, // Mengubah warna background
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      value['day']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : const Color.fromRGBO(55, 179, 183, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      value['date']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color.fromRGBO(55, 179, 183, 1),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ScheduleActivity extends StatelessWidget {
  final String activity;
  final String value;
  final String status;

  const ScheduleActivity({
    super.key,
    required this.activity,
    required this.value,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ikon berdasarkan status
    IconData getStatusIcon() {
      if (status == "pending") {
        return Icons.schedule_rounded; // Ikon untuk status pending
      } else if (status == "sukses") {
        return Icons.done; // Ikon untuk status sukses
      } else {
        return Icons.help_outline; // Ikon default jika status tidak dikenali
      }
    }

    // Mendapatkan warna berdasarkan status
    Color getStatusColor() {
      if (status == "pending") {
        return Colors.orange; // Warna ikon untuk pending
      } else if (status == "sukses") {
        return Colors.green; // Warna ikon untuk sukses
      } else {
        return Colors.grey; // Warna default jika status tidak dikenali
      }
    }

    // Mendapatkan warna latar belakang berdasarkan status
    Color getBackgroundColor() {
      if (status == "pending") {
        return const Color.fromRGBO(
            255, 252, 217, 1); // Warna background pending
      } else if (status == "sukses") {
        return const Color.fromRGBO(
            209, 250, 223, 1); // Warna background sukses
      } else {
        return Colors.white; // Default jika status tidak dikenali
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: getBackgroundColor(), // Warna background container utama
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Menyelaraskan secara vertikal
        children: [
          // Bagian teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment
                  .center, // Menyelaraskan secara vertikal di dalam kolom
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Color.fromRGBO(132, 132, 132, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  activity,
                  style: const TextStyle(
                    color: Color.fromRGBO(132, 132, 132, 1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          // Bagian ikon status
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getStatusColor(), // Warna background container ikon
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              getStatusIcon(),
              color: Colors.white, // Warna ikon selalu putih untuk kontras
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleTable extends StatelessWidget {
  const ScheduleTable({
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
          ],
        ),
      ],
    );
  }
}
