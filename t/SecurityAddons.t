#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => "security_addons";
zci is_cached   => 1;
my $plaintext="Firefox: https://addons.mozilla.org/en-US/firefox/collections/mozilla/privacy/";
   $plaintext.="\nSafari: https://extensions.apple.com/?category=security";
   $plaintext.="\nGoogle Chrome: https://chrome.google.com/webstore/search/anonymous";
   $plaintext.="\nOpera: https://addons.opera.com/en/extensions/category/privacy-security/?order=popular&language=en";
my @record_data = {
    'Firefox' => "https://addons.mozilla.org/en-US/firefox/collections/mozilla/privacy/",
    'Safari' => "https://extensions.apple.com/?category=security",
    'Google Chrome' => "https://chrome.google.com/webstore/search/anonymous",
    'Opera' => "https://addons.opera.com/en/extensions/category/privacy-security/?order=popular&language=en"
};
my @record_keys = ["Firefox", "Safari", "Google Chrome", "Opera"];
my $structured_answer = {
    id => "security_addons",
    name => "software",
    data => {
        title => "Security Addons",
        record_data => @record_data
    },
    meta => {},
    templates => {      
        group => 'list',
        options => {
            content => "record"
        },
    },
};
my $answer = test_zci($plaintext,structured_answer=>$structured_answer);
ddg_goodie_test(
	[
		'DDG::Goodie::SecurityAddons'
	],
    
    'privacy extensions' => $answer,
    'privacy extension' => $answer,
    'privacy addons' => $answer,
    'privacy addon' => $answer,
    
    'privacy extensions firefox' => $answer,
    'firefox privacy extension' => $answer,
    
    'google chrome privacy addons' => $answer,
    'opera privacy addon' => $answer,
    'safari privacy extensions' => $answer,
    
    'ie privacy extension' => undef,
    'internet explorer privacy addons' => undef,
);

done_testing;
