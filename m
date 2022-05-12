Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C384152456F
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 08:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349200AbiELGNq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 May 2022 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350189AbiELGNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 02:13:45 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26663102772;
        Wed, 11 May 2022 23:13:44 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id e189so5262168oia.8;
        Wed, 11 May 2022 23:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IphMtluPUV077NPW9fGrQJ/ioqshojCJHF+7J59USws=;
        b=hHqgQoWkE4nAlLp2a9wLZ17xgtDxD8ce4tPUM/kUe/SbbEXYHpXKDhFIY1gePH5rIg
         FYRNF+kH8acv0+DNYKvdhrmDpcRaxlHHFU3Z0uWpgUhM5G9zZwAHAPJc+mjdob5UcT0a
         MwFTThkMfHPiON31WDD6LmDkTR/4a+2BOZ+CcMsBWERmSCSg3Lqf6qWxOklW7kS1zh+i
         oWtmNTO3d6UroPicelRGotyO9X++L5osgE1ZmiwlRHWWXLqE01MFhet0TQ5UwjlSmIjJ
         MfsSWOJV4D17NfdMKU7oEFMHtWKxEKocYZKrOLetM8DiIV/ZE/pfkI5yHvY+ZVp5JFZ/
         NrKg==
X-Gm-Message-State: AOAM531vQmCAQhnIP5kNnWSxbK0mRxYFU3S6kc1R/IhjM2vJDwu6AMHt
        4J3oE2P2tnMec0/o0qdT10zzMtZUYhE+Vc0aH34=
X-Google-Smtp-Source: ABdhPJyA7TI+pfyx3yaWvxo/Xix9L9LjfEullFnK1Xse0argI2OAyw6dSGEtP4tzXetHvq6Wfweo3BpPgFiOC25Hhhs=
X-Received: by 2002:a05:6808:2218:b0:326:bd8c:d044 with SMTP id
 bd24-20020a056808221800b00326bd8cd044mr4399366oib.92.1652336023390; Wed, 11
 May 2022 23:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220506201627.85598-1-namhyung@kernel.org> <20220506201627.85598-3-namhyung@kernel.org>
 <YnqauukLMUqfv15K@kernel.org>
In-Reply-To: <YnqauukLMUqfv15K@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 May 2022 23:13:32 -0700
Message-ID: <CAM9d7cie0UpnpQG6AhsXYE8gowkfa4LpDF88Vh8MemjO-3fmug@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf record: Enable off-cpu analysis with BPF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 10:02 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 06, 2022 at 01:16:25PM -0700, Namhyung Kim escreveu:
[SNIP]
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 465be4e62a17..8084e3fb73a1 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -758,6 +758,16 @@ include::intel-hybrid.txt[]
> >       If the URLs is not specified, the value of DEBUGINFOD_URLS
> >       system environment variable is used.
> >
> > +--off-cpu::
> > +     Enable off-cpu profiling with BPF.  The BPF program will collect
> > +     task scheduling information with (user) stacktrace and save them
> > +     as sample data of a software event named "offcpu-time".  The
> > +     sample period will have the time the task slept in nano-second.
>
>                                                         nanoseconds.

ok

> > +
> > +     Note that BPF can collect stacktrace using frame pointer ("fp")
>
>                                 stack traces

ok

>
> > +     only, as of now.  So the applications built without the frame
> > +     pointer might see bogus addresses.
>
> One possible improvement is to check if debugging info is available in
> the traced program and check if -fnoomit-frame-pointer is present:
>
> ⬢[acme@toolbox perf]$ readelf -wi ~/bin/perf | grep DW_AT_producer -m1
>     <d>   DW_AT_producer    : (indirect string, offset: 0x6627): GNU C99 11.2.1 20220127 (Red Hat 11.2.1-9) -mtune=generic -march=x86-64 -ggdb3 -O6 -std=gnu99 -fno-omit-frame-pointer -funwind-tables -fstack-protector-all
> ⬢[acme@toolbox perf]$
>
> If debugging info is available and -fno-omit-frame-pointer isn't in the
> DW_AT_producer string, then we can print a flashing warning and even
> don't use the stack traces.

Yeah, but checking the binary only would not be enough as it will
call other libraries.  Also the libc would be the most frequent user of
any sleeping syscalls, I guess.

>
> That or some other more robust method to detect that frame pointers are
> valid.
>
> Some more comments below.
>
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
> >       $(Q)$(MKDIR) -p $@
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index a5cf6a99d67f..4e0285ca9a2d 100644
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
> >       bool                    buildid_mmap;
> >       bool                    timestamp_filename;
> >       bool                    timestamp_boundary;
> > +     bool                    off_cpu;
> >       struct switch_output    switch_output;
> >       unsigned long long      samples;
> >       unsigned long           output_max_size;        /* = 0: unlimited */
> > @@ -903,6 +905,11 @@ static int record__config_text_poke(struct evlist *evlist)
> >       return 0;
> >  }
> >
> > +static int record__config_off_cpu(struct record *rec)
> > +{
> > +     return off_cpu_prepare(rec->evlist);
> > +}
> > +
> >  static bool record__kcore_readable(struct machine *machine)
> >  {
> >       char kcore[PATH_MAX];
> > @@ -2600,6 +2607,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >       } else
> >               status = err;
> >
> > +     if (rec->off_cpu)
> > +             rec->bytes_written += off_cpu_write(rec->session);
> > +
> >       record__synthesize(rec, true);
> >       /* this will be recalculated during process_buildids() */
> >       rec->samples = 0;
> > @@ -3324,6 +3334,9 @@ static struct option __record_options[] = {
> >       OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
> >                           "write collected trace data into several data files using parallel threads",
> >                           record__parse_threads),
> > +#ifdef HAVE_BPF_SKEL
> > +     OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
> > +#endif
>
>
> Since this is in the documentation, I think we should have an #else
> clause and state that --off-cpu needs building with some specific make
> command line.

I'd rather remove the #ifdef here and put it after parse_options
to show the warning.

>
> >       OPT_END()
> >  };
> >
> > @@ -3981,6 +3994,14 @@ int cmd_record(int argc, const char **argv)
> >               }
> >       }
> >
> > +     if (rec->off_cpu) {
> > +             err = record__config_off_cpu(rec);
> > +             if (err) {
> > +                     pr_err("record__config_off_cpu failed, error %d\n", err);
> > +                     goto out;
> > +             }
> > +     }
> > +
> >       if (record_opts__config(&rec->opts)) {
> >               err = -EINVAL;
> >               goto out;
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
> > index 000000000000..1f87d2a9b86d
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -0,0 +1,208 @@
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
> > +     u32 pid;
> > +     u32 tgid;
> > +     u32 stack_id;
> > +     u32 state;
> > +     u64 cgroup_id;
> > +};
> > +
> > +union off_cpu_data {
> > +     struct perf_event_header hdr;
> > +     u64 array[1024 / sizeof(u64)];
> > +};
> > +
> > +static int off_cpu_config(struct evlist *evlist)
> > +{
> > +     struct evsel *evsel;
> > +     struct perf_event_attr attr = {
> > +             .type   = PERF_TYPE_SOFTWARE,
> > +             .config = PERF_COUNT_SW_BPF_OUTPUT,
> > +             .size   = sizeof(attr), /* to capture ABI version */
> > +     };
> > +
> > +     evsel = evsel__new(&attr);
> > +     if (!evsel)
> > +             return -ENOMEM;
> > +
> > +     evsel->core.attr.freq = 1;
> > +     evsel->core.attr.sample_period = 1;
> > +     /* off-cpu analysis depends on stack trace */
> > +     evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> > +
> > +     evlist__add(evlist, evsel);
> > +
> > +     free(evsel->name);
> > +     evsel->name = strdup("offcpu-time");
> > +     if (evsel->name == NULL)
> > +             return -ENOMEM;
>
> But at this point the evsel was left in the evlist? Shouldn't we start
> it all by trying to allocate this string and don't bother to call
> evsel__new() on failure, etc?

Sounds good, will change.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void off_cpu_start(void *arg __maybe_unused)
> > +{
> > +     skel->bss->enabled = 1;
> > +}
> > +
> > +static void off_cpu_finish(void *arg __maybe_unused)
> > +{
> > +     skel->bss->enabled = 0;
> > +     off_cpu_bpf__destroy(skel);
> > +}
> > +
> > +int off_cpu_prepare(struct evlist *evlist)
> > +{
> > +     int err;
> > +
> > +     if (off_cpu_config(evlist) < 0) {
> > +             pr_err("Failed to config off-cpu BPF event\n");
> > +             return -1;
> > +     }
> > +
> > +     set_max_rlimit();
> > +
> > +     skel = off_cpu_bpf__open_and_load();
> > +     if (!skel) {
> > +             pr_err("Failed to open off-cpu skeleton\n");
>
> "BPF sleketon", to give a bit more context to users?

ok

>
> > +             return -1;
> > +     }
> > +
> > +     err = off_cpu_bpf__attach(skel);
> > +     if (err) {
> > +             pr_err("Failed to attach off-cpu skeleton\n");
>
> Ditto.

ok

>
> > +             goto out;
> > +     }
> > +
> > +     if (perf_hooks__set_hook("record_start", off_cpu_start, NULL) ||
> > +         perf_hooks__set_hook("record_end", off_cpu_finish, NULL)) {
> > +             pr_err("Failed to attach off-cpu skeleton\n");
> > +             goto out;
> > +     }
> > +
> > +     return 0;
> > +
> > +out:
> > +     off_cpu_bpf__destroy(skel);
> > +     return -1;
> > +}
> > +
> > +int off_cpu_write(struct perf_session *session)
> > +{
> > +     int bytes = 0, size;
> > +     int fd, stack;
> > +     bool found = false;
> > +     u64 sample_type, val, sid = 0;
> > +     struct evsel *evsel;
> > +     struct perf_data_file *file = &session->data->file;
> > +     struct off_cpu_key prev, key;
> > +     union off_cpu_data data = {
> > +             .hdr = {
> > +                     .type = PERF_RECORD_SAMPLE,
> > +                     .misc = PERF_RECORD_MISC_USER,
> > +             },
> > +     };
> > +     u64 tstamp = OFF_CPU_TIMESTAMP;
> > +
> > +     skel->bss->enabled = 0;
> > +
> > +     evlist__for_each_entry(session->evlist, evsel) {
> > +             if (!strcmp(evsel__name(evsel), "offcpu-time")) {
> > +                     found = true;
> > +                     break;
> > +             }
> > +     }
>
> Don't we have some evlist__find_evsel function?
>
> struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
> {
>         struct evsel *evsel;
>
>         evlist__for_each_entry(evlist, evsel) {
>                 if (!evsel->name)
>                         continue;
>                 if (strcmp(str, evsel->name) == 0)
>                         return evsel;
>         }
>
>         return NULL;
> }

Nice, I'll use it instead.

Thanks for your review!
Namhyung
