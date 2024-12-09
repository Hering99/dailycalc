//
//  ContentView.swift
//  dailycalc
//
//  Created by Lukas Hering on 09.12.24.
//

import SwiftUI

struct ContentView: View {
    @State private var firstNumber = Int.random(in: 1...99)
    @State private var secondNumber = Int.random(in: 1...99)
    @State private var options: [Int] = Array(repeating: 0, count: 4)
    @State private var correctAnswer: Int = 0
    @State private var feedback: String = ""
    @State private var streak: Int = 0 // Streak counter
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            Text("Was ist das Ergebnis?")
                .font(.title)
                .bold()
            
            
            Text("\(firstNumber) × \(secondNumber) = ?")
                .font(.largeTitle)
                .bold()
            
            ForEach(0..<options.count, id: \.self) { index in
                Button(action: {
                    checkAnswer(options[index])
                }) {
                    Text("\(options.indices.contains(index) ? options[index] : 0)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Text(feedback)
                .font(.title2)
                .foregroundColor(feedback == "Richtig!" ? .green : .red)
                .padding(.top, 20)
            
            Text("Streak: \(streak)")
                .font(.title2)
                .foregroundColor(.orange)
            
            Button("Neue Frage") {
                generateQuestion()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
        .onAppear(perform: generateQuestion)
    }
    
    func generateQuestion() {
        // Neue Zufallszahlen und richtige Antwort generieren
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        correctAnswer = firstNumber * secondNumber
        
        // Antwortmöglichkeiten generieren
        options = generateOptions(correctAnswer: correctAnswer)
        feedback = ""
    }
    
    func generateOptions(correctAnswer: Int) -> [Int] {
        var allOptions = [correctAnswer]
        
        // Falsche Antworten generieren (nahe der richtigen Antwort)
        while allOptions.count < 4 {
            let offset = Int.random(in: -10...10) // Abstand zur richtigen Antwort
            let randomOption = correctAnswer + offset
            
            // Antwort muss positiv sein und darf nicht doppelt sein
            if randomOption > 0 && randomOption != correctAnswer && !allOptions.contains(randomOption) {
                allOptions.append(randomOption)
            }
        }
        
        return allOptions.shuffled()
    }
    
    func checkAnswer(_ answer: Int) {
        if answer == correctAnswer {
            feedback = "Richtig!"
            streak += 1 // Streak erhöhen
        } else {
            feedback = "Falsch!"
            streak = 0 // Streak zurücksetzen
        }
    }
}

