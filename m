Return-Path: <bpf+bounces-49178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0308A14E8B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC59F168949
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF091FE46B;
	Fri, 17 Jan 2025 11:35:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EB1D8E12;
	Fri, 17 Jan 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113740; cv=none; b=Y/4v2UErtGJ+CBdysNRuXQenn01fIjuTqrTEG7yZkcOHIojTXuMenKZLAhVjKyacULFy5GqJEKsih8VfsW2Yo5HH/CKph/cbq/O7EpjvtQyD6Fs5155lTbyqNFOE9xUpZXWZLEg5TuZzOOJkVLbIPFuBWwHGONKnOHcLLi1wVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113740; c=relaxed/simple;
	bh=MpVWMoWdsncOLBNsGe5pt+ULbypkbTe/agZRsjFXQqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=roI5U5kG1Zy+YGwbV6D3Ze4KYfyLVQKTA+H/Oa+OXuePjiQNIFkgcxwpXHWKkyChCitXuMZeSyM4g6O9azJIIcLJrkIa2rAvRobcQ1I2ThLrO8majB5haU9H32TgLPZoTj2zbX2hzinFANu+VTpdBltESf+ktzngRcvCpCUvpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YZHcq34sJzjYBg;
	Fri, 17 Jan 2025 19:31:39 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DBB1180101;
	Fri, 17 Jan 2025 19:35:33 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 19:35:32 +0800
Message-ID: <304b542d-514d-4269-ae11-b2e214659483@huawei.com>
Date: Fri, 17 Jan 2025 19:35:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/8] fix two bugs related to page_pool
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, IOMMU
	<iommu@lists.linux.dev>, MM <linux-mm@kvack.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <3c8e4f86-87e2-470d-84d8-86c70b3e2fcc@kernel.org>
 <c02e856e-6ec5-49d0-8527-2647695a0174@huawei.com>
 <3a853e1b-b5bf-4709-b8f6-e466e3e7375e@kernel.org>
 <1bef4a35-efaa-4083-8ed5-8818fe285db5@huawei.com>
 <f558df7a-d983-4fc5-8358-faf251994d23@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <f558df7a-d983-4fc5-8358-faf251994d23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/17 2:02, Jesper Dangaard Brouer wrote:

> 
> Benchmark (bench_page_pool_simple) results from before and after
> patchset with patches 1-5m and rcu lock removal as requested.
> 
> | Test name  |Cycles |   1-5 |    | Nanosec |    1-5 |        |      % |
> | (tasklet_*)|Before | After |diff|  Before |  After |   diff | change |
> |------------+-------+-------+----+---------+--------+--------+--------|
> | fast_path  |    19 |    19 |   0|   5.399 |  5.492 |  0.093 |    1.7 |
> | ptr_ring   |    54 |    57 |   3|  15.090 | 15.849 |  0.759 |    5.0 |
> | slow       |   238 |   284 |  46|  66.134 | 78.909 | 12.775 |   19.3 |
> #+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f
> 
> This test with patches 1-5 looks much better regarding performance.

Thanks for the testing.

Is there any notiable performance variation during different test running
for the same built kernel in your machine?

> 
> --Jesper
> 
> https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org#e5-1650-pp01-dma-fix-v7-p1-5
> 
> Kernel:
>  - 6.13.0-rc6-pp01-DMA-fix-v7-p1-5+ #5 SMP PREEMPT_DYNAMIC Thu Jan 16 18:06:53 CET 2025 x86_64 GNU/Linux
> 
> Machine: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
> 
> modprobe bench_page_pool_simple loops=100000000
> 
> Raw data:
> [  187.309423] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> [  187.872849] time_bench: Type:no-softirq-page_pool01 Per elem: 19 cycles(tsc) 5.539 ns (step:0) - (measurement period time:0.553906443 sec time_interval:553906443) - (invoke count:100000000 tsc_interval:1994123064)
> [  187.892023] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> [  189.611070] time_bench: Type:no-softirq-page_pool02 Per elem: 61 cycles(tsc) 17.095 ns (step:0) - (measurement period time:1.709580367 sec time_interval:1709580367) - (invoke count:100000000 tsc_interval:6154679394)
> [  189.630414] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> [  197.222387] time_bench: Type:no-softirq-page_pool03 Per elem: 272 cycles(tsc) 75.826 ns (step:0) - (measurement period time:7.582681388 sec time_interval:7582681388) - (invoke count:100000000 tsc_interval:27298499214)
> [  197.241926] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> [  197.249968] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> [  197.808470] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 19 cycles(tsc) 5.492 ns (step:0) - (measurement period time:0.549225541 sec time_interval:549225541) - (invoke count:100000000 tsc_interval:1977272238)
> [  197.828174] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> [  199.422305] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 57 cycles(tsc) 15.849 ns (step:0) - (measurement period time:1.584920736 sec time_interval:1584920736) - (invoke count:100000000 tsc_interval:5705890830)
> [  199.442087] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> [  207.342120] time_bench: Type:tasklet_page_pool03_slow Per elem: 284 cycles(tsc) 78.909 ns (step:0) - (measurement period time:7.890955151 sec time_interval:7890955151) - (invoke count:100000000 tsc_interval:28408319289)
> 

