#include <stdio.h>
#include <unistd.h>

int main()
{
   setuid( 0 );
   (void)fopen("/cache/.boot_to_or", "w");
   return 0;
}
