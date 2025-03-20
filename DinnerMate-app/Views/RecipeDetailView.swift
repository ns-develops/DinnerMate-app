//
//  RecipeDetailView.swift
//  DinnerMate-app
//
//  Created by Natalie S on 2025-03-19.
//
import SwiftUI
import UIKit
import MessageUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    @State private var showingShareSheet = false
    @State private var showingSMSComposer = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Recipe Name in a Rectangle
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.2))
                        .frame(height: 60)
                    
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading) // Align text to the left
                        .padding()
                }
                .padding(.top, 20)
                
                // Category in a Rectangle
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.green.opacity(0.2))
                        .frame(height: 60)
                    
                    Text("Category: \(recipe.category)")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading) // Align text to the left
                        .padding()
                }
                
                // Recipe Image
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(15)
                    .padding(.top, 15)
                    .shadow(radius: 10)
                
                // Recipe Description in a Rectangle
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.yellow.opacity(0.2))
                        .frame(height: 150)
                    
                    Text(recipe.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding()
                        .multilineTextAlignment(.leading) // Align text to the left
                }
                
                VStack {
                    HStack {
                        // Share Recipe Button
                        Button(action: {
                            showingShareSheet.toggle() // Show share sheet
                        }) {
                            Text("Share Recipe")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .frame(height: 50)

                        Spacer()

                        // Share on SMS Button
                        Button(action: {
                            showingSMSComposer.toggle() // Show SMS Composer
                        }) {
                            Text("Share on SMS")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .frame(height: 50)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Receptdetaljer", displayMode: .inline)
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [self.recipe.name, self.recipe.description]) // Show share sheet
        }
        .sheet(isPresented: $showingSMSComposer) {
            SMSComposerView(recipe: self.recipe) // Show SMS Composer
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(name: "Steak", category: "Meat", description: "A delicious steak recipe."))
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let shareSheet = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return shareSheet
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct SMSComposerView: UIViewControllerRepresentable {
    var recipe: Recipe
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composer = MFMessageComposeViewController()
        
        composer.body = "Check this recipe: \(recipe.name)\nCategory: \(recipe.category)\nDescription: \(recipe.description)"
        composer.messageComposeDelegate = context.coordinator
        
        if !MFMessageComposeViewController.canSendText() {
            print("SMS-composer not available")
        }
        
        return composer
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
