import 'package:flutter/material.dart';
import 'package:flutter_application_5/Login/otpscreen.dart';
import 'package:flutter_application_5/Modals/countrymodel.dart';
import 'package:flutter_application_5/widgets/country.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'mainlogin.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  String countryname = "Sri Lanka";
  String countrycode = "+94";
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset('assets/verify_otp.jpg', height: 270, width: 300),
            Text(
              'Welcome back!',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.teal[400],
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  "Please enter your Phone Number Below",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            countryCard(),
            SizedBox(
              height: 10,
            ),
            number(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(),
            ),
            SizedBox(
              height: 50,
              width: 130,
              child: ElevatedButton(
                onPressed: () {
                  // Respond to button press

                  if (_phoneController.text.length != 9) {
                    Fluttertoast.showToast(
                        msg: 'Recheck phone number', textColor: Colors.red);
                  }

                  _phoneController.text.isNotEmpty
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpScreen(
                                countrycode: countrycode,
                                number: _phoneController.text,
                              )))
                      //   ? doLogin( _phoneController.text)
                      : Fluttertoast.showToast(
                          msg: 'All feilds are required',
                          textColor: Colors.red);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)))),
                child: Text(
                  "Send OTP",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 130),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/signup');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainLogin()));
                  },
                  child: Text('Use Another method!',
                      style:
                          TextStyle(fontSize: 16.5, color: Colors.teal[400])),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }

  Widget countryCard() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      Country(setCountryData: setCountryData)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.teal, width: 1.8))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    child: Center(
                  child: Text(countryname, style: TextStyle(fontSize: 16)),
                )),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.teal,
                size: 28,
              )
            ],
          ),
        ));
  }

  Widget number() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 1,
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.teal, width: 1.8))),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter phone number ",
                      prefix: Text(countrycode),
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryname = countryModel.name;
      countrycode = countryModel.code;
    });
    Navigator.pop(context);
  }
}
