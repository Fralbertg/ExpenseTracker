//
//  HeaderTransactionCellDrawer.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import UIKit

public final class HeaderTransactionCellDrawer: CellDrawerProtocol {
    private struct Constants {
        static let reuseID = "HeaderTransactionCell"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.reuseID, for: indexPath)
    }

    func drawCell(_ cell: UITableViewCell, withItem item: Any) {
        guard let cell = cell as? HeaderTransactionCell,
            let item = item as? HeaderTransactionCellModel else {return}
        
        cell.titleLabel.text = item.title
        cell.currentBalanceLabel.text = Formatters.formatNumberToString(doubleNumber: item.balance)
    }
}

extension HeaderTransactionCellModel: DrawerProtocol {
    var cellDrawer: CellDrawerProtocol {
        return HeaderTransactionCellDrawer()
    }
}
