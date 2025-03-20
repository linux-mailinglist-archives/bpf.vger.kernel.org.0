Return-Path: <bpf+bounces-54433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5BA69FA7
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 07:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1712C463D43
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 06:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61551E2611;
	Thu, 20 Mar 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtC3mOq7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64893B665;
	Thu, 20 Mar 2025 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450831; cv=none; b=D9u9ohp+UAaNZsjPliqKbjjcZ0JrVt04WyYtD2oNZQ5PA975GTicvvJhpuIopI9lLWpWw3p1ji5jK462gMnZZEVCZEM3rLNShQT9rRdDZ/Dy3Ru1gqVt2DW+QHK4YIsvzyVxlybdHuJ+cPc6vSLohdoqE5DFHx4ZXeKlnIwzOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450831; c=relaxed/simple;
	bh=y42tfYRNQtlgFMEioPDHQXwEXpp6R+jEdrTlzzdzr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9W8IrMdpatG12gsUyxtfK3S/jgFiSnA7TlGZyrMp7BLpYsReCiqGW9NK8kN5ikldmKsszmYF9ADN99AONGLN3iUYrJ92q0M7orqUCvQL95OFbmtYK8c/X+8JlswucHLc6HnoNUB1KPk3HsF530PIizPnwWhMz6mDR+LEi7znO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtC3mOq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E08DC4CEDD;
	Thu, 20 Mar 2025 06:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742450830;
	bh=y42tfYRNQtlgFMEioPDHQXwEXpp6R+jEdrTlzzdzr1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtC3mOq7FcLVmomYxV9SODlOj3I2hV3th3mklyAAEAgihKuRqlh6wM0aHt8BCCdKb
	 8v5Mq0ojGiZU3qJ+E8fxBpyll6kx7elFYLy329wPsuDkSytgcyl2Eao0REYNSrmowO
	 A5vhQy01DJKKeRqgDG1pzbo5GYleW0kBE7dkhwoVRI9YwUT049PZ8K8kzv+0yYe79D
	 siosfx1C4EGFsE240N8k7q5DADHyid/a2fZk9u7DGuOO7UqsGKREfXixAGkj1YCQju
	 dewXIhHSgNv4Z3lUjVXt0lTqlvRfVeltAQOJyfkcqZV2PE4QHQvfwGhJup5CBlp7nR
	 Qt71Yvy5zutTA==
Date: Wed, 19 Mar 2025 23:07:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>, Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
Message-ID: <Z9uwjE_U2cngKblZ@google.com>
References: <20250317180834.1862079-1-namhyung@kernel.org>
 <CAP-5=fWW=9WboQ0_MJx1pYeUTNSC0FNmyeTzw40+Q-mw+TreeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWW=9WboQ0_MJx1pYeUTNSC0FNmyeTzw40+Q-mw+TreeA@mail.gmail.com>

On Mon, Mar 17, 2025 at 11:37:22AM -0700, Ian Rogers wrote:
> On Mon, Mar 17, 2025 at 11:08 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When -s/--summary option is used, it doesn't need (augmented) arguments
> > of syscalls.  Let's skip the augmentation and load another small BPF
> > program to collect the statistics in the kernel instead of copying the
> > data to the ring-buffer to calculate the stats in userspace.  This will
> > be much more light-weight than the existing approach and remove any lost
> > events.
> >
> > Let's add a new option --bpf-summary to control this behavior.  I cannot
> > make it default because there's no way to get e_machine in the BPF which
> > is needed for detecting different ABIs like 32-bit compat mode.
> >
> > No functional changes intended except for no more LOST events. :)
> >
> >   $ sudo perf trace -as --bpf-summary --summary-mode=total -- sleep 1
> >
> >    Summary of events:
> >
> >    total, 2824 events
> >
> >      syscall            calls  errors  total       min       avg       max       stddev
> >                                        (msec)    (msec)    (msec)    (msec)        (%)
> >      --------------- --------  ------ -------- --------- --------- ---------     ------
> >      futex                372     18  4373.773     0.000    11.757   997.715    660.42%
> >      poll                 241      0  2757.963     0.000    11.444   997.758    580.34%
> >      epoll_wait           161      0  2460.854     0.000    15.285   325.189    260.73%
> >      ppoll                 19      0  1298.652     0.000    68.350   667.172    281.46%
> >      clock_nanosleep        1      0  1000.093     0.000  1000.093  1000.093      0.00%
> >      epoll_pwait           16      0   192.787     0.000    12.049   173.994    348.73%
> >      nanosleep              6      0    50.926     0.000     8.488    10.210     43.96%
> >      ...
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v2)
> >  * rebased on top of Ian's e_machine changes
> >  * add --bpf-summary option
> >  * support per-thread summary
> >  * add stddev calculation  (Howard)
> >
> >  tools/perf/Documentation/perf-trace.txt       |   6 +
> >  tools/perf/Makefile.perf                      |   2 +-
> >  tools/perf/builtin-trace.c                    |  43 ++-
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/bpf-trace-summary.c           | 334 ++++++++++++++++++
> >  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 118 +++++++
> >  tools/perf/util/bpf_skel/syscall_summary.h    |  25 ++
> >  tools/perf/util/trace.h                       |  37 ++
> >  8 files changed, 553 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/perf/util/bpf-trace-summary.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
> >  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
> >  create mode 100644 tools/perf/util/trace.h
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> > index 887dc37773d0f4d6..a8a0d8c33438fef7 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -251,6 +251,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
> >         pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
> >         better pretty-print integer flags and struct pointers.
> >
> > +--bpf-summary::
> > +       Collect system call statistics in BPF.  This is only for live mode and
> > +       works well with -s/--summary option where no argument information is
> > +       required.
> > +
> > +
> >  PAGEFAULTS
> >  ----------
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f3cd8de15d1a2681..d7a7e0c68fc10b8b 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1206,7 +1206,7 @@ SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> >  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
> >  SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
> >  SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
> > -SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
> > +SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
> >  SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
> >  SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 7fef59306db2891f..deeb7250e8c52354 100644
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
> > @@ -141,12 +142,6 @@ struct syscall_fmt {
> >         bool       hexret;
> >  };
> >
> > -enum summary_mode {
> > -       SUMMARY__NONE = 0,
> > -       SUMMARY__BY_TOTAL,
> > -       SUMMARY__BY_THREAD,
> > -};
> > -
> >  struct trace {
> >         struct perf_tool        tool;
> >         struct {
> > @@ -205,7 +200,7 @@ struct trace {
> >         } stats;
> >         unsigned int            max_stack;
> >         unsigned int            min_stack;
> > -       enum summary_mode       summary_mode;
> > +       enum trace_summary_mode summary_mode;
> >         int                     raw_augmented_syscalls_args_size;
> >         bool                    raw_augmented_syscalls;
> >         bool                    fd_path_disabled;
> > @@ -234,6 +229,7 @@ struct trace {
> >         bool                    force;
> >         bool                    vfs_getname;
> >         bool                    force_btf;
> > +       bool                    summary_bpf;
> >         int                     trace_pgfaults;
> >         char                    *perfconfig_events;
> >         struct {
> > @@ -4356,6 +4352,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >
> >         trace->live = true;
> >
> > +       if (trace->summary_bpf) {
> > +               if (trace_prepare_bpf_summary(trace->summary_mode) < 0)
> > +                       goto out_delete_evlist;
> > +
> > +               goto create_maps;
> > +       }
> > +
> >         if (!trace->raw_augmented_syscalls) {
> >                 if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> >                         goto out_error_raw_syscalls;
> > @@ -4414,6 +4417,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         if (trace->cgroup)
> >                 evlist__set_default_cgroup(trace->evlist, trace->cgroup);
> >
> > +create_maps:
> >         err = evlist__create_maps(evlist, &trace->opts.target);
> >         if (err < 0) {
> >                 fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
> > @@ -4426,7 +4430,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >                 goto out_delete_evlist;
> >         }
> >
> > -       if (trace->summary_mode == SUMMARY__BY_TOTAL) {
> > +       if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
> >                 trace->syscall_stats = alloc_syscall_stats();
> >                 if (trace->syscall_stats == NULL)
> >                         goto out_delete_evlist;
> > @@ -4512,9 +4516,11 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
> > @@ -4527,6 +4533,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >                 evlist__enable(evlist);
> >         }
> >
> > +       if (trace->summary_bpf)
> > +               trace_start_bpf_summary();
> > +
> >         trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
> >                 perf_thread_map__nr(evlist->core.threads) > 1 ||
> >                 evlist__first(evlist)->core.attr.inherit;
> > @@ -4594,12 +4603,17 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
> > +                               trace_print_bpf_summary(trace->output);
> > +                       else if (trace->summary_mode == SUMMARY__BY_TOTAL)
> >                                 trace__fprintf_total_summary(trace, trace->output);
> >                         else
> >                                 trace__fprintf_thread_summary(trace, trace->output);
> > @@ -4615,6 +4629,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         }
> >
> >  out_delete_evlist:
> > +       trace_cleanup_bpf_summary();
> >         delete_syscall_stats(trace->syscall_stats);
> >         trace__symbols__exit(trace);
> >         evlist__free_syscall_tp_fields(evlist);
> > @@ -5444,6 +5459,7 @@ int cmd_trace(int argc, const char **argv)
> >                      "start"),
> >         OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
> >                        "to customized ones"),
> > +       OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
> >         OPTS_EVSWITCH(&trace.evswitch),
> >         OPT_END()
> >         };
> > @@ -5535,6 +5551,9 @@ int cmd_trace(int argc, const char **argv)
> >                 goto skip_augmentation;
> >         }
> >
> > +       if (trace.summary_only && trace.summary_bpf)
> > +               goto skip_augmentation;
> > +
> >         trace.skel = augmented_raw_syscalls_bpf__open();
> >         if (!trace.skel) {
> >                 pr_debug("Failed to open augmented syscalls BPF skeleton");
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
> > index 0000000000000000..5ae9feca244d5b22
> > --- /dev/null
> > +++ b/tools/perf/util/bpf-trace-summary.c
> > @@ -0,0 +1,334 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <inttypes.h>
> > +#include <math.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include "dwarf-regs.h" /* for EM_HOST */
> > +#include "syscalltbl.h"
> > +#include "util/hashmap.h"
> > +#include "util/trace.h"
> > +#include "util/util.h"
> > +#include <bpf/bpf.h>
> > +#include <linux/time64.h>
> > +#include <tools/libc_compat.h> /* reallocarray */
> > +
> > +#include "bpf_skel/syscall_summary.h"
> > +#include "bpf_skel/syscall_summary.skel.h"
> > +
> > +
> > +static struct syscall_summary_bpf *skel;
> > +
> > +int trace_prepare_bpf_summary(enum trace_summary_mode mode)
> > +{
> > +       skel = syscall_summary_bpf__open();
> > +       if (skel == NULL) {
> > +               fprintf(stderr, "failed to open syscall summary bpf skeleton\n");
> > +               return -1;
> > +       }
> > +
> > +       if (mode == SUMMARY__BY_THREAD)
> > +               skel->rodata->aggr_mode = SYSCALL_AGGR_THREAD;
> > +       else
> > +               skel->rodata->aggr_mode = SYSCALL_AGGR_CPU;
> > +
> > +       if (syscall_summary_bpf__load(skel) < 0) {
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
> > +struct syscall_node {
> > +       int syscall_nr;
> > +       struct syscall_stats stats;
> > +};
> > +
> > +static double rel_stddev(struct syscall_stats *stat)
> > +{
> > +       double variance, average;
> > +
> > +       if (stat->count < 2)
> > +               return 0;
> > +
> > +       average = (double)stat->total_time / stat->count;
> > +
> > +       variance = stat->squared_sum;
> > +       variance -= (stat->total_time * stat->total_time) / stat->count;
> > +       variance /= stat->count;
> > +
> > +       return 100 * sqrt(variance) / average;
> > +}
> > +
> > +struct syscall_data {
> > +       int key; /* tid if AGGR_THREAD, syscall-nr if AGGR_CPU */
> > +       int nr_events;
> > +       int nr_nodes;
> > +       u64 total_time;
> > +       struct syscall_node *nodes;
> > +};
> > +
> > +static int datacmp(const void *a, const void *b)
> > +{
> > +       const struct syscall_data * const *sa = a;
> > +       const struct syscall_data * const *sb = b;
> > +
> > +       return (*sa)->total_time > (*sb)->total_time ? -1 : 1;
> > +}
> > +
> > +static int nodecmp(const void *a, const void *b)
> > +{
> > +       const struct syscall_node *na = a;
> > +       const struct syscall_node *nb = b;
> > +
> > +       return na->stats.total_time > nb->stats.total_time ? -1 : 1;
> > +}
> > +
> > +static size_t sc_node_hash(long key, void *ctx __maybe_unused)
> > +{
> > +       return key;
> > +}
> > +
> > +static bool sc_node_equal(long key1, long key2, void *ctx __maybe_unused)
> > +{
> > +       return key1 == key2;
> > +}
> > +
> > +static int print_common_stats(struct syscall_data *data, FILE *fp)
> > +{
> > +       int printed = 0;
> > +
> > +       for (int i = 0; i < data->nr_nodes; i++) {
> > +               struct syscall_node *node = &data->nodes[i];
> > +               struct syscall_stats *stat = &node->stats;
> > +               double total = (double)(stat->total_time) / NSEC_PER_MSEC;
> > +               double min = (double)(stat->min_time) / NSEC_PER_MSEC;
> > +               double max = (double)(stat->max_time) / NSEC_PER_MSEC;
> > +               double avg = total / stat->count;
> > +               const char *name;
> > +
> > +               /* TODO: support other ABIs */
> > +               name = syscalltbl__name(EM_HOST, node->syscall_nr);
> > +               if (name)
> > +                       printed += fprintf(fp, "   %-15s", name);
> > +               else
> > +                       printed += fprintf(fp, "   syscall:%-7d", node->syscall_nr);
> > +
> > +               printed += fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3f %9.2f%%\n",
> > +                                  stat->count, stat->error, total, min, avg, max,
> > +                                  rel_stddev(stat));
> > +       }
> > +       return printed;
> > +}
> > +
> > +static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key,
> > +                              struct syscall_stats *map_data)
> > +{
> > +       struct syscall_data *data;
> > +       struct syscall_node *nodes;
> > +
> > +       if (!hashmap__find(hash, map_key->cpu_or_tid, &data)) {
> > +               data = zalloc(sizeof(*data));
> > +               if (data == NULL)
> > +                       return -ENOMEM;
> > +
> > +               data->key = map_key->cpu_or_tid;
> > +               if (hashmap__add(hash, data->key, data) < 0) {
> > +                       free(data);
> > +                       return -ENOMEM;
> > +               }
> > +       }
> > +
> > +       /* update thread total stats */
> > +       data->nr_events += map_data->count;
> > +       data->total_time += map_data->total_time;
> > +
> > +       nodes = reallocarray(data->nodes, data->nr_nodes + 1, sizeof(*nodes));
> > +       if (nodes == NULL)
> > +               return -ENOMEM;
> > +
> > +       data->nodes = nodes;
> > +       nodes = &data->nodes[data->nr_nodes++];
> > +       nodes->syscall_nr = map_key->nr;
> > +
> > +       /* each thread has an entry for each syscall, just use the stat */
> > +       memcpy(&nodes->stats, map_data, sizeof(*map_data));
> > +       return 0;
> > +}
> > +
> > +static int print_thread_stat(struct syscall_data *data, FILE *fp)
> > +{
> > +       int printed = 0;
> > +
> > +       qsort(data->nodes, data->nr_nodes, sizeof(*data->nodes), nodecmp);
> > +
> > +       printed += fprintf(fp, " thread (%d), ", data->key);
> > +       printed += fprintf(fp, "%d events\n\n", data->nr_events);
> > +
> > +       printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
> > +       printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> > +       printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> 
> The code lgtm and follows the code base's conventions but it seems odd
> to put very specific output like this inside of util/ rather than
> builtin-trace.c. stat-display.c is similar, it just seems the boundary
> between util/ and the buitin-*.c files is blurry.

I see your point and totally agree.  Ideally the print code should be
in the builtin-trace.c and this file contains BPF related parts only.

But it requires more refactoring to clearly separate logic that can be
shared in the util/ code.  Currently this code is large and hard to
factor out some parts.  I think we need to move many code to util/.

Maybe I can work on it in the near future to add more changes to perf
trace.  But for now I'd like to make this change small and independent
as much as possible.  Is it ok to you?

Thanks,
Namhyung


