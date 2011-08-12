#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

use Counter;

subtest 'invoke_on_array' => sub {
    my @sample = map { Counter->new($_) } ( 0 .. 9 );

    #func
    __->invoke( \@sample, 'add', 5 );
    is_deeply( [ map { $_->count } @sample ], [ ( 5 .. 14 ) ] );

    #oo
    __( \@sample )->invoke( 'add', -5 );
    is_deeply( [ map { $_->count } @sample ], [ ( 0 .. 9 ) ] );
};

subtest 'invoke_on_hash' => sub {
    my %sample;
    foreach ( 0 .. 9 ) {
        $sample{$_} = Counter->new($_);
    }

    #func
    __->invoke( \%sample, 'add', 5 );
    is_deeply( [ map { $_->count } @sample{ 0 .. 9 } ], [ ( 5 .. 14 ) ] );

    #oo
    __( \%sample )->invoke( 'add', -5 );
    is_deeply( [ map { $_->count } @sample{ 0 .. 9 } ], [ ( 0 .. 9 ) ] );
};

done_testing;

