//
//  TransactionCellDrawer.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import UIKit

public final class TransactionCellDrawer: CellDrawerProtocol {
    private struct Constants {
        static let reuseID = "TransactionCell"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.reuseID, for: indexPath)
    }

    func drawCell(_ cell: UITableViewCell, withItem item: Any) {
        guard let cell = cell as? TransactionCell,
            let item = item as? TransactionCellModel else {return}
        
        cell.selectionStyle = .none
        cell.tag = 0
        cell.conceptLabel.text = item.concept
        cell.dateLabel.text = item.date
        cell.amountLabel.text = item.amount
    }
}

extension TransactionCellModel: DrawerProtocol {
    var cellDrawer: CellDrawerProtocol {
        return TransactionCellDrawer()
    }
}
