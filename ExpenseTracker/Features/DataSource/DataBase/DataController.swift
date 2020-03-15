//
//  DataController.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import Foundation
import EasyStash

public class DataController {
    var options: Options?
    var storage: Storage?
    
    init () {
        initOptions()
    }
    
    func initOptions(){
        var options = Options()
        options.folder = "ExpenseTrackerAccounts"
        storage = try! Storage(options: options)
    }
    
    public func addTransaction_toAccount(transaction: TransactionModel,to accountName: String){
        guard let accounts = getAllAccounts() else { return }
        //accounts[0].transactions?.first(where: {$0 == transaction})

        var accountToUpdate = accounts.first(where: {$0.accountName == accountName})
        accountToUpdate?.transactions.append(transaction)
        
        do {
            try storage?.save(object: accounts, forKey: "accounts")
        } catch {
            print(error)
        }
        
    }
    public func deleteTransaction_fromAccount(transaction: TransactionModel,from accountName: String){
        guard let accounts = getAllAccounts() else { return }
        var accountToUpdate = accounts.first(where: {$0.accountName == accountName})
        let index :Int = accountToUpdate?.transactions.firstIndex(of: transaction) ?? 0
        accountToUpdate?.transactions.remove(at: index)
        do {
            try storage?.save(object: accounts, forKey: "accounts")
        } catch {
            print(error)
        }
    }
    
    public func addAccount_toDataBase(newAccount: AccountModel){
        guard var accounts = getAllAccounts() else { return }

        var accountToUpdate = accounts.first(where: {$0.accountName == newAccount.accountName})
        
        if accountToUpdate == nil {
            do {
                accounts.append(newAccount)
                try storage?.save(object: accounts, forKey: "accounts")
            } catch {
                print(error)
            }
        }else{
            print("ya existe esta cuenta")
        }
    
    }
    
    public func deleteAccount_fromDataBase(accountName accountToDelete: String){
        guard var accounts = getAllAccounts() else { return }
        let accountToDelete = accounts.first(where: {$0.accountName == accountToDelete}) ?? AccountModel()
        let index :Int = accounts.firstIndex(of: accountToDelete) ?? 0
            do {
                accounts.remove(at: index)
                try storage?.save(object: accounts, forKey: "accounts")
            } catch {
                print(error)
            }
    }
    
    public func getAllAccounts() -> [AccountModel]? {
        var accounts = [AccountModel]()
        
        do {
            accounts = try (storage?.load(forKey: "accounts", as: [AccountModel].self) ?? [])
        } catch {
            print(error)
        }
        return accounts
    }
    
    public func getTransactionFromAccount() -> TransactionModel?{
        return nil
    }
}
