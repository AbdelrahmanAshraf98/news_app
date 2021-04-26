import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list =NewsCubit.get(context).search;
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
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(child: articleBuilder(list)),
            ],
          ),
        );
      },
    );
  }
}
