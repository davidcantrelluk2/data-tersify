package Data::Tersify::Plugin::DateTime;

use strict;
use warnings;

use DateTime;

our $VERSION = '0.001';
$VERSION = eval $VERSION;

=head1 NAME

Data::Tersify::Plugin::DateTime - tersify DateTime objects

=head1 SYNOPSIS

 use Data::Tersify;
 print dumper(tersify({ now => DateTime->now }));
 # Prints just today's date and time in yyyy-mm-ss hh:mm:ss format,
 # rather than a full screen of DateTime internals

=head1 DESCRIPTION

This class provides terse description for DateTime objects.

=head2 handles

It handles DateTime objects only.

=cut

sub handles { 'DateTime' }

=head2 tersify

It summarises DateTime objects without a specified time zone into either
C<yyyy-mm-dd> or C<yyyy-mm-dd hh:mm:ss>, depending on whether there's a time
component to the DateTime object or not.

If there is a specified time zone then they are summarised as
C<yyyy-mm-dd 00:00:00 Time/Zone> or C<yyyy-mm-dd hh:mm:ss Time/Zone>.

=cut

sub tersify {
    my ($self, $datetime) = @_;

    my $terse = $datetime->ymd;
    if ($datetime->hms ne '00:00:00') {
        $terse .= ' ' . $datetime->hms;
        if ($datetime->time_zone->name ne 'floating') {
            $terse .= ' ' . $datetime->time_zone->name;
        }
    } elsif ($datetime->time_zone->name ne 'floating') {
        $terse .= ' 00:00:00 ' . $datetime->time_zone->name;
    }
    return $terse;
}

1;

