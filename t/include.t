#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "include_on_array" => sub {
    my $str_array   = [qw/hello world nice to meet u/];
    my $num_array   = [ 1, 2, 3, 4, 5 ];
    my $array_array = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];

    #func
    ok( __->include( $str_array,   'to' ) );
    ok( __->include( $num_array,   3 ) );
    ok( __->include( $array_array, $array_array->[-1] ) );
    ok( !__->include( $array_array, [ 1, 2, 3 ] ) );

    #oo
    ok( __($str_array)->include('to') );
    ok( __($num_array)->include(3) );
    ok( __($array_array)->include( $array_array->[-1] ) );
    ok( !__($array_array)->include( [ 1, 2, 3 ] ) );
};

subtest "include_on_hash" => sub {
    my $str_hash = {
        1 => 'hello',
        2 => 'world',
        3 => 'nice',
        4 => 'to',
        5 => 'u'
    };
    my $num_hash = {
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5
    };
    my $array_hash = {
        1 => [ 1, 2, 3 ],
        2 => [ 4, 5, 6 ]
    };

    #func
    ok( __->include( $str_hash,   'to' ) );
    ok( __->include( $num_hash,   3 ) );
    ok( __->include( $array_hash, $array_hash->{2} ) );
    ok( !__->include( $array_hash, [ 4, 5, 6 ] ) );

    #oo
    ok( __($str_hash)->include('to') );
    ok( __($num_hash)->include(3) );
    ok( __($array_hash)->include( $array_hash->{2} ) );
    ok( !__($array_hash)->include( [ 4, 5, 6 ] ) );
};

done_testing;
