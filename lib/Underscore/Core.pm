package Underscore::Core;
use strict;
use warnings;

require Exporter;
our @ISA    = qw/Exporter/;
our @EXPORT = qw/each map reduce reduce_right detect select reject all any include invoke pluck/;

use Carp;

use constant _LAST_ => "__undersocre__last__";

sub _itr {
    my ( $data, $itr, $to_reverse ) = @_;

    my $type = ref $data;
    if ( $type eq 'ARRAY' ) {
        my $index    = $to_reverse ? scalar(@$data) - 1 : 0;
        my @iterable = $to_reverse ? reverse @$data     : @$data;
        foreach (@iterable) {
            my $r
                = $itr->( $_, ( $to_reverse ? $index-- : $index++ ), $data );
            last if $r && $r eq _LAST_;
        }
    }
    elsif ( $type eq 'HASH' ) {
        my @iterable
            = $to_reverse ? reverse sort keys %$data : sort keys %$data;
        foreach (@iterable) {
            my $r = $itr->( $data->{$_}, $_, $data );
            last if $r && $r eq _LAST_;
        }

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

sub map {
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

sub detect {
    my ( $class, $data, $itr ) = @_;
    my $value;
    _itr $data, sub {
        if ( $itr->(@_) ) {
            $value = $_[0];
            return _LAST_;
        }
    };
    return $value;
}

sub select {
    my ( $class, $data, $itr ) = @_;
    my @result;
    _itr $data, sub {
        push @result, $_[0] if $itr->(@_);
    };
    return \@result;
}

sub reject {
    my ( $class, $data, $itr ) = @_;
    my @result;
    _itr $data, sub {
        push @result, $_[0] unless $itr->(@_);
    };
    return \@result;
}

sub all {
    my ( $class, $data, $itr ) = @_;
    my $result = 1;
    _itr $data, sub {
        $result = $result && $itr->(@_);
        return _LAST_ unless $result;
    };
    return $result;
}

sub any {
    my ( $class, $data, $itr ) = @_;
    my $result = "";
    _itr $data, sub {
        $result = $result || $itr->(@_);
        return _LAST_ if $result;
    };
    return $result;
}

sub include {
    my ( $class, $data, $value ) = @_;
    $class->any(
        $data,
        sub {
            _equal( shift, $value );
        }
    );
}

sub invoke {
    my ( $class, $data, $method, @args ) = @_;
    $class->each(
        $data,
        sub {
            shift->$method(@args);
        }
    );
}

sub pluck {
    my ( $class, $data, $key ) = @_;
    $class->map(
        $data,
        sub {
            my $value = shift;
            ref $value eq 'HASH' ? $value->{$key} : undef;
        }
    );
}

sub _equal {
    my ( $a, $b ) = @_;
    if ( ref $a eq ref $b ) {
        if ( ref $a eq '' ) {
            return ( $a . '' ) eq ( $b . '' );
        }
        else {
            return $a == $b;
        }
    }
    else {
        return "";
    }
}


1;
