Return-Path: <bpf+bounces-64920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9AB18741
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39243B1649
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B223AB95;
	Fri,  1 Aug 2025 18:17:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01318DB01;
	Fri,  1 Aug 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072221; cv=none; b=q3yp9IQvPYJQ12v08Oi/KmV8+xT24IpcGl2Kxehhevr8ZyFnQx3xGaImdS5V4QVEBGIylfV7mGxokOTTqCv5ROg4OTI/gBft7kmtm42WpKuAJHrOfHm9tRB/PdgA21nkjlYOQVDSMJhpRNyfMV4xNsWXHo3EqGOuPyiujj21st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072221; c=relaxed/simple;
	bh=GL/E2AB1e06foJAPp+gV5GFNw+zaw1Z1wD2y+Y0eSzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BQ02lOEFpIrRVyw0z6bQIgvUUJdqzxCD9EGqR+rlrmIJswi25dYQJfYiUTBdv9+qgw2DIAHhhLKj8vEVPK+hKaENuLyp09NrnHbKvBYSu4OF/Bo/HQl0tXCYO9r2pz/B8cp3dwWeno39+osCiesuwL8Ir8eOd1nYyTDMtIbOWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.223.11.83] (unknown [82.141.252.181])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id E87D1432F6;
	Fri,  1 Aug 2025 18:16:49 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 82.141.252.181) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.223.11.83]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <6ce83e5c-de34-4ef2-b9f4-2ad15e645969@arnaud-lcm.com>
Date: Fri, 1 Aug 2025 19:16:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
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
Content-Language: en-US
In-Reply-To: <5124b615-3a71-4a44-a497-eea3b5964fda@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175407221104.18149.4380539792465254642@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Well, it turns out it is less straightforward than it looked like to 
detect the memory corruption
  without KASAN. I am currently in holidays for the next 3 days so I've 
limited access to a
computer. I should be able to sort this out on monday.

Thanks,
Arnaud

On 30/07/2025 08:10, Arnaud Lecomte wrote:
> On 29/07/2025 23:45, Yonghong Song wrote:
>>
>>
>> On 7/29/25 9:56 AM, Arnaud Lecomte wrote:
>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>> __bpf_get_stackid()
>>> when copying stack trace data. The issue occurs when the perf trace
>>>   contains more stack entries than the stack map bucket can hold,
>>>   leading to an out-of-bounds write in the bucket's data array.
>>> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>>>   to determine capacity, and for normal mode we use sizeof(u64).
>>>
>>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>>> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>
>> Could you add a selftest? This way folks can easily find out what is
>> the problem and why this fix solves the issue correctly.
>>
> Sure, will be done after work
> Thanks,
> Arnaud
>>> ---
>>> Changes in v2:
>>>   - Use utilty stack_map_data_size to compute map stack map size
>>> ---
>>>   kernel/bpf/stackmap.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index 3615c06b7dfa..6f225d477f07 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>>       struct bpf_stack_map *smap = container_of(map, struct 
>>> bpf_stack_map, map);
>>>       struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>>> -    u32 hash, id, trace_nr, trace_len, i;
>>> +    u32 hash, id, trace_nr, trace_len, i, max_depth;
>>>       bool user = flags & BPF_F_USER_STACK;
>>>       u64 *ips;
>>>       bool hash_matches;
>>> @@ -241,6 +241,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>>         trace_nr = trace->nr - skip;
>>>       trace_len = trace_nr * sizeof(u64);
>>> +
>>> +    /* Clamp the trace to max allowed depth */
>>> +    max_depth = smap->map.value_size / stack_map_data_size(map);
>>> +    if (trace_nr > max_depth)
>>> +        trace_nr = max_depth;
>>> +
>>>       ips = trace->ip + skip;
>>>       hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>>>       id = hash & (smap->n_buckets - 1);
>>
>>

