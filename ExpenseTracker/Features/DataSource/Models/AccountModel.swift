//
//  AccountModel.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import Foundation

public enum ExpenseCategory: String, Codable, CaseIterable{
    case food = "Food"
    case health_fitness = "Health & Fitness"
    case salary = "Salary"
    case entertainment = "Entertainment"
    case gym = "GYM"
    case tax = "Tax"
    case grocery = "Grocery"
}

public struct AccountModel: Codable, Equatable {
    var accountName: String?
    var balance: Double?
    var transactions = [TransactionModel]()
    
    func getBalance() -> Double {
        let balance = transactions.map({($0.amount ?? 0.0)}).reduce(0.0, +) / Double(transactions.count)
        return balance
    }
    
    public static func ==(lhs: AccountModel,rhs:AccountModel) -> Bool{
        return lhs.accountName == rhs.accountName && lhs.balance == rhs.balance && lhs.transactions == rhs.transactions
    }
}

public struct TransactionModel: Equatable, Codable {
    var concept: ExpenseCategory?
    var amount: Double?
    var date: Date?
    
    public static func ==(lhs: TransactionModel,rhs:TransactionModel) -> Bool{
        return lhs.concept == rhs.concept && lhs.amount == rhs.amount && lhs.date == rhs.date
    }
}

