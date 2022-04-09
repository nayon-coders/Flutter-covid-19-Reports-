import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStateModel.dart';
import '../services/all_status_service.dart';
import 'countires_list.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({Key? key}) : super(key: key);

  @override
  State<WorldStatus> createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateService _stateService = StateService();
    return Scaffold(
      body:  Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            FutureBuilder(
              future: _stateService.fromWorldState(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if(!snapshot.hasData){
                    return Expanded(
                      flex:1,
                      child: SpinKitCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );

                  }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recovery": double.parse(snapshot.data!.recovered.toString()),
                            "Death": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartType: ChartType.ring,
                          animationDuration: Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.height / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),

                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        ResuableRow("Total", "${snapshot.data!.cases.toString()}"),
                        ResuableRow("Recovery", "${snapshot.data!.recovered.toString()}"),
                        ResuableRow("Dath", "${snapshot.data!.deaths.toString()}"),
                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesStatus()));
                           },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: const Center(
                              child: Text("Track Countries", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })

          ],
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
final String title, value;
ResuableRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${title}: ", style: TextStyle(color: Colors.white),),
            Text("${value}", style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}

