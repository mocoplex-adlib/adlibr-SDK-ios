//
//  AppDelegate.m
//  HelloAdlib
//
//  Created by Nara on 12. 5. 8..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameCenter.h"
#import "HelloWorldLayer.h"

#import <Adlib/Adlib.h>

#import "SubAdlibAdViewAdam.h"
#import "SubAdlibAdViewAdmob.h"
#import "SubAdlibAdViewCauly.h"
#import "SubAdlibAdViewTAD.h"
#import "SubAdlibAdViewiAd.h"
#import "SubAdlibAdViewNaverAdPost.h"
#import "SubAdlibAdViewShallWeAd.h"
#import "SubAdlibAdViewInmobi.h"
#import "SubAdlibAdViewDomob.h"
#import "SubAdlibAdViewAdHub.h"
#import "SubAdlibAdViewUPlusAD.h"
#import "SubAdlibAdViewMMedia.h"
#import <MillennialMedia/MMSDK.h>


@implementation AppDelegate

@synthesize window;

/// ADLIBr ///
- (void)showADLIBr
{
    [[AdlibManager sharedSingletonClass] attach:viewController withView:viewController.view withDelegate:self];
}

- (void)hideADLIBr
{
    [[AdlibManager sharedSingletonClass] detach:viewController];
}
- (void)gotAd
{
    // 광고 view의 크기
    //CGSize sz = [[AdlibManager sharedSingletonClass] size];
    
    [[AdlibManager sharedSingletonClass] moveAdContainer:CGPointMake(0, 0)];
}
/// ADLIBr ///


- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

- (void)initAdlib
{
    
    NSString* adlibKey = @"ADLIBr_KEY";
    [[AdlibManager sharedSingletonClass] initAdlib:adlibKey];
    
    // 실제 구현된 광고 뷰를 애드립 매니저에 연결합니다.
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADAM" withClass:[SubAdlibAdViewAdam class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADMOB" withClass:[SubAdlibAdViewAdmob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"CAULY" withClass:[SubAdlibAdViewCauly class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"TAD" withClass:[SubAdlibAdViewTAD class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"IAD" withClass:[SubAdlibAdViewiAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"NAVER" withClass:[SubAdlibAdViewNaverAdPost class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"SHALLWEAD" withClass:[SubAdlibAdViewShallWeAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"INMOBI" withClass:[SubAdlibAdViewInmobi class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"DOMOB" withClass:[SubAdlibAdViewDomob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADHUB" withClass:[SubAdlibAdViewAdHub class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"UPLUSAD" withClass:[SubAdlibAdViewUPlusAD class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"MMEDIA" withClass:[SubAdlibAdViewMMedia class]];
    [MMSDK initialize];  // MillennialMedia v5.2.0 이상을 사용하시려면 반드시 초기화를 호출해 주세요.
}


- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    [self initAdlib];
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//

	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
    
    /*
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
     */	

	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
    
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
    window.rootViewController = viewController;
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [HelloWorldLayer scene]];
    
    // 게임센터 start
    [GameCenter startGameCenter];
    
    // attach adlib..
    [self showADLIBr];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end