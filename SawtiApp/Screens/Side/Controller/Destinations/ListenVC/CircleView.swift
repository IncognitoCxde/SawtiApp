import UIKit

class CircleView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        UIColor.white.setFill()
        context.fill(rect)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        guard let circleColor = UIColor(named: "Light Green"),
              let circleBorderColor = UIColor(named: "UI Green") else {
            return
        }
        
        let radii: [CGFloat] = [100, 75, 50]
        
        context.setLineWidth(10)
    
        for radius in radii {
            context.setStrokeColor(circleBorderColor.cgColor)
            context.setFillColor(circleColor.cgColor)
            
            let circleRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
            
            context.strokeEllipse(in: circleRect)
            context.fillEllipse(in: circleRect) 
        }
    }
}
