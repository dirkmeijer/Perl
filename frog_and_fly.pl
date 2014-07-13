#!/usr/bin/perl
#
# How about a frog wanting to catch a fly? Perfect job for Perl.
# http://puzzlor.com/2014-06_FrogAndFly.html
# Only 3 positions have a lily (L) and a flower (F) (A1, A2 and B1) (4, 7 and 8)
# Just started with Perl. Better code possible, I guess.
#
use strict;
use warnings;
use Switch;
 
# I tried using a multiple array but it did not work for me while using strict
# my @pond = qw([1 L0 2 L0 3 0F]
              # [4 LF 5 L0 6 0F]
              # [7 LF 8 LF 9 0F]);
# print $pond[0][0];
#                     1  2  3  4  5  6  7  8  9   # all positions numbered from top left
my @pond        = qw(L0 L0 0F LF L0 0F LF LF 0F); # not used now. Was meant for multiple array
my $fly_pos     = 3;                              # start position fly
my $frog_pos    = 5;                              # start position frog
my $random_move = 0;                              
my $is_fly      = 0;                              # fly  false =0 true = 1
my $is_frog     = 0;                              # frog false =0 true = 1
my $caught_at_4 = 0;                              # has a lily and a flower
my $caught_at_7 = 0;                              # has a lily and a flower
my $caught_at_8 = 0;                              # has a lily and a flower
my $i = 0;                                        # just a counter

sub randomize_it() {
    $random_move = int(rand(9))+1;                # give a number between 1 and 9
}

sub move_evaluate() {                             # only valid fly and frog moves
    if ($is_fly  == 1) {                          # evaluate when fly
        switch($random_move){                      # move to
           case 3      { switch($fly_pos) {       # current fly position
                            case 6 {$fly_pos = 3;}# possible fly move
                            else {;}
                            }
                       }
           case 4      { switch($fly_pos) {
                            case 7 {$fly_pos = 4;}# possible fly move
                            case 8 {$fly_pos = 4;}# possible fly move
                            else {;}
                            }
                       }
           case 6      { switch($fly_pos) {
                            case 3 {$fly_pos = 6;}# possible fly move
                            case 8 {$fly_pos = 6;}# possible fly move
                            case 9 {$fly_pos = 6;}# possible fly move
                            else {;}
                            }
                       }
           case 7      { switch($fly_pos) {
                            case 4 {$fly_pos = 7;}# possible fly move
                            case 8 {$fly_pos = 7;}# possible fly move
                            else {;}
                            }
                       }
           case 8      { switch($fly_pos) {
                            case 4 {$fly_pos = 8;}# possible fly move
                            case 6 {$fly_pos = 8;}# possible fly move
                            case 7 {$fly_pos = 8;}# possible fly move
                            case 9 {$fly_pos = 8;}# possible fly move
                            else {;}
                            }
                       }
           case 9      { switch($fly_pos) {
                            case 6 {$fly_pos = 9;}# possible fly move
                            case 8 {$fly_pos = 9;}# possible fly move
                            else {;}
                            }
                       }
           else        { move_fly();              # no valid fly move, try again
                       }
        }
    }
    if ($is_frog  == 1) {                          # evaluate when frog
        switch($random_move){                      # move to
           case 1      { switch($frog_pos) {
                            case 2 {$frog_pos = 1;}# possible frog move
                            case 4 {$frog_pos = 1;}# possible frog move
                            case 5 {$frog_pos = 1;}# possible frog move
                            else {;}
                            }
                       }
           case 2      { switch($frog_pos) {
                            case 1 {$frog_pos = 2;}# possible frog move
                            case 4 {$frog_pos = 2;}# possible frog move
                            case 5 {$frog_pos = 2;}# possible frog move
                            else {;}
                            }
                       }
           case 4      { switch($frog_pos) {
                            case 1 {$frog_pos = 4;}# possible frog move
                            case 2 {$frog_pos = 4;}# possible frog move
                            case 5 {$frog_pos = 4;}# possible frog move
                            else {;}
                            }
                       }
           case 5      { switch($frog_pos) {
                            case 1 {$frog_pos = 5;}# possible frog move
                            case 2 {$frog_pos = 5;}# possible frog move
                            case 4 {$frog_pos = 5;}# possible frog move
                            case 7 {$frog_pos = 5;}# possible frog move
                            case 8 {$frog_pos = 5;}# possible frog move
                            else {;}
                            }
                       }
           case 7      { switch($frog_pos) {
                            case 4 {$frog_pos = 7;}# possible frog move
                            case 5 {$frog_pos = 7;}# possible frog move
                            case 8 {$frog_pos = 7;}# possible frog move
                            else {;}
                            }
                       }
           case 8      { switch($frog_pos) {
                            case 4 {$frog_pos = 8;}# possible frog move
                            case 5 {$frog_pos = 8;}# possible frog move
                            case 7 {$frog_pos = 8;}# possible frog move
                            else {;}
                            }
                       }
           else        {move_frog();              # no valid frog move, try again
                       }
        }
    }
}

sub move_fly() {
    $is_fly = 1;                                  # yes, moving the fly
    randomize_it();
    move_evaluate();
    $is_fly = 0;
}

sub move_frog() {
    $is_frog = 1;                                  # yes, moving the frog
    randomize_it();
    move_evaluate();
    $is_frog = 0;
}

#main program
foreach $i (1..1000) {                            # let 's loop it enough 
    until ($fly_pos == $frog_pos) {               # frog landed on fly position
        move_fly();
        move_frog();
    }
    if ($fly_pos == 4) {$caught_at_4 = $caught_at_4 +1;}
    if ($fly_pos == 7) {$caught_at_7 = $caught_at_7 +1;}
    if ($fly_pos == 8) {$caught_at_8 = $caught_at_8 +1;}
}
print "caught at 4: $caught_at_4\n";
print "caught at 7: $caught_at_7\n";
print "caught at 8: $caught_at_8\n\n";            # seems to end here always --> B1
