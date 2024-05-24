//
//  CheckboxCellTableViewCell.swift
//  ToDoList(UIKit)
//
//  Created by 김형준 on 5/24/24.
//

import UIKit

protocol CheckboxCellDelegate: AnyObject {
    func checkboxCellDidToggle(_ cell: CheckboxCellTableViewCell, isChecked: Bool)
}

class CheckboxCellTableViewCell: UITableViewCell {
    
    static let identifier = "CheckboxCell"
    weak var delegate: AddViewControllerDelegate?
    weak var checkboxDelegate: CheckboxCellDelegate?
    
    private let checkboxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(boxButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func boxButtonTapped() {
        checkboxButton.isSelected.toggle()
        self.checkboxDelegate?.checkboxCellDidToggle(self, isChecked: checkboxButton.isSelected)
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(label)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            label.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ text: String, isChecked: Bool ) {
        label.text = text
        checkboxButton.isSelected = isChecked
    }
    
    
    
}
