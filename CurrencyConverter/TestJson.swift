//
//  TestJson.swift
//  CurrencyConverter
//
//  Created by Кирилл Гекман on 16.06.2023.
//

import Foundation

struct vc {
    func myJs() -> CurrencyResponse? {
        let json = """
["success":true,"timestamp":1687080663,"base":"EUR","date":"2023-06-18","rates":{"AED":4.02576,"AFN":93.95886,"ALL":108.152645,"AMD":422.914826,"ANG":1.971737,"AOA":778.762158,"ARS":271.852069,"AUD":1.593589,"AWG":1.972926,"AZN":1.867671,"BAM":1.954944,"BBD":2.208933,"BDT":118.428146,"BGN":1.958739,"BHD":0.41202,"BIF":3090.246932,"BMD":1.09607,"BND":1.46226,"BOB":7.55969,"BRL":5.276098,"BSD":1.094021,"BTC":4.1404346e-5,"BTN":89.571381,"BWP":14.471664,"BYN":2.761491,"BYR":21482.973654,"BZD":2.205234,"CAD":1.44917,"CDF":2603.166847,"CHF":0.979833,"CLF":0.031466,"CLP":868.23984,"CNY":7.810929,"COP":4540.212063,"CRC":591.341081,"CUC":1.09607,"CUP":29.045857,"CVE":110.221739,"CZK":23.77793,"DJF":194.794709,"DKK":7.461721,"DOP":60.083692,"DZD":148.285073,"EGP":33.774212,"ERN":16.441051,"ETB":59.584011,"EUR":1,"FJD":2.410043,"FKP":0.854681,"GBP":0.855002,"GEL":2.855307,"GGP":0.854681,"GHS":12.362587,"GIP":0.854681,"GMD":65.110787,"GNF":9405.881623,"GTQ":8.571247,"GYD":231.388686,"HKD":8.572091,"HNL":26.934207,"HRK":7.646308,"HTG":152.613178,"HUF":374.236733,"IDR":16398.797764,"ILS":3.89922,"IMP":0.854681,"INR":89.785133,"IQD":1433.172484,"IRR":46322.666126,"ISK":149.657832,"JEP":0.854681,"JMD":168.896049,"JOD":0.777557,"JPY":155.483065,"KES":152.283323,"KGS":96.0052,"KHR":4505.027468,"KMF":493.396369,"KPW":986.463076,"KRW":1400.014475,"KWD":0.336341,"KYD":0.911701,"KZT":489.935481,"LAK":20153.175907,"LBP":16421.409865,"LKR":339.151502,"LRD":192.771369,"LSL":19.926972,"LTL":3.23641,"LVL":0.663002,"LYD":5.265694,"MAD":10.890931,"MDL":19.632404,"MGA":4947.833585,"MKD":61.593031,"MMK":2297.494039,"MNT":3768.298925,"MOP":8.817539,"MRO":391.296832,"MUR":49.618275,"MVR":16.830199,"MWK":1122.908333,"MXN":18.720991,"MYR":5.05782,"MZN":69.326847,"NAD":19.926968,"NGN":719.574095,"NIO":40.01248,"NOK":11.494054,"NPR":143.31425,"NZD":1.75779,"OMR":0.420806,"PAB":1.094021,"PEN":3.983756,"PGK":3.897294,"PHP":61.067587,"PKR":314.106468,"PLN":4.474544,"PYG":7922.53111,"QAR":3.990833,"RON":4.969038,"RSD":117.127715,"RUB":91.525896,"RWF":1248.453363,"SAR":4.108807,"SBD":9.134989,"SCR":14.988437,"SDG":659.290187,"SEK":11.676271,"SGD":1.468351,"SHP":1.333644,"SLE":24.672455,"SLL":21647.384537,"SOS":623.119859,"SRD":41.209499,"STD":22686.43779,"SVC":9.572809,"SYP":2753.909759,"SZL":19.871299,"THB":37.993119,"TJS":11.952267,"TMT":3.847206,"TND":3.374256,"TOP":2.562287,"TRY":25.889618,"TTD":7.424749,"TWD":33.607924,"TZS":2611.456571,"UAH":40.40251,"UGX":4027.236669,"USD":1.09607,"UYU":41.84168,"UZS":12540.509123,"VEF":2976199.545972,"VES":29.86124,"VND":25790.529085,"VUV":127.64564,"WST":2.940878,"XAF":655.669914,"XAG":0.0453,"XAU":0.00056,"XCD":2.962185,"XDR":0.820541,"XOF":655.669914,"XPF":119.965269,"YER":274.401544,"ZAR":19.936112,"ZMK":9865.949977,"ZMW":21.141743,"ZWL":352.93412}]
"""
        
        if let data = json.data(using: .utf8) {
            do {
                let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)

                return response
            } catch {
                print("Ошибка декодирования JSON: (error)")
            }
        }
        
        return nil
        
    }
}