//
//  RecipeViewModel.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//


import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    // Lägg till ett nytt recept
    func addRecipe(name: String, category: String, description: String) {
        let newRecipe = Recipe(name: name, category: category, description: description)
        recipes.append(newRecipe)
    }
}
