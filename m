Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8103753A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFFNa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 09:30:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34344 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFNa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 09:30:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so2644631qtu.1;
        Thu, 06 Jun 2019 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=laXwKrCLDbQlZ5wqNW0JxArXs2q0tdfYtz3FSuxgpnw=;
        b=oio9Cs4FcULACpYJdCfIrGZ5HmO1N1uOIpV9OTozuAF3AMBHbg+Lz4EYlMLV5z0wiu
         gRn4F7mZ2YxzDQbtqe86OzrFsESB+x4iyTsbDdEz1cL6I/xltLeKZlyPXHsMylrBnthD
         j6AI04HZm4Kh5fKztYnVY43d2bh3KwbUUnMZ5Hv6AjHs47t9wAx+dhIdaQusthDVClqY
         SioYhGBBRB2Q1ZSg+jXZRjFgfuC1H0atwpwtUApCDVxmSR1mhmO4kR9dxhE3YH5So6rR
         8T+ZCQXRefZYTokfOoX/MMWNIM9An2m3Ouqe2/6g3EqvTGDki+rfKLee9zulKE8xGjMD
         YEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=laXwKrCLDbQlZ5wqNW0JxArXs2q0tdfYtz3FSuxgpnw=;
        b=A69zQSb4JQnXY8EfPe9l5HFlnHumgUfKGNkzlISZK+fxrxnKs+h/GDD0/vTk7PhvuO
         G7OJ51ArovIhokDExcxt4itwT0mJq7T819/mrRzNqxhICX9biVLXH1h5DM/SYS/JEIfY
         kn45cHIBk1DJDt27zHsawUQtvWEiJ+TuYO+T/BoDiKU4WgzVnE4TVo766+n1knGfS/Tt
         YqKVbis1qYuK9QJCCTAlzTP3qqEDNeSZcyvQA/nxOKZEmfyRiOzxjHPqxKFjfTjztB1v
         EOOx/4mW//OSm9mXLdFqgjSGx9JkQjhU+2uUfFXM09I82mFTV1MYimtl/BFMtWNXbPo2
         d6wg==
X-Gm-Message-State: APjAAAU31zY6Ht8ZJZ0nAoAuNc/aJth9rORWDcCH+LP+vUCQGPAQyYix
        KrmrRXyYlXv3ncCqmXJ7SQI=
X-Google-Smtp-Source: APXvYqye2Zer3v0375PJLsNnVEZWtnUFz3D+ewVQx6S/sIBYhEo9URgNjMzz04PV2w/aCgg5/MH/dg==
X-Received: by 2002:ac8:525a:: with SMTP id y26mr41110270qtn.297.1559827824900;
        Thu, 06 Jun 2019 06:30:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.208.82])
        by smtp.gmail.com with ESMTPSA id e9sm905732qth.13.2019.06.06.06.30.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:30:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FBC541149; Thu,  6 Jun 2019 10:30:19 -0300 (-03)
Date:   Thu, 6 Jun 2019 10:30:19 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf trace: Exit when build eBPF program failure
Message-ID: <20190606133019.GA30166@kernel.org>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606094845.4800-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 06, 2019 at 05:48:42PM +0800, Leo Yan escreveu:
> On my Juno board with ARM64 CPUs, perf trace command reports the eBPF
> program building failure but the command will not exit and continue to
> run.  If we define an eBPF event in config file, the event will be
> parsed with below flow:
> 
>   perf_config()
>     `> trace__config()
> 	 `> parse_events_option()
> 	      `> parse_events__scanner()
> 	           `-> parse_events_parse()
> 	                 `> parse_events_load_bpf()
> 	                      `> llvm__compile_bpf()
> 
> Though the low level functions return back error values when detect eBPF
> building failure, but parse_events_option() returns 1 for this case and

(gdb) n
parse_events__scanner (str=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o", parse_state=0x7fffffff7fa0,
    start_token=258) at util/parse-events.c:1870
1870		parse_events__delete_buffer(buffer, scanner);
(gdb) n
1871		parse_events_lex_destroy(scanner);
(gdb) n
1872		return ret;
(gdb) p ret
$53 = 1
(gdb) bt
#0  parse_events__scanner (str=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o", parse_state=0x7fffffff7fa0,
    start_token=258) at util/parse-events.c:1872
#1  0x000000000050a926 in parse_events (evlist=0xb9e5d0, str=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o",
    err=0x7fffffff8020) at util/parse-events.c:1907
#2  0x000000000050ad94 in parse_events_option (opt=0x7fffffff8080,
    str=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o", unset=0) at util/parse-events.c:2007
#3  0x0000000000497fa8 in trace__config (var=0x7fffffff8150 "trace.add_events",
    value=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o", arg=0x7fffffffa1c0) at builtin-trace.c:3706
#4  0x00000000004e9a79 in perf_config (fn=0x497ee4 <trace__config>, data=0x7fffffffa1c0) at util/config.c:738
#5  0x0000000000498c97 in cmd_trace (argc=2, argv=0x7fffffffd690) at builtin-trace.c:3865
#6  0x00000000004d8c17 in run_builtin (p=0xa0e600 <commands+576>, argc=2, argv=0x7fffffffd690) at perf.c:303
#7  0x00000000004d8e84 in handle_internal_command (argc=2, argv=0x7fffffffd690) at perf.c:355
#8  0x00000000004d8fd3 in run_argv (argcp=0x7fffffffd4ec, argv=0x7fffffffd4e0) at perf.c:399
#9  0x00000000004d933f in main (argc=2, argv=0x7fffffffd690) at perf.c:521
(gdb)

So its parse_events__scanner() that returns 1, parse_events() propagate
that and:

parse_events_option (opt=0x7fffffff8080, str=0xb9d170 "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o", unset=0)
    at util/parse-events.c:2009
2009		if (ret) {
(gdb) p ret
$56 = 1
(gdb) n
2010			parse_events_print_error(&err, str);
(gdb) n
event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o'
                     \___ Kernel verifier blocks program loading

(add -v to see detail)
2011			fprintf(stderr, "Run 'perf list' for a list of valid events\n");
(gdb)

So the -4007 error is printed, and all we can say is that parsing events
failed, but we end up not propagating that error back when we use
parse_events_option(), we could use instead:

        struct parse_events_error err = { .idx = 0, };
        int ret = parse_events(evlist, str, &err);

And make parse_events_error have the raw err, i.e. -4007 in this case:

        [ERRCODE_OFFSET(VERIFY)]        = "Kernel verifier blocks program loading",

In your case would be something else, I'm just trying to load the
precompiled .o that does things the BPF kernel verifier doesn't like.

So yeah, your patch looks ok, i.e. parse_events_option() returning !0
should make trace__config() return -1.

But see below:

- Arnaldo

> trace__config() passes 1 to perf_config(); perf_config() doesn't treat
> the returned value 1 as failure and it continues to parse other
> configurations.  Thus the perf command continues to run even without
> enabling eBPF event successfully.
> 
> This patch changes error handling in trace__config(), when it detects
> failure it will return -1 rather than directly pass error value (1);
> finally, perf_config() will directly bail out and perf will exit for
> this case.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-trace.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 54b2d0fd0d02..4b5d004aab74 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3664,6 +3664,14 @@ static int trace__config(const char *var, const char *value, void *arg)
>  					       "event selector. use 'perf list' to list available events",
>  					       parse_events_option);
>  		err = parse_events_option(&o, value, 0);
> +
> +		/*
> +		 * When parse option successfully parse_events_option() will
> +		 * return 0, otherwise means the paring failure.  And it
> +		 * returns 1 for eBPF program building failure; so adjust the
> +		 * err value to -1 for the failure.
> +		 */
> +		err = err ? -1 : 0;

I'll rewrite the comment above to make it more succint and fix things
like 'paring' (parsing):

		/*
		 * parse_events_option() returns !0 to indicate failure
		 * while the perf_config code that calls trace__config()
		 * expects < 0 returns to indicate error, so:
		 */

		 if (err)
		 	err = -1;
>  	} else if (!strcmp(var, "trace.show_timestamp")) {
>  		trace->show_tstamp = perf_config_bool(var, value);
>  	} else if (!strcmp(var, "trace.show_duration")) {
> -- 
> 2.17.1

-- 

- Arnaldo
