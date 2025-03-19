//
//  AddRecipeView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//

import SwiftUI

struct AddRecipeView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            TextField("Recept namn", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Kategori (ex. meat, vegetarian)", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Använd TextEditor för beskrivning
            TextEditor(text: $description)
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 20)
            
            Button(action: {
                if !name.isEmpty && !category.isEmpty && !description.isEmpty {
                    viewModel.addRecipe(name: name, category: category, description: description)
                    name = ""
                    category = ""
                    description = ""  
                }
            }) {
                Text("Lägg till recept")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Lägg till Recept")
        .padding()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: RecipeViewModel())
    }
}
