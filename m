Return-Path: <bpf+bounces-65100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A3DB1BE70
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 03:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7B518A5DEC
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016C165F16;
	Wed,  6 Aug 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2mDjGsv"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150F15B135
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445143; cv=none; b=G9b2V46pP/HLxbc84i2aQyHhCZVK56ZXhcT0pVzP/6dodOkWF2OzQUbszuAc9LL/nFxyEJI5n3LIvoG+WTltRfEvPANSorYhUFDqzNJgd/Z+UVtPPHGhS/50hxMXvbnNr8uL2u138Eh+YDW+fm4drHsoEqcwRohjVYFfXH08Mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445143; c=relaxed/simple;
	bh=b9f2rD1YfLu11WXwEctrIPJGra3IBhhwAmmXYkomVtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0dwDNJMMvJ90cdDjbyNYPfUfocf7x5L1OKgz+3WOSzhKXGIBUZtqetx/4L0VQWuFOABxG2UbBCMi0pyWXSFSA7BU1Km6Bu+1Equ/spMb1Bf4GhTsGvUtTJfVIvWS4sQODtNPRpJwnExdCZJZgvjVz1vRwNnW8MM62G0uhZbXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2mDjGsv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cc26e1f-6ad6-44cd-a049-c4e7af9a229a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754445138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rw84AxFvQ89TE/hsNrqClvGXCtds3haEjZkh5cXuYY=;
	b=F2mDjGsvg/ZhTwCHgJWl1vysoQHmg4gQsLQbS8ohwxJhkbECwfzIofiZ1UkNdQGVpob/2U
	lPim9f7XYXY4JRotsybJVWvKB3dtVt5ltdJCo7y/ikuui95ac1uKT8Enr0z+xf5i2X/Jx4
	LZLd4sdcmpbd7uOZAjktvH3XbojTrHU=
Date: Tue, 5 Aug 2025 18:52:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>, song@kernel.org,
 jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
References: <20250729165622.13794-1-contact@arnaud-lcm.com>
 <2b69e397-a457-4dba-86f1-47b7fe87ef79@linux.dev>
 <5124b615-3a71-4a44-a497-eea3b5964fda@arnaud-lcm.com>
 <6ce83e5c-de34-4ef2-b9f4-2ad15e645969@arnaud-lcm.com>
 <a0e172e9-e4d3-427f-b237-ba8f6b3772f4@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a0e172e9-e4d3-427f-b237-ba8f6b3772f4@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/5/25 1:49 PM, Arnaud Lecomte wrote:
> Hi,
> I gave it several tries and I can't find a nice to do see properly.
> The main challenge is to find a way to detect memory corruption. I 
> wanted to place a canary value
>  by tweaking the map size but we don't have a way from a BPF program 
> perspective to access to the size
> of a stack_map_bucket. If we decide to do this computation manually, 
> we would end-up with maintainability
>  issues:
> #include "vmlinux.h"
> #include "bpf/bpf_helpers.h"
>
> #define MAX_STACK_DEPTH 32
> #define CANARY_VALUE 0xBADCAFE
>
> /* Calculate size based on known layout:
>  * - fnode: sizeof(void*)
>  * - hash: 4 bytes
>  * - nr: 4 bytes
>  * - data: MAX_STACK_DEPTH * 8 bytes
>  * - canary: 8 bytes
>  */
> #define VALUE_SIZE (sizeof(void*) + 4 + 4 + (MAX_STACK_DEPTH * 8) + 8)
>
> struct {
>     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
>     __uint(max_entries, 1);
>     __uint(value_size, VALUE_SIZE);
>     __uint(key_size, sizeof(u32));
> } stackmap SEC(".maps");
>
> static __attribute__((noinline)) void recursive_helper(int depth) {
>     if (depth <= 0) return;
>     asm volatile("" ::: "memory");
>     recursive_helper(depth - 1);
> }
>
> SEC("kprobe/do_sys_open")
> int test_stack_overflow(void *ctx) {
>     u32 key = 0;
>     u64 *stack = bpf_map_lookup_elem(&stackmap, &key);
>     if (!stack) return 0;
>
>     stack[MAX_STACK_DEPTH] = CANARY_VALUE;
>
>     /* Force minimum stack depth */
>     recursive_helper(MAX_STACK_DEPTH + 10);
>
>     (void)bpf_get_stackid(ctx, &stackmap, 0);
>     return 0;
> }
>
> char _license[] SEC("license") = "GPL";

It looks like it hard to trigger memory corruption inside the kernel.
Maybe kasan can detect it for your specific example.

If without selftests, you can do the following:
__bpf_get_stack() already solved the problem you tried to fix.
I suggest you refactor some portions of the code in __bpf_get_stack()
to set trace_nr properly, and then you can use that refactored function
in __bpf_get_stackid(). So two patches:
   1. refactor portion of codes (related elem_size/trace_nr) in __bpf_get_stack().
   2. fix the issue in __bpf_get_stackid() with newly created function.

>
> On 01/08/2025 19:16, Lecomte, Arnaud wrote:
>> Well, it turns out it is less straightforward than it looked like to 
>> detect the memory corruption
>>  without KASAN. I am currently in holidays for the next 3 days so 
>> I've limited access to a
>> computer. I should be able to sort this out on monday.
>>
>> Thanks,
>> Arnaud
>>
>> On 30/07/2025 08:10, Arnaud Lecomte wrote:
>>> On 29/07/2025 23:45, Yonghong Song wrote:
>>>>
>>>>
>>>> On 7/29/25 9:56 AM, Arnaud Lecomte wrote:
>>>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>>>> __bpf_get_stackid()
>>>>> when copying stack trace data. The issue occurs when the perf trace
>>>>>   contains more stack entries than the stack map bucket can hold,
>>>>>   leading to an out-of-bounds write in the bucket's data array.
>>>>> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>>>>>   to determine capacity, and for normal mode we use sizeof(u64).
>>>>>
>>>>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>>>>> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>>
>>>> Could you add a selftest? This way folks can easily find out what is
>>>> the problem and why this fix solves the issue correctly.
>>>>
>>> Sure, will be done after work
>>> Thanks,
>>> Arnaud
>>>>> ---
>>>>> Changes in v2:
>>>>>   - Use utilty stack_map_data_size to compute map stack map size
>>>>> ---
>>>>>   kernel/bpf/stackmap.c | 8 +++++++-
>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>>> index 3615c06b7dfa..6f225d477f07 100644
>>>>> --- a/kernel/bpf/stackmap.c
>>>>> +++ b/kernel/bpf/stackmap.c
>>>>> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map 
>>>>> *map,
>>>>>       struct bpf_stack_map *smap = container_of(map, struct 
>>>>> bpf_stack_map, map);
>>>>>       struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>>>>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>>> -    u32 hash, id, trace_nr, trace_len, i;
>>>>> +    u32 hash, id, trace_nr, trace_len, i, max_depth;
>>>>>       bool user = flags & BPF_F_USER_STACK;
>>>>>       u64 *ips;
>>>>>       bool hash_matches;
>>>>> @@ -241,6 +241,12 @@ static long __bpf_get_stackid(struct bpf_map 
>>>>> *map,
>>>>>         trace_nr = trace->nr - skip;
>>>>>       trace_len = trace_nr * sizeof(u64);
>>>>> +
>>>>> +    /* Clamp the trace to max allowed depth */
>>>>> +    max_depth = smap->map.value_size / stack_map_data_size(map);
>>>>> +    if (trace_nr > max_depth)
>>>>> +        trace_nr = max_depth;
>>>>> +
>>>>>       ips = trace->ip + skip;
>>>>>       hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>>>>>       id = hash & (smap->n_buckets - 1);
>>>>
>>>>


