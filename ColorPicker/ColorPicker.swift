//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Jeff Kang on 11/21/20.
//

import UIKit

//@IBDesignable
class ColorPicker: UIControl {
    
    private var colorWheel = ColorWheel()
    private var brightnessSlider = UISlider()
    var color: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        backgroundColor = .clear
        
        // color wheel
        colorWheel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorWheel)
        NSLayoutConstraint.activate([
            colorWheel.topAnchor.constraint(equalTo: topAnchor),
            colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
        ])
        
        // brightness slider
        brightnessSlider.minimumValue = 0
        brightnessSlider.minimumValueImage = UIImage(systemName: "sun.min")
        brightnessSlider.maximumValue = 1
        brightnessSlider.maximumValueImage = UIImage(systemName: "sun.max")
        brightnessSlider.value = 0.8
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        brightnessSlider.addTarget(self, action: #selector(changeBrightness), for: .touchUpInside)
        
        addSubview(brightnessSlider)
        NSLayoutConstraint.activate([
            brightnessSlider.topAnchor.constraint(equalTo: colorWheel.bottomAnchor, constant: 8),
            brightnessSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            brightnessSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func changeBrightness() {
        colorWheel.brightness = CGFloat(brightnessSlider.value)
    }
    
    // MARK: - Touch Tracking
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Begin tracking")
        let touchPoint = touch.location(in: colorWheel)
        color = colorWheel.color(for: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Continue tracking")
        let touchPoint = touch.location(in: colorWheel)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("End tracking")
        defer {
            super.endTracking(touch, with: event)
        }
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: colorWheel)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        print("Cancel Tracking")
        sendActions(for: [.touchCancel])
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
