use strict;
use Text::I18N;
use Test::Simple tests => 3;

my $t = Text::I18N->new;
$t->parse( \<<"");
de:
<html>
    <head>
    </head>
    <body>
        Hallo
    </body>
</html>
en:
<html>
    <head>
    </head>
    <body>
        Hello
    </body>
</html>

ok( $t->extract('de') =~ /Hallo/ );

$t->parse( \<<"");
Parrot
Foo
Bar
de-de:
Papagei
Foo
Bar
=head1 TEST
fooo
=cut
baaar
no:
Skol

ok( $t->extract('de-de') );

my $t2 = Text::I18N->new;
$t2->parse( \<<"");
de:
Hallo
en:
Hello

ok( $t2->extract('de') eq "Hallo\n" );
