(*1*)
fun is_older((d1,m1,y1),(d2,m2,y2)) =
    if y1 < y2 then true
    else if y1 > y2 then false
    else if m1 < m2 then true
    else if m1 > m2 then false
    else if d1 < d2 then true
    else false;

(*2*)
fun number_in_month(dates, month) =
    List.foldl (fn ((d,m,y), acc) => if m = month then acc + 1 else acc) 0 dates;

(*3*)
fun number_in_months(dates, months) =
    List.foldl (fn (month, acc) => acc + number_in_month(dates, month)) 0 months;

(*4*)
fun dates_in_month(dates, month) =
    List.filter (fn (d,m,y) => m = month) dates;

(*5*)
fun get_nth(strings, n) =
    List.nth(strings, n-1);

(*6*)
val month_names = ["January", "February", "March", "April", "May", "June",
                   "July", "August", "September", "October", "November", "December"];

fun date_to_string (d, m, y) =
    get_nth(month_names, m) ^ " " ^ Int.toString(d) ^ ", " ^ Int.toString(y);

(*7*)
fun number_before_reaching(target, numbers) =
    let
        fun helper (target, numbers, acc, sum) =
            if sum >= target then acc
            else helper(target, tl numbers, acc+1, sum + hd numbers)
    in
        helper(target, numbers, 0, 0)
    end;

(*8*)
val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

fun what_month(day) =
    number_before_reaching(day, days_in_month) + 1;


(*9*)
fun month_range(day1, day2) =
    let
        val m1 = what_month(day1)
        val m2 = what_month(day2)
        fun helper (m, acc) =
            if m > m2 then acc
            else helper(m+1, acc @ [m])
    in
        if m1 <= m2 then helper(m1, [])
        else []
    end;

(*10*)
fun oldest(dates) =
    List.foldl (fn (date, acc) => if is_older(date, acc) then date else acc) (hd dates) (tl dates);


