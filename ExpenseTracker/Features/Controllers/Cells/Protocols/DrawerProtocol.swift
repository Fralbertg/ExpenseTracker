//
//  DrawerProtocol.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import UIKit

protocol DrawerProtocol {
    var cellDrawer: CellDrawerProtocol { get }
}

protocol CellDrawerProtocol {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func drawCell (_ cell: UITableViewCell, withItem item: Any)
}
