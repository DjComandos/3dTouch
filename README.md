# 3dTouch
Swift: how to use 3D Touch - Introduction

3D Touch or force touch - this is anew feature that have been introduced in the iPhone 6s. It's interesting to know that you can get touch force, it is a number from 0 up to 6.6667, actually it a number from 0 up to <em><strong>maximumPossibleForce</strong></em>.

Let's take a look at how to check if 3d touch is supported on current device:

<pre lang="swift">
func is3dTouchAvailable(traitCollection: UITraitCollection) -> Bool {
    return traitCollection.forceTouchCapability == UIForceTouchCapability.available
}

// Let's call it somewhere from the GameScene for instance
override func didMove(to view: SKView) {

    hardwareService.initDevice()
    if(is3dTouchAvailable(traitCollection: self.view!.traitCollection)) {
       //...
    }
    
}
</pre>
Feel free to take a look at the example project - I'll provide the link in the end of this post.
So this is a good practice to check whether 3d touch is supported or not.

Here's an example of how to get the force of the 3d touch

<pre lang="swift">
func touchMoved(touch: UITouch, toPoint pos: CGPoint) {
    let location = touch.location(in: self)
    let node = self.atPoint(location)
    
    //...
    if is3dTouchEnabled {
        bubble.setPressure(pressurePercent: touch.force / touch.maximumPossibleForce)
    } else {
        // It is important to use touchMoved for iPhones w/o 3dTouch,
        // So we can "emulate" it.
        bubble.setPressure(pressurePercent: 1)
    }
}
</pre>
The current value of the Touch's force is <em><strong>touch.force</strong></em> and the <em><strong>touch.maximumPossibleForce</strong></em> is a good one to convert force value to the "percentage".
This code is from the small example of how to "emulate" the bubble reacting on the force of the touch.
