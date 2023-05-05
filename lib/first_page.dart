import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zigytest/model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
late Future<User> futureUser;
_launchUrl()async{
   Uri url =  Uri.parse('https://reqres.in/#support-heading');
  if(await canLaunchUrl(url)){
    await launchUrl(url);
  }else{
    throw Exception("Can't load Url");
  }
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUser = fetchUser();
  }
  Future<User> fetchUser() async{
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load user');
    }
  }

  @override
Widget build(BuildContext context) {
  return FutureBuilder<User>(
    future: futureUser,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.data.length + 1,
          itemBuilder: (context, index) {
            if (index == snapshot.data!.data.length) {
              return SizedBox(
                height:130,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: Text(
                          '${snapshot.data?.support.text}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                   Padding(
                     padding: const EdgeInsets.only(top: 2, right: 257),
                     child: TextButton(onPressed: (){
                        _launchUrl;
                     }, child: Text('${snapshot.data?.support.url}')),
                   ),
                   const SizedBox(height: 10,),
                   ElevatedButton(
                      style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(48, 132, 143, 1)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))
                ),
                    onPressed: (){
                    Navigator.push(context, 
                                  MaterialPageRoute(builder: (BuildContext context) => const SecondPage() ));
                   }, child: const Text('Next page', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Ubuntu'),))
                  ],
                ),
              );
            }
            Datum user = snapshot.data!.data[index];
            return Container(
              height: 90,
              margin: const EdgeInsets.all(10),
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(blurRadius: 5.0, blurStyle: BlurStyle.outer)
                  ]),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                ),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
            );
          },
        );
      } else if (snapshot.hasError) {
        return const Center(
          child: Text('Failed to load user'),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
}