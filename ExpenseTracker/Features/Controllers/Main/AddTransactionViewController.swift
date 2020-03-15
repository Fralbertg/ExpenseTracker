//
//  AddTransactionViewController.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import UIKit
import iOSDropDown

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var toggle: UISegmentedControl!
    @IBOutlet weak var accountSelector: DropDown!
    @IBOutlet weak var categorySelector: DropDown!
    @IBOutlet weak var amountTextField: UITextField!
    
    var accountSelected: String?
    var amount: String?
    var categorySelected: ExpenseCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        initSelectors()
    }
    
    @objc func saveTransaction(sender: UIButton) {
        let dataController = DataController()
        let amountDouble = Formatters.formatStringToNumber(stringNumber: amount ?? "0")
        let transaction = TransactionModel(concept: categorySelected, amount: amountDouble, date: Date())
        dataController.addTransaction_toAccount(transaction: transaction, to: accountSelected ?? "")
        self.dismiss(animated: true)
    }
   
    @objc func saveAmount(sender: UITextField) {
        amount = sender.text ?? "0"
    }

    func setBackButton() {
        let buttonBack = UIButton(type: .custom)
        buttonBack.setTitle("Cancel", for: .normal)
        buttonBack.frame = CGRect(x: 0, y: 0, width: 22, height: 20)
        buttonBack.tag = 3
        buttonBack.titleLabel?.font = UIFont(name: "Arial", size: 30.0)
        buttonBack.setTitleColor(.white, for: .normal)
        let itemBack = UIBarButtonItem(customView: buttonBack)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = itemBack
    }

    func setRightButton() {
        let btn = UIButton(type: .custom)
        btn.setTitle("Done", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial", size: 30)
        btn.frame = CGRect(x: 0, y: 0, width: 22, height: 20)
        btn.tag = 3
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(saveTransaction(sender:)), for: .touchUpInside)
        let itemBtn = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = itemBtn
    }


    func initSelectors() {
        initCategorySelector()
        initAccountSelector()
        amountTextField.addTarget(self, action: #selector(saveAmount), for: .editingDidEnd)
    }

    func initAccountSelector() {
        let dataController = DataController()
        let accounts = dataController.getAllAccounts()
        var stringAccounts = [String]()
        accounts?.forEach({ stringAccounts.append($0.accountName ?? "") })
        accountSelector.optionArray = stringAccounts
        accountSelector.didSelect { (selectedText, index, id) in
            self.accountSelected = selectedText
        }
    }

    func initCategorySelector() {
        let categories = ExpenseCategory.allCases
        var stringCategories = [String]()
        categories.forEach({ stringCategories.append("\($0.rawValue)") })
        categorySelector.optionArray = stringCategories
        accountSelector.didSelect { (selectedText, index, id) in
            self.categorySelected = ExpenseCategory(rawValue: selectedText)
        }
    }
}
