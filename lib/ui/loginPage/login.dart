import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_feed_newdemo_app/home.dart';
//import 'package:country_code_picker/country_code_picker.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:healthnest/ui/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CountryCode? _selectedCountry;
  final controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _validate = false;
  String? consumerMobileNumber;
  Color color = Colors.grey;

  @override
  void initState() {
    _selectedCountry = CountryCode.fromCountryCode("IN");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode:
          _validate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: formUI(),
      ),
    );
  }

  Widget formUI() {
    return GestureDetector(
      //  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  appIcon(),
                  SizedBox(height: 20),
                  welcomeText(),
                  SizedBox(height: 20),
                  editTextWithCountryCode(),
                  SizedBox(height: 20),
                  textDescription(),
                  SizedBox(height: 20),
                  sendOTPButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateMobile(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must be 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }

    return null;
  }

  void _sendToServer() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      print("Mobile $consumerMobileNumber");
      print('Country ${_selectedCountry?.name}');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Widget sendOTPButtonWidget() {
    return Container(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color, // Set the button color here
          elevation: 5.0, // Set the button elevation here
        ),
        onPressed: _sendToServer,
        child: Text('Send OTP',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        //color: Theme.of(context).accentColor,
        // elevation: 5,
      ),
    );
  }

  Widget textDescription() {
    return Container(
        child: Text(
      'We never compromise on security!\nHelp us create a safe place by providing your mobile number to maintain authenticity',
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),
    ));
  }

  Widget editTextWithCountryCode() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CountryCodePicker(
            showFlagDialog: true,
            // hideMainText: true,
            // showFlagMain: true,
            // showCountryOnly: true,
            // showOnlyCountryWhenClosed: true,
            // showFlag: false,
            onChanged: (CountryCode? country) {
              setState(() {
                _selectedCountry = country;
              });
            },
            initialSelection: 'IN',
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            onChanged: (String newVal) {
              setState(() {
                if (newVal.length == 10) {
                  color = Colors.teal;
                } else {
                  color = Colors.grey;
                }
              });
            },
            decoration: InputDecoration(
                labelText: 'Enter phone number',
                suffixIcon: Icon(CupertinoIcons.phone)),
            validator: _validateMobile,
            controller: controller,
            onSaved: (String? phoneNumber) {
              debugPrint('find the input length ${phoneNumber?.length}');
              consumerMobileNumber = phoneNumber;
            },
          ),
        )
      ],
    );
  }

  Widget appIcon() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // height: 200,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(50.0), // Set the border radius here
          child: Image.network(
            "https://th.bing.com/th/id/OIP.AWQVJxH_J92Z5D1MCfdspgHaFj?w=196&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
            fit: BoxFit.cover,
            height: 200,
          ),
        ),
      ),
    );
  }

  Widget welcomeText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: const Text(
          'Welcome to \n My world 😎',
          style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
