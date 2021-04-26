import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layouts/cubit/states.dart';
import 'layouts/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
            create: (context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // print(CacheHelper.getData(key: 'isDark'));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orange,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
            ),
            darkTheme: ThemeData(
              accentColor: Colors.black26,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                backgroundColor: HexColor('333739'),
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
