Return-Path: <bpf+bounces-78756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F6D1B541
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E614300D825
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5A322B94;
	Tue, 13 Jan 2026 21:01:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECC19644B;
	Tue, 13 Jan 2026 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338103; cv=none; b=AFdPEddDcAIX8PeJVRVp2gcyNhj9OupgvcBd/JemS1boY0bSoC2oCqz6oD4BGteksRN9b9mJDOXopetEq9UXBz/RPteInDym4p8uyyL+U1svmXO3iihN2SkBCu13LHHAL8TxqmItLEMS5Z57DV4ydmZClo5v1Ow3ZrdX/vId/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338103; c=relaxed/simple;
	bh=51Z8IvVJeA8MbP+NxHMavihnLSuqqsR+e5pSkyhEgOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsDO+zF4sgmdjLBVnk6rO6VhJ0NRQfhx1qcRHE3FfVJrbtGPNISmNM+42P/MaQP8NFZfn81fBI0qcYxRCQxSUI2IcHL+osfMpifx15q+pmi+QkhI6TkYdyyYSlC8HTKquagZMKbaROyzDmVJp6cBsSQ17DF1vTlLy6GyeJ5QBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.5.62.34] (unknown [89.100.17.9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 6F90D401A0;
	Tue, 13 Jan 2026 21:01:32 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 89.100.17.9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.5.62.34]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <e2fff10c-1a58-4e68-b9ca-2d27e0eb165b@arnaud-lcm.com>
Date: Tue, 13 Jan 2026 21:01:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 Brahmajit Das <listout@listout.xyz>
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
 <CAEf4BzYakog+DLSfA6aiHCPW0QHR-=TC8pVi+jDVo27Ljk5uuA@mail.gmail.com>
 <3c22314c-a677-4e59-be51-a807d26e7d33@arnaud-lcm.com>
 <962121a5-e69a-4c66-b447-6681da0827aa@arnaud-lcm.com>
 <CAEf4Bza=OwYhe_tSx0FHB8Bjzq9f2j9nWhmdQAraFAKJqGyj2A@mail.gmail.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAEf4Bza=OwYhe_tSx0FHB8Bjzq9f2j9nWhmdQAraFAKJqGyj2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176833809333.19451.17124036763493028100@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 09/01/2026 19:05, Andrii Nakryiko wrote:
> On Wed, Jan 7, 2026 at 10:35 AM Lecomte, Arnaud <contact@arnaud-lcm.com> wrote:
>>
>> On 07/01/2026 19:08, Lecomte, Arnaud wrote:
>>> On 06/01/2026 01:51, Andrii Nakryiko wrote:
>>>> On Sun, Jan 4, 2026 at 12:52 PM Arnaud Lecomte
>>>> <contact@arnaud-lcm.com> wrote:
>>>>> Syzkaller reported a KASAN slab-out-of-bounds write in
>>>>> __bpf_get_stack()
>>>>> during stack trace copying.
>>>>>
>>>>> The issue occurs when: the callchain entry (stored as a per-cpu
>>>>> variable)
>>>>> grow between collection and buffer copy, causing it to exceed the
>>>>> initially
>>>>> calculated buffer size based on max_depth.
>>>>>
>>>>> The callchain collection intentionally avoids locking for performance
>>>>> reasons, but this creates a window where concurrent modifications can
>>>>> occur during the copy operation.
>>>>>
>>>>> To prevent this from happening, we clamp the trace len to the max
>>>>> depth initially calculated with the buffer size and the size of
>>>>> a trace.
>>>>>
>>>>> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
>>>>> Closes:
>>>>> https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
>>>>> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth
>>>>> calculation into helper function")
>>>>> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
>>>>> Cc: Brahmajit Das <listout@listout.xyz>
>>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>>> ---
>>>>> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
>>>>> with the correct justification and a better implementation in my
>>>>> opinion.
>>>>> ---
>>>>>    kernel/bpf/stackmap.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>>> index da3d328f5c15..e56752a9a891 100644
>>>>> --- a/kernel/bpf/stackmap.c
>>>>> +++ b/kernel/bpf/stackmap.c
>>>>> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs
>>>>> *regs, struct task_struct *task,
>>>>>
>>>>>           if (trace_in) {
>>>>>                   trace = trace_in;
>>>>> -               trace->nr = min_t(u32, trace->nr, max_depth);
>>>>>           } else if (kernel && task) {
>>>>>                   trace = get_callchain_entry_for_task(task, max_depth);
>>>>>           } else {
>>>>> @@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs
>>>>> *regs, struct task_struct *task,
>>>>>                   goto err_fault;
>>>>>           }
>>>>>
>>>>> -       trace_nr = trace->nr - skip;
>>>>> +       trace_nr = min(trace->nr, max_depth);
>>>> there is `trace->nr < skip` check right above, should it be moved here
>>>> and done against adjusted trace_nr (but before we subtract skip, of
>>>> course)?
>>> We could indeed be more proactive on the clamping even-though I would
>>>   say it does not fundamentally change anything in my opinion.
>>> Happy to raise a new rev.
>> Nvm, this is not really possible as we are checking that the trace is
>> not NULL.
>> Moving it above could lead to a NULL dereference.
> ok, so what are we doing then?
>
> if (unlikely(!trace)) { ... }
>
> trace_nr = min(trace->nr, max_depth);
>
> if (trace->nr < skip) { ... }
>
> trace_nr = trace->nr - skip;
>
>
> (which is what I proposed, or am I still missing why this shouldn't be
> done like that?)

I think it doesn't really bring any value to adopt this split check.
The underlying problem is the lack of locking mechanism on
the trace structure. I will try to find a workaround minimizing
it's performance impact. I think this is an interesting problem
actually. Will get back to you soon !

> pw-bot: cr
>
>
>
>>>>> +       trace_nr = trace_nr - skip;
>>>>>           copy_len = trace_nr * elem_size;
>>>>>
>>>>>           ips = trace->ip + skip;
>>>>> --
>>>>> 2.43.0
>>>>>
>>> Thanks for the review !
>>> Arnaud

Thanks, Arnaud


