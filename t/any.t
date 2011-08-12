#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "any_on_array" => sub {
    my $result;

    my $sample1  = [qw/2 4 6 8/];
    my $sample2  = [qw/2 3 4 6 8/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        return $ele % 2 != 0;
    };

    #func
    $result = __->any( $sample1, $callback );
    ok( !$result );
    $result = __->any( $sample2, $callback );
    ok($result);

    #oo
    $result = __($sample1)->any($callback);
    ok( !$result );
    $result = __($sample2)->any($callback);
    ok($result);
};

subtest "any_on_hash" => sub {
    my $result;

    my $sample1 = {
        a => 2,
        b => 4,
        c => 6,
        d => 8
    };
    my $sample2 = {
        a => 2,
        b => 3,
        c => 4,
        d => 6,
        e => 8
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        return $value % 2 != 0;
    };

    #func
    $result = __->any( $sample1, $callback );
    ok( !$result );
    $result = __->any( $sample2, $callback );
    ok($result);

    #oo
    $result = __($sample1)->any($callback);
    ok( !$result );
    $result = __($sample2)->any($callback);
    ok($result);
};

done_testing;
