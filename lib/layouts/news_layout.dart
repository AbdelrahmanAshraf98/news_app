import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('News App'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:  (context) => SearchScreen(),));
                      }
                      ),
                  IconButton(
                      icon: Icon(Icons.brightness_4_outlined),
                      onPressed: (){
                        AppCubit.get(context).changeMode();
                      }
                  )
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
