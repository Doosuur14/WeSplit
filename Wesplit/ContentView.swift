//
//  ContentView.swift
//  Wesplit
//
//  Created by Faki Doosuur Doris on 06.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var amountIsFocused: Bool

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        
        
        var totalPerPerson: Double{
            
            let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPercentage)
            
            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount
            
            return amountPerPerson
        }
        
        
        var totalWithTip: Double{
            
            let newValue = Double(tipPercentage)
            let tipPercent = checkAmount / 100 * newValue
            let finalTotal =  checkAmount + tipPercent

            return finalTotal
        }
        
        
       
        
      
            
        
        
        //to fill in the total amount
        NavigationView{
            Form{
                Section{
                    
                    if tipPercentage > 0{
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ??  "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }else {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ??  "USD"))
                            .modifier(titleViewEdit())
                    }
                                        
                    
                    Picker("Number of people" , selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        
                    }
                }
                
                //section to choose percentage
                Section{
                    TextField( "Tip percentage", value: $tipPercentage , format:.percent)
                            .keyboardType(.numberPad)
                    
                    
//                    Picker("Tip Percentage" , selection: $tipPercentage){
//                        //ForEach(tipPercentages , id: \.self){
//                        ForEach(0..<101){ //Added this to expand the percentage options.
//                            Text($0, format: .percent)
//                        }
//                    }
//                        //.pickerStyle(.segmented)
                    
                } header: {
                    Text(" How much tip do you want to leave? ")
                }
                
                
                Section{
                    Text(totalWithTip,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text(" Grand total with tip included")
                }
                
                
                Section{
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text(" Total amount per person (tip included) ")
                }
                
            
                
                
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

//changing text view to red if the person picks 0% text view.
struct titleViewEdit: ViewModifier{
    func body(content: Content) -> some View{
        content
            .foregroundColor(.red)
    }
}
extension View{
    func textStyle() -> some View{
        modifier(titleViewEdit())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
