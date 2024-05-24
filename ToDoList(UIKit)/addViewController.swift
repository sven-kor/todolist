//
//  addViewController.swift
//  ToDoList(UIKit)
//
//  Created by 김형준 on 5/24/24.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func addTask(_ task: String)
}


class addViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: AddViewControllerDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .close)
        button.addAction(UIAction { [weak self] _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        return button
    }()
    
    private let textField :UITextField = {
        let textField = UITextField()
        textField.placeholder = "추가할 일을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitle("등록", for: .normal)
        submitButton.backgroundColor = .systemCyan
        submitButton.titleLabel?.font = .systemFont(ofSize: 20)
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        return submitButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        view.addSubview(submitButton)
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 100),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.centerYAnchor, constant: 150),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonTapped()
        textField.resignFirstResponder()
        return true
    }
    
    @objc func buttonTapped() {
        if let task = self.textField.text, task.isEmpty {
            let alert = UIAlertController(title: "뭐하냐", message: "아무것도 안할거야?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "반성하기", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        } else {
            self.delegate?.addTask(textField.text!)
            self.dismiss(animated: true)
        }
        
    }
}
