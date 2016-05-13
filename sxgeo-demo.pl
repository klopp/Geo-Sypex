#!/usr/bin/perl

use utf8;
use open qw/:std :utf8/;
use Modern::Perl;
use Geo::Sypex;
use Data::Printer return_value => 'dump';

my $sxgeo = Geo::Sypex->new( 'SxGeoCity.dat' );
my $ip = $ENV{'REMOTE_ADDR'}; 
$ip ||= $ENV{'X_FORWARDED_FOR'};
$ip ||= $ENV{'PROXY_USER'};
$ip ||= $ENV{'VIA'};
$ip ||= '127.0.0.1'; 

my $geodata = $sxgeo->get( $ip );

say "Content-Type: text/plain; charset=UTF-8\n\nIP: $ip\n";
say $geodata ? p($geodata) : 'Error: '.$sxgeo->errstr;
