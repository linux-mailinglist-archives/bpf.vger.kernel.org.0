Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBF5221E9
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbiEJRG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiEJRG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 13:06:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699361E1228;
        Tue, 10 May 2022 10:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4330B81DC3;
        Tue, 10 May 2022 17:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17403C385C9;
        Tue, 10 May 2022 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652202173;
        bh=bCGj8PLiibH/p9Tx45xlzoz11ALnJn8s7PSqJCsvHow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3mK34GlyoymFBDzA0dReqaI/fJ7a3GhKS5gB6TYM870pYQfJC/J+Lu8tZ7MT0O3t
         FoId5E6WYeypYA64PmKN8399uHH5hI1nyoBSNpQozu9fqJO/2kDPnRz5gdEO5p3O/4
         SPbXvtNxWXcY0OHjFWdxnTKAYNuNgdX4WV7DOAdL+j+zhv6jhOdEzArF/HkOKqGQ77
         V2U348iu5kG03ZJoouqXkeAFhKWdXjjUXKpptu90+S6A1ugMytFXb8O0H1+qN2n8ZT
         jRmeXLINC+g/lHvxTOzWPEV4QDvVeBORB2/OnE09Y2pSLEiOB9Wq4lFUBOIiTrEJtQ
         Zwmntw21cg3nQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 51806400B1; Tue, 10 May 2022 14:02:50 -0300 (-03)
Date:   Tue, 10 May 2022 14:02:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 2/4] perf record: Enable off-cpu analysis with BPF
Message-ID: <YnqauukLMUqfv15K@kernel.org>
References: <20220506201627.85598-1-namhyung@kernel.org>
 <20220506201627.85598-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506201627.85598-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, May 06, 2022 at 01:16:25PM -0700, Namhyung Kim escreveu:
> Add --off-cpu option to enable the off-cpu profiling with BPF.  It'd
> use a bpf_output event and rename it to "offcpu-time".  Samples will
> be synthesized at the end of the record session using data from a BPF
> map which contains the aggregated off-cpu time at context switches.
> So it needs root privilege to get the off-cpu profiling.
> 
> Each sample will have a separate user stacktrace so it will skip
> kernel threads.  The sample ip will be set from the stacktrace and
> other sample data will be updated accordingly.  Currently it only
> handles some basic sample types.
> 
> The sample timestamp is set to a dummy value just not to bother with
> other events during the sorting.  So it has a very big initial value
> and increase it on processing each samples.
> 
> Good thing is that it can be used together with regular profiling like
> cpu cycles.  If you don't want to that, you can use a dummy event to
> enable off-cpu profiling only.
> 
> Example output:
>   $ sudo perf record --off-cpu perf bench sched messaging -l 1000
> 
>   $ sudo perf report --stdio --call-graph=no
>   # Total Lost Samples: 0
>   #
>   # Samples: 41K of event 'cycles'
>   # Event count (approx.): 42137343851
>   ...
> 
>   # Samples: 1K of event 'offcpu-time'
>   # Event count (approx.): 587990831640
>   #
>   # Children      Self  Command          Shared Object       Symbol
>   # ........  ........  ...............  ..................  .........................
>   #
>       81.66%     0.00%  sched-messaging  libc-2.33.so        [.] __libc_start_main
>       81.66%     0.00%  sched-messaging  perf                [.] cmd_bench
>       81.66%     0.00%  sched-messaging  perf                [.] main
>       81.66%     0.00%  sched-messaging  perf                [.] run_builtin
>       81.43%     0.00%  sched-messaging  perf                [.] bench_sched_messaging
>       40.86%    40.86%  sched-messaging  libpthread-2.33.so  [.] __read
>       37.66%    37.66%  sched-messaging  libpthread-2.33.so  [.] __write
>        2.91%     2.91%  sched-messaging  libc-2.33.so        [.] __poll
>   ...
> 
> As you can see it spent most of off-cpu time in read and write in
> bench_sched_messaging().  The --call-graph=no was added just to make
> the output concise here.
> 
> It uses perf hooks facility to control BPF program during the record
> session rather than adding new BPF/off-cpu specific calls.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt |  10 ++
>  tools/perf/Makefile.perf                 |   1 +
>  tools/perf/builtin-record.c              |  21 +++
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/bpf_off_cpu.c            | 208 +++++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c   | 139 +++++++++++++++
>  tools/perf/util/off_cpu.h                |  22 +++
>  7 files changed, 402 insertions(+)
>  create mode 100644 tools/perf/util/bpf_off_cpu.c
>  create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
>  create mode 100644 tools/perf/util/off_cpu.h
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 465be4e62a17..8084e3fb73a1 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -758,6 +758,16 @@ include::intel-hybrid.txt[]
>  	If the URLs is not specified, the value of DEBUGINFOD_URLS
>  	system environment variable is used.
>  
> +--off-cpu::
> +	Enable off-cpu profiling with BPF.  The BPF program will collect
> +	task scheduling information with (user) stacktrace and save them
> +	as sample data of a software event named "offcpu-time".  The
> +	sample period will have the time the task slept in nano-second.

							nanoseconds.
> +
> +	Note that BPF can collect stacktrace using frame pointer ("fp")

				stack traces

> +	only, as of now.  So the applications built without the frame
> +	pointer might see bogus addresses.

One possible improvement is to check if debugging info is available in
the traced program and check if -fnoomit-frame-pointer is present:

⬢[acme@toolbox perf]$ readelf -wi ~/bin/perf | grep DW_AT_producer -m1
    <d>   DW_AT_producer    : (indirect string, offset: 0x6627): GNU C99 11.2.1 20220127 (Red Hat 11.2.1-9) -mtune=generic -march=x86-64 -ggdb3 -O6 -std=gnu99 -fno-omit-frame-pointer -funwind-tables -fstack-protector-all
⬢[acme@toolbox perf]$ 

If debugging info is available and -fno-omit-frame-pointer isn't in the
DW_AT_producer string, then we can print a flashing warning and even
don't use the stack traces.

That or some other more robust method to detect that frame pointers are
valid.

Some more comments below.

> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 6e5aded855cc..8f738e11356d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1038,6 +1038,7 @@ SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
>  SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
>  SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
>  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
> +SKELETONS += $(SKEL_OUT)/off_cpu.skel.h
>  
>  $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
>  	$(Q)$(MKDIR) -p $@
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a5cf6a99d67f..4e0285ca9a2d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -49,6 +49,7 @@
>  #include "util/clockid.h"
>  #include "util/pmu-hybrid.h"
>  #include "util/evlist-hybrid.h"
> +#include "util/off_cpu.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  #include "cputopo.h"
> @@ -162,6 +163,7 @@ struct record {
>  	bool			buildid_mmap;
>  	bool			timestamp_filename;
>  	bool			timestamp_boundary;
> +	bool			off_cpu;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
> @@ -903,6 +905,11 @@ static int record__config_text_poke(struct evlist *evlist)
>  	return 0;
>  }
>  
> +static int record__config_off_cpu(struct record *rec)
> +{
> +	return off_cpu_prepare(rec->evlist);
> +}
> +
>  static bool record__kcore_readable(struct machine *machine)
>  {
>  	char kcore[PATH_MAX];
> @@ -2600,6 +2607,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	} else
>  		status = err;
>  
> +	if (rec->off_cpu)
> +		rec->bytes_written += off_cpu_write(rec->session);
> +
>  	record__synthesize(rec, true);
>  	/* this will be recalculated during process_buildids() */
>  	rec->samples = 0;
> @@ -3324,6 +3334,9 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
>  			    "write collected trace data into several data files using parallel threads",
>  			    record__parse_threads),
> +#ifdef HAVE_BPF_SKEL
> +	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
> +#endif


Since this is in the documentation, I think we should have an #else
clause and state that --off-cpu needs building with some specific make
command line.

>  	OPT_END()
>  };
>  
> @@ -3981,6 +3994,14 @@ int cmd_record(int argc, const char **argv)
>  		}
>  	}
>  
> +	if (rec->off_cpu) {
> +		err = record__config_off_cpu(rec);
> +		if (err) {
> +			pr_err("record__config_off_cpu failed, error %d\n", err);
> +			goto out;
> +		}
> +	}
> +
>  	if (record_opts__config(&rec->opts)) {
>  		err = -EINVAL;
>  		goto out;
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 9a7209a99e16..a51267d88ca9 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -147,6 +147,7 @@ perf-$(CONFIG_LIBBPF) += bpf_map.o
>  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
>  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
>  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
> +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
>  perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
>  perf-$(CONFIG_LIBELF) += symbol-elf.o
>  perf-$(CONFIG_LIBELF) += probe-file.o
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> new file mode 100644
> index 000000000000..1f87d2a9b86d
> --- /dev/null
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "util/bpf_counter.h"
> +#include "util/debug.h"
> +#include "util/evsel.h"
> +#include "util/evlist.h"
> +#include "util/off_cpu.h"
> +#include "util/perf-hooks.h"
> +#include "util/session.h"
> +#include <bpf/bpf.h>
> +
> +#include "bpf_skel/off_cpu.skel.h"
> +
> +#define MAX_STACKS  32
> +/* we don't need actual timestamp, just want to put the samples at last */
> +#define OFF_CPU_TIMESTAMP  (~0ull << 32)
> +
> +static struct off_cpu_bpf *skel;
> +
> +struct off_cpu_key {
> +	u32 pid;
> +	u32 tgid;
> +	u32 stack_id;
> +	u32 state;
> +	u64 cgroup_id;
> +};
> +
> +union off_cpu_data {
> +	struct perf_event_header hdr;
> +	u64 array[1024 / sizeof(u64)];
> +};
> +
> +static int off_cpu_config(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +	struct perf_event_attr attr = {
> +		.type	= PERF_TYPE_SOFTWARE,
> +		.config = PERF_COUNT_SW_BPF_OUTPUT,
> +		.size	= sizeof(attr), /* to capture ABI version */
> +	};
> +
> +	evsel = evsel__new(&attr);
> +	if (!evsel)
> +		return -ENOMEM;
> +
> +	evsel->core.attr.freq = 1;
> +	evsel->core.attr.sample_period = 1;
> +	/* off-cpu analysis depends on stack trace */
> +	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> +
> +	evlist__add(evlist, evsel);
> +
> +	free(evsel->name);
> +	evsel->name = strdup("offcpu-time");
> +	if (evsel->name == NULL)
> +		return -ENOMEM;

But at this point the evsel was left in the evlist? Shouldn't we start
it all by trying to allocate this string and don't bother to call
evsel__new() on failure, etc?

> +
> +	return 0;
> +}
> +
> +static void off_cpu_start(void *arg __maybe_unused)
> +{
> +	skel->bss->enabled = 1;
> +}
> +
> +static void off_cpu_finish(void *arg __maybe_unused)
> +{
> +	skel->bss->enabled = 0;
> +	off_cpu_bpf__destroy(skel);
> +}
> +
> +int off_cpu_prepare(struct evlist *evlist)
> +{
> +	int err;
> +
> +	if (off_cpu_config(evlist) < 0) {
> +		pr_err("Failed to config off-cpu BPF event\n");
> +		return -1;
> +	}
> +
> +	set_max_rlimit();
> +
> +	skel = off_cpu_bpf__open_and_load();
> +	if (!skel) {
> +		pr_err("Failed to open off-cpu skeleton\n");

"BPF sleketon", to give a bit more context to users?

> +		return -1;
> +	}
> +
> +	err = off_cpu_bpf__attach(skel);
> +	if (err) {
> +		pr_err("Failed to attach off-cpu skeleton\n");

Ditto.

> +		goto out;
> +	}
> +
> +	if (perf_hooks__set_hook("record_start", off_cpu_start, NULL) ||
> +	    perf_hooks__set_hook("record_end", off_cpu_finish, NULL)) {
> +		pr_err("Failed to attach off-cpu skeleton\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	off_cpu_bpf__destroy(skel);
> +	return -1;
> +}
> +
> +int off_cpu_write(struct perf_session *session)
> +{
> +	int bytes = 0, size;
> +	int fd, stack;
> +	bool found = false;
> +	u64 sample_type, val, sid = 0;
> +	struct evsel *evsel;
> +	struct perf_data_file *file = &session->data->file;
> +	struct off_cpu_key prev, key;
> +	union off_cpu_data data = {
> +		.hdr = {
> +			.type = PERF_RECORD_SAMPLE,
> +			.misc = PERF_RECORD_MISC_USER,
> +		},
> +	};
> +	u64 tstamp = OFF_CPU_TIMESTAMP;
> +
> +	skel->bss->enabled = 0;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		if (!strcmp(evsel__name(evsel), "offcpu-time")) {
> +			found = true;
> +			break;
> +		}
> +	}

Don't we have some evlist__find_evsel function?

struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
{
        struct evsel *evsel;

        evlist__for_each_entry(evlist, evsel) {
                if (!evsel->name)
                        continue;
                if (strcmp(str, evsel->name) == 0)
                        return evsel;
        }

        return NULL;
}

> +
> +	if (!found) {
> +		pr_err("offcpu-time evsel not found\n");
> +		return 0;
> +	}
> +
> +	sample_type = evsel->core.attr.sample_type;
> +
> +	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
> +		if (evsel->core.id)
> +			sid = evsel->core.id[0];
> +	}
> +
> +	fd = bpf_map__fd(skel->maps.off_cpu);
> +	stack = bpf_map__fd(skel->maps.stacks);
> +	memset(&prev, 0, sizeof(prev));
> +
> +	while (!bpf_map_get_next_key(fd, &prev, &key)) {
> +		int n = 1;  /* start from perf_event_header */
> +		int ip_pos = -1;
> +
> +		bpf_map_lookup_elem(fd, &key, &val);
> +
> +		if (sample_type & PERF_SAMPLE_IDENTIFIER)
> +			data.array[n++] = sid;
> +		if (sample_type & PERF_SAMPLE_IP) {
> +			ip_pos = n;
> +			data.array[n++] = 0;  /* will be updated */
> +		}
> +		if (sample_type & PERF_SAMPLE_TID)
> +			data.array[n++] = (u64)key.pid << 32 | key.tgid;
> +		if (sample_type & PERF_SAMPLE_TIME)
> +			data.array[n++] = tstamp;
> +		if (sample_type & PERF_SAMPLE_ID)
> +			data.array[n++] = sid;
> +		if (sample_type & PERF_SAMPLE_CPU)
> +			data.array[n++] = 0;
> +		if (sample_type & PERF_SAMPLE_PERIOD)
> +			data.array[n++] = val;
> +		if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> +			int len = 0;
> +
> +			/* data.array[n] is callchain->nr (updated later) */
> +			data.array[n + 1] = PERF_CONTEXT_USER;
> +			data.array[n + 2] = 0;
> +
> +			bpf_map_lookup_elem(stack, &key.stack_id, &data.array[n + 2]);
> +			while (data.array[n + 2 + len])
> +				len++;
> +
> +			/* update length of callchain */
> +			data.array[n] = len + 1;
> +
> +			/* update sample ip with the first callchain entry */
> +			if (ip_pos >= 0)
> +				data.array[ip_pos] = data.array[n + 2];
> +
> +			/* calculate sample callchain data array length */
> +			n += len + 2;
> +		}
> +		/* TODO: handle more sample types */
> +
> +		size = n * sizeof(u64);
> +		data.hdr.size = size;
> +		bytes += size;
> +
> +		if (perf_data_file__write(file, &data, size) < 0) {
> +			pr_err("failed to write perf data, error: %m\n");
> +			return bytes;
> +		}
> +
> +		prev = key;
> +		/* increase dummy timestamp to sort later samples */
> +		tstamp++;
> +	}
> +	return bytes;
> +}
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> new file mode 100644
> index 000000000000..5173ed882fdf
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2022 Google
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +/* task->flags for off-cpu analysis */
> +#define PF_KTHREAD   0x00200000  /* I am a kernel thread */
> +
> +/* task->state for off-cpu analysis */
> +#define TASK_INTERRUPTIBLE	0x0001
> +#define TASK_UNINTERRUPTIBLE	0x0002
> +
> +#define MAX_STACKS   32
> +#define MAX_ENTRIES  102400
> +
> +struct tstamp_data {
> +	__u32 stack_id;
> +	__u32 state;
> +	__u64 timestamp;
> +};
> +
> +struct offcpu_key {
> +	__u32 pid;
> +	__u32 tgid;
> +	__u32 stack_id;
> +	__u32 state;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, MAX_STACKS * sizeof(__u64));
> +	__uint(max_entries, MAX_ENTRIES);
> +} stacks SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct tstamp_data);
> +} tstamp SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(struct offcpu_key));
> +	__uint(value_size, sizeof(__u64));
> +	__uint(max_entries, MAX_ENTRIES);
> +} off_cpu SEC(".maps");
> +
> +/* old kernel task_struct definition */
> +struct task_struct___old {
> +	long state;
> +} __attribute__((preserve_access_index));
> +
> +int enabled = 0;
> +
> +/*
> + * Old kernel used to call it task_struct->state and now it's '__state'.
> + * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> + *
> + * https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompatible-field-and-type-changes
> + */
> +static inline int get_task_state(struct task_struct *t)
> +{
> +	if (bpf_core_field_exists(t->__state))
> +		return BPF_CORE_READ(t, __state);
> +
> +	/* recast pointer to capture task_struct___old type for compiler */
> +	struct task_struct___old *t_old = (void *)t;
> +
> +	/* now use old "state" name of the field */
> +	return BPF_CORE_READ(t_old, state);
> +}
> +
> +SEC("tp_btf/sched_switch")
> +int on_switch(u64 *ctx)
> +{
> +	__u64 ts;
> +	int state;
> +	__u32 stack_id;
> +	struct task_struct *prev, *next;
> +	struct tstamp_data *pelem;
> +
> +	if (!enabled)
> +		return 0;
> +
> +	prev = (struct task_struct *)ctx[1];
> +	next = (struct task_struct *)ctx[2];
> +	state = get_task_state(prev);
> +
> +	ts = bpf_ktime_get_ns();
> +
> +	if (prev->flags & PF_KTHREAD)
> +		goto next;
> +	if (state != TASK_INTERRUPTIBLE &&
> +	    state != TASK_UNINTERRUPTIBLE)
> +		goto next;
> +
> +	stack_id = bpf_get_stackid(ctx, &stacks,
> +				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
> +
> +	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!pelem)
> +		goto next;
> +
> +	pelem->timestamp = ts;
> +	pelem->state = state;
> +	pelem->stack_id = stack_id;
> +
> +next:
> +	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
> +
> +	if (pelem && pelem->timestamp) {
> +		struct offcpu_key key = {
> +			.pid = next->pid,
> +			.tgid = next->tgid,
> +			.stack_id = pelem->stack_id,
> +			.state = pelem->state,
> +		};
> +		__u64 delta = ts - pelem->timestamp;
> +		__u64 *total;
> +
> +		total = bpf_map_lookup_elem(&off_cpu, &key);
> +		if (total)
> +			*total += delta;
> +		else
> +			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
> +
> +		/* prevent to reuse the timestamp later */
> +		pelem->timestamp = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> new file mode 100644
> index 000000000000..4113bd19a2e4
> --- /dev/null
> +++ b/tools/perf/util/off_cpu.h
> @@ -0,0 +1,22 @@
> +#ifndef PERF_UTIL_OFF_CPU_H
> +#define PERF_UTIL_OFF_CPU_H
> +
> +struct evlist;
> +struct perf_session;
> +
> +#ifdef HAVE_BPF_SKEL
> +int off_cpu_prepare(struct evlist *evlist);
> +int off_cpu_write(struct perf_session *session);
> +#else
> +static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline int off_cpu_write(struct perf_session *session __maybe_unused)
> +{
> +	return -1;
> +}
> +#endif
> +
> +#endif  /* PERF_UTIL_OFF_CPU_H */
> -- 
> 2.36.0.512.ge40c2bad7a-goog

-- 

- Arnaldo
