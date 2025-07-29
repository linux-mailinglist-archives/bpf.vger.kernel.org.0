Return-Path: <bpf+bounces-64639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D043B151B3
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CABC7AF7A5
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0730294A06;
	Tue, 29 Jul 2025 16:54:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3534CF5;
	Tue, 29 Jul 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808095; cv=none; b=BkE1A3aqXthE62b65zsBOF+vJE2oGcb8RwQV7Ki7tP128FJJlqRRDg32CsXMS9T9juF6XdY39wKNhTt330avPv48Ev/Nr8hFNeOw2MJ7J/hKt2HG3Aa9xruVAr4G/AOssWvZIDNm9y+Vg/ZKLaKiCxb5ESpjj8UOUHe3wCyNua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808095; c=relaxed/simple;
	bh=U1cCvd6q1MNbUiSScV1UzAwX6zIHoAjp0LdgULFE0Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9xLGIbsbYqUTpSqVlWqSGxknSxhy3QIlJ1KMLHJ1aHO+J7VE5g6Pp4pRotyQVhL0ds1Sh/t/PNKFCj6TSmTgeCTi+DZULclGGRi4G+4rSIcgqaffpSJ9Q5PMbPon4iczWBXMyQeH44QplVWEaadb5YdW7g+l4Sj3/MZTowjnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:d071:2bab:ab9:4510] (unknown [IPv6:2a02:8084:255b:aa00:d071:2bab:ab9:4510])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id EDD4D40B15;
	Tue, 29 Jul 2025 16:54:49 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:d071:2bab:ab9:4510) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:d071:2bab:ab9:4510]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <f86d659b-29f2-4f78-b2e9-8b667edfaa8e@arnaud-lcm.com>
Date: Tue, 29 Jul 2025 17:54:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Yonghong Song <yonghong.song@linux.dev>, song@kernel.org
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
References: <20250729091901.26436-1-contact@arnaud-lcm.com>
 <004ec202-cbe7-4108-b6ac-1d947a5a54b8@linux.dev>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: <004ec202-cbe7-4108-b6ac-1d947a5a54b8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175380809082.17798.6177797408058807626@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Good catch thanks Yonghong, sending rev2.

On 29/07/2025 17:21, Yonghong Song wrote:
>
>
> On 7/29/25 2:19 AM, Arnaud Lecomte wrote:
>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>> __bpf_get_stackid()
>> when copying stack trace data. The issue occurs when the perf trace
>>   contains more stack entries than the stack map bucket can hold,
>>   leading to an out-of-bounds write in the bucket's data array.
>> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>>   to determine capacity, and for normal mode we use sizeof(u64).
>>
>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   kernel/bpf/stackmap.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 3615c06b7dfa..0f9f6e4b6fe9 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>       struct bpf_stack_map *smap = container_of(map, struct 
>> bpf_stack_map, map);
>>       struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>>       u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>> -    u32 hash, id, trace_nr, trace_len, i;
>> +    u32 hash, id, trace_nr, trace_len, i, max_depth;
>>       bool user = flags & BPF_F_USER_STACK;
>>       u64 *ips;
>>       bool hash_matches;
>> @@ -241,6 +241,16 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>         trace_nr = trace->nr - skip;
>>       trace_len = trace_nr * sizeof(u64);
>> +
>> +    /* Clamp the trace to max allowed depth */
>> +    if (stack_map_use_build_id(map))
>> +        max_depth = smap->map.value_size / sizeof(struct 
>> bpf_stack_build_id);
>> +    else
>> +        max_depth = smap->map.value_size / sizeof(u64);
>
> Replace the above with
>     max_depth = smap->map.value_size / stack_map_data_size(map)
> ?
>
>> +
>> +    if (trace_nr > max_depth)
>> +        trace_nr = max_depth;
>> +
>>       ips = trace->ip + skip;
>>       hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>>       id = hash & (smap->n_buckets - 1);
>
>

