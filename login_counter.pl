#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Tk;

my $hidereset=0;

GetOptions ("hide-reset" => \$hidereset);

my $mw = MainWindow->new;
$mw->title("Login Counter");
$mw->attributes(-topmost => 1);

my $counter = 0;
my $hour_counter = 0;

$mw->protocol('WM_DELETE_WINDOW' => sub {; });
my $label = $mw->Label(-text => "0:00", -font => ['Arial', 24])->pack();

my $but = $mw->Button(-text => "Reset",	-command => \&func_reset_button);
$but->pack() if (! $hidereset);

sub func_reset_button {
    $counter=0;
    $hour_counter=0;
    $label->configure(-text => "$hour_counter:".sprintf("%02d", $counter));
}

sub update_counter {
    $label->configure(-text => "$hour_counter:".sprintf("%02d", $counter));
    $counter++;
    if ($counter > 59){
        $hour_counter++;
        $counter = $counter - 60;
    }
    $mw->after(60000, \&update_counter);
}

update_counter();
MainLoop;
