#!/usr/bin/perl
use strict;
use warnings;

use Test::More;

use Underscore;

subtest 'max_on_array' => sub {
    my $result;

    my @nums  = ( 1,   2,   3,   4,   5 );
    my @chars = ( 'a', 'b', 'c', 'd', 'e' );
    my @hashes = (
        { num => 1 },
        { num => 2 },
        { num => 3 },
        { num => 4 },
        { num => 5 }
    );

    #func
    $result = __->max( \@nums );
    is( $result, 5 );
    $result = __->max( \@chars );
    is( $result, 'e' );
    $result = __->max( \@hashes, sub { shift->{num} } );
    is( $result, 5 );

    #oo
    $result = __( \@nums )->max;
    is( $result, 5 );
    $result = __( \@chars )->max;
    is( $result, 'e' );
    $result = __( \@hashes )->max( sub { shift->{num} } );
    is( $result, 5 );

};

subtest 'max_on_hash' => sub {
    my $result;

    my %nums = (
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5
    );
    my %chars = (
        1 => 'a',
        2 => 'b',
        3 => 'c',
        4 => 'd',
        5 => 'e'
    );
    my %hashes = (
        a => { num => 1 },
        b => { num => 2 },
        c => { num => 3 },
        d => { num => 4 },
        e => { num => 5 }
    );

    #func
    $result = __->max( \%nums );
    is( $result, 5 );
    $result = __->max( \%chars );
    is( $result, 'e' );
    $result = __->max( \%hashes, sub { shift->{num} } );
    is( $result, 5 );

    #oo
    $result = __( \%nums )->max;
    is( $result, 5 );
    $result = __( \%chars )->max;
    is( $result, 'e' );
    $result = __( \%hashes )->max(
        sub {
            shift->{num};
        }
    );
    is( $result, 5 );

};

subtest 'min_on_array' => sub {
    my $result;

    my @nums  = ( 1,   2,   3,   4,   5 );
    my @chars = ( 'a', 'b', 'c', 'd', 'e' );
    my @hashes = (
        { num => 1 },
        { num => 2 },
        { num => 3 },
        { num => 4 },
        { num => 5 }
    );

    #func
    $result = __->min( \@nums );
    is( $result, 1 );
    $result = __->min( \@chars );
    is( $result, 'a' );
    $result = __->min( \@hashes, sub { shift->{num} } );
    is( $result, 1 );

    #oo
    $result = __( \@nums )->min;
    is( $result, 1 );
    $result = __( \@chars )->min;
    is( $result, 'a' );
    $result = __( \@hashes )->min( sub { shift->{num} } );
    is( $result, 1 );

};

subtest 'min_on_hash' => sub {
    my $result;

    my %nums = (
        a => 1,
        b => 2,
        c => 3,
        d => 4,
        e => 5
    );
    my %chars = (
        1 => 'a',
        2 => 'b',
        3 => 'c',
        4 => 'd',
        5 => 'e'
    );
    my %hashes = (
        a => { num => 1 },
        b => { num => 2 },
        c => { num => 3 },
        d => { num => 4 },
        e => { num => 5 }
    );

    #func
    $result = __->min( \%nums );
    is( $result, 1 );
    $result = __->min( \%chars );
    is( $result, 'a' );
    $result = __->min( \%hashes, sub { shift->{num} } );
    is( $result, 1 );

    #oo
    $result = __( \%nums )->min;
    is( $result, 1 );
    $result = __( \%chars )->min;
    is( $result, 'a' );
    $result = __( \%hashes )->min(
        sub {
            shift->{num};
        }
    );
    is( $result, 1 );
};

done_testing;
