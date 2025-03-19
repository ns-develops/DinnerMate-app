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
            
        
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 100)
                    .shadow(radius: 5)
                
                Button(action: {
                    if let randomRecipe = viewModel.getRandomRecipe() {
                        self.randomRecipe = randomRecipe
                    }
                }) {
                    Text("Any meal today")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
          
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green.opacity(0.1))
                    .frame(height: 100)
                    .shadow(radius: 5)
                
                VStack {
                    TextField("From category (t.ex. Vegan)", text: $categoryInput)
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
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
     
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.1))
                    .frame(height: 100)
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
                        Text("Choose from your ingrendients")
                            .foregroundColor(.purple)
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
