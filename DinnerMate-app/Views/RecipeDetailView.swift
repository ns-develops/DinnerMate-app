//
//  RecipeDetailView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Kategori: \(recipe.category)")
                .font(.title2)
                .padding(.bottom)
            
            Text(recipe.description)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("Recept Detaljer", displayMode: .inline)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(name: "Steak", category: "Meat", description: "A delicious steak recipe."))
    }
}
