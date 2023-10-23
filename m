Return-Path: <bpf+bounces-13008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA827D393D
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5666C1C20A75
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A91B295;
	Mon, 23 Oct 2023 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMwLGxvN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386E637;
	Mon, 23 Oct 2023 14:24:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F3B3;
	Mon, 23 Oct 2023 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698071051; x=1729607051;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9ZBt9BAMb07zsLNieeIaaNHAXHF6S1JGkj5qybE2s3A=;
  b=hMwLGxvNtSpbw9YtAtK9Z/hL+RThHf/RdrpG2/niWhVonqtlGLjV0PeI
   67loshUgUNY2jz8Nae2iu9nK7LoSsyBtgvEwG+E6n8TVQHlhwZwyPM/2F
   Vu0cm4ATCYZeXxEXp2bT6snxPCr8rbVNakCLg2cQBS1bMamqYTJY4Rq4d
   A54isO3mx0bP7WyZQdLAWEvnY4N+s8VcciaKUVBnP4EjH+CjrBzxWi7Lh
   uMNWJp5qb7H1Bm3Tp9FFMnXpFbMXa+SRBnuzDpoGXZy3SIyVvWGksG7jS
   IokL1B4aR3WlbWpwANxSfZ4arLQMVYqfhrly0+xFe0suGIJXQZPVuzbHb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389696490"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389696490"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="874713473"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="874713473"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.40.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:24:04 -0700
Message-ID: <c04c196a-3f29-4b89-97a7-5e71def3d3ce@intel.com>
Date: Mon, 23 Oct 2023 17:24:00 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by
 default
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>,
 Song Liu <song@kernel.org>, Sandipan Das <sandipan.das@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Artem Savkov <asavkov@redhat.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andi Kleen
 <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20231012062359.1616786-1-irogers@google.com>
 <20231012062359.1616786-14-irogers@google.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231012062359.1616786-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/23 09:23, Ian Rogers wrote:
> struct thread values hold onto references to mmaps, dsos, etc. When a
> thread exits it is necessary to clean all of this memory up by
> removing the thread from the machine's threads. Some tools require
> this doesn't happen, such as perf report if offcpu events exist or if
> a task list is being generated, so add a symbol_conf value to make the
> behavior optional. When an exited thread is left in the machine's
> threads, mark it as exited.
> 
> This change relates to commit 40826c45eb0b ("perf thread: Remove
> notion of dead threads"). Dead threads were removed as they had a
> reference count of 0 and were difficult to reason about with the
> reference count checker. Here a thread is removed from threads when it
> exits, unless via symbol_conf the exited thread isn't remove and is
> marked as exited. Reference counting behaves as it normally does.

Can we exclude AUX area tracing?

Essentially, the EXIT event happens when the task is still running
in kernel mode, so the thread has not in fact fully exited.

Example:

# perf record -a --kcore -e intel_pt// uname

Before:

# perf script --itrace=b --show-task-events -C6 | grep -C10 EXIT
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) => ffffffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) => ffffffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) => ffffffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) => ffffffffb6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) => ffffffffb6322040 perf_output_begin+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb6322085 perf_output_begin+0x45 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) => ffffffffb611d280 preempt_count_add+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) => ffffffffb63220d3 perf_output_begin+0x93 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) => ffffffffb63220ff perf_output_begin+0xbf ([kernel.kallsyms])
           uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740):(14739:14739)
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) => ffffffffb6322128 perf_output_begin+0xe8 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) => ffffffffb63220ea perf_output_begin+0xaa ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) => ffffffffb63221ab perf_output_begin+0x16b ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) => ffffffffb63221b6 perf_output_begin+0x176 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) => ffffffffb6322167 perf_output_begin+0x127 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) => ffffffffb631696b perf_event_task_output+0x9b ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) => ffffffffb61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb61034bc __task_pid_nr_ns+0x1c ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) => ffffffffb610353b __task_pid_nr_ns+0x9b ([kernel.kallsyms])

After:

$ perf script --itrace=b --show-task-events -C6 | grep -C10 EXIT
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) => ffffffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) => ffffffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) => ffffffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) => ffffffffb6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) => ffffffffb6322040 perf_output_begin+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb6322085 perf_output_begin+0x45 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) => ffffffffb611d280 preempt_count_add+0x0 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) => ffffffffb63220d3 perf_output_begin+0x93 ([kernel.kallsyms])
           uname   14740 [006] 26795.092638:          1   branches:  ffffffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) => ffffffffb63220ff perf_output_begin+0xbf ([kernel.kallsyms])
           uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740):(14739:14739)
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) => ffffffffb6322128 perf_output_begin+0xe8 ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) => ffffffffb63220ea perf_output_begin+0xaa ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) => ffffffffb63221ab perf_output_begin+0x16b ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) => ffffffffb63221b6 perf_output_begin+0x176 ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) => ffffffffb6322167 perf_output_begin+0x127 ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) => ffffffffb631696b perf_event_task_output+0x9b ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) => ffffffffb61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) => ffffffffb6194dc0 __rcu_read_lock+0x0 ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) => ffffffffb61034bc __task_pid_nr_ns+0x1c ([kernel.kallsyms])
          :14740   14740 [006] 26795.092638:          1   branches:  ffffffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) => ffffffffb610353b __task_pid_nr_ns+0x9b ([kernel.kallsyms])

This will also affect samples made after PERF_RECORD_EXIT but before
the task finishes exiting.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-report.c   |  7 +++++++
>  tools/perf/util/machine.c     | 10 +++++++---
>  tools/perf/util/symbol_conf.h |  3 ++-
>  tools/perf/util/thread.h      | 14 ++++++++++++++
>  4 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dcedfe00f04d..749246817aed 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
>  	if (ret < 0)
>  		goto exit;
>  
> +	/*
> +	 * tasks_mode require access to exited threads to list those that are in
> +	 * the data file. Off-cpu events are synthesized after other events and
> +	 * reference exited threads.
> +	 */
> +	symbol_conf.keep_exited_threads = true;
> +
>  	annotation_options__init(&report.annotation_opts);
>  
>  	ret = perf_config(report__config, &report);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 6ca7500e2cf4..5cda47eb337d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
>  	if (dump_trace)
>  		perf_event__fprintf_task(event, stdout);
>  
> -	if (thread != NULL)
> -		thread__put(thread);
> -
> +	if (thread != NULL) {
> +		if (symbol_conf.keep_exited_threads)
> +			thread__set_exited(thread, /*exited=*/true);
> +		else
> +			machine__remove_thread(machine, thread);
> +	}
> +	thread__put(thread);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 2b2fb9e224b0..6040286e07a6 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -43,7 +43,8 @@ struct symbol_conf {
>  			disable_add2line_warn,
>  			buildid_mmap2,
>  			guest_code,
> -			lazy_load_kernel_maps;
> +			lazy_load_kernel_maps,
> +			keep_exited_threads;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index e79225a0ea46..0df775b5c110 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -36,13 +36,22 @@ struct thread_rb_node {
>  };
>  
>  DECLARE_RC_STRUCT(thread) {
> +	/** @maps: mmaps associated with this thread. */
>  	struct maps		*maps;
>  	pid_t			pid_; /* Not all tools update this */
> +	/** @tid: thread ID number unique to a machine. */
>  	pid_t			tid;
> +	/** @ppid: parent process of the process this thread belongs to. */
>  	pid_t			ppid;
>  	int			cpu;
>  	int			guest_cpu; /* For QEMU thread */
>  	refcount_t		refcnt;
> +	/**
> +	 * @exited: Has the thread had an exit event. Such threads are usually
> +	 * removed from the machine's threads but some events/tools require
> +	 * access to dead threads.
> +	 */
> +	bool			exited;
>  	bool			comm_set;
>  	int			comm_len;
>  	struct list_head	namespaces_list;
> @@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
>  	return &RC_CHK_ACCESS(thread)->refcnt;
>  }
>  
> +static inline void thread__set_exited(struct thread *thread, bool exited)
> +{
> +	RC_CHK_ACCESS(thread)->exited = exited;
> +}
> +
>  static inline bool thread__comm_set(const struct thread *thread)
>  {
>  	return RC_CHK_ACCESS(thread)->comm_set;


