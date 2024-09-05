Return-Path: <bpf+bounces-38957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18DE96CF9A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DC0B2495C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628221917DB;
	Thu,  5 Sep 2024 06:44:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6E158D9C;
	Thu,  5 Sep 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518662; cv=none; b=H9okijVo8GQ4CTgywfO0i9AoXmbCyhFxVUNI9Qm/puxmeOzcJvovrEOLxZp/d+TtD+i1u+eILNq1+ioUcdyqcuGJLMpCzEQr0R0YvTY0bxXBQzh1OyUPQkIvBzETUdcohBjBkynL5LUrnLTEjJ++eZWGVqLi2IHcq/wEeYrZk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518662; c=relaxed/simple;
	bh=uFBU8Zqb5FJ7YeXXQBo1MneKu4BqCdNdlbJN+gArwlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOWmn5mLk6R1IBezFxGUvPNs1Xlb1GfoIm4Iqt7EsfB9sUKtANrOfAZLirrHvz84DzPJMeoddqvZgq38d1v4rQRuUvdznjis2/J61kIBrxW1IXJ4onS/R9sbgVuIHQQpU6OllbFL3NTaosIObXJDoZTSRohOuSXn0XDCXUJSnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzqZm6q1lz4f3jXn;
	Thu,  5 Sep 2024 14:44:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 04AB21A13AA;
	Thu,  5 Sep 2024 14:44:16 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCH24c+U9lmf7q3AQ--.55069S2;
	Thu, 05 Sep 2024 14:44:15 +0800 (CST)
Message-ID: <9570ce3e-5372-48b3-beca-ea251431326b@huaweicloud.com>
Date: Thu, 5 Sep 2024 14:44:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] perf stat: Support inherit events during fork()
 for bperf
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Song Liu <song@kernel.org>
References: <20240904123103.732507-1-wutengda@huaweicloud.com>
 <20240904123103.732507-2-wutengda@huaweicloud.com>
 <ZtktBbcjSdVt4WtJ@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZtktBbcjSdVt4WtJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCH24c+U9lmf7q3AQ--.55069S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1DArW7Kw15GFy7Gw1xZrb_yoWfGw4xpF
	WkCFyvkrW0qry7GwnIqw4kCFsay34furW5WFn3K3yIyF1kArn3Kr1xGFWY93W3ZrnrCF1S
	vr1UKw4UC3yDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/9/5 12:01, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Sep 04, 2024 at 12:31:02PM +0000, Tengda Wu wrote:
>> bperf has a nice ability to share PMUs, but it still does not support
>> inherit events during fork(), resulting in some deviations in its stat
>> results compared with perf.
>>
>> perf stat result:
>>   $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>>
>>    Performance counter stats for './perf test -w sqrtloop':
>>
>>        2,316,038,116      cycles
>>        2,859,350,725      instructions                     #    1.23  insn per cycle
>>
>>          1.009603637 seconds time elapsed
>>
>>          1.004196000 seconds user
>>          0.003950000 seconds sys
>>
>> bperf stat result:
>>   $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop
>>
>>    Performance counter stats for './perf test -w sqrtloop':
>>
>>           18,762,093      cycles
>>           23,487,766      instructions                     #    1.25  insn per cycle
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
> 
> Right, I think we may need this for other BPF programs.
> 
>>
>> After support:
>>   $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop
>>
>>    Performance counter stats for './perf test -w sqrtloop':
>>
>>        2,316,543,537      cycles
>>        2,859,677,779      instructions                     #    1.23  insn per cycle
>>
>>          1.009566332 seconds time elapsed
>>
>>          1.004414000 seconds user
>>          0.003545000 seconds sys
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/bpf_counter.c                 |  9 +--
>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 75 +++++++++++++++++--
>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>>  3 files changed, 78 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
>> index 7a8af60e0f51..e07ff04b934f 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -529,9 +529,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	/* set up reading map */
>>  	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
>>  				 filter_entry_cnt);
>> -	/* set up follower filter based on target */
>> -	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
>> -				 filter_entry_cnt);
>>  	err = bperf_follower_bpf__load(evsel->follower_skel);
>>  	if (err) {
>>  		pr_err("Failed to load follower skeleton\n");
>> @@ -543,6 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	for (i = 0; i < filter_entry_cnt; i++) {
>>  		int filter_map_fd;
>>  		__u32 key;
>> +		struct bperf_filter_value fval = { i, 0 };
>>  
>>  		if (filter_type == BPERF_FILTER_PID ||
>>  		    filter_type == BPERF_FILTER_TGID)
>> @@ -553,10 +551,11 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  			break;
>>  
>>  		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
>> -		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
>> +		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
>>  	}
>>  
>>  	evsel->follower_skel->bss->type = filter_type;
>> +	evsel->follower_skel->bss->init_filter_entries = filter_entry_cnt;
> 
> Do you need this in the BPF program?

No need. Actually, this variable is only used in bperf__read(). 
Since bperf__read() does not have a `struct target` parameter, it is not possible to check the
filter_entry_cnt value again through bperf_check_target(). We can only put it in a global scope,
one way is the current implementation, and another way is to declare a global variable in bpf_counter.
Maybe the second way is more appropriate? If so, I will modify it.

> 
>>  
>>  	err = bperf_follower_bpf__attach(evsel->follower_skel);
>>  
>> @@ -623,7 +622,7 @@ static int bperf__read(struct evsel *evsel)
>>  	bperf_sync_counters(evsel);
>>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>>  
>> -	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
>> +	for (i = 0; i < skel->bss->init_filter_entries; i++) {
>>  		struct perf_cpu entry;
>>  		__u32 cpu;
>>  
>> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> index f193998530d4..59fab421526a 100644
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
>> +__u32 init_filter_entries = 0;
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
>> @@ -55,16 +61,20 @@ int BPF_PROG(fexit_XXX)
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
>> @@ -75,4 +85,57 @@ int BPF_PROG(fexit_XXX)
>>  	return 0;
>>  }
>>  
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
>> +{
>> +	__u32 parent_pid, child_pid;
>> +	struct bperf_filter_value *parent_fval;
>> +	struct bperf_filter_value child_fval = { 0 };
>> +
>> +	if (!enabled)
>> +		return 0;
>> +
>> +	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
>> +		return 0;
> 
> I think you can load/attach this program only if the type is either
> PID or TGID.  Then it'd reduce the overhead.

Great suggestion, I'll give it a try.

> 
>> +
>> +	parent_pid = bpf_get_current_pid_tgid() >> 32;
>> +	child_pid = task->pid;
>> +
>> +	/* Check if the current task is one of the target tasks to be counted */
>> +	parent_fval = bpf_map_lookup_elem(&filter, &parent_pid);
>> +	if (!parent_fval)
>> +		return 0;
>> +
>> +	/* Start counting for the new task by adding it into filter map,
>> +	 * inherit the accum key of its parent task so that they can be
>> +	 * counted together.
>> +	 */
>> +	child_fval.accum_key = parent_fval->accum_key;
>> +	child_fval.exited = 0;
>> +	bpf_map_update_elem(&filter, &child_pid, &child_fval, BPF_NOEXIST);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("tp_btf/sched_process_exit")
>> +int BPF_PROG(on_exittask, struct task_struct *task)
>> +{
>> +	__u32 pid;
>> +	struct bperf_filter_value *fval;
>> +
>> +	if (!enabled)
>> +		return 0;
>> +
>> +	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
>> +		return 0;
> 
> Ditto.
> 
> Thanks,
> Namhyung
> 
>> +
>> +	/* Stop counting for this task by removing it from filter map */
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


