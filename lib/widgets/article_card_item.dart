import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


class ArticleCardItem extends StatelessWidget {
  final String id;
  final String image;
  final String url;
  final String title;
  final String desc;
  final Function onPress;
  final DateTime date;

  ArticleCardItem({
    @required this.id,
    @required this.image,
    @required this.url,
    @required this.title,
    @required this.desc,
    @required this.onPress,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String desc = this.desc;
    if(desc == null)
        desc = '';
    return InkWell(
      onTap: () => onPress(url),
      child: Container(
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: (this.image.length == 0 || this.image == 'null') ? Image.asset(
                    'assets/images/placeholder.png'
                ) : FadeInImage.assetNetwork(
                  image: this.image,
                  placeholder: 'assets/images/placeholder.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        this.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        timeago.format(date, locale: 'en'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
