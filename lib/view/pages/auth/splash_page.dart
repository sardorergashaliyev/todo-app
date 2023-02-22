import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/view/pages/auth/sign_in.dart';
import 'package:todo_app/view/pages/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  delayed() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          Future.delayed(const Duration(seconds: 3), () async {
            String? docId = 'asd';
            if (docId == null) {
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                  (route) => false);
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            }
          });
        },
      ),
    );
  }

  @override
  void initState() {
    delayed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/Group.png'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                150.verticalSpace,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    'assets/image/LogoMainPage.png',
                    fit: BoxFit.cover,
                  ),
                ),
                100.verticalSpace,
                const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
