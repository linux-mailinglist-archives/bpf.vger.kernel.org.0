Return-Path: <bpf+bounces-38950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24C96CD8A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7CA1C22A75
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1867148FF3;
	Thu,  5 Sep 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWKxZD35"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB87FD;
	Thu,  5 Sep 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508871; cv=none; b=AF0s95soBATaR0TjT1SM368a/bHkD0Dxvulp/sX6SzpEQ1N9r/PaZAYEpFwB2dQVnTP2kbVhUBxElRUpPK513emU9nXJYkbFcITiO8drDR6+rj6Foj49f5Rfk+eIITSpI3XX4egLM15DR3XPJPiqL5O/JDzdrrMFEgqOjDPbiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508871; c=relaxed/simple;
	bh=Cq55vOaoUdNt9YDbuIEXFWORsEN46O+vPyE1Fey6dCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT0oladQXdZYWJDC5xJ0a43mE2f9bOss+Y110+IFBWkvsVwBaLSHMhM1Uty9hnS2bt2A8GFQG1JDXhBVISGUqaXFXMHdq3DIKLRhJ1tEkPm1ZvKvVJMRXUmM6MhsIis58p1vq5y0gQR2cxUY8TAZvjaqaWF0tOAdnDAkvwaQcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWKxZD35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804D4C4CEC4;
	Thu,  5 Sep 2024 04:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725508871;
	bh=Cq55vOaoUdNt9YDbuIEXFWORsEN46O+vPyE1Fey6dCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWKxZD35iM+uwhzfINmvNi4M5OHGM/MvTYbuc31bblal1XIXPPeEw4XrBPd6Eyj4U
	 /vzRNPiujP4SHWSEDWEfqcwUwm780j5z9bM4m7vE6+rdU/g4UXNIvp0wft1jbt85Jt
	 ocpTXOW28XAD4Wu0LoHcxjhAZ2s74UdAmVuQZDNeI6ql0/Y0pymUw3DDWtKyV74Ob3
	 V60aAVKp1WPlZnKoRW6QCAhk0Wz+xwJhsayZjxfXGz+GeMUeOFI6MUDrBJGYZ/fNeH
	 gCIDYGU+i3STD4ZwkLNEuNXJ4IT581GcPX1HKo3aAeptD0JtNzv5CSl2eWLA0cHMtF
	 M30uW1QkEbenA==
Date: Wed, 4 Sep 2024 21:01:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <ZtktBbcjSdVt4WtJ@google.com>
References: <20240904123103.732507-1-wutengda@huaweicloud.com>
 <20240904123103.732507-2-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904123103.732507-2-wutengda@huaweicloud.com>

Hello,

On Wed, Sep 04, 2024 at 12:31:02PM +0000, Tengda Wu wrote:
> bperf has a nice ability to share PMUs, but it still does not support
> inherit events during fork(), resulting in some deviations in its stat
> results compared with perf.
> 
> perf stat result:
>   $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
> 
>    Performance counter stats for './perf test -w sqrtloop':
> 
>        2,316,038,116      cycles
>        2,859,350,725      instructions                     #    1.23  insn per cycle
> 
>          1.009603637 seconds time elapsed
> 
>          1.004196000 seconds user
>          0.003950000 seconds sys
> 
> bperf stat result:
>   $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop
> 
>    Performance counter stats for './perf test -w sqrtloop':
> 
>           18,762,093      cycles
>           23,487,766      instructions                     #    1.25  insn per cycle
> 
>          1.008913769 seconds time elapsed
> 
>          1.003248000 seconds user
>          0.004069000 seconds sys
> 
> In order to support event inheritance, two new bpf programs are added
> to monitor the fork and exit of tasks respectively. When a task is
> created, add it to the filter map to enable counting, and reuse the
> `accum_key` of its parent task to count together with the parent task.
> When a task exits, remove it from the filter map to disable counting.

Right, I think we may need this for other BPF programs.

> 
> After support:
>   $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop
> 
>    Performance counter stats for './perf test -w sqrtloop':
> 
>        2,316,543,537      cycles
>        2,859,677,779      instructions                     #    1.23  insn per cycle
> 
>          1.009566332 seconds time elapsed
> 
>          1.004414000 seconds user
>          0.003545000 seconds sys
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/bpf_counter.c                 |  9 +--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 75 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>  3 files changed, 78 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 7a8af60e0f51..e07ff04b934f 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -529,9 +529,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	/* set up reading map */
>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>  				 filter_entry_cnt);
> -	/* set up follower filter based on target */
> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> -				 filter_entry_cnt);
>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>  	if (err) {
>  		pr_err("Failed to load follower skeleton\n");
> @@ -543,6 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	for (i = 0; i < filter_entry_cnt; i++) {
>  		int filter_map_fd;
>  		__u32 key;
> +		struct bperf_filter_value fval = { i, 0 };
>  
>  		if (filter_type == BPERF_FILTER_PID ||
>  		    filter_type == BPERF_FILTER_TGID)
> @@ -553,10 +551,11 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  			break;
>  
>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>  	}
>  
>  	evsel->follower_skel->bss->type = filter_type;
> +	evsel->follower_skel->bss->init_filter_entries = filter_entry_cnt;

Do you need this in the BPF program?

>  
>  	err = bperf_follower_bpf__attach(evsel->follower_skel);
>  
> @@ -623,7 +622,7 @@ static int bperf__read(struct evsel *evsel)
>  	bperf_sync_counters(evsel);
>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>  
> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +	for (i = 0; i < skel->bss->init_filter_entries; i++) {
>  		struct perf_cpu entry;
>  		__u32 cpu;
>  
> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index f193998530d4..59fab421526a 100644
> --- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -5,6 +5,8 @@
>  #include <bpf/bpf_tracing.h>
>  #include "bperf_u.h"
>  
> +#define MAX_ENTRIES 102400
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>  	__uint(key_size, sizeof(__u32));
> @@ -22,25 +24,29 @@ struct {
>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
>  	__uint(key_size, sizeof(__u32));
> -	__uint(value_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bperf_filter_value));
> +	__uint(max_entries, MAX_ENTRIES);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>  } filter SEC(".maps");
>  
>  enum bperf_filter_type type = 0;
>  int enabled = 0;
> +__u32 init_filter_entries = 0;
>  
>  SEC("fexit/XXX")
>  int BPF_PROG(fexit_XXX)
>  {
>  	struct bpf_perf_event_value *diff_val, *accum_val;
>  	__u32 filter_key, zero = 0;
> -	__u32 *accum_key;
> +	__u32 accum_key;
> +	struct bperf_filter_value *fval;
>  
>  	if (!enabled)
>  		return 0;
>  
>  	switch (type) {
>  	case BPERF_FILTER_GLOBAL:
> -		accum_key = &zero;
> +		accum_key = zero;
>  		goto do_add;
>  	case BPERF_FILTER_CPU:
>  		filter_key = bpf_get_smp_processor_id();
> @@ -55,16 +61,20 @@ int BPF_PROG(fexit_XXX)
>  		return 0;
>  	}
>  
> -	accum_key = bpf_map_lookup_elem(&filter, &filter_key);
> -	if (!accum_key)
> +	fval = bpf_map_lookup_elem(&filter, &filter_key);
> +	if (!fval)
>  		return 0;
>  
> +	accum_key = fval->accum_key;
> +	if (fval->exited)
> +		bpf_map_delete_elem(&filter, &filter_key);
> +
>  do_add:
>  	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
>  	if (!diff_val)
>  		return 0;
>  
> -	accum_val = bpf_map_lookup_elem(&accum_readings, accum_key);
> +	accum_val = bpf_map_lookup_elem(&accum_readings, &accum_key);
>  	if (!accum_val)
>  		return 0;
>  
> @@ -75,4 +85,57 @@ int BPF_PROG(fexit_XXX)
>  	return 0;
>  }
>  
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
> +{
> +	__u32 parent_pid, child_pid;
> +	struct bperf_filter_value *parent_fval;
> +	struct bperf_filter_value child_fval = { 0 };
> +
> +	if (!enabled)
> +		return 0;
> +
> +	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
> +		return 0;

I think you can load/attach this program only if the type is either
PID or TGID.  Then it'd reduce the overhead.

> +
> +	parent_pid = bpf_get_current_pid_tgid() >> 32;
> +	child_pid = task->pid;
> +
> +	/* Check if the current task is one of the target tasks to be counted */
> +	parent_fval = bpf_map_lookup_elem(&filter, &parent_pid);
> +	if (!parent_fval)
> +		return 0;
> +
> +	/* Start counting for the new task by adding it into filter map,
> +	 * inherit the accum key of its parent task so that they can be
> +	 * counted together.
> +	 */
> +	child_fval.accum_key = parent_fval->accum_key;
> +	child_fval.exited = 0;
> +	bpf_map_update_elem(&filter, &child_pid, &child_fval, BPF_NOEXIST);
> +
> +	return 0;
> +}
> +
> +SEC("tp_btf/sched_process_exit")
> +int BPF_PROG(on_exittask, struct task_struct *task)
> +{
> +	__u32 pid;
> +	struct bperf_filter_value *fval;
> +
> +	if (!enabled)
> +		return 0;
> +
> +	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
> +		return 0;

Ditto.

Thanks,
Namhyung

> +
> +	/* Stop counting for this task by removing it from filter map */
> +	pid = task->pid;
> +	fval = bpf_map_lookup_elem(&filter, &pid);
> +	if (fval)
> +		fval->exited = 1;
> +
> +	return 0;
> +}
> +
>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/bpf_skel/bperf_u.h b/tools/perf/util/bpf_skel/bperf_u.h
> index 1ce0c2c905c1..4a4a753980be 100644
> --- a/tools/perf/util/bpf_skel/bperf_u.h
> +++ b/tools/perf/util/bpf_skel/bperf_u.h
> @@ -11,4 +11,9 @@ enum bperf_filter_type {
>  	BPERF_FILTER_TGID,
>  };
>  
> +struct bperf_filter_value {
> +	__u32 accum_key;
> +	__u8 exited;
> +};
> +
>  #endif /* __BPERF_STAT_U_H */
> -- 
> 2.34.1
> 

