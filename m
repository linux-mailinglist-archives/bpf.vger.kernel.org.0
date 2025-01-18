Return-Path: <bpf+bounces-49252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E181BA15BD7
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A4E166325
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF801632F2;
	Sat, 18 Jan 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwwr4yFv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202F149C53;
	Sat, 18 Jan 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187453; cv=none; b=JhPTY6Q3l65z6SXTbtevshGGVfAEUWmql4tcr2gAzLzusPUoNlaHzkdSCM1+6/3J8bepqE895KV0TYf6+J2umfrzsZQG2TEszBr5iLNhwYg1b3P1q5kew7NFIA0hwoTJojlcMa6I7TaH6YeiD+gzMrEaTgULEVBhidvTfoKO7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187453; c=relaxed/simple;
	bh=X8xl+FikvEsefyJsKMCnT/zbfddcbexbuTDnIId5TZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhIHK3Ph5akHutfgsCRSbi+MqcwnZ5FYfAorivrhR5ICwFl4kMiSuzDf9qjJ1fln3suNOiE56tbm/IgC23llJwR9+2dDDTTfqqU3ugZEosvd88Do5nJO3pdbPgJuhzMlhW9/s4DGpOV3Bqe9huYX2yssiyRlwkk1s3+AlGgAHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwwr4yFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B24DC4CED1;
	Sat, 18 Jan 2025 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737187452;
	bh=X8xl+FikvEsefyJsKMCnT/zbfddcbexbuTDnIId5TZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jwwr4yFvVLsCkvAYidGgHqdk1SqnXor04i9X94Db2qJ0QhORGpQHZOZkOPmZ0GQtJ
	 97no8YhrF+z3OTjQ1lxCNFIVYAjcGr8mU7o6rOF0vKBZ4er/XmYA+kcxB1nNqYB5xi
	 I4C2VEEVFterxQ3SKCBXurdH9MFkI3wJEd4w52mAp4+2zxpjHpAqcxGouwiJC8tXqr
	 cAmuba8ya9Vapi35c8+kl1peNietydCSD5VpLFVteL1O30Vd+ZhbSsCzExQc5RQRQH
	 zyCh1DkSlCRZ1x9ehDtdukIbZ4w4vxBXMukSP8LJ8AQkZHSGVcSYl5qh1n/eyyJkBJ
	 PJtjuFWuoRbIw==
Message-ID: <e0096465-a941-4a1e-9cad-8f5906a31554@kernel.org>
Date: Sat, 18 Jan 2025 09:04:05 +0100
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
 <3c8e4f86-87e2-470d-84d8-86c70b3e2fcc@kernel.org>
 <c02e856e-6ec5-49d0-8527-2647695a0174@huawei.com>
 <3a853e1b-b5bf-4709-b8f6-e466e3e7375e@kernel.org>
 <1bef4a35-efaa-4083-8ed5-8818fe285db5@huawei.com>
 <f558df7a-d983-4fc5-8358-faf251994d23@kernel.org>
 <304b542d-514d-4269-ae11-b2e214659483@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <304b542d-514d-4269-ae11-b2e214659483@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/01/2025 12.35, Yunsheng Lin wrote:
> On 2025/1/17 2:02, Jesper Dangaard Brouer wrote:
> 
>>
>> Benchmark (bench_page_pool_simple) results from before and after
>> patchset with patches 1-5m and rcu lock removal as requested.
>>
>> | Test name  |Cycles |   1-5 |    | Nanosec |    1-5 |        |      % |
>> | (tasklet_*)|Before | After |diff|  Before |  After |   diff | change |
>> |------------+-------+-------+----+---------+--------+--------+--------|
>> | fast_path  |    19 |    19 |   0|   5.399 |  5.492 |  0.093 |    1.7 |
>> | ptr_ring   |    54 |    57 |   3|  15.090 | 15.849 |  0.759 |    5.0 |
>> | slow       |   238 |   284 |  46|  66.134 | 78.909 | 12.775 |   19.3 |
>> #+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f
>>
>> This test with patches 1-5 looks much better regarding performance.
> 
> Thanks for the testing.
> 
> Is there any notiable performance variation during different test running
> for the same built kernel in your machine?
> 

My machine have quite stable performance for this benchmark.


>> https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org#e5-1650-pp01-dma-fix-v7-p1-5

Like documented in above link. I have also increased the loops count for
the test to get it more stable, given this will be measured over a
longer period.

  modprobe bench_page_pool_simple loops=100000000


>> Kernel:
>>   - 6.13.0-rc6-pp01-DMA-fix-v7-p1-5+ #5 SMP PREEMPT_DYNAMIC Thu Jan 16 18:06:53 CET 2025 x86_64 GNU/Linux
>>
>> Machine: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>>
>> modprobe bench_page_pool_simple loops=100000000
>>
>> Raw data:
>> [  187.309423] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
>> [  187.872849] time_bench: Type:no-softirq-page_pool01 Per elem: 19 cycles(tsc) 5.539 ns (step:0) - (measurement period time:0.553906443 sec time_interval:553906443) - (invoke count:100000000 tsc_interval:1994123064)
>> [  187.892023] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
>> [  189.611070] time_bench: Type:no-softirq-page_pool02 Per elem: 61 cycles(tsc) 17.095 ns (step:0) - (measurement period time:1.709580367 sec time_interval:1709580367) - (invoke count:100000000 tsc_interval:6154679394)
>> [  189.630414] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
>> [  197.222387] time_bench: Type:no-softirq-page_pool03 Per elem: 272 cycles(tsc) 75.826 ns (step:0) - (measurement period time:7.582681388 sec time_interval:7582681388) - (invoke count:100000000 tsc_interval:27298499214)
>> [  197.241926] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
>> [  197.249968] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
>> [  197.808470] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 19 cycles(tsc) 5.492 ns (step:0) - (measurement period time:0.549225541 sec time_interval:549225541) - (invoke count:100000000 tsc_interval:1977272238)
>> [  197.828174] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
>> [  199.422305] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 57 cycles(tsc) 15.849 ns (step:0) - (measurement period time:1.584920736 sec time_interval:1584920736) - (invoke count:100000000 tsc_interval:5705890830)
>> [  199.442087] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
>> [  207.342120] time_bench: Type:tasklet_page_pool03_slow Per elem: 284 cycles(tsc) 78.909 ns (step:0) - (measurement period time:7.890955151 sec time_interval:7890955151) - (invoke count:100000000 tsc_interval:28408319289)
>>

