const { Module } = require("module");
const { PerformanceObserver, performance } = require("perf_hooks");

const obs = new PerformanceObserver((list, observer) => {
  console.log(list.getEntries()[0]);
  performance.clearMarks();
  observer.disconnect();
});
obs.observe({ entryTypes: ["measure"], buffered: true });

module.exports = {performance};
