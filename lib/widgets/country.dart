import 'package:flutter/material.dart';
import 'package:flutter_application_5/Modals/countrymodel.dart';

class Country extends StatefulWidget {
  const Country({Key? key, required this.setCountryData}) : super(key: key);
  final Function setCountryData;
  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List<CountryModel> countries = [
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "Sri Lanka", code: "+94", flag: "🇱🇰"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        title: Text(
          "Choose the country",
          style:
              TextStyle(color: Colors.teal[800], fontSize: 18, wordSpacing: 1),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.teal,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) => card(countries[index])),
    );
  }

  Widget card(CountryModel country) {
    return InkWell(
        onTap: () {
          widget.setCountryData(country);
        },
        child: Card(
          margin: EdgeInsets.all(0.15),
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(children: [
              Text(
                country.flag,
              ),
              SizedBox(
                width: 15,
              ),
              Text(country.name),
              Expanded(
                  child: Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text(country.code)],
                      )))
            ]),
          ),
        ));
  }
}
