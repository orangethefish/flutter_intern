//import packages
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import constants
import '../services/api_service.dart';



//category tab
class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  Future<Map<String, List<Item>>> _itemsFuture = Future<Map<String, List<Item>>>(() => {});
  @override
  void initState(){
    super.initState();
    _itemsFuture=getItems();
  }
  Widget build(BuildContext context) {
    return FutureBuilder <Map<String,List<Item>>>(
        future: _itemsFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return const Text('No data available.');
          }else{
            List categories=snapshot.data!.keys.toList();
            Map<String,List<Item>> items=snapshot.data!;
            return DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar(
                    // unselectedLabelColor: Colors.tealAccent,
                    tabs: categories.map((category) {
                      return Tab(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categories.map((category){
                        List<Item> itemsToDisplay=items[category]!.cast<Item>();
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          shrinkWrap: true,
                          itemCount: itemsToDisplay.length,
                          itemBuilder: (context, index) {
                            Item item = itemsToDisplay[index];
                            return GestureDetector(
                              onDoubleTap:(){

                              },
                              child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.network(item.image),
                                      SizedBox(height: 8),
                                      Text('${item.prodName} - ${item.prodPrice}£',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );

                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
