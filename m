Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA524BBA8E
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiBROXM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 09:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiBROXM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 09:23:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D402459E;
        Fri, 18 Feb 2022 06:22:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id p9so14840995wra.12;
        Fri, 18 Feb 2022 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnAIJ0UvovmuuRgmc/P0eoCaMTkjs2w9LqScQtLxo3g=;
        b=Px6loXhQkxStejGmXJpI+5UAeQ9EfLtKQPkqYEikfuKSw1EzIkaz0YZ1Dibes4Mpii
         EotzNG5rl+jqnQMR5J3kkeTAer9ndjct5npAKK1EIHVpbiaL5I9TC7/je4AWTMtdHfhd
         /SnwAdLdGvNUPHpmjVZCTfpmn+9lrX8FcvQHM4mGQU8io+4JLu8OK0y6kmPWbv/AWHUU
         clFjFg69ChGs8iyMPFAbHCD+9Hkgk9lHkbWBxWC+3dxpUtppgVAIoV7f9yH3USdw9VlQ
         ZKk12XpwJhjI7BRzYaP3nxatFuazHwavRq/AI78Md3qELUZhC1gI0G5yfW0WVif5KkLZ
         09Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnAIJ0UvovmuuRgmc/P0eoCaMTkjs2w9LqScQtLxo3g=;
        b=n6YxPgCMigLQHXvB1+RZa3aDOb7Bdt5qJtphlM3+9qtC3fnfVzvPtXzcMUaiRCtPxy
         2sUGpA4tMzyD6WhDcLi+w547KKqVVmUBlh+lqEkPQDbmUycBnA4tGtXJhXUcuNHQNf1d
         64iIdzJimIHvsQC+DSq6JqZL8E9Df15MNC/Z9Gu0GWNNLk0VQqNhosPsmFPFhzx5lCb0
         7HeQ1gduxX5S8LEBJKxkZec8OQxehxCl579QclvYjknICfEtmvzXkxvsBgxu/D9oC0MV
         HrYqvgi1UHlz8omtGtibhoxS0dKB9qcB0IDyNwczReWKjGtdXWZe5ZvrDzP0UttRvBWn
         Atvg==
X-Gm-Message-State: AOAM530g4ylGxnINcELUdD805e1mzJRTBsy3kf5Z6uUl2ZOXbBTvTrzB
        YhW2iT/Y6fxW4Mtz0JZm0cw=
X-Google-Smtp-Source: ABdhPJxQ+renDcxdLPuwzaYOA43bndL6cMVEwsRjfRPhlbJ8m+sJbAToPEOAIVPa3JoxRtrBlq/JGQ==
X-Received: by 2002:adf:9106:0:b0:1e3:c02a:f4af with SMTP id j6-20020adf9106000000b001e3c02af4afmr6353398wrj.150.1645194171020;
        Fri, 18 Feb 2022 06:22:51 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id b18sm34031223wrx.92.2022.02.18.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:22:50 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:22:48 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
Message-ID: <Yg+ruDjO0kq2a3O/@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava>
 <Yg+ZHUm4raVBwnQP@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg+ZHUm4raVBwnQP@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 18, 2022 at 02:03:28PM +0100, Jiri Olsa wrote:
> On Fri, Feb 18, 2022 at 10:01:45AM +0100, Jiri Olsa wrote:
> > On Thu, Feb 17, 2022 at 01:53:16PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Some functions we use now for bpf prologue generation are
> > > > going to be deprecated, so reworking the current code not
> > > > to use them.
> > > >
> > > > We need to replace following functions/struct:
> > > >    bpf_program__set_prep
> > > >    bpf_program__nth_fd
> > > >    struct bpf_prog_prep_result
> > > >
> > > > Current code uses bpf_program__set_prep to hook perf callback
> > > > before the program is loaded and provide new instructions with
> > > > the prologue.
> > > >
> > > > We workaround this by using objects's 'unloaded' programs instructions
> > > > for that specific program and load new ebpf programs with prologue
> > > > using separate bpf_prog_load calls.
> > > >
> > > > We keep new ebpf program instances descriptors in bpf programs
> > > > private struct.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
> > > >  1 file changed, 104 insertions(+), 18 deletions(-)
> > > >
> > > 
> > > [...]
> > > 
> > > >  errout:
> > > > @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > >         struct bpf_prog_priv *priv = program_priv(prog);
> > > >         struct perf_probe_event *pev;
> > > >         bool need_prologue = false;
> > > > -       int err, i;
> > > > +       int i;
> > > >
> > > >         if (IS_ERR_OR_NULL(priv)) {
> > > >                 pr_debug("Internal error when hook preprocessor\n");
> > > > @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > >                 return 0;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * Do not load programs that need prologue, because we need
> > > > +        * to add prologue first, check bpf_object__load_prologue.
> > > > +        */
> > > > +       bpf_program__set_autoload(prog, false);
> > > 
> > > if you set autoload to false, program instructions might be invalid in
> > > the end. Libbpf doesn't apply some (all?) relocations to such
> > > programs, doesn't resolve CO-RE, etc, etc. You have to let
> > > "prototypal" BPF program to be loaded before you can grab final
> > > instructions. It's not great, but in your case it should work, right?
> > 
> > hum, do we care? it should all be done when the 'new' program with
> > the prologue is loaded, right?
> > 
> > I switched it off because the verifier failed to load the program
> > without the prologue.. because in the originaal program there's no
> > code to grab the arguments that the rest of the code depends on,
> > so the verifier sees invalid access
> > 
> > > 
> > > > +
> > > >         priv->need_prologue = true;
> > > >         priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
> > > >         if (!priv->insns_buf) {
> > > > @@ -734,6 +762,13 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > >                 return -ENOMEM;
> > > >         }
> > > >
> > > 
> > > [...]
> > > 
> > > > +               /*
> > > > +                * For each program that needs prologue we do following:
> > > > +                *
> > > > +                * - take its current instructions and use them
> > > > +                *   to generate the new code with prologue
> > > > +                *
> > > > +                * - load new instructions with bpf_prog_load
> > > > +                *   and keep the fd in proglogue_fds
> > > > +                *
> > > > +                * - new fd will be used bpf__foreach_event
> > > > +                *   to connect this program with perf evsel
> > > > +                */
> > > > +               orig_insns = bpf_program__insns(prog);
> > > > +               orig_insns_cnt = bpf_program__insn_cnt(prog);
> > > > +
> > > > +               pev = &priv->pev;
> > > > +               for (i = 0; i < pev->ntevs; i++) {
> > > > +                       err = preproc_gen_prologue(prog, i, orig_insns,
> > > > +                                                  orig_insns_cnt, &res);
> > > > +                       if (err)
> > > > +                               return err;
> > > > +
> > > > +                       fd = bpf_prog_load(bpf_program__get_type(prog),
> > > 
> > > nit: bpf_program__type() is preferred (we are deprecating/discouraging
> > > "get_" prefixed getters in libbpf 1.0)
> > 
> > ok, will change
> 
> hum, I can't see bpf_program__type.. what do I miss?

nah I was on top of perf/core.. I see it now ;-)

jirka
