#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "reduce_on_array" => sub {
    my $result;

    my $sample   = [qw/a b c/];
    my $callback = sub {
        my ( $memo, $ele, $idx, $list ) = @_;
        return $memo . $ele . $idx . $list->[$idx];
    };
    my $expected       = "a0ab1bc2c";
    my $right_expected = "c2cb1ba0a";

    #func
    $result = __->reduce( $sample, $callback, "" );
    is( $result, $expected );

    $result = __->reduce_right( $sample, $callback, "" );
    is( $result, $right_expected );

    #oo
    $result = __($sample)->reduce( $callback, "" );
    is( $result, $expected );

    $result = __($sample)->reduce_right( $callback, "" );
    is( $result, $right_expected );

};

subtest "reduce_on_hash" => sub {
    my $result;

    my $sample = {
        a => 1,
        b => 2,
        c => 3
    };
    my $callback = sub {
        my ( $memo, $value, $key, $hash ) = @_;
        return [ $memo, [ $value, $key, $hash->{$key} ] ];
    };
    my $expected
        = [ [ [ [], [ 1, 'a', 1 ] ], [ 2, 'b', 2 ] ], [ 3, 'c', 3 ] ];
    my $right_expected
        = [ [ [ [], [ 3, 'c', 3 ] ], [ 2, 'b', 2 ] ], [ 1, 'a', 1 ] ];

    #func
    $result = __->reduce( $sample, $callback, [] );
    is_deeply( $result, $expected );

    $result = __->reduce_right( $sample, $callback, [] );
    is_deeply( $result, $right_expected );

    #oo
    $result = __($sample)->reduce( $callback, [] );
    is_deeply( $result, $expected );

    $result = __($sample)->reduce_right( $callback, [] );
    is_deeply( $result, $right_expected );
};

done_testing;

