//
//  celda.swift
//  tableview-swift
//
//  Created by A4-iMAC03 on 30/11/2020.
//

import UIKit

class celda: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
