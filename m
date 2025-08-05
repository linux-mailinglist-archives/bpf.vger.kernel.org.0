Return-Path: <bpf+bounces-65089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D3B1BB87
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B2A185899
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D422D4C0;
	Tue,  5 Aug 2025 20:50:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2B78F2F;
	Tue,  5 Aug 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427000; cv=none; b=BGbvlXEPQTzTF6hj8RYpErSJcHfTkJ4/Rr1ZF/RxC6nW/7FM6GrGnYtXxjAHG8RjdXcOEqUGSAcq06dy3MEyFjKxwVHOzvdrMUrQ+KSKB0Nwl5IB3td0MFuz3xRRwBMV3Xc1KqGDUhvrAa6VyGhEMUeKwn9E6AyXJySetj7grBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427000; c=relaxed/simple;
	bh=aLhc8Bw36/66/OjVMNAvLc/anRiGdt29/5bujHg3EcY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q1Etp3TtMIiquc2fKBf6w0T72ywdRlhPtZRlRdiQQfOnRfRy1bedfoFw4z5myvZdFEk7PxiCcb8Dw79oi0Rai/x+D9EwVW2QU+Q8VVZQuhdNHEGKbQsrYiWJEYbtk7jJP1I1uQf/PC+K/4VNOYtudiEHSjXSxjr4LUj/HIgWmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:7b12:35fe:1712:13bc] (unknown [IPv6:2a02:8084:255b:aa00:7b12:35fe:1712:13bc])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 7B4A242077;
	Tue,  5 Aug 2025 20:49:49 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:7b12:35fe:1712:13bc) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:7b12:35fe:1712:13bc]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <a0e172e9-e4d3-427f-b237-ba8f6b3772f4@arnaud-lcm.com>
Date: Tue, 5 Aug 2025 21:49:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: Yonghong Song <yonghong.song@linux.dev>, song@kernel.org,
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
Content-Language: en-US
In-Reply-To: <6ce83e5c-de34-4ef2-b9f4-2ad15e645969@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175442699038.30990.12216209494253811498@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi,
I gave it several tries and I can't find a nice to do see properly.
The main challenge is to find a way to detect memory corruption. I 
wanted to place a canary value
  by tweaking the map size but we don't have a way from a BPF program 
perspective to access to the size
of a stack_map_bucket. If we decide to do this computation manually, we 
would end-up with maintainability
  issues:
#include "vmlinux.h"
#include "bpf/bpf_helpers.h"

#define MAX_STACK_DEPTH 32
#define CANARY_VALUE 0xBADCAFE

/* Calculate size based on known layout:
  * - fnode: sizeof(void*)
  * - hash: 4 bytes
  * - nr: 4 bytes
  * - data: MAX_STACK_DEPTH * 8 bytes
  * - canary: 8 bytes
  */
#define VALUE_SIZE (sizeof(void*) + 4 + 4 + (MAX_STACK_DEPTH * 8) + 8)

struct {
     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
     __uint(max_entries, 1);
     __uint(value_size, VALUE_SIZE);
     __uint(key_size, sizeof(u32));
} stackmap SEC(".maps");

static __attribute__((noinline)) void recursive_helper(int depth) {
     if (depth <= 0) return;
     asm volatile("" ::: "memory");
     recursive_helper(depth - 1);
}

SEC("kprobe/do_sys_open")
int test_stack_overflow(void *ctx) {
     u32 key = 0;
     u64 *stack = bpf_map_lookup_elem(&stackmap, &key);
     if (!stack) return 0;

     stack[MAX_STACK_DEPTH] = CANARY_VALUE;

     /* Force minimum stack depth */
     recursive_helper(MAX_STACK_DEPTH + 10);

     (void)bpf_get_stackid(ctx, &stackmap, 0);
     return 0;
}

char _license[] SEC("license") = "GPL";

On 01/08/2025 19:16, Lecomte, Arnaud wrote:
> Well, it turns out it is less straightforward than it looked like to 
> detect the memory corruption
>  without KASAN. I am currently in holidays for the next 3 days so I've 
> limited access to a
> computer. I should be able to sort this out on monday.
>
> Thanks,
> Arnaud
>
> On 30/07/2025 08:10, Arnaud Lecomte wrote:
>> On 29/07/2025 23:45, Yonghong Song wrote:
>>>
>>>
>>> On 7/29/25 9:56 AM, Arnaud Lecomte wrote:
>>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>>> __bpf_get_stackid()
>>>> when copying stack trace data. The issue occurs when the perf trace
>>>>   contains more stack entries than the stack map bucket can hold,
>>>>   leading to an out-of-bounds write in the bucket's data array.
>>>> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>>>>   to determine capacity, and for normal mode we use sizeof(u64).
>>>>
>>>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>>>> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>
>>> Could you add a selftest? This way folks can easily find out what is
>>> the problem and why this fix solves the issue correctly.
>>>
>> Sure, will be done after work
>> Thanks,
>> Arnaud
>>>> ---
>>>> Changes in v2:
>>>>   - Use utilty stack_map_data_size to compute map stack map size
>>>> ---
>>>>   kernel/bpf/stackmap.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>> index 3615c06b7dfa..6f225d477f07 100644
>>>> --- a/kernel/bpf/stackmap.c
>>>> +++ b/kernel/bpf/stackmap.c
>>>> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>>>       struct bpf_stack_map *smap = container_of(map, struct 
>>>> bpf_stack_map, map);
>>>>       struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>>>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>>> -    u32 hash, id, trace_nr, trace_len, i;
>>>> +    u32 hash, id, trace_nr, trace_len, i, max_depth;
>>>>       bool user = flags & BPF_F_USER_STACK;
>>>>       u64 *ips;
>>>>       bool hash_matches;
>>>> @@ -241,6 +241,12 @@ static long __bpf_get_stackid(struct bpf_map 
>>>> *map,
>>>>         trace_nr = trace->nr - skip;
>>>>       trace_len = trace_nr * sizeof(u64);
>>>> +
>>>> +    /* Clamp the trace to max allowed depth */
>>>> +    max_depth = smap->map.value_size / stack_map_data_size(map);
>>>> +    if (trace_nr > max_depth)
>>>> +        trace_nr = max_depth;
>>>> +
>>>>       ips = trace->ip + skip;
>>>>       hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>>>>       id = hash & (smap->n_buckets - 1);
>>>
>>>

