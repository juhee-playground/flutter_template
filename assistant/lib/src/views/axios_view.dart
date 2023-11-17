import 'package:flutter/material.dart';
import 'dart:async';

import '../model/album.dart';
import '../axios/example.dart' as axios;

class AxiosView extends StatefulWidget {
  const AxiosView({super.key});
  static const routeName = '/axios';

  @override
  State<AxiosView> createState() => _AxiosViewState();
}

class _AxiosViewState extends State<AxiosView> {
  late Future<Album> futureAlbum;

  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = axios.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = axios.createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(snapshot.data!.title),
              ]);
        } else if (snapshot.hasError) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${snapshot.error}'),
              ]);
        }
        return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()]);
      },
    );
  }
}
