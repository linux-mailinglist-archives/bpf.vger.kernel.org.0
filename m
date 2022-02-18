Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D94BB4CF
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiBRJCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 04:02:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiBRJCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 04:02:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79823541B9;
        Fri, 18 Feb 2022 01:01:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so5889744wmb.0;
        Fri, 18 Feb 2022 01:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MMooeDrJfD+MSlWbTtjztNE5tCVYFbi09srETvHrxyE=;
        b=LkyQK1tuBU3F8wwaUsWNOBmumJHGImN2OeDODhK2rl9gWzlbqq+MRRuk70kze8+RM4
         y2F82bkOwh8y/5TYrnimKoxOotOiukUz7aIUkPEGfOneXK7eWGmREZcMGGXz4skBldDl
         8xnPVDOdlKmodcUPjOd4kNZp6Cm/H2BDlJj1WncJmAF94Jm9ri/RJWXlQXMRtVwwIZ/x
         5KKDOXK+WAfsWD81eo+0O32tQUmvLE5svObUd3JYCTuzMpij3XP+O/30GyIHGbcPZgZv
         lYKxNSjjVvoJyD7gnCjJ6RIGWMtu2Vhx6g4ge0JfyP4Km61yqirkPh7/NruecQI2jssr
         03mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MMooeDrJfD+MSlWbTtjztNE5tCVYFbi09srETvHrxyE=;
        b=B+fbK/q1QgMuGTVm8BqlIeL/LRZCVPJduShiOvauzbljKvm2YNG2nQRWw9PIbvZSoD
         h3BkOJFiNAKoAbPmNJTKyIiUttvWHTwsezXP2vsBzoUCTLlS8rfrbgIe+rZ7/4vUsGlb
         VH/PsU7IXkZcFLUUTqZSlZhOQgRqscA6C95GxW8PkmvZe175IeQNULhJ4403OG0xmGEl
         VT1PN8PiwGI+tsQgGCJKbC26wbgmJupvBPfJb+biuqepDMUc9np10fWCBhudlM0Z6k8j
         fCtEWvpIGfP6I/Jp7JVIf1UQfKFZM4Jik64abExa3ed4x2ajnI2HkeXhlA5s08d3/rdD
         YMxw==
X-Gm-Message-State: AOAM532WbWj2QEQDI7xJ/o3IV2gncN078bYBoQHN1LMSxUFgKgq0TMkf
        OkexTEjjKwWgeSs7qLTrOYM=
X-Google-Smtp-Source: ABdhPJwP0DNxczzXwHSaFAcN5EVFHM4JR80AWM/uieubehRVv4wiIqUitZAAoIpZr077/IouS4JXpw==
X-Received: by 2002:a05:600c:22d3:b0:37b:f1a7:ceb5 with SMTP id 19-20020a05600c22d300b0037bf1a7ceb5mr6205842wmg.164.1645174908956;
        Fri, 18 Feb 2022 01:01:48 -0800 (PST)
Received: from krava ([2a00:102a:5012:d617:c924:e6ed:1707:a063])
        by smtp.gmail.com with ESMTPSA id p2sm3658016wmc.33.2022.02.18.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:01:48 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:01:45 +0100
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
Message-ID: <Yg9geQ0LJjhnrc7j@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 01:53:16PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Some functions we use now for bpf prologue generation are
> > going to be deprecated, so reworking the current code not
> > to use them.
> >
> > We need to replace following functions/struct:
> >    bpf_program__set_prep
> >    bpf_program__nth_fd
> >    struct bpf_prog_prep_result
> >
> > Current code uses bpf_program__set_prep to hook perf callback
> > before the program is loaded and provide new instructions with
> > the prologue.
> >
> > We workaround this by using objects's 'unloaded' programs instructions
> > for that specific program and load new ebpf programs with prologue
> > using separate bpf_prog_load calls.
> >
> > We keep new ebpf program instances descriptors in bpf programs
> > private struct.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
> >  1 file changed, 104 insertions(+), 18 deletions(-)
> >
> 
> [...]
> 
> >  errout:
> > @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> >         struct bpf_prog_priv *priv = program_priv(prog);
> >         struct perf_probe_event *pev;
> >         bool need_prologue = false;
> > -       int err, i;
> > +       int i;
> >
> >         if (IS_ERR_OR_NULL(priv)) {
> >                 pr_debug("Internal error when hook preprocessor\n");
> > @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> >                 return 0;
> >         }
> >
> > +       /*
> > +        * Do not load programs that need prologue, because we need
> > +        * to add prologue first, check bpf_object__load_prologue.
> > +        */
> > +       bpf_program__set_autoload(prog, false);
> 
> if you set autoload to false, program instructions might be invalid in
> the end. Libbpf doesn't apply some (all?) relocations to such
> programs, doesn't resolve CO-RE, etc, etc. You have to let
> "prototypal" BPF program to be loaded before you can grab final
> instructions. It's not great, but in your case it should work, right?

hum, do we care? it should all be done when the 'new' program with
the prologue is loaded, right?

I switched it off because the verifier failed to load the program
without the prologue.. because in the originaal program there's no
code to grab the arguments that the rest of the code depends on,
so the verifier sees invalid access

> 
> > +
> >         priv->need_prologue = true;
> >         priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
> >         if (!priv->insns_buf) {
> > @@ -734,6 +762,13 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> >                 return -ENOMEM;
> >         }
> >
> 
> [...]
> 
> > +               /*
> > +                * For each program that needs prologue we do following:
> > +                *
> > +                * - take its current instructions and use them
> > +                *   to generate the new code with prologue
> > +                *
> > +                * - load new instructions with bpf_prog_load
> > +                *   and keep the fd in proglogue_fds
> > +                *
> > +                * - new fd will be used bpf__foreach_event
> > +                *   to connect this program with perf evsel
> > +                */
> > +               orig_insns = bpf_program__insns(prog);
> > +               orig_insns_cnt = bpf_program__insn_cnt(prog);
> > +
> > +               pev = &priv->pev;
> > +               for (i = 0; i < pev->ntevs; i++) {
> > +                       err = preproc_gen_prologue(prog, i, orig_insns,
> > +                                                  orig_insns_cnt, &res);
> > +                       if (err)
> > +                               return err;
> > +
> > +                       fd = bpf_prog_load(bpf_program__get_type(prog),
> 
> nit: bpf_program__type() is preferred (we are deprecating/discouraging
> "get_" prefixed getters in libbpf 1.0)

ok, will change

> 
> > +                                          bpf_program__name(prog), "GPL",
> 
> would it make sense to give each clone a distinct name?

AFAICS the original code uses same prog name for instances,
so I'd rather keep it that way

thanks,
jirka

> 
> > +                                          res.new_insn_ptr,
> > +                                          res.new_insn_cnt, NULL);
> > +                       if (fd < 0) {
> > +                               char bf[128];
> > +
> 
> [...]
