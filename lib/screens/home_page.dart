import 'package:assessment_countries/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // initial value onChange Checkbox
  bool name = true;
  bool currency = true;
  bool unicodeFlag = true;
  bool flag = true;
  var isSelected = [true,false,false,true];


  @override
  Widget build(BuildContext context) {
    final getDate = Provider.of<ApiProvider>(context).fetchCount();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Countrys')),
      ),
      body: FutureBuilder(
          future: getDate,
          builder: (ctx, AsyncSnapshot snapshot) {
            final data = snapshot.data;

            if (snapshot.hasData) {
              return Column(
                children: [
                  // All Checkbox ---------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleButtons(
  children: <Widget>[
    Padding(padding:const EdgeInsets.all(5),
      child:Text('country'),)
    ,
    Padding(padding:const EdgeInsets.all(5),
      child:Text('currency'),)
    ,
      Padding(padding:const EdgeInsets.all(5),
      child:Text('unicodeFlag'),)
    ,
      Padding(padding:const EdgeInsets.all(5),
      child:Text('Flag'),)
    ,
  ],
  onPressed: (int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  },
  isSelected: isSelected,
),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (ctx, i) {
                          var svgImage = data["data"][i]["flag"];

                          return ListTile(
                            trailing: Visibility(
                              visible: isSelected[3],
                              child: svgImage == null
                                  ? SvgPicture.asset('assets/images/flag.svg',
                                      width: 50)
                                  : SvgPicture.network(svgImage, width: 50),
                            ),
                            title: Text(isSelected[0] ? data["data"][i]["name"] : ''),
                            subtitle: Row(
                              children: [
                                Text(isSelected[1]
                                    ? 'Currency ${data["data"][i]["currency"]}'
                                    : ''),
                                const VerticalDivider(),
                                Text(isSelected[2]
                                    ? 'unicodeFlag  ${data["data"][i]["unicodeFlag"]}'
                                    : ''),
                              ],
                            ),
                          );
                        }),
                  ),
               
                ],
              );
            } else {
              // Circular Progress Indicator ()------------------------------------------
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
