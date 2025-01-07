Return-Path: <bpf+bounces-48121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FFA0427C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136D31660A0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F11F1927;
	Tue,  7 Jan 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYL4fPuU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814861EF092;
	Tue,  7 Jan 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260003; cv=none; b=q2wmKplhZYSgb0eY+8t8qsOOiLvgXvowBF18wBtZYlWTwqxo0XGoh05u9FVa92XnVS2Yo69thatFiGObdTNuv2FhY07cNN7tosiYnwP1gbck58OnaApyROhfmCbJul/B+TIvOi2NTRxM0MNfmKanG5vlaDEtkOqK5YZk5fBHsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260003; c=relaxed/simple;
	bh=AeMg2utTMAlKSbxWiRzE7yu6vRG6PdpdikVVUTzB7Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDmcOvb7vW3o09BCZLWUhnyae4oaZ6PBQRrZfIlt93qRTltvWdJ0YxKJUWSp6xgB33KAEk6cQILKUfS0jWKkPt8lWkBUVTBeFsP7Oq4mXVCowP4uduS96eCaT9PfuhZBJCEnv+b0k+GVhr2/+CWPpQDLhyPbFB3TewsCR/WwjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYL4fPuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1940CC4CED6;
	Tue,  7 Jan 2025 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736260003;
	bh=AeMg2utTMAlKSbxWiRzE7yu6vRG6PdpdikVVUTzB7Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYL4fPuUt3YBqyPuBz92sS5jcy/VsnOz6MkBc+Fbk9qHBM2JFQcpjLIB5VduAzKzX
	 Wog6S9U2SOSYofWSlq8OUKbOvKA9Z46TrCntIHu428GAwuyK4bZH0fQxNMzp33Bcn1
	 WShlsGyIlFWAAqmI6IbMsU3k2+GM7FPDtsN6WV8C3t0InsWrCNNYfQJr5a3LItROi3
	 WpEwlP8/8JmYS1fDCgkRu7PCzNfBZ2Koe6q8/FFo1HKARb14CWN6XkXP9zLY6Gdc06
	 lG290+aDphxV1KOFeQxY4EHEag88h0oxdHfkn7a1G0uVf3RHzYAXFyeCJVndgHuCHp
	 q6ystbxVShpDw==
Message-ID: <f977c0ab-76f5-4869-9fb7-e111104e2fff@kernel.org>
Date: Tue, 7 Jan 2025 15:26:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/8] fix two bugs related to page_pool
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250106130116.457938-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250106130116.457938-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/01/2025 14.01, Yunsheng Lin wrote:
> This patchset fix a possible time window problem for page_pool and
> the dma API misuse problem as mentioned in [1], and try to avoid the
> overhead of the fixing using some optimization.
> 
>  From the below performance data, the overhead is not so obvious
> due to performance variations for time_bench_page_pool01_fast_path()
> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
> for time_bench_page_pool03_slow() for fixing the bug.
> 
> Before this patchset:
> root@(none)$ insmod bench_page_pool_simple.ko
> [  323.367627] bench_page_pool_simple: Loaded
> [  323.448747] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076997150 sec time_interval:76997150) - (invoke count:100000000 tsc_interval:7699707)
> [  324.812884] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.468 ns (step:0) - (measurement period time:1.346855130 sec time_interval:1346855130) - (invoke count:100000000 tsc_interval:134685507)
> [  324.980875] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.010 ns (step:0) - (measurement period time:0.150101270 sec time_interval:150101270) - (invoke count:10000000 tsc_interval:15010120)
> [  325.652195] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.542 ns (step:0) - (measurement period time:0.654213000 sec time_interval:654213000) - (invoke count:100000000 tsc_interval:65421294)
> [  325.669215] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> [  325.974848] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 29.633 ns (step:0) - (measurement period time:0.296338200 sec time_interval:296338200) - (invoke count:10000000 tsc_interval:29633814)

(referring to above line, below)

> [  325.993517] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> [  326.576636] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.391 ns (step:0) - (measurement period time:0.573911820 sec time_interval:573911820) - (invoke count:10000000 tsc_interval:57391174)
> [  326.595307] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> [  328.422661] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 181.849 ns (step:0) - (measurement period time:1.818495880 sec time_interval:1818495880) - (invoke count:10000000 tsc_interval:181849581)
> [  328.441681] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> [  328.449584] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> [  328.755031] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 29.632 ns (step:0) - (measurement period time:0.296327910 sec time_interval:296327910) - (invoke count:10000000 tsc_interval:29632785)

It is strange that fast-path "tasklet_page_pool01_fast_path" isn't
faster than above "no-softirq-page_pool01".
They are both 29.633 ns.

What hardware is this?

e.g. the cycle count of 2 cycles(tsc) seem strange.

On my testlab hardware Intel CPU E5-1650 v4 @3.60GHz
My fast-path numbers say 5.202 ns (18 cycles) for 
"tasklet_page_pool01_fast_path"


Raw data look like this

[Tue Jan  7 15:15:18 2025] bench_page_pool_simple: pp_tasklet_handler(): 
in_serving_softirq fast-path
[Tue Jan  7 15:15:18 2025] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[Tue Jan  7 15:15:18 2025] time_bench: 
Type:tasklet_page_pool01_fast_path Per elem: 18 cycles(tsc) 5.202 ns 
(step:0) - (measurement period time:0.052020430 sec 
time_interval:52020430) - (invoke count:10000000 tsc_interval:187272981)
[Tue Jan  7 15:15:18 2025] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[Tue Jan  7 15:15:19 2025] time_bench: Type:tasklet_page_pool02_ptr_ring 
Per elem: 55 cycles(tsc) 15.343 ns (step:0) - (measurement period 
time:0.153438301 sec time_interval:153438301) - (invoke count:10000000 
tsc_interval:552378168)
[Tue Jan  7 15:15:19 2025] bench_page_pool_simple: 
time_bench_page_pool03_slow(): in_serving_softirq fast-path
[Tue Jan  7 15:15:19 2025] time_bench: Type:tasklet_page_pool03_slow Per 
elem: 243 cycles(tsc) 67.725 ns (step:0) - (measurement period 
time:0.677255574 sec time_interval:677255574) - (invoke count:10000000 
tsc_interval:2438124315)


> [  328.774308] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> [  329.578579] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 7 cycles(tsc) 79.523 ns (step:0) - (measurement period time:0.795236560 sec time_interval:795236560) - (invoke count:10000000 tsc_interval:79523650)
> [  329.597769] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> [  331.507501] time_bench: Type:tasklet_page_pool03_slow Per elem: 19 cycles(tsc) 190.104 ns (step:0) - (measurement period time:1.901047510 sec time_interval:1901047510) - (invoke count:10000000 tsc_interval:190104743)
> 
> After this patchset:
> root@(none)$ insmod bench_page_pool_simple.ko
> [  138.634758] bench_page_pool_simple: Loaded
> [  138.715879] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076972720 sec time_interval:76972720) - (invoke count:100000000 tsc_interval:7697265)
> [  140.079897] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.467 ns (step:0) - (measurement period time:1.346735370 sec time_interval:1346735370) - (invoke count:100000000 tsc_interval:134673531)
> [  140.247841] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150055080 sec time_interval:150055080) - (invoke count:10000000 tsc_interval:15005497)
> [  140.919072] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654125000 sec time_interval:654125000) - (invoke count:100000000 tsc_interval:65412493)
> [  140.936091] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> [  141.246985] time_bench: Type:no-softirq-page_pool01 Per elem: 3 cycles(tsc) 30.159 ns (step:0) - (measurement period time:0.301598160 sec time_interval:301598160) - (invoke count:10000000 tsc_interval:30159812)
> [  141.265654] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> [  141.976265] time_bench: Type:no-softirq-page_pool02 Per elem: 7 cycles(tsc) 70.140 ns (step:0) - (measurement period time:0.701405780 sec time_interval:701405780) - (invoke count:10000000 tsc_interval:70140573)
> [  141.994933] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> [  144.018945] time_bench: Type:no-softirq-page_pool03 Per elem: 20 cycles(tsc) 201.514 ns (step:0) - (measurement period time:2.015141210 sec time_interval:2015141210) - (invoke count:10000000 tsc_interval:201514113)
> [  144.037966] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> [  144.045870] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> [  144.205045] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150056510 sec time_interval:150056510) - (invoke count:10000000 tsc_interval:15005645)

This 15.005 ns looks like a significant improvement over 29.633 ns

> [  144.224320] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> [  144.916044] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 6 cycles(tsc) 68.269 ns (step:0) - (measurement period time:0.682693070 sec time_interval:682693070) - (invoke count:10000000 tsc_interval:68269300)
> [  144.935234] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> [  146.997684] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 205.376 ns (step:0) - (measurement period time:2.053766310 sec time_interval:2053766310) - (invoke count:10000000 tsc_interval:205376624)
> 


Looks like I should also try out this patchset on my testlab, as this
hardware seems significantly different than mine...


> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: IOMMU <iommu@lists.linux.dev>
> CC: MM <linux-mm@kvack.org>
> 
> Change log:
> V6:
>    1. Repost based on latest net-next.
>    2. Rename page_pool_to_pp() to page_pool_get_pp().
> 
> V5:
>    1. Support unlimit inflight pages.
>    2. Add some optimization to avoid the overhead of fixing bug.
> 
> V4:
>    1. use scanning to do the unmapping
>    2. spilt dma sync skipping into separate patch
> 
> V3:
>    1. Target net-next tree instead of net tree.
>    2. Narrow the rcu lock as the discussion in v2.
>    3. Check the ummapping cnt against the inflight cnt.
> 
> V2:
>    1. Add a item_full stat.
>    2. Use container_of() for page_pool_to_pp().
> 
> Yunsheng Lin (8):
>    page_pool: introduce page_pool_get_pp() API
>    page_pool: fix timing for checking and disabling napi_local
>    page_pool: fix IOMMU crash when driver has already unbound
>    page_pool: support unlimited number of inflight pages
>    page_pool: skip dma sync operation for inflight pages
>    page_pool: use list instead of ptr_ring for ring cache
>    page_pool: batch refilling pages to reduce atomic operation
>    page_pool: use list instead of array for alloc cache
> 
>   drivers/net/ethernet/freescale/fec_main.c     |   8 +-
>   .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   6 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  14 +-
>   drivers/net/ethernet/intel/libeth/rx.c        |   2 +-
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
>   drivers/net/netdevsim/netdev.c                |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +-
>   include/linux/mm_types.h                      |   2 +-
>   include/linux/skbuff.h                        |   1 +
>   include/net/libeth/rx.h                       |   3 +-
>   include/net/netmem.h                          |  24 +-
>   include/net/page_pool/helpers.h               |  11 +
>   include/net/page_pool/types.h                 |  63 +-
>   net/core/devmem.c                             |   4 +-
>   net/core/netmem_priv.h                        |   5 +-
>   net/core/page_pool.c                          | 660 ++++++++++++++----
>   net/core/page_pool_priv.h                     |  12 +-
>   18 files changed, 664 insertions(+), 164 deletions(-)
> 

