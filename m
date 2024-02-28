Return-Path: <bpf+bounces-22864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1AB86AF03
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24B3B21956
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF003BBE5;
	Wed, 28 Feb 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfwyb1nR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAF3BBD0;
	Wed, 28 Feb 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122967; cv=none; b=GE91KE5rJlddlqnxRRlzn79AuPDUTNTTBUd3IS/XmWL8Bjlo2Gr6GjMPur81XyTbq58Hzu44vLJ1AHvGNEsCAcc2KSbA5JlathMWjey2B6YpgpCLIoObz9M6Gu6QxftkXdVYmEsTqKpSVCGAB2saOlyOiyRtI9H54OHJeHqSDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122967; c=relaxed/simple;
	bh=Vtf8uiKYo2k9u20FWxvxPIPbVyK9vLwi1nNSnIilD74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgltxOmTxQOWUqoU2nHtl8jK5/iIIGs+KIlcYWaTwtqW38VekBw02z5QZJu68Lh+JOM0rX/g65VfcB0pbYIOoB6AfepztAaGmLO/rwjxhuDwPTOXCETuHjxng+W1Rj7bAEWHCAvj2wFRW14NYwIXH2dC27t/kV9iHYgI2FS9/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfwyb1nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11943C433F1;
	Wed, 28 Feb 2024 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709122966;
	bh=Vtf8uiKYo2k9u20FWxvxPIPbVyK9vLwi1nNSnIilD74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gfwyb1nRErLkTkRKYm3WcN1bCr4Cdya+HMKWySLtYNHYLDqbge4lPY0Z/Js4wfmK8
	 YK/W3ZqxBtUuuI7CTYa6/rW8gD6bkSygxSc0HIXoauSzRkBdx7Q3wvSZcqTeg7g20+
	 nIbiDqIKMHA6yjWfJOjPb9LV5mn1k9XY0bZ5nJ3pXgTDrwgywcE524Mqak7sHkkifs
	 Jl2IpnRaC3ZsNPPTPTRK3uIToBV9DBVjXGPkT3xtjOFa9nOejgempF4CygOgNd2ZOj
	 3Ivi00u6U5jv2I1gCNyOrexjkGbFJjQJjKuagvGny7CytY7zXp880eBoew1PYcsJyM
	 DWlWZIZcFaimg==
Date: Wed, 28 Feb 2024 09:22:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
Message-ID: <Zd8lkcb5irCOY4-m@x1>
References: <20240228053335.312776-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228053335.312776-1-namhyung@kernel.org>

On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> Currently it accounts the contention using delta between timestamps in
> lock:contention_begin and lock:contention_end tracepoints.  But it means
> the lock should see the both events during the monitoring period.
> 
> Actually there are 4 cases that happen with the monitoring:
> 
>                 monitoring period
>             /                       \
>             |                       |
>  1:  B------+-----------------------+--------E
>  2:    B----+-------------E         |
>  3:         |           B-----------+----E
>  4:         |     B-------------E   |
>             |                       |
>             t0                      t1
> 
> where B and E mean contention BEGIN and END, respectively.  So it only
> accounts the case 4 for now.  It seems there's no way to handle the case
> 1.  The case 2 might be handled if it saved the timestamp (t0), but it
> lacks the information from the B notably the flags which shows the lock
> types.  Also it could be a nested lock which it currently ignores.  So
> I think we should ignore the case 2.

Perhaps have a separate output listing locks that were found to be with
at least tE - t0 time, with perhaps a backtrace at that END time?

With that we wouldn't miss that info, however incomplete it is and the
user would try running again, perhaps for a longer time, or start
monitoring before the observed workload starts, etc.

Anyway:

Reviwed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> However we can handle the case 3 if we save the timestamp (t1) at the
> end of the period.  And then it can iterate the map entries in the
> userspace and update the lock stat accordinly.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2: add a comment on mark_end_timestamp  (Ian)
> 
>  tools/perf/util/bpf_lock_contention.c         | 120 ++++++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 ++-
>  tools/perf/util/bpf_skel/lock_data.h          |   7 +
>  3 files changed, 136 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 31ff19afc20c..9af76c6b2543 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -179,6 +179,123 @@ int lock_contention_prepare(struct lock_contention *con)
>  	return 0;
>  }
>  
> +/*
> + * Run the BPF program directly using BPF_PROG_TEST_RUN to update the end
> + * timestamp in ktime so that it can calculate delta easily.
> + */
> +static void mark_end_timestamp(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.flags = BPF_F_TEST_RUN_ON_CPU,
> +	);
> +	int prog_fd = bpf_program__fd(skel->progs.end_timestamp);
> +
> +	bpf_prog_test_run_opts(prog_fd, &opts);
> +}
> +
> +static void update_lock_stat(int map_fd, int pid, u64 end_ts,
> +			     enum lock_aggr_mode aggr_mode,
> +			     struct tstamp_data *ts_data)
> +{
> +	u64 delta;
> +	struct contention_key stat_key = {};
> +	struct contention_data stat_data;
> +
> +	if (ts_data->timestamp >= end_ts)
> +		return;
> +
> +	delta = end_ts - ts_data->timestamp;
> +
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_CALLER:
> +		stat_key.stack_id = ts_data->stack_id;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		stat_key.pid = pid;
> +		break;
> +	case LOCK_AGGR_ADDR:
> +		stat_key.lock_addr_or_cgroup = ts_data->lock;
> +		break;
> +	case LOCK_AGGR_CGROUP:
> +		/* TODO */
> +		return;
> +	default:
> +		return;
> +	}
> +
> +	if (bpf_map_lookup_elem(map_fd, &stat_key, &stat_data) < 0)
> +		return;
> +
> +	stat_data.total_time += delta;
> +	stat_data.count++;
> +
> +	if (delta > stat_data.max_time)
> +		stat_data.max_time = delta;
> +	if (delta < stat_data.min_time)
> +		stat_data.min_time = delta;
> +
> +	bpf_map_update_elem(map_fd, &stat_key, &stat_data, BPF_EXIST);
> +}
> +
> +/*
> + * Account entries in the tstamp map (which didn't see the corresponding
> + * lock:contention_end tracepoint) using end_ts.
> + */
> +static void account_end_timestamp(struct lock_contention *con)
> +{
> +	int ts_fd, stat_fd;
> +	int *prev_key, key;
> +	u64 end_ts = skel->bss->end_ts;
> +	int total_cpus;
> +	enum lock_aggr_mode aggr_mode = con->aggr_mode;
> +	struct tstamp_data ts_data, *cpu_data;
> +
> +	/* Iterate per-task tstamp map (key = TID) */
> +	ts_fd = bpf_map__fd(skel->maps.tstamp);
> +	stat_fd = bpf_map__fd(skel->maps.lock_stat);
> +
> +	prev_key = NULL;
> +	while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> +		if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) == 0) {
> +			int pid = key;
> +
> +			if (aggr_mode == LOCK_AGGR_TASK && con->owner)
> +				pid = ts_data.flags;
> +
> +			update_lock_stat(stat_fd, pid, end_ts, aggr_mode,
> +					 &ts_data);
> +		}
> +
> +		prev_key = &key;
> +	}
> +
> +	/* Now it'll check per-cpu tstamp map which doesn't have TID. */
> +	if (aggr_mode == LOCK_AGGR_TASK || aggr_mode == LOCK_AGGR_CGROUP)
> +		return;
> +
> +	total_cpus = cpu__max_cpu().cpu;
> +	ts_fd = bpf_map__fd(skel->maps.tstamp_cpu);
> +
> +	cpu_data = calloc(total_cpus, sizeof(*cpu_data));
> +	if (cpu_data == NULL)
> +		return;
> +
> +	prev_key = NULL;
> +	while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
> +		if (bpf_map_lookup_elem(ts_fd, &key, cpu_data) < 0)
> +			goto next;
> +
> +		for (int i = 0; i < total_cpus; i++) {
> +			update_lock_stat(stat_fd, -1, end_ts, aggr_mode,
> +					 &cpu_data[i]);
> +		}
> +
> +next:
> +		prev_key = &key;
> +	}
> +	free(cpu_data);
> +}
> +
>  int lock_contention_start(void)
>  {
>  	skel->bss->enabled = 1;
> @@ -188,6 +305,7 @@ int lock_contention_start(void)
>  int lock_contention_stop(void)
>  {
>  	skel->bss->enabled = 0;
> +	mark_end_timestamp();
>  	return 0;
>  }
>  
> @@ -301,6 +419,8 @@ int lock_contention_read(struct lock_contention *con)
>  	if (stack_trace == NULL)
>  		return -1;
>  
> +	account_end_timestamp(con);
> +
>  	if (con->aggr_mode == LOCK_AGGR_TASK) {
>  		struct thread *idle = __machine__findnew_thread(machine,
>  								/*pid=*/0,
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 95cd8414f6ef..fb54bd38e7d0 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -19,13 +19,6 @@
>  #define LCB_F_PERCPU	(1U << 4)
>  #define LCB_F_MUTEX	(1U << 5)
>  
> -struct tstamp_data {
> -	__u64 timestamp;
> -	__u64 lock;
> -	__u32 flags;
> -	__s32 stack_id;
> -};
> -
>  /* callstack storage  */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
> @@ -140,6 +133,8 @@ int perf_subsys_id = -1;
>  /* determine the key of lock stat */
>  int aggr_mode;
>  
> +__u64 end_ts;
> +
>  /* error stat */
>  int task_fail;
>  int stack_fail;
> @@ -559,4 +554,11 @@ int BPF_PROG(collect_lock_syms)
>  	return 0;
>  }
>  
> +SEC("raw_tp/bpf_test_finish")
> +int BPF_PROG(end_timestamp)
> +{
> +	end_ts = bpf_ktime_get_ns();
> +	return 0;
> +}
> +
>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index 08482daf61be..36af11faad03 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -3,6 +3,13 @@
>  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
>  #define UTIL_BPF_SKEL_LOCK_DATA_H
>  
> +struct tstamp_data {
> +	u64 timestamp;
> +	u64 lock;
> +	u32 flags;
> +	u32 stack_id;
> +};
> +
>  struct contention_key {
>  	u32 stack_id;
>  	u32 pid;
> -- 
> 2.44.0.rc1.240.g4c46232300-goog

