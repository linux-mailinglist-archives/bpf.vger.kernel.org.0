Return-Path: <bpf+bounces-66020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F90B2C969
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F62D164D7F
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB84246BB8;
	Tue, 19 Aug 2025 16:21:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084521FDA8E;
	Tue, 19 Aug 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620470; cv=none; b=r1DEf6KFKftzrFbU2QQ4FesiCQS1W0F7E6sDAiDlPAkWrMFjuaXj8n1fAuDrMnWB2G1TJ09cy3CJcb8E3FBGhslL+SLgAwPkombYkWh8U50Ev0ZhQD4q4cYfqtBsTa8+UCKITE9069bKMP63wbzPvFJUZS8GSnyyrnSC61ejpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620470; c=relaxed/simple;
	bh=xFNCSoUoI/QBeEEDdHgL5WulflhR/d72oEr+1fHBGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFcZvIl5Q7CSTBSAjPWnktyvaYyRlavDkCYrpLW6FuPQ24iR2bhlCoAeptxMVJjyFiUHPTlUuNi4xXBTSMfuKjroka0XCX1+G5EAoO9+zAuuCSZq7CxKQC3MbjYfTP4zotDTXBrMswFeWianJ8nC3NcXuYhQ7ePTfc62hgzFQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:a45f:4d28:5bd6:f5e1] (unknown [IPv6:2a02:8084:255b:aa00:a45f:4d28:5bd6:f5e1])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id EEE104099F;
	Tue, 19 Aug 2025 16:20:58 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:a45f:4d28:5bd6:f5e1) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:a45f:4d28:5bd6:f5e1]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <a0d0ed39-3c47-42dc-bdf9-a1961368b166@arnaud-lcm.com>
Date: Tue, 19 Aug 2025 17:20:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: Yonghong Song <yonghong.song@linux.dev>, song@kernel.org, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250813204606.167019-1-contact@arnaud-lcm.com>
 <20250813205506.168069-1-contact@arnaud-lcm.com>
 <07d849b2-67c2-40b2-9cd3-75b8f3a4e0a6@arnaud-lcm.com>
 <ca5b2f4a-f92d-4749-9abe-c2af9254addc@linux.dev>
 <ae450780-f2a9-46fc-8e49-3528ff2e5daa@linux.dev>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: <ae450780-f2a9-46fc-8e49-3528ff2e5daa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175562045987.14819.824542910901246384@Plesk>
X-PPP-Vhost: arnaud-lcm.com

On 18/08/2025 18:02, Yonghong Song wrote:
>
>
> On 8/18/25 9:57 AM, Yonghong Song wrote:
>>
>>
>> On 8/18/25 6:49 AM, Lecomte, Arnaud wrote:
>>> Hey,
>>> Just forwarding the patch to the associated maintainers with 
>>> `stackmap.c`.
>>
>> Arnaud, please add Ack (provided in comments for v3) to make things 
>> easier
>> for maintainers.
>>
>> Also, looks like all your patch sets (v1 to v4) in the same thread.
>
> sorry, it should be v3 and v4 in the same thread.
>
Hey, ty for the feedback !
I am going to provide the link to the v3 in the v4 commit and resent the 
v4 with the Acked-by.

>> It would be good to have all these versions in separate thread.
>> Please look at some examples in bpf mailing list.
>>
>>> Have a great day,
>>> Cheers
>>>
>>> On 13/08/2025 21:55, Arnaud Lecomte wrote:
>>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>>> __bpf_get_stackid()
>>>> when copying stack trace data. The issue occurs when the perf trace
>>>>   contains more stack entries than the stack map bucket can hold,
>>>>   leading to an out-of-bounds write in the bucket's data array.
>>>>
>>>> Changes in v2:
>>>>   - Fixed max_depth names across get stack id
>>>>
>>>> Changes in v4:
>>>>   - Removed unnecessary empty line in __bpf_get_stackid
>>>>
>>>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>> ---
>>>>   kernel/bpf/stackmap.c | 23 +++++++++++++----------
>>>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>>>
>> [...]
>>
>>
>
>

