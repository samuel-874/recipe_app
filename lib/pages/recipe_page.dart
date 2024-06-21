

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipePage extends StatelessWidget{

  final Recipe recipe;

  const RecipePage({
    super.key,
    required this.recipe,
});

  @override
  build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('RecipeBook'),
        centerTitle: true,
        backgroundColor: Colors.white60,
      ),
      body: _buildUI(context)
    );
  }

  SingleChildScrollView _buildUI(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
              children: [
                _recipeImage(context),
                _recipeDetails(context),
                _recipeIngredient(context),
                _recipeInstruction(context)
              ]
          )
      );
  }

  Widget _recipeImage(BuildContext context){

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(recipe.image)
        )
      ),
    );
  }

  Widget _recipeDetails(BuildContext context){
      return Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${recipe.cuisine}, ${recipe.difficulty}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300
              ),
            ),
            Text(
                recipe.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Prep Time: ${recipe.prepTimeMinutes} Minutes || Cook Time: ${recipe.cookTimeMinutes} Minutes",
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300
              ),
            ),
            Text(
              "Rating: ${recipe.rating} ⭐ || ${recipe.reviewCount} Reviews",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      );
  }

  Widget _recipeIngredient(BuildContext context){
      return Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recipe.ingredients.map((i) {
             return Row(
                      children: [
                        const Icon(Icons.check_box),
                        Text(" $i")
                      ],
                );
            }).toList(),
        ),
      );
  }

  Widget _recipeInstruction(BuildContext context){
    return Container(
      color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20
        ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: recipe.instructions.map((item){
            return Text("${recipe.instructions.indexOf(item)} $item \n",
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15.0)
            );
      }).toList()
      )
    );

  }
  
}

