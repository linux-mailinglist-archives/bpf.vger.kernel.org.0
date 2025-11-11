Return-Path: <bpf+bounces-74131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B776C4B4C1
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F34E2A23
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DF314B77;
	Tue, 11 Nov 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="G0Ej6azi"
X-Original-To: bpf@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42961218AB0
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831229; cv=none; b=DsCg+EtQI7CwrcWUDDRb/eMHzM5jrrqJF4kY/J8HomTLh5kIDjsa0iF2KhyEwx9rD57TmXnMYdvrVXNGutM0wyw7+RdK4lhXqZhXFVWgWbgR29POuD+X5AWUiN7E7AKIGzn9eR0VhVduK58a0BbFjKyXwxoMI09ltVFBpqCuueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831229; c=relaxed/simple;
	bh=JL0UEG7weza/PUKEaMAZt2tb5ngFNwIC5J0u9jJfFaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XwN8TGXxWLv8KfqWoe09MTAkg0/Di4m65Qi0+nw7VGv0LJ/tMpKBIXk1isF2l4PKnefyP8TAX2cGTcWhyg0wlpXQFikDCTYieBiiRvyxNXKGup3qDKaftL4iluHsjWU1seQPYxWsO9LaSpbPtdQizSXE2FrgBPk8kBm3g5LhJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=G0Ej6azi; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cGub8Shr/nyUIh2+TlhgxwD5cLmG8czFxwLQv+jD1m4=;
	b=G0Ej6azi3EFqFD9TBORIFwWS/anwrwAM92vPhDSFV3t8dOGtn4C1J1ti/azVZmxMx7+dx+Ht5
	QFAmXmHL75lQqCXJTMlBaP5qkEex7EFRdDzaYRnNdjyoS8om671yVZLkG5d/CNpfwjmKPLDmhy9
	aMYv+X9EG54M3/PltfWaUFM=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d5BZN2D3czpSty;
	Tue, 11 Nov 2025 11:18:36 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id F3D031401F0;
	Tue, 11 Nov 2025 11:20:16 +0800 (CST)
Received: from [10.67.108.204] (10.67.108.204) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 11:20:16 +0800
Message-ID: <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
Date: Tue, 11 Nov 2025 11:20:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman
	<eddyz87@gmail.com>
CC: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2025/11/11 9:13, Alexei Starovoitov wrote:
> On Mon, Nov 10, 2025 at 12:36 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Syzkaller triggers an invalid memory access issue following fault
>>> injection in update_effective_progs. The issue can be described as
>>> follows:
>>>
>>> __cgroup_bpf_detach
>>>    update_effective_progs
>>>      compute_effective_progs
>>>        bpf_prog_array_alloc <-- fault inject
>>>    purge_effective_progs
>>>      /* change to dummy_bpf_prog */
>>>      array->items[index] = &dummy_bpf_prog.prog
>>>
>>> ---softirq start---
>>> __do_softirq
>>>    ...
>>>      __cgroup_bpf_run_filter_skb
>>>        __bpf_prog_run_save_cb
>>>          bpf_prog_run
>>>            stats = this_cpu_ptr(prog->stats)
>>>            /* invalid memory access */
>>>            flags = u64_stats_update_begin_irqsave(&stats->syncp)
>>> ---softirq end---
>>>
>>>    static_branch_dec(&cgroup_bpf_enabled_key[atype])
>>>
>>> The reason is that fault injection caused update_effective_progs to fail
>>> and then changed the original prog into dummy_bpf_prog.prog in
>>> purge_effective_progs. Then a softirq came, and accessing the stats of
>>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>>>
>>> To fix it, we can use static per-cpu variable to initialize the stats
>>> of dummy_bpf_prog.prog.
>>>
>>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>
>> Hi Pu,
>>
>> Sorry for the delayed response. This patch looks good to me, but I
>> think that your argument about memory consumption makes total sense.
>> It might be the case that v1 is a better fix. Let's hear from Alexei.
> 

Hi Alexei,

> I don't particularly like either v1 or v2.
> Runtime penalty to bpf_prog_run_array_cg() is not nice.
> Memory waste with __dummy_stats is not good as well.

Indeed a trade-off between time and space before better solution.

> 
> Also v1 doesn't really fix it, since prog_array is
> used not only by cgroup.
> perf_event_detach_bpf_prog() does bpf_prog_array_delete_safe() too.

I noticed that too, but before syncing to other parts of the 
bpf_prog_array, I found there were some shotgun-style modifications, so 
I switched to initializing per-cpu variables to minimize changes.

> 
> Another option is to add a runtime check to __bpf_prog_run()
> but it isn't great either.

Yep, same runtime penalty, but simpler than v1 – will we use this to patch?

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -712,11 +712,13 @@ static __always_inline u32 __bpf_prog_run(const 
struct bpf_prog *prog,
                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);

                 duration = sched_clock() - start;
-               stats = this_cpu_ptr(prog->stats);
-               flags = u64_stats_update_begin_irqsave(&stats->syncp);
-               u64_stats_inc(&stats->cnt);
-               u64_stats_add(&stats->nsecs, duration);
-               u64_stats_update_end_irqrestore(&stats->syncp, flags);
+               if (likely(prog->stats)) {
+                       stats = this_cpu_ptr(prog->stats);
+                       flags = 
u64_stats_update_begin_irqsave(&stats->syncp);
+                       u64_stats_inc(&stats->cnt);
+                       u64_stats_add(&stats->nsecs, duration);
+                       u64_stats_update_end_irqrestore(&stats->syncp, 
flags);
+               }
         } else {
                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
         }

> 
> pw-bot: cr

