// The MIT License (MIT)
//
// Copyright (c) 2014 Chris Cunningham
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <CoreGraphics/CoreGraphics.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

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
