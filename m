Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00A4BC0BA
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiBRTz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 14:55:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiBRTzp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 14:55:45 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C129E;
        Fri, 18 Feb 2022 11:55:27 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h11so5468680ilq.9;
        Fri, 18 Feb 2022 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uMqrw8+6VchXMRp0bzbPkGR2Iy1g3pLICkvKHQUn5s=;
        b=Gz+N6F0GuBqFa6mOtU/cqd9YC7sTYPS/YXaUQIwHTo3WhD9LCaPiA2X2CrplBDWlzX
         d2ie1fQsmGyLhelJ7fLx3PLzYB8+fYH6BazFK1Eoz+uR1nvpZZ07lVUQS9AEq2v7cT6Q
         sw4KvXulNbKRo4b/FMm7HRUDlf4Mj2ABfjHbt5vmXbVg48xaGBOgJbrEwTHMxJluJBeP
         KXYzVJU+CNLflQgHSnu8uf0+H570io3eu9QgiCnTk+gxHlxeAe7pD8n0A/Dj40h1zr+l
         aecSnsUsCE6HoSyLb4pmFFPzzdv4N0SwzsaLeZ/44JItbt03+uC1GiuyAC8Ojurn8/Z1
         L6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uMqrw8+6VchXMRp0bzbPkGR2Iy1g3pLICkvKHQUn5s=;
        b=EU+ANyg24Vpcen35b4Z5uBQd5KOuG/DbVRxdnitYjm8h7otRjX4e3gRIO4Ga/TRJmS
         UPh0N3uzQ8OUUdnO1ucBl6kkRPztLtJmqGQ7W0pxuwhoaffkfRZSAM0wwKd89143/jsa
         5Gudz/OvrifqMnGaq7ifDNYB5wpTWp6ZcYlQusti3To0GNM4E68D9Jj/5gYeXTawHoLn
         8NV57aG+d1y/bfNk+YG0Gxp8byMdwAc/QqaYRXSGR6Ygy6dvazRDyx8yYNoIq+qNVYiL
         zN7CrWT4uYi8Fft50lOKg0rWa2GaKKhz1k6bZfTSDTLoubb+E7RSjAgWtZjsEyKLsp6p
         0mEQ==
X-Gm-Message-State: AOAM532WM6sWb6IwaSi+ZRjZTTO6lwME4trzQbv6SpNAZBTUoKKaexfW
        eJn0E2mvDiHNA9vgE467Jh8EESynHs0U3HlGvFQ6zwjxYYs=
X-Google-Smtp-Source: ABdhPJwMElGK0zoFWXExXzv66lkDUPkUajOfC5brsjaVY+7cETRxZt3fHRYc7wYWrqv/3bY+JQmsfOL4rp9yZ/BTJrw=
X-Received: by 2002:a92:d208:0:b0:2c1:1a3c:7b01 with SMTP id
 y8-20020a92d208000000b002c11a3c7b01mr6454880ily.71.1645214127400; Fri, 18 Feb
 2022 11:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org> <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com> <Yg9geQ0LJjhnrc7j@krava>
In-Reply-To: <Yg9geQ0LJjhnrc7j@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Feb 2022 11:55:16 -0800
Message-ID: <CAEf4BzZaFWhWf73JbfO7gLi82Nn4ma-qmaZBPij=giNzzoSCTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
To:     Jiri Olsa <olsajiri@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 18, 2022 at 1:01 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
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

yeah, you should care. If there is any BPF map involved, it is
properly resolved to correct FD (which is put into ldimm64 instruction
in BPF program code) during the load. If program is not autoloaded,
this is skipped. Same for any global variable or subprog call (if it's
not always inlined). So you very much should care for any non-trivial
program.

>
> I switched it off because the verifier failed to load the program
> without the prologue.. because in the original program there's no
> code to grab the arguments that the rest of the code depends on,
> so the verifier sees invalid access

Do you have an example of C code and corresponding BPF instructions
before/after prologue generation? Just curious to see in details how
this is done.

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

It's been added in v0.7, yeah.

>
> >
> > > +                                          bpf_program__name(prog), "GPL",
> >
> > would it make sense to give each clone a distinct name?
>
> AFAICS the original code uses same prog name for instances,
> so I'd rather keep it that way
>

sure, np

> thanks,
> jirka
>
> >
> > > +                                          res.new_insn_ptr,
> > > +                                          res.new_insn_cnt, NULL);
> > > +                       if (fd < 0) {
> > > +                               char bf[128];
> > > +
> >
> > [...]
