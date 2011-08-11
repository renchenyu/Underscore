#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "mmap_on_array" => sub {
    my $result;

    my $sample   = [qw/1 2 3/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        return $ele * 2 * $idx * $list->[ $idx - 1 ];
    };
    my $expected = [qw/0 4 24/];

    #func
    $result = __->mmap( $sample, $callback );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->mmap($callback);
    is_deeply( $result, $expected );
};

subtest "mmap_on_hash" => sub {
    my $result;

    my $sample = {
        3 => 1,
        2 => 2,
        1 => 3
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        return $value * $key * $hash->{$key};
    };
    #sorted by key
    my $expected = [qw/9 8 3/];

    #func
    $result = __->mmap( $sample, $callback );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->mmap($callback);
    is_deeply( $result, $expected );
};

done_testing;
