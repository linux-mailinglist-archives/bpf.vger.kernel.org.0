Return-Path: <bpf+bounces-64391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84678B12355
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179B7581FBB
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004848CFC;
	Fri, 25 Jul 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QCrA/RTZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB52EE60F
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466131; cv=none; b=nHKGQ7Nky+i52RzohYj8np4JopObYVZ46XAnJHlWowgGINZLEq0rACktspEMV/4BtjkfBo88FWfJfNad8eoi5u3lrggcBTqhj0jJd6ZRE2as/9oAp4W1Dva1Klm3nQiwzlczgAOY7ZY6FiRfoBEeVIS9rnDpmDAuKohPKbUPYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466131; c=relaxed/simple;
	bh=0oGTJnr1mfinE0+43aOwkz/FeRZpczh/Iy4t70HRg7g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JnzdbIVANEUerUbGqVDo+wrRxLEGk1VeQ2NtEO6yqumBoikRseP4efRtQn5FDBc6hRaRwJ+9CuS9YLUPRWwnsZWKGKLw29Ef2Yji8/CMpwplWaMS3iSr3jaxB9w+6hqXR+1P5tmumIRn6C0QJCiMLg+NbKEcXZ9qkw4zR+nklFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QCrA/RTZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5746ef8-7334-455e-b7c3-ef1563fbc239@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753466118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXCPnYjZAc6JgXUknqRlhTVTB7aGKhhOuisrCVxbhBM=;
	b=QCrA/RTZvaAeRv27DzYMiz1efStkU7YmeHtD2vo+aL0mqYZrojVg4oyQzgFznMyjyE8D3C
	G1MzwdO26bSCDGV7OwBKwyUsXSUqo2fAaWI0EJNbIJcxhstqjDVza5mp0GlPcD9RscveP0
	kCuuxAneE1cBG2WDckFAi8evBthmZX4=
Date: Fri, 25 Jul 2025 10:55:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: fix WARNING in __bpf_prog_ret0_warn
 when jit failed
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Felix Fietkau <nbd@nbd.name>, KaFai Wan <mannkafai@gmail.com>,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250526133358.2594176-1-mannkafai@gmail.com>
 <2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name>
 <bfae2bbc-b440-4d47-8ce7-1d39a33b108e@linux.dev>
In-Reply-To: <bfae2bbc-b440-4d47-8ce7-1d39a33b108e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 10:30 AM, Yonghong Song wrote:
>
> On 7/22/25 6:28 AM, Felix Fietkau wrote:
>> Hi,
>>
>> On 26.05.25 15:33, KaFai Wan wrote:
>>> syzkaller reported an issue:
>>>
>>> WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 
>>> __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
>>> Modules linked in:
>>> CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 
>>> 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
>>> 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>> Workqueue: ipv6_addrconf addrconf_dad_work
>>> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
>>> RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
>>> RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
>>> RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
>>> R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
>>> FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) 
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <TASK>
>>>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>>>   __bpf_prog_run include/linux/filter.h:718 [inline]
>>>   bpf_prog_run include/linux/filter.h:725 [inline]
>>>   cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
>>>   ...
>>>
>>> When creating bpf program, 'fp->jit_requested' depends on 
>>> bpf_jit_enable.
>>> Currently the value of bpf_jit_enable is available from 0 to 2, 0 
>>> means use
>>> interpreter and not jit, 1 and 2 means need to jit. When
>>> CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set
>>> to 1, when it's not set or disabled, we can set bpf_jit_enable via 
>>> proc.
>>>
>>> This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set
>>> and bpf_jit_enable is set to 1, causing the arch to attempt JIT the 
>>> prog,
>>> but jit failed due to FAULT_INJECTION. As a result, incorrectly
>>> treats the program as valid, when the program runs it calls
>>> `__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).
>>>
>>> Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
>>> Closes: 
>>> https://lore.kernel.org/bpf/6816e34e.a70a0220.254cdc.002c.GAE@google.com 
>>>
>>> Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to 
>>> enable jits")
>>> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
>>
>> I think this patch may have caused a regression in configurations 
>> with CONFIG_BPF_JIT_DEFAULT_ON=y when programs can't be JITed. 
>> Attaching the program fails with error -ENOTSUPP.
>
> Could you explain why there is an issue here?
> CONFIG_BPF_JIT_DEFAULT_ON=y but prog cannot be jit'ed. So the end 
> result is to return -ENOTSUPP.
> It looks okay to me since the jit is required but jit failed, the only 
> choice for the kernel
> is to return an error.

BTW, you mentioned programs cannot be jited. Could you explain why programs cannot be jitted?
It would be strange that a program cannot be jitted but can be interpreted.

>
>>
>> Please see https://github.com/openwrt/openwrt/issues/19405 for more 
>> information.
>>
>> - Felix
>
>


