//
//  EditingViewController.swift
//  ToDo
//
//  Created by Soo Jang on 2022/12/15.
//

import UIKit

class EditingViewController: UIViewController {
    
    let toDoManager = CoreDataManager.shared
    var colorNum: Int64 = 1
    
    var toDoData: ToDoData?
    
    lazy var redButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Red", for: .normal)
        btn.setTitleColor(Colors(rawValue: 1)?.buttonColor, for: .normal)
        btn.backgroundColor = Colors(rawValue: 1)?.backgoundColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 1
        btn.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)


        return btn
    }()
    lazy var greenButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Green", for: .normal)
        btn.setTitleColor(Colors(rawValue: 2)?.buttonColor, for: .normal)
        btn.backgroundColor = Colors(rawValue: 2)?.backgoundColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 2
        btn.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
   
        return btn
    }()
    lazy var blueButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Blue", for: .normal)
        btn.setTitleColor(Colors(rawValue: 3)?.buttonColor, for: .normal)
        btn.backgroundColor = Colors(rawValue: 3)?.backgoundColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 3
        btn.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)

        return btn
    }()
    
    lazy var purpleButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Purple", for: .normal)
        btn.setTitleColor(Colors(rawValue: 4)?.buttonColor, for: .normal)
        btn.backgroundColor = Colors(rawValue: 4)?.backgoundColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 4
        btn.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
 
        return btn
    }()
    
    lazy var buttons = [redButton, greenButton, blueButton, purpleButton]
    
  
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: buttons)
        st.spacing = 10
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()
    
    lazy var memoView: UIView = {
        let v = UIView()
        v.backgroundColor = Colors(rawValue: 1)?.backgoundColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.addSubview(memoTextView)
        return v
    }()
    
    lazy var memoTextView: UITextView = {
        let tv = UITextView()
        tv.text = toDoData?.memoText ?? ""
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    lazy var updateButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors(rawValue: 1)?.buttonColor
        btn.setTitle("UPDATE", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        let text = NSAttributedString(string: "UPDATE", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        btn.setAttributedTitle(text, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(onClickUpdateButton), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConst()
        setNav()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 모든 버튼에 설정 변경
        buttons.forEach { button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
    
    func setNav() {
        navigationItem.largeTitleDisplayMode = .never

        self.title = "Edit Memo"
    }
    
    
    @objc func onClickUpdateButton() {
        if let data = toDoData {
            data.memoText = memoTextView.text ?? ""
            data.color = colorNum
            toDoManager.updateToDo(newToDoData: data, completion: {
                self.navigationController?.popViewController(animated: true)
            })
            } else {
                let updatedText = memoTextView.text
                toDoManager.saveToDoData(toDoText: updatedText, colorInt: colorNum ) {
                    self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func colorButtonTapped(sender: UIButton) {
        colorNum = Int64(sender.tag)
        print(colorNum)
        sender.setTitleColor(.white, for: .normal)
        sender.backgroundColor = Colors(rawValue: colorNum)?.buttonColor
        
        memoView.backgroundColor = Colors(rawValue: colorNum)?.backgoundColor
        updateButton.backgroundColor = Colors(rawValue: colorNum)?.buttonColor
    }
    
    
    func setConst() {
        view.addSubview(stackView)
        view.addSubview(memoView)
        view.addSubview(updateButton)
        memoView.translatesAutoresizingMaskIntoConstraints = false
        memoTextView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            memoView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            memoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            memoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            memoView.heightAnchor.constraint(equalToConstant: 200),
            
            memoTextView.topAnchor.constraint(equalTo: memoView.topAnchor, constant: 8),
            memoTextView.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 16),
            memoTextView.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -16),
            memoTextView.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -8),
            
            updateButton.topAnchor.constraint(equalTo: memoView.bottomAnchor, constant: 40),
            updateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            updateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            updateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }


}
