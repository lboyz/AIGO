import 'package:aigo/dashboard/activity.dart';
import 'package:aigo/dashboard/chat.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/analytics.dart';
import 'package:aigo/dashboard/consultation.dart';
import 'Schedule.dart';
import 'dart:math';
import 'recomendation.dart';
import 'setting.dart';

void main() {
  runApp(const AigoDashboard());
}

class AigoDashboard extends StatelessWidget {
  const AigoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
              child: mainContent(context),
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
              onPressed: () {},
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

// Main content
Widget mainContent(BuildContext context) {
  // Mendapatkan ukuran layar
  final isMobile = MediaQuery.of(context).size.width < 600;

  return SingleChildScrollView(
    child: Column(
      children: [
        if (isMobile) ...[
          AspectRatio(
            aspectRatio: 1, // Menjaga proporsi persegi untuk BMI widget
            child: BMIWidget(bmi: 25.9, bmiCategory: 'Overweight'),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.00001),
          AspectRatio(
            aspectRatio: 4,
            child: StatsWidget(weight: "75", height: "170", age: "21"),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          AspectRatio(
            aspectRatio: 3,
            child: ActivityStat(
              label: 'Calories',
              value: "2.500",
              unit: ' Cal',
              img: "calories.png",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          AspectRatio(
            aspectRatio: 3,
            child: ActivityStat(
              label: 'Running Distance',
              value: "5",
              unit: ' km',
              img: "running.png",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          AspectRatio(
            aspectRatio: 3,
            child: ActivityStat(
              label: 'Sleep Time',
              value: "8",
              unit: ' hours',
              img: "sleep.png",
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildActivityChart(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildSectionTitle('My Schedule', () {}),
          AspectRatio(
            aspectRatio: 3,
            child: ScheduleItem(
              day: 'Monday',
              activity: 'Stretch',
              time: 'At 08:00',
              count: '20 Pieces',
              imageAssetPath: 'assets/images/stretch.png',
            ),
          ),
          AspectRatio(
            aspectRatio: 3,
            child: ScheduleItem(
              day: 'Tuesday',
              activity: 'Back Stretch',
              time: 'At 08:00',
              count: '10 Rounds',
              imageAssetPath: 'assets/images/stretch.png',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildSectionTitle('Goals', () {}),
          AspectRatio(
            aspectRatio: 5,
            child: GoalItem(
              label: 'Running on Track',
              date: 'Saturday, April 14 08:00 AM',
              rounds: '04 Rounds',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          AspectRatio(
            aspectRatio: 5,
            child: GoalItem(
              label: 'Push Up',
              date: 'Sunday, April 15 08:00 AM',
              rounds: '50 Pieces',
            ),
          ),
        ] else ...[
          // Kolom ganda untuk perangkat desktop
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom kiri
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BMIWidget(bmi: 25.9, bmiCategory: 'Overweight'),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    StatsWidget(weight: "75", height: "170", age: "21"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _buildActivityStats(context),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              // Kolom kanan
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _buildActivityChart(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _buildScheduleAndGoals(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _buildActivityStats(BuildContext context) {
  return Column(
    children: [
      ActivityStat(
        label: 'Calories',
        value: "2.500",
        unit: ' Cal',
        img: "calories.png",
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ActivityStat(
        label: 'Running Distance',
        value: "5",
        unit: ' km',
        img: "running.png",
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ActivityStat(
        label: 'Sleep Time',
        value: "8",
        unit: ' hours',
        img: "sleep.png",
      ),
    ],
  );
}

Widget _buildActivityChart(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.001),
    height: MediaQuery.of(context).size.height * 0.55, // Responsive height
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10.0,
          spreadRadius: 5.0,
        ),
      ],
    ),
    child: ActivityChart(
      label: 'Acticity',
      value: 'percentage',
    ),
  );
}

Widget _buildScheduleAndGoals(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: MediaQuery.of(context).size.width * 0.001),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('My Schedule', () {}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ScheduleItem(
              day: 'Monday',
              activity: 'Stretch',
              time: 'At 08:00',
              count: '20 Pieces',
              imageAssetPath: 'assets/images/stretch.png',
            ),
            ScheduleItem(
              day: 'Tuesday',
              activity: 'Back Stretch',
              time: 'At 08:00',
              count: '10 Rounds',
              imageAssetPath: 'assets/images/stretch.png',
            ),
          ],
        ),
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Goals', () {}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            GoalItem(
              label: 'Running on Track',
              date: 'Saturday, April 14 08:00 AM',
              rounds: '04 Rounds',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            GoalItem(
              label: 'Push Up',
              date: 'Sunday, April 15 08:00 AM',
              rounds: '50 Pieces',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildSectionTitle(String title, VoidCallback onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      TextButton(
        onPressed: onPressed,
        child: const Text('View All', style: TextStyle(color: Colors.blue)),
      ),
    ],
  );
}

// Sidebar Button Widget
class SidebarButton extends StatefulWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const SidebarButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  _SidebarButtonState createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  late Color labelColor;
  late Color iconColor;

  @override
  void initState() {
    super.initState();
    // Set warna berdasarkan status aktif
    labelColor = widget.isActive ? Colors.blue : Colors.grey;
    iconColor = widget.isActive ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(widget.icon, color: iconColor),
          const SizedBox(width: 10),
          Text(
            widget.label,
            style: TextStyle(color: labelColor),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 12),
            onPressed: widget.onPressed,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

// BMI Widget
class BMIWidget extends StatelessWidget {
  final double bmi;
  final String bmiCategory;

  const BMIWidget({
    super.key,
    required this.bmi,
    required this.bmiCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          // vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
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
        maxHeight: MediaQuery.of(context).size.height * 0.4, // Maximum height
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Mendapatkan ukuran container
          final containerWidth = constraints.maxWidth;
          final containerHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: containerWidth * 0.5, // Menggunakan ukuran container
                    height: containerHeight * 0.5, // Menjaga proporsi persegi
                    child: CircularProgressIndicator(
                      value: bmi / 40,
                      strokeWidth: 6,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.orange),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: containerWidth *
                          0.1, // Responsif terhadap ukuran container
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'BMI = ${bmi.toStringAsFixed(1)} kg/m²',
                style: TextStyle(
                  fontSize: containerWidth *
                      0.08, // Responsif terhadap ukuran container
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                bmiCategory,
                style: TextStyle(
                  fontSize: containerWidth *
                      0.07, // Responsif terhadap ukuran container
                  color: Color.fromARGB(255, 231, 208, 0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StatsWidget extends StatelessWidget {
  final String weight;
  final String height;
  final String age;

  const StatsWidget({
    super.key,
    required this.weight,
    required this.height,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      width: MediaQuery.of(context).size.width * 0.4, // Responsive width
      height: MediaQuery.of(context).size.height * 0.1, // Responsive height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Mendapatkan ukuran container
          final containerWidth = constraints.maxWidth;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("Weight", weight, "kg", containerWidth, context),
              _buildStatItem("Height", height, "cm", containerWidth, context),
              _buildStatItem("Age", age, "yrs", containerWidth, context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit,
      double containerWidth, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          CrossAxisAlignment.start, // Mengubah alignment agar lebih rata
      children: [
        // Row untuk menampilkan value dan unit bersebelahan
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Untuk memastikan di tengah
          crossAxisAlignment: CrossAxisAlignment
              .baseline, // Untuk menyelaraskan secara vertikal
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
            fontSize: containerWidth * 0.04, // Ukuran font responsif
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

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
          // vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02), // Responsif
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.12,
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
                  width: containerWidth * 0.2, // Responsif
                  height: containerWidth * 0.2, // Responsif
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

// Schedule Item Widget
class ScheduleItem extends StatelessWidget {
  final String day;
  final String activity;
  final String time;
  final String count;
  final String imageAssetPath;

  const ScheduleItem({
    super.key,
    required this.day,
    required this.activity,
    required this.time,
    required this.count,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                day,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
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

// Goal Item Widget
class GoalItem extends StatelessWidget {
  final String label;
  final String date;
  final String rounds;

  const GoalItem({
    super.key,
    required this.label,
    required this.date,
    required this.rounds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height * 0.11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.black)),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text(rounds, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ActivityChart extends StatefulWidget {
  final String label;
  final String value;

  const ActivityChart({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  _ActivityChartState createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  int? touchedIndex;
  final Random random = Random();

  // List untuk menyimpan nilai acak
  late List<int> randomValues;

  @override
  void initState() {
    super.initState();
    // Periksa apakah nilai adalah 'percentage' atau bukan
    if (widget.value == 'percentage') {
      // Jika persentase, buat nilai acak antara 10 dan 100 persen
      randomValues = List.generate(7, (_) => random.nextInt(91) + 10);
    } else {
      // Jika bukan persentase, buat nilai acak antara 30 dan 150
      randomValues = List.generate(7, (_) => random.nextInt(121) + 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String day;
                    switch (group.x.toInt()) {
                      case 0:
                        day = 'Monday';
                        break;
                      case 1:
                        day = 'Tuesday';
                        break;
                      case 2:
                        day = 'Wednesday';
                        break;
                      case 3:
                        day = 'Thursday';
                        break;
                      case 4:
                        day = 'Friday';
                        break;
                      case 5:
                        day = 'Saturday';
                        break;
                      case 6:
                        day = 'Sunday';
                        break;
                      default:
                        day = '';
                    }

                    // Cek apakah nilai adalah 'percentage' dan tampilkan sesuai
                    return BarTooltipItem(
                      '$day\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.value == 'percentage'
                              ? '${rod.toY.toInt()}%' // Jika persentase, tampilkan dengan simbol %
                              : '${rod.toY.toInt()}', // Jika bukan persentase, tampilkan angka saja
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text('Mon');
                        case 1:
                          return const Text('Tue');
                        case 2:
                          return const Text('Wed');
                        case 3:
                          return const Text('Thu');
                        case 4:
                          return const Text('Fri');
                        case 5:
                          return const Text('Sat');
                        case 6:
                          return const Text('Sun');
                        default:
                          return const Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 40,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: List.generate(7, (i) {
                final isTouched = i == touchedIndex;
                final double toY = randomValues[i].toDouble();
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: toY,
                      color: isTouched ? Colors.blue : Colors.blueGrey.shade100,
                      width: 40,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
              gridData: FlGridData(show: false),
              maxY: widget.value == 'percentage'
                  ? 150
                  : 200, // Tentukan maxY berdasarkan 'value'
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: DropdownButton<String>(
              value: 'Weekly',
              items: <String>['Weekly', 'Monthly', 'Yearly']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle dropdown value change
              },
              underline: Container(),
              style: const TextStyle(color: Colors.black),
              dropdownColor: Colors.blueGrey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
