use aiken/collection/list

// adding elem in list
fn add_element(list: List<Int>, elem: Int) -> List<Int> {
  list.push(list, elem)
}

test add_element_to_list() {
  let initial_list =
    [2, 3]
  let result = add_element(initial_list, 1)
  let expected =
    [1, ..[2, 3]]

  expect result == expected
}

// concat 2 list
fn concat_lst(x: List<Int>, y: List<Int>) {
  list.concat(x, y)
}

test concat_lst_test() {
  let left_lst =
    [1, 2, 3]
  let right_lst =
    [4, 5, 6]

  let result = concat_lst(left_lst, right_lst)
  expect [1, 2, 3, 4, 5, 6] == result
}

fn str(x) {
  x
}

test str_test() {
  when str("f") is {
    "" -> False
    x -> True
  }
}


fn just_Joe()->List<ByteArray>{
  list.take(list.drop(["H","e","l","l","o"," ","J","o","e","!"],6),3)
}

fn just_Mike()->List<ByteArray>{
  ["H","e","l","l","o"," ","M","I","K","E","!"]
  |> list.drop(_,6)
  |> list.take(_,4)
}

test just_Joe_test(){
  just_Joe() == ["J","o","e"]
}

test just_Mike_test(){
  just_Mike() == ["M","I","K","E"]
}

fn count_alp() {
  list.count( ["H","e","l","l","o"," ","M","I","l","E","!"],fn(a){a=="l"})
}

test count_alp_test(){
  count_alp() == 3
}

pub fn simplest()-> List<Int>{
  [1,2,3,4,5]
}

test map_test(){
  list.map(simplest(),fn(x){x+1}) == [2,3,4,5,6]
}

test all_test(){
  list.all(simplest(),fn(x){x>0}) == True
}

test any_test(){
  list.any(simplest(),fn(x){x > 0 || x<7}) == True
}

test filter_test(){
  list.filter(simplest(),fn(x) {x%2 == 0}) == [2,4]
 }

 test foldr