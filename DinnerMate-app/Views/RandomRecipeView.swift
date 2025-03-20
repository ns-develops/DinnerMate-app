//
//  RandomReceipeView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//
//

//
import SwiftUI

struct RandomRecipeView: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack {
          
            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 40, height: 200) //
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 20)

     
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.5))
                    .shadow(radius: 10)
                    .padding()

                VStack(spacing: 10) {
                 
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top)

                  
                    Text("Category: \(recipe.category)")
                        .font(.title2)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
              
                    ScrollView {
                        Text(recipe.description)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.bottom)
                    }
                    .padding(.bottom)
                }
                .padding()
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .navigationBarTitle("Recipe", displayMode: .inline)
    }
}

struct RandomRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeView(recipe: Recipe(name: "Pasta Carbonara", category: "Meat", description: "A simple and delicious pasta carbonara recipe with eggs, cheese, and pancetta."))
    }
}
