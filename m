Return-Path: <bpf+bounces-74046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CACC4531A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 08:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 534F04E6225
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E1289E06;
	Mon, 10 Nov 2025 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fBjMY4mU"
X-Original-To: bpf@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C1223DEC
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759289; cv=none; b=nr9WQsZaMcxBp1pckVyTm6j/up9kuPpC22o4HX/X0sOM8zdF8MCbAlJdEurM4LOJgi1XBRBxCJPnZbgFYhT1isuNelZRHFX622Oshl6ZUvH9Ell3prWrlsIe80/NWPmq/TSRSFAIkHGVrxM6oSJpkSM3dWk80cM3unBDkGfX1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759289; c=relaxed/simple;
	bh=5qzz5qo8JA/D3ERsbfzqEICxp6Kb5gUIz/2QLAg7Cq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s9ZXZIF1hioqvxt64S6SPw7P/OzNgoS0wZyba5kAR1LFE3P4wbHvVLG2/D/Q9EI8KtKG2f3y/E/TblO0qTtTx6aNrW56/VabeyO+6CDQxHDzoQgPttF26wEpISFgo03Sf1YVJGO24DVmq3fhjujJcNC+5LuZXpMYfx56O7XPWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fBjMY4mU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m1vxOYltxyeORZW9wklQ/sRP0XgIwO+tJDXRbZUWkkQ=;
	b=fBjMY4mU/JFQOxgjSh41eaqQK97zHgbGg/r5CJt+yYJXeKu5NqI1yk1tqK9XxNsgdSEDn5vRH
	lbtmc601OkL71JNexvsvolikm8EFLAijDoUbthEQ/hjBBNBTQcx0ixZucsJHD5FxILO93sDvdWk
	D4YZTugtEaco9agxFEwF6LQ=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d4gyz3F0Dz1prLJ;
	Mon, 10 Nov 2025 15:19:39 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 487C3180495;
	Mon, 10 Nov 2025 15:21:18 +0800 (CST)
Received: from [10.67.108.204] (10.67.108.204) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 15:21:17 +0800
Message-ID: <7a0110ae-c462-48e2-bc95-aa777d512a5e@huawei.com>
Date: Mon, 10 Nov 2025 15:21:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Pu Lehui <pulehui@huaweicloud.com>,
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>
References: <20251105100302.2968475-1-pulehui@huaweicloud.com>
 <a0acd787192bef94c7da88c40c4693bc67876b32.camel@gmail.com>
 <6a8bb167-17af-471d-aaaa-9219a7c41583@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <6a8bb167-17af-471d-aaaa-9219a7c41583@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/11/6 10:14, Pu Lehui wrote:
> 
> 
> On 2025/11/6 7:33, Eduard Zingerman wrote:
>> On Wed, 2025-11-05 at 10:03 +0000, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Syzkaller triggers an invalid memory access issue following fault
>>> injection in update_effective_progs. The issue can be described as
>>> follows:
>>>
>>> __cgroup_bpf_detach
>>>    update_effective_progs
>>>      compute_effective_progs
>>>        bpf_prog_array_alloc <-- fault inject
>>>    purge_effective_progs
>>>      /* change to dummy_bpf_prog */
>>>      array->items[index] = &dummy_bpf_prog.prog
>>>
>>> ---softirq start---
>>> __do_softirq
>>>    ...
>>>      __cgroup_bpf_run_filter_skb
>>>        __bpf_prog_run_save_cb
>>>          bpf_prog_run
>>>            stats = this_cpu_ptr(prog->stats)
>>>            /* invalid memory access */
>>>            flags = u64_stats_update_begin_irqsave(&stats->syncp)
>>> ---softirq end---
>>>
>>>    static_branch_dec(&cgroup_bpf_enabled_key[atype])
>>>
>>> The reason is that fault injection caused update_effective_progs to fail
>>> and then changed the original prog into dummy_bpf_prog.prog in
>>> purge_effective_progs. Then a softirq came, and accessing the members of
>>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>>>
>>> To fix it, we can skip executing the prog when it's dummy_bpf_prog.prog.
>>>
>>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in 
>>> compute_effective_progs")
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>
>> Is there a link for syzkaller report?
> 
> 
> Hi Eduard,
> 
> This is a local syzkaller test, and I have attached the report at the 
> end of the email.
> 
>>
>> [...]
>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 248f517d66d0..baad33b34cef 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -77,7 +77,9 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>>>       item = &array->items[0];
>>>       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>>       while ((prog = READ_ONCE(item->prog))) {
>>> -        run_ctx.prog_item = item;
>>> +        run_ctx.prog_item = item++;
>>> +        if (prog == &dummy_bpf_prog.prog)
>>> +            continue;
>>
>> Will the following fix the issue?
>>
>>      diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>      index d595fe512498..c7c9c78f171a 100644
>>      --- a/kernel/bpf/core.c
>>      +++ b/kernel/bpf/core.c
>>      @@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const 
>> void *ctx,
>>              return 1;
>>       }
>>
>>      +DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
>>      +
>>       static struct bpf_prog_dummy {
>>              struct bpf_prog prog;
>>       } dummy_bpf_prog = {
>>              .prog = {
>>                      .bpf_func = __bpf_prog_ret1,
>>      +               .stats = &__dummy_stats,
>>              },
>>       };
>>
>> Or that's too much memory wasted?
> 
> In 160 cores system, it will waste 5K bytes for this dummy.
> 
> And also, this solution will not suit for 5.10.0 or lower LTS version, 
> as the bpf_prog_stats is embedded in struct bpf_prog_aux, and bpf->aux 
> is empty at this time, which will trigger a null pointer access.

Hi Eduard,

I've reviewed the kernel usage of static per-CPU variables and believe 
that 32 bytes per core is not a significant overhead. Moreover, similar 
approaches can be applied to older versions. I've submitted the v2 based 
on your suggestions.

https://lore.kernel.org/bpf/20251110071714.4069712-1-pulehui@huaweicloud.com/

Thanks.

