import 'dart:io';

import 'package:flutter_codigo5_sqflite/models/book_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getCheckDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = await initDB();
    return myDatabase;
  }

  //crear base de datos
  Future<Database> initDB() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, "BookDB.db");
    print(path);
    return await openDatabase(path, version: 1, onOpen: (Database db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE BOOK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, description TEXT, image TEXT)");
    });
  }

  Future<List<Map<String, dynamic>>> getBooksRaw() async {
    Database? db = await getCheckDatabase();
    List<Map<String, dynamic>> res = await db!.rawQuery("SELECT * FROM BOOK");
    print(res);
    return res;
  }

  Future<List<BookModel>> getBooks() async {
    List<BookModel> listBokModel = [];
    final Database? db = await getCheckDatabase();
    List<Map<String, dynamic>> res =
        await db!.query("BOOK", orderBy: "id DESC");
    //res = res.reversed.toList();
    /*
    res.forEach((itemMap) {
      listBokModel.add(BookModel.deMapaAModelo(itemMap));
    });
    */
    listBokModel =
        res.map<BookModel>((itemMap) => BookModel.fromJson(itemMap)).toList();
    return listBokModel;
  }

  //INSERT
  //Los insert comentados es para ingresar uno a uno altenando comentarios.
  /*
  insertBookRaw() async {
    final Database? db = await getCheckDatabase();
    db!.rawInsert(
        //"INSERT INTO BOOK(title, author, description, image) VALUES('The Hobbit', 'JRR Tolkien', 'Bilbo Bolsón lleva una vida sencilla con sus compañeros hobbits en la comarca, hasta que el mago Gandalf llega y lo convence de unirse a un grupo de enanos para recuperar el reino de Erebor. El viaje lleva a Bilbo en un camino a través de tierras peligrosas llenas de orcos, goblins y otras amenazas', 'https://i.harperapps.com/hcanz/covers/9780261102217/x293.jpg')");
        //"INSERT INTO BOOK(title, author, description, image) VALUES('El simbolo perdido', 'Dan Brawn', 'Robert Langdon, profesor de simbología en la Universidad de Harvard, recibe un encargo del asistente de su amigo Peter Solomon: dar una conferencia sobre masonería en la sala más importante del Capitolio de los Estados Unidos. Además', 'https://images.penguinrandomhouse.com/cover/700jpg/9780307736932')");
        "INSERT INTO BOOK(title, author, description, image) VALUES('Cien anos de Soledad', 'Gabriel Garcia Marquez', 'Lorem ipsum', 'https://images.cdn1.buscalibre.com/fit-in/360x360/a9/0c/a90cb063637b0b991165a9b109ce002a.jpg')");
  }
  */
  /*
  insertBookRaw(
      String title, String author, String description, String image) async {
    final Database? db = await getCheckDatabase();
    db!.rawInsert(
        "INSERT INTO BOOK(title, author, description, image) VALUES('$title','$author','$description','$image')");
  }
  */
  insertBookRaw(BookModel model) async {
    final Database? db = await getCheckDatabase();
    db!.rawInsert(
        "INSERT INTO BOOK(title, author, description, image) VALUES('${model.title}', '${model.author}', '${model.description}', '${model.image}')");
  }
  /*
  insertBook() async {
    final Database? db = await getCheckDatabase();
    db!.insert("BOOK", {
      "title": "Mobi Dick",
      "author": "Melville, Herman",
      "description":
          "Narra la travesía del barco ballenero Pequod, comandado por el capitán Ahab, junto a Ismael y el arponero Queequeg en la obsesiva y autodestructiva persecución de un gran cachalote blanco..",
      "image":
          "https://s3.amazonaws.com/imagenes-sellers-mercado-ripley/2021/05/08225321/9788491049616.jpg",
    });
  }
  */

  Future<int> insertBook(BookModel model) async {
    final Database? db = await getCheckDatabase();
    int res = await db!.insert("BOOK", model.toJson());
    return res;
  }
}
