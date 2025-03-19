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
                
                // Knapp för att navigera till RandomRecipeSelectionView
                NavigationLink(destination: RandomRecipeSelectionView(viewModel: viewModel)) {
                    Text("Slumpa ett recept")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarTitle("Recept Lista")
            .navigationBarItems(trailing: NavigationLink("Lägg till", destination: AddRecipeView(viewModel: viewModel)))
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(viewModel: RecipeViewModel())
    }
}
