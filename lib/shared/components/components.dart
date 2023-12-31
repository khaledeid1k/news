import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/webView.dart';
import '../cubit/cubit.dart';
import 'constants.dart';

Widget defaultButton({
  width = double.infinity,
  Color color = Colors.blue,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0,
  required Function() function,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  bool obscureText = false,
  required Icon prefixIcon,
  Widget? suffixIcon,
  required String labelText,
  required TextInputType keyboardType,
  required String? Function(String?)? validator,
  Function()? onSuffixIconPressed,
  Function()? onTap,
  Function(String value)? onChanged,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      // to hidden text
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixIconPressed,
                icon: suffixIcon,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged:onChanged ,
    );

Widget defaultItemNews(context,
    {required List<dynamic> articles}) {
  return  ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      Map<String, dynamic> article = articles[index];

      return InkWell(
        onTap: (){
          navigate(context: context, widget: WebViewScreen(article['url']));
        },
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage(
                    article["urlToImage"] ?? "https://th.bing.com/th/id/OIP.p-aZsNRUiC7FilHb3hnEYgHaE8?pid=ImgDet&rs=1",),

                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Container(
              height: 120.0 ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(article["title"],
                      style:Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow:TextOverflow.ellipsis ,),
                  ),

                  Text(article["publishedAt"], style: TextStyle(
                      color: Colors.grey
                  ),),

                ],
              ),
            ),
          ),
        ],),
    ),
      );},
    itemCount:articles.length ,
    separatorBuilder: (context, index) => separatorBuilder(context,index)

  );
}




Widget fallbackByTextAndIcon(IconData icon,String text) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 100.0,
          color: Colors.black38,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    ),
  );
}
Widget fallbackByProgress(context) {
  return const Center(
    child: CircularProgressIndicator(

    ),
  );
}
Widget separatorBuilder(context, index) => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    height: 2.0,
    color: Colors.grey[200],
    width: double.infinity,
  ),
);
void navigate({required context , required Widget widget}){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

