import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite/db/db_admin.dart';
import 'package:flutter_codigo5_sqflite/models/book_model.dart';

import 'package:flutter_codigo5_sqflite/utils.dart/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //DBAdmin.db.insertBookRaw();
    DBAdmin.db.insertBook();
    getData();
    BookModel milibrito = BookModel(
      id: 51,
      title: "title",
      image:
          "https://s3.amazonaws.com/imagenes-sellers-mercado-ripley/2021/05/08225321/9788491049616.jpg",
      author: "author",
      description: "description",
    );
    //DBAdmin.db.getBooksRaw();
  }

  getData() {
    DBAdmin.db.getBooks().then((value) {
      books = value;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Fiorella de Fátima",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        "https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
                        height: 64,
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: kPrimaryColor.withOpacity(0.45),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: kSecondaryColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mis Libros",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Ver más",
                      style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                /*
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ItemSliderWidget(),
                      ItemSliderWidget(),
                      ItemSliderWidget(),
                      ItemSliderWidget(),
                    ],
                  ),
                ),
                */
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: DBAdmin.db.getBooksRaw(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        List bookList = snap.data;
                        return Row(
                          children: bookList
                              .map((e) => ItemSliderWidget(
                                    title: e["title"],
                                    image: e["image"],
                                    author: e["author"],
                                  ))
                              .toList(),
                        );
                      }
                      return Row();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                FutureBuilder(
                  future: DBAdmin.db.getBooksRaw(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List bookList = snap.data;
                      return Column(
                        children: bookList
                            .map((e) => ItemBookWidget(
                                  title: e["title"],
                                  image: e["image"],
                                  author: e["author"],
                                  description: e["description"],
                                ))
                            .toList(),
                      );
                    }
                    return Column();
                  },
                ),
                //Los mismos widgets pero usando una clase:

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: books
                        .map((e) => ItemSliderWidget(
                              title: e.title,
                              image: e.image,
                              author: e.author,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: books
                      .map((itemBookModel) => ItemBookWidget(
                            title: itemBookModel.title,
                            image: itemBookModel.image,
                            author: itemBookModel.author,
                            description: itemBookModel.description,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),

      // body: ListView.builder(
      //   itemCount: books.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return ListTile(
      //       title: Text(books[index]["title"]),
      //     );
      //   },
      // ),
      // body: FutureBuilder(
      //   future: DBAdmin.db.getBooksRaw(),
      //   builder: (BuildContext context, AsyncSnapshot snap){
      //     if(snap.hasData){
      //       List bookList = snap.data;
      //       return ListView.builder(
      //         itemCount: bookList.length,
      //         itemBuilder: (BuildContext context, int index){
      //           return ListTile(
      //             title: Text(bookList[index]["title"]),
      //           );
      //         },
      //       );
      //     }
      //     return Text("ss");
      //   },
      // ),
    );
  }
}

class ItemBookWidget extends StatelessWidget {
  String title, image, author, description;
  ItemBookWidget({
    required this.title,
    required this.image,
    required this.author,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: GoogleFonts.poppins(
                      color: Colors.white60,
                      //fontWeight: FontWeight.w400,
                      fontSize: 13.0),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.white60,
                      //fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemSliderWidget extends StatelessWidget {
  String title, image, author;
  ItemSliderWidget({
    required this.title,
    required this.image,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Image.network(
              image,
              height: 250,
              width: 170,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
