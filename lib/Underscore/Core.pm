package Underscore::Core;
use strict;
use warnings;

require Exporter;
our @ISA    = qw/Exporter/;
our @EXPORT = qw/each mmap reduce reduce_right/;

use Carp;

sub _itr {
    my ( $data, $itr, $to_reverse ) = @_;

    my $type = ref $data;
    if ( $type eq 'ARRAY' ) {
        my $index    = $to_reverse ? scalar(@$data) - 1 : 0;
        my @iterable = $to_reverse ? reverse @$data     : @$data;
        $itr->( $_, ( $to_reverse ? $index-- : $index++ ), $data )
            foreach @iterable;
    }
    elsif ( $type eq 'HASH' ) {
        my @iterable
            = $to_reverse ? reverse sort keys %$data : sort keys %$data;
        $itr->( $data->{$_}, $_, $data ) foreach @iterable;
    }
    else {
        croak "Must be reference of HASH or ARRAY";
    }
    return;
}

sub each {
    my ( $class, $data, $itr ) = @_;
    _itr $data, sub {
        $itr->(@_);
    };
}

sub mmap {
    my ( $class, $data, $itr ) = @_;
    my @result;
    _itr $data, sub {
        push @result, $itr->(@_);
    };
    return \@result;
}

sub reduce {
    my ( $class, $data, $itr, $memo ) = @_;
    _itr $data, sub {
        $memo = $itr->( $memo, @_ );
    };
    return $memo;
}

sub reduce_right {
    my ( $class, $data, $itr, $memo ) = @_;
    _itr $data, sub {
        $memo = $itr->( $memo, @_ );
    }, 1;
    return $memo;
}


1;
