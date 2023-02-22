import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth_controller.dart';
import 'package:todo_app/view/pages/auth/sign_up.dart';
import 'package:todo_app/view/pages/home/home_page.dart';
import 'package:todo_app/view/util/style/style.dart';
import 'package:todo_app/view/util/widgets/auth_button.dart';
import 'package:todo_app/view/util/widgets/custom_textform.dart';
import 'package:todo_app/view/util/widgets/onunfocus.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool value = false;
  bool isPhoneEmpty = false;
  bool isPasswordEmpty = false;
  bool visibilityOfpasswor = false;

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
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
                24.verticalSpace,
                Text(
                  'Sign in to your account',
                  style: Style.textStyleRegular(size: 23),
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Row(
                    children: [
                      Text(
                        'Password',
                        style: Style.textStyleRegular2(
                          textColor: const Color(0xff2C3A4B),
                        ),
                      ),
                      Text(
                        '*',
                        style: Style.textStyleRegular2(
                            size: 14, textColor: Style.primaryColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: CustomTextFrom(
                    colorFill: Style.greyColor,
                    colorBorder: Style.greyColor,
                    radius: 100,
                    onchange: (value) {},
                    suffixicon: IconButton(
                        onPressed: () {
                          visibilityOfpasswor = !visibilityOfpasswor;
                          setState(() {});
                        },
                        icon: Icon(visibilityOfpasswor == false
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    controller: password,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.multiline,
                    hintext: 'Password',
                    onChange: (s) {},
                    label: '',
                  ),
                ),
                // 8.verticalSpace,
                // isPasswordEmpty
                //     ? const Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 24),
                //         child: Warning(
                //           text: 'Please fill the Password',
                //         ))
                //     : const SizedBox.shrink(),
                // 22.verticalSpace,
                // const Padding(
                //     padding: EdgeInsets.only(
                //       left: 48,
                //     ),
                //     child: CkeckBox()),
                context.watch<AuthController>().errorText == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          context.watch<AuthController>().errorText ?? "",
                          style:
                              Style.textStyleRegular2(textColor: Colors.red),
                        ),
                      ),
                24.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: InkWell(
                      onTap: () {
                        if (phone.text.isEmpty) {
                          isPhoneEmpty = true;
                        } else if (password.text.isEmpty) {
                          isPasswordEmpty = true;
                          setState(() {});
                        }
                        if (phone.text.isNotEmpty &&
                            password.text.isNotEmpty) {
                          context
                              .read<AuthController>()
                              .login(phone.text, password.text, () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                                (route) => false);
                          });
                        }
                      },
                      child: AuthButton(
                        controller: phone,
                        passw: password,
                        text: 'Sign in',
                      )),
                ),
                20.verticalSpace,
                Text(
                  'Forgot the password?',
                  style:
                      Style.textStyleRegular2(textColor: Style.primaryColor),
                ),
                32.verticalSpace,
                Text(
                  'or continue with',
                  style: Style.textStyleRegular2(textColor: Style.blackColor),
                ),
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
                          'assets/image/google.png',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff858C94),
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        context.read<AuthController>().errorText = '';
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (a) => const SignUpPage(),
                            ),
                            (route) => false);
                      }),
                      child: Text('Sign Up',
                          style: Style.textStyleRegular2(
                              textColor: Style.primaryColor)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
