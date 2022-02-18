Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14D54BB9C5
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiBRNDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 08:03:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiBRNDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 08:03:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629E2B4611;
        Fri, 18 Feb 2022 05:03:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so15481200edn.0;
        Fri, 18 Feb 2022 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOs0uaJkZw6XSqCT47Qsb31OiMxuh3k2TEKng99tzTk=;
        b=RJOdqj97r0Mfp3qitF7KrOqCBQxXRakn2z7sMDYdQ8e9AMLKTZBr4Ov1BNAzOZsGls
         MkWCCx9PdEDpp5eQL/xzRCq6fjv+NaNnL9nS5NHoQczeb76mEpEE101gW55xL5Usd4HL
         pc0dWT3YvREgcaIED9isF76Ljm5oIBegXUMSz+3jhRcjnfblbUBqTT2OSvBOQtbMXKwM
         sEB/r/EtlipUtdgJSVvVe7/O40N9euGNGr6l3rLhUbIzB2qUU42F0QQRsgBWy5b5LzCk
         7ky3jEZmk5kUuk2mnVfOOMMYmjZC+uDtlyGOmXRNlgx19DI/S74vLyerraQf+I8sFX84
         pWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOs0uaJkZw6XSqCT47Qsb31OiMxuh3k2TEKng99tzTk=;
        b=jLtBQSiexM5Izy2IzCPc8W3tKDCcKopGG0BgxRcAX04lCy/KrODC6cyHnaU8RMPHVT
         L2xXMWpnMTQ9gJ7ksDi0q1HF7WtNS9B4AG6ycyosH1UnhATtmy/hcVBFvYtuIonwKZRM
         iqhpoeL4aQDqklRd6cHW+Djv2glITzSViDYUzWZZ4RAy8zLr/c0ThTs0BiuWhtVkNtIC
         q1KQZwv9IsmYmDmOZoLyibMtV5ayD/h7XgmkQOd4+NasLtQoJjrpY8w5wBfT/6s9RPdi
         2dD8Fz2Ooje6DjVl43jxjDvMZfyQJUhJSCZivzhrxSJ1MeiXEM/MM3Ggkn9lv/pJGi8Z
         NCLg==
X-Gm-Message-State: AOAM531TU4l/4TWsrARuhehvcxyHEWVNB3K/2u/pLifdWnSGGZhLnNdd
        TInVDl4jY2jTmRKMfWc4ylU=
X-Google-Smtp-Source: ABdhPJyrVGmO0zq32H5QDik2uU8AJSVIfJn4HVkwBhRddi+WF01ShlDGgk41aLwt84TaO7s1chUMRQ==
X-Received: by 2002:a50:9e2e:0:b0:410:d1b6:4d2e with SMTP id z43-20020a509e2e000000b00410d1b64d2emr7996818ede.201.1645189408145;
        Fri, 18 Feb 2022 05:03:28 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id t3sm2202918ejd.83.2022.02.18.05.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:03:27 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:03:25 +0100
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
Message-ID: <Yg+ZHUm4raVBwnQP@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg9geQ0LJjhnrc7j@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 18, 2022 at 10:01:45AM +0100, Jiri Olsa wrote:
> On Thu, Feb 17, 2022 at 01:53:16PM -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Some functions we use now for bpf prologue generation are
> > > going to be deprecated, so reworking the current code not
> > > to use them.
> > >
> > > We need to replace following functions/struct:
> > >    bpf_program__set_prep
> > >    bpf_program__nth_fd
> > >    struct bpf_prog_prep_result
> > >
> > > Current code uses bpf_program__set_prep to hook perf callback
> > > before the program is loaded and provide new instructions with
> > > the prologue.
> > >
> > > We workaround this by using objects's 'unloaded' programs instructions
> > > for that specific program and load new ebpf programs with prologue
> > > using separate bpf_prog_load calls.
> > >
> > > We keep new ebpf program instances descriptors in bpf programs
> > > private struct.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
> > >  1 file changed, 104 insertions(+), 18 deletions(-)
> > >
> > 
> > [...]
> > 
> > >  errout:
> > > @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > >         struct bpf_prog_priv *priv = program_priv(prog);
> > >         struct perf_probe_event *pev;
> > >         bool need_prologue = false;
> > > -       int err, i;
> > > +       int i;
> > >
> > >         if (IS_ERR_OR_NULL(priv)) {
> > >                 pr_debug("Internal error when hook preprocessor\n");
> > > @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > >                 return 0;
> > >         }
> > >
> > > +       /*
> > > +        * Do not load programs that need prologue, because we need
> > > +        * to add prologue first, check bpf_object__load_prologue.
> > > +        */
> > > +       bpf_program__set_autoload(prog, false);
> > 
> > if you set autoload to false, program instructions might be invalid in
> > the end. Libbpf doesn't apply some (all?) relocations to such
> > programs, doesn't resolve CO-RE, etc, etc. You have to let
> > "prototypal" BPF program to be loaded before you can grab final
> > instructions. It's not great, but in your case it should work, right?
> 
> hum, do we care? it should all be done when the 'new' program with
> the prologue is loaded, right?
> 
> I switched it off because the verifier failed to load the program
> without the prologue.. because in the originaal program there's no
> code to grab the arguments that the rest of the code depends on,
> so the verifier sees invalid access
> 
> > 
> > > +
> > >         priv->need_prologue = true;
> > >         priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
> > >         if (!priv->insns_buf) {
> > > @@ -734,6 +762,13 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > >                 return -ENOMEM;
> > >         }
> > >
> > 
> > [...]
> > 
> > > +               /*
> > > +                * For each program that needs prologue we do following:
> > > +                *
> > > +                * - take its current instructions and use them
> > > +                *   to generate the new code with prologue
> > > +                *
> > > +                * - load new instructions with bpf_prog_load
> > > +                *   and keep the fd in proglogue_fds
> > > +                *
> > > +                * - new fd will be used bpf__foreach_event
> > > +                *   to connect this program with perf evsel
> > > +                */
> > > +               orig_insns = bpf_program__insns(prog);
> > > +               orig_insns_cnt = bpf_program__insn_cnt(prog);
> > > +
> > > +               pev = &priv->pev;
> > > +               for (i = 0; i < pev->ntevs; i++) {
> > > +                       err = preproc_gen_prologue(prog, i, orig_insns,
> > > +                                                  orig_insns_cnt, &res);
> > > +                       if (err)
> > > +                               return err;
> > > +
> > > +                       fd = bpf_prog_load(bpf_program__get_type(prog),
> > 
> > nit: bpf_program__type() is preferred (we are deprecating/discouraging
> > "get_" prefixed getters in libbpf 1.0)
> 
> ok, will change

hum, I can't see bpf_program__type.. what do I miss?

jirka
