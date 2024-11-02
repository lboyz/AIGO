import 'package:aigo/dashboard/chat.dart';
import 'package:aigo/dashboard/recomendation.dart';
import 'package:aigo/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'package:aigo/dashboard/activity.dart';
import 'package:aigo/dashboard/consultation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'schedule.dart';

void main() {
  runApp(const AnalyticsDashboard());
}

class AnalyticsDashboard extends StatelessWidget {
  const AnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analytics',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const Analytics(),
    );
  }
}

class Analytics extends StatelessWidget {
  const Analytics({super.key});

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
                child: _buildInfoCard(
                    context, 'Sleep Time', '8', 'hours', 'sleep.png'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(context, 'Running Distance', '5',
                    'Kilometer', 'running.png'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                    context, 'Calories', '2.500', 'Cal', 'calories.png'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1, // Menjaga proporsi persegi untuk BMI widget
                child: BMIWidget(bmi: 25.9, bmiCategory: 'Overweight'),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.00001),
              AspectRatio(
                aspectRatio: 4,
                child: StatsWidget(weight: "75", height: "170", age: "21"),
              ),
              SizedBox(height: 10),
              _buildActivityChart(context, 'Activity Recap', 'percentage'),
              SizedBox(height: 10),
              _buildMapActivity(context),
              SizedBox(height: 10),
              _buildActivityChart(context, 'Calory Burn', 'calory'),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
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
                child: Column(children: [
                  AspectRatio(
                    aspectRatio: 2,
                    child: SizedBox(
                      child: _buildRunningMaps(
                          context,
                          'November 26',
                          '10,12 km',
                          '701 kcal  11,2 km/hr',
                          'runningMaps.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(),
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: SizedBox(
                      child: _buildRunningMaps(
                          context,
                          'November 26',
                          '10,12 km',
                          '701 kcal  11,2 km/hr',
                          'runningMaps.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(),
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: SizedBox(
                      child: _buildRunningMaps(
                          context,
                          'November 26',
                          '10,12 km',
                          '701 kcal  11,2 km/hr',
                          'runningMaps.jpg'),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              _buildWaterTracker(context),
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
                      child: _buildInfoCard(
                          context, 'Sleep Time', '8', 'hours', 'sleep.png'),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: _buildInfoCard(context, 'Running Distance', '5',
                          'Kilometer', 'running.png'),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: _buildInfoCard(
                          context, 'Calories', '2.500', 'Cal', 'calories.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BMIWidget(bmi: 25.9, bmiCategory: 'Overweight'),
                        StatsWidget(weight: "75", height: "170", age: "21"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: _buildActivityChart(
                        context, 'Activity Recap', 'percentage'),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: _buildMapActivity(context),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:
                        _buildActivityChart(context, 'Calory Burn', 'calory'),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.01),
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
                        child: Column(children: [
                          SizedBox(
                            child: _buildRunningMaps(
                                context,
                                'November 26',
                                '10,12 km',
                                '701 kcal  11,2 km/hr',
                                'runningMaps.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(),
                          ),
                          SizedBox(
                            child: _buildRunningMaps(
                                context,
                                'November 26',
                                '10,12 km',
                                '701 kcal  11,2 km/hr',
                                'runningMaps.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(),
                          ),
                          SizedBox(
                            child: _buildRunningMaps(
                                context,
                                'November 26',
                                '10,12 km',
                                '701 kcal  11,2 km/hr',
                                'runningMaps.jpg'),
                          ),
                        ]),
                      )),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: _buildWaterTracker(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

Widget _buildInfoCard(
    BuildContext context, String label, String value, String unit, String img) {
  return ActivityStat(
    label: label,
    value: value,
    unit: unit,
    img: img,
  );
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
          // vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.01),
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
      width: MediaQuery.of(context).size.width * 0.35, // Responsive width
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
                    width:
                        containerWidth * 0.35, // Menggunakan ukuran container
                    height: containerHeight * 0.4, // Menjaga proporsi persegi
                    child: CircularProgressIndicator(
                      value: bmi / 40,
                      strokeWidth: 10,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.orange),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: containerWidth *
                          0.075, // Responsif terhadap ukuran container
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
                      0.065, // Responsif terhadap ukuran container
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                bmiCategory,
                style: TextStyle(
                  fontSize: containerWidth *
                      0.055, // Responsif terhadap ukuran container
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
          horizontal: MediaQuery.of(context).size.width * 0.01),
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

Widget _buildActivityChart(BuildContext context, String label, String value) {
  // Hitung tinggi untuk BMIWidget dan StatsWidget
  double bmiWidgetHeight =
      MediaQuery.of(context).size.height * 0.4; // Tinggi BMIWidget
  double statsWidgetHeight =
      MediaQuery.of(context).size.height * 0.1; // Tinggi StatsWidget

  // Hitung margin vertikal yang memisahkan BMIWidget dan StatsWidget
  double verticalMargin = MediaQuery.of(context).size.height *
      0.01; // Sesuai dengan margin di StatsWidget

  // Jumlahkan tinggi BMIWidget, StatsWidget, dan margin vertikal untuk tinggi _buildActivityChart
  double totalHeight = bmiWidgetHeight + statsWidgetHeight + verticalMargin;

  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01),
    height: totalHeight, // Sesuaikan tinggi dengan hasil penjumlahan
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
      label: label,
      value: value,
    ),
  );
}

// Widget untuk Map Activity
Widget _buildMapActivity(BuildContext context) {
  // Calculate height for BMIWidget and StatsWidget
  double bmiWidgetHeight =
      MediaQuery.of(context).size.height * 0.4; // Height for BMIWidget
  double statsWidgetHeight =
      MediaQuery.of(context).size.height * 0.1; // Height for StatsWidget

  // Calculate vertical margin between BMIWidget and StatsWidget
  double verticalMargin =
      MediaQuery.of(context).size.height * 0.01; // Margin for StatsWidget

  // Total height calculation for the activity chart
  double totalHeight = bmiWidgetHeight + statsWidgetHeight + verticalMargin;

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.01,
      vertical: MediaQuery.of(context).size.height * 0.01,
    ),
    height: totalHeight,
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
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0), // Optional padding
          child: Chart(label: '49.05', unit: 'Kcal'),
        ),
        SizedBox(height: verticalMargin),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MapActivityItem(
                      label: 'Carbo',
                      value: '10',
                      unit: 'g',
                      colorBar: Colors.red,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MapActivityItem(
                      label: 'Protein',
                      value: '20',
                      unit: 'g',
                      colorBar: Colors.green,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MapActivityItem(
                      label: 'Fat',
                      value: '15',
                      unit: 'g',
                      colorBar: Colors.blue,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MapActivityItem(
                      label: 'Fiber',
                      value: '5',
                      unit: 'g',
                      colorBar: Colors.orange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: verticalMargin),
      ],
    ),
  );
}

class MapActivityItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color colorBar;

  const MapActivityItem({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.colorBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;

        return Container(
          // Optional: You can add padding or margin if needed
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Circular Progress Bar section
              Container(
                height: containerWidth * 0.3, // Responsive height
                width: containerWidth * 0.3, // Responsive width
                child: CircularProgressIndicator(
                  value: double.tryParse(value)! / 50.0,
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(colorBar),
                  backgroundColor: Colors.grey[300],
                ),
              ),
              const SizedBox(width: 10),
              // Text section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$value $unit', // Concatenate value and unit for better readability
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: containerWidth * 0.1, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: containerWidth * 0.09, // Responsive font size
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Chart extends StatelessWidget {
  final String label;
  final String unit;
  const Chart({
    Key? key,
    required this.label,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    fontSize: 24, // Adjust as needed
                    height: 0.5,
                  ),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  unit,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 15, // Adjust as needed
                    height: 0.5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: const Color.fromARGB(255, 104, 136, 179),
    value: 25,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Colors.blueGrey.shade100,
    value: 20,
    showTitle: false,
    radius: 22,
  ),
];

Widget _buildWaterTracker(BuildContext context) {
  // Calculate height for BMIWidget and StatsWidget
  double bmiWidgetHeight =
      MediaQuery.of(context).size.height * 0.4; // Height for BMIWidget
  double statsWidgetHeight =
      MediaQuery.of(context).size.height * 0.1; // Height for StatsWidget

  // Calculate vertical margin between BMIWidget and StatsWidget
  double verticalMargin =
      MediaQuery.of(context).size.height * 0.01; // Margin for StatsWidget

  // Total height calculation for the activity chart
  double totalHeight = bmiWidgetHeight + statsWidgetHeight + verticalMargin;

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.01,
    ),
    height: totalHeight,
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
    child: Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text("Today Water",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        SizedBox(height: verticalMargin),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0), // Optional padding
          child: Chart(
            label: '80%',
            unit: '',
          ),
        ),
        SizedBox(height: verticalMargin),
        Expanded(
          child: Text("80%",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Text("1600ml / 2000ml")),
      ],
    ),
  );
}

Widget _buildRunningMaps(
    BuildContext context, String date, String value, String unit, String img) {
  return RunningMap(
    date: date,
    value: value,
    unit: unit,
    img: img,
  );
}

class RunningMap extends StatelessWidget {
  final String date;
  final String value;
  final String unit;
  final String img;

  const RunningMap({
    super.key,
    required this.date,
    required this.value,
    required this.unit,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth;

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: containerWidth * 0.35, // Ukuran gambar responsif
                  height: containerWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(8), // Membulatkan border
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8), // Membulatkan gambar
                    child: Image.asset(
                      "assets/images/$img",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatItem(date, value, unit, containerWidth),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String date, String value, String unit, double containerWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center, // Teks vertikal di tengah
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: containerWidth * 0.06, // Ukuran font responsif
            color: Colors.grey, // Warna unit lebih terang
          ),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: containerWidth * 0.07, // Ukuran font responsif
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          unit,
          style: TextStyle(
            fontSize: containerWidth * 0.06, // Ukuran font responsif
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
