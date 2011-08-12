#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "pluck_on_array" => sub {
    my $result;

    my $sample = [
        { name => "moe",   age => 40 },
        { name => "larry", age => 50 },
        { name => "curly", age => 60 }
    ];
    my $expected = [qw/moe larry curly/];

    #func
    $result = __->pluck( $sample, "name" );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->pluck("name");
    is_deeply( $result, $expected );
};

subtest "pluck_on_hash" => sub {
    my $result;

    my $sample = {
        1 => { name => "moe",   age => 40 },
        2 => { name => "larry", age => 50 },
        3 => { name => "curly", age => 60 }
    };
    my $expected = [qw/moe larry curly/];

    #func
    $result = __->pluck( $sample, "name" );
    is_deeply( $result, $expected );

    #oo
    $result = __($sample)->pluck("name");
    is_deeply( $result, $expected );
};

done_testing;
