Return-Path: <bpf+bounces-42499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D59A4BFC
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747411F22D49
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC71DE889;
	Sat, 19 Oct 2024 08:27:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F812B17C;
	Sat, 19 Oct 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326471; cv=none; b=M2LxE1GwxHkq5NJ73F2pz9OISX4wQrbWWar+i0//qZ/Kr76VDVa4grrlZCyhQ+6hAlHNq1r785045JQKbJmp0ZQ0JCysMyVZJQmcqM9UapKSV+8MoIw8fx7ptIyeCMbPyAWpZ71jQxD1ISDaJTz+LKKktcm+gF9cLU4mGVIZxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326471; c=relaxed/simple;
	bh=YSH+HUdHMn0lUKeHVzgggYhFri4b1LePkWEKTNcbj1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDXVZq/2DgA2vbvoLyWzfCi4huA7F8JPShcoSXZCxKActarym+jcc6Xor8PWRhL5cx3PBG+pU3/9Ht84lTSvvsZYArd5QJ/XV8IQc6XfZbgGRj0tHXfUHF2hdbpM13smuZt/+ckVH4OztvEE7H1jtNgrpkBXtvjzJlfBh+uUkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XVvnk05Zkz4f3lVd;
	Sat, 19 Oct 2024 16:27:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1115E1A058E;
	Sat, 19 Oct 2024 16:27:40 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgDXAi96bRNnmEeOEQ--.60398S2;
	Sat, 19 Oct 2024 16:27:39 +0800 (CST)
Message-ID: <093e14a9-4008-4490-9946-5080449935c4@huaweicloud.com>
Date: Sat, 19 Oct 2024 16:27:38 +0800
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
 <5c8612d2-a0fb-4853-8b6f-aca85b200edb@huaweicloud.com>
 <ZxKXFMh6_8E6-z7H@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZxKXFMh6_8E6-z7H@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXAi96bRNnmEeOEQ--.60398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFykZF17KF1rAw13Cr45ZFb_yoWxWF15pF
	W7Ka4jkw4kXFW5Cw12qa1DXr9ayw1SgrW3Wr13trW8t3WDtr9xWFyxJFyYkFn7XrykCr10
	qr4j9rWxurZrArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/10/19 1:12, Namhyung Kim wrote:
> On Thu, Oct 17, 2024 at 10:53:46AM +0800, Tengda Wu wrote:
>> Hi,
>>
>> On 2024/10/17 5:16, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Sat, Oct 12, 2024 at 02:32:24AM +0000, Tengda Wu wrote:
>>>> bperf has a nice ability to share PMUs, but it still does not support
>>>> inherit events during fork(), resulting in some deviations in its stat
>>>> results compared with perf.
>>>>
>>>> perf stat result:
>>>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>>>>
>>>>    Performance counter stats for './perf test -w sqrtloop':
>>>>
>>>>        2,316,038,116      cycles
>>>>        2,859,350,725      instructions
>>>>
>>>>          1.009603637 seconds time elapsed
>>>>
>>>>          1.004196000 seconds user
>>>>          0.003950000 seconds sys
>>>>
>>>> bperf stat result:
>>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>>>       ./perf test -w sqrtloop
>>>>
>>>>    Performance counter stats for './perf test -w sqrtloop':
>>>>
>>>>           18,762,093      cycles
>>>>           23,487,766      instructions
>>>>
>>>>          1.008913769 seconds time elapsed
>>>>
>>>>          1.003248000 seconds user
>>>>          0.004069000 seconds sys
>>>>
>>>> In order to support event inheritance, two new bpf programs are added
>>>> to monitor the fork and exit of tasks respectively. When a task is
>>>> created, add it to the filter map to enable counting, and reuse the
>>>> `accum_key` of its parent task to count together with the parent task.
>>>> When a task exits, remove it from the filter map to disable counting.
>>>>
>>>> After support:
>>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>>>       ./perf test -w sqrtloop
>>>>
>>>>  Performance counter stats for './perf test -w sqrtloop':
>>>>
>>>>      2,316,252,189      cycles
>>>>      2,859,946,547      instructions
>>>>
>>>>        1.009422314 seconds time elapsed
>>>>
>>>>        1.003597000 seconds user
>>>>        0.004270000 seconds sys
>>>>
>>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>>> ---
>>>>  tools/perf/builtin-stat.c                     |  4 +-
>>>>  tools/perf/util/bpf_counter.c                 | 57 +++++++++---
>>>>  tools/perf/util/bpf_counter.h                 | 13 ++-
>>>>  tools/perf/util/bpf_counter_cgroup.c          |  3 +-
>>>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
>>>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>>>>  6 files changed, 145 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index 3e6b9f216e80..c27b107c1985 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -698,6 +698,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>>>  	char msg[BUFSIZ];
>>>>  	unsigned long long t0, t1;
>>>>  	struct evsel *counter;
>>>> +	struct bpf_stat_opts opts;
>>>>  	size_t l;
>>>>  	int status = 0;
>>>>  	const bool forks = (argc > 0);
>>>> @@ -725,7 +726,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>>>  
>>>>  	evlist__for_each_entry(evsel_list, counter) {
>>>>  		counter->reset_group = false;
>>>> -		if (bpf_counter__load(counter, &target)) {
>>>> +		opts.inherit = !stat_config.no_inherit;
>>>> +		if (bpf_counter__load(counter, &target, &opts)) {
>>>
>>> Maybe you can just add a boolean member in the struct target.
>>
>> Yes，this approach would be more straightforward. 
>>
>> I had considered it before, but, as you see, considering that `inherit` does not
>> align well with the `target` semantics, I chose the another one.
> 
> Well, I think 'inherit' is well aligned with the target semantics.
> We want some processes as the targets of the event and we want to
> profile their children or not.
> 

Ok.

>>
>> Anyway, I'll try it. Code changes would be more clean. Thanks.
>>
>>>
>>>
>>>>  			err = -1;
>>>>  			goto err_out;
>>>>  		}
>>>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
>>>> index 7a8af60e0f51..00afea6bde63 100644
>>>> --- a/tools/perf/util/bpf_counter.c
>>>> +++ b/tools/perf/util/bpf_counter.c
>>>> @@ -166,7 +166,9 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
>>>>  	return -1;
>>>>  }
>>>>  
>>>> -static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
>>>> +static int bpf_program_profiler__load(struct evsel *evsel,
>>>> +				      struct target *target,
>>>> +				      struct bpf_stat_opts *opts __maybe_unused)
>>>>  {
>>>>  	char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
>>>>  	u32 prog_id;
>>>> @@ -364,6 +366,7 @@ static int bperf_lock_attr_map(struct target *target)
>>>>  
>>>>  static int bperf_check_target(struct evsel *evsel,
>>>>  			      struct target *target,
>>>> +			      struct bpf_stat_opts *opts,
>>>>  			      enum bperf_filter_type *filter_type,
>>>>  			      __u32 *filter_entry_cnt)
>>>>  {
>>>> @@ -383,7 +386,12 @@ static int bperf_check_target(struct evsel *evsel,
>>>>  		*filter_type = BPERF_FILTER_PID;
>>>>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
>>>>  	} else if (target->pid || evsel->evlist->workload.pid != -1) {
>>>> -		*filter_type = BPERF_FILTER_TGID;
>>>> +		/*
>>>> +		 * unlike the PID type, the TGID type implicitly enables
>>>> +		 * event inheritance within a single process.
>>>> +		 */
>>>> +		*filter_type = opts->inherit ?
>>>> +				BPERF_FILTER_TGID : BPERF_FILTER_PID;
>>>
>>> I'm not sure if it's right.  You should be able to use PID type with
>>> inheritance.  In this case child processes or threads from the selected
>>> thread would be counted only.
>>
>> Sorry, don't quite understand. TGID type counts together with all sub-threads within
>> the same process, which is what inheritance needs to do; while PID type only counts
>> for a single thread and should be used when inheritance is turned off. This is equivalent
>> to the code above.
> 
> Let me be clear:
> 
>  * PID w/o inherit : specified threads only
>  * PID w/ inherit  : specified threads + all threads or child process from the threads
>  * TGID w/o inherit: specified process (all threads in the process) only
>  * TGID w/ inherit : specified process + all children from the processes
> 
> For the TGID w/o inherit case, it's ok not to track new threads in the
> process because they will have the same tgid anyway.
> 
> So you cannot change the filter type using inherit value.  It should be
> used to control whether it tracks new task only.
> 

So changing 'TGID w/o inherit' to 'PID w/o inherit' will lose counts of all
threads in the process, right?

It's clear now. Thanks for the explanation.

Tengda


