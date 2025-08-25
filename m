Return-Path: <bpf+bounces-66460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F4B34DC1
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5AE176172
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D023ABA0;
	Mon, 25 Aug 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIoa1C0+"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D9230BDF
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156523; cv=none; b=sajmU1ElyGXaX1FLQOYWLd4CrcwokNWZl/NrcDLi38YhqEkZKwqY0S8H+GVR/UsQ0GHAJZYL0p7r3q5VpxzBrA5EnVN6mvzDzcGFV0uAzJ9Xh0fIWuTWJWl5nW8dmyBSw30wkLTCN7QSy/3quhC6fHFgXEyHa5GvCAlZBr8DEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156523; c=relaxed/simple;
	bh=AbLB2eRMtTZnNOt/j5On2L0B7d0nlrQWpgV2/bU/veA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQNzxI+3jfPjZfY9joF5OJP5C+cUe1Hxieze8mUn/EN5qdeIgqmynuvDclNupLh2BtPf4mSGTlz0iTlgLJKfpSMceQiGegnqe1LzLATUK/orbrgcRuaemeEGG6qxoRZFilEtoYdTq/9besY9saCPro6QlrzSm9nfAnn6gWL3BX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JIoa1C0+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2feb48ea-4846-4030-b9fc-cc9300bab57f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756156514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnNxmZ2TVEDKw8UzTdWgJgQWMgrvXznrwWTltZCEw2g=;
	b=JIoa1C0+ao82/CXIozGCXasa+n/yN0qY0I5fGAKQcrhZPiiq1HarSCnZ9b1ZUbsA9VD5K4
	EyDR9PqfeDdhHw1K5dnNer6TW2vT/8LbjQqxH8G/rbvH/BtxoK2eLfsOokGeFpCBpDAbBL
	VydWLFZykROR6UCB+jDibCpO20rnqF4=
Date: Mon, 25 Aug 2025 14:15:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next RESEND v4 1/2] bpf: refactor max_depth
 computation in bpf_get_stack()
Content-Language: en-GB
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, song@kernel.org
References: <20250819162652.8776-1-contact@arnaud-lcm.com>
 <3d8fe484-2889-4367-9405-91aeee7d2ef0@linux.dev>
 <b15c8986-b407-4ae1-9e02-672c1cf9013f@arnaud-lcm.com>
 <43b9d0ff-9922-490a-ac6b-7e8e7baa2247@linux.dev>
 <0165bf55-4a46-4e75-91df-644b0281b247@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0165bf55-4a46-4e75-91df-644b0281b247@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/25/25 1:07 PM, Lecomte, Arnaud wrote:
>
> On 25/08/2025 19:27, Yonghong Song wrote:
>>
>>
>> On 8/25/25 9:39 AM, Lecomte, Arnaud wrote:
>>>
>>> On 19/08/2025 22:15, Martin KaFai Lau wrote:
>>>> On 8/19/25 9:26 AM, Arnaud Lecomte wrote:
>>>>> A new helper function stack_map_calculate_max_depth() that
>>>>> computes the max depth for a stackmap.
>>>>>
>>>>> Changes in v2:
>>>>>   - Removed the checking 'map_size % map_elem_size' from
>>>>>     stack_map_calculate_max_depth
>>>>>   - Changed stack_map_calculate_max_depth params name to be more 
>>>>> generic
>>>>>
>>>>> Changes in v3:
>>>>>   - Changed map size param to size in max depth helper
>>>>>
>>>>> Changes in v4:
>>>>>   - Fixed indentation in max depth helper for args
>>>>>
>>>>> Link to v3: 
>>>>> https://lore.kernel.org/all/09dc40eb-a84e-472a-8a68-36a2b1835308@linux.dev/
>>>>>
>>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> ---
>>>>>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>>>>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>>> index 3615c06b7dfa..b9cc6c72a2a5 100644
>>>>> --- a/kernel/bpf/stackmap.c
>>>>> +++ b/kernel/bpf/stackmap.c
>>>>> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct 
>>>>> bpf_map *map)
>>>>>           sizeof(struct bpf_stack_build_id) : sizeof(u64);
>>>>>   }
>>>>>   +/**
>>>>> + * stack_map_calculate_max_depth - Calculate maximum allowed 
>>>>> stack trace depth
>>>>> + * @size:  Size of the buffer/map value in bytes
>>>>> + * @elem_size:  Size of each stack trace element
>>>>> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, 
>>>>> BPF_F_USER_BUILD_ID, ...)
>>>>> + *
>>>>> + * Return: Maximum number of stack trace entries that can be 
>>>>> safely stored
>>>>> + */
>>>>> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, 
>>>>> u64 flags)
>>>>> +{
>>>>> +    u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>>> +    u32 max_depth;
>>>>> +
>>>>> +    max_depth = size / elem_size;
>>>>> +    max_depth += skip;
>>>>> +    if (max_depth > sysctl_perf_event_max_stack)
>>>>> +        return sysctl_perf_event_max_stack;
>>>>
>>>> hmm... this looks a bit suspicious. Is it possible that 
>>>> sysctl_perf_event_max_stack is being changed to a larger value in 
>>>> parallel?
>>>>
>>> Hi Martin, this is a valid concern as sysctl_perf_event_max_stack 
>>> can be modified at runtime through 
>>> /proc/sys/kernel/perf_event_max_stack.
>>> What we could maybe do instead is to create a copy: u32 current_max 
>>> = READ_ONCE(sysctl_perf_event_max_stack);
>>> Any thoughts on this ?
>>
>> There is no need to have READ_ONCE. Jut do
>>     int curr_sysctl_max_stack = sysctl_perf_event_max_stack;
>>     if (max_depth > curr_sysctl_max_stack)
>>       return curr_sysctl_max_stack;
>>
>> Because of the above change, the patch is not a refactoring change 
>> any more.
>>
> Why would you not consider it as a refactoring change anymore ?

Sorry, I think I made a couple of mistakes in the above.

First, yes, we do want READ_ONCE, other potentially compiler may optimization
the above back to the original code with two references to sysctl_perf_event_max_stack.

Second, yes, it is indeed a refactoring.

>>>
>>>>> +
>>>>> +    return max_depth;
>>>>> +}
>>>>> +
>>>>>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>>>>>   {
>>>>>       u64 elem_size = sizeof(struct stack_map_bucket) +
>>>>> @@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>>> *regs, struct task_struct *task,
>>>>>                   struct perf_callchain_entry *trace_in,
>>>>>                   void *buf, u32 size, u64 flags, bool may_fault)
>>>>>   {
>>>>> -    u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>>>>> +    u32 trace_nr, copy_len, elem_size, max_depth;
>>>>>       bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>>>>>       bool crosstask = task && task != current;
>>>>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>>> @@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>>> *regs, struct task_struct *task,
>>>>>           goto clear;
>>>>>       }
>>>>>   -    num_elem = size / elem_size;
>>>>> -    max_depth = num_elem + skip;
>>>>> -    if (sysctl_perf_event_max_stack < max_depth)
>>>>> -        max_depth = sysctl_perf_event_max_stack;
>>>>> +    max_depth = stack_map_calculate_max_depth(size, elem_size, 
>>>>> flags);
>>>>>         if (may_fault)
>>>>>           rcu_read_lock(); /* need RCU for perf's callchain below */
>>>>> @@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>>> *regs, struct task_struct *task,
>>>>>       }
>>>>>         trace_nr = trace->nr - skip;
>>>>> -    trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>>>>
>>>> I suspect it was fine because trace_nr was still bounded by num_elem.
>>>>
>>> We should bring back the num_elem bound as an additional safe net.
>>>>> +    trace_nr = min(trace_nr, max_depth - skip);
>>>>
>>>> but now the min() is also based on max_depth which could be 
>>>> sysctl_perf_event_max_stack.
>>>>
>>>> beside, if I read it correctly, in "max_depth - skip", the 
>>>> max_depth could also be less than skip. I assume trace->nr is bound 
>>>> by max_depth, so should be less of a problem but still a bit 
>>>> unintuitive to read.
>>>>
>>>>>       copy_len = trace_nr * elem_size;
>>>>>         ips = trace->ip + skip;
>>>>
>>
>>


