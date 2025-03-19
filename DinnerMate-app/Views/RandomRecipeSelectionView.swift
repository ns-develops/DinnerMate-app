//
//  RandomRecipeSelectionView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//

import SwiftUI

struct RandomRecipeSelectionView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    @State private var randomRecipe: Recipe?
    @State private var categoryInput: String = ""
    @State private var ingredientInput: String = ""
    
    var body: some View {
        VStack {
            Text("Choose how you want to eat today:")
                .font(.headline)
                .padding()
            
            // Fyrkant för "Any meal today"
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.4)) // Mörkare lila nyans
                    .frame(height: 150) // Större fyrkant
                    .shadow(radius: 5)
                
                Button(action: {
                    if let randomRecipe = viewModel.getRandomRecipe() {
                        self.randomRecipe = randomRecipe
                    }
                }) {
                    Text("Any meal today")
                        .foregroundColor(.white) // Texten blir vit för denna knapp
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            // Fyrkant för "From category"
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.4)) // Mörkare lila nyans
                    .frame(height: 150) // Större fyrkant
                    .shadow(radius: 5)
                
                VStack {
                    TextField("From category (t.ex. vegan)", text: $categoryInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        let category = categoryInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if !category.isEmpty {
                            if let randomRecipe = viewModel.getRandomRecipe(fromCategory: category) {
                                self.randomRecipe = randomRecipe
                            } else {
                                self.randomRecipe = nil
                            }
                        }
                    }) {
                        Text("From category")
                            .foregroundColor(.white) // Texten blir vit för denna knapp
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Fyrkant för "Choose from your ingredients"
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.4)) // Mörkare lila nyans
                    .frame(height: 150) // Större fyrkant
                    .shadow(radius: 5)
                
                VStack {
                    TextField("Add ingredient (t.ex. meat, tomato)", text: $ingredientInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        let ingredient = ingredientInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if !ingredient.isEmpty {
                            if let randomRecipe = viewModel.getRandomRecipe(fromIngredient: ingredient) {
                                self.randomRecipe = randomRecipe
                            } else {
                                self.randomRecipe = nil
                            }
                        }
                    }) {
                        Text("Choose from your ingredients")
                            .foregroundColor(.white) // Texten blir vit för denna knapp
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Visa slumpat recept
            if let randomRecipe = randomRecipe {
                NavigationLink(destination: RandomRecipeView(recipe: randomRecipe)) {
                    Text("Todays Dinner!")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }

            Spacer()
        }
        .navigationBarTitle("Let me know what I should eat?", displayMode: .inline)
    }
}

struct RandomRecipeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeSelectionView(viewModel: RecipeViewModel())
    }
}
