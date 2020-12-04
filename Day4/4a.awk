BEGIN {  
  FS=" ";
  OFS=",";

  split("byr iyr eyr hgt hcl ecl pid",requirements);
  validCount = 0;
}

function isValid(credential){
  for (requirement in requirements){
    if (!(requirements[requirement] in credential)) return 0;
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