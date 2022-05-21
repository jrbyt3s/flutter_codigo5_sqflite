import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite/db/db_admin.dart';
import 'package:flutter_codigo5_sqflite/models/book_model.dart';
import 'package:flutter_codigo5_sqflite/pages/detail_page.dart';
import 'package:flutter_codigo5_sqflite/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo5_sqflite/ui/widgets/item_book_widget.dart';
import 'package:flutter_codigo5_sqflite/ui/widgets/item_slider_widget.dart';

import 'package:flutter_codigo5_sqflite/utils.dart/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];
  int? idBook;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //DBAdmin.db.insertBookRaw();
    //DBAdmin.db.insertBook();
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

  _showForm(bool add) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.66),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  add ? "Agregar libro" : "Actualizar libro",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Container(
                  width: 80.0,
                  height: 2.7,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                InputTextFieldWidget(
                  hintText: "Título",
                  icon: "bx-bookmark.svg",
                  controller: _titleController,
                ),
                InputTextFieldWidget(
                  hintText: "Autor",
                  icon: "bx-user.svg",
                  controller: _authorController,
                ),
                InputTextFieldWidget(
                  hintText: "Descripción",
                  icon: "bx-list-ul.svg",
                  maxLines: 2,
                  controller: _descriptionController,
                ),
                InputTextFieldWidget(
                  hintText: "Portada",
                  icon: "bx-image-alt.svg",
                  maxLines: 4,
                  controller: _imageUrlController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        _titleController.clear();
                        _authorController.clear();
                        _descriptionController.clear();
                        _imageUrlController.clear();
                      },
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        // DBAdmin.db.insertBookRaw(
                        //   _titleController.text,
                        //   _authorController.text,
                        //   _descriptionController.text,
                        //   _imageController.text,
                        // );
                        BookModel book = BookModel(
                          title: _titleController.text,
                          author: _authorController.text,
                          description: _descriptionController.text,
                          image: _imageUrlController.text,
                        );
                        if (add) {
                          //Procediiento para crear:
                          DBAdmin.db.insertBook(book).then(
                            (value) {
                              if (value > 0) {
                                getData();
                                Navigator.pop(context);
                                _titleController.clear();
                                _authorController.clear();
                                _descriptionController.clear();
                                _imageUrlController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xff1eb880),
                                    duration: const Duration(seconds: 3),
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "El libro fue agregado correctamente",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          //Procedimiento para Editar o actualizar
                          book.id = idBook;

                          DBAdmin.db.updateBook(book).then((value) {
                            if (value > 0) {
                              getData();
                              Navigator.pop(context);
                              _titleController.clear();
                              _authorController.clear();
                              _descriptionController.clear();
                              _imageUrlController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xff1eb880),
                                  duration: const Duration(seconds: 3),
                                  content: Row(
                                    children: const [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "El libro fue actualizado correctamente",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          });
                        }
                        //Popup parte inferir de manera informativa que esta insertando.
                      },
                      child: Text(
                        "Aceptar",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDeleteDialog(BookModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10.0),
          backgroundColor: Color(0xffF53649),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Eliminar libro: ${model.title}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "¿Estás seguro de eliminar este libro ?",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: GoogleFonts.poppins(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      //Procedimiento para eliminar
                      print(model.id);
                      Navigator.pop(context);

                      DBAdmin.db.deleteBook(model.id!).then((value) {
                        if (value > 0) {
                          getData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xff00afb9),
                              duration: const Duration(seconds: 10),
                              content: Row(
                                children: const [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "El libro fue borrado Correctamente",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 185, 49, 0),
                              duration: const Duration(seconds: 10),
                              content: Row(
                                children: const [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "El libro fue No fue borrado Correctamente",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      "Aceptar",
                      style: GoogleFonts.poppins(
                        color: Color(0xffF53649),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          _titleController.clear();
          _authorController.clear();
          _descriptionController.clear();
          _imageUrlController.clear();
          _showForm(true);
        },
        child: Icon(Icons.add),
      ),
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
                //Datos en Duro:
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
                    future: DBAdmin.db.getBooks(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        List<BookModel> bookList = snap.data;
                        return Row(
                          children: bookList
                              .map((e) => GestureDetector(
                                    onLongPress: () {
                                      idBook = e.id;
                                      _titleController.text = e.title;
                                      _authorController.text = e.author;
                                      _descriptionController.text =
                                          e.description;
                                      _imageUrlController.text = e.image;
                                      _showForm(false);
                                    },
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPage(book: e)));
                                    },
                                    child: ItemSliderWidget(
                                      bookModel: e,
                                    ),
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
                  future: DBAdmin.db.getBooks(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<BookModel> bookList = snap.data;
                      return Column(
                        children: bookList
                            .map((e) => ItemBookWidget(
                                  bookModel: e,
                                  onTap: () {
                                    idBook = e.id;
                                    _showDeleteDialog(e);
                                  },
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
                        .map((BookModel e) => ItemSliderWidget(
                              bookModel: e,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: books
                      .map((itemBookModel) => ItemBookWidget(
                            bookModel: itemBookModel,
                            onTap: () {},
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
