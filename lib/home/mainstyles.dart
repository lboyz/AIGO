import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reversedImage(String assetPath,
    {BoxFit fit = BoxFit.cover, double? width, double? height}) {
  return Transform(
    alignment: Alignment.center,
    transform: Matrix4.rotationY(0),
    child: Image.asset(
      assetPath,
      fit: fit,
      width: width,
      height: height,
    ),
  );
}

final appBarGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.blue.withOpacity(0.20), // Warna biru dengan transparansi
      Colors.transparent, // Warna transparan
    ],
    stops: [0.25, 1.0], // 75% biru, 25% transparan
  ),
);

final appBarShadowStyle = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.blue.withOpacity(0.5), // Warna shadow biru
      spreadRadius: 5,
      blurRadius: 10,
      offset: Offset(0, 5), // Posisi shadow
    ),
  ],
);

Widget titleText(String text, BuildContext context) {
  final bool isMobile = MediaQuery.of(context).size.width < 600;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.55,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Sitka',
        fontSize: isMobile ? 30 : 85,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}

Widget subtitleText(String text, BuildContext context) {
  final bool isMobile = MediaQuery.of(context).size.width < 600;
  return SizedBox(
    width: isMobile
        ? MediaQuery.of(context).size.width * 0.45
        : MediaQuery.of(context).size.width * 0.35,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Sitka-light',
        fontSize: isMobile ? 15 : 25,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}

Widget subMenuTitle(String text, BuildContext context) {
  final bool isMobile = MediaQuery.of(context).size.width < 600;
  return SizedBox(
    // width: isMobile
    //     ? MediaQuery.of(context).size.width * 0.45
    //     : MediaQuery.of(context).size.width * 0.35,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Sitka',
        fontSize: isMobile ? 24 : 50,
        fontWeight: FontWeight.w400,
        color: Colors.blue,
      ),
    ),
  );
}

Widget subMenuText(String text, BuildContext context) {
  final bool isMobile = MediaQuery.of(context).size.width < 600;
  return SizedBox(
    // width: isMobile
    //     ? MediaQuery.of(context).size.width * 0.45
    //     : MediaQuery.of(context).size.width * 0.35,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Saira-Light',
        fontSize: isMobile ? 10 : 20,
      ),
      textAlign: TextAlign.justify,
    ),
  );
}

const TextStyle titleStyle = TextStyle(
  fontFamily: 'Sitka',
  fontSize: 85,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const TextStyle subtitleStyle = TextStyle(
  fontFamily: 'Sitka-light',
  fontSize: 25,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 58, 99, 169),
  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 25),
).copyWith(
  foregroundColor: WidgetStateProperty.all(
      const Color.fromARGB(255, 63, 215, 207)), // warna text
);
