Return-Path: <bpf+bounces-69919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C3BA6793
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 06:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389863BDC27
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B364283695;
	Sun, 28 Sep 2025 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mhym6ZsV"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DD259CA7
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759032713; cv=none; b=QMWZenP3oPmC9fgUq3rKojc29+QJQXSkValwgOn7cVVEdlAH5Uy9VuQuz7Seg5kS1jyy6gD+l3T9SaMKRndpEXaqcZsCej9IGwknyDoyzI+gc2MvJoCZVyvZ1Z/QMLKWtCXdy4DBBOngPRk69fzj3LmYP9yszn2JWzpWvj+9Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759032713; c=relaxed/simple;
	bh=+qDzAiKj/w/3mHf+fMrBzq+hgXPWUw8DSBBX0hWelN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctHFR08ajoZKOaKpqsZrgzWz5Mzdw9X92RgF7Q2u5AsI5G67iPxeTyMqUBmJFwnX3kKD7pceLeCK71JT5BL0mbX3Yuty3mImGG0J8sX+8vo+CHz/dwsOJwVDC6ptpPaWJM/DtN8wiNUpGFMfFPbYbYTUyUUS+2kH4WBhaFzWC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mhym6ZsV; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0a4134e-66f0-4266-b4d3-0c080a684d96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759032699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTjbTzemrHJVc5NjsMYuvPqqXOO67dFYOMRW5eKsCg8=;
	b=Mhym6ZsVzRRan1ZeS/YgWYJufGMlNPPpzFc8SA3lvP6GI9e8ebDu9DlE485Se4miOHhE8W
	TT0FBHnR8+4dLa8QWMon9hjsHx7geRHZNnFOpKpv9RQhDjf/a1K7RetzfqkDy9yINw27h9
	yIkJ4vXngUT58nk3LJxrRSjZAad3Ei8=
Date: Sun, 28 Sep 2025 12:11:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Add preempt_disable to protect
 get_perf_callchain
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153952.1661146-1-chen.dylane@linux.dev>
 <CAEf4BzbLJtMGaZoFAaAgnNXe8GCStsw+kZ_3hWoGfySWZ6B5mg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbLJtMGaZoFAaAgnNXe8GCStsw+kZ_3hWoGfySWZ6B5mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/27 02:52, Andrii Nakryiko 写道:
> On Fri, Sep 26, 2025 at 8:40 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. We therefore use bpf_perf_callchain_entries percpu entries
>> similarly to bpf_try_get_buffers to preserve the current task's
>> callchain and prevent overwriting by preempting tasks. And we also
>> add preempt_disable to protect get_perf_callchain.
>>
>> Reported-by: Alexei Starovoitov <ast@kernel.org>
>> Closes: https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 76 ++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 61 insertions(+), 15 deletions(-)
>>
>> Change list:
>>   v1 -> v2:
>>    From Alexei
>>    - create percpu entris to preserve current task's callchain
>>      similarly to bpf_try_get_buffers.
>>    v1: https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@linux.dev
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 2e182a3ac4c..8788c219926 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -31,6 +31,55 @@ struct bpf_stack_map {
>>          struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>>   };
>>
>> +struct bpf_perf_callchain_entry {
>> +       u64 nr;
>> +       u64 ip[PERF_MAX_STACK_DEPTH];
>> +};
>> +
>> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
>> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN_PREEMPT],
>> +                     bpf_perf_callchain_entries);
>> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);
>> +
>> +static int bpf_get_perf_callchain(struct bpf_perf_callchain_entry **entry,
>> +                                 struct pt_regs *regs, u32 init_nr, bool kernel,
>> +                                 bool user, u32 max_stack, bool crosstack,
>> +                                 bool add_mark)
>> +{
>> +       struct bpf_perf_callchain_entry *bpf_entry;
>> +       struct perf_callchain_entry *perf_entry;
>> +       int preempt_cnt;
>> +
>> +       preempt_cnt = this_cpu_inc_return(bpf_perf_callchain_preempt_cnt);
>> +       if (WARN_ON_ONCE(preempt_cnt > MAX_PERF_CALLCHAIN_PREEMPT)) {
>> +               this_cpu_dec(bpf_perf_callchain_preempt_cnt);
>> +               return -EBUSY;
>> +       }
>> +
>> +       bpf_entry = this_cpu_ptr(&bpf_perf_callchain_entries[preempt_cnt - 1]);
>> +
>> +       preempt_disable();
>> +       perf_entry = get_perf_callchain(regs, init_nr, kernel, user, max_stack,
>> +                                       crosstack, add_mark);
>> +       if (unlikely(!perf_entry)) {
>> +               preempt_enable();
>> +               this_cpu_dec(bpf_perf_callchain_preempt_cnt);
>> +               return -EFAULT;
>> +       }
>> +       memcpy(bpf_entry, perf_entry, sizeof(u64) * (perf_entry->nr + 1));
> 
> N copies of a stack trace is not good enough, let's have N + 1 now :)
> 
> If we are going with our own buffers, we need to teach
> get_perf_callchain to let us pass that buffer directly to avoid that
> unnecessary copy.
> 
> Also, I know it's about 1KB, but it would be so simple and efficient
> to just have this bpf_perf_callchain_entry on the stack. Kernel has a
> 16KB stack, right? It feels like for something like this using 1KB of
> the stack to simplify and speed up stack trace capture is a good
> enough reason.
> 

It's a good idea, if that's the case, do we also not need 
preempt_disable for get_perf_callchain?

>> +       *entry = bpf_entry;
>> +       preempt_enable();
>> +
>> +       return 0;
>> +}
>> +
>> +static void bpf_put_perf_callchain(void)
>> +{
>> +       if (WARN_ON_ONCE(this_cpu_read(bpf_perf_callchain_preempt_cnt) == 0))
>> +               return;
>> +       this_cpu_dec(bpf_perf_callchain_preempt_cnt);
>> +}
>> +
>>   static inline bool stack_map_use_build_id(struct bpf_map *map)
>>   {
>>          return (map->map_flags & BPF_F_STACK_BUILD_ID);
>> @@ -303,8 +352,9 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          u32 max_depth = map->value_size / stack_map_data_size(map);
>>          u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>          bool user = flags & BPF_F_USER_STACK;
>> -       struct perf_callchain_entry *trace;
>> +       struct bpf_perf_callchain_entry *trace;
>>          bool kernel = !user;
>> +       int err;
>>
>>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>                                 BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>> @@ -314,14 +364,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          if (max_depth > sysctl_perf_event_max_stack)
>>                  max_depth = sysctl_perf_event_max_stack;
>>
>> -       trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>> -                                  false, false);
>> +       err = bpf_get_perf_callchain(&trace, regs, 0, kernel, user, max_depth,
>> +                                    false, false);
>> +       if (err)
>> +               return err;
>>
>> -       if (unlikely(!trace))
>> -               /* couldn't fetch the stack trace */
>> -               return -EFAULT;
>> +       err = __bpf_get_stackid(map, (struct perf_callchain_entry *)trace, flags);
>> +       bpf_put_perf_callchain();
>>
>> -       return __bpf_get_stackid(map, trace, flags);
>> +       return err;
>>   }
>>
>>   const struct bpf_func_proto bpf_get_stackid_proto = {
>> @@ -443,8 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          if (sysctl_perf_event_max_stack < max_depth)
>>                  max_depth = sysctl_perf_event_max_stack;
>>
>> -       if (may_fault)
>> -               rcu_read_lock(); /* need RCU for perf's callchain below */
>> +       preempt_disable();
>>
>>          if (trace_in)
>>                  trace = trace_in;
>> @@ -455,8 +505,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                                             crosstask, false);
>>
>>          if (unlikely(!trace) || trace->nr < skip) {
>> -               if (may_fault)
>> -                       rcu_read_unlock();
>> +               preempt_enable();
>>                  goto err_fault;
>>          }
>>
>> @@ -474,10 +523,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          } else {
>>                  memcpy(buf, ips, copy_len);
>>          }
>> -
>> -       /* trace/ips should not be dereferenced after this point */
>> -       if (may_fault)
>> -               rcu_read_unlock();
>> +       preempt_enable();
>>
>>          if (user_build_id)
>>                  stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
> 
> really it's just build_id resolution that can take a while, which is
> why we are trying to avoid preemption around it. But for non-build_id
> case, can we avoid extra copying?
> 
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

