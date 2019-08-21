//
//  Created by Kenan Atmaca on 19.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

open class KActionTable: UITableView {
    
    var items:[(name:String, image:UIImage?)] = []
    
    weak public var actionDelegate:KActionDelegate?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.separatorColor = UIColor.lightGray
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.delegate = self
        self.dataSource = self
        loadNib()
    }
    
    private func loadNib() {
        let tableViewBundle = Bundle(for: KActionMenu.self)
        self.register(UINib(nibName: "KActionTableCellView", bundle: tableViewBundle), forCellReuseIdentifier: KActionTableCell.id)
    }
}

extension KActionTable: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KActionTableCell.id) as? KActionTableCell else { return UITableViewCell() }
        let row = items[indexPath.row]
        cell.actionLabel.text = row.name
        cell.actionImage.image = row.image
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        actionDelegate?.touchItem(name: items[indexPath.row].name, index: indexPath.row)
    }
}
