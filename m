Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1E52DEE0
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbiESVBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiESVBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:01:39 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB45AED5;
        Thu, 19 May 2022 14:01:37 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-e656032735so8301215fac.0;
        Thu, 19 May 2022 14:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mg4aRwtCWBKuSpJ0kAPCOFYSSlZHU27vIjDdyk4uSkk=;
        b=PemdctjYAQkQogTosn70+ZBivJr7tlh1o0//reKzAhqTetaZbZL2Epg/iRGHPhaQV6
         DBQFucrVxUcYDeqqlol9Xhctrc8m3rojeyWrJRV5YygumlYZM3KNifk1LVPmF9IriIOD
         ttomdL/9cJuy36zErNFCvQeKhoELU7CvvPZoq3J6bYmHRrrs0yIo1ekjohzH0pH8V0vY
         bt+MZC0BbSnw3fmpAbxJkPxyhN/fnIO76phkJVfCitWnqRJMLM9lh/cB0a5ViF8OKNCB
         FSOPcEPe3kCX6xinauHQ2FhLkxXrTr6gkd7cxfm1mWCdk5mSizLU990XAGm3KfGt8irT
         4gIA==
X-Gm-Message-State: AOAM530DFA7rs0iR5aUplIFd6oB3FI6U1TI5TMaWtuGniwCuTWDUDRQS
        0p2BwojCJtHN2+Sm8QzNM4xeFBbGASgn507+Cj01O4UO
X-Google-Smtp-Source: ABdhPJxCBxMq0n0yIgRyJUcpnYzF9jlcKxf65rb5RnNqGMPqgqyD9mXq9zmmZ7G4IhqAMT6aIMNZPB55LRYAurB99lQ=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr3789717oad.92.1652994097085; Thu, 19
 May 2022 14:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-3-namhyung@kernel.org>
 <CAP-5=fXenfuYZ-ArxDjt7OY7Z+KHJ8fL+ewOUo+9Uno0E=k0pw@mail.gmail.com>
In-Reply-To: <CAP-5=fXenfuYZ-ArxDjt7OY7Z+KHJ8fL+ewOUo+9Uno0E=k0pw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 May 2022 14:01:25 -0700
Message-ID: <CAM9d7cgB-iw0phVTb9EH5ps=1+PQM5nU1fTLMfQx=Kj31W-8Jw@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf record: Enable off-cpu analysis with BPF
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Wed, May 18, 2022 at 8:58 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add --off-cpu option to enable the off-cpu profiling with BPF.  It'd
> > use a bpf_output event and rename it to "offcpu-time".  Samples will
> > be synthesized at the end of the record session using data from a BPF
> > map which contains the aggregated off-cpu time at context switches.
> > So it needs root privilege to get the off-cpu profiling.
> >
> > Each sample will have a separate user stacktrace so it will skip
> > kernel threads.  The sample ip will be set from the stacktrace and
> > other sample data will be updated accordingly.  Currently it only
> > handles some basic sample types.
> >
> > The sample timestamp is set to a dummy value just not to bother with
> > other events during the sorting.  So it has a very big initial value
> > and increase it on processing each samples.
> >
> > Good thing is that it can be used together with regular profiling like
> > cpu cycles.  If you don't want to that, you can use a dummy event to
> > enable off-cpu profiling only.
> >
> > Example output:
> >   $ sudo perf record --off-cpu perf bench sched messaging -l 1000
> >
> >   $ sudo perf report --stdio --call-graph=no
> >   # Total Lost Samples: 0
> >   #
> >   # Samples: 41K of event 'cycles'
> >   # Event count (approx.): 42137343851
> >   ...
> >
> >   # Samples: 1K of event 'offcpu-time'
> >   # Event count (approx.): 587990831640
> >   #
> >   # Children      Self  Command          Shared Object       Symbol
> >   # ........  ........  ...............  ..................  .........................
> >   #
> >       81.66%     0.00%  sched-messaging  libc-2.33.so        [.] __libc_start_main
> >       81.66%     0.00%  sched-messaging  perf                [.] cmd_bench
> >       81.66%     0.00%  sched-messaging  perf                [.] main
> >       81.66%     0.00%  sched-messaging  perf                [.] run_builtin
> >       81.43%     0.00%  sched-messaging  perf                [.] bench_sched_messaging
> >       40.86%    40.86%  sched-messaging  libpthread-2.33.so  [.] __read
> >       37.66%    37.66%  sched-messaging  libpthread-2.33.so  [.] __write
> >        2.91%     2.91%  sched-messaging  libc-2.33.so        [.] __poll
> >   ...
> >
> > As you can see it spent most of off-cpu time in read and write in
> > bench_sched_messaging().  The --call-graph=no was added just to make
> > the output concise here.
> >
> > It uses perf hooks facility to control BPF program during the record
> > session rather than adding new BPF/off-cpu specific calls.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  10 ++
> >  tools/perf/Makefile.perf                 |   1 +
> >  tools/perf/builtin-record.c              |  25 +++
> >  tools/perf/util/Build                    |   1 +
> >  tools/perf/util/bpf_off_cpu.c            | 204 +++++++++++++++++++++++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c   | 139 +++++++++++++++
> >  tools/perf/util/off_cpu.h                |  24 +++
> >  7 files changed, 404 insertions(+)
> >  create mode 100644 tools/perf/util/bpf_off_cpu.c
> >  create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
> >  create mode 100644 tools/perf/util/off_cpu.h
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 465be4e62a17..b4e9ef7edfef 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -758,6 +758,16 @@ include::intel-hybrid.txt[]
> >         If the URLs is not specified, the value of DEBUGINFOD_URLS
> >         system environment variable is used.
> >
> > +--off-cpu::
> > +       Enable off-cpu profiling with BPF.  The BPF program will collect
> > +       task scheduling information with (user) stacktrace and save them
> > +       as sample data of a software event named "offcpu-time".  The
> > +       sample period will have the time the task slept in nanoseconds.
> > +
> > +       Note that BPF can collect stack traces using frame pointer ("fp")
> > +       only, as of now.  So the applications built without the frame
> > +       pointer might see bogus addresses.
> > +
> >  SEE ALSO
> >  --------
> >  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 6e5aded855cc..8f738e11356d 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1038,6 +1038,7 @@ SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> >  SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
> >  SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> >  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
> > +SKELETONS += $(SKEL_OUT)/off_cpu.skel.h
> >
> >  $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
> >         $(Q)$(MKDIR) -p $@
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index a5cf6a99d67f..91f88501412e 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -49,6 +49,7 @@
> >  #include "util/clockid.h"
> >  #include "util/pmu-hybrid.h"
> >  #include "util/evlist-hybrid.h"
> > +#include "util/off_cpu.h"
> >  #include "asm/bug.h"
> >  #include "perf.h"
> >  #include "cputopo.h"
> > @@ -162,6 +163,7 @@ struct record {
> >         bool                    buildid_mmap;
> >         bool                    timestamp_filename;
> >         bool                    timestamp_boundary;
> > +       bool                    off_cpu;
> >         struct switch_output    switch_output;
> >         unsigned long long      samples;
> >         unsigned long           output_max_size;        /* = 0: unlimited */
> > @@ -903,6 +905,11 @@ static int record__config_text_poke(struct evlist *evlist)
> >         return 0;
> >  }
> >
> > +static int record__config_off_cpu(struct record *rec)
> > +{
> > +       return off_cpu_prepare(rec->evlist);
> > +}
> > +
> >  static bool record__kcore_readable(struct machine *machine)
> >  {
> >         char kcore[PATH_MAX];
> > @@ -2600,6 +2607,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >         } else
> >                 status = err;
> >
> > +       if (rec->off_cpu)
> > +               rec->bytes_written += off_cpu_write(rec->session);
> > +
> >         record__synthesize(rec, true);
> >         /* this will be recalculated during process_buildids() */
> >         rec->samples = 0;
> > @@ -3324,6 +3334,7 @@ static struct option __record_options[] = {
> >         OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
> >                             "write collected trace data into several data files using parallel threads",
> >                             record__parse_threads),
> > +       OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
> >         OPT_END()
> >  };
> >
> > @@ -3743,6 +3754,12 @@ int cmd_record(int argc, const char **argv)
> >         set_nobuild('\0', "vmlinux", true);
> >  # undef set_nobuild
> >  # undef REASON
> > +#endif
> > +
> > +#ifndef HAVE_BPF_SKEL
> > +# define set_nobuild(s, l, m, c) set_option_nobuild(record_options, s, l, m, c)
> > +       set_nobuild('\0', "off-cpu", "no BUILD_BPF_SKEL=1", true);
> > +# undef set_nobuild
> >  #endif
> >
> >         rec->opts.affinity = PERF_AFFINITY_SYS;
> > @@ -3981,6 +3998,14 @@ int cmd_record(int argc, const char **argv)
> >                 }
> >         }
> >
> > +       if (rec->off_cpu) {
> > +               err = record__config_off_cpu(rec);
> > +               if (err) {
> > +                       pr_err("record__config_off_cpu failed, error %d\n", err);
> > +                       goto out;
> > +               }
> > +       }
> > +
> >         if (record_opts__config(&rec->opts)) {
> >                 err = -EINVAL;
> >                 goto out;
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 9a7209a99e16..a51267d88ca9 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -147,6 +147,7 @@ perf-$(CONFIG_LIBBPF) += bpf_map.o
> >  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
> >  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> >  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
> > +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
> >  perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> >  perf-$(CONFIG_LIBELF) += symbol-elf.o
> >  perf-$(CONFIG_LIBELF) += probe-file.o
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> > new file mode 100644
> > index 000000000000..9ed7aca3f4ac
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -0,0 +1,204 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "util/bpf_counter.h"
> > +#include "util/debug.h"
> > +#include "util/evsel.h"
> > +#include "util/evlist.h"
> > +#include "util/off_cpu.h"
> > +#include "util/perf-hooks.h"
> > +#include "util/session.h"
> > +#include <bpf/bpf.h>
> > +
> > +#include "bpf_skel/off_cpu.skel.h"
> > +
> > +#define MAX_STACKS  32
> > +/* we don't need actual timestamp, just want to put the samples at last */
> > +#define OFF_CPU_TIMESTAMP  (~0ull << 32)
> > +
> > +static struct off_cpu_bpf *skel;
> > +
> > +struct off_cpu_key {
> > +       u32 pid;
> > +       u32 tgid;
> > +       u32 stack_id;
> > +       u32 state;
> > +};
> > +
> > +union off_cpu_data {
> > +       struct perf_event_header hdr;
> > +       u64 array[1024 / sizeof(u64)];
> > +};
> > +
> > +static int off_cpu_config(struct evlist *evlist)
> > +{
> > +       struct evsel *evsel;
> > +       struct perf_event_attr attr = {
> > +               .type   = PERF_TYPE_SOFTWARE,
> > +               .config = PERF_COUNT_SW_BPF_OUTPUT,
> > +               .size   = sizeof(attr), /* to capture ABI version */
> > +       };
> > +       char *evname = strdup(OFFCPU_EVENT);
> > +
> > +       if (evname == NULL)
> > +               return -ENOMEM;
> > +
> > +       evsel = evsel__new(&attr);
> > +       if (!evsel) {
> > +               free(evname);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       evsel->core.attr.freq = 1;
> > +       evsel->core.attr.sample_period = 1;
> > +       /* off-cpu analysis depends on stack trace */
> > +       evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> > +
> > +       evlist__add(evlist, evsel);
> > +
> > +       free(evsel->name);
> > +       evsel->name = evname;
> > +
> > +       return 0;
> > +}
> > +
> > +static void off_cpu_start(void *arg __maybe_unused)
> > +{
> > +       skel->bss->enabled = 1;
> > +}
> > +
> > +static void off_cpu_finish(void *arg __maybe_unused)
> > +{
> > +       skel->bss->enabled = 0;
> > +       off_cpu_bpf__destroy(skel);
> > +}
> > +
> > +int off_cpu_prepare(struct evlist *evlist)
> > +{
> > +       int err;
> > +
> > +       if (off_cpu_config(evlist) < 0) {
> > +               pr_err("Failed to config off-cpu BPF event\n");
> > +               return -1;
> > +       }
> > +
> > +       set_max_rlimit();
> > +
> > +       skel = off_cpu_bpf__open_and_load();
> > +       if (!skel) {
> > +               pr_err("Failed to open off-cpu BPF skeleton\n");
> > +               return -1;
> > +       }
> > +
> > +       err = off_cpu_bpf__attach(skel);
> > +       if (err) {
> > +               pr_err("Failed to attach off-cpu BPF skeleton\n");
> > +               goto out;
> > +       }
> > +
> > +       if (perf_hooks__set_hook("record_start", off_cpu_start, NULL) ||
> > +           perf_hooks__set_hook("record_end", off_cpu_finish, NULL)) {
>
> An off-topic thought here. I was looking at tool events and thinking
> that rather than have global state and the counter reading getting
> those global values, it would be nice if the tool events had private
> state that was created on open, freed on close and then did the
> appropriate thing for enable/read/disable. If we were object oriented
> I was thinking tool events could be a subclass of evsel that would
> override the appropriate functions. Something that strikes me as silly
> is that tool events have a dummy event file descriptor from
> perf_event_open, in part because the evsel code paths are shared.
> Anyway, if we made evsels have something like a virtual method table,
> we could do similar tricks with off-cpu and BPF created events.
> Possibly this could lead to better structured code and more reuse.

Thanks for your review.

Yeah I think it makes sense to change the offcpu-time event as a
tool event and to skip actual open/read/close operations.  It would
be a good follow up work.

Using a dummy event still has a syscall overhead and tool events
don't need the syscalls.  Maybe we can add some logic in the evlist
code to skip the tool events.

Thanks,
Namhyung
