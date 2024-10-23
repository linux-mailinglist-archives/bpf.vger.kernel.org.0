Return-Path: <bpf+bounces-42964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFB9AD811
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254A9282A5D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331871FDFA1;
	Wed, 23 Oct 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE2omq6g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A214EC77;
	Wed, 23 Oct 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723531; cv=none; b=Ogw01CSVi6jiS69qpfe+ach6y4xnvKFUU18RxSt/KfDcWymPNqLtdGtCbCAAydG77gS6fnV1Ec2aI1odJnTox62GlC2hLJk0qTO+qWpZ1kiALd3yeOKzK7igst778aaaSZUc6fpJyWZpgQ0CK4Kjpp6A1TwqiFmVDYSB5aT3gQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723531; c=relaxed/simple;
	bh=EliXeaoWJzMWzCsMLdmkVRhE+2eshMCJsk78E7MFImg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6hapDyL7jxYjXhV3vgRA8anT+qhwkCXRXx7FhwXRCo8giKJDvDxkGvlVDT29YQIm8+PRxDj+I3y7P0r0znVFCG5VlSreF/9TUUefq10luIJQCI5wfQorFu/ogbwAPe+w86nmqATuf+ncKvy5OwAqq3hZ43Unh0iqPcdfIIhCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE2omq6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A573FC4CEC6;
	Wed, 23 Oct 2024 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729723531;
	bh=EliXeaoWJzMWzCsMLdmkVRhE+2eshMCJsk78E7MFImg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE2omq6g+SeE5RVw0gdeOA17+dWfEoLBiHD86QvCVs4JikFSo2u4kb5tvMB3fqUZ7
	 kEtfLbUnmO73BAvblqntQ9eq6bugT3b3CZGA8PJBQBJrksLJSZB4veFi8SWdFcK+dP
	 iMrSsGxPkEg4U1aYNkpr1xBVh3TMv3LTRUOYccbLtBTgRqya2MSMQnjDTLJxDSmItq
	 d9Q0sqKtWiENZrE6e4vVEnNj5OIxAVyjfWW8BhspYKAuja4JDpSBWW2v+GyyCOr653
	 lNIZowQp132X+osxxszG7p4sBdQkflh7nkmqTJa2+2yoduAe3tC52y+hGkpTaNLCrq
	 eV1j+AXXNM+Fg==
Date: Wed, 23 Oct 2024 15:45:29 -0700
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
Subject: Re: [PATCH -next v5 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <Zxl8iRgHi0ZZKMf-@google.com>
References: <20241021110201.325617-1-wutengda@huaweicloud.com>
 <20241021110201.325617-2-wutengda@huaweicloud.com>
 <ZxclNg9Y5hUXGXCf@google.com>
 <e1faa3b2-5448-403f-93ab-78731daffce4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1faa3b2-5448-403f-93ab-78731daffce4@huaweicloud.com>

On Tue, Oct 22, 2024 at 05:39:23PM +0800, Tengda Wu wrote:
> 
> 
> On 2024/10/22 12:08, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Oct 21, 2024 at 11:02:00AM +0000, Tengda Wu wrote:
> >> bperf has a nice ability to share PMUs, but it still does not support
> >> inherit events during fork(), resulting in some deviations in its stat
> >> results compared with perf.
> >>
> >> perf stat result:
> >> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
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
> >>  tools/perf/builtin-stat.c                     |  1 +
> >>  tools/perf/util/bpf_counter.c                 | 35 +++++--
> >>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 98 +++++++++++++++++--
> >>  tools/perf/util/bpf_skel/bperf_u.h            |  5 +
> >>  tools/perf/util/target.h                      |  1 +
> >>  5 files changed, 126 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 3e6b9f216e80..8bc880479417 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -2620,6 +2620,7 @@ int cmd_stat(int argc, const char **argv)
> >>  	} else if (big_num_opt == 0) /* User passed --no-big-num */
> >>  		stat_config.big_num = false;
> >>  
> >> +	target.inherit = !stat_config.no_inherit;
> >>  	err = target__validate(&target);
> >>  	if (err) {
> >>  		target__strerror(&target, err, errbuf, BUFSIZ);
> >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >> index 7a8af60e0f51..73fcafbffc6a 100644
> >> --- a/tools/perf/util/bpf_counter.c
> >> +++ b/tools/perf/util/bpf_counter.c
> >> @@ -394,6 +394,7 @@ static int bperf_check_target(struct evsel *evsel,
> >>  }
> >>  
> >>  static	struct perf_cpu_map *all_cpu_map;
> >> +static __u32 filter_entry_cnt;
> >>  
> >>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >>  				       struct perf_event_attr_map_entry *entry)
> >> @@ -444,12 +445,32 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >>  	return err;
> >>  }
> >>  
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
> >>  static int bperf__load(struct evsel *evsel, struct target *target)
> >>  {
> >>  	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
> >>  	int attr_map_fd, diff_map_fd = -1, err;
> >>  	enum bperf_filter_type filter_type;
> >> -	__u32 filter_entry_cnt, i;
> >> +	__u32 i;
> >>  
> >>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> >>  		return -1;
> >> @@ -529,9 +550,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  	/* set up reading map */
> >>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
> >>  				 filter_entry_cnt);
> >> -	/* set up follower filter based on target */
> >> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> >> -				 filter_entry_cnt);
> >>  	err = bperf_follower_bpf__load(evsel->follower_skel);
> >>  	if (err) {
> >>  		pr_err("Failed to load follower skeleton\n");
> >> @@ -543,6 +561,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  	for (i = 0; i < filter_entry_cnt; i++) {
> >>  		int filter_map_fd;
> >>  		__u32 key;
> >> +		struct bperf_filter_value fval = { i, 0 };
> >>  
> >>  		if (filter_type == BPERF_FILTER_PID ||
> >>  		    filter_type == BPERF_FILTER_TGID)
> >> @@ -553,12 +572,14 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >>  			break;
> >>  
> >>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> >> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> >> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
> >>  	}
> >>  
> >>  	evsel->follower_skel->bss->type = filter_type;
> >> +	evsel->follower_skel->bss->inherit = target->inherit;
> >>  
> >> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
> >> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type,
> >> +					    target->inherit);
> >>  
> >>  out:
> >>  	if (err && evsel->bperf_leader_link_fd >= 0)
> >> @@ -623,7 +644,7 @@ static int bperf__read(struct evsel *evsel)
> >>  	bperf_sync_counters(evsel);
> >>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >>  
> >> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> >> +	for (i = 0; i < filter_entry_cnt; i++) {
> >>  		struct perf_cpu entry;
> >>  		__u32 cpu;
> >>  
> >> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >> index f193998530d4..0595063139a3 100644
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
> >> @@ -22,25 +24,29 @@ struct {
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
> >>  int enabled = 0;
> >> +int inherit;
> >>  
> >>  SEC("fexit/XXX")
> >>  int BPF_PROG(fexit_XXX)
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
> >> @@ -49,22 +55,34 @@ int BPF_PROG(fexit_XXX)
> >>  		filter_key = bpf_get_current_pid_tgid() & 0xffffffff;
> >>  		break;
> >>  	case BPERF_FILTER_TGID:
> >> -		filter_key = bpf_get_current_pid_tgid() >> 32;
> >> +		/* Use pid as the filter_key to exclude new task counts
> >> +		 * when inherit is disabled. Don't worry about the existing
> >> +		 * children in TGID losing their counts, bpf_counter has
> >> +		 * already added them to the filter map via perf_thread_map
> >> +		 * before this bpf prog runs.
> >> +		 */
> >> +		filter_key = inherit ?
> >> +			     bpf_get_current_pid_tgid() >> 32 :
> >> +			     bpf_get_current_pid_tgid() & 0xffffffff;
> > 
> > I'm not sure why this is needed.  Isn't the existing code fine?
> 
> No, it's not. If I don't modify here, all child threads will always be counted
> when inherit is disabled.
> 
> 
> Before explaining this modification, we may need to first clarify what is included
> in the filter map.
> 
> 1. The fexit_XXX prog determines whether to count by filter_key during each
>    context switch. If the key is found in the filter map, it will be counted,
>    otherwise not.
> 2. The keys in the filter map are synchronized from the perf_thread_map when
>    bperf__load().
> 3. The threads in perf_thread_map are added through cmd_stat()->evlist__create_maps()
>    before bperf__load().
> 4. evlist__create_maps() fills perf_thread_map by traversing the /proc/%d/task
>    directory, and these pids belong to the same tgid.
> 
> Therefore, when the bperf command is issued, the filter map already holds all
> existing threads with the same tgid as the specified process.
> 
> 
> Now, let's take a look at the TGID case. We hope the behavior is as follows:
> 
>  * TGID w/ inherit : specified process + all children from the processes
>  * TGID w/o inherit: specified process (all threads in the process) only
> 
> Assuming that a new thread is created during bperf stats, the new thread should
> exhibit the following behavior in the fexit_XXX prog:
> 
>  * TGID w/ inherit : do_add
>  * TGID w/o inherit: skip and return
> 
> Let's now test the code before and after modification.
> 
> Before modification: (filter_key = tgid)
> 
>  * TGID w/ inherit:
>       create  : new thread
>       enter   : fexit_XXX prog
>       assign  : filter_key = new thread's tgid
>       match   : bpf_map_lookup_elem(&filter, &filter_key)
>       do_add
>    (PASS)
> 
>  * TGID w/o inherit:
>       [...]   /* like above */
>       do_add
>    (FAILED, expect skip and return)
> 
> After modification: (filter_key = inherit ? tgid : pid)
> 
>  * TGID w/ inherit:
>       create  : new thread
>       enter   : fexit_XXX prog
>       assign  : filter_key = new thread's tgid
>       match   : bpf_map_lookup_elem(&filter, &filter_key)
>       do_add
>    (PASS)
> 
>  * TGID w/o inherit:
>       create  : new thread
>       enter   : fexit_XXX prog
>       assign  : filter_key = new thread's pid
>       mismatch: bpf_map_lookup_elem(&filter, &filter_key)
>       skip and return
>    (PASS)
> 
> As we can see, filter_key=tgid counts incorrectly in TGID w/o inherit case,
> and we need to change it to filter_key=pid to fix it.

I'm sorry but I don't think I'm following.  A new thread in TGID mode
(regardless inherit) should be counted always, right?  Why do you
expect to skip it?

Thanks,
Namhyung


