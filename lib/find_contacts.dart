import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';

class PhoneContacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PhoneContactsState();
  }
}

class _PhoneContactsState extends State<PhoneContacts> {
  Iterable<Contact> _contacts;

  @override
  initState() {
    super.initState();
    refreshContacts();
  }

  refreshContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new BackButton(),
        title: new Text('Phone Contacts'),
      ),
      body: SafeArea(
        child: _contacts != null
            ? buildListView()
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact c = _contacts?.elementAt(index);
          return ListTile(
            onTap: () {
              // TODO:
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) =>
//                        ContactDetailsPage(c)));
              },
            leading: (c.avatar != null && c.avatar.length > 0)
                ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                : CircleAvatar(
                child: Text(c.displayName.length > 1
                    ? c.displayName?.substring(0, 2)
                    : "")),
            title: Text(c.displayName ?? "", style: Theme.of(context).textTheme.title),
            trailing: new IconButton(
              onPressed: () => print('add button pressed'),
              iconSize: 30.0,
              padding: EdgeInsets.all(5.0),
              icon: new Icon(Icons.add_circle_outline, color: Colors.black,),
            ),
          );
        },
      );
  }
}