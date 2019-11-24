//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Kévin Esprit on 24/11/2019.
//  Copyright © 2019 Kespri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTables = [Int]()
    @State private var preparingGame = true
    
    var body: some View {
        VStack(spacing: 20) {
            Section(header: Text("Table de multiplication")
                .font(.largeTitle)) {
                    HStack(spacing: 20) {
                        ForEach(1..<5) { index in
                            TableButton(tableNumber: index) {
                                self.changeTableSelection(isSelected: $0, number: index)
                            }
                        }
                    }
                    HStack(spacing: 20) {
                        ForEach(5..<9) { index in
                            TableButton(tableNumber: index){
                                self.changeTableSelection(isSelected: $0, number: index)
                            }
                        }
                    }
                    HStack(spacing: 20) {
                        ForEach(9..<13) { index in
                            TableButton(tableNumber: index){
                                print(index)
                                self.changeTableSelection(isSelected: $0, number: index)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        print(self.selectedTables)
                    }) {
                        Text("START")
                    }
                    .disabled(self.preparingGame)
                    .frame(width: 200, height: 60, alignment: .center)
                    .background(self.preparingGame ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .font(.title)
                    .blur(radius: self.preparingGame ? 3 : 0)
                    .animation(.default)
                    
            }
        }
    }
    
    func changeTableSelection(isSelected: Bool, number: Int) {
        if isSelected {
            self.selectedTables.append(number)
        } else {
            self.selectedTables.removeAll { number == $0 }
        }
        
        self.checkSettings()
    }
    
    func checkSettings() {
        
        guard !self.selectedTables.isEmpty else {
            self.preparingGame = true
            return
        }
        self.preparingGame = false
    }
}

struct TableButton: View {
    var tableNumber: Int
    var action: (Bool) -> Void
    @State private var selected = false
    
    var body: some View {
        Button("\(tableNumber)") {
            self.selected.toggle()
            self.action(self.selected)
        }
        .frame(width: 70, height: 50)
        .background(self.selected ? Color.red : Color.white)
        .foregroundColor(self.selected ? .white : .red)
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
