import 'package:covid_19_app/widgets/info_card.dart';
import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {

  final Map worldWide;
  final Map historyData;

  const WorldWidePanel({Key key, this.worldWide,this.historyData}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2
        ),
        children: <Widget>[
          InfoCard(
            title: "CONFIRMED",
            iconColor: Colors.red,
            effectedNum: worldWide['cases'],
            press: (){},
            cardColor: Colors.red[100] ,
            historyData: historyData,
          ),
          InfoCard(
            title: "ACTIVE",
            iconColor: Colors.blue,
            effectedNum: worldWide['active'],
            press: (){},
            cardColor: Colors.blue[100],
            historyData: null,
          ),
          InfoCard(
            title: "RECOVERED",
            iconColor: Colors.green,
            effectedNum: worldWide['recovered'],
            press: (){},
            cardColor: Colors.green[100],
            historyData: historyData,
          ),
          InfoCard(
            title: "DEATHS",
            iconColor: Colors.black,
            effectedNum: worldWide['deaths'],
            press: (){},
            cardColor: Colors.grey[400],
            historyData:historyData ,
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}):super(key:key);@override

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;//al3ard tba3 al jehaz
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width/2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
            style: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
          ),
          ),
          Text(count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

