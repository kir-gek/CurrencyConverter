//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Кирилл Гекман on 16.06.2023.
//

import SwiftUI



struct CurrencyResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    //    let rates: [СurrencyValue]
    let rates: [String: Double]
}

struct СurrencyValue: Codable {
    let Сurrency: String
    let Value: Double
}

struct ContentView: View {
    
    @State private var convertedAmount: String = ""
    @State private var isShowingPopup = false
    //    @State private var currentRates: [СurrencyValue] = []
    @State private var currentRates: [String: Double] = [:]
    @State private var country_currency = ["EUR": "IT",
                                           "AED": "AE",
                                           "COP": "CO",
                                           "PEN": "PE",
                                           "USD": "US",
                                           "AFN": "AF",
                                           "ARS": "AR",
                                           "AUD": "KI",
                                           "BYN": "BY",
                                           "RUB": "RU",
    ]
    @State private var selectedCurrency: [String: Double] = [:]
    
    var body: some View {
        VStack {
            
            if !currentRates.isEmpty {
                List {
                    
                    ForEach (currentRates.sorted(by: { $0.key < $1.key }), id: \.key) { currency in
                        VStack(alignment: .leading) {
                            
                            HStack {
                                VStack {
                                    Text(currency.key)
                                        .font(.headline)
                                    Image(country_currency[currency.key]!)
                                        .resizable()
                                        .frame(width: 35, height: 35.0)
                                }
                                Spacer()
                                Text("1 EUR = \(currency.value)")
                                    .font(.subheadline)
                            }
                            
                        }
                        .onTapGesture {
                            print("click \(currency.key)")
                            selectedCurrency = [currency.key: currency.value]
      
                            isShowingPopup = true

                        }
                    }
                    
                }.sheet(isPresented: $isShowingPopup) {
                        PopupView(selCurrency: $selectedCurrency, isShowingPopup: $isShowingPopup)
                }
            }
            else {
                Text("Загрузка...")
                    .onAppear {
                        getCurrency()
                    }
            }
        }
    }
    
    func getCurrency() {
        
        let thisAPIKEY:String = "12b86acf88840f6b1528704a423f08f5"
        
        let urlString = "http://api.exchangeratesapi.io/latest?access_key=\(thisAPIKEY)"
        guard let url = URL(string: urlString) else {
            convertedAmount = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(CurrencyResponse.self, from: data) {
                    DispatchQueue.main.async {
                        currentRates = response.rates.filter({ country_currency.keys.contains($0.key) })
                    }
                } else {
                    convertedAmount = "failed"
                }
            } else {
                convertedAmount = "failed"
            }
        }.resume()
    }
}

struct PopupView: View {
    
    @Binding var selCurrency: [String: Double]
    @Binding var isShowingPopup: Bool
    @State private var country_currency = ["EUR": "IT",
                                           "AED": "AE",
                                           "COP": "CO",
                                           "PEN": "PE",
                                           "USD": "US",
                                           "AFN": "AF",
                                           "ARS": "AR",
                                           "AUD": "KI",
                                           "BYN": "BY",
                                           "RUB": "RU",
    ]
    
    var body: some View {
        VStack {
            
//            if let keys = selCurrency.keys.first
//            {
            Text(selCurrency.keys.first!)
                    .font(.title)
                    .padding()
                
            Image(country_currency[selCurrency.keys.first!]!)
                    .resizable()
                    .frame(width: 60, height: 60.0)
                
            let str:String = String(format: "%.1f",selCurrency[selCurrency.keys.first!]!)
            Text("1 EUR = \(str)")
                    .font(.subheadline)
                
                Button("Close") {
                    dismiss()
                }
                .padding()
            
        }
    }
    
    private func dismiss() {
        isShowingPopup = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
