import 'package:flutter/material.dart';

// basic pagination
int count = 15;

void main() {
  runApp(MaterialApp(
    title: 'Pagination in Flutter',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool getMoreFlag = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.70;
      if (maxScroll - currentScroll <= delta) {
        //Load data more data
        if (!getMoreFlag) {
          setState(() {
            getMoreFlag = true;
          });
          getMoreData();
        }
      }
    });
    super.initState();
  }

  void getMoreData() {
    print(count);
    print("Loading.. more data");
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        count = count + 15;
        getMoreFlag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination in Flutter"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: count,
          itemBuilder: (context, i) {
            if (i == count - 1) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListTile(
              title: Text(i.toString()),
            );
          },
        ),
      ),
    );
  }
}
