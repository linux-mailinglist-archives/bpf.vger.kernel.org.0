Return-Path: <bpf+bounces-78154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66776CFFC30
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37553340E8F5
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089EA2FD7A3;
	Wed,  7 Jan 2026 18:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2533D6C5;
	Wed,  7 Jan 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810940; cv=none; b=AMjR+DhZZnlKWc46WZv6Ps4QsZQ9q+uX/PMV5M//rFKBgGrFfL0TsDEy2wb4bHFBT+TnRu+DggbSEIWNANffi5eUbK2igyE3DAbyYl+W/3+8lYl9FXe1RFVgtFKVo1enax6fvB00eCyJB79HrPAjMJfWpz4uQirl/Hx1XBy+pVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810940; c=relaxed/simple;
	bh=ogZ+V3HKXlwFdn5r8YA9VePLPxwkn6TOEOi+OAEjPdM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ndNbDf9x1elZtdnkt4HJOVtS/q3IZE/CLInkPeKR/44Y0xaLkth1i5FtwRAsAT05mchgHoIUHwSxED83rnP1rofpF72Pt72b1qloxYw7NoRUR0gdwNQTghd8tOw2fSVggWK602TdPfOu/rBY6uzn4zmSv4P0NCrlPCQ0ydOUKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6] (2a01cb0403021e00dc6d2db6511fadd6.ipv6.abo.wanadoo.fr [IPv6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B19A6405DD;
	Wed,  7 Jan 2026 18:35:34 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:cb04:302:1e00:dc6d:2db6:511f:add6) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <962121a5-e69a-4c66-b447-6681da0827aa@arnaud-lcm.com>
Date: Wed, 7 Jan 2026 19:35:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
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
Content-Language: en-US
In-Reply-To: <3c22314c-a677-4e59-be51-a807d26e7d33@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176781093527.14344.16977425900143617962@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 07/01/2026 19:08, Lecomte, Arnaud wrote:
>
> On 06/01/2026 01:51, Andrii Nakryiko wrote:
>> On Sun, Jan 4, 2026 at 12:52 PM Arnaud Lecomte 
>> <contact@arnaud-lcm.com> wrote:
>>> Syzkaller reported a KASAN slab-out-of-bounds write in 
>>> __bpf_get_stack()
>>> during stack trace copying.
>>>
>>> The issue occurs when: the callchain entry (stored as a per-cpu 
>>> variable)
>>> grow between collection and buffer copy, causing it to exceed the 
>>> initially
>>> calculated buffer size based on max_depth.
>>>
>>> The callchain collection intentionally avoids locking for performance
>>> reasons, but this creates a window where concurrent modifications can
>>> occur during the copy operation.
>>>
>>> To prevent this from happening, we clamp the trace len to the max
>>> depth initially calculated with the buffer size and the size of
>>> a trace.
>>>
>>> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
>>> Closes: 
>>> https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
>>> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth 
>>> calculation into helper function")
>>> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
>>> Cc: Brahmajit Das <listout@listout.xyz>
>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>> ---
>>> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
>>> with the correct justification and a better implementation in my
>>> opinion.
>>> ---
>>>   kernel/bpf/stackmap.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index da3d328f5c15..e56752a9a891 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs 
>>> *regs, struct task_struct *task,
>>>
>>>          if (trace_in) {
>>>                  trace = trace_in;
>>> -               trace->nr = min_t(u32, trace->nr, max_depth);
>>>          } else if (kernel && task) {
>>>                  trace = get_callchain_entry_for_task(task, max_depth);
>>>          } else {
>>> @@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs 
>>> *regs, struct task_struct *task,
>>>                  goto err_fault;
>>>          }
>>>
>>> -       trace_nr = trace->nr - skip;
>>> +       trace_nr = min(trace->nr, max_depth);
>> there is `trace->nr < skip` check right above, should it be moved here
>> and done against adjusted trace_nr (but before we subtract skip, of
>> course)?
> We could indeed be more proactive on the clamping even-though I would
>  say it does not fundamentally change anything in my opinion.
> Happy to raise a new rev.
Nvm, this is not really possible as we are checking that the trace is 
not NULL.
Moving it above could lead to a NULL dereference.
>>> +       trace_nr = trace_nr - skip;
>>>          copy_len = trace_nr * elem_size;
>>>
>>>          ips = trace->ip + skip;
>>> -- 
>>> 2.43.0
>>>
> Thanks for the review !
> Arnaud

