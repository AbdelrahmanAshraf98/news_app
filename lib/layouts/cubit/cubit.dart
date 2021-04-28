import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  
  int currentIndex = 0 ;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  ];
  List<Widget> Screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
   List<dynamic> business = [];

   void getBusiness(){
     if(business.length == 0){
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        business = value.data['articles'];
        print(business[1]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print('Error 555 : $error.toString()');
        emit(NewsGetBusinessErrorState());
      });
     }else{
       emit(NewsGetBusinessSuccessState());
     }
   }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0){
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'eg',
        'category':'Sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[1]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print('Error 556 : ${error.toString()}');
        emit(NewsGetSportsErrorState());
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience(){
    if(science.length == 0){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science = value.data['articles'];
        print(science[1]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print('Error 557 : ${error.toString()}');
        emit(NewsGetScienceErrorState());
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('Error 558 : ${error.toString()}');
      emit(NewsGetSearchErrorState());
    });
  }

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

  void changeBottomNavbar (index){
    currentIndex = index;
    if(index == 1)
      getSports();
    else if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }



}