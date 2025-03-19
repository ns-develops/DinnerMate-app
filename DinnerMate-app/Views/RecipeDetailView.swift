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
    
    // State för att visa delningsvyn eller SMS-komposering
    @State private var showingShareSheet = false
    @State private var showingSMSComposer = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Receptnamn med stil
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                
                // Receptkategori
                Text("Kategori: \(recipe.category)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
                
                // Receptbild - här kan du ersätta med en verklig bild i framtiden
                Image(systemName: "leaf.fill") // En tillfällig bild, kan bytas ut med en verklig bild från data
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(15)
                    .padding(.top, 15)
                    .shadow(radius: 10)
                
                // Beskrivning
                Text(recipe.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                // Knapp för att dela receptet
                VStack {
                    HStack {
                        // Dela via andra appar
                        Button(action: {
                            showingShareSheet.toggle() // Visa delningsvyn
                        }) {
                            Text("Dela Recept")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .frame(height: 50)

                        Spacer()

                        // Dela via SMS
                        Button(action: {
                            showingSMSComposer.toggle() // Visa SMS-komposering
                        }) {
                            Text("Dela via SMS")
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
                    
                    // Placera knapparna horisontellt på rad
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Receptdetaljer", displayMode: .inline)
        .background(Color(.systemGroupedBackground)) // Lägger till bakgrundsfärg
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [self.recipe.name, self.recipe.description]) // Visar delningsvyn
        }
        .sheet(isPresented: $showingSMSComposer) {
            SMSComposerView(recipe: self.recipe) // Visar SMS-komposering
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(name: "Steak", category: "Meat", description: "A delicious steak recipe."))
    }
}

// SwiftUI wrapper för UIActivityViewController (för delning)
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let shareSheet = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return shareSheet
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Ingen uppdatering behövs, vi skapar delningsvyn när den visas
    }
}

// SwiftUI wrapper för MFMessageComposeViewController (för att skicka SMS)
struct SMSComposerView: UIViewControllerRepresentable {
    var recipe: Recipe
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composer = MFMessageComposeViewController()
        
        // Sätt upp SMS-innehåll
        composer.body = "Kolla på detta recept: \(recipe.name)\nKategori: \(recipe.category)\nBeskrivning: \(recipe.description)"
        
        composer.messageComposeDelegate = context.coordinator
        
        // Kontrollera om SMS-komposering är tillgänglig
        if !MFMessageComposeViewController.canSendText() {
            // Om SMS inte kan skickas (t.ex. om simulatorn används utan SMS-funktion)
            print("SMS-komposering är inte tillgänglig.")
        }
        
        return composer
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        // Ingen uppdatering behövs, vi skapar SMS-komposering när den visas
    }
    
    // Coordinator för att hantera händelser från MFMessageComposeViewController
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil) // Stäng komposeringen
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
