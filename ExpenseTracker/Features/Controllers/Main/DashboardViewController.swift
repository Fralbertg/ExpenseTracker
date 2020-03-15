//
//  DashboardViewController.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cells = [DrawerProtocol]()
    var accounts = [AccountModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAccountsData()
    }
    
    func getAccountsData(){
        let dataController = DataController()
                
        accounts = dataController.getAllAccounts() ?? []
        
        createCells()
    }
    
    func createCells(){
        cells = []
        for account in accounts {
            cells.append(HeaderTransactionCellModel(title: account.accountName ?? "", balance: account.getBalance()))
            account.transactions.forEach({
                cells.append(TransactionCellModel(concept: $0.concept?.rawValue ?? "", date: "\($0.date)" ?? "", amount: Formatters.formatNumberToString(doubleNumber: $0.amount ?? 0)))
            })
        }
        tableView.reloadData()
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "HeaderTransactionCell", bundle: Bundle(for: HeaderTransactionCell.self)), forCellReuseIdentifier: "HeaderTransactionCell")
        tableView.register(UINib(nibName: "TransactionCell",bundle: Bundle(for: TransactionCell.self)) , forCellReuseIdentifier: "TransactionCell")
    }
    
    public func setUpNavigationBar() {
        self.title = "Dashboard"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont(name: "Al Nile", size: 20)]
        setRightButton()
    }

    func setRightButton() {
        let btn = UIButton(type: .custom)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial", size: 30)
        btn.frame = CGRect(x: 0, y: 0, width: 22, height: 20)
        btn.tag = 3
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(rightButtonPressed(sender:)), for: .touchUpInside)
        let itemBtn = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = itemBtn
    }
    
    @objc func rightButtonPressed(sender: UIButton){
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "AddTransactionViewController") as? AddTransactionViewController {            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = cells[indexPath.row]
        let drawer = item.cellDrawer
        let cell = drawer.tableView(tableView, cellForRowAt: indexPath)
        drawer.drawCell(cell, withItem: item)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cells[indexPath.row] is TransactionCellModel{
            return Constants.TRANSACTION_CELL_HEIGHT
        }
        return tableView.rowHeight
    }
}
