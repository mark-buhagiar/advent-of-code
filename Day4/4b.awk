BEGIN {  
  FS=" ";
  OFS=",";

  split("byr iyr eyr hgt hcl ecl pid",t);
  for(v in t) {
    requirements[t[v]]
  }

  split("amb blu brn gry grn hzl oth", t)
  for(v in t) {
    ecl[t[v]]
  }

  validCount = 0;
}

function isValidB(field, value) {
  switch (field) {
    case "byr":
      return value >= 1920 && value <= 2002;
    case "iyr":
      return value >= 2010 && value <= 2020;
    case "eyr":
      return value >= 2020 && value <= 2030;
    case "hgt":
      match(value, /([0-9]*)(cm|in)/, a)
      return (a[2] == "cm" && a[1] >= 150 && a[1] <= 193) ||
          (a[2] == "in" && a[1] >= 59 && a[1] <= 76)
    case "hcl":
      return length(value) == 7 && value ~ /#[0-9a-f]/
    case "ecl":
      return value in ecl
    case "pid":
      return length(value) == 9 && value ~ /[0-9]{9}/
    default:
      return 0;
  }
}

function isValid(credential){
  for (requirement in requirements){
    if (!isValidB(requirement, credential[requirement])){
      return 0
    }
  }
  return 1;
}

match($0, /^$/){  
  validCount += isValid(credential);
  delete credential;
}

match($0, /^.+$/){
  for(i = 1; i <= NF; i++){
    split($i, parts, ":");
    credential[parts[1]] = parts[2];
  }
}

END{  
  validCount += isValid(credential);
  print(validCount);
}