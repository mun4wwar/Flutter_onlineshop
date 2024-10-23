import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshopwang/addproduct.dart';
import 'package:onlineshopwang/updateproduct.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List productList = [];

  Future<void> deleteProduct(String id) async {
    String urlDeleteProduct =
        "https://awang-mi2b.000webhostapp.com/deleteproduct.php";

    try {
      var responseDelete =
          await http.post(Uri.parse(urlDeleteProduct), body: {"id": id});
      var deleteDataProduct = jsonDecode(responseDelete.body);
      if (deleteDataProduct["success"] == "true") {
        ("Product successfully deleted");
        // Remove the product from the list and update the state
        setState(() {
          productList.removeWhere((product) => product["id"] == id);
        });
      } else {
        ("Product failed to delete");
      }
    } catch (exc) {
      (exc);
    }
  }

  Future<void> getAllProduct() async {
    String urlAllProduct =
        "https://awang-mi2b.000webhostapp.com/all_productlist.php";

    try {
      var response = await http.get(Uri.parse(urlAllProduct));
      productList = jsonDecode(response.body);
      setState(() {
        productList = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: const Text(
          'Product List',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  '${productList[index]["images"]}',
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                productList[index]["name"],
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      productList[index]['description']!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    'Rp. '
                    '${productList[index]['price']}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Promo '
                    '${productList[index]['promo']}'
                    '%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    )
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(
                            id: productList[index]["id"],
                            name: productList[index]["name"],
                            price: productList[index]["price"],
                            description: productList[index]["description"],
                            promo: productList[index]["promo"],
                            images: productList[index]["images"],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.upload_circle_fill,
                      size: 18,
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteProduct(productList[index]["id"]);
                      getAllProduct();
                    },
                    icon: Icon(
                      CupertinoIcons.delete_solid,
                      size: 18,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        mini: true,
        splashColor: Colors.green.shade400,
        backgroundColor: Colors.green.shade200,
        child: const Icon(
          CupertinoIcons.add_circled,
          size: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}
