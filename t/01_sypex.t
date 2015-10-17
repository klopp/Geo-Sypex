use strict;
use utf8;
use Test::More tests => 12;
use Geo::Sypex qw/SXGEO_BATCH SXGEO_MEM/;

my %testcountry = do 't/country.p';
my %testcity = do 't/city.p';

do_tests( 0, 'no flags, country codes', \%testcountry, 'country_iso', 'SxGeo' );
do_tests( SXGEO_BATCH, 'SXGEO_BATCH, country codes', \%testcountry, 'country_iso', 'SxGeo' );
do_tests( SXGEO_MEM, 'SXGEO_MEM, country codes', \%testcountry, 'country_iso', 'SxGeo' );
do_tests( SXGEO_MEM+SXGEO_BATCH, 'SXGEO_MEM+SXGEO_BATCH, country codes', \%testcountry, 'country_iso', 'SxGeo' );

do_tests( 0, 'no flags, UTF-8 city codes', \%testcity, 'city_id', 'SxGeoCity' );
do_tests( SXGEO_BATCH, 'SXGEO_BATCH, UTF-8 city codes', \%testcity, 'city_id', 'SxGeoCity' );
do_tests( SXGEO_MEM, 'SXGEO_MEM, UTF-8 city codes', \%testcity, 'city_id', 'SxGeoCity' );
do_tests( SXGEO_MEM+SXGEO_BATCH, 'SXGEO_MEM+SXGEO_BATCH, UTF-8 city codes', \%testcity, 'city_id', 'SxGeoCity' );

do_tests( 0, 'no flags, CP-1251 city codes', \%testcity, 'city_id', 'SxGeoCity1251' );
do_tests( SXGEO_BATCH, 'SXGEO_BATCH, CP-1251 city codes', \%testcity, 'city_id', 'SxGeoCity1251' );
do_tests( SXGEO_MEM, 'SXGEO_MEM, CP-1251 city codes', \%testcity, 'city_id', 'SxGeoCity1251' );
do_tests( SXGEO_MEM+SXGEO_BATCH, 'SXGEO_MEM+SXGEO_BATCH, CP-1251 city codes', \%testcity, 'city_id', 'SxGeoCity1251' );

sub do_tests
{
  my ( $flags, $label, $data, $field, $file ) = @_;

  subtest "$file.dat, $label" => sub
  {
    plan tests => scalar( keys %{$data} ) + 1;

    my $geo = Geo::Sypex->new( "data/$file.dat", $flags );
    ok( !$geo->errstr, "Geo::Sypex(data/$file.dat, $label) created OK" );
    BAIL_OUT( "Geo::Sypex(data/$file.dat, $label) object NOT created: ".$geo->errstr) if $geo->errstr;

    for( keys %{$data} )
    {
      my $rc = $geo->get( $_ );
      $rc->{$field} ||= 0;
      ok( $rc->{$field} == $data->{$_} ) 
        or diag ( "$_: expect $rc->{$_}, got $rc->{$field}" );
    }
  };
}
