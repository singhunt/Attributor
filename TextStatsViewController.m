//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Wei on 20/4/14.
//  Copyright (c) 2014 __Wei__. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;
@end

@implementation TextStatsViewController

/*below view did load is just for testing purpose only, you need to drage the arrow to start this view directly*/
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor], NSStrokeWidthAttributeName : @-3} ];
//}


// common pattern to set up screen
- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze =textToAnalyze;
    if (self.view.window) [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI;
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorfule characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return  characters;
}



@end
