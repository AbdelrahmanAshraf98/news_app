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

   void getBusiness({bool changeCountry}){
     if(changeCountry != null)
       business = [];
     if(business.length == 0){
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'$selectedCountry',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        business = value.data['articles'];
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

  void getSports({bool changeCountry}){
    if(changeCountry != null)
      sports = [];
    if(sports.length == 0){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'$selectedCountry',
        'category':'Sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports = value.data['articles'];
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

  void getScience({bool changeCountry}){
    if(changeCountry != null)
      science = [];
    if(science.length == 0){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url:'v2/top-headlines', query: {
        'country':'$selectedCountry',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science = value.data['articles'];
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
    search = [];
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

  bool isDark = true;

  void changeMode({bool fromShared}) {
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.setTheme(key: 'isDark', value: isDark).then((value) => emit(AppChangeModeState()));
    }
  }

  void changeBottomNavbar (index){
    currentIndex = index;
    if(index == 1)
      getSports();
    else if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<String> countries = ['eg','fr','RU','us','de'];
  String selectedCountry = 'eg';

  void changeCountry({int index}){
    if(index != null){
      selectedCountry = countries[index];
      CacheHelper.setCountry(key: 'countryId', value: index).then((value) {
        emit(AppChangeCountryState());
        getBusiness(changeCountry: true);
        getSports(changeCountry: true);
        getScience(changeCountry: true);
      }).catchError((error){
        print("change Country Error");
      });
    }
    else{
      selectedCountry = 'eg';
      CacheHelper.setCountry(key: 'countryId', value: 0).then((value) {
        emit(AppChangeCountryState());
        getBusiness(changeCountry: true);
        getSports(changeCountry: true);
        getScience(changeCountry: true);
      }).catchError((error){
        print("change Country Error");
      });
    }

  }

}