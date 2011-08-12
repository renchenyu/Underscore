#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "sort_by_on_array" => sub {
    my $result;

    my $sample1   = [qw/1 2 3 4 5 6/];
    my $callback1 = sub {
        -shift;
    };
    my $expected1 = [qw/6 5 4 3 2 1/];

    my $sample2   = [qw/a b c d e f/];
    my $callback2 = sub {
        ord("z") - ord(shift);
    };
    my $expected2 = [qw/f e d c b a/];

    #func
    $result = __->sort_by( $sample1, $callback1 );
    is_deeply( $result, $expected1 );
    $result = __->sort_by( $sample2, $callback2 );
    is_deeply( $result, $expected2 );

    #oo
    $result = __($sample1)->sort_by($callback1);
    is_deeply( $result, $expected1 );
    $result = __($sample2)->sort_by($callback2);
    is_deeply( $result, $expected2 );
};

subtest "sort_by_on_hash" => sub {
    my $result;

    my $sample1 = { a => 1, b => 2, c => 3, d => 4, e => 5, f => 6 };
    my $callback1 = sub {
        -shift;
    };
    my $expected1 = [qw/6 5 4 3 2 1/];

    my $sample2
        = { 1 => 'a', 2 => 'b', 3 => 'c', 4 => 'd', 5 => 'e', 6 => 'f' };
    my $callback2 = sub {
        ord("z") - ord(shift);
    };
    my $expected2 = [qw/f e d c b a/];

    #func
    $result = __->sort_by( $sample1, $callback1 );
    is_deeply( $result, $expected1 );
    $result = __->sort_by( $sample2, $callback2 );
    is_deeply( $result, $expected2 );

    #oo
    $result = __($sample1)->sort_by($callback1);
    is_deeply( $result, $expected1 );
    $result = __($sample2)->sort_by($callback2);
    is_deeply( $result, $expected2 );

};

done_testing;
