import 'package:flutter/material.dart';
import 'package:meals/widgets/drawer_contents.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter-meals';
  final Function filter;
  final Map<String, bool> currentFilter;
  FiltersScreen(this.filter,  this.currentFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState(){
      _glutenFree = widget.currentFilter['gluten'];
      _lactoseFree = widget.currentFilter['lactose'];
      _vegan = widget.currentFilter['vegan'];
      _vegetarian = widget.currentFilter['vegetarian'];
      super.initState();
    }

  Widget _buildSwitchListTile(String text, bool key, Function change){
    return SwitchListTile(
        title: Text(text),
        subtitle: Text('Only include $text meals.'),
        value: key,
        onChanged: change,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.filter(selectedFilters);
              }
          )
        ],
      ),
       drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten-free',
                      _glutenFree,
                        (newVal) {
                          setState(() {
                           _glutenFree = newVal;
                        });
                      },
                  ),
                  _buildSwitchListTile(
                      'Lactose-free',
                      _lactoseFree,
                        (newVal) {
                         setState(() {
                        _lactoseFree = newVal;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                      'Vegetarian',
                      _vegetarian,
                        (newVal) {
                       setState(() {
                        _vegetarian = newVal;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                      'Vegan',
                      _vegan,
                        (newVal) {
                      setState(() {
                        _vegan = newVal;
                      });
                    },
                  )
                ],
            ),
          )
        ],
      ),
    );
  }
}
