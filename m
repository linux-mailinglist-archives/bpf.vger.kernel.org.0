Return-Path: <bpf+bounces-65450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE0B2390D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828453A2279
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1702D540D;
	Tue, 12 Aug 2025 19:32:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E23274B29;
	Tue, 12 Aug 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027139; cv=none; b=V/1PJZ90etxaTU3E7lR/tKtzQVcH3pOEv1WFjIhoiFw9AbQ6W1RhQzVopsVr7npkWkLvowiyGYRWta+AGJsMuTb+nqmYCXbZxH2SWeSh2R7l1hBetcrjaAj/jYtQywD0lAO1mQPNLghCNo2ADl05m7PwwSHM4dhQrJG6WTMYWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027139; c=relaxed/simple;
	bh=sw/YuyXbj0SKwdTzogkSVkX70Y3N33Yy9MoAIY+BExE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lE8idhYFuYkNCaylHWzEYH7pxmbmlx6O1wwIEpw9jybf/kK4fscnX81sbfz9eR7j6qDO4cEP+H8/YhGgZhgpDMXPACS9iYLJZGQNBCxYY5TsAwhL1MeFu25pE9rA49z6Rp5a4eJT7eHK0e+f4Bdx/m1LBEAP7Q52PeEZD2kaHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:acd6:d96f:40a0:aee] (unknown [IPv6:2a02:8084:255b:aa00:acd6:d96f:40a0:aee])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id ED80F4139D;
	Tue, 12 Aug 2025 19:32:12 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:acd6:d96f:40a0:aee) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:acd6:d96f:40a0:aee]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <084a70f2-96ef-43a1-a1d0-863496c4547e@arnaud-lcm.com>
Date: Tue, 12 Aug 2025 20:32:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250809115833.87033-1-contact@arnaud-lcm.com>
 <20250809120911.88670-1-contact@arnaud-lcm.com>
 <ef33d3cb-4346-41af-9e0e-541fdc007f89@linux.dev>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: <ef33d3cb-4346-41af-9e0e-541fdc007f89@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175502713383.30733.7319759797711796805@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Thanks Yonghong for your feedbacks and your patience !

On 12/08/2025 05:39, Yonghong Song wrote:
>
>
> On 8/9/25 5:09 AM, Arnaud Lecomte wrote:
>> A new helper function stack_map_calculate_max_depth() that
>> computes the max depth for a stackmap.
>
> Please add 'bpf-next' in the subject like [PATCH bpf-next v2 1/2]
> so CI can properly test the patch set.
>
>>
>> Changes in v2:
>>   - Removed the checking 'map_size % map_elem_size' from 
>> stack_map_calculate_max_depth
>>   - Changed stack_map_calculate_max_depth params name to be more generic
>>
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 3615c06b7dfa..532447606532 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct 
>> bpf_map *map)
>>           sizeof(struct bpf_stack_build_id) : sizeof(u64);
>>   }
>>   +/**
>> + * stack_map_calculate_max_depth - Calculate maximum allowed stack 
>> trace depth
>> + * @map_size:        Size of the buffer/map value in bytes
>
> let us rename 'map_size' to 'size' since the size represents size of
> buffer or map, not just for map.
>
>> + * @elem_size:       Size of each stack trace element
>> + * @flags:       BPF stack trace flags (BPF_F_USER_STACK, 
>> BPF_F_USER_BUILD_ID, ...)
>> + *
>> + * Return: Maximum number of stack trace entries that can be safely 
>> stored
>> + */
>> +static u32 stack_map_calculate_max_depth(u32 map_size, u32 
>> elem_size, u64 flags)
>
> map_size -> size
> Also, you can replace 'flags' to 'skip', so below 'u32 skip = flags & 
> BPF_F_SKIP_FIELD_MASK'
> is not necessary.
>
>> +{
>> +    u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> +    u32 max_depth;
>> +
>> +    max_depth = map_size / elem_size;
>> +    max_depth += skip;
>> +    if (max_depth > sysctl_perf_event_max_stack)
>> +        return sysctl_perf_event_max_stack;
>> +
>> +    return max_depth;
>> +}
>> +
>>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>>   {
>>       u64 elem_size = sizeof(struct stack_map_bucket) +
>> @@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
>> struct task_struct *task,
>>                   struct perf_callchain_entry *trace_in,
>>                   void *buf, u32 size, u64 flags, bool may_fault)
>>   {
>> -    u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>> +    u32 trace_nr, copy_len, elem_size, max_depth;
>>       bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>>       bool crosstask = task && task != current;
>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> @@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs 
>> *regs, struct task_struct *task,
>>           goto clear;
>>       }
>>   -    num_elem = size / elem_size;
>> -    max_depth = num_elem + skip;
>> -    if (sysctl_perf_event_max_stack < max_depth)
>> -        max_depth = sysctl_perf_event_max_stack;
>> +    max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>>         if (may_fault)
>>           rcu_read_lock(); /* need RCU for perf's callchain below */
>> @@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
>> struct task_struct *task,
>>       }
>>         trace_nr = trace->nr - skip;
>> -    trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>> +    trace_nr = min(trace_nr, max_depth - skip);
>>       copy_len = trace_nr * elem_size;
>>         ips = trace->ip + skip;
>
>

