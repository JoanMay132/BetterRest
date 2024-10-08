//
//  BuildingABasicLayout.swift
//  BetterRest
//
//  Created by Joan May on 30/09/24.
//
import CoreML
import SwiftUI

// Day 27 - Building a Basic Layout
struct BuildingABasicLayout: View {
    @State private var coffeeAmount: Int = 1
    @State private var sleepAmount : Double = 8.0
    @State private var wakeUp = defaultWakeTime
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
   var bedTime : String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
           
        } catch {
            return "Error, there was a problem calculating your bedtime"
           
        }


    }
    var body: some View {
        
        NavigationStack {
            Form {
                Section("When do you want to wake up? ") {
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                //More to come
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
//                    Stepper(coffeeAmount == 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1...20, id : \.self) { coffee in
                            Text("\(coffee)")
                            
                        }
                    }
//                    Picker(coffeeAmount == 1 ? "Cup" : "Cups", selection: $coffeeAmount) {
//                        ForEach(1...20, id : \.self) { coffee in
//                            Text("\(coffee)")
//                        }
//                    }
                }
                Text(bedTime)
                    .font(.title3)
            }
            
            .navigationTitle("BetterRest")
            
//            .toolbar {
//                Button("Calculate",action: calculateBedTime)
//            } .alert(alertTitle, isPresented: $showingAlert){
//                Button("OK"){}
//            }message: {
//                    Text(alertMessage)
//                }
            
        }
    }
    func calculateBedTime() {
  
    }
}
    



#Preview {
    BuildingABasicLayout()
}
