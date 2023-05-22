import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/screen/categories_screen.dart';
import 'package:todolist_sqflite/screen/profile_screen.dart';
import 'package:todolist_sqflite/screen/theme_screen.dart';
import 'package:todolist_sqflite/screen/todos_by_category.dart';
import '../services/category_service.dart';
import '../services/profile_service.dart';
import '../src/app.dart';
import 'models/profile.dart';
import 'dart:io';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  var pickedImage;
  var name;
  var email;
  final _categoryList = <Widget>[];
  final CategoryService _categoriesService = CategoryService();
  final _profileService = ProfileService();
  List<Profile> _profileList = <Profile>[];

  @override
  void initState() {
    super.initState();
    getAllCategories();
    readProfile();
  }

  getAllCategories() async {
    var categories = await _categoriesService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TodosByCategory(category: category['name'])));
          },
          child: ListTile(
            title: Text(
              category['name'],
              style: TextStyle(
                  color: Provider.of<ThemeChanger>(context, listen: false)
                      .kDrawerLowerText),
            ),
          ),
        ));
      });
    });
  }

  readProfile() async {
    _profileList = <Profile>[];
    var profiles = await _profileService.readProfile();
    profiles.forEach((prof) {
      setState(() {
        var profileModel = Profile();
        profileModel.image = prof['image'];
        profileModel.name = prof['name'];
        profileModel.email = prof['email'];
        _profileList.add(profileModel);
        pickedImage = _profileList[0].image;
        name = _profileList[0].name;
        email = _profileList[0].email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          Provider.of<ThemeChanger>(context, listen: false).kBackgroundColor,
      child: ListView(
        children: [
          Container(
            color:
                Provider.of<ThemeChanger>(context, listen: false).kAppbarColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(110.0)),
                      border: Border.all(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kAppbarColor,
                        width: 5.0,
                      ),
                    ),
                    child: ClipOval(
                      child: pickedImage != null
                          ? Image.file(
                              File(pickedImage),
                              height: 180,
                              width: 180,
                              scale: 1,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'images/profile.jpg',
                              width: 180,
                              height: 180,
                            ),
                    ),
                  ),
                  Center(
                      child: Text(
                    name ?? 'Enter name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kDrawerUpperText,
                    ),
                  )),
                  Center(
                      child: Text(
                    email ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kDrawerUpperText,
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomDrawerTile(
            text: "Profile",
            icon: Icons.account_circle_rounded,
            onPressing: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen()));
            },
          ),
          CustomDrawerTile(
            text: "Home",
            icon: Icons.home,
            onPressing: () {
              Navigator.of(context).pop();
            },
          ),
          CustomDrawerTile(
            text: "Themes",
            icon: Icons.brush,
            onPressing: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ThemeScreen()));
            },
          ),
          CustomDrawerTile(
            text: "Categories",
            icon: Icons.view_list,
            onPressing: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CategoriesScreen()));
            },
          ),
          Divider(
            color: Provider.of<ThemeChanger>(context, listen: false)
                .kDrawerLowerText,
          ),
          Column(
            children: _categoryList,
          )
        ],
      ),
    );
  }
}

class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressing,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onPressing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            Provider.of<ThemeChanger>(context, listen: false).kDrawerLowerText,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: Provider.of<ThemeChanger>(context, listen: false)
                .kDrawerLowerText),
      ),
      trailing: Icon(Icons.arrow_right,
          color: Provider.of<ThemeChanger>(context, listen: false)
              .kDrawerLowerText),
      onTap: () {
        onPressing();
      },
    );
  }
}
