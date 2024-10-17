Return-Path: <bpf+bounces-42271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 783499A18DE
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FEB24F40
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072A7DA6C;
	Thu, 17 Oct 2024 02:54:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2C762D2;
	Thu, 17 Oct 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133640; cv=none; b=ksGILh20y4DFUpjLQHdwq/flv0bUtgXo5IXWJyaS9XAkam3a2fP2EMy9tIB5KBkR+0C6i3QU1nZD7s5jahq2rN5aYfYOCEZayvBnTTJQxOn3rP44qLWCOnCXLXZ26127m+GerjkIP0TIgn9F6kMJU7Vn+8mTNAIvW3uSohbZhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133640; c=relaxed/simple;
	bh=YKB8mj+a0TKkYs8piSRMb+qI4XvLlO4rUdOu7KEshck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW1EP+eKyhLx3oDT06+e2zTEf/KuBTrWi1W8sRye28jEZcbOzPY/AxdSYH+ZE0gfefyNJIxqWscHFcu0P54sNn5RnGk+dXOiRz5SBcPrAX39FcN9pZUcDpvYVW+n6NAKU988htoysz4xpJRu+yh2dpxXQStGwHzhLBBkijIURyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XTXTQ4VtGz4f3jR1;
	Thu, 17 Oct 2024 10:53:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C31241A092F;
	Thu, 17 Oct 2024 10:53:47 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgBnuoY6fBBnFdCwEA--.2155S2;
	Thu, 17 Oct 2024 10:53:47 +0800 (CST)
Message-ID: <5c8612d2-a0fb-4853-8b6f-aca85b200edb@huaweicloud.com>
Date: Thu, 17 Oct 2024 10:53:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 1/2] perf stat: Support inherit events during
 fork() for bperf
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20241012023225.151084-1-wutengda@huaweicloud.com>
 <20241012023225.151084-2-wutengda@huaweicloud.com>
 <ZxAtLsClDW8x0H_a@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZxAtLsClDW8x0H_a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnuoY6fBBnFdCwEA--.2155S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw47ZFyrWrW5ZFyrAr43Wrg_yoW8Ary3Wo
	Wxtr43tan5WryrJrWDJ3s7trWa9a4DWayrXr4Uuws5Ww17KF1Y9rsxGr4rZay7ZFWUGF4U
	Ca47JaykJFZYkw1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

On 2024/10/17 5:16, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Oct 12, 2024 at 02:32:24AM +0000, Tengda Wu wrote:
>> bperf has a nice ability to share PMUs, but it still does not support
>> inherit events during fork(), resulting in some deviations in its stat
>> results compared with perf.
>>
>> perf stat result:
>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>>
>>    Performance counter stats for './perf test -w sqrtloop':
>>
>>        2,316,038,116      cycles
>>        2,859,350,725      instructions
>>
>>          1.009603637 seconds time elapsed
>>
>>          1.004196000 seconds user
>>          0.003950000 seconds sys
>>
>> bperf stat result:
>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>       ./perf test -w sqrtloop
>>
>>    Performance counter stats for './perf test -w sqrtloop':
>>
>>           18,762,093      cycles
>>           23,487,766      instructions
>>
>>          1.008913769 seconds time elapsed
>>
>>          1.003248000 seconds user
>>          0.004069000 seconds sys
>>
>> In order to support event inheritance, two new bpf programs are added
>> to monitor the fork and exit of tasks respectively. When a task is
>> created, add it to the filter map to enable counting, and reuse the
>> `accum_key` of its parent task to count together with the parent task.
>> When a task exits, remove it from the filter map to disable counting.
>>
>> After support:
>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>       ./perf test -w sqrtloop
>>
>>  Performance counter stats for './perf test -w sqrtloop':
>>
>>      2,316,252,189      cycles
>>      2,859,946,547      instructions
>>
>>        1.009422314 seconds time elapsed
>>
>>        1.003597000 seconds user
>>        0.004270000 seconds sys
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/builtin-stat.c                     |  4 +-
>>  tools/perf/util/bpf_counter.c                 | 57 +++++++++---
>>  tools/perf/util/bpf_counter.h                 | 13 ++-
>>  tools/perf/util/bpf_counter_cgroup.c          |  3 +-
>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>>  6 files changed, 145 insertions(+), 24 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 3e6b9f216e80..c27b107c1985 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -698,6 +698,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  	char msg[BUFSIZ];
>>  	unsigned long long t0, t1;
>>  	struct evsel *counter;
>> +	struct bpf_stat_opts opts;
>>  	size_t l;
>>  	int status = 0;
>>  	const bool forks = (argc > 0);
>> @@ -725,7 +726,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>  
>>  	evlist__for_each_entry(evsel_list, counter) {
>>  		counter->reset_group = false;
>> -		if (bpf_counter__load(counter, &target)) {
>> +		opts.inherit = !stat_config.no_inherit;
>> +		if (bpf_counter__load(counter, &target, &opts)) {
> 
> Maybe you can just add a boolean member in the struct target.

Yes，this approach would be more straightforward. 

I had considered it before, but, as you see, considering that `inherit` does not
align well with the `target` semantics, I chose the another one.

Anyway, I'll try it. Code changes would be more clean. Thanks.

> 
> 
>>  			err = -1;
>>  			goto err_out;
>>  		}
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
>> index 7a8af60e0f51..00afea6bde63 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -166,7 +166,9 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
>>  	return -1;
>>  }
>>  
>> -static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
>> +static int bpf_program_profiler__load(struct evsel *evsel,
>> +				      struct target *target,
>> +				      struct bpf_stat_opts *opts __maybe_unused)
>>  {
>>  	char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
>>  	u32 prog_id;
>> @@ -364,6 +366,7 @@ static int bperf_lock_attr_map(struct target *target)
>>  
>>  static int bperf_check_target(struct evsel *evsel,
>>  			      struct target *target,
>> +			      struct bpf_stat_opts *opts,
>>  			      enum bperf_filter_type *filter_type,
>>  			      __u32 *filter_entry_cnt)
>>  {
>> @@ -383,7 +386,12 @@ static int bperf_check_target(struct evsel *evsel,
>>  		*filter_type = BPERF_FILTER_PID;
>>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
>>  	} else if (target->pid || evsel->evlist->workload.pid != -1) {
>> -		*filter_type = BPERF_FILTER_TGID;
>> +		/*
>> +		 * unlike the PID type, the TGID type implicitly enables
>> +		 * event inheritance within a single process.
>> +		 */
>> +		*filter_type = opts->inherit ?
>> +				BPERF_FILTER_TGID : BPERF_FILTER_PID;
> 
> I'm not sure if it's right.  You should be able to use PID type with
> inheritance.  In this case child processes or threads from the selected
> thread would be counted only.

Sorry, don't quite understand. TGID type counts together with all sub-threads within
the same process, which is what inheritance needs to do; while PID type only counts
for a single thread and should be used when inheritance is turned off. This is equivalent
to the code above.

Simple test blow:
---
$ ./perf stat -e cpu-clock -- ./perf test -w sqrtloop

 Performance counter stats for './perf test -w sqrtloop':

          1,022.29 msec cpu-clock                        #    0.999 CPUs utilized

       1.023801331 seconds time elapsed

       1.012666000 seconds user
       0.010618000 seconds sys


$ ./perf stat -e cpu-clock -i -- ./perf test -w sqrtloop

 Performance counter stats for './perf test -w sqrtloop':

             19.85 msec cpu-clock                        #    0.019 CPUs utilized

       1.023108515 seconds time elapsed

       1.008862000 seconds user
       0.014346000 seconds sys


$ ./perf stat --bpf-counters -e cpu-clock -- ./perf test -w sqrtloop

 Performance counter stats for './perf test -w sqrtloop':

          1,022.77 msec cpu-clock                        #    0.986 CPUs utilized

       1.037375618 seconds time elapsed

       1.014952000 seconds user
       0.008047000 seconds sys

$ ./perf stat --bpf-counters -e cpu-clock -i -- ./perf test -w sqrtloop

 Performance counter stats for './perf test -w sqrtloop':

             18.88 msec cpu-clock                        #    0.018 CPUs utilized

       1.021336780 seconds time elapsed

       0.998283000 seconds user
       0.023079000 seconds sys


As we can see, the perf and bperf counts are consistent before and after enabling
-i(--no-inherit), which means the TGID and PID type switch works well.

Thanks,
Tengda

> 
> Thanks,
> Namhyung
> 
> 
>>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
>>  	} else {
>>  		pr_err("bpf managed perf events do not yet support these targets.\n");
>> @@ -394,6 +402,7 @@ static int bperf_check_target(struct evsel *evsel,
>>  }
>>  
>>  static	struct perf_cpu_map *all_cpu_map;
>> +static __u32 filter_entry_cnt;
>>  
>>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>>  				       struct perf_event_attr_map_entry *entry)
>> @@ -444,14 +453,36 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>>  	return err;
>>  }
>>  
>> -static int bperf__load(struct evsel *evsel, struct target *target)
>> +static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
>> +					 enum bperf_filter_type filter_type,
>> +					 bool inherit)
>> +{
>> +	struct bpf_link *link;
>> +	int err = 0;
>> +
>> +	if ((filter_type == BPERF_FILTER_PID ||
>> +	    filter_type == BPERF_FILTER_TGID) && inherit)
>> +		/* attach all follower bpf progs to enable event inheritance */
>> +		err = bperf_follower_bpf__attach(skel);
>> +	else {
>> +		link = bpf_program__attach(skel->progs.fexit_XXX);
>> +		if (IS_ERR(link))
>> +			err = PTR_ERR(link);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int bperf__load(struct evsel *evsel, struct target *target,
>> +		       struct bpf_stat_opts *opts)
>>  {
>>  	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
>>  	int attr_map_fd, diff_map_fd = -1, err;
>>  	enum bperf_filter_type filter_type;
>> -	__u32 filter_entry_cnt, i;
>> +	__u32 i;
>>  
>> -	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
>> +	if (bperf_check_target(evsel, target, opts, &filter_type,
>> +			       &filter_entry_cnt))
>>  		return -1;
>>  
>>  	if (!all_cpu_map) {
>> @@ -529,9 +560,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	/* set up reading map */
>>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>>  				 filter_entry_cnt);
>> -	/* set up follower filter based on target */
>> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
>> -				 filter_entry_cnt);
>>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>>  	if (err) {
>>  		pr_err("Failed to load follower skeleton\n");
>> @@ -543,6 +571,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	for (i = 0; i < filter_entry_cnt; i++) {
>>  		int filter_map_fd;
>>  		__u32 key;
>> +		struct bperf_filter_value fval = { i, 0 };
>>  
>>  		if (filter_type == BPERF_FILTER_PID ||
>>  		    filter_type == BPERF_FILTER_TGID)
>> @@ -553,12 +582,13 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  			break;
>>  
>>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
>> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
>> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>>  	}
>>  
>>  	evsel->follower_skel->bss->type = filter_type;
>>  
>> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
>> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type,
>> +					    opts->inherit);
>>  
>>  out:
>>  	if (err && evsel->bperf_leader_link_fd >= 0)
>> @@ -623,7 +653,7 @@ static int bperf__read(struct evsel *evsel)
>>  	bperf_sync_counters(evsel);
>>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>>  
>> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
>> +	for (i = 0; i < filter_entry_cnt; i++) {
>>  		struct perf_cpu entry;
>>  		__u32 cpu;
>>  
>> @@ -776,7 +806,8 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
>>  	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
>>  }
>>  
>> -int bpf_counter__load(struct evsel *evsel, struct target *target)
>> +int bpf_counter__load(struct evsel *evsel, struct target *target,
>> +		      struct bpf_stat_opts *opts)
>>  {
>>  	if (target->bpf_str)
>>  		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
>> @@ -787,7 +818,7 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
>>  		evsel->bpf_counter_ops = &bperf_ops;
>>  
>>  	if (evsel->bpf_counter_ops)
>> -		return evsel->bpf_counter_ops->load(evsel, target);
>> +		return evsel->bpf_counter_ops->load(evsel, target, opts);
>>  	return 0;
>>  }
>>  
>> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
>> index c6d21c07b14c..70d7869c0cd6 100644
>> --- a/tools/perf/util/bpf_counter.h
>> +++ b/tools/perf/util/bpf_counter.h
>> @@ -15,9 +15,14 @@ struct evsel;
>>  struct target;
>>  struct bpf_counter;
>>  
>> +struct bpf_stat_opts {
>> +	bool inherit;
>> +};
>> +
>>  typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
>>  typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
>> -					   struct target *target);
>> +					   struct target *target,
>> +					   struct bpf_stat_opts *opts);
>>  typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
>>  					       int cpu_map_idx,
>>  					       int fd);
>> @@ -38,7 +43,8 @@ struct bpf_counter {
>>  
>>  #ifdef HAVE_BPF_SKEL
>>  
>> -int bpf_counter__load(struct evsel *evsel, struct target *target);
>> +int bpf_counter__load(struct evsel *evsel, struct target *target,
>> +		      struct bpf_stat_opts *opts);
>>  int bpf_counter__enable(struct evsel *evsel);
>>  int bpf_counter__disable(struct evsel *evsel);
>>  int bpf_counter__read(struct evsel *evsel);
>> @@ -50,7 +56,8 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
>>  #include <linux/err.h>
>>  
>>  static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
>> -				    struct target *target __maybe_unused)
>> +				    struct target *target __maybe_unused,
>> +				    struct bpf_stat_opts *opts __maybe_unused)
>>  {
>>  	return 0;
>>  }
>> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
>> index 6ff42619de12..755f12a6703c 100644
>> --- a/tools/perf/util/bpf_counter_cgroup.c
>> +++ b/tools/perf/util/bpf_counter_cgroup.c
>> @@ -167,7 +167,8 @@ static int bperf_load_program(struct evlist *evlist)
>>  }
>>  
>>  static int bperf_cgrp__load(struct evsel *evsel,
>> -			    struct target *target __maybe_unused)
>> +			    struct target *target __maybe_unused,
>> +			    struct bpf_stat_opts *opts __maybe_unused)
>>  {
>>  	static bool bperf_loaded = false;
>>  
>> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> index f193998530d4..e804b2a9d0a6 100644
>> --- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> @@ -5,6 +5,8 @@
>>  #include <bpf/bpf_tracing.h>
>>  #include "bperf_u.h"
>>  
>> +#define MAX_ENTRIES 102400
>> +
>>  struct {
>>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>  	__uint(key_size, sizeof(__u32));
>> @@ -22,7 +24,9 @@ struct {
>>  struct {
>>  	__uint(type, BPF_MAP_TYPE_HASH);
>>  	__uint(key_size, sizeof(__u32));
>> -	__uint(value_size, sizeof(__u32));
>> +	__uint(value_size, sizeof(struct bperf_filter_value));
>> +	__uint(max_entries, MAX_ENTRIES);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>>  } filter SEC(".maps");
>>  
>>  enum bperf_filter_type type = 0;
>> @@ -33,14 +37,15 @@ int BPF_PROG(fexit_XXX)
>>  {
>>  	struct bpf_perf_event_value *diff_val, *accum_val;
>>  	__u32 filter_key, zero = 0;
>> -	__u32 *accum_key;
>> +	__u32 accum_key;
>> +	struct bperf_filter_value *fval;
>>  
>>  	if (!enabled)
>>  		return 0;
>>  
>>  	switch (type) {
>>  	case BPERF_FILTER_GLOBAL:
>> -		accum_key = &zero;
>> +		accum_key = zero;
>>  		goto do_add;
>>  	case BPERF_FILTER_CPU:
>>  		filter_key = bpf_get_smp_processor_id();
>> @@ -55,16 +60,20 @@ int BPF_PROG(fexit_XXX)
>>  		return 0;
>>  	}
>>  
>> -	accum_key = bpf_map_lookup_elem(&filter, &filter_key);
>> -	if (!accum_key)
>> +	fval = bpf_map_lookup_elem(&filter, &filter_key);
>> +	if (!fval)
>>  		return 0;
>>  
>> +	accum_key = fval->accum_key;
>> +	if (fval->exited)
>> +		bpf_map_delete_elem(&filter, &filter_key);
>> +
>>  do_add:
>>  	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
>>  	if (!diff_val)
>>  		return 0;
>>  
>> -	accum_val = bpf_map_lookup_elem(&accum_readings, accum_key);
>> +	accum_val = bpf_map_lookup_elem(&accum_readings, &accum_key);
>>  	if (!accum_val)
>>  		return 0;
>>  
>> @@ -75,4 +84,70 @@ int BPF_PROG(fexit_XXX)
>>  	return 0;
>>  }
>>  
>> +/* The program is only used for PID or TGID filter types. */
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
>> +{
>> +	__u32 parent_key, child_key;
>> +	struct bperf_filter_value *parent_fval;
>> +	struct bperf_filter_value child_fval = { 0 };
>> +
>> +	if (!enabled)
>> +		return 0;
>> +
>> +	switch (type) {
>> +	case BPERF_FILTER_PID:
>> +		parent_key = bpf_get_current_pid_tgid() & 0xffffffff;
>> +		child_key = task->pid;
>> +		break;
>> +	case BPERF_FILTER_TGID:
>> +		parent_key = bpf_get_current_pid_tgid() >> 32;
>> +		child_key = task->tgid;
>> +		if (child_key == parent_key)
>> +			return 0;
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	/* Check if the current task is one of the target tasks to be counted */
>> +	parent_fval = bpf_map_lookup_elem(&filter, &parent_key);
>> +	if (!parent_fval)
>> +		return 0;
>> +
>> +	/* Start counting for the new task by adding it into filter map,
>> +	 * inherit the accum key of its parent task so that they can be
>> +	 * counted together.
>> +	 */
>> +	child_fval.accum_key = parent_fval->accum_key;
>> +	child_fval.exited = 0;
>> +	bpf_map_update_elem(&filter, &child_key, &child_fval, BPF_NOEXIST);
>> +
>> +	return 0;
>> +}
>> +
>> +/* The program is only used for PID or TGID filter types. */
>> +SEC("tp_btf/sched_process_exit")
>> +int BPF_PROG(on_exittask, struct task_struct *task)
>> +{
>> +	__u32 pid;
>> +	struct bperf_filter_value *fval;
>> +
>> +	if (!enabled)
>> +		return 0;
>> +
>> +	/* Stop counting for this task by removing it from filter map.
>> +	 * For TGID type, if the pid can be found in the map, it means that
>> +	 * this pid belongs to the leader task. After the task exits, the
>> +	 * tgid of its child tasks (if any) will be 1, so the pid can be
>> +	 * safely removed.
>> +	 */
>> +	pid = task->pid;
>> +	fval = bpf_map_lookup_elem(&filter, &pid);
>> +	if (fval)
>> +		fval->exited = 1;
>> +
>> +	return 0;
>> +}
>> +
>>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
>> diff --git a/tools/perf/util/bpf_skel/bperf_u.h b/tools/perf/util/bpf_skel/bperf_u.h
>> index 1ce0c2c905c1..4a4a753980be 100644
>> --- a/tools/perf/util/bpf_skel/bperf_u.h
>> +++ b/tools/perf/util/bpf_skel/bperf_u.h
>> @@ -11,4 +11,9 @@ enum bperf_filter_type {
>>  	BPERF_FILTER_TGID,
>>  };
>>  
>> +struct bperf_filter_value {
>> +	__u32 accum_key;
>> +	__u8 exited;
>> +};
>> +
>>  #endif /* __BPERF_STAT_U_H */
>> -- 
>> 2.34.1
>>


