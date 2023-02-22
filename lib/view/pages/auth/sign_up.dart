import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth_controller.dart';
import 'package:todo_app/view/pages/auth/sign_in.dart';
import 'package:todo_app/view/pages/home/home_page.dart';
import 'package:todo_app/view/util/style/style.dart';
import 'package:todo_app/view/util/widgets/auth_button.dart';
import 'package:todo_app/view/util/widgets/onunfocus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phone = TextEditingController();
  bool isPhoneEmpty = false;

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnUnFocusTap(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Sign up for free',
                    style: Style.textStyleRegular(
                        size: 23, textColor: Style.blackColor)),
                32.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 48,
                  ),
                  child: Row(
                    children: [
                      Text('Phone',
                          style: Style.textStyleRegular2(
                              textColor: const Color(0xff2C3A4B))),
                      Text('*',
                          style: Style.textStyleRegular2(
                              size: 14, textColor: Style.primaryColor)),
                    ],
                  ),
                ),
                8.verticalSpace,
                context.watch<AuthController>().errorText == null
                    ? const SizedBox.shrink()
                    : Text(
                        context.watch<AuthController>().errorText ?? "",
                        style: Style.textStyleRegular2(
                            textColor: Style.primaryColor),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: InkWell(
                    child: AuthButton(
                      controller: phone,
                      text: 'Sign up',
                    ),
                  ),
                ),
                20.verticalSpace,
                Text('Forgot the password?',
                    style:
                        Style.textStyleRegular2(textColor: Style.primaryColor)),
                32.verticalSpace,
                Text('or continue with',
                    style:
                        Style.textStyleRegular2(textColor: Style.blackColor)),
                24.verticalSpace,
                GestureDetector(
                  onTap: () async {
                    context.read<AuthController>().loginGoogle(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    });
                  },
                  child: Container(
                    height: 57.h,
                    width: 178.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 206, 206)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: [
                        37.5.horizontalSpace,
                        Image.asset(
                          'assets/google.png',
                          height: 25,
                          width: 24,
                        ),
                        12.horizontalSpace,
                        context.watch<AuthController>().isGoogleLoading
                            ? const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: CircularProgressIndicator(
                                    color: Style.primaryColor),
                              )
                            : Text(
                                'Google',
                                style: Style.textStyleRegular2(
                                    textColor: Style.blackColor),
                              ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Already have an account?',
                    style: Style.textStyleRegular2(
                        textColor: const Color(0xff858C94)),
                  ),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (a) => const SignInPage()),
                          (route) => false);
                    }),
                    child: Text('Sign in',
                        style: Style.textStyleRegular2(
                            textColor: Style.primaryColor)),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
