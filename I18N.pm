package Text::I18N;

use strict;
use I18N::LangTags 'is_language_tag';

our $VERSION = '0.03';

=head1 NAME

Text::I18N - Simple multi language markup

=head1 SYNOPSIS

    use Text::I18N;
    my $t = Text::I18N->new( \<<"");
    de:
    Hallo
    en:
    Hello

    $t->parse( \<<"");
    no:
    Skol

    my @langtags = $t->langtags;
    my $text = $t->extract('de');
    print $t->dump;

=head1 DESCRIPTION

Simple human editable multi language markup, useful in combination with POD,
Wikitext, Textile or HTML.

=head2 METHODS

=cut 

sub new {
    my $self = shift;
    my $args = ( ref $_[0] eq 'HASH' ) ? $_[0] : {};
    $self = bless( {}, ( ref($self) || $self ) );
    $self->{default} = $args->{default} || 'i-default';
    $self->{regex}   = $args->{regex}   || qr/^(\S+):$/;
    $self->{parsed}  = {};
    $self->parse( $_[0] ) if ( ref $_[0] eq 'SCALAR' );
    return $self;
}

=head3 append

Append text in specific language.

=cut

sub append {
    my ( $self, $langtag, $text ) = @_;
    $self->{parsed}->{$langtag} .= $text;
}

=head3 dump

Dump parsed text.

=cut

sub dump {
    my $self = shift;
    my $dump;
    while ( my ( $langtag, $text ) = each %{ $self->{parsed} } ) {
        $dump .= "$langtag:\n$text";
    }
    return $dump;
}

=head3 extract

Extract text in specific language.

=cut

sub extract {
    my ( $self, $langtag ) = @_;
    return $self->{parsed}->{ $langtag || $self->{default} };
}

=head3 langtags

Return list of found langtags.

=cut

sub langtags { return keys %{ $_[0]->{parsed} } }

=head3 parse

Parse text snippet.

=cut

sub parse {
    my ( $self, $input ) = @_;
    my $langtag = $self->{default};
    for my $line ( split /[\n\r]+/, $$input ) {
        if ( $line =~ $self->{regex} ) {
            is_language_tag($1)
              ? ( $langtag = $1 )
              : $self->append( $langtag, "$line\n" );
        }
        else { $self->append( $langtag, "$line\n" ) }
    }
}

=head1 AUTHOR

Sebastian Riedel, C<sri@cpan.org>

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 SEE ALSO

L<Locale::Maketext>, L<I18N::LangTags>

=cut

1;
