//
//  PreviousOperationTableViewCell.swift
//  Calculator
//
//  Created by Alexander Rojas Benavides on 8/25/21.
//

import UIKit

class PreviousOperationTableViewCell: UITableViewCell {
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
