Return-Path: <bpf+bounces-43315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379E9B367A
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BB6281153
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A01DED6C;
	Mon, 28 Oct 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFvTzXQK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B0186616;
	Mon, 28 Oct 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133026; cv=none; b=akk52AuFiCxRFGhC2fJLFyV82+FayWsE12unyuQe06J9icvxarKZTr8FadJuXEvQ/iJqGxAk879tw304U2c0M6P5/tvwCCFR4fpJTt3k74FuV9C77pjQJe0+pI2VE3w2AWGoBcmpCAHzO9yMIeda1qmE6nNkTI9xBqse4FblMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133026; c=relaxed/simple;
	bh=sD63o9u/4oqbY3vz0Ga6nOROLYgu9iYG94wK9hFus1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaGxkTSEnKngsEst+PewtcYqVvmgluxUSB0Frq7UImcd8u5elvx1aQx3jYmz2V83GfINHx502c1AL9Q4RNe6Whd8AYV5FvWs+dG+kDXKvbpMpIgRSzGdLcEwpoocrcM2/2OvJUT6NqXGwN8XU2bhNxkw7b1yEfqVZvn2dl/Vtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFvTzXQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6EC4CEC3;
	Mon, 28 Oct 2024 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133025;
	bh=sD63o9u/4oqbY3vz0Ga6nOROLYgu9iYG94wK9hFus1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFvTzXQKn0LoIaTcemo7WZWn6hrGAb3J17BHyxVhc4CGQwqk7ExobiwBSGZfiILZG
	 Liq+Olif1JjrnF3CPI52p9/z8Mu7zHZZpXtraYp9Epres8eWS9SWa1AqJmWw4RJrDz
	 EHIhx6+QjCslEijDU9ExE2e4vN+qG0Hhck0ha4DuZjvxd+2ifiT+fq7vpf4WJj6DIb
	 bDGsSPYKVLXh1kRina8hVvgMIC7NRD5NAuAFIw/UybAOHJJ4suNoEgiiyQTrZzYAkw
	 JNH0H7DfHgCdqxCkXQKJ1RRR8Q86Qsp8ScAIobaadENC9PaXms2S+LHlJdg0bHaYax
	 /fpowELo+d66g==
Date: Mon, 28 Oct 2024 09:30:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>, song@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v5 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <Zx-8HnxhoH1xfaKA@google.com>
References: <20241021110201.325617-1-wutengda@huaweicloud.com>
 <20241021110201.325617-2-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021110201.325617-2-wutengda@huaweicloud.com>

Hi Song,

On Mon, Oct 21, 2024 at 11:02:00AM +0000, Tengda Wu wrote:
> bperf has a nice ability to share PMUs, but it still does not support
> inherit events during fork(), resulting in some deviations in its stat
> results compared with perf.
> 
> perf stat result:
> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>    Performance counter stats for './perf test -w sqrtloop':
> 
>        2,316,038,116      cycles
>        2,859,350,725      instructions
> 
>          1.009603637 seconds time elapsed
> 
>          1.004196000 seconds user
>          0.003950000 seconds sys
> 
> bperf stat result:
> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>       ./perf test -w sqrtloop
> 
>    Performance counter stats for './perf test -w sqrtloop':
> 
>           18,762,093      cycles
>           23,487,766      instructions
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
> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>       ./perf test -w sqrtloop
> 
>  Performance counter stats for './perf test -w sqrtloop':
> 
>      2,316,252,189      cycles
>      2,859,946,547      instructions
> 
>        1.009422314 seconds time elapsed
> 
>        1.003597000 seconds user
>        0.004270000 seconds sys
> 

Are you ok with this now?

Thanks,
Namhyung


> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/builtin-stat.c                     |  1 +
>  tools/perf/util/bpf_counter.c                 | 35 +++++--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 98 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 +
>  tools/perf/util/target.h                      |  1 +
>  5 files changed, 126 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3e6b9f216e80..8bc880479417 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2620,6 +2620,7 @@ int cmd_stat(int argc, const char **argv)
>  	} else if (big_num_opt == 0) /* User passed --no-big-num */
>  		stat_config.big_num = false;
>  
> +	target.inherit = !stat_config.no_inherit;
>  	err = target__validate(&target);
>  	if (err) {
>  		target__strerror(&target, err, errbuf, BUFSIZ);
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 7a8af60e0f51..73fcafbffc6a 100644
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
> @@ -444,12 +445,32 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	return err;
>  }
>  
> +static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
> +					 enum bperf_filter_type filter_type,
> +					 bool inherit)
> +{
> +	struct bpf_link *link;
> +	int err = 0;
> +
> +	if ((filter_type == BPERF_FILTER_PID ||
> +	    filter_type == BPERF_FILTER_TGID) && inherit)
> +		/* attach all follower bpf progs to enable event inheritance */
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
> @@ -529,9 +550,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	/* set up reading map */
>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>  				 filter_entry_cnt);
> -	/* set up follower filter based on target */
> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> -				 filter_entry_cnt);
>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>  	if (err) {
>  		pr_err("Failed to load follower skeleton\n");
> @@ -543,6 +561,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	for (i = 0; i < filter_entry_cnt; i++) {
>  		int filter_map_fd;
>  		__u32 key;
> +		struct bperf_filter_value fval = { i, 0 };
>  
>  		if (filter_type == BPERF_FILTER_PID ||
>  		    filter_type == BPERF_FILTER_TGID)
> @@ -553,12 +572,14 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  			break;
>  
>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>  	}
>  
>  	evsel->follower_skel->bss->type = filter_type;
> +	evsel->follower_skel->bss->inherit = target->inherit;
>  
> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type,
> +					    target->inherit);
>  
>  out:
>  	if (err && evsel->bperf_leader_link_fd >= 0)
> @@ -623,7 +644,7 @@ static int bperf__read(struct evsel *evsel)
>  	bperf_sync_counters(evsel);
>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>  
> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +	for (i = 0; i < filter_entry_cnt; i++) {
>  		struct perf_cpu entry;
>  		__u32 cpu;
>  
> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index f193998530d4..0595063139a3 100644
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
> +int inherit;
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
> @@ -49,22 +55,34 @@ int BPF_PROG(fexit_XXX)
>  		filter_key = bpf_get_current_pid_tgid() & 0xffffffff;
>  		break;
>  	case BPERF_FILTER_TGID:
> -		filter_key = bpf_get_current_pid_tgid() >> 32;
> +		/* Use pid as the filter_key to exclude new task counts
> +		 * when inherit is disabled. Don't worry about the existing
> +		 * children in TGID losing their counts, bpf_counter has
> +		 * already added them to the filter map via perf_thread_map
> +		 * before this bpf prog runs.
> +		 */
> +		filter_key = inherit ?
> +			     bpf_get_current_pid_tgid() >> 32 :
> +			     bpf_get_current_pid_tgid() & 0xffffffff;
>  		break;
>  	default:
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
> @@ -75,4 +93,70 @@ int BPF_PROG(fexit_XXX)
>  	return 0;
>  }
>  
> +/* The program is only used for PID or TGID filter types. */
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
> +{
> +	__u32 parent_key, child_key;
> +	struct bperf_filter_value *parent_fval;
> +	struct bperf_filter_value child_fval = { 0 };
> +
> +	if (!enabled)
> +		return 0;
> +
> +	switch (type) {
> +	case BPERF_FILTER_PID:
> +		parent_key = bpf_get_current_pid_tgid() & 0xffffffff;
> +		child_key = task->pid;
> +		break;
> +	case BPERF_FILTER_TGID:
> +		parent_key = bpf_get_current_pid_tgid() >> 32;
> +		child_key = task->tgid;
> +		if (child_key == parent_key)
> +			return 0;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	/* Check if the current task is one of the target tasks to be counted */
> +	parent_fval = bpf_map_lookup_elem(&filter, &parent_key);
> +	if (!parent_fval)
> +		return 0;
> +
> +	/* Start counting for the new task by adding it into filter map,
> +	 * inherit the accum key of its parent task so that they can be
> +	 * counted together.
> +	 */
> +	child_fval.accum_key = parent_fval->accum_key;
> +	child_fval.exited = 0;
> +	bpf_map_update_elem(&filter, &child_key, &child_fval, BPF_NOEXIST);
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
> +	/* Stop counting for this task by removing it from filter map.
> +	 * For TGID type, if the pid can be found in the map, it means that
> +	 * this pid belongs to the leader task. After the task exits, the
> +	 * tgid of its child tasks (if any) will be 1, so the pid can be
> +	 * safely removed.
> +	 */
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
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
> index d582cae8e105..2ee2cc30340f 100644
> --- a/tools/perf/util/target.h
> +++ b/tools/perf/util/target.h
> @@ -17,6 +17,7 @@ struct target {
>  	bool	     default_per_cpu;
>  	bool	     per_thread;
>  	bool	     use_bpf;
> +	bool	     inherit;
>  	int	     initial_delay;
>  	const char   *attr_map;
>  };
> -- 
> 2.34.1
> 

