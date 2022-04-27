Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7905122B4
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiD0TbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiD0Ta6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 15:30:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5EF1A39A;
        Wed, 27 Apr 2022 12:26:48 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id t4so619092ilo.12;
        Wed, 27 Apr 2022 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPwl3B36r2cAnhKOklI7W5r9ku8U6ZGRu8H06ecsDmA=;
        b=BjuIo11TFSHGVHxVxumbfBtSf8/SrNJ5SC/Xtue/hPWKa4HvDpapKHpH2L6yrPENpH
         2OEaN0xGJdlqoxfc0DVjsqxTiZ8R5bPkyB+qiNr3huDg39Lsetol46LCwuW940laIqwf
         LbzlCHbPy22J2HKPJ39VYopALdVPToXxpMj5gVW+fjtziRpo1gCbCVVZpWWfWygF+PCG
         u9tyApFiaaMIlpEsxb6c3637itcFm+maFkB4K24+ToVSepQMG4t8SybAruTA07s54LCI
         I6sdzHWpmJMyz40EX+iwKNtvW//cG/hteQwpeSn/y5CNx4XJoeB+aq7Hrjf+CcT+d5lN
         ENWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPwl3B36r2cAnhKOklI7W5r9ku8U6ZGRu8H06ecsDmA=;
        b=Cu8VPT2JAFjtCiZiKVboR5MYTqAHrz5WnrpWEEJBPIQUGsbsVYllbc9gGZeRrJCBsa
         cPENfqMvhi3te2Ulk2x+Emz0LkoB8g3+qvEQSnvb8Tzqpqing4ybbOiCmy9TNPQrqPMr
         9LsDMt2YcN/fyBDBGN2KnUHFUuxClzFhL42ZlPsO7rwOytkVheQpsLv0F1PrU7T7q05R
         76Br4kdn8TOcinU2OJ9Y/+ATrkk8aorGUoMkF/0uK/rB7Gsg1k7Zfj2JQDuAXAHypafn
         H7T03ZLHNUWrOLWLV4vAnqA74JrwwdtOSE8de5fnsar9TtribFY3pmfrWuikb1QCCWCq
         bwHw==
X-Gm-Message-State: AOAM533/M00R5d3u7V7EmEftaB+h8R/E/peEF4TVYQVDH1tW/nFkAwxl
        I4fa8g5caivHU/AiKMKI2byFPmV3yKLE4lQ1wX1/6lib620=
X-Google-Smtp-Source: ABdhPJzA/MkwsJsuKT3AKg8Kx603QI4N2VDrpmZSAU9hfxKMztHgFoA7OVcNigYiHbBOLyuzfVf/oBw7/LFCsDUaGGg=
X-Received: by 2002:a05:6e02:1ba3:b0:2cc:4158:d3ff with SMTP id
 n3-20020a056e021ba300b002cc4158d3ffmr11614731ili.98.1651087607619; Wed, 27
 Apr 2022 12:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-5-namhyung@kernel.org>
 <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com> <CAM9d7chos3xgxPMOMwgSh6nCNfqk8k2tXO=0JsdL4KgN_yngCA@mail.gmail.com>
In-Reply-To: <CAM9d7chos3xgxPMOMwgSh6nCNfqk8k2tXO=0JsdL4KgN_yngCA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 12:26:36 -0700
Message-ID: <CAEf4BzZ-RwXV8NoWk4rLyLWyxJhQ6b96ieVCy0kkjLCq8cVxqw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf record: Handle argument change in sched_switch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
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

On Wed, Apr 27, 2022 at 11:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Tue, Apr 26, 2022 at 4:55 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 22, 2022 at 3:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Recently sched_switch tracepoint added a new argument for prev_state,
> > > but it's hard to handle the change in a BPF program.  Instead, we can
> > > check the function prototype in BTF before loading the program.
> > >
> > > Thus I make two copies of the tracepoint handler and select one based
> > > on the BTF info.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/bpf_off_cpu.c          | 32 +++++++++++++++
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 55 ++++++++++++++++++++------
> > >  2 files changed, 76 insertions(+), 11 deletions(-)
> > >
> >
> > [...]
> >
> > >
> > > +SEC("tp_btf/sched_switch")
> > > +int on_switch3(u64 *ctx)
> > > +{
> > > +       struct task_struct *prev, *next;
> > > +       int state;
> > > +
> > > +       if (!enabled)
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * TP_PROTO(bool preempt, struct task_struct *prev,
> > > +        *          struct task_struct *next)
> > > +        */
> > > +       prev = (struct task_struct *)ctx[1];
> > > +       next = (struct task_struct *)ctx[2];
> >
> >
> > you don't have to have two BPF programs for this, you can use
> > read-only variable to make this choice.
> >
> > On BPF side
> >
> > const volatile bool has_prev_state = false;
> >
> > ...
> >
> > if (has_prev_state) {
> >     prev = (struct task_struct *)ctx[2];
> >     next = (struct task_struct *)ctx[3];
> > } else {
> >     prev = (struct task_struct *)ctx[1];
> >     next = (struct task_struct *)ctx[2];
> > }
> >
> >
> > And from user-space side you do your detection and before skeleton is loaded:
> >
> > skel->rodata->has_prev_state = <whatever you detected>
>
> Nice, thanks for the tip!
>
> Actually I tried something similar but it was with a variable (in bss)
> so the verifier in an old kernel rejected it due to invalid arg access.
>
> I guess now the const makes the verifier ignore the branch as if
> it's dead but the compiler still generates the code, right?


yes, exactly

>
> >
> > But I'm still hoping that this prev_state argument can be moved to the
> > end ([0]) to make all this unnecessary.
> >
> >   [0] https://lore.kernel.org/lkml/93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com/
>
> Yeah, that would make life easier. :)
>
> Thanks,
> Namhyung
