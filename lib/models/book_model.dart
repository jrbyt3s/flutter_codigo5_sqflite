class BookModel {
  String title, image, author, description;
  int id;
  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.author,
    required this.description,
  });

  //Practica recurrente : Constructor con Nombre:
  //Factory constructors return am instance of the class, but it doesn't necessarily create a new instance.
  //Factory constructors might return an instance that already exists, or a sub-class.
  factory BookModel.fromJson(Map<String, dynamic> map) => BookModel(
        id: map["id"],
        title: map["title"],
        image: map["image"],
        author: map["author"],
        description: map["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "image": description,
        "description": description,
      };
}
