Return-Path: <bpf+bounces-48233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70941A056FC
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD8161537
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC51F3D3E;
	Wed,  8 Jan 2025 09:36:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E510E4;
	Wed,  8 Jan 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329017; cv=none; b=U9yHLAmae6NkUnHITm2tUQYsXnw8C1AURtrQswsmnUL2f3ny3ev+48vvAIc8TC+6FDuYxW9Q+42jZW6EJJO+3/SrjjOdDGbAe/dg+jcaSwMV38/Koht1XJWcTtUcQVwR56vMFBkliI6fdPnAAJHJ+k5aQFKS/jz0kPIXBZ/OEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329017; c=relaxed/simple;
	bh=OVg/SOY/wgFfgt0yL/fzrCSEp/zsFXqwCn4vmsanJp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=il1VqxXYgpnXXs+9NAXmfakOXYh1EHlegMUAw79yi8Qd9W+tHHNvDs0VG7ZnR93ZiDTqRYoM5xpsFa2hzSTlNCWtU3LnUARtiWI0z6KlC9VFdf7X/rHUDoiApP1kZoUXo3ut5xwfBkVuHxIzFQws5ElKiAP5FBLIhqEomWAGGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YSjRw22mXz22kgr;
	Wed,  8 Jan 2025 17:34:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 49DF41A016C;
	Wed,  8 Jan 2025 17:36:51 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jan 2025 17:36:50 +0800
Message-ID: <7d26402a-bcd1-4e5f-bbf1-8b0a433ee8cd@huawei.com>
Date: Wed, 8 Jan 2025 17:36:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/8] fix two bugs related to page_pool
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, IOMMU
	<iommu@lists.linux.dev>, MM <linux-mm@kvack.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <f977c0ab-76f5-4869-9fb7-e111104e2fff@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <f977c0ab-76f5-4869-9fb7-e111104e2fff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/7 22:26, Jesper Dangaard Brouer wrote:
> 
> 
> On 06/01/2025 14.01, Yunsheng Lin wrote:
>> This patchset fix a possible time window problem for page_pool and
>> the dma API misuse problem as mentioned in [1], and try to avoid the
>> overhead of the fixing using some optimization.
>>
>>  From the below performance data, the overhead is not so obvious
>> due to performance variations for time_bench_page_pool01_fast_path()
>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>> for time_bench_page_pool03_slow() for fixing the bug.
>>
>> Before this patchset:
>> root@(none)$ insmod bench_page_pool_simple.ko
>> [  323.367627] bench_page_pool_simple: Loaded
>> [  323.448747] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076997150 sec time_interval:76997150) - (invoke count:100000000 tsc_interval:7699707)
>> [  324.812884] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.468 ns (step:0) - (measurement period time:1.346855130 sec time_interval:1346855130) - (invoke count:100000000 tsc_interval:134685507)
>> [  324.980875] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.010 ns (step:0) - (measurement period time:0.150101270 sec time_interval:150101270) - (invoke count:10000000 tsc_interval:15010120)
>> [  325.652195] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.542 ns (step:0) - (measurement period time:0.654213000 sec time_interval:654213000) - (invoke count:100000000 tsc_interval:65421294)
>> [  325.669215] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
>> [  325.974848] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 29.633 ns (step:0) - (measurement period time:0.296338200 sec time_interval:296338200) - (invoke count:10000000 tsc_interval:29633814)
> 
> (referring to above line, below)
> 
>> [  325.993517] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
>> [  326.576636] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.391 ns (step:0) - (measurement period time:0.573911820 sec time_interval:573911820) - (invoke count:10000000 tsc_interval:57391174)
>> [  326.595307] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
>> [  328.422661] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 181.849 ns (step:0) - (measurement period time:1.818495880 sec time_interval:1818495880) - (invoke count:10000000 tsc_interval:181849581)
>> [  328.441681] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
>> [  328.449584] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
>> [  328.755031] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 29.632 ns (step:0) - (measurement period time:0.296327910 sec time_interval:296327910) - (invoke count:10000000 tsc_interval:29632785)
> 
> It is strange that fast-path "tasklet_page_pool01_fast_path" isn't
> faster than above "no-softirq-page_pool01".
> They are both 29.633 ns.
> 
> What hardware is this?

Arm64 server, as the testing module doesn't support arm64, so get_cycles()
in [1] is used to do time keeping instead of using x86 asm instruction.

1. https://lore.kernel.org/lkml/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/T/

> 
> e.g. the cycle count of 2 cycles(tsc) seem strange.
> 
> On my testlab hardware Intel CPU E5-1650 v4 @3.60GHz
> My fast-path numbers say 5.202 ns (18 cycles) for "tasklet_page_pool01_fast_path"
> 
> 
> Raw data look like this
> 
> [Tue Jan  7 15:15:18 2025] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> [Tue Jan  7 15:15:18 2025] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> [Tue Jan  7 15:15:18 2025] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 18 cycles(tsc) 5.202 ns (step:0) - (measurement period time:0.052020430 sec time_interval:52020430) - (invoke count:10000000 tsc_interval:187272981)
> [Tue Jan  7 15:15:18 2025] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> [Tue Jan  7 15:15:19 2025] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 55 cycles(tsc) 15.343 ns (step:0) - (measurement period time:0.153438301 sec time_interval:153438301) - (invoke count:10000000 tsc_interval:552378168)
> [Tue Jan  7 15:15:19 2025] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> [Tue Jan  7 15:15:19 2025] time_bench: Type:tasklet_page_pool03_slow Per elem: 243 cycles(tsc) 67.725 ns (step:0) - (measurement period time:0.677255574 sec time_interval:677255574) - (invoke count:10000000 tsc_interval:2438124315)
> 
> 
>> [  328.774308] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
>> [  329.578579] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 7 cycles(tsc) 79.523 ns (step:0) - (measurement period time:0.795236560 sec time_interval:795236560) - (invoke count:10000000 tsc_interval:79523650)
>> [  329.597769] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
>> [  331.507501] time_bench: Type:tasklet_page_pool03_slow Per elem: 19 cycles(tsc) 190.104 ns (step:0) - (measurement period time:1.901047510 sec time_interval:1901047510) - (invoke count:10000000 tsc_interval:190104743)
>>
>> After this patchset:
>> root@(none)$ insmod bench_page_pool_simple.ko
>> [  138.634758] bench_page_pool_simple: Loaded
>> [  138.715879] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076972720 sec time_interval:76972720) - (invoke count:100000000 tsc_interval:7697265)
>> [  140.079897] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.467 ns (step:0) - (measurement period time:1.346735370 sec time_interval:1346735370) - (invoke count:100000000 tsc_interval:134673531)
>> [  140.247841] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150055080 sec time_interval:150055080) - (invoke count:10000000 tsc_interval:15005497)
>> [  140.919072] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654125000 sec time_interval:654125000) - (invoke count:100000000 tsc_interval:65412493)
>> [  140.936091] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
>> [  141.246985] time_bench: Type:no-softirq-page_pool01 Per elem: 3 cycles(tsc) 30.159 ns (step:0) - (measurement period time:0.301598160 sec time_interval:301598160) - (invoke count:10000000 tsc_interval:30159812)
>> [  141.265654] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
>> [  141.976265] time_bench: Type:no-softirq-page_pool02 Per elem: 7 cycles(tsc) 70.140 ns (step:0) - (measurement period time:0.701405780 sec time_interval:701405780) - (invoke count:10000000 tsc_interval:70140573)
>> [  141.994933] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
>> [  144.018945] time_bench: Type:no-softirq-page_pool03 Per elem: 20 cycles(tsc) 201.514 ns (step:0) - (measurement period time:2.015141210 sec time_interval:2015141210) - (invoke count:10000000 tsc_interval:201514113)
>> [  144.037966] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
>> [  144.045870] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
>> [  144.205045] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150056510 sec time_interval:150056510) - (invoke count:10000000 tsc_interval:15005645)
> 
> This 15.005 ns looks like a significant improvement over 29.633 ns

It seems to be some performance variations here. There seems to be some
performance variations between doing test using 'taskset -c 0' and with
using 'taskset -c 1' too, I didn't get into the detail reason of performance
variations yet, as the performance variations seems to exist before this
patchset too.

> 
>> [  144.224320] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
>> [  144.916044] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 6 cycles(tsc) 68.269 ns (step:0) - (measurement period time:0.682693070 sec time_interval:682693070) - (invoke count:10000000 tsc_interval:68269300)
>> [  144.935234] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
>> [  146.997684] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 205.376 ns (step:0) - (measurement period time:2.053766310 sec time_interval:2053766310) - (invoke count:10000000 tsc_interval:205376624)
>>
> 
> 
> Looks like I should also try out this patchset on my testlab, as this
> hardware seems significantly different than mine...

Yes, it would be much appreciated if it is also tested in your testlab.

