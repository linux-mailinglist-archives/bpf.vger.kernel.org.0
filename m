Return-Path: <bpf+bounces-64389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973FCB12307
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84621898278
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB72EFD93;
	Fri, 25 Jul 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="og+ouuGa"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2F240604
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464644; cv=none; b=rVzoYPyKnyU0hNwlo0Ed+Vvx7lKLcBHqiJBnFhZ2V4CeMbcKw0kO9Vz5ZIv1GRk6cqBxUay3kl/sNnOTFQ3kN6MiY+E4byw2Mi0xYyZOT13CQBOjJSS3q8D2H8akUWLXX+w/ncYFAHrYxr28I7rpt8S3an5QnkQ2UZU7SGiUiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464644; c=relaxed/simple;
	bh=+q1qJLsEHbLvu1F0pgq1Drfko8EUrkvrNLAQmy+383A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EZlFuv1O0xPDFa2660bd+1hKEfzDH5/dIpo1knm8NuAZObno5Qxovw3R7XKqcna+ozPSt12gbqX8DPdKpbOI9yCx8w07Bo/Gc+tQnFNtWNV9vEhbzBnfEwRLlT3sTjHoqczTRYJYqTcc+Aes5yCIyTfjRm1UTwxzju/9Tuw50Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=og+ouuGa; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfae2bbc-b440-4d47-8ce7-1d39a33b108e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753464629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pDROfUQq42wBzo1Q0k5++y7V8eH2Gqhj7GH+jwyDrY=;
	b=og+ouuGaUitinxolY4bcJ4qTaP7TMDOWc0bIepbsTCR/6Ql1JpK0GML8Px8onBGf/pfmZ7
	J89pxXxDVUqwgVb6yatuABcQG+/E5SXwzu0UdMY8yFsRDFjVfj5GoIqrSQJfoVlEi6bC5u
	94KR81NjkTl2x7leeuy5Bq2163RPRQg=
Date: Fri, 25 Jul 2025 10:30:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: fix WARNING in __bpf_prog_ret0_warn
 when jit failed
Content-Language: en-GB
To: Felix Fietkau <nbd@nbd.name>, KaFai Wan <mannkafai@gmail.com>,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250526133358.2594176-1-mannkafai@gmail.com>
 <2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/22/25 6:28 AM, Felix Fietkau wrote:
> Hi,
>
> On 26.05.25 15:33, KaFai Wan wrote:
>> syzkaller reported an issue:
>>
>> WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 
>> __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
>> Modules linked in:
>> CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 
>> 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
>> 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> Workqueue: ipv6_addrconf addrconf_dad_work
>> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
>> RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
>> RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
>> RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
>> R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
>> FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>>   __bpf_prog_run include/linux/filter.h:718 [inline]
>>   bpf_prog_run include/linux/filter.h:725 [inline]
>>   cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
>>   ...
>>
>> When creating bpf program, 'fp->jit_requested' depends on 
>> bpf_jit_enable.
>> Currently the value of bpf_jit_enable is available from 0 to 2, 0 
>> means use
>> interpreter and not jit, 1 and 2 means need to jit. When
>> CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set
>> to 1, when it's not set or disabled, we can set bpf_jit_enable via proc.
>>
>> This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set
>> and bpf_jit_enable is set to 1, causing the arch to attempt JIT the 
>> prog,
>> but jit failed due to FAULT_INJECTION. As a result, incorrectly
>> treats the program as valid, when the program runs it calls
>> `__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).
>>
>> Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
>> Closes: 
>> https://lore.kernel.org/bpf/6816e34e.a70a0220.254cdc.002c.GAE@google.com
>> Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to 
>> enable jits")
>> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
>
> I think this patch may have caused a regression in configurations with 
> CONFIG_BPF_JIT_DEFAULT_ON=y when programs can't be JITed. Attaching 
> the program fails with error -ENOTSUPP.

Could you explain why there is an issue here?
CONFIG_BPF_JIT_DEFAULT_ON=y but prog cannot be jit'ed. So the end result is to return -ENOTSUPP.
It looks okay to me since the jit is required but jit failed, the only choice for the kernel
is to return an error.

>
> Please see https://github.com/openwrt/openwrt/issues/19405 for more 
> information.
>
> - Felix


