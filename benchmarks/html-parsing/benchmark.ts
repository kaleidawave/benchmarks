import { Window as happyDOM } from "happy-dom";
import * as cheerio from "cheerio";
import { retrieve } from "@bengineering/lightml";
// import { HTMLRewriter as wasmHTMLRewriter } from "@worker-tools/html-rewriter";

import { readFileSync } from "node:fs";
const file = readFileSync("./corpus.html").toString();

Deno.bench("happyDOM", () => {
    const window = new happyDOM();
    window.document.write(file);
    const main = window.document.querySelector("#nations-news-uk");
    if (!main) throw new Error("");
    const elements = main.querySelectorAll("a[href^='/news/articles']");
    let s = "";
    for (const element of elements) {
        if (s) s += "\0";
        s += element.textContent;
    }
    window.close();
});

Deno.bench("cheerio", () => {
    const document = cheerio.load(file);
    const main = document("#nations-news-uk");
    if (!main.length) throw new Error("");
    const elements = main.find("a[href^='/news/articles']");
    let s = "";
    elements.each((_, element) => {
        if (s) s += "\0";
        s += document(element).text();
    });
});

Deno.bench("html_parser", () => {
    const query = "single #nations-news-uk\0all a[href^='/news/articles']\0text";
    const _ = retrieve(file, query)
});

// Deno.bench("wasm_html_rewriter", () => {
//     let s = "";
//     const rewriter = new wasmHTMLRewriter().on("#nations-news-uk a[href^='/news/articles']", {
//         text(text: { text: string }) {
//             s += text.text;
//         },
//     });

//     const _result = rewriter.transform(new Response(file));
// });
