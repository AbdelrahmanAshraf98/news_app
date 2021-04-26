import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                  title: Text('News App'),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){}
                        ),
                    IconButton(
                        icon: Icon(Icons.brightness_4_outlined),
                        onPressed: (){
                          cubit.changeMode();
                        }
                    )
                  ],
                ),
                body: cubit.Screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                    items: cubit.BottomItems,
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeBottomNavbar(index);
                    }));
          }),
    );
  }
}
