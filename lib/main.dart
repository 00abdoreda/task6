import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie2/Movies.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: screen(),
     routes: {
        "/": (_) => MyHomePage(),

        "/MoviesScreen": (_) => screen(),
        "/movie-details": (_) => details(),
      },

    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie>movies=[];
  List<Movie>movies2=[];



  @override
  void initState() {
    getmovies();
    getmovies2();

    super.initState();

  }

  getmovies() async{
    var response= await Dio().get("https://api.themoviedb.org/3/movie/popular",
    queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
 // print(response.data["results"][5]["title"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++){
      Movie movie = new Movie.frommap(response.data["results"][i]);


      movies.add(movie);


    }


    setState(() {});


  }
  getmovies2() async{
    var response= await Dio().get("https://api.themoviedb.org/3/movie/now_playing",
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
    // print(response.data["results"][5]["title"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++){
      Movie movie = new Movie.frommap(response.data["results"][i]);


      movies2.add(movie);


    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],

        title: Text("MovieHunt" ,style: TextStyle(color: Colors.blue)),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          Container(
            color: Colors.blueGrey[900],
            margin: EdgeInsets.only(top: 2,bottom: 2),
            height: 310,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start ,

                  children: [
                    Text("  Now Playing",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 20),),
                    Spacer(),

                    GestureDetector(
                      onTap:(){
                        Navigator.pushNamed(
                            context,
                            "/MoviesScreen",
                            arguments: "Now Playing"

                        );


                      } ,

                       child: Text("View all  ",style: TextStyle(color:Colors.blue,fontSize: 12 ),)
                    ),

                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,

                      itemCount: movies2.length,

                      itemBuilder:(_,i){

                        Movie movie = movies2[i];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,
                            "/movie-details",
                            arguments: movie);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            color:Colors.transparent ,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start, //in row and column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: Image.network(
                                      movie.poster_path.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title.toString(),

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [


                                            RatingBar.builder(
                                              itemSize: 12,
                                              initialRating: ((movie.vote_average!).toDouble()/2),


                                              minRating: 1,

                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),

                                            SizedBox(width: 10),
                                            Text(
                                              "${movie.vote_count} reviews",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2h 14m",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),


                          ),
                        );


                      }

                  ),





                ),



              ],

            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.blueGrey[900],
            margin: EdgeInsets.only(top: 2,bottom: 2),
            height: 310,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start ,

                  children: [
                    Text("  Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 20),),
                    Spacer(),
                    GestureDetector(
                        onTap:(){
                          Navigator.pushNamed(
                              context,
                              "/MoviesScreen",
                              arguments: "Popular"

                          );


                        } ,

                        child: Text("View all  ",style: TextStyle(color:Colors.blue,fontSize: 12 ),)
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    shrinkWrap: true,

                    itemCount: movies.length,

                      itemBuilder:(_,i){

                      Movie movie = movies[i];
                       return GestureDetector(
                         onTap: (){
                           Navigator.pushNamed(context,"/movie-details",arguments: movie);
                         },
                         child: Container(
                           margin: EdgeInsets.all(8),
                           height: 200,
                           color:Colors.transparent ,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start, //in row and column
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Expanded(
                                 child: Container(
                                   clipBehavior: Clip.antiAlias,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),

                                   ),
                                   child: Image.network(
                                     movie.poster_path.toString(),
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: Container(
                                   padding: EdgeInsets.all(8),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         movie.title.toString(),

                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w800,
                                         ),
                                       ),
                                       SizedBox(height: 5),
                                       Row(
                                         children: [


                                           RatingBar.builder(
                                             itemSize: 12,
                                             initialRating: ((movie.vote_average!).toDouble()/2),


                                             minRating: 1,

                                             direction: Axis.horizontal,
                                             allowHalfRating: true,
                                             itemCount: 5,
                                             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                             itemBuilder: (context, _) => Icon(
                                               Icons.star,
                                               color: Colors.amber,
                                             ),
                                             onRatingUpdate: (rating) {
                                               print(rating);
                                             },
                                           ),

                                           SizedBox(width: 10),
                                           Text(
                                             "${movie.vote_count} reviews",
                                             style: TextStyle(
                                               color: Colors.white,
                                             ),
                                           ),
                                           SizedBox(width: 10),
                                         ],
                                       ),
                                       SizedBox(height: 5),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.access_time,
                                             size: 14,
                                             color: Colors.grey[350],
                                           ),
                                           SizedBox(width: 4),
                                           Text(
                                             "2h 14m",
                                             style: TextStyle(
                                               color: Colors.grey[350],
                                             ),
                                           ),
                                         ],
                                       ),

                                     ],
                                   ),
                                 ),
                               )
                             ],
                           ),


                         ),
                       );


                      }

                      ),





                ),



              ],

            ),
          ),
        ],
      ) ,

    );
  }
}

class screen extends StatefulWidget{

  @override
  _screenstate createState() =>_screenstate();
}
class _screenstate extends State<screen>{
  List<Movie>movies=[];
  String ? statue;
  String ?s;
 _screenstate({this.statue});




  @override
  void initState() {
    Future.delayed(Duration.zero,()=>getmovies());



    super.initState();

  }

  getmovies() async{

    statue = ModalRoute.of(context)?.settings.arguments as String?;
    if(statue=="Popular"){
     s="popular";

    }else if(statue=="Now Playing"){
      s="now_playing";
    }
    print("https://api.themoviedb.org/3/movie/${s??"popular"}");
    var response= await Dio().get("https://api.themoviedb.org/3/movie/${s??"popular"}",
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
    // print(response.data["results"][5]["title"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++){
      Movie movie = new Movie.frommap(response.data["results"][i]);


      movies.add(movie);




    }
    setState(() {});



  }

  @override
  Widget build(BuildContext context) {
    statue = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(

        backgroundColor: Colors.blueGrey[900],

        title: Text(statue??"" ,style: TextStyle(color: Colors.blue)),
      ),
      body: Container(
            color: Colors.blueGrey[900],


        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,

                      itemCount: movies.length,

                      itemBuilder:(_,i){

                        Movie movie = movies[i];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,"/movie-details",arguments: movie);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            color:Colors.transparent ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start, //in row and column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: Image.network(
                                      movie.poster_path.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title.toString(),

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [


                                            RatingBar.builder(
                                              itemSize: 12,
                                              initialRating: ((movie.vote_average!).toDouble()/2),


                                              minRating: 1,

                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),

                                            SizedBox(width: 10),
                                            Text(
                                              "${movie.vote_count} reviews",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2h 14m",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),


                          ),
                        );


                      }

                  ),



          ),



    );
  }
}

class details extends StatefulWidget{

  @override
  _detailstate createState() =>_detailstate();


}
class _detailstate extends State<details>{
  List <Movie>mymovie=[];
  Movie? movie;
  _detailstate({this.movie});

  @override
  void initState() {

    super.initState();
  }

 /* getmovies() async{
    mymovie.clear();
    x=(ModalRoute.of(context)?.settings.arguments as int);
    var response= await Dio().get("https://api.themoviedb.org/3/movie/popular",
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
  Movie movie1 = new Movie.frommap(response.data["results"][x]);

    mymovie.add(movie1);
    setState(() {});

  }*/
  @override
  Widget build(BuildContext context) {
    movie=(ModalRoute.of(context)?.settings.arguments as Movie);

    return Scaffold(


      backgroundColor: Colors.blueGrey[900],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(400),
        child: AppBar(
          flexibleSpace: ClipRRect(
            borderRadius:BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)) ,
            child: Container (

              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(movie!.poster_path.toString())),



              ),


            ),
          ),
          backgroundColor: Colors.transparent,
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))
          ),*/
        ),

      ),





      body: Container(
        child: Container(
          height: 700,
          margin: EdgeInsets.all(8),
          child: Row(
            children: [

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie!.title.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [


                          RatingBar.builder(
                            itemSize: 12,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),

                          SizedBox(width: 10),
                          Text(
                            "${movie!.vote_count!/1000}k reviews",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 5),



                      Text(
                        movie!.overview.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );

  }
}





