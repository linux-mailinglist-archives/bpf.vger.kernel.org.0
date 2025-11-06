Return-Path: <bpf+bounces-73788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850BC3943A
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 07:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8204E34F83B
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878E2DC335;
	Thu,  6 Nov 2025 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KuyG9orG"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33042D8781
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410082; cv=none; b=QiosfNuCNCoL5B9E3u7gwN9ea7mMw9KtXDrumjt0PSMB1AQK1AoIzDwX3dbXSV4yUy32zZ43o22hypO+Kdazv4o844VVuFXJ9PhDZg4SEdzgUhGAYzV7w1pWItT54GZVHLuNdiJZcOTbaMuZa7PikRwwVlaFOCQMpURLHCZbpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410082; c=relaxed/simple;
	bh=abKb5CfZvJNGhEenqOGbu+zmBxdUtT+s+KOcu4Z7NB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxByCrii6kneg6nZ151SjqoMxzTPxFCoCURxeNDkdZVzERAZj7509K9oJo9IIjDIrfp8aaLCuJse1Xvjmfc4UFasLZz1qbEVHvc2KqTBZhMKSNHhqwDye7ncvz+JQofcBiJHNnYvw09AXh9Atj4aZU1irBmbd6bF1pT5JevDGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KuyG9orG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04002253-1edf-4957-a43e-bd6dcc465dcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762410068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hL6DGlvfqnJjww1xq+st54rj3XETpUdgjatzms+S4Zc=;
	b=KuyG9orGa4Ydr/lDvPCFz2F/1SM92tLvWZIahOwcgGy01ifHNmfKDt0Nkq0r6dWMld659a
	6QqEJEEJtybZFtKtECAjsuiM17hMGgF91Y+y917HJ5bavnEmPCOg6Ey4cy5cQA06gqZJgd
	YKp038G/Pqw4uz5z6MmOTX+STYPW1qw=
Date: Wed, 5 Nov 2025 22:20:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Hold the perf callchain entry until
 used completely
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251028162502.3418817-1-chen.dylane@linux.dev>
 <20251028162502.3418817-3-chen.dylane@linux.dev>
 <c352f357-1417-47b5-9d8c-28d99f20f5a6@linux.dev>
 <363717bf-499a-4e47-b2c9-8a6e4105282c@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <363717bf-499a-4e47-b2c9-8a6e4105282c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 9:12 PM, Tao Chen wrote:
> 在 2025/11/6 06:16, Yonghong Song 写道:
>>
>>
>> On 10/28/25 9:25 AM, Tao Chen wrote:
>>> As Alexei noted, get_perf_callchain() return values may be reused
>>> if a task is preempted after the BPF program enters migrate disable
>>> mode. The perf_callchain_entres has a small stack of entries, and
>>> we can reuse it as follows:
>>>
>>> 1. get the perf callchain entry
>>> 2. BPF use...
>>> 3. put the perf callchain entry
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   kernel/bpf/stackmap.c | 61 
>>> ++++++++++++++++++++++++++++++++++---------
>>>   1 file changed, 48 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index e28b35c7e0b..70d38249083 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -188,13 +188,12 @@ static void 
>>> stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>>   }
>>>   static struct perf_callchain_entry *
>>> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>>> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, 
>>> u32 max_depth)
>>>   {
>>>   #ifdef CONFIG_STACKTRACE
>>>       struct perf_callchain_entry *entry;
>>> -    int rctx;
>>> -    entry = get_callchain_entry(&rctx);
>>> +    entry = get_callchain_entry(rctx);
>>>       if (!entry)
>>>           return NULL;
>>> @@ -216,8 +215,6 @@ get_callchain_entry_for_task(struct task_struct 
>>> *task, u32 max_depth)
>>>               to[i] = (u64)(from[i]);
>>>       }
>>> -    put_callchain_entry(rctx);
>>> -
>>>       return entry;
>>>   #else /* CONFIG_STACKTRACE */
>>>       return NULL;
>>> @@ -297,6 +294,31 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>>       return id;
>>>   }
>>> +static struct perf_callchain_entry *
>>> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool 
>>> kernel, bool user,
>>> +               int max_stack, bool crosstask)
>>> +{
>>> +    struct perf_callchain_entry_ctx ctx;
>>> +    struct perf_callchain_entry *entry;
>>> +
>>> +    entry = get_callchain_entry(rctx);
>>
>> I think this may not work. Let us say we have two bpf programs
>> both pinned to a particular cpu (migrate disabled but preempt enabled).
>> get_callchain_entry() calls get_recursion_context() to get the
>> buffer for a particulart level.
>>
>> static inline int get_recursion_context(u8 *recursion)
>> {
>>          unsigned char rctx = interrupt_context_level();
>>          if (recursion[rctx])
>>                  return -1;
>>          recursion[rctx]++;
>>          barrier();
>>          return rctx;
>> }
>>
>> It is possible that both tasks (at process level) may
>> reach right before "recursion[rctx]++;".
>> In such cases, both tasks will be able to get
>> buffer and this is not right.
>>
>> To fix this, we either need to have preempt disable
>> in bpf side, or maybe we have some kind of atomic
>> operation (cmpxchg or similar things), or maybe
>> has a preempt disable between if statement and recursion[rctx]++,
>> so only one task can get buffer?
>>
>
> Thanks to your reminder, can we add preempt disable before and after 
> get_callchain_entry, avoid affecting the original functions of perf.

Yes, we get two get_callchain_entry() call site:
   bpf/stackmap.c: entry = get_callchain_entry(&rctx);
   events/callchain.c:     entry = get_callchain_entry(&rctx);
We need to have preempt_disable()/preempt_enable() around them.

Another choice maybe adds preempt_disable/enable() for
get_callchain_entry() and get_perf_callchain() in stackmap.c,
assuming these two function usage in other places are for
interrupts (softirq, hardirq and nmi) so they are okay.

But maybe the following is better?

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index d9cc57083091..0ccf94315954 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -214,12 +214,9 @@ static inline int get_recursion_context(u8 *recursion)
  {
         unsigned char rctx = interrupt_context_level();
  
-       if (recursion[rctx])
+       if (cmpxchg(&recursion[rctx], 0, 1) != 0)
                 return -1;
  
-       recursion[rctx]++;
-       barrier();
-
         return rctx;
  }

>
> Regarding multiple task preemption: if the entry is not released via 
> put_callchain_entry, it appears that perf's buffer does not support 
> recording the second task, so it returns directly here.
>
>           if (recursion[rctx])
>                   return -1;
>
>>
>>> +    if (unlikely(!entry))
>>> +        return NULL;
>>> +
>>> +    __init_perf_callchain_ctx(&ctx, entry, max_stack, false);
>>> +    if (kernel)
>>> +        __get_perf_callchain_kernel(&ctx, regs);
>>> +    if (user && !crosstask)
>>> +        __get_perf_callchain_user(&ctx, regs);
>>> +
>>> +    return entry;
>>> +}
>>> +
>>> +static void bpf_put_callchain_entry(int rctx)
>>
>> we have bpf_get_perf_callchain(), maybe rename the above
>> to bpf_put_perf_callchain()?
>>
>
> Ack, thanks.
>
>>> +{
>>> +    put_callchain_entry(rctx);
>>> +}
>>> +
>>
>> [...]
>>
>
>


