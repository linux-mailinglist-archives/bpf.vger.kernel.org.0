Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4168205B
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjAaAHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjAaAHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:07:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA03C07
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:07:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m2so36496638ejb.8
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VFeqvS6Aa3gkqt4oyYlVD9JbcLQP9Itn1uTTHVDe7pQ=;
        b=oqJYfk372KdSF/WfscWoJrEZtTlF2aTuybj0AQw2MBU5cchSjHXd0GioHDMF3jTWL8
         JrY70nsyfDTg+dUvGCVLd2wMBzQtLsp32t5W4O0CAEcEcgHgsXBBE92t2lI2L3CrcYhL
         Xrb0CHgmPu+bzKmn0VquCg/hEZz8MAs2zAHyf/8pEmG9TfXg8MmChsC6AwbEn9SgxhSw
         GIqyHid2lqPbx9Pk+M1UZAJF6QZYgWu6642I/BB3lc5Q9VEyb5PIzOZ0UNWIsZK+/Yxw
         DkMfwdOt6WSqMNvFRIXjHDQHMKP+gsswyz5k42RIXwABJoGkyrKA48VjQSSZVyk+55kB
         7EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFeqvS6Aa3gkqt4oyYlVD9JbcLQP9Itn1uTTHVDe7pQ=;
        b=uYIGFMHeRc43BX3MiOcGYduIU3uJKsU2iePH+nfUMh1pioOKR206AdUy0r8iS+TidD
         MAOITxQEKiLUeutVZ0Y5HGqB9iX0ygS4HxRKSWmuCO4e6ZwO/Hf4OT+U+ci5lZ2IN1hq
         lCAdtI53fUUnICu9JikbYSE3M5CftPxVsGnt2qAJ4eC/tyMvqLkkLR/FnXe61IvX3Uxu
         mn7JNys3XSSQ2M/pcJfXhm1Mx7N11APeBFVuZVTNA/DcwNhlTosrSNVoxOQEHR8qN5Yq
         uFwtEF9WUjsL/NbwvNMSsHDLIYgNGtPStaRoD+3MxFN+CZ9/xwbdnzQKOCk79EvEO9dV
         lbGw==
X-Gm-Message-State: AO0yUKUng+MNSQFRcP92cdojooDIM0ErR9bkkMA6LSTvtW9THHK/np/m
        v/uo+zml0kCom5vGp5rFMnfwWZoQKnFMC/b5ZZA=
X-Google-Smtp-Source: AK7set/IATtvGD4u+X52M1Yaxt+anEMz5CKP2usL1CvJS82cC8DiIhi4URl86qBB/Z4jfrWjC1SXZXoKQkbra2+Zkd8=
X-Received: by 2002:a17:906:46d3:b0:888:1f21:4424 with SMTP id
 k19-20020a17090646d300b008881f214424mr1800543ejs.141.1675123649296; Mon, 30
 Jan 2023 16:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com> <20230127181457.21389-4-aspsk@isovalent.com>
In-Reply-To: <20230127181457.21389-4-aspsk@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Jan 2023 16:07:17 -0800
Message-ID: <CAEf4BzYk2sBHsPPF5-dx=jnuaob3WvnTFyWH6DtnwF3T_=JVkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftest/bpf/benchs: enhance argp parsing
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>
> To parse command line the bench utility uses the argp_parse() function. This
> function takes as an argument a parent 'struct argp' structure which defines
> common command line options and an array of children 'struct argp' structures
> which defines additional command line options for particular benchmarks. This
> implementation doesn't allow benchmarks to share option names, e.g., if two
> benchmarks want to use, say, the --option option, then only one of them will
> succeed (the first one encountered in the array).  This will be convenient if
> we could use the same option names in different benchmarks (with the same
> semantics, e.g., --nr_loops=N).
>
> Fix this by calling the argp_parse() function twice. The first call is needed
> to find the benchmark name. Given the name, we can patch the list of argp
> children to only include the correct list of option. This way the right parser
> will be executed. (If there's no a specific list of arguments, then only one
> call is enough.) As was mentioned above, arguments with same names should have
> the same semantics (which means in this case "taking a parameter or not"), but
> can have different description and will have different parsers.
>
> As we now can share option names, this also makes sense to share the option ids.
> Previously every benchmark defined a separate enum, like
>
>     enum {
>            ARG_SMTH = 9000,
>            ARG_SMTH_ELSE = 9001,
>     };
>
> These ids were later used to distinguish between command line options:
>
>     static const struct argp_option opts[] = {
>             { "smth", ARG_SMTH, "SMTH", 0,
>                     "Set number of smth to configure smth"},
>             { "smth_else", ARG_SMTH_ELSE, "SMTH_ELSE", 0,
>                     "Set number of smth_else to configure smth else"},
>             ...
>
> Move arguments id definitions to bench.h such that they are visible to every
> benchmark (and such that there's no need to grep if this number is defined
> already or not).

On the other hand, if each benchmark defines their own set of IDs and
parser, that keeps benchmarks more self-contained. Is there a real
need to centralize everything? I don't see much benefit, tbh.

If we want to centralize, then we can just bypass all the child parser
machinery and have one centralized list of arguments. But I think it's
good to have each benchmark self-contained and independent from other
benchmarks.


>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/testing/selftests/bpf/bench.c           | 98 +++++++++++++++++--
>  tools/testing/selftests/bpf/bench.h           | 20 ++++
>  .../bpf/benchs/bench_bloom_filter_map.c       |  6 --
>  .../selftests/bpf/benchs/bench_bpf_loop.c     |  4 -
>  .../bpf/benchs/bench_local_storage.c          |  5 -
>  .../bench_local_storage_rcu_tasks_trace.c     |  6 --
>  .../selftests/bpf/benchs/bench_ringbufs.c     |  8 --
>  .../selftests/bpf/benchs/bench_strncmp.c      |  4 -
>  8 files changed, 110 insertions(+), 41 deletions(-)
>

[...]

> +struct argp *bench_name_to_argp(const char *bench_name)
> +{
> +
> +#define _SCMP(NAME) (!strcmp(bench_name, NAME))
> +
> +       if (_SCMP("bloom-lookup") ||
> +           _SCMP("bloom-update") ||
> +           _SCMP("bloom-false-positive") ||
> +           _SCMP("hashmap-without-bloom") ||
> +           _SCMP("hashmap-with-bloom"))
> +               return &bench_bloom_map_argp;
> +
> +       if (_SCMP("rb-libbpf") ||
> +           _SCMP("rb-custom") ||
> +           _SCMP("pb-libbpf") ||
> +           _SCMP("pb-custom"))
> +               return &bench_ringbufs_argp;
> +
> +       if (_SCMP("local-storage-cache-seq-get") ||
> +           _SCMP("local-storage-cache-int-get") ||
> +           _SCMP("local-storage-cache-hashmap-control"))
> +               return &bench_local_storage_argp;
> +
> +       if (_SCMP("local-storage-tasks-trace"))
> +               return &bench_local_storage_rcu_tasks_trace_argp;
> +
> +       if (_SCMP("strncmp-no-helper") ||
> +           _SCMP("strncmp-helper"))
> +               return &bench_strncmp_argp;
> +
> +       if (_SCMP("bpf-loop"))
> +               return &bench_bpf_loop_argp;
> +
> +       /* no extra arguments */
> +       if (_SCMP("count-global") ||
> +           _SCMP("count-local") ||
> +           _SCMP("rename-base") ||
> +           _SCMP("rename-kprobe") ||
> +           _SCMP("rename-kretprobe") ||
> +           _SCMP("rename-rawtp") ||
> +           _SCMP("rename-fentry") ||
> +           _SCMP("rename-fexit") ||
> +           _SCMP("trig-base") ||
> +           _SCMP("trig-tp") ||
> +           _SCMP("trig-rawtp") ||
> +           _SCMP("trig-kprobe") ||
> +           _SCMP("trig-fentry") ||
> +           _SCMP("trig-fentry-sleep") ||
> +           _SCMP("trig-fmodret") ||
> +           _SCMP("trig-uprobe-base") ||
> +           _SCMP("trig-uprobe-with-nop") ||
> +           _SCMP("trig-uretprobe-with-nop") ||
> +           _SCMP("trig-uprobe-without-nop") ||
> +           _SCMP("trig-uretprobe-without-nop") ||
> +           _SCMP("bpf-hashmap-full-update"))
> +               return NULL;
> +
> +#undef _SCMP
> +

it's not good to have to maintain a separate list of benchmark names
here. Let's maybe extend struct bench to specify extra parser and use
that to figure out if we need to run nested child parser?


> +       fprintf(stderr, "%s: bench %s is unknown\n", __func__, bench_name);
> +       exit(1);
> +}
> +
>  static void parse_cmdline_args(int argc, char **argv)
>  {
>         static const struct argp argp = {
> @@ -367,12 +426,35 @@ static void parse_cmdline_args(int argc, char **argv)
>                 .doc = argp_program_doc,
>                 .children = bench_parsers,
>         };
> +       static struct argp *bench_argp;

nit: do you need static?

> +
> +       /* Parse args for the first time to get bench name */
>         if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
>                 exit(1);
> -       if (!env.list && !env.bench_name) {
> +
> +       if (env.list)
> +               return;
> +
> +       if (!env.bench_name) {
>                 argp_help(&argp, stderr, ARGP_HELP_DOC, "bench");
>                 exit(1);
>         }
> +
> +       /* Now check if there are custom options available. If not, then
> +        * everything is done, if yes, then we need to patch bench_parsers
> +        * so that bench_parsers[0] points to the right 'struct argp', and
> +        * bench_parsers[1] terminates the list.
> +        */
> +       bench_argp = bench_name_to_argp(env.bench_name);
> +       if (bench_argp) {
> +               bench_parsers[0].argp = bench_argp;
> +               bench_parsers[0].header = env.bench_name;
> +               memset(&bench_parsers[1], 0, sizeof(bench_parsers[1]));
> +
> +               pos_args = 0;
> +               if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
> +                       exit(1);
> +       }

this also feels like a big hack, why can't you just construct a
single-item array based on child parser, instead of overwriting global
array?

>  }
>
>  static void collect_measurements(long delta_ns);

[...]
