//
//  ContentView.swift
//  BetterRest
//
//  Created by Joan May on 28/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    var body: some View {
        // Day 26 - Entering numbers with stepper
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        
    }
}

#Preview {
    ContentView()
}
