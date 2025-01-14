Return-Path: <bpf+bounces-48782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584FA10968
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7709F1887AE6
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9B154BFC;
	Tue, 14 Jan 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEtX7U3/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F27149DFA;
	Tue, 14 Jan 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865097; cv=none; b=Mm/ZW1zx/CqnBda9AAV8JUNUWhWetIveWAv8dVI8p16gYCFIkLrDt7HoTjleU84xqP4DhH+0aPPmm2Z4iLwPXxqNzNHvfN7XD0WIVhU9uAjGL3IBxX6iZAWOUJe7Y1L+Wy33Gx8ginMb447dpHM/QFROHZwVdvpa4mXjSz+UI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865097; c=relaxed/simple;
	bh=VU+nLEgBl+YFJkoUv1eElekBu6BwOmDALua6tx+orpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epXsYKx82rF/ULYSUxWNMuLizyFZjiBpOLjnfJ9lVIl1oLoD4R1Ox03svPmikX6BTf7PH541INEeUcf7+1e+4e3JSJGbsgi9Xn12DWYanCflU+94VcITpoeoAh8gouu85RoWUwrDJCnI55w7dZUKSMdy4wCpHD7FA7oq3iUAnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEtX7U3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2784EC4CEDD;
	Tue, 14 Jan 2025 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736865096;
	bh=VU+nLEgBl+YFJkoUv1eElekBu6BwOmDALua6tx+orpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QEtX7U3/ak1me7Fh/IOKx2eWije06zBsdu54WkuYgovrWPxbLz2NBgPtvo1bHlJkx
	 qsSj7wTdsfrNbU7M8DywqPKHQUGhsEciFB4JuAU06IaOXYhuh44utmCTi/fOg+rLzp
	 mCTBnWIVcVYl/PQGV8vitwvv+6uGzb4eMn8wrT1v7SuG7x0DNk02YAYOOOc70+qv60
	 2rxT1sLWMEx4ct2T1z6sQgoH65L99EqU0Xh9fXUeiclQNW+0WIrdVrH3qcw76Pje3C
	 ZMpqTTqBZTCQZDwSTHzEw/n0Jtjm6Br5Fnm1yd9rpeRn3L4fb9HJ53wbB+wNxnRCEf
	 Qly7CofQ8+xaw==
Message-ID: <3c8e4f86-87e2-470d-84d8-86c70b3e2fcc@kernel.org>
Date: Tue, 14 Jan 2025 15:31:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/8] fix two bugs related to page_pool
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
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
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250110130703.3814407-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2025 14.06, Yunsheng Lin wrote:
> This patchset fix a possible time window problem for page_pool and
> the dma API misuse problem as mentioned in [1], and try to avoid the
> overhead of the fixing using some optimization.
> 
>  From the below performance data, the overhead is not so obvious
> due to performance variations for time_bench_page_pool01_fast_path()
> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
> for time_bench_page_pool03_slow() for fixing the bug.
> 

My benchmarking on x86_64 CPUs looks significantly different.
  - CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz

Benchmark (bench_page_pool_simple) results from before and after patchset:

| Test name  | Cycles |       |    |Nanosec |        |       |      % |
| (tasklet_*)| Before | After |diff| Before |  After |  diff | change |
|------------+--------+-------+----+--------+--------+-------+--------|
| fast_path  |     19 |    24 |   5|  5.399 |  6.928 | 1.529 |   28.3 |
| ptr_ring   |     54 |    79 |  25| 15.090 | 21.976 | 6.886 |   45.6 |
| slow       |    238 |   299 |  61| 66.134 | 83.298 |17.164 |   26.0 |
#+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f

My above testing show a clear performance regressions across three
different page_pool operating modes.


Data also available in:
  - 
https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org

Raw data below

Before this patchset:

[  157.186644] bench_page_pool_simple: Loaded
[  157.475084] time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.284 
ns (step:0) - (measurement period time:0.284327440 sec 
time_interval:284327440) - (invoke count:1000000000 tsc_interval:1023590451)
[  162.262752] time_bench: Type:atomic_inc Per elem: 17 cycles(tsc) 
4.769 ns (step:0) - (measurement period time:4.769757001 sec 
time_interval:4769757001) - (invoke count:1000000000 
tsc_interval:17171776113)
[  163.324091] time_bench: Type:lock Per elem: 37 cycles(tsc) 10.431 ns 
(step:0) - (measurement period time:1.043182161 sec 
time_interval:1043182161) - (invoke count:100000000 tsc_interval:3755514465)
[  163.341702] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  163.922466] time_bench: Type:no-softirq-page_pool01 Per elem: 20 
cycles(tsc) 5.713 ns (step:0) - (measurement period time:0.571357387 sec 
time_interval:571357387) - (invoke count:100000000 tsc_interval:2056911063)
[  163.941429] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  165.506796] time_bench: Type:no-softirq-page_pool02 Per elem: 56 
cycles(tsc) 15.560 ns (step:0) - (measurement period time:1.556080558 
sec time_interval:1556080558) - (invoke count:100000000 
tsc_interval:5601960921)
[  165.525978] bench_page_pool_simple: time_bench_page_pool03_slow(): 
Cannot use page_pool fast-path
[  171.811289] time_bench: Type:no-softirq-page_pool03 Per elem: 225 
cycles(tsc) 62.763 ns (step:0) - (measurement period time:6.276301531 
sec time_interval:6276301531) - (invoke count:100000000 
tsc_interval:22594974468)
[  171.830646] bench_page_pool_simple: pp_tasklet_handler(): 
in_serving_softirq fast-path
[  171.838561] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  172.387597] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 
19 cycles(tsc) 5.399 ns (step:0) - (measurement period time:0.539904228 
sec time_interval:539904228) - (invoke count:100000000 
tsc_interval:1943679246)
[  172.407130] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  173.925266] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 
54 cycles(tsc) 15.090 ns (step:0) - (measurement period time:1.509075496 
sec time_interval:1509075496) - (invoke count:100000000 
tsc_interval:5432740575)
[  173.944878] bench_page_pool_simple: time_bench_page_pool03_slow(): 
in_serving_softirq fast-path
[  180.567094] time_bench: Type:tasklet_page_pool03_slow Per elem: 238 
cycles(tsc) 66.134 ns (step:0) - (measurement period time:6.613430605 
sec time_interval:6613430605) - (invoke count:100000000 
tsc_interval:23808654870)



After this patchset:
[  860.519918] bench_page_pool_simple: Loaded
[  860.781605] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.257 
ns (step:0) - (measurement period time:0.257573336 sec 
time_interval:257573336) - (invoke count:1000000000 tsc_interval:927275355)
[  865.613893] time_bench: Type:atomic_inc Per elem: 17 cycles(tsc) 
4.814 ns (step:0) - (measurement period time:4.814593429 sec 
time_interval:4814593429) - (invoke count:1000000000 
tsc_interval:17332768494)
[  866.708420] time_bench: Type:lock Per elem: 38 cycles(tsc) 10.763 ns 
(step:0) - (measurement period time:1.076362960 sec 
time_interval:1076362960) - (invoke count:100000000 tsc_interval:3874955595)
[  866.726118] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  867.423572] time_bench: Type:no-softirq-page_pool01 Per elem: 24 
cycles(tsc) 6.880 ns (step:0) - (measurement period time:0.688069107 sec 
time_interval:688069107) - (invoke count:100000000 tsc_interval:2477080260)
[  867.442517] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  869.436286] time_bench: Type:no-softirq-page_pool02 Per elem: 71 
cycles(tsc) 19.844 ns (step:0) - (measurement period time:1.984451929 
sec time_interval:1984451929) - (invoke count:100000000 
tsc_interval:7144120329)
[  869.455492] bench_page_pool_simple: time_bench_page_pool03_slow(): 
Cannot use page_pool fast-path
[  877.071437] time_bench: Type:no-softirq-page_pool03 Per elem: 273 
cycles(tsc) 76.069 ns (step:0) - (measurement period time:7.606911291 
sec time_interval:7606911291) - (invoke count:100000000 
tsc_interval:27385252251)
[  877.090762] bench_page_pool_simple: pp_tasklet_handler(): 
in_serving_softirq fast-path
[  877.098683] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  877.800696] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 
24 cycles(tsc) 6.928 ns (step:0) - (measurement period time:0.692852876 
sec time_interval:692852876) - (invoke count:100000000 
tsc_interval:2494303293)
[  877.820224] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  880.026911] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 
79 cycles(tsc) 21.976 ns (step:0) - (measurement period time:2.197615122 
sec time_interval:2197615122) - (invoke count:100000000 
tsc_interval:7911521190)
[  880.046528] bench_page_pool_simple: time_bench_page_pool03_slow(): 
in_serving_softirq fast-path
[  888.385235] time_bench: Type:tasklet_page_pool03_slow Per elem: 299 
cycles(tsc) 83.298 ns (step:0) - (measurement period time:8.329893717 
sec time_interval:8329893717) - (invoke count:100000000 
tsc_interval:29988024696)




> Before this patchset:
> root@(none)$ insmod bench_page_pool_simple.ko
> [  323.367627] bench_page_pool_simple: Loaded
> [  323.448747] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076997150 sec time_interval:76997150) - (invoke count:100000000 tsc_interval:7699707)
> [  324.812884] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.468 ns (step:0) - (measurement period time:1.346855130 sec time_interval:1346855130) - (invoke count:100000000 tsc_interval:134685507)
> [  324.980875] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.010 ns (step:0) - (measurement period time:0.150101270 sec time_interval:150101270) - (invoke count:10000000 tsc_interval:15010120)
> [  325.652195] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.542 ns (step:0) - (measurement period time:0.654213000 sec time_interval:654213000) - (invoke count:100000000 tsc_interval:65421294)
> [  325.669215] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> [  325.974848] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 29.633 ns (step:0) - (measurement period time:0.296338200 sec time_interval:296338200) - (invoke count:10000000 tsc_interval:29633814)
> [  325.993517] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> [  326.576636] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.391 ns (step:0) - (measurement period time:0.573911820 sec time_interval:573911820) - (invoke count:10000000 tsc_interval:57391174)
> [  326.595307] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> [  328.422661] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 181.849 ns (step:0) - (measurement period time:1.818495880 sec time_interval:1818495880) - (invoke count:10000000 tsc_interval:181849581)
> [  328.441681] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> [  328.449584] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> [  328.755031] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 29.632 ns (step:0) - (measurement period time:0.296327910 sec time_interval:296327910) - (invoke count:10000000 tsc_interval:29632785)
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
> [  144.224320] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> [  144.916044] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 6 cycles(tsc) 68.269 ns (step:0) - (measurement period time:0.682693070 sec time_interval:682693070) - (invoke count:10000000 tsc_interval:68269300)
> [  144.935234] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> [  146.997684] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 205.376 ns (step:0) - (measurement period time:2.053766310 sec time_interval:2053766310) - (invoke count:10000000 tsc_interval:205376624)
> 
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
> V7:
>    1. Fix a used-after-free bug reported by KASAN as mentioned by Jakub.
>    2. Fix the 'netmem' variable not setting up correctly bug as mentioned
>       by Simon.
> 
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
>   include/net/page_pool/types.h                 |  64 +-
>   net/core/devmem.c                             |   4 +-
>   net/core/netmem_priv.h                        |   5 +-
>   net/core/page_pool.c                          | 664 ++++++++++++++----
>   net/core/page_pool_priv.h                     |  12 +-
>   18 files changed, 675 insertions(+), 158 deletions(-)
> 

