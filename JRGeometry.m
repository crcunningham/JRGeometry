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

#import "JRGeometry.h"

void JRRectGetCorners(CGRect rect, CGPoint points[4]) {
	points[0].x = rect.origin.x;
	points[0].y = rect.origin.y;
	
	points[1].x = rect.origin.x;
	points[1].y = rect.origin.y + rect.size.height;
	
	points[2].x = rect.origin.x + rect.size.width;
	points[2].y = rect.origin.y + rect.size.height;
	
	points[3].x = rect.origin.x + rect.size.width;
	points[3].y = rect.origin.y;
}

CGRect JRRectMakeWithPoints(const CGPoint points[4]) {
#define MAX4(x, y, z, w) (MAX(MAX(x, y), MAX(z, w)))
#define MIN4(x, y, z, w) (MIN(MIN(x, y), MIN(z, w)))
    
	CGRect rect;
	CGFloat minX, maxX, minY, maxY;
	
	minX = MIN4(points[0].x, points[1].x, points[2].x, points[3].x);
	minY = MIN4(points[0].y, points[1].y, points[2].y, points[3].y);
	maxX = MAX4(points[0].x, points[1].x, points[2].x, points[3].x);
	maxY = MAX4(points[0].y, points[1].y, points[2].y, points[3].y);
	
	rect.origin.x = minX;
	rect.origin.y = minY;
	rect.size.width = maxX - minX;
	rect.size.height = maxY - minY;
	
	return rect;
}

CGPoint JRPointIntegral(CGPoint point) {
	return CGPointMake((CGFloat)round(point.x), (CGFloat)round(point.y));
}

CGPoint JRRectGetCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect JRRectCenteredIntegralRect(CGRect rectToBeCentered, CGRect boundsToCenterIn) {
	CGRect result;
	
	result.origin.x = (CGFloat)round(boundsToCenterIn.origin.x + (boundsToCenterIn.size.width - rectToBeCentered.size.width) / 2.0);
	result.origin.y = (CGFloat)round(boundsToCenterIn.origin.y + (boundsToCenterIn.size.height - rectToBeCentered.size.height) / 2.0);
	result.size = rectToBeCentered.size;
	return result;
}

CGRect JRRectCenteredXInRect(CGRect rectToBeCentered, CGRect boundsToCenterIn) {
	CGRect result = rectToBeCentered;
	
	result.origin.x = (CGFloat)round(boundsToCenterIn.origin.x + (boundsToCenterIn.size.width - rectToBeCentered.size.width) / 2.0);
	return result;
}

CGRect JRRectCenteredYInRect(CGRect rectToBeCentered, CGRect boundsToCenterIn) {
	CGRect result = rectToBeCentered;
	
	result.origin.y = (CGFloat)round(boundsToCenterIn.origin.y + (boundsToCenterIn.size.height - rectToBeCentered.size.height) / 2.0);
	return result;
}

CGRect JRRectCenteredAboutPoint(CGRect rectToBeCentered, CGPoint center) {
	CGRect result = rectToBeCentered;
	
	result.origin.y = (CGFloat)round(center.y - rectToBeCentered.size.height / 2.0);
	result.origin.x = (CGFloat)round(center.x - rectToBeCentered.size.width / 2.0);
	return result;
}

CGSize JRRoundSize(CGSize size) {
	return CGSizeMake((CGFloat)round(size.width), (CGFloat)round(size.height));
}

CGPoint JRMultiplyPointScalar(CGPoint pt, CGFloat s) {
	return CGPointMake(pt.x * s, pt.y * s);
}

CGSize JRMultiplySizeScalar(CGSize size, CGFloat s) {
	return CGSizeMake(size.width * s, size.height * s);
}

CGSize JRMultiplySizeScalarRound(CGSize size, CGFloat s) {
	return CGSizeMake((CGFloat)round(size.width * s), (CGFloat)round(size.height * s));
}

CGRect JRMultiplyRectScalar(CGRect rect, CGFloat s) {
	if (CGRectIsInfinite(rect) || CGRectIsNull(rect)) {
		return rect;
	}
	
    CGRect result;
    rect.origin = JRMultiplyPointScalar(rect.origin, s);
    rect.size = JRMultiplySizeScalar(rect.size, s);
    
	return result;
}

CGRect JRRoundedRectForMainScreen(CGRect rect) {
	CGFloat screenScale = [[UIScreen mainScreen] scale];
	return JRRoundedRectForScale(rect, screenScale);
}

CGRect JRRoundedRectForScale(CGRect rect, CGFloat scale) {
	CGRect result;
	
	if (CGRectIsNull(rect)) {
		return rect;
	}
	
	rect = JRMultiplyRectScalar(rect, scale);
	
	result.origin.x = JRRound(CGRectGetMinX(rect));
	result.origin.y = JRRound(CGRectGetMinY(rect));
	result.size.width = JRRound(CGRectGetMaxX(rect)) - result.origin.x;
	result.size.height = JRRound(CGRectGetMaxY(rect)) - result.origin.y;
	
	result = JRMultiplyRectScalar(result, 1.0f / scale);
	
	return result;
}

CGRect JRRectInnerRectWithAspectRatio(CGRect rect, CGFloat aspectRatio) {
	CGRect outputRect = rect;
	CGFloat targetAspect = CGRectGetWidth(rect) / CGRectGetHeight(rect);
	
	if (aspectRatio != targetAspect) {
		if (aspectRatio > targetAspect) {
			outputRect.size.width = rect.size.width;
			outputRect.size.height = rect.size.width / aspectRatio;
		}
		else {
			outputRect.size.height = rect.size.height;
			outputRect.size.width = rect.size.height * aspectRatio;
		}
		
		outputRect.origin.x = rect.origin.x + (CGFloat)floor((rect.size.width - outputRect.size.width) / 2.0);
		outputRect.origin.y = rect.origin.y + (CGFloat)floor((rect.size.height - outputRect.size.height) / 2.0);
	}
	
	return outputRect;
}

CGRect JRRectOuterRectWithAspectRatio(CGRect rect, CGFloat aspectRatio) {
	CGRect outputRect = rect;
	CGFloat targetAspect = CGRectGetWidth(rect) / CGRectGetHeight(rect);
	
	if (aspectRatio != targetAspect) {
		if (aspectRatio < targetAspect) {
			outputRect.size.width = rect.size.width;
			outputRect.size.height = rect.size.width / aspectRatio;
		}
		else {
			outputRect.size.height = rect.size.height;
			outputRect.size.width = rect.size.height * aspectRatio;
		}
		
		outputRect.origin.x = rect.origin.x - (CGFloat)floor((outputRect.size.width - rect.size.width) / 2.0);
		outputRect.origin.y = rect.origin.y - (CGFloat)floor((outputRect.size.height - rect.size.height) / 2.0);
	}
	
	return outputRect;
}

CGFloat JRRectGetAspectRatio(CGRect rect) {
	return (rect.size.height != 0.0) ? (rect.size.width / rect.size.height) : 0.0;
}

#if TARGET_OS_IPHONE
CGRect JRConvertRectToScreen(UIView *view, CGRect rect) {
	CGPoint points[4];
	
	JRRectGetCorners(rect, points);
	points[0] = [view.window convertPoint:[view convertPoint:points[0] toView:nil] toWindow:nil];
	points[1] = [view.window convertPoint:[view convertPoint:points[1] toView:nil] toWindow:nil];
	points[2] = [view.window convertPoint:[view convertPoint:points[2] toView:nil] toWindow:nil];
	points[3] = [view.window convertPoint:[view convertPoint:points[3] toView:nil] toWindow:nil];
	return JRRectMakeWithPoints(points);
}

CGRect JRConvertRectToWindow(CGRect rect, UIWindow *window) {
	CGPoint points[4];
	
	JRRectGetCorners(rect, points);
	points[0] = [window convertPoint:points[0] fromWindow:nil];
	points[1] = [window convertPoint:points[1] fromWindow:nil];
	points[2] = [window convertPoint:points[2] fromWindow:nil];
	points[3] = [window convertPoint:points[3] fromWindow:nil];
	return JRRectMakeWithPoints(points);
}
#endif
