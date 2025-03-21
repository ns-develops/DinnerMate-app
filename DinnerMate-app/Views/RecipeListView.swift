//
//  RecipeListView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//


import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name)
                            .font(.headline)
                    }
                }
                
                
                NavigationLink(destination: RandomRecipeSelectionView(viewModel: viewModel)) {
                    Text("Pick Dinner")
                        .font(.title2)
                        .padding()
                        .background(Color.pink.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarTitle("Recipes")
            .navigationBarItems(trailing: NavigationLink("Add Recipe", destination: AddRecipeView(viewModel: viewModel)))
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(viewModel: RecipeViewModel())
    }
}
