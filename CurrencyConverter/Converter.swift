//
//  Converter.swift
//  CurrencyConverter
//
//  Created by Кирилл Гекман on 20.06.2023.
//"BYNRUB","CADRUB","CHFRUB","CNYEUR","CNYRUB","CNYUSD","EURAED","EURAMD","EURBGN","EURBYN","EURGBP","EURJPY","EURKZT","EURRUB","EURTRY","EURUSD","GBPAUD","GBPBYN","GBPJPY","GBPRUB","GELRUB","GELUSD","IDRUSD","JPYAMD","JPYAZN","JPYRUB","LKREUR","LKRRUB","LKRUSD","MDLEUR","MDLRUB","MDLUSD","MMKEUR","MMKRUB","MMKUSD","RSDEUR","RSDRUB","RSDUSD","RUBAED","RUBAMD","RUBAUD","RUBBGN","RUBKZT","RUBMYR","RUBNZD","RUBSGD","RUBTRY","RUBUAH","THBCNY","THBEUR","THBRUB","USDAED","USDAMD","USDAUD","USDBGN","USDBYN","USDCAD","USDGBP","USDILS","USDJPY","USDKGS","USDKZT","USDMYR","USDRUB","USDTHB","USDUAH","USDVND"

import SwiftUI

struct CurResponse: Codable {
    let status: Int
    let message: String
    let data: [String: String]
}

struct CurrencyData: Codable {
    let rates: [String: String]
}


struct ConverterVC: View {
    let arr = [
//        "BYN": ["RUB"],
//        "CAD": ["RUB"],
//        "CHF": ["RUB"],
//        "CNY": ["EUR", "RUB", "USD"],
//        "EUR": ["AED", "AMD", "BGN", "BYN", "GBP", "JPY", "KZT", "RUB", "TRY", "USD"],
//        "GBP": ["AUD", "BYN", "JPY", "RUB"],
//        "GEL": ["RUB", "USD"],
//        "IDR": ["USD"],
        "JPY": ["AMD", "AZN", "RUB"],
        "LKR": ["EUR", "RUB", "USD"],
        "MDL": ["EUR", "RUB", "USD"],
        "MMK": ["EUR", "RUB", "USD"],
        "RSD": ["EUR", "RUB", "USD"],
//        "RUB": ["AED", "AMD", "AUD", "BGN", "KZT", "MYR", "NZD", "SGD", "TRY", "UAH"],
        "THB": ["CNY", "EUR", "RUB"],
//        "USD": ["AED", "AMD", "AUD", "BGN", "BYN", "CAD", "GBP", "ILS", "JPY", "KGS", "KZT", "MYR", "RUB", "THB", "UAH", "VND"]
    ]
    
    @State private var convertedAmount: String = "Loading..."
    @State private var currentRates: [String: String] = [:]
    
    @State private var strNumber = ""
    
    @State private var firstPickerIndex = 0
    @State private var secondPickerIndex = 0
    
    var firstPickerData: [String] {
        Array(arr.keys)
    }
    
    var secondPickerData: [String] {
        let firstPickerKey = firstPickerData[firstPickerIndex]
        return arr[firstPickerKey] ?? []
    }
    
    var body: some View {
        
        
        if !currentRates.isEmpty {
            NavigationStack {
                
                Form {
                    
                    Section
                    {
                        TextField("0", text: $strNumber)
                    }
                    
                    Section
                    {
                        Picker(selection: $firstPickerIndex, label: Text("From")) {
                            ForEach(0..<firstPickerData.count, id: \.self) { index in
                                Text(firstPickerData[index]).tag(index)
                            }
                        }
                        
                        Picker(selection: $secondPickerIndex, label: Text("Do")) {
                            ForEach(0..<secondPickerData.count, id: \.self) { index in
                                Text(secondPickerData[index]).tag(index)
                            }
                        }
                    }
                    
                    Section {
                        
                        let keyCurrency = "\(firstPickerData[firstPickerIndex])\(secondPickerData[secondPickerIndex])"
                        let doubleCur = Double(currentRates[keyCurrency]!)
                        if let strNum = Double(strNumber)
                        {
                            Text("\(strNum*doubleCur!)")
                        }
                        else
                        {
                            Text("0")
                        }
                    }
                    
                }.navigationTitle("Currency Converter")
                
            }
        } else {
            Text(convertedAmount)
                .onAppear {
                    getCurrency()
                }
        }
    }
    
    func getCurrency() {
        
        let thisAPIKEY:String = "b7e24d9ae6a8e2d50877464f629c9091"
        let curren = "JPYAMD,JPYAZN,JPYRUB,LKREUR,LKRRUB,LKRUSD,MDLEUR,MDLRUB,MDLUSD,MMKEUR,MMKRUB,MMKUSD,RSDEUR,RSDRUB,RSDUSD,THBCNY,THBEUR,THBRUB"
        
        let urlString = "https://currate.ru/api/?get=rates&pairs=\(curren)&key=\(thisAPIKEY)"
        guard let url = URL(string: urlString) else {
            convertedAmount = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(CurResponse.self, from: data) {
                    DispatchQueue.main.async {
                        currentRates = response.data
                    }
                } else {
                    convertedAmount = "failed decode"
                }
            } else {
                convertedAmount = "failed data"
            }
        }.resume()
    }
    
}


struct ConverterVC_Previews: PreviewProvider {
    static var previews: some View {
        TabVc()
    }
}
