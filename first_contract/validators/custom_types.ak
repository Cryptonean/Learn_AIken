type Datum {
  Datum { signer: ByteArray, count: Int }
}

type Datum_nameless {
  Datum_nameless(ByteArray, Int)
}

fn datum() {
  let name_1 = Datum { signer: "124312", count: 1 }
  let name_2 = Datum { signer: "123123", count: 2 }

  let name_less_1 = Datum_nameless("123", 1)

  let name_less_2 = Datum_nameless("456", 2)

  (name_1, name_2, name_less_1, name_less_2)
}

type User {
    Loggin {username: ByteArray}
    Guest
}

let user1 = Loggin{username:"faiz"}
let visitor = Guest

type Box <inner_type> {
    Box(inner: inner_type)
}

fn foo(){
    let a = Box{inner: 1}
    let b = Box{inner: "hello"}
}

type Dog{
    name: ByteArray,
    age: Int,
    cuteness: Int
}

let dog = Dog{name:"bob", age: 3, cuteness:4}
dog.name 
dog.age 
dog.cuteness 

///////////////---------------Destructuring------------------------/////////////////////////////


let dog = Dog{name:"bob", age: 3, cuteness:4}

/// destrc

let Dog{name, age, cuteness} = dog
name == "bob"
age == 3
cuteness == 4

//////////----------------pattern matching

type User {
    Loggin {username: ByteArray}
    Guest
}

fn get_name(user:User){
    when user is {
        Loggin{username} -> username
        _ -> "Guest"
    }
}

type User {
    LogginAsAdmin: {username:ByteArray}
    Loggin: {username: ByteArray}
    Guest
}

fn get_name(user:User){
    when user is {
        LogginAsAdmin{username} -> username | Loggin{username} -> username
        _ ->  "Guest"
    }
}

fn is_authorized(user:User)->Bool{
    when user is {
        LogginAsAdmin{ .. }-> True | Loggin{ username } -> username == "faiz"
        _ -> False 
    }
}


fn get_heaed(xs :List<a>)-> Option<a> {
    when xs is {
        [] -> None
        [a, ..] -> Some(a)
    }
}

fn is_empty(xs:List<a>) : Option<a>{
    when xs is {
        [] -> None
        [_, .. ] ->False
    }
}

fn get_last(xs: List<a>)-> Option<a>{
    when xs is {
        [] -> None
        [ .. , tail]-> Some(tail)
    }
}


type Dog{
    name: ByteArray,
    age: Int,
    cuteness: Int
}


fn get_pet_name(dog: Option<Dog>,  default: ByteArray)->  ByteArray{
    when dog is {
        Some(Dog {name , ..})-> name 
        _ -> default
    }
}


fn get_dog( dog: Option<Dog> , default:ByteArray)-> ByteArray {
    when dog is {
        Some(Dog { age, .. }) -> age
        _ -> default
    }
}