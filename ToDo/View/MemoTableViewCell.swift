//
//  MemoTableViewCell.swift
//  ToDo
//
//  Created by Soo Jang on 2022/12/15.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    lazy var memoView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.addSubview(memoTextLabel)
        v.addSubview(memoDateLabel)
        return v
    }()
    
    
    lazy var memoTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        
        return label
    }()
    
    lazy var memoDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022-12-16"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var memoUpdateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        btn.tintColor = .white
        let text = NSAttributedString(string: "UPDATE", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white])
        btn.setAttributedTitle(text, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.setNeedsDisplay()
        
        btn.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var dateAndUpdateView: UIView = {
        let v = UIView()
        v.addSubview(memoDateLabel)
        v.addSubview(memoUpdateButton)
        return v
    }()
    
    lazy var memoStView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [memoTextLabel,dateAndUpdateView])
        st.spacing = 10
        st.axis = .vertical
        st.alignment = .fill
        return st
    }()
    
    var toDoData: ToDoData? {
        didSet {
            setData()
        }
    }
    
    var closureForUpdateButton:(MemoTableViewCell) -> Void = { (sender) in }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setConst()
        self.selectionStyle = .none

        print("called")
        
    }
    
    @objc func updateButtonPressed() {
        print("go to edit on cell")
        closureForUpdateButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        memoTextLabel.text = toDoData?.memoText
        memoDateLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = Colors(rawValue: colorNum)
        memoView.backgroundColor = color?.backgoundColor
        memoUpdateButton.backgroundColor = color?.buttonColor
    }
    
    func setConst() {
        contentView.addSubview(memoView)
        memoView.addSubview(memoStView)
        
        
        memoView.translatesAutoresizingMaskIntoConstraints = false
        memoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        memoDateLabel.translatesAutoresizingMaskIntoConstraints = false
        memoUpdateButton.translatesAutoresizingMaskIntoConstraints = false
        dateAndUpdateView.translatesAutoresizingMaskIntoConstraints = false
        memoStView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            memoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            memoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            memoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    

            memoStView.topAnchor.constraint(equalTo: memoView.topAnchor, constant: 10),
            memoStView.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 10),
            memoStView.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -10),
            memoStView.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -10),
            
            memoTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            dateAndUpdateView.heightAnchor.constraint(equalToConstant: 30),
            
            memoDateLabel.bottomAnchor.constraint(equalTo: dateAndUpdateView.bottomAnchor, constant: 0),
            memoDateLabel.leadingAnchor.constraint(equalTo: dateAndUpdateView.leadingAnchor, constant: 0),

            memoUpdateButton.bottomAnchor.constraint(equalTo: dateAndUpdateView.bottomAnchor, constant: 0),
            memoUpdateButton.trailingAnchor.constraint(equalTo: dateAndUpdateView.trailingAnchor, constant: 0),
            
            
//            memoTextLabel.topAnchor.constraint(equalTo: memoView.safeAreaLayoutGuide.topAnchor ,constant: 10),
//            memoTextLabel.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 10),
//            memoTextLabel.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -10),
//
//            memoDateLabel.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -10),
//            memoDateLabel.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 10),
//
            
//            memoUpdateButton.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -10),
//            memoUpdateButton.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -10),
//            memoUpdateButton.heightAnchor.constraint(equalToConstant: 26),
//            memoUpdateButton.widthAnchor.constraint(equalToConstant: 70)
            
            
            
        ])
    }
}
