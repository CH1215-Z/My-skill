// node render.js in.html out.png [width] [height] — HTML to PNG at 2x with the preinstalled Playwright
const {chromium} = require('playwright');
(async () => {
  const [inp, out, w = 1400, h = 600] = process.argv.slice(2);
  const b = await chromium.launch();
  const p = await b.newPage({viewport: {width: +w, height: +h}, deviceScaleFactor: 2});
  await p.goto('file://' + require('path').resolve(inp));
  await p.waitForTimeout(300);
  await p.screenshot({path: out});
  await b.close();
})();
