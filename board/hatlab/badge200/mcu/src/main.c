#include <avr/io.h>
#include <util/delay.h>

int main()
{
    DDRB |= _BV(PB0);
    while(1)
    {
        PORTB ^= _BV(PB0);
        _delay_ms(500);
    }
}
