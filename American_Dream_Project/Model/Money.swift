//
//  converterMoneyModel.swift
//  test_Projet_9
//
//  Created by Wandianga on 6/28/20.
//  Copyright © 2020 Wandianga. All rights reserved.
//

import Foundation


// MARK: - Money
struct Money: Codable {
    let base: String
    let date: String
    let monnaie: Rates
    var baseConversion : Double {
        return monnaie.dollar
    }
    enum CodingKeys: String, CodingKey {
        case monnaie = "rates"
        case base
        case date
    }
}

extension Money : CustomStringConvertible {
    var description: String {
        return "Base Money : \(base), date : \(date), Conversion : \(baseConversion)$"
    }
}

struct Rates : Codable {
    let dollar: Double
    let cfa: Double
    enum CodingKeys: String, CodingKey {
        case dollar = "USD"
        case cfa = "XOF"
    }
}
