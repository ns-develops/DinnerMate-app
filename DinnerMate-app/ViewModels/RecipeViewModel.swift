//
//  RecipeViewModel.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//



import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
   
    func addRecipe(name: String, category: String, description: String) {
        let newRecipe = Recipe(name: name, category: category, description: description)
        recipes.append(newRecipe)
    }
    
  
    func getRandomRecipe() -> Recipe? {
        guard !recipes.isEmpty else { return nil }
        let randomIndex = Int.random(in: 0..<recipes.count)
        return recipes[randomIndex]
    }
}
