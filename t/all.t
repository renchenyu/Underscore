#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "all_on_array" => sub {
    my $result;

    my $sample1  = [qw/2 4 6 8 10/];
    my $sample2  = [qw/2 4 6 8 10 11 12 13/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        return $ele % 2 == 0;
    };

    #func
    $result = __->all( $sample1, $callback );
    ok($result);
    $result = __->all( $sample2, $callback );
    ok( !$result );

    #oo
    $result = __($sample1)->all($callback);
    ok($result);
    $result = __($sample2)->all($callback);
    ok( !$result );
};

subtest "all_on_hash" => sub {
    my $result;

    my $sample1 = {
        a => 2,
        b => 4,
        c => 6
    };
    my $sample2 = {
        a => 2,
        b => 4,
        c => 6,
        d => 7
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        return $value % 2 == 0;
    };

    #func
    $result = __->all( $sample1, $callback );
    ok($result);
    $result = __->all( $sample2, $callback );
    ok( !$result );

    #oo
    $result = __($sample1)->all($callback);
    ok($result);
    $result = __($sample2)->all($callback);
    ok( !$result );
};

done_testing;

