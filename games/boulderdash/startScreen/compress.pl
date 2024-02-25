#!/usr/bin/perl
my $src = 'startScreen.data.asm';
my $dest = 'startScreen.compressed.data.asm';
open( SRC, '<', $src );
open( DEST, '>', $dest );
my $size = 0;
while( my $sor = <SRC> ) {
    if ( $sor =~ /^DB ([\d,]+)$/o ) {
        my $lista = $1;
        print DEST compress( $lista );
    } else {
        print DEST $sor;
    }
}
close( DEST );
close( SRC );
printf "%d helyett %d\n", 14*48, $size;

sub compress {
    my $lista = shift;
print "$lista\n";
    my @list = split /,/, $lista;
    my @out;
    my $i=0;
    my $cnt = 1;
    while( $i<=$#list ) {
        if ( $i == $#list ) {
            $out[ $#out+1 ] = $cnt;
            $out[ $#out+1 ] = $list[ $i ];
            $size += 2;
        } else {
            if ( $list[ $i ] == $list[ $i+1 ] ) {
                $cnt++;
            } else {
                $out[ $#out+1 ] = $cnt;
                $out[ $#out+1 ] = $list[ $i ];
                $cnt = 1;
                $size += 2;
            }
        }
        $i++;
    }
    return join( ',', @out )."\n";
}
