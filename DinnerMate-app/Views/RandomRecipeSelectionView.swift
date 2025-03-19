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
    
    var body: some View {
        VStack {
            Text("Välj hur du vill slumpa ett recept")
                .font(.headline)
                .padding()
            
            // Knappar för att slumpa recept
            Button(action: {
                // Slumpa utan kategori
                if let randomRecipe = viewModel.getRandomRecipe() {
                    self.randomRecipe = randomRecipe
                }
            }) {
                Text("Slumpa ett recept utan kategori")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

          
            TextField("Ange kategori (t.ex. kött, vegetariskt)", text: $categoryInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
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
                Text("Slumpa recept från kategori")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            
            if let randomRecipe = randomRecipe {
                NavigationLink(destination: RandomRecipeView(recipe: randomRecipe)) {
                    Text("Visa slumpat recept")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Slumpa Recept", displayMode: .inline)
    }
}

struct RandomRecipeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeSelectionView(viewModel: RecipeViewModel())
    }
}
