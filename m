Return-Path: <bpf+bounces-70782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CDBCF84A
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D23A3E91
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9927F00E;
	Sat, 11 Oct 2025 16:25:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495B1548C;
	Sat, 11 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760199923; cv=none; b=H8iM+fypwZFrMIhPCYdqo3SbajYW7BzQ+Vg76EFS6xUuc9dIX0gZmyIvCWzNvWVcu5z/vG5QLW3S0MSH524lJYj6PdSfQCgBaNnJ32XlD1SlSYLarqPC+MZhGlfqLNSrDuWfVA7aCglSlZfjBSa1Jof1FaUw3xg89OidkRdYNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760199923; c=relaxed/simple;
	bh=dbeHMQ5/T17YbKYvubrvV7NlkXNqFlPgtItSYlStG4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjvfpCxVx23fNGsRREX2otPY4ajv6FEmotDEYZl9owlqgXFctnUdc2AN3zQ5F5ac9lI4a7uksIsD3U5lIh6Cc8yBIkRDMFBhIMhTZtL/a9VDaa8Yuvp9AHbY7fBtxEcrF5hrFtXpPGz4Sv4EOZGX7LMvtVZHmcrQJgtEplyBR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.5.62.16] (unknown [89.100.17.9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 1ABEA40A76;
	Sat, 11 Oct 2025 16:25:11 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 89.100.17.9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.5.62.16]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <1169f4ac-c28a-442f-bcbc-2cf8e2beb3f5@arnaud-lcm.com>
Date: Sat, 11 Oct 2025 17:25:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/3] bpf: refactor max_depth computation in
 bpf_get_stack()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250912233409.74900-1-contact@arnaud-lcm.com>
 <CAEf4BzZ-ovqXqLJ5oJ95n9prFnXsLOkO1UvdycUcON77=Akv-w@mail.gmail.com>
 <60553783-125a-4628-bd17-a7c40841d0ae@arnaud-lcm.com>
 <CAEf4BzbBR7GBnWCA4E-RuEkbYJ7bUEfmJ5nd0g8G_bV0MG5tAA@mail.gmail.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAEf4BzbBR7GBnWCA4E-RuEkbYJ7bUEfmJ5nd0g8G_bV0MG5tAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176019991194.20205.3023393961942335238@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 22/09/2025 23:38, Andrii Nakryiko wrote:
> On Sat, Sep 20, 2025 at 12:32 PM Lecomte, Arnaud <contact@arnaud-lcm.com> wrote:
>>
>> On 19/09/2025 23:50, Andrii Nakryiko wrote:
>>
>> On Fri, Sep 12, 2025 at 4:34 PM Arnaud Lecomte <contact@arnaud-lcm.com> wrote:
>>
>> A new helper function stack_map_calculate_max_depth() that
>> computes the max depth for a stackmap.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Acked-by: Song Liu <song@kernel.org>
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>> Changes in v2:
>>   - Removed the checking 'map_size % map_elem_size' from
>>     stack_map_calculate_max_depth
>>   - Changed stack_map_calculate_max_depth params name to be more generic
>>
>> Changes in v3:
>>   - Changed map size param to size in max depth helper
>>
>> Changes in v4:
>>   - Fixed indentation in max depth helper for args
>>
>> Changes in v5:
>>   - Bound back trace_nr to num_elem in __bpf_get_stack
>>   - Make a copy of sysctl_perf_event_max_stack
>>     in stack_map_calculate_max_depth
>>
>> Changes in v6:
>>   - Restrained max_depth computation only when required
>>   - Additional cleanup from Song in __bpf_get_stack
>>
>> Changes in v7:
>>   - Removed additional cleanup from v6
>>
>> Changes in v9:
>>   - Fixed incorrect removal of num_elem in get stack
>>
>> Link to v8: https://lore.kernel.org/all/20250905134625.26531-1-contact@arnaud-lcm.com/
>> ---
>> ---
>>   kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++++------------
>>   1 file changed, 27 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 3615c06b7dfa..a794e04f5ae9 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
>>                  sizeof(struct bpf_stack_build_id) : sizeof(u64);
>>   }
>>
>> +/**
>> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
>> + * @size:  Size of the buffer/map value in bytes
>> + * @elem_size:  Size of each stack trace element
>> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
>> + *
>> + * Return: Maximum number of stack trace entries that can be safely stored
>> + */
>> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
>> +{
>> +       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> +       u32 max_depth;
>> +       u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
>> +
>> +       max_depth = size / elem_size;
>> +       max_depth += skip;
>> +       if (max_depth > curr_sysctl_max_stack)
>> +               return curr_sysctl_max_stack;
>> +
>> +       return max_depth;
>> +}
>> +
>>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>>   {
>>          u64 elem_size = sizeof(struct stack_map_bucket) +
>> @@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>             u64, flags)
>>   {
>> -       u32 max_depth = map->value_size / stack_map_data_size(map);
>> -       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> +       u32 elem_size = stack_map_data_size(map);
>>          bool user = flags & BPF_F_USER_STACK;
>>          struct perf_callchain_entry *trace;
>>          bool kernel = !user;
>> +       u32 max_depth;
>>
>>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>                                 BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>>                  return -EINVAL;
>>
>> -       max_depth += skip;
>> -       if (max_depth > sysctl_perf_event_max_stack)
>> -               max_depth = sysctl_perf_event_max_stack;
>> -
>> +       max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>>          trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>>                                     false, false);
>>
>> @@ -406,7 +425,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                              struct perf_callchain_entry *trace_in,
>>                              void *buf, u32 size, u64 flags, bool may_fault)
>>   {
>> -       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>> +       u32 trace_nr, copy_len, elem_size, max_depth;
>>          bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>>          bool crosstask = task && task != current;
>>          u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> @@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                  goto clear;
>>          }
>>
>> -       num_elem = size / elem_size;
>> -       max_depth = num_elem + skip;
>> -       if (sysctl_perf_event_max_stack < max_depth)
>> -               max_depth = sysctl_perf_event_max_stack;
>> +       max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>>
>>          if (may_fault)
>>                  rcu_read_lock(); /* need RCU for perf's callchain below */
>> @@ -461,7 +477,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          }
>>
>>          trace_nr = trace->nr - skip;
>> -       trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>>
>> Is this also part of refactoring? If yes, it deserves a mention on why
>> it's ok to just drop this.
>>
>> pw-bot: cr
>>
>> Yes it is also part of the refactoring as stack_map_calculate_max_depth now already curtains the trace->nr to the max possible number of elements, there is no need to do the clamping twice. This is valid assuming that get_perf_callchain and get_callchain_entry_for_task correctly set this limit.
>>
> What about that third case:
>
> if (trace_in)
>      trace = trace_in;
>
> Did you analyze if that gets its trace->nr set properly as well (as of
> this patch, without taking into account changes in the follow up
> patches). Because it looks like this removal belongs in patch #2, no?
>
> In either case, all the other changes in this patch except the removal
> of this line is refactoring and as far as I can tell don't change the
> logic. This line removal does (potentially) change the logic, so it
> would be good to do it separately, explaining why you think it's the
> correct thing to do.
Back from holidays, catching up now :)
You are indeed totally right Andrii, thanks for pointing it out.
We should squash the 2 first patch together.
>
>
>>          copy_len = trace_nr * elem_size;
>>
>>          ips = trace->ip + skip;
>> --
>> 2.43.0
>>
>> Thanks,
>> Arnaud
Thanks,
Arnaud

