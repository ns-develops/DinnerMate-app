//
//  RandomReceipeView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//

import SwiftUI

struct RandomRecipeView: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Category: \(recipe.category)")
                .font(.title2)
                .padding(.bottom)
            
            ScrollView {
                Text(recipe.description)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarTitle("Recipe", displayMode: .inline)
        .padding()
    }
}

struct RandomRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeView(recipe: Recipe(name: "Pasta Carbonara", category: "Meat", description: "A simple and delicious pasta carbonara recipe with eggs, cheese, and pancetta."))
    }
}
