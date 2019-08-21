//
//  Created by Kenan Atmaca on 19.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

class KActionTableCell: UITableViewCell {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    static let id = String(describing: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = .clear
    }
}
