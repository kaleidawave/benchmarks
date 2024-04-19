use std::time::Instant;
use thousands::Separable;
use codespan_reporting::{
    diagnostic::{Diagnostic, Label, Severity},
    files::SimpleFiles,
    term::{
        emit,
        termcolor::{ColorChoice, StandardStream},
        Config, DisplayStyle,
    },
};

fn main() {
    let compact = false;
    let config = Config {
		display_style: if compact { DisplayStyle::Short } else { DisplayStyle::Rich },
		..Config::default()
	};
    let mut files = SimpleFiles::<usize, String>::new();

    let count = 500;

    let content =
        (0..count)
            .map(|i| format!("Hello World {:07}", i))
            .fold(String::new(), |mut acc, cur| {
                acc.push_str(&cur);
                acc.push('\n');
                acc
            });

    files.add(0, content);

    let now = Instant::now();
    let mut writer = StandardStream::stderr(ColorChoice::Auto);

    for i in 0..count {
        let diagnostic = Diagnostic {
            severity: Severity::Error,
            code: None,
            message: "*some error*".into(),
            labels: vec![Label::primary(0, (i * 20)..((i + 1) * 20 - 1)).with_message("*error here*")],
            notes: Vec::default(),
        };
        emit(&mut writer, &config, &files, &diagnostic).unwrap();
    }

    let duration = now.elapsed().as_micros().separate_with_commas();
    let on = env!("CURRENT_TARGET");
    println!("Printing diagnostics in {duration}µs (on {on})");
}
