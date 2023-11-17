fun is_older ((day1, month1, year1), (day2, month2, year2)) =
  if year1 < year2 then true
  else if year1 = year2 then
    if month1 < month2 then true
    else if month1 = month2 then
      if day1 < day2 then true
      else false
    else false
  else false;

fun number_in_month (dates, month) =
  let
    fun count_month ([], acc) = acc
    | count_month ((_, m, _) :: tl, acc) =
      if m = month then count_month (tl, acc + 1)
      else count_month (tl, acc)
  in
    count_month (dates, 0)
  end;

fun number_in_months (dates, months) =
  let
    fun count_months ([], _, acc) = acc
    | count_months ((_, m, _) :: tl, months, acc) =
      if List.exists (fn x => x = m) months then
        count_months (tl, months, acc + 1)
      else count_months (tl, months, acc)
  in
    count_months (dates, months, 0)
  end;

fun dates_in_month (dates, month) =
  let
    fun get_dates ([], acc) = rev acc
    | get_dates ((d, m, y) :: tl, acc) =
      if m = month then get_dates (tl, (d, m, y) :: acc)
      else get_dates (tl, acc)
  in
    get_dates (dates, [])
  end;

fun get_nth (lst, n) = List.nth (lst, n - 1);

val month_names = ["January", "February", "March", "April", "May", "June",
                   "July", "August", "September", "October", "November", "December"];

fun date_to_string (day, month, year) =
  get_nth (month_names, month) ^ " " ^ Int.toString day ^ ", " ^ Int.toString year;

fun number_before_reaching (target, lst) =
  let
    fun find_sum ([], acc) = acc
    | find_sum (h :: tl, acc) =
      if acc + h >= target then acc
      else find_sum (tl, acc + h)
  in
    find_sum (lst, 0)
  end;

val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

fun what_month (day_of_year) =
  let
    fun find_month (day_of_year, [], month) = month
    | find_month (day_of_year, h :: tl, month) =
      if day_of_year <= h then find_month (day_of_year, [], month)
      else find_month (day_of_year - h, tl, month + 1)