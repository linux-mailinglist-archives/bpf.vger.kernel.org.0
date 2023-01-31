Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3596682E10
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 14:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjAaNfc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 08:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAaNf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 08:35:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912F51435
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:35:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lu11so4316587ejb.3
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KziYAxnITBAIUX9mnX7VfzMAfUqlVfdg/F+svcVxvug=;
        b=F5hmspb71e5z8+07UPFe1D8OA0mdF784j7ktzgZUYADKpP2i42eW/QOxCcR1oGhjb5
         ofL777MH7UHhEemvCkARRKS/8pRsl8xTxSkD1du8X2lTbSWg9Y5ifUB6ewshW0+lBN8+
         +Wb77YKJu9+2NJZN4Z+yWCLX9V+Tsw5Uc+ME3EaStabD/Uf5TGGkiFiHaNJNd1kZGQRh
         EK+nTzlwylzIyPV85l3V1n05bLcxWo9vMWvOkTiE2BzVfe0M/CjRZarjmIXbgPTnFbrw
         Wq5DmkfLXz2yQe0SsXBOxgzSiR6HOyp8SoJxBcZatPVWyraJnqJx5orDgkirMJfifkWy
         kfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KziYAxnITBAIUX9mnX7VfzMAfUqlVfdg/F+svcVxvug=;
        b=WKiVMmJCyWen0ruhKFojpsZKuD+SHTxxldNWGPwVXJFTDtJiBoQFEWSwK5sWjYjsea
         +kIfaxPj3bbhgM3zbyc1yKBXLhhfJdwhdHFZ7qEFG4ibA+dwu3WoHlpTtT8cN6kDjolz
         8NSuGb067wM6+JWRk7IRBjZBzfzT83d/tOEEjrsO63BWx3pbaQ3Hsy6g0uOaa0ODM+OF
         IR9bEhBv+WH+3s0R75KsZlRVJ2+mdK1zvXzUur5an/dAasOiHj92ANacIqfD+PV+s4vQ
         TlfsOn+BERSUMdujhWKUp/r7E5mH+8BoyKchBL6MsJb1TbPHNyWxSITmhc7ifN248o//
         uScQ==
X-Gm-Message-State: AO0yUKXm8tI1VHVqgchBAineauxUpRdJb1e72JwD+suZ1C6N89slqrDm
        qxUxezmY96MiKrRQ38n0+pqwTg==
X-Google-Smtp-Source: AK7set8l1H5c8TIJa+RqFs7XxaWeMaOuTjMrgzjOHDm2x0Ae29ud7wO2GaOQvYwUzAB/zLVhoXc3xg==
X-Received: by 2002:a17:906:ce2c:b0:7c1:4d35:a143 with SMTP id sd12-20020a170906ce2c00b007c14d35a143mr2948392ejb.3.1675172118219;
        Tue, 31 Jan 2023 05:35:18 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906264400b0084d35ffbc20sm8433417ejc.68.2023.01.31.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:35:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:35:16 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftest/bpf/benchs: enhance argp parsing
Message-ID: <Y9kZFBJP2FPstZzM@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-4-aspsk@isovalent.com>
 <CAEf4BzYk2sBHsPPF5-dx=jnuaob3WvnTFyWH6DtnwF3T_=JVkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYk2sBHsPPF5-dx=jnuaob3WvnTFyWH6DtnwF3T_=JVkg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/30 04:07, Andrii Nakryiko wrote:
> On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > To parse command line the bench utility uses the argp_parse() function. This
> > function takes as an argument a parent 'struct argp' structure which defines
> > common command line options and an array of children 'struct argp' structures
> > which defines additional command line options for particular benchmarks. This
> > implementation doesn't allow benchmarks to share option names, e.g., if two
> > benchmarks want to use, say, the --option option, then only one of them will
> > succeed (the first one encountered in the array).  This will be convenient if
> > we could use the same option names in different benchmarks (with the same
> > semantics, e.g., --nr_loops=N).
> >
> > Fix this by calling the argp_parse() function twice. The first call is needed
> > to find the benchmark name. Given the name, we can patch the list of argp
> > children to only include the correct list of option. This way the right parser
> > will be executed. (If there's no a specific list of arguments, then only one
> > call is enough.) As was mentioned above, arguments with same names should have
> > the same semantics (which means in this case "taking a parameter or not"), but
> > can have different description and will have different parsers.
> >
> > As we now can share option names, this also makes sense to share the option ids.
> > Previously every benchmark defined a separate enum, like
> >
> >     enum {
> >            ARG_SMTH = 9000,
> >            ARG_SMTH_ELSE = 9001,
> >     };
> >
> > These ids were later used to distinguish between command line options:
> >
> >     static const struct argp_option opts[] = {
> >             { "smth", ARG_SMTH, "SMTH", 0,
> >                     "Set number of smth to configure smth"},
> >             { "smth_else", ARG_SMTH_ELSE, "SMTH_ELSE", 0,
> >                     "Set number of smth_else to configure smth else"},
> >             ...
> >
> > Move arguments id definitions to bench.h such that they are visible to every
> > benchmark (and such that there's no need to grep if this number is defined
> > already or not).
> 
> On the other hand, if each benchmark defines their own set of IDs and
> parser, that keeps benchmarks more self-contained. Is there a real
> need to centralize everything? I don't see much benefit, tbh.
>
> If we want to centralize, then we can just bypass all the child parser
> machinery and have one centralized list of arguments. But I think it's
> good to have each benchmark self-contained and independent from other
> benchmarks.

When I was adding a new bench, it looked simpler to just add IDs to a global
list than to grep for what ID is not defined yet. This doesn't matter much
though, I can switch back to local IDs.

> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  tools/testing/selftests/bpf/bench.c           | 98 +++++++++++++++++--
> >  tools/testing/selftests/bpf/bench.h           | 20 ++++
> >  .../bpf/benchs/bench_bloom_filter_map.c       |  6 --
> >  .../selftests/bpf/benchs/bench_bpf_loop.c     |  4 -
> >  .../bpf/benchs/bench_local_storage.c          |  5 -
> >  .../bench_local_storage_rcu_tasks_trace.c     |  6 --
> >  .../selftests/bpf/benchs/bench_ringbufs.c     |  8 --
> >  .../selftests/bpf/benchs/bench_strncmp.c      |  4 -
> >  8 files changed, 110 insertions(+), 41 deletions(-)
> >
> 
> [...]
> 
> > +struct argp *bench_name_to_argp(const char *bench_name)
> > +{
> > +
> > +#define _SCMP(NAME) (!strcmp(bench_name, NAME))
> > +
> > +       if (_SCMP("bloom-lookup") ||
> > +           _SCMP("bloom-update") ||
> > +           _SCMP("bloom-false-positive") ||
> > +           _SCMP("hashmap-without-bloom") ||
> > +           _SCMP("hashmap-with-bloom"))
> > +               return &bench_bloom_map_argp;
> > +
> > +       if (_SCMP("rb-libbpf") ||
> > +           _SCMP("rb-custom") ||
> > +           _SCMP("pb-libbpf") ||
> > +           _SCMP("pb-custom"))
> > +               return &bench_ringbufs_argp;
> > +
> > +       if (_SCMP("local-storage-cache-seq-get") ||
> > +           _SCMP("local-storage-cache-int-get") ||
> > +           _SCMP("local-storage-cache-hashmap-control"))
> > +               return &bench_local_storage_argp;
> > +
> > +       if (_SCMP("local-storage-tasks-trace"))
> > +               return &bench_local_storage_rcu_tasks_trace_argp;
> > +
> > +       if (_SCMP("strncmp-no-helper") ||
> > +           _SCMP("strncmp-helper"))
> > +               return &bench_strncmp_argp;
> > +
> > +       if (_SCMP("bpf-loop"))
> > +               return &bench_bpf_loop_argp;
> > +
> > +       /* no extra arguments */
> > +       if (_SCMP("count-global") ||
> > +           _SCMP("count-local") ||
> > +           _SCMP("rename-base") ||
> > +           _SCMP("rename-kprobe") ||
> > +           _SCMP("rename-kretprobe") ||
> > +           _SCMP("rename-rawtp") ||
> > +           _SCMP("rename-fentry") ||
> > +           _SCMP("rename-fexit") ||
> > +           _SCMP("trig-base") ||
> > +           _SCMP("trig-tp") ||
> > +           _SCMP("trig-rawtp") ||
> > +           _SCMP("trig-kprobe") ||
> > +           _SCMP("trig-fentry") ||
> > +           _SCMP("trig-fentry-sleep") ||
> > +           _SCMP("trig-fmodret") ||
> > +           _SCMP("trig-uprobe-base") ||
> > +           _SCMP("trig-uprobe-with-nop") ||
> > +           _SCMP("trig-uretprobe-with-nop") ||
> > +           _SCMP("trig-uprobe-without-nop") ||
> > +           _SCMP("trig-uretprobe-without-nop") ||
> > +           _SCMP("bpf-hashmap-full-update"))
> > +               return NULL;
> > +
> > +#undef _SCMP
> > +
> 
> it's not good to have to maintain a separate list of benchmark names
> here. Let's maybe extend struct bench to specify extra parser and use
> that to figure out if we need to run nested child parser?

Yes, right, so then I can do something like

struct argp *bench_name_to_argp(const char *bench_name)
{
        int i;

        for (i = 0; i < ARRAY_SIZE(benchs); i++)
                if (!strcmp(bench_name, benchs[i]->name))
                        return benchs[i]->argp;

        fprintf(stderr, "benchmark '%s' not found\n", bench_name);
        exit(1);
}

> 
> > +       fprintf(stderr, "%s: bench %s is unknown\n", __func__, bench_name);
> > +       exit(1);
> > +}
> > +
> >  static void parse_cmdline_args(int argc, char **argv)
> >  {
> >         static const struct argp argp = {
> > @@ -367,12 +426,35 @@ static void parse_cmdline_args(int argc, char **argv)
> >                 .doc = argp_program_doc,
> >                 .children = bench_parsers,
> >         };
> > +       static struct argp *bench_argp;
> 
> nit: do you need static?

No, thanks for noting.

> 
> > +
> > +       /* Parse args for the first time to get bench name */
> >         if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
> >                 exit(1);
> > -       if (!env.list && !env.bench_name) {

Also, I will switch to a simpler mode here: just find the bench_name, then
construct correct `struct argp`, then call argp_parse() once.

> > +
> > +       if (env.list)
> > +               return;
> > +
> > +       if (!env.bench_name) {
> >                 argp_help(&argp, stderr, ARGP_HELP_DOC, "bench");
> >                 exit(1);
> >         }
> > +
> > +       /* Now check if there are custom options available. If not, then
> > +        * everything is done, if yes, then we need to patch bench_parsers
> > +        * so that bench_parsers[0] points to the right 'struct argp', and
> > +        * bench_parsers[1] terminates the list.
> > +        */
> > +       bench_argp = bench_name_to_argp(env.bench_name);
> > +       if (bench_argp) {
> > +               bench_parsers[0].argp = bench_argp;
> > +               bench_parsers[0].header = env.bench_name;
> > +               memset(&bench_parsers[1], 0, sizeof(bench_parsers[1]));
> > +
> > +               pos_args = 0;
> > +               if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
> > +                       exit(1);
> > +       }
> 
> this also feels like a big hack, why can't you just construct a
> single-item array based on child parser, instead of overwriting global
> array?

Sure, thanks.

> >  }
> >
> >  static void collect_measurements(long delta_ns);
> 
> [...]
