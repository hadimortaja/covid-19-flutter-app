import 'dart:convert';
import 'package:covid_19_app/data_source.dart';
import 'package:covid_19_app/localization/localization_methods.dart';
import 'package:covid_19_app/localization/models.dart';
import 'package:covid_19_app/main.dart';
import 'package:covid_19_app/pages/country_page.dart';
import 'package:covid_19_app/panels/info_panel.dart';
import 'package:covid_19_app/panels/most_effected_countries.dart';
import 'package:covid_19_app/panels/world_wide_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/all");
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;

  fetchCountriesData() async {
    http.Response response = await http.get(
        "https://corona.lmao.ninja/v2/countries?sort=cases");
    setState(() {
      countriesData = json.decode(response.body);
    });
  }

  Map historyData;

  fetchHistoryData() async {
    http.Response response = await http.get(
        "https://corona.lmao.ninja/v2/historical/all");
    setState(() {
      historyData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
    fetchHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(getTranslated(context,
            "COVID-19_Panel")),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.LanguageList()
                  .map<DropdownMenuItem<Language>>((lang) =>
                  DropdownMenuItem(
                    value: lang,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          lang.flag,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(lang.name)
                      ],
                    ),
                  )
              ).toList(),
              onChanged: (Language lang) {
                _changeLanguage(lang);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 100,
              padding: EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text(
                getLangCode(context)== ARABIC ?DataSource.quoteAr :DataSource.quote, style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                getTranslated(context,"WorldWide"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CountryPage()));
                    },
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlack,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        getTranslated(context,"Regional"),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null
                ? Center(child: CircularProgressIndicator())
                : WorldWidePanel(
              worldWide: worldData,
              historyData: historyData,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                getTranslated(context,"Most_Affected_Countries"),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10,),
            countriesData == null ? Container() : MostEffectedPanel(
              countryData: countriesData,),
            SizedBox(height: 5,),
            InfoPanel(),
            SizedBox(height: 10,),
            Center(
              child: Text(getTranslated(context,"We_Are_Together_In_This"),
                style: TextStyle(
                    color: primaryBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }


  void _changeLanguage(Language lang) async {
    Locale _temp = await setLocale(lang.languageCode);
    MyApp.setLocale(context, _temp);
  }
}