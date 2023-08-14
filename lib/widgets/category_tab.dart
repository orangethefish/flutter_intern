//import packages
import 'package:flutter/material.dart';

//import widgets
import './products_list.dart';

//import apis
import '../services/api_service.dart';


//category tab
class CategoryTab extends StatefulWidget {
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  Future<Map<String, List<Item>>> _itemsFuture = Future<Map<String, List<Item>>>(() => {});
  // Map<String, List<Item>> with Item defined in services/api_service.dart
  //each category(key) contains a List of Items(value) with the same category
  @override
  void initState(){
    super.initState();
    _itemsFuture=getItems(); //fetch Items from api
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
            List categories=snapshot.data!.keys.toList(); //extract all keys to a list that contains categories
            Map<String,List<Item>> items=snapshot.data!; //items map
            return DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar( //each tab represent a category
                    // unselectedLabelColor: Colors.tealAccent,
                    tabs: categories.map((category) { //map each category in the list
                      return Tab(
                        child: Text(
                          category,
                          style: TextStyle( //styling
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView( //content in each tab
                      children: categories.map((category){
                        List<Item> itemsToDisplay=items[category]!.cast<Item>(); //list of items to display
                        return GridView.builder( //display item in grid
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //3 items per line
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          shrinkWrap: true,
                          itemCount: itemsToDisplay.length, //number of items to display
                          itemBuilder: (context, index) {
                            Item item = itemsToDisplay[index];
                            return ProductsList( //ProductList
                                item: item,
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
