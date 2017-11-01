//
//  LighthouseSwiftViewController.swift
//  LighthouseSwiftDemo
//
//  Created by hbc on 2017/10/31.
//  Copyright © 2017年 Adirects. All rights reserved.
//

import UIKit

class LighthouseSwiftViewController: UIViewController {
    
    fileprivate var _count: Int = 0
    
    private var lighthouseAd: LighthouseInterstailAd!
    @IBOutlet weak var preloadBtn: UIButton!
    @IBOutlet weak var placementID1: UILabel!
    @IBOutlet weak var placementID2: UILabel!
    
    private var activityIndicatorView1: UIActivityIndicatorView!
    private var activityIndicatorView2: UIActivityIndicatorView!
    
    private var playBtn1: UIButton!
    private var playBtn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func preloadAds(_ sender: Any) {
        _count = 0
        preloadBtn.isUserInteractionEnabled = false
        if activityIndicatorView1 != nil {
            activityIndicatorView1.removeFromSuperview()
        }
        if activityIndicatorView2 != nil {
            activityIndicatorView2.removeFromSuperview()
        }
        if playBtn1 != nil {
            playBtn1.removeFromSuperview()
        }
        if playBtn2 != nil {
            playBtn2.removeFromSuperview()
        }
        
        // 多条
        let placementIDsArray = ["176-10011","176-10012"]
        lighthouseAd = LighthouseInterstailAd.initialize("3-10008", withPlacements: placementIDsArray, delegate: self)
        activityIndicatorView1 = UIActivityIndicatorView.init()
        activityIndicatorView2 = UIActivityIndicatorView.init()
        activityIndicatorView1.activityIndicatorViewStyle = .gray
        activityIndicatorView2.activityIndicatorViewStyle = .gray
        self.view.addSubview(activityIndicatorView1)
        self.view.addSubview(activityIndicatorView2)
        activityIndicatorView1.mas_makeConstraints { (make) in
            make?.left.equalTo()(placementID1.mas_right)?.offset()(20)
            make?.centerY.equalTo()(placementID1)
        }
        activityIndicatorView2.mas_makeConstraints { (make) in
            make?.left.equalTo()(placementID2.mas_right)?.offset()(20)
            make?.centerY.equalTo()(placementID2)
        }
        activityIndicatorView1.startAnimating()
        activityIndicatorView2.startAnimating()
    }
    
    fileprivate func getIDWithString(string:String) -> String {
        let array: [String] = string.components(separatedBy: ":")
        return array[1]
    }
    
    @objc fileprivate func playAds1() {
        if lighthouseAd.isReady("176-10011") {
            lighthouseAd.showWithplacementId("176-10011")
        }
    }
    
    @objc fileprivate func playAds2() {
        if lighthouseAd.isReady("176-10012") {
            lighthouseAd.showWithplacementId("176-10012")
        }
    }
}

extension LighthouseSwiftViewController: LighthouseInterstailAdDelegate {
    
    
    /// 预加载单条视频完成
    func lighthouseAdsReady(_ lighthouseAd: LighthouseInterstailAd!, withPlacementId placementId: String!) {
        print("预加载视频完成id = " + placementId);
        if getIDWithString(string: placementID1.text!) == placementId {
            if activityIndicatorView1 != nil {
                activityIndicatorView1.removeFromSuperview()
            }
            playBtn1 = UIButton.init()
            playBtn1.setTitle("finished to play", for: .normal)
            playBtn1.backgroundColor = UIColor.orange
            playBtn1.setTitleColor(UIColor.blue, for: .normal)
            playBtn1.addTarget(self, action: #selector(playAds1), for: .touchUpInside)
            self.view.addSubview(playBtn1)
            playBtn1.mas_makeConstraints({ (make) in
                make?.left.equalTo()(placementID1.mas_right)?.offset()(20)
                make?.centerY.equalTo()(placementID1)
            })
        }
        
        if getIDWithString(string: placementID2.text!) == placementId {
            if activityIndicatorView2 != nil {
                activityIndicatorView2.removeFromSuperview()
            }
            playBtn2 = UIButton.init()
            playBtn2.setTitle("finished to play", for: .normal)
            playBtn2.backgroundColor = UIColor.orange
            playBtn2.setTitleColor(UIColor.blue, for: .normal)
            playBtn2.addTarget(self, action: #selector(playAds2), for: .touchUpInside)
            self.view.addSubview(playBtn2)
            playBtn2.mas_makeConstraints({ (make) in
                make?.left.equalTo()(placementID2.mas_right)?.offset()(20)
                make?.centerY.equalTo()(placementID2)
            })
        }
        _count += 1
        if _count == 2 {
            preloadBtn.isUserInteractionEnabled = true
        }
    }
    
    // 预加载单条视频失败
    func lighthouseAd(_ lighthouseAd: LighthouseInterstailAd!, didFailPreloadWithError error: Error!, withPlacementId placementId: String!) {
        print("预加载视频失败")
        preloadBtn.isUserInteractionEnabled = true
        if activityIndicatorView1 != nil {
            activityIndicatorView1.removeFromSuperview()
        }
        if activityIndicatorView2 != nil {
            activityIndicatorView2.removeFromSuperview()
        }
        
        let hud: MBProgressHUD! = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.label.text = placementId + " " + error.localizedDescription
        hud.offset = CGPoint.init(x: 0, y: MBProgressMaxOffset)
        hud.contentColor = UIColor.red
        hud .hide(animated: true, afterDelay: 5)
    }
    
    // 广告展示成功
    func lighthouseAdDidFinishShow(_ lighthouseAd: LighthouseInterstailAd!) {
        print("广告展示成功")
    }
    
    // 广告展示失败
    func lighthouseAd(_ lighthouseAd: LighthouseInterstailAd!, didFailShowWithError error: Error!) {
        print("广告展示失败")
    }
    
    // 广告开始展示
    func lighthouseAdDidStartShow(_ lighthouseAd: LighthouseInterstailAd!) {
        print("广告开始展示")
    }
    
    // 广告点击关闭
    func lighthouseAdDidClickClose(_ lighthouseAd: LighthouseInterstailAd!) {
        print("广告展示关闭")
    }
    
    // 广告点击下载
    func lighthouseAdDidClickDownload(_ lighthouseAd: LighthouseInterstailAd!) {
         print("广告点击下载")
    }
    
}
