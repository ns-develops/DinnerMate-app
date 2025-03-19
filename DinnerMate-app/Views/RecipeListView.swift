//
//  RecipeListView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//



import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    @State private var randomRecipe: Recipe?
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name)
                            .font(.headline)
                    }
                }
                
      
                Button(action: {
                    if let randomRecipe = viewModel.getRandomRecipe() {
                        self.randomRecipe = randomRecipe 
                    }
                }) {
                    Text("Do you want me to choose what to eat?")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if let randomRecipe = randomRecipe {
                    NavigationLink(destination: RandomRecipeView(recipe: randomRecipe)) {
                        Text("Todays Dinner")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Recipe List")
            .navigationBarItems(trailing: NavigationLink("Add", destination: AddRecipeView(viewModel: viewModel)))
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(viewModel: RecipeViewModel())
    }
}
