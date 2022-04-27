Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B81511E63
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiD0SSQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiD0SSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 14:18:15 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706119C02;
        Wed, 27 Apr 2022 11:15:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w1so4589888lfa.4;
        Wed, 27 Apr 2022 11:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Okm5dD/Oc33gIv0yVRc1fgY/+IJnnsOYTp9Pczt09uQ=;
        b=m7OMcPDJcmgUIU3bf+FXbNeg7c+ela3KHvKmg9fBQ1qWlg317zDddDI81aj44pz+AA
         Vo46wfrGZmi02QXSKnYBrRcSlpNYFNXtM/aJjSjqnZSbkY98ccCW3DM2NgusQzzHZEa6
         pClvWGz1NoW0weSFrTpp9FkqrhK6K1RTQDjIye5CgemlFu5kT2O5mRMMfzPhj0BQzCxx
         //i7QOQzCIG6JsUgMIwpfNftUsNdgMu8h08Lv/h1YfhnAjOLj/PXYiJQHBVFxbDXR0PB
         igCudI5x//A+QB7l0Y/frG/0reTaHy1cYa4kBboob14QtywZkgQCmEJ8bAZBDKXFl5My
         7K9g==
X-Gm-Message-State: AOAM530r1axzXZ3julBaRIZza1OHFfDpZrf4A/sQgoeTZxrvmZwAJaun
        GmtXpSonOGkNW9qPB7fIL46IHgfn4WNCw9lZ0zE=
X-Google-Smtp-Source: ABdhPJzaf+QMWy4arMCMk4NdpXvr5yt3ItrfK0d+nJtIt/Jb8/lofL0/THaA2G1M2/vvUksET/j07HAXd5AjWTAETZY=
X-Received: by 2002:a05:6512:321c:b0:46b:b7fd:1eca with SMTP id
 d28-20020a056512321c00b0046bb7fd1ecamr8012902lfe.481.1651083300256; Wed, 27
 Apr 2022 11:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-5-namhyung@kernel.org>
 <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com>
In-Reply-To: <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Apr 2022 11:14:49 -0700
Message-ID: <CAM9d7chos3xgxPMOMwgSh6nCNfqk8k2tXO=0JsdL4KgN_yngCA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf record: Handle argument change in sched_switch
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Apr 26, 2022 at 4:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 22, 2022 at 3:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Recently sched_switch tracepoint added a new argument for prev_state,
> > but it's hard to handle the change in a BPF program.  Instead, we can
> > check the function prototype in BTF before loading the program.
> >
> > Thus I make two copies of the tracepoint handler and select one based
> > on the BTF info.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_off_cpu.c          | 32 +++++++++++++++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 55 ++++++++++++++++++++------
> >  2 files changed, 76 insertions(+), 11 deletions(-)
> >
>
> [...]
>
> >
> > +SEC("tp_btf/sched_switch")
> > +int on_switch3(u64 *ctx)
> > +{
> > +       struct task_struct *prev, *next;
> > +       int state;
> > +
> > +       if (!enabled)
> > +               return 0;
> > +
> > +       /*
> > +        * TP_PROTO(bool preempt, struct task_struct *prev,
> > +        *          struct task_struct *next)
> > +        */
> > +       prev = (struct task_struct *)ctx[1];
> > +       next = (struct task_struct *)ctx[2];
>
>
> you don't have to have two BPF programs for this, you can use
> read-only variable to make this choice.
>
> On BPF side
>
> const volatile bool has_prev_state = false;
>
> ...
>
> if (has_prev_state) {
>     prev = (struct task_struct *)ctx[2];
>     next = (struct task_struct *)ctx[3];
> } else {
>     prev = (struct task_struct *)ctx[1];
>     next = (struct task_struct *)ctx[2];
> }
>
>
> And from user-space side you do your detection and before skeleton is loaded:
>
> skel->rodata->has_prev_state = <whatever you detected>

Nice, thanks for the tip!

Actually I tried something similar but it was with a variable (in bss)
so the verifier in an old kernel rejected it due to invalid arg access.

I guess now the const makes the verifier ignore the branch as if
it's dead but the compiler still generates the code, right?

>
> But I'm still hoping that this prev_state argument can be moved to the
> end ([0]) to make all this unnecessary.
>
>   [0] https://lore.kernel.org/lkml/93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com/

Yeah, that would make life easier. :)

Thanks,
Namhyung
