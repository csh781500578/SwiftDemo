//
//  NBEventUIViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/24.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import EventKitUI

class NBEventUIViewController: UIViewController {
    
    var store = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        view.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
        view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.left.equalTo(btn1.snp.right).offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
    }
    
    
    
    
    @objc func didSelect1Action() {
        let event = EKEvent(eventStore: store)
        event.startDate = Date(timeIntervalSinceNow: 3)
        event.endDate = Date(timeIntervalSinceNow: 1000)
        event.title = "今天是星期天下午4点42分"
        let alarm = EKAlarm(absoluteDate: Date(timeIntervalSinceNow: 3))
        event.addAlarm(alarm)
        let calendar = EKCalendar(for: EKEntityType.event, eventStore: store)
        calendar.title = "日历事件"
        event.calendar = calendar
        
        let vc = EKEventViewController()
        vc.delegate = self
        vc.event = event
//        navigationController?.present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didSelect2Action() {
        let vc = EKEventEditViewController()
        vc.editViewDelegate = self
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    lazy var btn1: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 5
        view.setTitle("日历功能", for: UIControl.State.normal)
        view.addTarget(self, action: #selector(didSelect1Action), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var btn2: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 5
        view.setTitle("提醒功能", for: UIControl.State.normal)
        view.addTarget(self, action: #selector(didSelect2Action), for: UIControl.Event.touchUpInside)
        return view
    }()
}

extension NBEventUIViewController : EKEventEditViewDelegate, EKEventViewDelegate{

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        switch action {
        case .canceled:
            controller.dismiss(animated: true, completion: nil)
            break
        case .saved:
            break
        case .deleted:
            break
        default:
            break
        }
    }
        
    func eventEditViewControllerDefaultCalendar(forNewEvents controller: EKEventEditViewController) -> EKCalendar {
        let calendar = EKCalendar(for: EKEntityType.event, eventStore: store)
        calendar.title = "这是一个日历功能"
        
        return calendar
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        
    }
}
