Return-Path: <bpf+bounces-54589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826CA6D2E0
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 02:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7863C7A3910
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064B41C85;
	Mon, 24 Mar 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETEkej1t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FB1362;
	Mon, 24 Mar 2025 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780943; cv=none; b=oMoFnmkSpJFi6EB66o7lRTygQLEL4L8AdX7AFTBtUdrEVsH74NtXQxM6TXveYbNR82FlSOCc8P5N1xKiytA7kY4oPXTSTbKETVqOcK1A0wVlD0Iw/l6pqZj3LsOmUVvMgQohncjMGwSfjt8/oCRBHrZsPQKEJmKTlReKYR3B6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780943; c=relaxed/simple;
	bh=YV3k6Xdqyx4/ZDEUvtVUbTKz4NlDiLBTYIM4gctsH9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uExk9bmB0TosCdDHDZUwOdcluX1SnAejzR4D+mSJTIlTyR7qDKrQmNFRxli5yXv6NqxYCe+oolqlQ7bTlEty0ORt+RvEbUsT93GGr4PbnQPA447QR3ChIVaUJ502CcEIyliII7oF3e/EC/+ZD8K+hdTVpYtiCJGeOkN711+w8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETEkej1t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227a8cdd241so17192215ad.3;
        Sun, 23 Mar 2025 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742780941; x=1743385741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXOQskcOJsN7Rmd723/wQRi5Q5/ziF69kqzxyWTLnlg=;
        b=ETEkej1tUPTduJH+M+hbWu5z+/hcGF9hBrP44SV9VpeLJjKmJ9DLQo7PuLJALcg+uG
         uEpp2k5NvF3aJsmFlK589DBYYxkXns6aw+bro/NZ0XBppdMCshKktABmscxSxmVP7SB3
         rrNIHHuU23lA8yK+nQnjhQdSEzx/nvFbAcv4pd3EbYwASYvowhtgGsxLbIVqYcJzcyIq
         74+wz/civqMU/gNjQcBgXNfTWRHbjNjOst2GWsimI5fQ+qhd2yX8ZKIvYdicQZDwZWW7
         zIWA0ke29bsWcNBC8nYXCzCOREhPkyXiIwLL15gdg4I/arGsuwJaXdJO7YsWITky2fRx
         Gtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742780941; x=1743385741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXOQskcOJsN7Rmd723/wQRi5Q5/ziF69kqzxyWTLnlg=;
        b=DV9/nkz3+9MhO5QkEbCT7OtCW9SK8+Qj/gT67RtKa0XIPAo9svjFIrpvVHhsrcnYWI
         6gr0D4zm6Ylpks7zvWOm0LGkq6eLwM1xNRZiHkuoQenI+Azjyk7WqJseARoFM+dg/fcY
         +JlauWo3jQj87vj0V4/m+AnPGOjZV4K58xuOdKoQQmmWBo+8RVynNnhoj96kgs4nUUpn
         8lo7VFKufWucKwNnDtIVsc5oPLxkHNX3qQ5ZjGn//KQxKKQAmVayXJbVgpmCbAvJte7W
         AmZ3Ydjf5d6maOdnaJmPCLZbw5bRvRUIny8DB5UzNhKNarf8fCdaPjqp3MvrdlyEXnlN
         wFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNBmsSBkDxoL1HIiEUEWbB7At88VV/CI/60weaVEZjJPk3UGWnkLBV07H+oSc6jEY5R0=@vger.kernel.org, AJvYcCVpwPu0nhBrW8KE+GqcJhqudkS4m6Ew6D8mw/Tpl53LnrDH1No9TEcnbJ9r1MVgJp5+U3eZPdxblpJTxg26@vger.kernel.org, AJvYcCWGMsXhsfuvqqG8iKtaa/fjdBTErVwvWzH8SjbORhDbNskec9vtl8LWdaj/A3mYRYCQ3rgRopfdNAgGk3Z1JLFcZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9IRm227AHIIXEqe2eCNxa9WoHOV+pyV3uVQ434QVoTHew567
	U5uWW47ZYJoT/6nH5XZvTcyqlUiNMbmQ2eBVoze+L2jb81+QdSRk
X-Gm-Gg: ASbGncv4Dg1uJ0lIfQMLzCWPkGQOkcAfLGChwr1eql86vPEBzLfRcqCxMBjPLnvazaI
	PLyLt3E2kMqJJa4d881zpuDRBYkn6Us/IU620ixM9/nBYvkw1K1I4cPMkEikMgB+Hi08L8YJQLZ
	qIWfzJg20wpNI/LR8EYp6G48QrRHplM+E8/QHLkZF/lWCiB9d0QvzR4JtQyZ9ngBxKU7Zcz1hnv
	ZKyQwTFHSIpLJtPAOnLaGG5ZAPl8IrjNTr3Pfjo94X/xG1MJSBFhUwcNFA2upaotsjdACMg/hZv
	io92FMi1oy6wqYovFyB4ZevizuQhFUnu2Gr2H0MEgZ+wK63zNcP58ubD4dG8PCFYJxT3ywkViUz
	RtPLsNh5wCsCNPA==
X-Google-Smtp-Source: AGHT+IFFx/16qR05KKlDPtLD2SFdvl1sDcaa4WdsceekmmAJR82UCRJCOT1JxXLSuuP22jYSfdE6OA==
X-Received: by 2002:a05:6a20:3942:b0:1f5:7007:9ea5 with SMTP id adf61e73a8af0-1fe42f2a027mr18737452637.2.1742780940623;
        Sun, 23 Mar 2025 18:49:00 -0700 (PDT)
Received: from gmail.com (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a280e572sm5891967a12.32.2025.03.23.18.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 18:49:00 -0700 (PDT)
Date: Sun, 23 Mar 2025 18:48:57 -0700
From: Howard Chu <howardchu95@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3] perf trace: Implement syscall summary in BPF
Message-ID: <Z-C6CdVXohPJSjzu@gmail.com>
References: <20250321184255.2809370-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321184255.2809370-1-namhyung@kernel.org>

Hello Namhyung,

On Fri, Mar 21, 2025 at 11:42:55AM -0700, Namhyung Kim wrote:
> When -s/--summary option is used, it doesn't need (augmented) arguments
> of syscalls.  Let's skip the augmentation and load another small BPF
> program to collect the statistics in the kernel instead of copying the
> data to the ring-buffer to calculate the stats in userspace.  This will
> be much more light-weight than the existing approach and remove any lost
> events.
> 
> Let's add a new option --bpf-summary to control this behavior.  I cannot
> make it default because there's no way to get e_machine in the BPF which
> is needed for detecting different ABIs like 32-bit compat mode.
> 
> No functional changes intended except for no more LOST events. :)  But
> it only works with -a/--all-cpus for now.
> 
>   $ sudo ./perf trace -as --summary-mode=total --bpf-summary sleep 1
> 
>    Summary of events:
> 
>    total, 6194 events
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      epoll_wait           561      0  4530.843     0.000     8.076   520.941     18.75%
>      futex                693     45  4317.231     0.000     6.230   500.077     21.98%
>      poll                 300      0  1040.109     0.000     3.467   120.928     17.02%
>      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.172      0.00%
>      ppoll                360      0   872.386     0.001     2.423   253.275     41.91%
>      epoll_pwait           14      0   384.349     0.001    27.453   380.002     98.79%
>      pselect6              14      0   108.130     7.198     7.724     8.206      0.85%
>      nanosleep             39      0    43.378     0.069     1.112    10.084     44.23%
>      ...
> 
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v3)
>  * support -S/--with-summary option too  (Howard)

It gave me segfault somehow. 

(gdb) bt
#0  sighandler_dump_stack (sig=32767) at util/debug.c:322
#1  <signal handler called>
#2  0x00005555556d2383 in hashmap_find ()
#3  0x000055555567474a in thread__update_stats (thread=0x5555564acc60, ttrace=0x5555564ad7a0, id=0, sample=0x7fffffff8f10, err=1,
    trace=0x7fffffffb1a0) at builtin-trace.c:2616
#4  0x00005555556757cb in trace__sys_exit (trace=0x7fffffffb1a0, evsel=0x5555561879d0, event=0x7fffed980000, sample=0x7fffffff8f10)
    at builtin-trace.c:2924
#5  0x0000555555677e1b in trace__handle_event (trace=0x7fffffffb1a0, event=0x7fffed980000, sample=0x7fffffff8f10) at builtin-trace.c:3619
#6  0x00005555556796fb in __trace__deliver_event (trace=0x7fffffffb1a0, event=0x7fffed980000) at builtin-trace.c:4173
#7  0x0000555555679859 in trace__deliver_event (trace=0x7fffffffb1a0, event=0x7fffed980000) at builtin-trace.c:4201
#8  0x000055555567abed in trace__run (trace=0x7fffffffb1a0, argc=2, argv=0x7fffffffeb30) at builtin-trace.c:4590
#9  0x000055555567f102 in cmd_trace (argc=2, argv=0x7fffffffeb30) at builtin-trace.c:5803
#10 0x0000555555685252 in run_builtin (p=0x5555560eaf28 <commands+648>, argc=7, argv=0x7fffffffeb30) at perf.c:351
#11 0x00005555556854fd in handle_internal_command (argc=7, argv=0x7fffffffeb30) at perf.c:404
#12 0x000055555568565e in run_argv (argcp=0x7fffffffe91c, argv=0x7fffffffe910) at perf.c:448
#13 0x00005555556859af in main (argc=7, argv=0x7fffffffeb30) at perf.c:556

>  * make it work only with -a/--all-cpus  (Howard)
>  * fix stddev calculation  (Howard)
>  * add some comments about syscall_data  (Howard)
> 
> v2)
>  * Rebased on top of Ian's e_machine changes
>  * add --bpf-summary option
>  * support per-thread summary
>  * add stddev calculation  (Howard)
> 
>  tools/perf/Documentation/perf-trace.txt       |   6 +
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-trace.c                    |  51 ++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf-trace-summary.c           | 347 ++++++++++++++++++
>  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 118 ++++++
>  tools/perf/util/bpf_skel/syscall_summary.h    |  25 ++
>  tools/perf/util/trace.h                       |  37 ++
>  8 files changed, 574 insertions(+), 13 deletions(-)
>  create mode 100644 tools/perf/util/bpf-trace-summary.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
>  create mode 100644 tools/perf/util/trace.h
> 
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index 887dc37773d0f4d6..a8a0d8c33438fef7 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -251,6 +251,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
>  	better pretty-print integer flags and struct pointers.
>  
> +--bpf-summary::
> +	Collect system call statistics in BPF.  This is only for live mode and
> +	works well with -s/--summary option where no argument information is
> +	required.
> +
> +
>  PAGEFAULTS
>  ----------
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f3cd8de15d1a2681..d7a7e0c68fc10b8b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1206,7 +1206,7 @@ SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
>  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
>  SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
>  SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
> -SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
> +SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
>  SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
>  SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
>  
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 439e152186daf38b..71822161956827a7 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -55,6 +55,7 @@
>  #include "util/thread_map.h"
>  #include "util/stat.h"
>  #include "util/tool.h"
> +#include "util/trace.h"
>  #include "util/util.h"
>  #include "trace/beauty/beauty.h"
>  #include "trace-event.h"
> @@ -141,12 +142,6 @@ struct syscall_fmt {
>  	bool	   hexret;
>  };
>  
> -enum summary_mode {
> -	SUMMARY__NONE = 0,
> -	SUMMARY__BY_TOTAL,
> -	SUMMARY__BY_THREAD,
> -};
> -
>  struct trace {
>  	struct perf_tool	tool;
>  	struct {
> @@ -205,7 +200,7 @@ struct trace {
>  	} stats;
>  	unsigned int		max_stack;
>  	unsigned int		min_stack;
> -	enum summary_mode	summary_mode;
> +	enum trace_summary_mode	summary_mode;
>  	int			raw_augmented_syscalls_args_size;
>  	bool			raw_augmented_syscalls;
>  	bool			fd_path_disabled;
> @@ -234,6 +229,7 @@ struct trace {
>  	bool			force;
>  	bool			vfs_getname;
>  	bool			force_btf;
> +	bool			summary_bpf;
>  	int			trace_pgfaults;
>  	char			*perfconfig_events;
>  	struct {
> @@ -4371,6 +4367,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	trace->live = true;
>  
> +	if (trace->summary_bpf) {
> +		if (trace_prepare_bpf_summary(trace->summary_mode) < 0)
> +			goto out_delete_evlist;
> +
> +		if (trace->summary_only)
> +			goto create_maps;
> +	}
> +
>  	if (!trace->raw_augmented_syscalls) {
>  		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
>  			goto out_error_raw_syscalls;
> @@ -4429,6 +4433,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	if (trace->cgroup)
>  		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
>  
> +create_maps:
>  	err = evlist__create_maps(evlist, &trace->opts.target);
>  	if (err < 0) {
>  		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
> @@ -4441,7 +4446,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		goto out_delete_evlist;
>  	}
>  
> -	if (trace->summary_mode == SUMMARY__BY_TOTAL) {
> +	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
>  		trace->syscall_stats = alloc_syscall_stats();
>  		if (trace->syscall_stats == NULL)
>  			goto out_delete_evlist;
> @@ -4527,9 +4532,11 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	if (err < 0)
>  		goto out_error_apply_filters;
>  
> -	err = evlist__mmap(evlist, trace->opts.mmap_pages);
> -	if (err < 0)
> -		goto out_error_mmap;
> +	if (!trace->summary_only || !trace->summary_bpf) {
> +		err = evlist__mmap(evlist, trace->opts.mmap_pages);
> +		if (err < 0)
> +			goto out_error_mmap;
> +	}
>  
>  	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
>  		evlist__enable(evlist);
> @@ -4542,6 +4549,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		evlist__enable(evlist);
>  	}
>  
> +	if (trace->summary_bpf)
> +		trace_start_bpf_summary();
> +
>  	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
>  		perf_thread_map__nr(evlist->core.threads) > 1 ||
>  		evlist__first(evlist)->core.attr.inherit;
> @@ -4609,12 +4619,17 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	evlist__disable(evlist);
>  
> +	if (trace->summary_bpf)
> +		trace_end_bpf_summary();
> +
>  	if (trace->sort_events)
>  		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
>  
>  	if (!err) {
>  		if (trace->summary) {
> -			if (trace->summary_mode == SUMMARY__BY_TOTAL)
> +			if (trace->summary_bpf)
> +				trace_print_bpf_summary(trace->output);
> +			else if (trace->summary_mode == SUMMARY__BY_TOTAL)
>  				trace__fprintf_total_summary(trace, trace->output);
>  			else
>  				trace__fprintf_thread_summary(trace, trace->output);
> @@ -4630,6 +4645,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	}
>  
>  out_delete_evlist:
> +	trace_cleanup_bpf_summary();
>  	delete_syscall_stats(trace->syscall_stats);
>  	trace__symbols__exit(trace);
>  	evlist__free_syscall_tp_fields(evlist);
> @@ -5465,6 +5481,7 @@ int cmd_trace(int argc, const char **argv)
>  		     "start"),
>  	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
>  		       "to customized ones"),
> +	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
>  	OPTS_EVSWITCH(&trace.evswitch),
>  	OPT_END()
>  	};
> @@ -5556,6 +5573,16 @@ int cmd_trace(int argc, const char **argv)
>  		goto skip_augmentation;
>  	}
>  
> +	if (trace.summary_bpf) {
> +		if (!trace.opts.target.system_wide) {
> +			/* TODO: Add filters in the BPF to support other targets. */
> +			pr_err("Error: --bpf-summary only works for system-wide mode.\n");
> +			goto out;
> +		}
> +		if (trace.summary_only)
> +			goto skip_augmentation;
> +	}
> +
>  	trace.skel = augmented_raw_syscalls_bpf__open();
>  	if (!trace.skel) {
>  		pr_debug("Failed to open augmented syscalls BPF skeleton");
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 034a6603d5a8e8b0..ba4201a6f3c69753 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -171,6 +171,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
> +perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
>  
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
> new file mode 100644
> index 0000000000000000..1eadc00c46056747
> --- /dev/null
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -0,0 +1,347 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <inttypes.h>
> +#include <math.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "dwarf-regs.h" /* for EM_HOST */
> +#include "syscalltbl.h"
> +#include "util/hashmap.h"
> +#include "util/trace.h"
> +#include "util/util.h"
> +#include <bpf/bpf.h>
> +#include <linux/time64.h>
> +#include <tools/libc_compat.h> /* reallocarray */
> +
> +#include "bpf_skel/syscall_summary.h"
> +#include "bpf_skel/syscall_summary.skel.h"
> +
> +
> +static struct syscall_summary_bpf *skel;
> +
> +int trace_prepare_bpf_summary(enum trace_summary_mode mode)
> +{
> +	skel = syscall_summary_bpf__open();
> +	if (skel == NULL) {
> +		fprintf(stderr, "failed to open syscall summary bpf skeleton\n");
> +		return -1;
> +	}
> +
> +	if (mode == SUMMARY__BY_THREAD)
> +		skel->rodata->aggr_mode = SYSCALL_AGGR_THREAD;
> +	else
> +		skel->rodata->aggr_mode = SYSCALL_AGGR_CPU;
> +
> +	if (syscall_summary_bpf__load(skel) < 0) {
> +		fprintf(stderr, "failed to load syscall summary bpf skeleton\n");
> +		return -1;
> +	}
> +
> +	if (syscall_summary_bpf__attach(skel) < 0) {
> +		fprintf(stderr, "failed to attach syscall summary bpf skeleton\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +void trace_start_bpf_summary(void)
> +{
> +	skel->bss->enabled = 1;
> +}
> +
> +void trace_end_bpf_summary(void)
> +{
> +	skel->bss->enabled = 0;
> +}
> +
> +struct syscall_node {
> +	int syscall_nr;
> +	struct syscall_stats stats;
> +};
> +
> +static double rel_stddev(struct syscall_stats *stat)
> +{
> +	double variance, average;
> +
> +	if (stat->count < 2)
> +		return 0;
> +
> +	average = (double)stat->total_time / stat->count;
> +
> +	variance = stat->squared_sum;
> +	variance -= (stat->total_time * stat->total_time) / stat->count;
> +	variance /= stat->count - 1;
> +
> +	return 100 * sqrt(variance / stat->count) / average;
> +}
> +
> +/*
> + * The syscall_data is to maintain syscall stats ordered by total time.
> + * It support different summary mode like per-thread or global.

nit: It supports different summary modes like per-thread or global.

> + *
> + * For per-thread stats, it uses two-level data strurcture -
> + * syscall_data is keyed by TID and has an array of nodes which
> + * represents each syscall for the thread.
> + *
> + * For global stats, it's still two-level technically but we don't need
> + * per-cpu analysis so it's keyed by the syscall number to combine stats
> + * from different CPUs.  And syscall_data always has a syscall_node so
> + * it can effectively work as flat hierarchy.
> + */
> +struct syscall_data {
> +	int key; /* tid if AGGR_THREAD, syscall-nr if AGGR_CPU */
> +	int nr_events;
> +	int nr_nodes;
> +	u64 total_time;
> +	struct syscall_node *nodes;
> +};
> +
> +static int datacmp(const void *a, const void *b)
> +{
> +	const struct syscall_data * const *sa = a;
> +	const struct syscall_data * const *sb = b;
> +
> +	return (*sa)->total_time > (*sb)->total_time ? -1 : 1;
> +}
> +
> +static int nodecmp(const void *a, const void *b)
> +{
> +	const struct syscall_node *na = a;
> +	const struct syscall_node *nb = b;
> +
> +	return na->stats.total_time > nb->stats.total_time ? -1 : 1;
> +}
> +
> +static size_t sc_node_hash(long key, void *ctx __maybe_unused)
> +{
> +	return key;
> +}
> +
> +static bool sc_node_equal(long key1, long key2, void *ctx __maybe_unused)
> +{
> +	return key1 == key2;
> +}
> +
> +static int print_common_stats(struct syscall_data *data, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	for (int i = 0; i < data->nr_nodes; i++) {
> +		struct syscall_node *node = &data->nodes[i];
> +		struct syscall_stats *stat = &node->stats;
> +		double total = (double)(stat->total_time) / NSEC_PER_MSEC;
> +		double min = (double)(stat->min_time) / NSEC_PER_MSEC;
> +		double max = (double)(stat->max_time) / NSEC_PER_MSEC;
> +		double avg = total / stat->count;
> +		const char *name;
> +
> +		/* TODO: support other ABIs */
> +		name = syscalltbl__name(EM_HOST, node->syscall_nr);
> +		if (name)
> +			printed += fprintf(fp, "   %-15s", name);
> +		else
> +			printed += fprintf(fp, "   syscall:%-7d", node->syscall_nr);
> +
> +		printed += fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3f %9.2f%%\n",
> +				   stat->count, stat->error, total, min, avg, max,
> +				   rel_stddev(stat));
> +	}
> +	return printed;
> +}
> +
> +static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key,
> +			       struct syscall_stats *map_data)
> +{
> +	struct syscall_data *data;
> +	struct syscall_node *nodes;
> +
> +	if (!hashmap__find(hash, map_key->cpu_or_tid, &data)) {
> +		data = zalloc(sizeof(*data));
> +		if (data == NULL)
> +			return -ENOMEM;
> +
> +		data->key = map_key->cpu_or_tid;
> +		if (hashmap__add(hash, data->key, data) < 0) {
> +			free(data);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	/* update thread total stats */
> +	data->nr_events += map_data->count;
> +	data->total_time += map_data->total_time;
> +
> +	nodes = reallocarray(data->nodes, data->nr_nodes + 1, sizeof(*nodes));
> +	if (nodes == NULL)
> +		return -ENOMEM;
> +
> +	data->nodes = nodes;
> +	nodes = &data->nodes[data->nr_nodes++];
> +	nodes->syscall_nr = map_key->nr;
> +
> +	/* each thread has an entry for each syscall, just use the stat */
> +	memcpy(&nodes->stats, map_data, sizeof(*map_data));
> +	return 0;
> +}
> +
> +static int print_thread_stat(struct syscall_data *data, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	qsort(data->nodes, data->nr_nodes, sizeof(*data->nodes), nodecmp);
> +
> +	printed += fprintf(fp, " thread (%d), ", data->key);
> +	printed += fprintf(fp, "%d events\n\n", data->nr_events);
> +
> +	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
> +	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> +	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> +
> +	printed += print_common_stats(data, fp);
> +	printed += fprintf(fp, "\n\n");
> +
> +	return printed;
> +}
> +
> +static int print_thread_stats(struct syscall_data **data, int nr_data, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	for (int i = 0; i < nr_data; i++)
> +		printed += print_thread_stat(data[i], fp);
> +
> +	return printed;
> +}
> +
> +static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
> +			      struct syscall_stats *map_data)
> +{
> +	struct syscall_data *data;
> +	struct syscall_stats *stat;
> +
> +	if (!hashmap__find(hash, map_key, &data)) {

There is a bug that I missed in my previous review, this should be map_key->nr.

As I mentioned in v2's review, I discovered an anomaly, it reads:

"there is a difference between

sudo ./perf trace -as --summary-mode=total -- sleep 1
sudo ./perf trace -as --bpf-summary --summary-mode=total -- sleep 1

perf $ sudo ./perf trace -as --summary-mode=total -- sleep 1


 Summary of events:

 total, 15354 events

perf $ sudo ./perf trace -as --bpf-summary --summary-mode=total -- sleep 1


 Summary of events:

 total, 1319 events


without the --bpf-summary perf trace gave more events, and it ran
slower"

Turns out we are losing events because of finding with the wrong key.
The value of key 'syscall_nr' is actually present in the hashmap so
if hashmap__add() with the duplicated key, the function failed. It won't
cause memory leak because it returns right away.

This bug can be displayed using this diff:

diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index 1eadc00c4605..5fab33a2de3a 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -214,13 +214,21 @@ static int print_thread_stats(struct syscall_data **data, int nr_data, FILE *fp)
 	return printed;
 }
 
+int cnt;
+
 static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
 			      struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
 	struct syscall_stats *stat;
 
+	cnt += map_data->count;
 	if (!hashmap__find(hash, map_key, &data)) {
+		if (hashmap__find(hash, map_key->nr, &data)) {
+			printf("duplicated key\n");
+			printf("map_key->nr %d\n", map_key->nr);
+			printf("key %d nr_events %d nr_nodes %d total_time %lu nodes %p\n", data->key, data->nr_events, data->nr_nodes, data->total_time, data->nodes);
+		}
 		data = zalloc(sizeof(*data));
 		if (data == NULL)
 			return -ENOMEM;
@@ -238,6 +246,7 @@ static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
 		if (hashmap__add(hash, data->key, data) < 0) {
 			free(data->nodes);
 			free(data);
+			printf("failed\n");
 			return -ENOMEM;
 		}
 	}
@@ -270,6 +279,7 @@ static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
 	for (int i = 0; i < nr_data; i++)
 		nr_events += data[i]->nr_events;
 
+	printf("actual number of events: %d\n", cnt);
 	printed += fprintf(fp, " total, %d events\n\n", nr_events);
 
 	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");

> +		data = zalloc(sizeof(*data));
> +		if (data == NULL)
> +			return -ENOMEM;
> +
> +		data->nodes = zalloc(sizeof(*data->nodes));
> +		if (data->nodes == NULL) {
> +			free(data);
> +			return -ENOMEM;
> +		}
> +
> +		data->nr_nodes = 1;
> +		data->key = map_key->nr;
> +		data->nodes->syscall_nr = data->key;
> +
> +		if (hashmap__add(hash, data->key, data) < 0) {
> +			free(data->nodes);
> +			free(data);
> +			return -ENOMEM;
> +		}
> +	}

Thanks for recommending me mutt, this is the first review using mutt,
hope it reaches places.

Thanks,
Howard

