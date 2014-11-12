#!/usr/bin/env perl

use strict;
use warnings;
use Term::ANSIColor;

our $CURRENT_DIR = `pwd`; chomp $CURRENT_DIR;
our $HOME = $ENV{"HOME"};

main();

sub show_help {
	print "USAGE: restore opt1 [opt2 opt3 ..]\n";
	print "OPTIONS: all bash sublime atom icons\n";
	exit();
}

sub mylog {
	my ($message, $color) = @_;
	print color($color), "$message \n", color("reset");
}

sub show_invalid {
	my @invalid = @_;
	for (@invalid) { 
		mylog "Invalid argument: $_", "red"; 
	}
}

sub bash_profile_old {
	print color("blue"), "Setting bash profile.. \n", color("reset");
	my $bash_profile = "ln -sf $CURRENT_DIR/bash_profile $HOME/.bash_profile";
	print qx{$bash_profile};
	print color("green"), "Setting bash profile finished!\n", color("reset");
}

sub sublime_old {
	mylog "Setting Sublime Preferences..", "blue";
	
	my $rm_packages = "rm -r '$HOME/Library/Application Support/Sublime Text 2/Packages'";
	print qx{$rm_packages};	
	my $ln_packages = "ln -svnf '$CURRENT_DIR/sublime/Packages' '$HOME/Library/Application Support/Sublime Text 2'";
	print qx{$ln_packages};

	my $rm_installed = "rm -r '$HOME/Library/Application Support/Sublime Text 2/Installed Packages'";
	print qx{$rm_installed};
	my $ln_installed = "ln -svnf  '$CURRENT_DIR/sublime/Installed Packages' '$HOME/Library/Application Support/Sublime Text 2'";
	print qx{$ln_installed};

	mylog "Setting Sublime Preferences finished!", "green";
}

sub sublime {
	mylog "Setting Sublime Preferences..", "blue";
	my $cmd = "sublime/sublime.sh";
	print qx{$cmd};
	mylog "Setting Sublime Preferences finished!", "green";
}

sub atom {
	print color("blue"), "Setting Atom Preferences.. \n", color("reset");

	my $rm = "rm -r '$HOME/.atom'";
	print qx{$rm};
	my $ln = "ln -svnf '$CURRENT_DIR/atom' '$HOME/.atom'";
	print qx{$ln};

	print color("green"), "Setting Atom Preferences finished!\n", color("reset");
}

sub iterm {
	print "Set configuration file under Preferences -> General";
}

sub icons {
	print color("blue"), "Setting icons.. \n", color("reset");

	my $cd = "cd icons";
	print qx{$cd};
	my $cmd = "./changeicons";
	print qx{$cmd};

	print color("green"), "Setting icons finished!\n", color("reset");
}

sub z {
	mylog "Won't really work: z auto creates a new .z file", "red";
	exit;
	
	mylog "Symlink .z file to HOME", "blue";
	
	my $rm = "rm $HOME/.z";
	print $rm, "\n";
	print qx{$rm};
	my $ln = "ln -svf $CURRENT_DIR/z/z $HOME/.z";
	print $ln, "\n";
	print qx{$ln};
	
	mylog "Ended symlink .z file", "green";
}

sub all {
	sublime(); 
	icons();
	z();
}

sub main {
	show_help() if @ARGV < 1;
	my %set = map { $_ => 1 } qw( all icons z sublime);

	all()          if grep { $_ eq "all"     } @ARGV;
	sublime()      if grep { $_ eq "sublime" } @ARGV;
	icons()        if grep { $_ eq "icons"   } @ARGV;
	z()			   if grep { $_ eq "z"       } @ARGV;

	my @invalid = grep { not $set{$_} } @ARGV;
	show_invalid(@invalid);
}