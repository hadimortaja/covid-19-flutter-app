
import 'package:covid_19_app/localization/localization_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'line_chart.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final int effectedNum;
  final Color iconColor;
  final Function press;
  final Color cardColor;
  final Map historyData;

  const InfoCard({Key key, this.title, this.effectedNum, this.iconColor, this.press,this.cardColor,this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
builder: (context,constraints){
  return Container(
    margin: EdgeInsets.all(5),
    child: GestureDetector(
      onTap: press,
      child: Container(
        width: (MediaQuery.of(context).size.width/2) -10,/////
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        height: 30,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.12),
                          shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(
                          "assets/running.svg",
                          height: 12,
                          width: 12,
                          color: iconColor,
                        ),
                      ),
                    Text(
                     getTranslated(context, title),
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color:Color(0xFF1E2432)),
                          children: [
                            TextSpan(
                              text: "$effectedNum \n",
                              style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                              text: "People",
                              style: TextStyle(
                                fontSize: 12,
                                height: 2,
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                    Expanded(
                        child: LineChartReport(
                          historyData: historyData,
                          title:  this.title,
                        ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
},

    );
  }
}
