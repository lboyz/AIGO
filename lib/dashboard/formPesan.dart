import 'package:aigo/dashboard/recomendation.dart';
import 'package:aigo/dashboard/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../dashboard/dashboard.dart';
import 'activity.dart';
import 'analytics.dart';
import 'consultation.dart';
import 'chat.dart';
import 'setting.dart';

void main() {
  runApp(const formPesanDashboard());
}

class formPesanDashboard extends StatelessWidget {
  const formPesanDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'formPesan',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const formPesan(),
    );
  }
}

class formPesan extends StatelessWidget {
  const formPesan({Key? key}) : super(key: key);

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
                  constraints: BoxConstraints(
                    maxWidth: 975,
                    maxHeight: MediaQuery.of(context).size.height * 3,
                  ), // Maximum height for larger screens),
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
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        _FormContent(),
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
                        child: Row(
                          children: [
                            Expanded(child: _Logo()),
                            Expanded(
                              child: Center(child: _FormContent()),
                            ),
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

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
            Radius.circular(8)), // Border radius untuk container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxWidth: isSmallScreen
            ? 150
            : 300, // Menyesuaikan lebar untuk layar kecil atau besar
        maxHeight: isSmallScreen ? 150 : 800,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Border radius untuk gambar
        child: Image.asset(
          'assets/images/consul_food.jpg', // Ganti dengan path gambar logo Anda
          fit: BoxFit.cover, // Agar gambar memenuhi container
        ),
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  String _waktuTidur = '< 7 jam';
  String _selectedDate = ''; // To store the selected date

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      constraints: BoxConstraints(
        maxWidth: isSmallScreen
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width * 0.3,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Konsultasi',
              style: TextStyle(
                color: const Color.fromRGBO(55, 179, 183, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 13),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tanggal Lahir field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal Lahir *',
                    style: TextStyle(
                      color: const Color.fromRGBO(55, 179, 183, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
                _gap(isSmallScreen),
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a valid date';
                    }
                    // Additional date validation
                    DateTime? selectedDate = DateTime.tryParse(value);
                    if (selectedDate != null &&
                        selectedDate.isAfter(DateTime.now())) {
                      return 'Date cannot be in the future';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText:
                        _selectedDate.isEmpty ? 'DD/MM/YYYY' : _selectedDate,
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(224, 233, 244, 1)),
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(224, 233, 244, 1)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                _gap(isSmallScreen),

                // Layout for Berat Badan and Tinggi Badan
                if (isSmallScreen) ...[
                  _buildWeightField(),
                  const SizedBox(height: 5),
                  _buildHeightField(),
                ] else ...[
                  Row(
                    children: [
                      Expanded(child: _buildWeightField()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildHeightField()),
                    ],
                  ),
                ],
                _gap(isSmallScreen),

                // Riwayat Alergi field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Riwayat Alergi',
                    style: TextStyle(
                      color: const Color.fromRGBO(55, 179, 183, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
                _gap(isSmallScreen),
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(55, 179, 183, 1),
                        fontStyle: FontStyle.italic),
                    hintText: 'Opsional',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(224, 233, 244, 1)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                _gap(isSmallScreen),

                // Riwayat Penyakit field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Riwayat Penyakit',
                    style: TextStyle(
                      color: const Color.fromRGBO(55, 179, 183, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
                _gap(isSmallScreen),
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(55, 179, 183, 1),
                        fontStyle: FontStyle.italic),
                    hintText: 'Opsional',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(224, 233, 244, 1)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                _gap(isSmallScreen),

                // Radio buttons for Waktu Tidur
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Waktu Tidur (Jam) *',
                    style: TextStyle(
                      color: const Color.fromRGBO(55, 179, 183, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          '< 7 jam',
                          style:
                              TextStyle(color: Color.fromRGBO(55, 179, 183, 1)),
                        ),
                        value: '< 7 jam',
                        groupValue: _waktuTidur,
                        onChanged: (value) {
                          setState(() {
                            _waktuTidur = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          '> 7 jam',
                          style:
                              TextStyle(color: Color.fromRGBO(55, 179, 183, 1)),
                        ),
                        value: '> 7 jam',
                        groupValue: _waktuTidur,
                        onChanged: (value) {
                          setState(() {
                            _waktuTidur = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _gap(isSmallScreen),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(55, 179, 183, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Kirim',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the submission of the form
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to display the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  // Helper methods to build weight and height fields
  Widget _buildWeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Berat Badan (kg) *',
            style: TextStyle(
              color: const Color.fromRGBO(55, 179, 183, 1),
              fontSize: 14,
            ),
          ),
        ),
        _gap(true), // Adjust to pass a boolean value
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter weight';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(224, 233, 244, 1)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tinggi Badan (cm) *',
            style: TextStyle(
              color: const Color.fromRGBO(55, 179, 183, 1),
              fontSize: 14,
            ),
          ),
        ),
        _gap(true), // Adjust to pass a boolean value
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter height';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(224, 233, 244, 1)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  // Helper method for spacing
  Widget _gap(bool isSmallScreen) {
    return SizedBox(height: isSmallScreen ? 16 : 16.0);
  }
}
