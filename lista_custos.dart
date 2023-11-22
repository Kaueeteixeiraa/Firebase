import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'despesa.dart';

class ListaCustos extends StatefulWidget {
  @override
  _ListaCustosState createState() => _ListaCustosState();
}

class _ListaCustosState extends State<ListaCustos> {
  List<Despesa> despesas = [];

  @override
  void initState() {
    super.initState();

    // Carrega os dados do Firestore
    FirebaseFirestore.instance
        .collection('despesas')
        .get()
        .then((snapshot) {
      despesas = snapshot.docs.map((doc) => Despesa.fromJson(doc.data())).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de custos'),
      ),
      body: ListView.builder(
        itemCount: despesas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(despesas[index].nome),
            subtitle: Text(despesas[index].descricao),
            trailing: Text(despesas[index].valor.toString()),
          );
        },
      ),
    );
  }
}