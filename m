Return-Path: <bpf+bounces-42767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77999A9EB6
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F531B21079
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078251990CE;
	Tue, 22 Oct 2024 09:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6809198A2F;
	Tue, 22 Oct 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589973; cv=none; b=rWpqXzYTnzaVOl2ca8AIU1chKw1+vDcqPDkRQ7sh2kU7fY0UnHu4sKZiWMA+Z3m/9vL0uIpr4piGTPJLIaeyn3Htd2tKw/T4vM/vC/xws5meGV1LwU//1qhThClPYE0tsD263DhFgevELiKCC5SuQkbKVNWp/9xlTA0jWs32d3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589973; c=relaxed/simple;
	bh=NAzYIwAEZJbeJG2tgh6a95d71pNUcTJH8NjOLAZhr4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRGQSK8TW3JpYGg1cREkacK6SuudZvt31pDgOdU/7mpNzsLCs+7/xiLzDOPlV/bD53NSCWeLdASyXsdBPP9L45jbP/6BCR796+5wY/uoMui/u7u6gLs6tQyd693lH+68F/GoR6v+yjdIdqlGhPuWCGROUPq7tcS02ZenJMr0q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXnFF0flrz4f3kk9;
	Tue, 22 Oct 2024 17:39:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B7231A058E;
	Tue, 22 Oct 2024 17:39:25 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgC36sbLchdnCp0vEw--.18142S2;
	Tue, 22 Oct 2024 17:39:25 +0800 (CST)
Message-ID: <e1faa3b2-5448-403f-93ab-78731daffce4@huaweicloud.com>
Date: Tue, 22 Oct 2024 17:39:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v5 1/2] perf stat: Support inherit events during
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
References: <20241021110201.325617-1-wutengda@huaweicloud.com>
 <20241021110201.325617-2-wutengda@huaweicloud.com>
 <ZxclNg9Y5hUXGXCf@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZxclNg9Y5hUXGXCf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC36sbLchdnCp0vEw--.18142S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw45Zr43ZrWfJr4kKr4kWFg_yoW8GrWrXo
	WfJFsrtan5Kry3AFWqy3s7tFW3u3Z8CFWrXFWUWws5C3W7KF4j9ws5Cr4fZwsrZFy8ta17
	Ca4UA3ykJFs5Kr1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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



On 2024/10/22 12:08, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Oct 21, 2024 at 11:02:00AM +0000, Tengda Wu wrote:
>> bperf has a nice ability to share PMUs, but it still does not support
>> inherit events during fork(), resulting in some deviations in its stat
>> results compared with perf.
>>
>> perf stat result:
>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
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
>>  tools/perf/builtin-stat.c                     |  1 +
>>  tools/perf/util/bpf_counter.c                 | 35 +++++--
>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 98 +++++++++++++++++--
>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 +
>>  tools/perf/util/target.h                      |  1 +
>>  5 files changed, 126 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 3e6b9f216e80..8bc880479417 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -2620,6 +2620,7 @@ int cmd_stat(int argc, const char **argv)
>>  	} else if (big_num_opt == 0) /* User passed --no-big-num */
>>  		stat_config.big_num = false;
>>  
>> +	target.inherit = !stat_config.no_inherit;
>>  	err = target__validate(&target);
>>  	if (err) {
>>  		target__strerror(&target, err, errbuf, BUFSIZ);
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
>> index 7a8af60e0f51..73fcafbffc6a 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -394,6 +394,7 @@ static int bperf_check_target(struct evsel *evsel,
>>  }
>>  
>>  static	struct perf_cpu_map *all_cpu_map;
>> +static __u32 filter_entry_cnt;
>>  
>>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>>  				       struct perf_event_attr_map_entry *entry)
>> @@ -444,12 +445,32 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>>  	return err;
>>  }
>>  
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
>>  static int bperf__load(struct evsel *evsel, struct target *target)
>>  {
>>  	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
>>  	int attr_map_fd, diff_map_fd = -1, err;
>>  	enum bperf_filter_type filter_type;
>> -	__u32 filter_entry_cnt, i;
>> +	__u32 i;
>>  
>>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
>>  		return -1;
>> @@ -529,9 +550,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	/* set up reading map */
>>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>>  				 filter_entry_cnt);
>> -	/* set up follower filter based on target */
>> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
>> -				 filter_entry_cnt);
>>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>>  	if (err) {
>>  		pr_err("Failed to load follower skeleton\n");
>> @@ -543,6 +561,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	for (i = 0; i < filter_entry_cnt; i++) {
>>  		int filter_map_fd;
>>  		__u32 key;
>> +		struct bperf_filter_value fval = { i, 0 };
>>  
>>  		if (filter_type == BPERF_FILTER_PID ||
>>  		    filter_type == BPERF_FILTER_TGID)
>> @@ -553,12 +572,14 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  			break;
>>  
>>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
>> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
>> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>>  	}
>>  
>>  	evsel->follower_skel->bss->type = filter_type;
>> +	evsel->follower_skel->bss->inherit = target->inherit;
>>  
>> -	err = bperf_follower_bpf__attach(evsel->follower_skel);
>> +	err = bperf_attach_follower_program(evsel->follower_skel, filter_type,
>> +					    target->inherit);
>>  
>>  out:
>>  	if (err && evsel->bperf_leader_link_fd >= 0)
>> @@ -623,7 +644,7 @@ static int bperf__read(struct evsel *evsel)
>>  	bperf_sync_counters(evsel);
>>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>>  
>> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
>> +	for (i = 0; i < filter_entry_cnt; i++) {
>>  		struct perf_cpu entry;
>>  		__u32 cpu;
>>  
>> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> index f193998530d4..0595063139a3 100644
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
>> @@ -22,25 +24,29 @@ struct {
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
>>  int enabled = 0;
>> +int inherit;
>>  
>>  SEC("fexit/XXX")
>>  int BPF_PROG(fexit_XXX)
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
>> @@ -49,22 +55,34 @@ int BPF_PROG(fexit_XXX)
>>  		filter_key = bpf_get_current_pid_tgid() & 0xffffffff;
>>  		break;
>>  	case BPERF_FILTER_TGID:
>> -		filter_key = bpf_get_current_pid_tgid() >> 32;
>> +		/* Use pid as the filter_key to exclude new task counts
>> +		 * when inherit is disabled. Don't worry about the existing
>> +		 * children in TGID losing their counts, bpf_counter has
>> +		 * already added them to the filter map via perf_thread_map
>> +		 * before this bpf prog runs.
>> +		 */
>> +		filter_key = inherit ?
>> +			     bpf_get_current_pid_tgid() >> 32 :
>> +			     bpf_get_current_pid_tgid() & 0xffffffff;
> 
> I'm not sure why this is needed.  Isn't the existing code fine?

No, it's not. If I don't modify here, all child threads will always be counted
when inherit is disabled.


Before explaining this modification, we may need to first clarify what is included
in the filter map.

1. The fexit_XXX prog determines whether to count by filter_key during each
   context switch. If the key is found in the filter map, it will be counted,
   otherwise not.
2. The keys in the filter map are synchronized from the perf_thread_map when
   bperf__load().
3. The threads in perf_thread_map are added through cmd_stat()->evlist__create_maps()
   before bperf__load().
4. evlist__create_maps() fills perf_thread_map by traversing the /proc/%d/task
   directory, and these pids belong to the same tgid.

Therefore, when the bperf command is issued, the filter map already holds all
existing threads with the same tgid as the specified process.


Now, let's take a look at the TGID case. We hope the behavior is as follows:

 * TGID w/ inherit : specified process + all children from the processes
 * TGID w/o inherit: specified process (all threads in the process) only

Assuming that a new thread is created during bperf stats, the new thread should
exhibit the following behavior in the fexit_XXX prog:

 * TGID w/ inherit : do_add
 * TGID w/o inherit: skip and return

Let's now test the code before and after modification.

Before modification: (filter_key = tgid)

 * TGID w/ inherit:
      create  : new thread
      enter   : fexit_XXX prog
      assign  : filter_key = new thread's tgid
      match   : bpf_map_lookup_elem(&filter, &filter_key)
      do_add
   (PASS)

 * TGID w/o inherit:
      [...]   /* like above */
      do_add
   (FAILED, expect skip and return)

After modification: (filter_key = inherit ? tgid : pid)

 * TGID w/ inherit:
      create  : new thread
      enter   : fexit_XXX prog
      assign  : filter_key = new thread's tgid
      match   : bpf_map_lookup_elem(&filter, &filter_key)
      do_add
   (PASS)

 * TGID w/o inherit:
      create  : new thread
      enter   : fexit_XXX prog
      assign  : filter_key = new thread's pid
      mismatch: bpf_map_lookup_elem(&filter, &filter_key)
      skip and return
   (PASS)

As we can see, filter_key=tgid counts incorrectly in TGID w/o inherit case,
and we need to change it to filter_key=pid to fix it.

Thanks,
Tengda


> 
> Thanks,
> Namhyung
> 
> 
>>  		break;
>>  	default:
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
>> @@ -75,4 +93,70 @@ int BPF_PROG(fexit_XXX)
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
>> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
>> index d582cae8e105..2ee2cc30340f 100644
>> --- a/tools/perf/util/target.h
>> +++ b/tools/perf/util/target.h
>> @@ -17,6 +17,7 @@ struct target {
>>  	bool	     default_per_cpu;
>>  	bool	     per_thread;
>>  	bool	     use_bpf;
>> +	bool	     inherit;
>>  	int	     initial_delay;
>>  	const char   *attr_map;
>>  };
>> -- 
>> 2.34.1
>>


