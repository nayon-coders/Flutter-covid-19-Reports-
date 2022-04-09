import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/all_status_service.dart';

class CountriesStatus extends StatefulWidget {
  const CountriesStatus({Key? key}) : super(key: key);

  @override
  State<CountriesStatus> createState() => _CountriesStatusState();
}

class _CountriesStatusState extends State<CountriesStatus> {
  //controller
  TextEditingController _SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateService _stateService = StateService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid-19 Countries Result"),
        backgroundColor: Colors.black38,
        elevation: 0,
      ),

      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: _SearchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search Country Cases",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                prefixIcon: Icon(Icons.search,),
              ),
            ),
          ),

          Expanded(
              child: FutureBuilder(
              future: _stateService.fromCountriesStatus(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.hasData){

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String countryName = snapshot.data[index]['country'];
                              if(_SearchController.text.isEmpty){
                                return ListTile(
                                  title: Text(snapshot.data[index]['country']),
                                  subtitle:Text("Total Case: ${snapshot.data[index]['cases'].toString()}"),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data[index]['countryInfo']['flag']),
                                  ),
                                );
                              }else if(countryName.toLowerCase().contains(_SearchController.text.toLowerCase())){
                                return ListTile(
                                  title: Text(snapshot.data[index]['country']),
                                  subtitle:Text("Total Case: ${snapshot.data[index]['cases'].toString()}"),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data[index]['countryInfo']['flag']),
                                  ),
                                );
                              }else{
                                return Container();
                              }

                            });
                      }else{
                          return ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade500,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10, width: 89, color: Colors.white,),
                                      subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                      leading:  Container(height: 50, width: 50, color: Colors.white,),
                                    )
                                  ],
                                ),
                              );
                            });
                      }

                  }
                  ),
              ),
        ],
      ),
    );
  }
}
