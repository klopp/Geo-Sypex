# NAME

Geo::Sypex - [Sypex Geo](https://sypexgeo.net/) databases parser

# VERSION

Version v1.0.10

# SYNOPSIS

    use Geo::Sypex qw/SXGEO_BATCH/;

    my $sxgeo = Geo::Sypex->new( 'SxGeo.dat', SXGEO_BATCH );
    my $geodata = $sxgeo->get( '93.191.14.81' ); 
    

# DESCRIPTION

This module parse [Sypex Geo](http://sypexgeo.net/) databases and allow to get geo information for IP.

Only `SxGeo.dat` and `SxGeoCity.dat` supported. 

# SUBROUTINES/METHODS

- new( `$file` \[, `$flags`\] )

    Valid `$flags` values: `SXGEO_BATCH` (for multiple `get` requests), `SXGEO_MEM`.  

- get( `$ip` \[, `@fields`\] )

    Return geodata or undef.

        use Data::Printer;
        my $geodata = $sxgeo->get( '93.191.14.81' );
        p $geodata; 

    Output:

        \ {
            city_en       "Fryazino",
            city_id       562319,
            city_ru       "Фрязино",
            country_id    185,
            country_iso   "ru",
            lat           55.96056,
            lon           38.04556,
            region_id     10267
        }

    You can indicate fields to return:

        my $geodata = $sxgeo->get( '93.191.14.81', 'city_en', 'lat', 'lon' );
        p $geodata; 

    Output:

        \ {
            city_en       "Fryazino",
            lat           55.96056,
            lon           38.04556
        }

    For `SxGeo.dat` only two field avaliable: `country_id`, `country_iso`.

- errstr

    Return internal error string. Example:

        my $geodata = $sxgeo->get( '666.356.299.400' ); 
        say $sxgeo->errstr unless $geodata;

# BUGS AND LIMITATIONS

With `SXGEO_MEM` flag entire file will be loaded into memory!

# LICENSE AND COPYRIGHT

Coyright (C) 2015 Vsevolod Lutovinov.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. The full text of this license can be found in
the LICENSE file included with this module.

# AUTHOR

Contact the author at klopp@yandex.ru.

# SOURCE CODE

Source code and issues can be found here:
 [https://github.com/klopp/sxgeo-perl](https://github.com/klopp/sxgeo-perl)
