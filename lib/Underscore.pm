package Underscore;
use strict;
use warnings;

require Exporter;
our @ISA      = qw/Exporter/;
our @EXPORT = qw/__/;

use Carp;

use Underscore::Core;

sub __ {
    my $args_length = scalar @_;
    croak "zero or one parameters\n" if $args_length > 1;
    if ( $args_length == 0 ) {
        return __PACKAGE__;
    }
    else {
        my $ref_type = ref $_[0];
        if ( $ref_type eq 'HASH' || $ref_type eq 'ARRAY' ) {
            my $cloned = $ref_type eq 'HASH' ? {%{$_[0]}} : [@{$_[0]}];
            return Underscore::Wrapper->new($cloned);
        }
        else {
            croak "invalid ref\n";

        }
    }
}

package Underscore::Wrapper;
use strict;
use warnings;

use Data::Dumper;
use Carp;

use Underscore::Core qw//;

our $AUTOLOAD;

sub new {
    my ( $class, $data, $is_chain ) = @_;
    return bless { data => $data, is_chain => $is_chain }, $class;
}

sub AUTOLOAD {
    my ( $self, @argv ) = @_;

    my $sub_name = $AUTOLOAD;
    $sub_name =~ s/.*::(.*?)$/$1/;

    return if $sub_name =~ /^DESTROY$/;

    if ( $sub_name !~ /^_/
        && ( my $core_sub = Underscore::Core->can($sub_name) ) )
    {
        {
            no strict 'refs';
            *{$sub_name} = sub {
                my ( $self, @argv ) = @_;
                my $result = $core_sub->( undef, $self->{data}, @argv );

                return $self->{is_chain}
                    ? __PACKAGE__->new( $result, 1 )
                    : $result;
            };
        }
        return $self->$sub_name(@argv);
    }

    croak "Cannot find method: $AUTOLOAD";
    return;
}

sub chain {
    my $self = shift;
    $self->{is_chain} = 1;
    return $self;
}

sub value {
    shift->{data};
}

1;

