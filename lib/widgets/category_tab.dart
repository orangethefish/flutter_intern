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
  //fetch categories list from api
  Future <List> getCategory() async{
    var url = Uri.http(apiHost,'products/category');
    final response = await http.get(url);
    List data = jsonDecode(response.body);
    return data;
  }
  @override
  void initState(){
    super.initState();
    getCategory();
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
