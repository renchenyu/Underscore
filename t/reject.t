#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "reject_on_array" => sub {
    my $result;

    my $sample   = [qw/1 2 3 4 5 6/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        return $ele % 2 == 0;
    };
    my $expected = [qw/1 3 5/];

    #func
    $result = __->reject( $sample, $callback );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->reject($callback);
    is_deeply( $result, $expected );
};

subtest "reject_on_hash" => sub {
    my $result;

    my $sample = {
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5,
        f => 6
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        return $value % 2 == 0;
    };
    my $expected = [qw/1 3 5/];

    #func
    $result = __->reject( $sample, $callback );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->reject($callback);
    is_deeply( $result, $expected );
};

done_testing;
