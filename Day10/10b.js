const { performance } = require("../lib/performance");

const input = `105
124
42
52
71
41
1
85
148
90
155
112
35
134
145
39
161
160
34
54
15
165
8
20
46
49
108
151
60
7
48
154
63
147
132
98
158
33
137
45
140
121
22
62
111
141
167
131
74
93
2
142
113
21
162
61
3
19
101
9
102
115
70
12
84
6
114
107
97
133
64
80
78
91
79
14
168
87
159
30
94
77
40
125
47
27
38
166
86
26
23
67
127
28
16
169
13
92
106
57
118
126
83
146
29
130
53`;

function doWork(input) {
  const possiblePaths = input.reduce(
    (possiblePaths, jolt) => {
      possiblePaths[jolt] =
        (possiblePaths[jolt - 3] || 0) +
        (possiblePaths[jolt - 2] || 0) +
        (possiblePaths[jolt - 1] || 0);
      return possiblePaths;
    },
    [1] // The original plug only has one path it can come from, itself.
  );

  return possiblePaths[possiblePaths.length - 1];
}

performance.mark("processing-start");
console.log(
  doWork(
    input
      .split(/\n/)
      .map((x) => parseInt(x))
      .sort((a, b) => a - b)
  )
);
performance.measure("execution-measure", "processing-start");
