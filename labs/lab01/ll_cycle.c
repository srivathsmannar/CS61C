#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
   struct  node *tortoise = head;
   struct  node *hare = head;
if (!hare) {
return 0;
}
    while(1) {
if (hare->next && hare->next->next) {
hare = hare->next->next;
tortoise = tortoise->next;
if(hare == tortoise) {
return 1;
}
}
else if(hare->next) {
hare = hare->next;
if(hare == tortoise) {
return 1;
}
}
else {
return 0;
}
}
}
