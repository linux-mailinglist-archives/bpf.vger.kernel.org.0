Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD4533BB7
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiEYL17 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbiEYL1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 07:27:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD7D9EB6B;
        Wed, 25 May 2022 04:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 487E1B81D26;
        Wed, 25 May 2022 11:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01ACC385B8;
        Wed, 25 May 2022 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653478061;
        bh=koflIRXjp6DUubFrVVuIsQCYgnnlKZX/mFWNYM4Xq1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQ/4U2G/D1ssovDPoN5J3gYIIXsZzIV2QbShXWj5hCEeSB+G1rDWyCrYMaLFNSG9V
         Ry9am/YdG1ONr+/47ccp8VA5CpY9slv02mZoKIeb0SolgEWQqjrNQgTwCFWjo7ogvC
         wk7MHsVfX44ijHdIG6yMzddrTwRdZgFqpfsdanf5K76HYZBf38FMN4yRXhsvKkkaeQ
         l81AK1iRXG5UGJiAXaRtvZdMhC5iAKpkeX/5hE9lroTirwbW5bHkn69ntGXJ+Sb/k7
         67DhElX44GOuL3S01fNwinsDJqWyqaiadfm/fp0+zRYhsI8icLUjeCdmusZf1swiYR
         M0ugi/s52Ot8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 545174007E; Wed, 25 May 2022 08:27:38 -0300 (-03)
Date:   Wed, 25 May 2022 08:27:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 3/6] perf record: Implement basic filtering for off-cpu
Message-ID: <Yo4SqnEqzo2Rt+PF@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
 <20220518224725.742882-4-namhyung@kernel.org>
 <CAP-5=fWfZ_MqiAUx-tdO1C=Dyyzno6FbBp+KGAb_MweXs+N7Jw@mail.gmail.com>
 <CAM9d7cgxdFJJQOg6ivuy4+nh=WME2fgjvM-kSWLv9zd49yxR4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgxdFJJQOg6ivuy4+nh=WME2fgjvM-kSWLv9zd49yxR4A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, May 19, 2022 at 02:02:28PM -0700, Namhyung Kim escreveu:
> On Wed, May 18, 2022 at 9:02 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > It should honor cpu and task filtering with -a, -C or -p, -t options.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/builtin-record.c            |  2 +-
> > >  tools/perf/util/bpf_off_cpu.c          | 78 +++++++++++++++++++++++---
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 52 +++++++++++++++--
> > >  tools/perf/util/off_cpu.h              |  6 +-
> > >  4 files changed, 123 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 91f88501412e..7f60d2eac0b4 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -907,7 +907,7 @@ static int record__config_text_poke(struct evlist *evlist)
> > >
> > >  static int record__config_off_cpu(struct record *rec)
> > >  {
> > > -       return off_cpu_prepare(rec->evlist);
> > > +       return off_cpu_prepare(rec->evlist, &rec->opts.target);
> > >  }
> > >
> > >  static bool record__kcore_readable(struct machine *machine)
> > > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> > > index 9ed7aca3f4ac..b5e2d038da50 100644
> > > --- a/tools/perf/util/bpf_off_cpu.c
> > > +++ b/tools/perf/util/bpf_off_cpu.c
> > > @@ -6,6 +6,9 @@
> > >  #include "util/off_cpu.h"
> > >  #include "util/perf-hooks.h"
> > >  #include "util/session.h"
> > > +#include "util/target.h"
> > > +#include "util/cpumap.h"
> > > +#include "util/thread_map.h"
> > >  #include <bpf/bpf.h>
> > >
> > >  #include "bpf_skel/off_cpu.skel.h"
> > > @@ -60,8 +63,23 @@ static int off_cpu_config(struct evlist *evlist)
> > >         return 0;
> > >  }
> > >
> > > -static void off_cpu_start(void *arg __maybe_unused)
> > > +static void off_cpu_start(void *arg)
> > >  {
> > > +       struct evlist *evlist = arg;
> > > +
> > > +       /* update task filter for the given workload */
> > > +       if (!skel->bss->has_cpu && !skel->bss->has_task &&
> > > +           perf_thread_map__pid(evlist->core.threads, 0) != -1) {
> > > +               int fd;
> > > +               u32 pid;
> > > +               u8 val = 1;
> > > +
> > > +               skel->bss->has_task = 1;
> > > +               fd = bpf_map__fd(skel->maps.task_filter);
> > > +               pid = perf_thread_map__pid(evlist->core.threads, 0);
> > > +               bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> > > +       }
> > > +
> > >         skel->bss->enabled = 1;
> > >  }
> > >
> > > @@ -71,31 +89,75 @@ static void off_cpu_finish(void *arg __maybe_unused)
> > >         off_cpu_bpf__destroy(skel);
> > >  }
> > >
> > > -int off_cpu_prepare(struct evlist *evlist)
> > > +int off_cpu_prepare(struct evlist *evlist, struct target *target)
> > >  {
> > > -       int err;
> > > +       int err, fd, i;
> > > +       int ncpus = 1, ntasks = 1;
> > >
> > >         if (off_cpu_config(evlist) < 0) {
> > >                 pr_err("Failed to config off-cpu BPF event\n");
> > >                 return -1;
> > >         }
> > >
> > > -       set_max_rlimit();
> > > -
> > > -       skel = off_cpu_bpf__open_and_load();
> > > +       skel = off_cpu_bpf__open();
> > >         if (!skel) {
> > >                 pr_err("Failed to open off-cpu BPF skeleton\n");
> > >                 return -1;
> > >         }
> > >
> > > +       /* don't need to set cpu filter for system-wide mode */
> > > +       if (target->cpu_list) {
> > > +               ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
> > > +               bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
> > > +       }
> > > +
> > > +       if (target__has_task(target)) {
> > > +               ntasks = perf_thread_map__nr(evlist->core.threads);
> > > +               bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
> > > +       }
> > > +
> > > +       set_max_rlimit();
> > > +
> > > +       err = off_cpu_bpf__load(skel);
> > > +       if (err) {
> > > +               pr_err("Failed to load off-cpu skeleton\n");
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (target->cpu_list) {
> > > +               u32 cpu;
> > > +               u8 val = 1;
> > > +
> > > +               skel->bss->has_cpu = 1;
> > > +               fd = bpf_map__fd(skel->maps.cpu_filter);
> > > +
> > > +               for (i = 0; i < ncpus; i++) {
> > > +                       cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, i).cpu;
> > > +                       bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
> >
> > Perhaps more concise with a for_each:
> >
> > perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.user_requested_cpus)
> >   bpf_map_update_elem(fd, &cpu.cpu, &val, BPF_ANY);

So I'll wait for a new version of this patchset.

- Arnaldo
