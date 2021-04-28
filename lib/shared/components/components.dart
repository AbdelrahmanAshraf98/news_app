
import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/article/article_screen.dart';

Widget buildArticleItem(article,context){
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute
        (builder: (context) => ArticleScreen(url: article['url']),));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${article['urlToImage']}'),),
          ),),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articleBuilder(list,{isSearch = false}){
  return Conditional(
    condition: list.length > 0,
    onConditionTrue: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index],context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20.0,right: 20.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Theme.of(context).accentColor,
          ),
        ),
        itemCount: list.length),
    onConditionFalse: isSearch ? Container() : Center(child: CircularProgressIndicator()),
  );
}