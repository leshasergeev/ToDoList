//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Алексей Сергеев on 29.04.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    weak var delegate: ToDoCellDelegate?
    
    @IBOutlet var isCompleteButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
