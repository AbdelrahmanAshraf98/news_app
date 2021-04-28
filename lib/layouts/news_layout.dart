import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          String _selected;
          List<Map> _myJson = [
            {"id": '0', "name": "EG"},
            {"id": '1', "name": "FR"},
            {"id": '2', "name": "RU"},
            {"id": '3', "name": "US"},
            {"id": '4', "name": "DE"},
          ];
          return Scaffold(
              appBar: AppBar(
                title: Text('News App'),
                actions: [
                  DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        iconEnabledColor: Colors.deepOrangeAccent,
                        isDense: true,
                        hint: CircleFlag(cubit.selectedCountry,size: 25,),
                        value: _selected,
                        onChanged: (String newValue) {
                          cubit.changeCountry(index: int.parse(newValue));
                        },
                        items: _myJson.map((Map map) {
                          return new DropdownMenuItem<String>(
                            value: map["id"].toString(),
                            child: Row(
                              children: <Widget>[
                                CircleFlag(map['name'],size: 25,),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(map["name"])),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ));
                      }),
                  IconButton(
                      icon: Icon(Icons.brightness_4_outlined),
                      onPressed: () {
                        NewsCubit.get(context).changeMode();
                      })
                ],
              ),
              body: cubit.Screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  items: cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavbar(index);
                  }));
        });
  }
}
