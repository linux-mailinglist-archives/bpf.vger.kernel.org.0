Return-Path: <bpf+bounces-39909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206079792C7
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 20:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8657E1F223CC
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D01D1720;
	Sat, 14 Sep 2024 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZbmm690"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E51D0DC8;
	Sat, 14 Sep 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726336931; cv=none; b=aKSO4Vh11UEkTYmhwBCbqB07z8w0JBuEa4H48c0ZECHmTsa/Owu5VPnAH7JhOzQHknG8+90K8eSKxAJTEgPDM14Y7grW32HWQYe5lSk55xgjNuK9UbQuT0DqLGhZaO933hoP/7qVR0KvBv8LfIpUGCLZ9XXIX58FhYXY6ylPUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726336931; c=relaxed/simple;
	bh=Cd6WnEOyRA+TWzUq0VVyyi56ju6z4TF6iuhJvc+2pYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKKSZlQcLHaj8idXj8UAYO7q6/D7Op+LBM+5Gss14Qx6Rz9NCNd+uWHNCf/+DpZV8JjK/vFo5e9De/VbLyvmYyvJrEevDLOhiiFcjcQlw8nqqQ93Jco9Ma++4Lp3GGW+MXKUjKOGWe2iiHokRcYRV8oNLGI0o81+G65iJ89/5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZbmm690; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B4C4CEC0;
	Sat, 14 Sep 2024 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726336930;
	bh=Cd6WnEOyRA+TWzUq0VVyyi56ju6z4TF6iuhJvc+2pYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZbmm6907EeZxyIx/GRqSivc62DfbfP3GnwGBb+AyZe9DU6p1B4s7Cvs8lg0YA+/s
	 xOen/k+77taHTXCBGPakvAPn12X5z1tw15D5OtFDgcrIPqMAMIvRiAGMO1dPFr/7kL
	 IAvqTFrDLysyq2B9uM0at027AnQL1ox4xIMuJ4P27gAkft+TS3o8nUmkY8iqCwLw7Q
	 TOoARlES6mvrXI31eXxUrZYn75c50TwYutpPQvrCvr8XfHOwExS5362lMB6y/DFQVh
	 PuaS+3xRRnzu8+WqH/u2e2ikqgQv7rNoY5NyP+XGLMJT2PU+e4H8DUlxzNwYo7ycJd
	 Iyuhot8vfUoJA==
Date: Sat, 14 Sep 2024 11:02:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <ZuXPn-VIkmH7iitG@google.com>
References: <20240905115918.772234-1-wutengda@huaweicloud.com>
 <20240905115918.772234-2-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905115918.772234-2-wutengda@huaweicloud.com>

Hello,

On Thu, Sep 05, 2024 at 11:59:17AM +0000, Tengda Wu wrote:
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
>  tools/perf/util/bpf_counter.c                 | 32 +++++++--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 70 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>  3 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 7a8af60e0f51..94aa46f50052 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -394,6 +394,7 @@ static int bperf_check_target(struct evsel *evsel,
>  }
>  
>  static	struct perf_cpu_map *all_cpu_map;
> +static __u32 filter_entry_cnt;
>  
>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  				       struct perf_event_attr_map_entry *entry)
> @@ -444,12 +445,31 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	return err;
>  }
>  
> +/* Attach programs on demand according to filter types to reduce overhead */
> +static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
> +					 enum bperf_filter_type filter_type)
> +{
> +	struct bpf_link *link;
> +	int err = 0;
> +
> +	if (filter_type == BPERF_FILTER_PID ||
> +	    filter_type == BPERF_FILTER_TGID)
> +		err = bperf_follower_bpf__attach(skel);
> +	else {
> +		link = bpf_program__attach(skel->progs.fexit_XXX);
> +		if (IS_ERR(link))
> +			err = PTR_ERR(link);
> +	}
> +
> +	return err;
> +}
> +
>  static int bperf__load(struct evsel *evsel, struct target *target)
>  {
>  	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
>  	int attr_map_fd, diff_map_fd = -1, err;
>  	enum bperf_filter_type filter_type;
> -	__u32 filter_entry_cnt, i;
> +	__u32 i;
>  
>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
>  		return -1;
> @@ -529,9 +549,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	/* set up reading map */
>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>  				 filter_entry_cnt);
> -	/* set up follower filter based on target */
> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> -				 filter_entry_cnt);
>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>  	if (err) {
>  		pr_err("Failed to load follower skeleton\n");
> @@ -543,6 +560,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	for (i = 0; i < filter_entry_cnt; i++) {
>  		int filter_map_fd;
>  		__u32 key;
> +		struct bperf_filter_value fval = { i, 0 };
>  
>  		if (filter_type == BPERF_FILTER_PID ||
>  		    filter_type == BPERF_FILTER_TGID)
> @@ -553,12 +571,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  			break;
>  
>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>  	}
>  
>  	evsel->follower_skel->bss->type = filter_type;
>  
> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type);
>  
>  out:
>  	if (err && evsel->bperf_leader_link_fd >= 0)
> @@ -623,7 +641,7 @@ static int bperf__read(struct evsel *evsel)
>  	bperf_sync_counters(evsel);
>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>  
> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +	for (i = 0; i < filter_entry_cnt; i++) {
>  		struct perf_cpu entry;
>  		__u32 cpu;
>  
> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index f193998530d4..32b944f28776 100644
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
> @@ -22,7 +24,9 @@ struct {
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
> @@ -33,14 +37,15 @@ int BPF_PROG(fexit_XXX)
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
> @@ -55,16 +60,20 @@ int BPF_PROG(fexit_XXX)
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
> @@ -75,4 +84,53 @@ int BPF_PROG(fexit_XXX)
>  	return 0;
>  }
>  
> +/* The program is only used for PID or TGID filter types. */
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
> +	parent_pid = bpf_get_current_pid_tgid() >> 32;
> +	child_pid = task->pid;

Should it use pid or tgid depending on the filter type?

Thanks,
Namhyung

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
> +/* The program is only used for PID or TGID filter types. */
> +SEC("tp_btf/sched_process_exit")
> +int BPF_PROG(on_exittask, struct task_struct *task)
> +{
> +	__u32 pid;
> +	struct bperf_filter_value *fval;
> +
> +	if (!enabled)
> +		return 0;
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

