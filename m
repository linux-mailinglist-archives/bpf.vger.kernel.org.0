Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92A64A861
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiLLUF2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 12 Dec 2022 15:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiLLUFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:05:11 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F51789C;
        Mon, 12 Dec 2022 12:05:10 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id i187-20020a1c3bc4000000b003d21f02fbaaso715635wma.4;
        Mon, 12 Dec 2022 12:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC47u5ABuoEhubGgg4/9VNrEDUcZI85O5fBH9REajDA=;
        b=iEPoscHd5fvbKadhR315VfbgvCWHCtTMs8h8qn8FXE6ZIkxjGXO/kRzF+nSO9A7PTs
         JlFQPxpRlMPEBXouEdywyZ6T5215dDU8M1SMn0jaBIhQDTZQstjjaU5I24qZS4D7mZhj
         po6MRtAOJm7/5dHefHckfl9A3x43nZ8YdxmDP3YQxHBX077mMRlc6/RfZNq5j70mxJwa
         kVzt02RqyqwIDCcVKAqoecFXy4iqyW2qJCGSYUT4Cf5JTUo1+VsszOuHo0Vgj8z7Y6e6
         ZmVEFNFjKnWCxDhnz6maZUc2XoOYbNgUOOIJPc/oNcvQKNTF7FOaKCqj83GcOCjjryCG
         GrSA==
X-Gm-Message-State: ANoB5pnGrPmXmhj9CxlCobKM1dNVlPQF5EC1eb4cCxYwnIJIeJXE4oeZ
        LRd9FEbj7/kvGRNDeqeh7JcRIpPmtZtIiY0c3G4=
X-Google-Smtp-Source: AA0mqf7MiW707fes7g9Q5aQzK1ML4tYsEM7LkIbboMUaR5/C23/d3G5PSVlEEIOTPC5a1CVCgpcs01dvbxXLAxI0UOM=
X-Received: by 2002:a05:600c:3052:b0:3d1:cae5:efe9 with SMTP id
 n18-20020a05600c305200b003d1cae5efe9mr10986wmh.158.1670875508712; Mon, 12 Dec
 2022 12:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20221209190727.759804-1-namhyung@kernel.org> <20221209190727.759804-2-namhyung@kernel.org>
 <Y5eEJd/AhSzUfILO@kernel.org> <Y5eEbxVOHaUPw9UI@kernel.org> <Y5eE3Udv03uM4zhQ@kernel.org>
In-Reply-To: <Y5eE3Udv03uM4zhQ@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 12 Dec 2022 12:04:56 -0800
Message-ID: <CAM9d7ch2nNS_m_3f5J+M9GJ8=GimG1Y7Yqve=Loy1hhjnEvnag@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf lock contention: Add lock_data.h for common data
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Mon, Dec 12, 2022 at 11:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Dec 12, 2022 at 04:43:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Dec 12, 2022 at 04:42:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Dec 09, 2022 at 11:07:24AM -0800, Namhyung Kim escreveu:
> > > > Accessing BPF maps should use the same data types.  Add bpf_skel/lock_data.h
> > > > to define the common data structures.  No functional changes.
> > >
> > > You forgot to update one of the stack_id users, that field got renamed:
> > >
> > > util/bpf_skel/lock_contention.bpf.c:144:6: error: no member named 'stack_id' in 'struct contention_key'
> > >         key.stack_id = pelem->stack_id;
> > >         ~~~ ^
> > > 1 error generated.
> > > make[2]: *** [Makefile.perf:1075: /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> > > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > > make: *** [Makefile:113: install-bin] Error 2
> > > make: Leaving directory '/var/home/acme/git/perf/tools/perf'

Oops, right.

> > >
> > >  Performance counter stats for 'make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':
> > >
> > >      7,005,216,342      cycles:u
> > >     11,851,225,594      instructions:u                   #    1.69  insn per cycle
> > >
> > >        3.168945139 seconds time elapsed
> > >
> > >        1.730964000 seconds user
> > >        1.578932000 seconds sys
> > >
> > >
> > > ⬢[acme@toolbox perf]$ git log --oneline -4
> > > f6e7a5f1db49dc8e (HEAD) perf lock contention: Add lock_data.h for common data
> > > 5d9b55713c5c037f perf python: Account for multiple words in CC
> > > d9078bf3f3320457 perf off_cpu: Fix a typo in BTF tracepoint name, it should be 'btf_trace_sched_switch'
> > > 3b7ea76f0f7844f5 perf test: Update event group check for support of uncore event
> > > ⬢[acme@toolbox perf]$
> > >
> > > After some point it builds.
> > >
> > > I'm fixing this to keep it bisectable.
> >
> > I folded this:
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 0f63cc28ccbabd21..64fd1e040ac86e58 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -141,7 +141,7 @@ int contention_end(u64 *ctx)
> >
> >       duration = bpf_ktime_get_ns() - pelem->timestamp;
> >
> > -     key.stack_id = pelem->stack_id;
> > +     key.stack_or_task_id = pelem->stack_id;
> >       data = bpf_map_lookup_elem(&lock_stat, &key);
> >       if (!data) {
> >               struct contention_data first = {

Thanks for fixing this.

>
>
> And then fixed up this:
>
> Could not apply 3d4947c7bd10beba... perf lock contention: Implement -t/--threads option for BPF
> ⬢[acme@toolbox perf]$
> ⬢[acme@toolbox perf]$
> ⬢[acme@toolbox perf]$ git diff
> diff --cc tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 64fd1e040ac86e58,cd405adcd252b82d..0000000000000000
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@@ -141,7 -168,13 +168,17 @@@ int contention_end(u64 *ctx
>
>         duration = bpf_ktime_get_ns() - pelem->timestamp;
>
> ++<<<<<<< HEAD
>  +      key.stack_or_task_id = pelem->stack_id;
> ++=======
> +       if (aggr_mode == LOCK_AGGR_CALLER) {
> +               key.stack_or_task_id = pelem->stack_id;
> +       } else {
> +               key.stack_or_task_id = pid;
> +               update_task_data(pid);
> +       }
> +
> ++>>>>>>> 3d4947c7bd10beba (perf lock contention: Implement -t/--threads option for BPF)

Sure, it looks good to me.

Thanks,
Namhyung
