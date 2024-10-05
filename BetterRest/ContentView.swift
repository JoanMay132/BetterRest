//
//  ContentView.swift
//  BetterRest
//
//  Created by Joan May on 28/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount : Int = 1
    
    var body: some View {
        // Day 26 - Entering numbers with stepper
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        // Day 26 - Selecting dates and times with Datepicker
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
            .labelsHidden()
        Text(Date.now.formatted(date: .long, time: .shortened))
        
    }
    
    // Day 26 - Working with dates
    func exampleDates() {
        //        let now = Date.now
        //        let tomorrow = Date.now.addingTimeInterval(86400)
        //        let range = now...tomorrow
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: .now)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
    }
    

}


#Preview {
    ContentView()
}
