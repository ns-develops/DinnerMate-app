//
//  RecipeListView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//

// Views/RecipeListView.swift

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    Text(recipe.name)
                        .font(.headline)
                }
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
