Return-Path: <bpf+bounces-42436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE09A445C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F11C21CE6
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CA204009;
	Fri, 18 Oct 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0int+Ij"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFF1442F4;
	Fri, 18 Oct 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271574; cv=none; b=jN1kCBNxiGwpJ2cWss3smRBDJLJQos+7SeiaraYHq8G21+4s3qJCcqzDJ6sxmOeDPzUbn0GePNJPr99GEThFHvruDoXUvkjIZeVlTOZo1/fw+2ByoptFzPdGW4tmM3U4QO0LyDb873NtiyC0mJfVPyltzHjaJljbAoe+K2FBmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271574; c=relaxed/simple;
	bh=AewQhhVvbfwIXcghwwB5Umf/YI72ffEXrFASdFOr9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGEsVvAUg1edJb0hKj+3wlaimRGeRPjXfIiQjouGtkQE9ATYlD4ImIefWo/jm/HtsBwMbHKp+jeCt4Zv0N9dZ8CvNhHDSzAERpXXu+ci2PtTpZheNpJtitlBpvloMkTku4xKYllMUQzZ9vNjr6ICGS6Axf+N1FTyFEpJ5DFMx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0int+Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F9DC4CEC3;
	Fri, 18 Oct 2024 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729271574;
	bh=AewQhhVvbfwIXcghwwB5Umf/YI72ffEXrFASdFOr9uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0int+IjrZM+rGaHdiHp7jZGr5NmSKOjfRXJYGPm+mOxXAJmYGG+buIrOAODEeO38
	 FyyoiHCQtGQfejAGIjTK+h5KwbuQDLoz20pxgVTjSVjwDmnvr84TuwCNutxwsWboA/
	 RRCSBXvGkVlCDr1UyGnRKAVMlwkrJi7bdpXgACqYK2N5151AzVdC60OrUCmgSMvOTU
	 WiLDZOYzCaWACPu/wtNWfF9156o8GmFHyd9zfSaOYXfHOtlBgkxVcKJUEtLieEPHow
	 pwITxkvqJObnyDgX5aQGbGowFIYJK2+cUJYNOJm277JM7HKnhqQg5XDTeBYzcIQm3g
	 gpCtj56cdL/FQ==
Date: Fri, 18 Oct 2024 10:12:52 -0700
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
Subject: Re: [PATCH -next v4 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <ZxKXFMh6_8E6-z7H@google.com>
References: <20241012023225.151084-1-wutengda@huaweicloud.com>
 <20241012023225.151084-2-wutengda@huaweicloud.com>
 <ZxAtLsClDW8x0H_a@google.com>
 <5c8612d2-a0fb-4853-8b6f-aca85b200edb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c8612d2-a0fb-4853-8b6f-aca85b200edb@huaweicloud.com>

On Thu, Oct 17, 2024 at 10:53:46AM +0800, Tengda Wu wrote:
> Hi,
> 
> On 2024/10/17 5:16, Namhyung Kim wrote:
> > Hello,
> > 
> > On Sat, Oct 12, 2024 at 02:32:24AM +0000, Tengda Wu wrote:
> >> bperf has a nice ability to share PMUs, but it still does not support
> >> inherit events during fork(), resulting in some deviations in its stat
> >> results compared with perf.
> >>
> >> perf stat result:
> >> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
> >>
> >>    Performance counter stats for './perf test -w sqrtloop':
> >>
> >>        2,316,038,116      cycles
> >>        2,859,350,725      instructions
> >>
> >>          1.009603637 seconds time elapsed
> >>
> >>          1.004196000 seconds user
> >>          0.003950000 seconds sys
> >>
> >> bperf stat result:
> >> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>       ./perf test -w sqrtloop
> >>
> >>    Performance counter stats for './perf test -w sqrtloop':
> >>
> >>           18,762,093      cycles
> >>           23,487,766      instructions
> >>
> >>          1.008913769 seconds time elapsed
> >>
> >>          1.003248000 seconds user
> >>          0.004069000 seconds sys
> >>
> >> In order to support event inheritance, two new bpf programs are added
> >> to monitor the fork and exit of tasks respectively. When a task is
> >> created, add it to the filter map to enable counting, and reuse the
> >> `accum_key` of its parent task to count together with the parent task.
> >> When a task exits, remove it from the filter map to disable counting.
> >>
> >> After support:
> >> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>       ./perf test -w sqrtloop
> >>
> >>  Performance counter stats for './perf test -w sqrtloop':
> >>
> >>      2,316,252,189      cycles
> >>      2,859,946,547      instructions
> >>
> >>        1.009422314 seconds time elapsed
> >>
> >>        1.003597000 seconds user
> >>        0.004270000 seconds sys
> >>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>  tools/perf/builtin-stat.c                     |  4 +-
> >>  tools/perf/util/bpf_counter.c                 | 57 +++++++++---
> >>  tools/perf/util/bpf_counter.h                 | 13 ++-
> >>  tools/perf/util/bpf_counter_cgroup.c          |  3 +-
> >>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
> >>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
> >>  6 files changed, 145 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 3e6b9f216e80..c27b107c1985 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -698,6 +698,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  	char msg[BUFSIZ];
> >>  	unsigned long long t0, t1;
> >>  	struct evsel *counter;
> >> +	struct bpf_stat_opts opts;
> >>  	size_t l;
> >>  	int status = 0;
> >>  	const bool forks = (argc > 0);
> >> @@ -725,7 +726,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  
> >>  	evlist__for_each_entry(evsel_list, counter) {
> >>  		counter->reset_group = false;
> >> -		if (bpf_counter__load(counter, &target)) {
> >> +		opts.inherit = !stat_config.no_inherit;
> >> +		if (bpf_counter__load(counter, &target, &opts)) {
> > 
> > Maybe you can just add a boolean member in the struct target.
> 
> Yes，this approach would be more straightforward. 
> 
> I had considered it before, but, as you see, considering that `inherit` does not
> align well with the `target` semantics, I chose the another one.

Well, I think 'inherit' is well aligned with the target semantics.
We want some processes as the targets of the event and we want to
profile their children or not.

> 
> Anyway, I'll try it. Code changes would be more clean. Thanks.
> 
> > 
> > 
> >>  			err = -1;
> >>  			goto err_out;
> >>  		}
> >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >> index 7a8af60e0f51..00afea6bde63 100644
> >> --- a/tools/perf/util/bpf_counter.c
> >> +++ b/tools/perf/util/bpf_counter.c
> >> @@ -166,7 +166,9 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
> >>  	return -1;
> >>  }
> >>  
> >> -static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
> >> +static int bpf_program_profiler__load(struct evsel *evsel,
> >> +				      struct target *target,
> >> +				      struct bpf_stat_opts *opts __maybe_unused)
> >>  {
> >>  	char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
> >>  	u32 prog_id;
> >> @@ -364,6 +366,7 @@ static int bperf_lock_attr_map(struct target *target)
> >>  
> >>  static int bperf_check_target(struct evsel *evsel,
> >>  			      struct target *target,
> >> +			      struct bpf_stat_opts *opts,
> >>  			      enum bperf_filter_type *filter_type,
> >>  			      __u32 *filter_entry_cnt)
> >>  {
> >> @@ -383,7 +386,12 @@ static int bperf_check_target(struct evsel *evsel,
> >>  		*filter_type = BPERF_FILTER_PID;
> >>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> >>  	} else if (target->pid || evsel->evlist->workload.pid != -1) {
> >> -		*filter_type = BPERF_FILTER_TGID;
> >> +		/*
> >> +		 * unlike the PID type, the TGID type implicitly enables
> >> +		 * event inheritance within a single process.
> >> +		 */
> >> +		*filter_type = opts->inherit ?
> >> +				BPERF_FILTER_TGID : BPERF_FILTER_PID;
> > 
> > I'm not sure if it's right.  You should be able to use PID type with
> > inheritance.  In this case child processes or threads from the selected
> > thread would be counted only.
> 
> Sorry, don't quite understand. TGID type counts together with all sub-threads within
> the same process, which is what inheritance needs to do; while PID type only counts
> for a single thread and should be used when inheritance is turned off. This is equivalent
> to the code above.

Let me be clear:

 * PID w/o inherit : specified threads only
 * PID w/ inherit  : specified threads + all threads or child process from the threads
 * TGID w/o inherit: specified process (all threads in the process) only
 * TGID w/ inherit : specified process + all children from the processes

For the TGID w/o inherit case, it's ok not to track new threads in the
process because they will have the same tgid anyway.

So you cannot change the filter type using inherit value.  It should be
used to control whether it tracks new task only.

Thanks,
Namhyung

> 
> Simple test blow:
> ---
> $ ./perf stat -e cpu-clock -- ./perf test -w sqrtloop
> 
>  Performance counter stats for './perf test -w sqrtloop':
> 
>           1,022.29 msec cpu-clock                        #    0.999 CPUs utilized
> 
>        1.023801331 seconds time elapsed
> 
>        1.012666000 seconds user
>        0.010618000 seconds sys
> 
> 
> $ ./perf stat -e cpu-clock -i -- ./perf test -w sqrtloop
> 
>  Performance counter stats for './perf test -w sqrtloop':
> 
>              19.85 msec cpu-clock                        #    0.019 CPUs utilized
> 
>        1.023108515 seconds time elapsed
> 
>        1.008862000 seconds user
>        0.014346000 seconds sys
> 
> 
> $ ./perf stat --bpf-counters -e cpu-clock -- ./perf test -w sqrtloop
> 
>  Performance counter stats for './perf test -w sqrtloop':
> 
>           1,022.77 msec cpu-clock                        #    0.986 CPUs utilized
> 
>        1.037375618 seconds time elapsed
> 
>        1.014952000 seconds user
>        0.008047000 seconds sys
> 
> $ ./perf stat --bpf-counters -e cpu-clock -i -- ./perf test -w sqrtloop
> 
>  Performance counter stats for './perf test -w sqrtloop':
> 
>              18.88 msec cpu-clock                        #    0.018 CPUs utilized
> 
>        1.021336780 seconds time elapsed
> 
>        0.998283000 seconds user
>        0.023079000 seconds sys
> 
> 
> As we can see, the perf and bperf counts are consistent before and after enabling
> -i(--no-inherit), which means the TGID and PID type switch works well.
> 
> Thanks,
> Tengda
> 
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> >>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> >>  	} else {
> >>  		pr_err("bpf managed perf events do not yet support these targets.\n");
> >> @@ -394,6 +402,7 @@ static int bperf_check_target(struct evsel *evsel,
> >>  }
> >>  
> >>  static	struct perf_cpu_map *all_cpu_map;
> >> +static __u32 filter_entry_cnt;
> >>  
> >>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >>  				       struct perf_event_attr_map_entry *entry)
> >> @@ -444,14 +453,36 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >>  	return err;
> >>  }
> >>  
> >> -static int bperf__load(struct evsel *evsel, struct target *target)
> >> +static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
> >> +					 enum bperf_filter_type filter_type,
> >> +					 bool inherit)
> >> +{
> >> +	struct bpf_link *link;
> >> +	int err = 0;
> >> +
> >> +	if ((filter_type == BPERF_FILTER_PID ||
> >> +	    filter_type == BPERF_FILTER_TGID) && inherit)
> >> +		/* attach all follower bpf progs to enable event inheritance */
> >> +		err = bperf_follower_bpf__attach(skel);
> >> +	else {
> >> +		link = bpf_program__attach(skel->progs.fexit_XXX);
> >> +		if (IS_ERR(link))
> >> +			err = PTR_ERR(link);
> >> +	}
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static int bperf__load(struct evsel *evsel, struct target *target,
> >> +		       struct bpf_stat_opts *opts)
> >>  {
> >>  	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
> >>  	int attr_map_fd, diff_map_fd = -1, err;
> >>  	enum bperf_filter_type filter_type;
> >> -	__u32 filter_entry_cnt, i;
> >> +	__u32 i;
> >>  
> >> -	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> >> +	if (bperf_check_target(evsel, target, opts, &filter_type,
> >> +			       &filter_entry_cnt))
> >>  		return -1;
> >>  
> >>  	if (!all_cpu_map) {
> >> @@ -529,9 +560,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  	/* set up reading map */
> >>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
> >>  				 filter_entry_cnt);
> >> -	/* set up follower filter based on target */
> >> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> >> -				 filter_entry_cnt);
> >>  	err = bperf_follower_bpf__load(evsel->follower_skel);
> >>  	if (err) {
> >>  		pr_err("Failed to load follower skeleton\n");
> >> @@ -543,6 +571,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  	for (i = 0; i < filter_entry_cnt; i++) {
> >>  		int filter_map_fd;
> >>  		__u32 key;
> >> +		struct bperf_filter_value fval = { i, 0 };
> >>  
> >>  		if (filter_type == BPERF_FILTER_PID ||
> >>  		    filter_type == BPERF_FILTER_TGID)
> >> @@ -553,12 +582,13 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  			break;
> >>  
> >>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> >> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> >> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
> >>  	}
> >>  
> >>  	evsel->follower_skel->bss->type = filter_type;
> >>  
> >> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
> >> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type,
> >> +					    opts->inherit);
> >>  
> >>  out:
> >>  	if (err && evsel->bperf_leader_link_fd >= 0)
> >> @@ -623,7 +653,7 @@ static int bperf__read(struct evsel *evsel)
> >>  	bperf_sync_counters(evsel);
> >>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >>  
> >> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> >> +	for (i = 0; i < filter_entry_cnt; i++) {
> >>  		struct perf_cpu entry;
> >>  		__u32 cpu;
> >>  
> >> @@ -776,7 +806,8 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
> >>  	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
> >>  }
> >>  
> >> -int bpf_counter__load(struct evsel *evsel, struct target *target)
> >> +int bpf_counter__load(struct evsel *evsel, struct target *target,
> >> +		      struct bpf_stat_opts *opts)
> >>  {
> >>  	if (target->bpf_str)
> >>  		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> >> @@ -787,7 +818,7 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
> >>  		evsel->bpf_counter_ops = &bperf_ops;
> >>  
> >>  	if (evsel->bpf_counter_ops)
> >> -		return evsel->bpf_counter_ops->load(evsel, target);
> >> +		return evsel->bpf_counter_ops->load(evsel, target, opts);
> >>  	return 0;
> >>  }
> >>  
> >> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> >> index c6d21c07b14c..70d7869c0cd6 100644
> >> --- a/tools/perf/util/bpf_counter.h
> >> +++ b/tools/perf/util/bpf_counter.h
> >> @@ -15,9 +15,14 @@ struct evsel;
> >>  struct target;
> >>  struct bpf_counter;
> >>  
> >> +struct bpf_stat_opts {
> >> +	bool inherit;
> >> +};
> >> +
> >>  typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
> >>  typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
> >> -					   struct target *target);
> >> +					   struct target *target,
> >> +					   struct bpf_stat_opts *opts);
> >>  typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
> >>  					       int cpu_map_idx,
> >>  					       int fd);
> >> @@ -38,7 +43,8 @@ struct bpf_counter {
> >>  
> >>  #ifdef HAVE_BPF_SKEL
> >>  
> >> -int bpf_counter__load(struct evsel *evsel, struct target *target);
> >> +int bpf_counter__load(struct evsel *evsel, struct target *target,
> >> +		      struct bpf_stat_opts *opts);
> >>  int bpf_counter__enable(struct evsel *evsel);
> >>  int bpf_counter__disable(struct evsel *evsel);
> >>  int bpf_counter__read(struct evsel *evsel);
> >> @@ -50,7 +56,8 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
> >>  #include <linux/err.h>
> >>  
> >>  static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
> >> -				    struct target *target __maybe_unused)
> >> +				    struct target *target __maybe_unused,
> >> +				    struct bpf_stat_opts *opts __maybe_unused)
> >>  {
> >>  	return 0;
> >>  }
> >> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> >> index 6ff42619de12..755f12a6703c 100644
> >> --- a/tools/perf/util/bpf_counter_cgroup.c
> >> +++ b/tools/perf/util/bpf_counter_cgroup.c
> >> @@ -167,7 +167,8 @@ static int bperf_load_program(struct evlist *evlist)
> >>  }
> >>  
> >>  static int bperf_cgrp__load(struct evsel *evsel,
> >> -			    struct target *target __maybe_unused)
> >> +			    struct target *target __maybe_unused,
> >> +			    struct bpf_stat_opts *opts __maybe_unused)
> >>  {
> >>  	static bool bperf_loaded = false;
> >>  
> >> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >> index f193998530d4..e804b2a9d0a6 100644
> >> --- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >> @@ -5,6 +5,8 @@
> >>  #include <bpf/bpf_tracing.h>
> >>  #include "bperf_u.h"
> >>  
> >> +#define MAX_ENTRIES 102400
> >> +
> >>  struct {
> >>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>  	__uint(key_size, sizeof(__u32));
> >> @@ -22,7 +24,9 @@ struct {
> >>  struct {
> >>  	__uint(type, BPF_MAP_TYPE_HASH);
> >>  	__uint(key_size, sizeof(__u32));
> >> -	__uint(value_size, sizeof(__u32));
> >> +	__uint(value_size, sizeof(struct bperf_filter_value));
> >> +	__uint(max_entries, MAX_ENTRIES);
> >> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> >>  } filter SEC(".maps");
> >>  
> >>  enum bperf_filter_type type = 0;
> >> @@ -33,14 +37,15 @@ int BPF_PROG(fexit_XXX)
> >>  {
> >>  	struct bpf_perf_event_value *diff_val, *accum_val;
> >>  	__u32 filter_key, zero = 0;
> >> -	__u32 *accum_key;
> >> +	__u32 accum_key;
> >> +	struct bperf_filter_value *fval;
> >>  
> >>  	if (!enabled)
> >>  		return 0;
> >>  
> >>  	switch (type) {
> >>  	case BPERF_FILTER_GLOBAL:
> >> -		accum_key = &zero;
> >> +		accum_key = zero;
> >>  		goto do_add;
> >>  	case BPERF_FILTER_CPU:
> >>  		filter_key = bpf_get_smp_processor_id();
> >> @@ -55,16 +60,20 @@ int BPF_PROG(fexit_XXX)
> >>  		return 0;
> >>  	}
> >>  
> >> -	accum_key = bpf_map_lookup_elem(&filter, &filter_key);
> >> -	if (!accum_key)
> >> +	fval = bpf_map_lookup_elem(&filter, &filter_key);
> >> +	if (!fval)
> >>  		return 0;
> >>  
> >> +	accum_key = fval->accum_key;
> >> +	if (fval->exited)
> >> +		bpf_map_delete_elem(&filter, &filter_key);
> >> +
> >>  do_add:
> >>  	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
> >>  	if (!diff_val)
> >>  		return 0;
> >>  
> >> -	accum_val = bpf_map_lookup_elem(&accum_readings, accum_key);
> >> +	accum_val = bpf_map_lookup_elem(&accum_readings, &accum_key);
> >>  	if (!accum_val)
> >>  		return 0;
> >>  
> >> @@ -75,4 +84,70 @@ int BPF_PROG(fexit_XXX)
> >>  	return 0;
> >>  }
> >>  
> >> +/* The program is only used for PID or TGID filter types. */
> >> +SEC("tp_btf/task_newtask")
> >> +int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
> >> +{
> >> +	__u32 parent_key, child_key;
> >> +	struct bperf_filter_value *parent_fval;
> >> +	struct bperf_filter_value child_fval = { 0 };
> >> +
> >> +	if (!enabled)
> >> +		return 0;
> >> +
> >> +	switch (type) {
> >> +	case BPERF_FILTER_PID:
> >> +		parent_key = bpf_get_current_pid_tgid() & 0xffffffff;
> >> +		child_key = task->pid;
> >> +		break;
> >> +	case BPERF_FILTER_TGID:
> >> +		parent_key = bpf_get_current_pid_tgid() >> 32;
> >> +		child_key = task->tgid;
> >> +		if (child_key == parent_key)
> >> +			return 0;
> >> +		break;
> >> +	default:
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* Check if the current task is one of the target tasks to be counted */
> >> +	parent_fval = bpf_map_lookup_elem(&filter, &parent_key);
> >> +	if (!parent_fval)
> >> +		return 0;
> >> +
> >> +	/* Start counting for the new task by adding it into filter map,
> >> +	 * inherit the accum key of its parent task so that they can be
> >> +	 * counted together.
> >> +	 */
> >> +	child_fval.accum_key = parent_fval->accum_key;
> >> +	child_fval.exited = 0;
> >> +	bpf_map_update_elem(&filter, &child_key, &child_fval, BPF_NOEXIST);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/* The program is only used for PID or TGID filter types. */
> >> +SEC("tp_btf/sched_process_exit")
> >> +int BPF_PROG(on_exittask, struct task_struct *task)
> >> +{
> >> +	__u32 pid;
> >> +	struct bperf_filter_value *fval;
> >> +
> >> +	if (!enabled)
> >> +		return 0;
> >> +
> >> +	/* Stop counting for this task by removing it from filter map.
> >> +	 * For TGID type, if the pid can be found in the map, it means that
> >> +	 * this pid belongs to the leader task. After the task exits, the
> >> +	 * tgid of its child tasks (if any) will be 1, so the pid can be
> >> +	 * safely removed.
> >> +	 */
> >> +	pid = task->pid;
> >> +	fval = bpf_map_lookup_elem(&filter, &pid);
> >> +	if (fval)
> >> +		fval->exited = 1;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> >> diff --git a/tools/perf/util/bpf_skel/bperf_u.h b/tools/perf/util/bpf_skel/bperf_u.h
> >> index 1ce0c2c905c1..4a4a753980be 100644
> >> --- a/tools/perf/util/bpf_skel/bperf_u.h
> >> +++ b/tools/perf/util/bpf_skel/bperf_u.h
> >> @@ -11,4 +11,9 @@ enum bperf_filter_type {
> >>  	BPERF_FILTER_TGID,
> >>  };
> >>  
> >> +struct bperf_filter_value {
> >> +	__u32 accum_key;
> >> +	__u8 exited;
> >> +};
> >> +
> >>  #endif /* __BPERF_STAT_U_H */
> >> -- 
> >> 2.34.1
> >>
> 

