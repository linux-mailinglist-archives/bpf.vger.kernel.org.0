Return-Path: <bpf+bounces-54114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80FA632F9
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 01:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80183B26A0
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0B4C96;
	Sun, 16 Mar 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtbyepfA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245033F7;
	Sun, 16 Mar 2025 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742084613; cv=none; b=lh28mrT5sQEFaux4baQ/ODoWw+PDWVQ/CIP6nNbzCVcwAs6nwfueZ+TH2B5xzER1/n7uix3eBOFY5GvJvsGz641wN5MY5LZaPOJmJP/7fbzAEHhytpaj4UG3uMMA+UJ0iB1P4E1cGQSYkrptV3gqzrcSCx3zH+TV8YPHxmzBXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742084613; c=relaxed/simple;
	bh=2fNZ+b2Z69Y7dx+fBPulqiQfdI+4Ngrx1XD1ZN4+vZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihVmLQhYLRccj2T0kG4aWmyeVGOEaUugYkrBghhP29j6fCx4Dpy1dLfMQ1vm48ye3yuYsGgoKefxJCcqmhzXUzotXbkKoyi+2J5+U92CX+0l4Sxe52ya5v2IizVFPZNyicj0Nsy1OJcJM567OQGK3SKINnzbX82sYog5K4n9e4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtbyepfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED57C4CEE5;
	Sun, 16 Mar 2025 00:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742084612;
	bh=2fNZ+b2Z69Y7dx+fBPulqiQfdI+4Ngrx1XD1ZN4+vZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtbyepfAEPoG2EWm1S5UxkODHY6GQ3MXW/RQ/HkWQACLc6C7EvCK/KRF7EWkCE0zJ
	 Xp62Hvl9SAtepaiDr/QuYI7YMQ4SfZqtC0M1qt9fWkAfMgZ++MGkuZWBjGZNnx3UXL
	 O3egwwN5zYMjSoDXefh5+TgGnlVxSfYxLalvJxiA+ZXFsSNQNUsfteb2pMz2tmM1FR
	 NoOkEl2a5qj2e87HacPpMb0Wmrpm/MUMIGIOrridNy6zrIvJ/pv+xbVLmeWgc1zJku
	 SqvXyN2hbTezn76Utuz0PVHytuiYCWhENid4KHlwpVDAiObuWPIhk6Vd/e90C4Yez0
	 sCqlWNyCGfx9w==
Date: Sat, 15 Mar 2025 17:23:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] perf trace: Implement syscall summary in BPF
Message-ID: <Z9YaApKiGTkuudi8@google.com>
References: <20250221183207.560262-1-namhyung@kernel.org>
 <CAH0uvoi0fqm-jJcw2VtLwHbSrcKUq__UW82oCMLaKEH7Fz-zhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoi0fqm-jJcw2VtLwHbSrcKUq__UW82oCMLaKEH7Fz-zhQ@mail.gmail.com>

Hello Howard,

On Thu, Mar 06, 2025 at 05:57:33PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> Sorry for replying this crazy late, flu got me good last week...

I'm also late. :)  Hope you are well now.

> 
> On Fri, Feb 21, 2025 at 10:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When --summary-only option is used, it doesn't need (augmented) arguments
> > of syscalls.  Let's skip the augmentation and load another small BPF
> > program to collect the statistics in the kernel instead of copying the
> > data to the ring-buffer to calculate the stats in userspace.  This will
> > be much more light-weight than the existing approach and remove any lost
> > events.
> 
> Yep, awesome idea, 100% agree. That's how the summary mode should be
> written, so cool :)
> 
> >
> > For simplicity, it's only activated with --summary-mode=total in system-
> > wide mode.  And it also skips to calculate stddev as doing it atomically
> > would add more overheads (i.e. requiring a spinlock).  It can be extended
> > to cover more use cases later, if needed.
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Makefile.perf                      |   2 +-
> >  tools/perf/builtin-trace.c                    |  41 ++++--
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/bpf-trace-summary.c           | 117 ++++++++++++++++++
> >  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 109 ++++++++++++++++
> >  tools/perf/util/bpf_skel/syscall_summary.h    |  18 +++
> >  tools/perf/util/trace.h                       |  31 +++++
> >  7 files changed, 311 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/perf/util/bpf-trace-summary.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
> >  create mode 100644 tools/perf/util/trace.h
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 55d6ce9ea52fb2a5..3b68a57682ca991d 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1198,7 +1198,7 @@ SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> >  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
> >  SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
> >  SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
> > -SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
> > +SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
> >  SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
> >  SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f55a8a6481f27f99..1c7af7583bc560c4 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -55,6 +55,7 @@
> >  #include "util/thread_map.h"
> >  #include "util/stat.h"
> >  #include "util/tool.h"
> > +#include "util/trace.h"
> >  #include "util/util.h"
> >  #include "trace/beauty/beauty.h"
> >  #include "trace-event.h"
> > @@ -222,6 +223,7 @@ struct trace {
> >         bool                    force;
> >         bool                    vfs_getname;
> >         bool                    force_btf;
> > +       bool                    summary_bpf;
> >         int                     trace_pgfaults;
> >         char                    *perfconfig_events;
> >         struct {
> > @@ -4276,6 +4278,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >
> >         trace->live = true;
> >
> > +       if (trace->summary_bpf) {
> > +               if (trace_prepare_bpf_summary() < 0)
> > +                       goto out_delete_evlist;
> > +
> > +               goto create_maps;
> > +       }
> > +
> >         if (!trace->raw_augmented_syscalls) {
> >                 if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> >                         goto out_error_raw_syscalls;
> > @@ -4334,6 +4343,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         if (trace->cgroup)
> >                 evlist__set_default_cgroup(trace->evlist, trace->cgroup);
> >
> > +create_maps:
> >         err = evlist__create_maps(evlist, &trace->opts.target);
> >         if (err < 0) {
> >                 fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
> > @@ -4426,9 +4436,11 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         if (err < 0)
> >                 goto out_error_apply_filters;
> >
> > -       err = evlist__mmap(evlist, trace->opts.mmap_pages);
> > -       if (err < 0)
> > -               goto out_error_mmap;
> > +       if (!trace->summary_bpf) {
> > +               err = evlist__mmap(evlist, trace->opts.mmap_pages);
> > +               if (err < 0)
> > +                       goto out_error_mmap;
> > +       }
> >
> >         if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
> >                 evlist__enable(evlist);
> 
> I think if summary_bpf is true we don't need to enable the evlist
> either, but we can leave it here.

Probably.  I think I just wanted to make minimal changes to the existing
code if possible.

> 
> > @@ -4441,6 +4453,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >                 evlist__enable(evlist);
> >         }
> >
> > +       if (trace->summary_bpf)
> > +               trace_start_bpf_summary();
> > +
> >         trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
> >                 perf_thread_map__nr(evlist->core.threads) > 1 ||
> >                 evlist__first(evlist)->core.attr.inherit;
> > @@ -4508,12 +4523,17 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >
> >         evlist__disable(evlist);
> >
> > +       if (trace->summary_bpf)
> > +               trace_end_bpf_summary();
> > +
> >         if (trace->sort_events)
> >                 ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
> >
> >         if (!err) {
> >                 if (trace->summary) {
> > -                       if (trace->summary_mode == SUMMARY__BY_TOTAL)
> > +                       if (trace->summary_bpf)
> > +                               trace_print_bpf_summary(trace->sctbl, trace->output);
> > +                       else if (trace->summary_mode == SUMMARY__BY_TOTAL)
> >                                 trace__fprintf_total_summary(trace, trace->output);
> >                         else
> >                                 trace__fprintf_thread_summary(trace, trace->output);
> > @@ -4529,6 +4549,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         }
> >
> >  out_delete_evlist:
> > +       trace_cleanup_bpf_summary();
> >         delete_syscall_stats(trace->syscall_stats);
> >         trace__symbols__exit(trace);
> >         evlist__free_syscall_tp_fields(evlist);
> > @@ -5446,6 +5467,15 @@ int cmd_trace(int argc, const char **argv)
> >                 goto skip_augmentation;
> >         }
> >
> > +       if (!argc && target__none(&trace.opts.target))
> > +               trace.opts.target.system_wide = true;
> > +
> > +       if (trace.summary_only && trace.opts.target.system_wide &&
> > +           trace.summary_mode == SUMMARY__BY_TOTAL && !trace.trace_pgfaults) {
> 
> I feel like trace_pgfaults can coexist with the BPF summary, but I'm
> fine with the current logic.
> 
> BTW, this part of the code can be confusing; You covered a case where:
> sudo ./perf trace -s --summary-mode=total -F all -a --syscall
> is handled properly. Because normally when doing
> sudo ./perf trace -s --summary-mode=total -F all -a
> without the --syscall option, perf trace won't even get to this point,
> it will skip augmentation from here:
> if (!trace.trace_syscalls)
>         goto skip_augmentation;
> 
> So, good work!

I feel like I'd add an option to turn it on explicitly and support
per-task summary as well.

Maybe something like --bpf-summary?

> 
> > +               trace.summary_bpf = true;
> > +               goto skip_augmentation;
> > +       }
> > +
> >         trace.skel = augmented_raw_syscalls_bpf__open();
> >         if (!trace.skel) {
> >                 pr_debug("Failed to open augmented syscalls BPF skeleton");
> > @@ -5649,9 +5679,6 @@ int cmd_trace(int argc, const char **argv)
> >                 goto out_close;
> >         }
> >
> > -       if (!argc && target__none(&trace.opts.target))
> > -               trace.opts.target.system_wide = true;
> > -
> >         if (input_name)
> >                 err = trace__replay(&trace);
> >         else
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 034a6603d5a8e8b0..ba4201a6f3c69753 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -171,6 +171,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
> >  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
> >  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
> >  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
> > +perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
> >  perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
> >
> >  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> > diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
> > new file mode 100644
> > index 0000000000000000..7e8b1c9b3faeee4f
> > --- /dev/null
> > +++ b/tools/perf/util/bpf-trace-summary.c
> > @@ -0,0 +1,117 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <inttypes.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include "syscalltbl.h"
> > +#include "util/trace.h"
> > +#include "util/util.h"
> > +#include <bpf/bpf.h>
> > +#include <linux/time64.h>
> > +
> > +#include "bpf_skel/syscall_summary.h"
> > +#include "bpf_skel/syscall_summary.skel.h"
> > +
> > +
> > +static struct syscall_summary_bpf *skel;
> > +
> > +int trace_prepare_bpf_summary(void)
> > +{
> > +       skel = syscall_summary_bpf__open_and_load();
> > +       if (skel == NULL) {
> > +               fprintf(stderr, "failed to load syscall summary bpf skeleton\n");
> > +               return -1;
> > +       }
> > +
> > +       if (syscall_summary_bpf__attach(skel) < 0) {
> > +               fprintf(stderr, "failed to attach syscall summary bpf skeleton\n");
> > +               return -1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +void trace_start_bpf_summary(void)
> > +{
> > +       skel->bss->enabled = 1;
> > +}
> > +
> > +void trace_end_bpf_summary(void)
> > +{
> > +       skel->bss->enabled = 0;
> > +}
> > +
> > +struct syscall_data {
> > +       int syscall_nr;
> > +       struct syscall_stats stats;
> > +};
> > +
> > +static int datacmp(const void *a, const void *b)
> > +{
> > +       const struct syscall_data *sa = a;
> > +       const struct syscall_data *sb = b;
> > +
> > +       return sa->stats.total_time > sb->stats.total_time ? -1 : 1;
> > +}
> > +
> > +int trace_print_bpf_summary(struct syscalltbl *sctbl, FILE *fp)
> > +{
> > +       struct syscall_key *prev_key, key;
> > +       struct syscall_data *data = NULL;
> > +       struct bpf_map *map = skel->maps.syscall_stats_map;
> > +       int nr_data = 0;
> > +       int printed = 0;
> > +
> > +       /* get stats from the bpf map */
> > +       prev_key = NULL;
> > +       while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key))) {
> > +               struct syscall_stats stat;
> > +
> > +               if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, sizeof(stat), 0)) {
> > +                       struct syscall_data *tmp, *pos;
> > +
> > +                       tmp = realloc(data, sizeof(*data) * (nr_data + 1));
> > +                       if (tmp == NULL)
> > +                               break;
> > +
> > +                       data = tmp;
> > +                       pos = &data[nr_data++];
> > +
> > +                       pos->syscall_nr = key.nr;
> > +                       memcpy(&pos->stats, &stat, sizeof(stat));
> > +               }
> > +
> > +               prev_key = &key;
> > +       }
> > +
> > +       qsort(data, nr_data, sizeof(*data), datacmp);
> > +
> > +       printed += fprintf(fp, "\n");
> > +
> > +       printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
> > +       printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> > +       printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> > +
> > +       for (int i = 0; i < nr_data; i++) {
> > +               struct syscall_data *pos = &data[i];
> > +               double total = (double)(pos->stats.total_time) / NSEC_PER_MSEC;
> > +               double min = (double)(pos->stats.min_time) / NSEC_PER_MSEC;
> > +               double max = (double)(pos->stats.max_time) / NSEC_PER_MSEC;
> > +               double avg = total / pos->stats.count;
> > +
> > +               printed += fprintf(fp, "   %-15s", syscalltbl__name(sctbl, pos->syscall_nr));
> > +               printed += fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3f %9.2f%%\n",
> > +                                  pos->stats.count, pos->stats.error, total, min, avg, max,
> > +                                  /*stddev=*/0.0);
> 
> Assuming the performance downfall comes from libc's sqrt(), isn't it
> calculated only after collecting all the data? And don't we have at
> most nr_data records to process? I fail to understand how they "add
> more overheads", can you please explain?

I thought we should do the same with update_stats() in util/stat.c
and do the rest of calculation for stddev in userspace.

    void update_stats(struct stats *stats, u64 val)
    {
            double delta;
    
            stats->n++;
            delta = val - stats->mean;
            stats->mean += delta / stats->n;
            stats->M2 += delta*(val - stats->mean);
    
            if (val > stats->max)
                    stats->max = val;
    
            if (val < stats->min)
                    stats->min = val;
    }

Then I thought n, mean and M2 should be protected in a lock.
But it may be ok to allow small inaccuracies without locks.
I'll update it.

> 
> > +       }
> > +
> > +       printed += fprintf(fp, "\n\n");
> > +       free(data);
> > +
> > +       return printed;
> > +}
> > +
> > +void trace_cleanup_bpf_summary(void)
> > +{
> > +       syscall_summary_bpf__destroy(skel);
> > +}
> > diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> > new file mode 100644
> > index 0000000000000000..e573ce39de73eaf3
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Trace raw_syscalls tracepoints to collect system call statistics.
> > + */
> > +
> > +#include "vmlinux.h"
> > +#include "syscall_summary.h"
> > +
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +/* This is to calculate a delta between sys-enter and sys-exit for each thread */
> > +struct syscall_trace {
> > +       int nr; /* syscall number is only available at sys-enter */
> > +       int unused;
> > +       u64 timestamp;
> > +};
> > +
> > +#define MAX_ENTRIES    (16 * 1024)
> > +
> > +struct syscall_trace_map {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __type(key, int); /* tid */
> > +       __type(value, struct syscall_trace);
> > +       __uint(max_entries, MAX_ENTRIES);
> > +} syscall_trace_map SEC(".maps");
> > +
> > +struct syscall_stats_map {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __type(key, struct syscall_key);
> > +       __type(value, struct syscall_stats);
> > +       __uint(max_entries, MAX_ENTRIES);
> > +} syscall_stats_map SEC(".maps");
> > +
> > +int enabled; /* controlled from userspace */
> > +
> > +static void update_stats(int nr, s64 duration, long ret)
> > +{
> > +       struct syscall_key key = { .nr = nr, };
> > +       struct syscall_stats *stats;
> > +
> > +       stats = bpf_map_lookup_elem(&syscall_stats_map, &key);
> > +       if (stats == NULL) {
> > +               struct syscall_stats zero = {};
> > +
> > +               bpf_map_update_elem(&syscall_stats_map, &key, &zero, BPF_NOEXIST);
> > +               stats = bpf_map_lookup_elem(&syscall_stats_map, &key);
> > +               if (stats == NULL)
> > +                       return;
> > +       }
> > +
> > +       __sync_fetch_and_add(&stats->count, 1);
> > +       if (ret < 0)
> > +               __sync_fetch_and_add(&stats->error, 1);
> > +
> > +       if (duration > 0) {
> > +               __sync_fetch_and_add(&stats->total_time, duration);
> > +               if (stats->max_time < duration)
> > +                       stats->max_time = duration;
> > +               if (stats->min_time > duration || stats->min_time == 0)
> > +                       stats->min_time = duration;
> > +       }
> > +
> > +       return;
> > +}
> > +
> > +SEC("tp_btf/sys_enter")
> > +int sys_enter(u64 *ctx)
> > +{
> > +       int tid;
> > +       struct syscall_trace st;
> > +
> > +       if (!enabled)
> > +               return 0;
> > +
> > +       st.nr = ctx[1]; /* syscall number */
> > +       st.unused = 0;
> > +       st.timestamp = bpf_ktime_get_ns();
> > +
> > +       tid = bpf_get_current_pid_tgid();
> > +       bpf_map_update_elem(&syscall_trace_map, &tid, &st, BPF_ANY);
> > +
> > +       return 0;
> > +}
> > +
> > +SEC("tp_btf/sys_exit")
> > +int sys_exit(u64 *ctx)
> > +{
> > +       int tid;
> > +       long ret = ctx[1]; /* return value of the syscall */
> > +       struct syscall_trace *st;
> > +       s64 delta;
> > +
> > +       if (!enabled)
> > +               return 0;
> > +
> > +       tid = bpf_get_current_pid_tgid();
> > +       st = bpf_map_lookup_elem(&syscall_trace_map, &tid);
> > +       if (st == NULL)
> > +               return 0;
> > +
> > +       delta = bpf_ktime_get_ns() - st->timestamp;
> 
> Do you think we can do bpf_ktime_get_ns() a little earlier, say before
> bpf_map_lookup_elem()? Although the difference will be tiny...

Right, also it'd be unnecessary if the lookup returns nothing.

Thanks,
Namhyung

> 
> 
> > +       update_stats(st->nr, delta, ret);
> > +
> > +       bpf_map_delete_elem(&syscall_trace_map, &tid);
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > diff --git a/tools/perf/util/bpf_skel/syscall_summary.h b/tools/perf/util/bpf_skel/syscall_summary.h
> > new file mode 100644
> > index 0000000000000000..644dc7049377147e
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/syscall_summary.h
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/* Data structures shared between BPF and tools. */
> > +#ifndef UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
> > +#define UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
> > +
> > +struct syscall_key {
> > +       int nr;
> > +};
> > +
> > +struct syscall_stats {
> > +       u64 total_time;
> > +       u64 max_time;
> > +       u64 min_time;
> > +       u32 count;
> > +       u32 error;
> > +};
> > +
> > +#endif /* UTIL_BPF_SKEL_SYSCALL_SUMMARY_H */
> > diff --git a/tools/perf/util/trace.h b/tools/perf/util/trace.h
> > new file mode 100644
> > index 0000000000000000..4d7a7c4544d94caf
> > --- /dev/null
> > +++ b/tools/perf/util/trace.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef UTIL_TRACE_H
> > +#define UTIL_TRACE_H
> > +
> > +#include <stdio.h>  /* for FILE */
> > +
> > +struct syscalltbl;
> > +
> > +#ifdef HAVE_BPF_SKEL
> > +
> > +int trace_prepare_bpf_summary(void);
> > +void trace_start_bpf_summary(void);
> > +void trace_end_bpf_summary(void);
> > +int trace_print_bpf_summary(struct syscalltbl *sctbl, FILE *fp);
> > +void trace_cleanup_bpf_summary(void);
> > +
> > +#else /* !HAVE_BPF_SKEL */
> > +
> > +static inline int trace_prepare_bpf_summary(void) { return -1; }
> > +static inline void trace_start_bpf_summary(void) {}
> > +static inline void trace_end_bpf_summary(void) {}
> > +static inline int trace_print_bpf_summary(struct syscalltbl *sctbl __maybe_unused,
> > +                                         FILE *fp __maybe_unused)
> > +{
> > +       return 0;
> > +}
> > +static inline void trace_cleanup_bpf_summary(void) {}
> > +
> > +#endif /* HAVE_BPF_SKEL */
> > +
> > +#endif /* UTIL_TRACE_H */
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
> 
> Awesome patch :)
> 
> Thanks,
> Howard

