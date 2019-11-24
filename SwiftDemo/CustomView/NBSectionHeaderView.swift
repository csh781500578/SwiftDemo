//
//  NBSectionHeaderView.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit

class NBSectionHeaderView: UITableViewHeaderFooterView {
    
    var didSelectViewBlock : (()->())?
    
    var model: NBVCListModel? {
        didSet {
            label.text = model?.date
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let ges = UITapGestureRecognizer.init(target: self, action: #selector(didSelectView))
        addGestureRecognizer(ges)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didSelectView() {
        model?.open = !(model?.open ?? false)
        didSelectViewBlock?()
    }
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17.0)
        view.textColor = UIColor.darkGray
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        return view
    }()
}
