###OYSTERCARD

This project mocks TfL Oystercard functionality. 

touch_in
touch_out
in_journey?

create new card
check balance 0
card.top_up(amount)
check balance = amount
check card.in_journey? false

card.touch_in 
check card.in_journey? true
check balance = amount

card.touch_out
check card.in_journey? false
check balance = amount - journey cost
