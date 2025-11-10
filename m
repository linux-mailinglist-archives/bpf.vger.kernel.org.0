Return-Path: <bpf+bounces-74051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7BC45A18
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F011890F8B
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DF2FFDC9;
	Mon, 10 Nov 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0obFlvpp"
X-Original-To: bpf@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D312FF157
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766864; cv=none; b=BnI1dht1LgxTQZN3IglPkG6FHoQ5xAhFfXsdv5U3PECeu0ZnoDXSXSQkk/8g9xzd+iJ0uLulkmdaQgeYvYAuJt4Vv41/poY6V0Ia4ez2pDSOAg7pySx77u5EphiaHbjkIme1LFo6S4O+Vq+lx02HFdWJVJCLuEU8UpfTGofUUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766864; c=relaxed/simple;
	bh=Xo7kfg+ZDQZT6iJKQYVgjc2Y3prdJvEfkVbclTnsIQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7szNqbfapsDlFS9riSXU7gK1m4E53jrqiiMaA6gmhP6UJdHoxWiTABRDJio4wQ8gl1pzlklXJoCz+japaVQ4qtphD9Ox6S4voPhLIO35spmUkhtqviMt625hGIP9ettoG4ARPiueVe+1GRXDeuSGo47pHvbVH+xEWpWF2C+6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0obFlvpp; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SeMA90UAoYzSixXIqCuRm5fshxQIuN//PDzpWPTSEN4=;
	b=0obFlvpphDj6QyerDzk5qw8CRSzAnUo2WvBw4GcFtj5y2OwMY+Bbu2M/nbcHfqpjL3IIjDxVw
	ZVERBrS7Lo3SdBKsog/uAI0mjjBRIXgZAxsYGW/ISSHP7RFOVOHw70YzSuMyoXA0nU80wbGGxEX
	/7HbV5l30KZhyRfUXzf/imM=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d4kmf3LvMzLlT9;
	Mon, 10 Nov 2025 17:25:54 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DDA0140155;
	Mon, 10 Nov 2025 17:27:32 +0800 (CST)
Received: from [10.67.108.204] (10.67.108.204) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 17:27:31 +0800
Message-ID: <c934be76-3918-4b84-8e7a-ca1ddd64a0b3@huawei.com>
Date: Mon, 10 Nov 2025 17:27:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>
References: <20251110071714.4069712-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20251110071714.4069712-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)

CI report the following warning, and I've post new version [0]. Sorry 
for the noise.

warning: symbol '__pcpu_scope___dummy_stats' was not declared. Should it 
be static?

Link: 
https://lore.kernel.org/bpf/20251110092536.4082324-1-pulehui@huaweicloud.com/ 
[0]

On 2025/11/10 15:17, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller triggers an invalid memory access issue following fault
> injection in update_effective_progs. The issue can be described as
> follows:
> 
> __cgroup_bpf_detach
>    update_effective_progs
>      compute_effective_progs
>        bpf_prog_array_alloc <-- fault inject
>    purge_effective_progs
>      /* change to dummy_bpf_prog */
>      array->items[index] = &dummy_bpf_prog.prog
> 
> ---softirq start---
> __do_softirq
>    ...
>      __cgroup_bpf_run_filter_skb
>        __bpf_prog_run_save_cb
>          bpf_prog_run
>            stats = this_cpu_ptr(prog->stats)
>            /* invalid memory access */
>            flags = u64_stats_update_begin_irqsave(&stats->syncp)
> ---softirq end---
> 
>    static_branch_dec(&cgroup_bpf_enabled_key[atype])
> 
> The reason is that fault injection caused update_effective_progs to fail
> and then changed the original prog into dummy_bpf_prog.prog in
> purge_effective_progs. Then a softirq came, and accessing the stats of
> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
> 
> To fix it, we can use static per-cpu variables to initialize the stats
> of dummy_bpf_prog.prog.
> 
> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v2:
> - Use static per-cpu variables to initialize the stats of
>    dummy_bpf_prog.prog suggested by Eduard.
> 
> v1: https://lore.kernel.org/all/20251105100302.2968475-1-pulehui@huaweicloud.com
> 
>   kernel/bpf/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d595fe512498..c7c9c78f171a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
>   	return 1;
>   }
>   
> +DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
> +
>   static struct bpf_prog_dummy {
>   	struct bpf_prog prog;
>   } dummy_bpf_prog = {
>   	.prog = {
>   		.bpf_func = __bpf_prog_ret1,
> +		.stats = &__dummy_stats,
>   	},
>   };
>   

