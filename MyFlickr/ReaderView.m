//
//  ReaderView.m
//  Reader
//
//  Created by florian BUREL on 10/07/13.
//  Copyright (c) 2013 Florian Burel. All rights reserved.
//

#import "ReaderView.h"


@implementation ReaderView

- (void)layoutSubviews
{
    if(self.gestureRecognizers.count == 0)
    {
        // Ajoute les GR
        {
            UISwipeGestureRecognizer * right= [[UISwipeGestureRecognizer alloc]init];
            right.direction = UISwipeGestureRecognizerDirectionRight;
            [right addTarget:self action:@selector(handleSwipe:)];
            [self addGestureRecognizer:right];
            
            UISwipeGestureRecognizer * left = [[UISwipeGestureRecognizer alloc]init];
            left.direction = UISwipeGestureRecognizerDirectionLeft;
            [left addTarget:self action:@selector(handleSwipe:)];
            [self addGestureRecognizer:left];
        }
        
        // Affiche la 1er page
        [self displayPageAtIndex:0 animated:NO];
        
    }
}

- (void) displayPageAtIndex:(int)idx __deprecated
{
    [self displayPageAtIndex:idx animated:NO];
}

- (void) displayPageAtIndex:(int)idx animated:(BOOL)animated
{
    // Purge l'ancienne page
    UIView * oldView = [self.subviews lastObject];
//    [oldView removeFromSuperview];
    
    // Affiche la page
    UIView * viewToDisplay = [self.delegate viewForPageAtIndex:idx];
    [self addSubview:viewToDisplay];
    
    // Gestion de l'animation
    // positionnement initial
    {
        // Calcul si on va vers la gauche ou la droite
        int direction = idx - self.currentPageIndex;
        if(direction) direction /= abs(direction);
        
        // placement de la viewToDisplay en décalage horizontal
        viewToDisplay.center = CGPointMake(viewToDisplay.center.x + direction * self.bounds.size.width,
                                           viewToDisplay.center.y);
        
        
        // code d'animation

        
        
        [UIView animateWithDuration:(animated ? 0.4 : 0)
                         animations:^{
                             viewToDisplay.center = CGPointMake(
                                viewToDisplay.center.x - direction * self.bounds.size.width,
                                viewToDisplay.center.y);
                             oldView.center = CGPointMake(
                                oldView.center.x - direction * self.bounds.size.width,
                                oldView.center.y);
                         }
                         completion:^(BOOL finished) {
                             [oldView removeFromSuperview];
                         }];
    }
    
    // met a jour le currentPageIndex
    _currentPageIndex = idx;
}

- (void) handleSwipe:(UISwipeGestureRecognizer *)sender
{
    
    if(sender.direction == UISwipeGestureRecognizerDirectionRight
       && self.currentPageIndex > 0)
    {
        [self displayPageAtIndex:self.currentPageIndex - 1 animated:YES];
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionLeft
            && self.currentPageIndex < [self.delegate numberOfPages] - 1)
    {
        [self displayPageAtIndex:self.currentPageIndex + 1 animated:YES];
    }
    else
    {
        [self bounce:sender.direction];
    }
}

- (void) bounce:(UISwipeGestureRecognizerDirection)gestureDirection
{
    int direction = 0;
    if(gestureDirection == UISwipeGestureRecognizerDirectionLeft)
    {
        direction = 1;
    }
    else if (gestureDirection == UISwipeGestureRecognizerDirectionRight)
    {
        direction = -1;
    }
    
    float offset = self.bounds.size.width  / 10;
    
    UIView * presentedView = [self.subviews lastObject];
    
    [UIView animateWithDuration:.2
                     animations:^{
                         presentedView.center = CGPointMake(presentedView.center.x + offset, presentedView.center.y);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:.2 animations:^{
                             presentedView.center = CGPointMake(presentedView.center.x - offset, presentedView.center.y);
                         }];
                     }];
}

@end
