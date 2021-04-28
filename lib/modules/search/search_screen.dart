import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          String s = "";
          return Scaffold(
            appBar: AppBar(
              title : Text('Search'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      s="";
                      s+=value;
                      NewsCubit.get(context).getSearch(s);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: Icon(Icons.search,color: Theme.of(context).accentColor,),
                    ),
                  ),
                ),
                Expanded(child: articleBuilder(list,isSearch: true)),
              ],
            ),
          );
        },
      ),
    );
  }
}
