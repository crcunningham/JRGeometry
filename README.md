JRGeometry
==========

```
#define DEG_TO_RAD(x) ((x) * M_PI / 180.0)
#define RAD_TO_DEG(x) ((x) * 180.0 / M_PI)

// points
void JRRectGetCorners(CGRect rect, CGPoint points[4]);
CGRect JRRectMakeWithPoints(const CGPoint points[4]);

// pixel alignment
CGPoint JRPointIntegral(CGPoint point);

// center
CGPoint JRRectGetCenter(CGRect rect);
CGRect JRRectCenteredIntegralRect(CGRect rectToBeCentered, CGRect boundsToCenterIn);
CGRect JRRectCenteredXInRect(CGRect rectToBeCentered, CGRect boundsToCenterIn);
CGRect JRRectCenteredYInRect(CGRect rectToBeCentered, CGRect boundsToCenterIn);
CGRect JRRectCenteredAboutPoint(CGRect rectToBeCentered, CGPoint center);

// scaling
CGFloat JRRound(CGFloat a);
CGSize JRRoundSize(CGSize size);
CGPoint JRMultiplyPointScalar(CGPoint pt, CGFloat s);
CGSize JRMultiplySizeScalar(CGSize size, CGFloat s);
CGSize JRMultiplySizeScalarRound(CGSize size, CGFloat s);
CGRect JRMultiplyRectScalar(CGRect rect, CGFloat s);
CGRect JRRoundedRectForMainScreen(CGRect rect);
CGRect JRRoundedRectForScale(CGRect rect, CGFloat scale);

CGRect JRRectInnerRectWithAspectRatio(CGRect rect, CGFloat aspectRatio);
CGRect JRRectOuterRectWithAspectRatio(CGRect rect, CGFloat aspectRatio);
CGFloat JRRectGetAspectRatio(CGRect rect);

#if TARGET_OS_IPHONE
CGRect JRConvertRectToScreen(UIView *view, CGRect rect);
CGRect JRConvertRectToWindow(CGRect rect, UIWindow *window);
#endif
```