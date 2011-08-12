package Counter;
use strict;
use warnings;

sub new {
    my ($class, $count) = @_;
    bless { count => $count }, $class;
}

sub count {
    shift->{count};
}

sub incr {
    shift->{count}++;
}

sub decr {
    shift->{count}--;
}

sub add {
    shift->{count} += shift;
}


1;
