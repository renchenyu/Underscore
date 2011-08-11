#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest "each_on_array" => sub {
    my %result;

    my $sample   = [qw/a b c/];
    my $callback = sub {
        my ( $ele, $idx, $list ) = @_;
        $result{$ele} = $idx . $list->[$idx];
    };
    my $expected = {
        a => "0a",
        b => "1b",
        c => "2c"
    };

    #func
    __->each( $sample, $callback );
    is_deeply( \%result, $expected );

    %result = ();

    #oo
    __($sample)->each($callback);
    is_deeply( \%result, $expected );
};

subtest "each_on_hash" => sub {
    my %result;

    my $sample = {
        a => 1,
        b => 2,
        c => 3
    };
    my $callback = sub {
        my ( $value, $key, $hash ) = @_;
        $result{$value} = $key . $hash->{$key};
    };
    my $expected = {
        1 => "a1",
        2 => "b2",
        3 => "c3"
    };

    #func
    __->each( $sample, $callback );
    is_deeply( \%result, $expected );

    %result = ();

    #oo
    __($sample)->each($callback);
    is_deeply( \%result, $expected );

};

done_testing();

