#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "detect_on_array" => sub {
    my $result;

    my $sample   = [qw/1 2 3 4 5/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        return $ele % 2 == 0;
    };
    my $expected = 2;

    #func
    $result = __->detect( $sample, $callback );
    is( $result, $expected );

    #oo
    $result = __($sample)->detect($callback);
    is( $result, $expected );
};

subtest "detect_on_hash" => sub {
    my $result;

    my $sample = {
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        return $value % 2 == 0;
    };
    my $expected = 2;

    #func
    $result = __->detect( $sample, $callback );
    is( $result, $expected );

    #oo
    $result = __->detect( $sample, $callback );
    is( $result, $expected );
};

done_testing;

