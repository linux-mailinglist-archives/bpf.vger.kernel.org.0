Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B14C1E73
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiBWWah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBWWah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:30:37 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335E40A16;
        Wed, 23 Feb 2022 14:30:08 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d7so303508ilf.8;
        Wed, 23 Feb 2022 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCD5mZDkpwUlyfA20EEEfKsRSer4ZvxexsoTB06hY/A=;
        b=IreiLBdNn8Oy45HYTiYi2dUZLMAOM4/vGSglBN0jSNWgfa2KiIJ5SmWVmmLY14LTPu
         /ljwBTfAMRprIEmitySbE3DjJ7GO0Ym6pNZgCO1FAMzA4SCsP855lFASCRAl4y2YxHNF
         xDl3rPDL0R1qL/C5JHR7m3hdTG28+QD7TKz+HgrsjBoP/BOHhDEVC50IRywWovGZh6dF
         fGT8h1Skdkj6x52KTXkUm4btGad7BAjcXOFmnFUxKFnWIt6gVb2qQcyyxoTSuV/Vs1/T
         sr0QLtUEEdz0PgnZlMJE3nMpFa4cu3yFrwAcPb/XYC90ueCgD/vIrzGX+TZg4hlO3q4a
         dgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCD5mZDkpwUlyfA20EEEfKsRSer4ZvxexsoTB06hY/A=;
        b=R26Rjmyfwt5v3oJcCXFXvDcD0evUiWIoyHLVWNZ0ErdBB3tuQEnl+wBnnNO4c3ef4Z
         kcPEWYIuE8E0XpiEz9+m26hHYNet1MrpG4axOyixXFg7rEePnR3njsCLSkasWRD7Us4u
         6wu93bIO/+YUNnG0mQ9/G8YvEd453hOVND7CnoInBrm4W9Ehe4KPn3+ZWIoYwLNVXGik
         C38Rc4ivN1OSXUVVDtqtnU769UWqq+EYxW6uCJpnECdeWAK7a06lBLtqwm4hDna2fBXx
         0VWpRvsTIpXfjBur1dgIVf1x2VFurLsJ02vXo7eRlrJlSzaMihhSjELCi6M1JcCoTrCb
         lKWA==
X-Gm-Message-State: AOAM530bcD6lt4dLxj4q5p5vgN1y/qFnM+MpG7NM+n5rn5ZQ5P5+1zTR
        lTFWTZFkueyChx0LuaZIppJrnzOfyEahNGFbrpA=
X-Google-Smtp-Source: ABdhPJxkrxQdW9RPINy1hLfe+amQK5VHu3FnVHncvhMgrVRBAMv9MOXRITgx8Wdf0TVYEhH0pSZB1zZBsxVpuZfeqXk=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr1478385ilb.305.1645655407879; Wed, 23
 Feb 2022 14:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org> <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava> <CAEf4BzZaFWhWf73JbfO7gLi82Nn4ma-qmaZBPij=giNzzoSCTQ@mail.gmail.com>
 <YhJF00d9baPtXjzH@krava>
In-Reply-To: <YhJF00d9baPtXjzH@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:56 -0800
Message-ID: <CAEf4BzaiBO3_617kkXZdYJ8hS8YF--ZLgapNbgeeEJ-pY0H88g@mail.gmail.com>
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

On Sun, Feb 20, 2022 at 5:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Feb 18, 2022 at 11:55:16AM -0800, Andrii Nakryiko wrote:
> > On Fri, Feb 18, 2022 at 1:01 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Feb 17, 2022 at 01:53:16PM -0800, Andrii Nakryiko wrote:
> > > > On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Some functions we use now for bpf prologue generation are
> > > > > going to be deprecated, so reworking the current code not
> > > > > to use them.
> > > > >
> > > > > We need to replace following functions/struct:
> > > > >    bpf_program__set_prep
> > > > >    bpf_program__nth_fd
> > > > >    struct bpf_prog_prep_result
> > > > >
> > > > > Current code uses bpf_program__set_prep to hook perf callback
> > > > > before the program is loaded and provide new instructions with
> > > > > the prologue.
> > > > >
> > > > > We workaround this by using objects's 'unloaded' programs instructions
> > > > > for that specific program and load new ebpf programs with prologue
> > > > > using separate bpf_prog_load calls.
> > > > >
> > > > > We keep new ebpf program instances descriptors in bpf programs
> > > > > private struct.
> > > > >
> > > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
> > > > >  1 file changed, 104 insertions(+), 18 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > >  errout:
> > > > > @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > > >         struct bpf_prog_priv *priv = program_priv(prog);
> > > > >         struct perf_probe_event *pev;
> > > > >         bool need_prologue = false;
> > > > > -       int err, i;
> > > > > +       int i;
> > > > >
> > > > >         if (IS_ERR_OR_NULL(priv)) {
> > > > >                 pr_debug("Internal error when hook preprocessor\n");
> > > > > @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > > >                 return 0;
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * Do not load programs that need prologue, because we need
> > > > > +        * to add prologue first, check bpf_object__load_prologue.
> > > > > +        */
> > > > > +       bpf_program__set_autoload(prog, false);
> > > >
> > > > if you set autoload to false, program instructions might be invalid in
> > > > the end. Libbpf doesn't apply some (all?) relocations to such
> > > > programs, doesn't resolve CO-RE, etc, etc. You have to let
> > > > "prototypal" BPF program to be loaded before you can grab final
> > > > instructions. It's not great, but in your case it should work, right?
> > >
> > > hum, do we care? it should all be done when the 'new' program with
> > > the prologue is loaded, right?
> >
> > yeah, you should care. If there is any BPF map involved, it is
> > properly resolved to correct FD (which is put into ldimm64 instruction
> > in BPF program code) during the load. If program is not autoloaded,
> > this is skipped. Same for any global variable or subprog call (if it's
> > not always inlined). So you very much should care for any non-trivial
> > program.
>
> ah too bad.. all that is in the load path, ok
>
> >
> > >
> > > I switched it off because the verifier failed to load the program
> > > without the prologue.. because in the original program there's no
> > > code to grab the arguments that the rest of the code depends on,
> > > so the verifier sees invalid access
> >
> > Do you have an example of C code and corresponding BPF instructions
> > before/after prologue generation? Just curious to see in details how
> > this is done.
>
> so with following example:
>
>         SEC("func=do_sched_setscheduler param->sched_priority@user")
>         int bpf_func__setscheduler(void *ctx, int err, int param)
>         {
>                 char fmt[] = "prio: %ld";
>                 bpf_trace_printk(fmt, sizeof(fmt), param);
>                 return 1;
>         }
>
> perf will attach the code to do_sched_setscheduler function,
> and read 'param->sched_priority' into 'param' argument
>
> so the resulting clang object expects 'param' to be in R3
>
>         0000000000000000 <bpf_func__setscheduler>:
>                0:       b7 01 00 00 64 00 00 00 r1 = 100
>                1:       6b 1a f8 ff 00 00 00 00 *(u16 *)(r10 - 8) = r1
>                2:       18 01 00 00 70 72 69 6f 00 00 00 00 3a 20 25 6c r1 = 77926701655
>                4:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
>                5:       bf a1 00 00 00 00 00 00 r1 = r10
>                6:       07 01 00 00 f0 ff ff ff r1 += -16
>                7:       b7 02 00 00 0a 00 00 00 r2 = 10
>                8:       85 00 00 00 06 00 00 00 call 6
>                9:       b7 00 00 00 01 00 00 00 r0 = 1
>               10:       95 00 00 00 00 00 00 00 exit
>
> and R3 is loaded in the prologue code (first 15 instructions)
> and it also sets 'err' (R2) with the result of the reading:
>
>            0: (bf) r6 = r1
>            1: (79) r3 = *(u64 *)(r6 +96)
>            2: (bf) r7 = r10
>            3: (07) r7 += -8
>            4: (7b) *(u64 *)(r10 -8) = r3
>            5: (b7) r2 = 8
>            6: (bf) r1 = r7
>            7: (85) call bpf_probe_read_user#-60848
>            8: (55) if r0 != 0x0 goto pc+2
>            9: (61) r3 = *(u32 *)(r10 -8)
>           10: (05) goto pc+3
>           11: (b7) r2 = 1
>           12: (b7) r3 = 0
>           13: (05) goto pc+1
>           14: (b7) r2 = 0
>           15: (bf) r1 = r6
>
>           16: (b7) r1 = 100
>           17: (6b) *(u16 *)(r10 -8) = r1
>           18: (18) r1 = 0x6c25203a6f697270
>           20: (7b) *(u64 *)(r10 -16) = r1
>           21: (bf) r1 = r10
>           22: (07) r1 += -16
>           23: (b7) r2 = 10
>           24: (85) call bpf_trace_printk#-54848
>           25: (b7) r0 = 1
>           26: (95) exit
>
>
> I'm still scratching my head how to workaround this.. we do want maps
> and all the other updates to the code, but verifier won't let it pass
> without the prologue code

ugh, perf cornered itself into supporting this crazy scheme and now
there is no good solution. I'm still questioning the value of
supporting this going forward. Is there an evidence that anyone is
using this functionality at all? Is it worth it trying to carry it on
just because we have some example that exercises this feature?

Anyways, one way to solve this is to add bpf_program__set_insns() that
could be called from prog_init_fn callback (which I just realized
hasn't landed yet, I'll send v4 today) to prepend a simple preamble
like this:

r1 = 0;
r2 = 0;
r3 = 0;
f4 = 0;
r5 = 0; /* how many input arguments we support? */

This will make all input arguments initialized, libbpf will be able to
adjust all the relocations and stuff. Once this "prototype program" is
loaded, perf can grab final instructions and replace first X
instructions with desired preamble.

But... ugliness and horror, yeah :(


>
> jirka
