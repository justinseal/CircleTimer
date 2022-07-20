//
//  ViewController.swift
//  Animated Cirle Timer
//
//  Created by Justin Seal on 7/18/22.
//

import UIKit

class ViewController: UIViewController {
    let shapeLayer = CAShapeLayer()
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var timer = Timer()
    var totalTime = 10
    var secondsPassed = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTrackLayer()
        configureShape()
        configureLabel()
        // Do any additional setup after loading the view.
    }
    
    func configureShape() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 150, startAngle: -CGFloat .pi / 2, endAngle: 2 * .pi, clockwise: true)
        shapeLayer.position = view.center
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        animateCircle()
    }

    fileprivate func animateCircle() {
        shapeLayer.strokeEnd = 0
        fireTimer()
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        let durationTime = CGFloat(secondsPassed) / CGFloat(totalTime)
        shapeLayer.strokeEnd = durationTime
        basicAnimation.duration = 10
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "junk")
    }
    
    func createTrackLayer() {
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 150, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        trackLayer.position = view.center
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 12
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        view.layer.addSublayer(trackLayer)
    }
    
    func configureLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
        percentageLabel.center = view.center
    }
    
    func fireTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            percentageLabel.text = "\(secondsPassed)"
           print(secondsPassed)
        } else {
            timer.invalidate()
        }
    }
    
}

