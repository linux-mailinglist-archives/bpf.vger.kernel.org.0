Return-Path: <bpf+bounces-66445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079FB34B86
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80177242517
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129C286417;
	Mon, 25 Aug 2025 20:07:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91979285C8F;
	Mon, 25 Aug 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152436; cv=none; b=pxrNWNUUSfjVTXjVSVB/8gPbMSnyFziltDwDYN+wUWsW8m+JeS1vK8zadO4hUkV4mR16gt8NK/7JcURLiQpNnhz7QL4YN+Pv60vGgPEP9Dw7ShdB2Vlf2e2/p4/qLeR7bX4kHHlrbYhXgM/7FPFORJAycVft5bLo/FXx00Qx4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152436; c=relaxed/simple;
	bh=YCRhxx3RdlApPSKFaF9dmlJcjWTwvnvYlnLGiNohuss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLBP8IRAjHX52kpbmH9ASi4ZE2NDY8Yfeg79f2FikUAr2yhRYHocaIyD0PMFg3VYK6a8PO9jIp223XW4eYtJg+tVRJfdKex2g60EvVy8pXmFhDB0gpO2xg16GlCRuxkCCesLjNHs34X9AOz/6fRDB/Gzo0BYEHQmglc2iGYQ+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:5463:d190:b7cc:eed1] (unknown [IPv6:2a02:8084:255b:aa00:5463:d190:b7cc:eed1])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 8D1D340099;
	Mon, 25 Aug 2025 20:07:11 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:5463:d190:b7cc:eed1) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:5463:d190:b7cc:eed1]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <0165bf55-4a46-4e75-91df-644b0281b247@arnaud-lcm.com>
Date: Mon, 25 Aug 2025 21:07:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next RESEND v4 1/2] bpf: refactor max_depth
 computation in bpf_get_stack()
To: Yonghong Song <yonghong.song@linux.dev>,
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
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <43b9d0ff-9922-490a-ac6b-7e8e7baa2247@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175615243259.32519.10645825439471745222@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 25/08/2025 19:27, Yonghong Song wrote:
>
>
> On 8/25/25 9:39 AM, Lecomte, Arnaud wrote:
>>
>> On 19/08/2025 22:15, Martin KaFai Lau wrote:
>>> On 8/19/25 9:26 AM, Arnaud Lecomte wrote:
>>>> A new helper function stack_map_calculate_max_depth() that
>>>> computes the max depth for a stackmap.
>>>>
>>>> Changes in v2:
>>>>   - Removed the checking 'map_size % map_elem_size' from
>>>>     stack_map_calculate_max_depth
>>>>   - Changed stack_map_calculate_max_depth params name to be more 
>>>> generic
>>>>
>>>> Changes in v3:
>>>>   - Changed map size param to size in max depth helper
>>>>
>>>> Changes in v4:
>>>>   - Fixed indentation in max depth helper for args
>>>>
>>>> Link to v3: 
>>>> https://lore.kernel.org/all/09dc40eb-a84e-472a-8a68-36a2b1835308@linux.dev/
>>>>
>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>>>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>> index 3615c06b7dfa..b9cc6c72a2a5 100644
>>>> --- a/kernel/bpf/stackmap.c
>>>> +++ b/kernel/bpf/stackmap.c
>>>> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct 
>>>> bpf_map *map)
>>>>           sizeof(struct bpf_stack_build_id) : sizeof(u64);
>>>>   }
>>>>   +/**
>>>> + * stack_map_calculate_max_depth - Calculate maximum allowed stack 
>>>> trace depth
>>>> + * @size:  Size of the buffer/map value in bytes
>>>> + * @elem_size:  Size of each stack trace element
>>>> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, 
>>>> BPF_F_USER_BUILD_ID, ...)
>>>> + *
>>>> + * Return: Maximum number of stack trace entries that can be 
>>>> safely stored
>>>> + */
>>>> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, 
>>>> u64 flags)
>>>> +{
>>>> +    u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>> +    u32 max_depth;
>>>> +
>>>> +    max_depth = size / elem_size;
>>>> +    max_depth += skip;
>>>> +    if (max_depth > sysctl_perf_event_max_stack)
>>>> +        return sysctl_perf_event_max_stack;
>>>
>>> hmm... this looks a bit suspicious. Is it possible that 
>>> sysctl_perf_event_max_stack is being changed to a larger value in 
>>> parallel?
>>>
>> Hi Martin, this is a valid concern as sysctl_perf_event_max_stack can 
>> be modified at runtime through /proc/sys/kernel/perf_event_max_stack.
>> What we could maybe do instead is to create a copy: u32 current_max = 
>> READ_ONCE(sysctl_perf_event_max_stack);
>> Any thoughts on this ?
>
> There is no need to have READ_ONCE. Jut do
>     int curr_sysctl_max_stack = sysctl_perf_event_max_stack;
>     if (max_depth > curr_sysctl_max_stack)
>       return curr_sysctl_max_stack;
>
> Because of the above change, the patch is not a refactoring change any 
> more.
>
Why would you not consider it as a refactoring change anymore ?
>>
>>>> +
>>>> +    return max_depth;
>>>> +}
>>>> +
>>>>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>>>>   {
>>>>       u64 elem_size = sizeof(struct stack_map_bucket) +
>>>> @@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>> *regs, struct task_struct *task,
>>>>                   struct perf_callchain_entry *trace_in,
>>>>                   void *buf, u32 size, u64 flags, bool may_fault)
>>>>   {
>>>> -    u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>>>> +    u32 trace_nr, copy_len, elem_size, max_depth;
>>>>       bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>>>>       bool crosstask = task && task != current;
>>>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>> @@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>> *regs, struct task_struct *task,
>>>>           goto clear;
>>>>       }
>>>>   -    num_elem = size / elem_size;
>>>> -    max_depth = num_elem + skip;
>>>> -    if (sysctl_perf_event_max_stack < max_depth)
>>>> -        max_depth = sysctl_perf_event_max_stack;
>>>> +    max_depth = stack_map_calculate_max_depth(size, elem_size, 
>>>> flags);
>>>>         if (may_fault)
>>>>           rcu_read_lock(); /* need RCU for perf's callchain below */
>>>> @@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs 
>>>> *regs, struct task_struct *task,
>>>>       }
>>>>         trace_nr = trace->nr - skip;
>>>> -    trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>>>
>>> I suspect it was fine because trace_nr was still bounded by num_elem.
>>>
>> We should bring back the num_elem bound as an additional safe net.
>>>> +    trace_nr = min(trace_nr, max_depth - skip);
>>>
>>> but now the min() is also based on max_depth which could be 
>>> sysctl_perf_event_max_stack.
>>>
>>> beside, if I read it correctly, in "max_depth - skip", the max_depth 
>>> could also be less than skip. I assume trace->nr is bound by 
>>> max_depth, so should be less of a problem but still a bit 
>>> unintuitive to read.
>>>
>>>>       copy_len = trace_nr * elem_size;
>>>>         ips = trace->ip + skip;
>>>
>
>

