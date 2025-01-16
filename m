Return-Path: <bpf+bounces-49075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4CFA1415F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F42F16B696
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7822FAFC;
	Thu, 16 Jan 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeJd3zIn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274722CBEF;
	Thu, 16 Jan 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050587; cv=none; b=OcCC4MPR0MI6gP+Zd+2yuvEEvPrTw7eQo8kYPfzTyy3R4DFyvgcuJB3KOgzRMSZ6G8miXk4rqzljyt7F5pd9mOtNst+/vgTGYcgMuGnRCrm0khq1U/PgoSGsA/1FmJtfGDf2vof0yzJYvu9oUqGQ1vJJLmI4HCZlqhI4bYK5bks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050587; c=relaxed/simple;
	bh=NJ3mCKVaerTWKdIY3yecqSXXrLTSZSkqHQ/cdTJWkEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5a/Eg8Uu+17LLyVeBydMq9gZHzKLxL/uJpXTm5nHNAnTYh1rDP6x01rXQUceOK9UcXvks/YoP4PBmD75mMFvmHKcvdEtManYPTHMbNJFJjSnX8+6+eyalKyOr3yPBJqvsMpp/x6KUIKUVJQkItuU1vjGCgu/2MFBN8nYFokGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeJd3zIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65FAC4CED6;
	Thu, 16 Jan 2025 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737050587;
	bh=NJ3mCKVaerTWKdIY3yecqSXXrLTSZSkqHQ/cdTJWkEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JeJd3zInKgbOG12tOr+M4tKEbxueUw/GyR+YtZoFsftDzz0NwbDdOaZmqF5FjYFUW
	 fq6OXxaf+kc1UKQI2xkfNOn0SjTKJnNQ6aXrCf7yXLUanwJgEZH991A6sCCJnotDSa
	 45KUpiLVVf0vfVmDz6J+L0vQgxFwLj175YRjmd52cG4KnnH6aZEz/BDLoa+3C2t4i0
	 kFtpeTJZdQUiafVv1ZfytHfbDixLf90R7zdAKIEem/f2ynVZGfoZoC/U9Zb8dAxh/z
	 MRQBfGJg4zbVKAH1DtDFnZUofqYFq86ctZEd5OYqGxAaLB1XT8L0cfy+QG3chLi3AZ
	 KqN2d3gF1mAPw==
Message-ID: <f558df7a-d983-4fc5-8358-faf251994d23@kernel.org>
Date: Thu, 16 Jan 2025 19:02:59 +0100
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1bef4a35-efaa-4083-8ed5-8818fe285db5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/01/2025 13.52, Yunsheng Lin wrote:
> On 2025/1/16 1:40, Jesper Dangaard Brouer wrote:
>>
>>
>> On 15/01/2025 12.33, Yunsheng Lin wrote:
>>> On 2025/1/14 22:31, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 10/01/2025 14.06, Yunsheng Lin wrote:
>>>>> This patchset fix a possible time window problem for page_pool and
>>>>> the dma API misuse problem as mentioned in [1], and try to avoid the
>>>>> overhead of the fixing using some optimization.
>>>>>
>>>>>    From the below performance data, the overhead is not so obvious
>>>>> due to performance variations for time_bench_page_pool01_fast_path()
>>>>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>>>>> for time_bench_page_pool03_slow() for fixing the bug.
>>>>>
>>>>
>>>> My benchmarking on x86_64 CPUs looks significantly different.
>>>>    - CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>>>>
>>>> Benchmark (bench_page_pool_simple) results from before and after patchset:
>>>>
>>>> | Test name  | Cycles |       |    |Nanosec |        |       |      % |
>>>> | (tasklet_*)| Before | After |diff| Before |  After |  diff | change |
>>>> |------------+--------+-------+----+--------+--------+-------+--------|
>>>> | fast_path  |     19 |    24 |   5|  5.399 |  6.928 | 1.529 |   28.3 |
>>>> | ptr_ring   |     54 |    79 |  25| 15.090 | 21.976 | 6.886 |   45.6 |
>>>> | slow       |    238 |   299 |  61| 66.134 | 83.298 |17.164 |   26.0 |
>>>> #+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f
>>>>
>>>> My above testing show a clear performance regressions across three
>>>> different page_pool operating modes.
>>>
>>> I retested it on arm64 server patch by patch as the raw performance
>>> data in the attachment, it seems the result seemed similar as before.
>>>
>>> Before this patchset:
>>>               fast_path              ptr_ring            slow
>>> 1.         31.171 ns               60.980 ns          164.917 ns
>>> 2.         28.824 ns               60.891 ns          170.241 ns
>>> 3.         14.236 ns               60.583 ns          164.355 ns
>>>
>>> With patch 1-4:
>>> 4.         31.443 ns               53.242 ns          210.148 ns
>>> 5.         31.406 ns               53.270 ns          210.189 ns
>>>
>>> With patch 1-5:
>>> 6.         26.163 ns               53.781 ns          189.450 ns
>>> 7.         26.189 ns               53.798 ns          189.466 ns
>>>
>>> With patch 1-8:
>>> 8.         28.108 ns               68.199 ns          202.516 ns
>>> 9.         16.128 ns               55.904 ns          202.711 ns
>>>
>>> I am not able to get hold of a x86 server yet, I might be able
>>> to get one during weekend.
>>>
>>> Theoretically, patch 1-4 or 1-5 should not have much performance
>>> impact for fast_path and ptr_ring except for the rcu_lock mentioned
>>> in page_pool_napi_local(), so it would be good if patch 1-5 is also
>>> tested in your testlab with the rcu_lock removing in
>>> page_pool_napi_local().
>>>
>>
>> What are you saying?
>>   - (1) test patch 1-5
>>   - or (2) test patch 1-5 but revert patch 2 with page_pool_napi_local()
> 
> patch 1-5 with below applied.
> 
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1207,10 +1207,8 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>          /* Synchronizated with page_pool_destory() to avoid use-after-free
>           * for 'napi'.
>           */
> -       rcu_read_lock();
>          napi = READ_ONCE(pool->p.napi);
>          napi_local = napi && READ_ONCE(napi->list_owner) == cpuid;
> -       rcu_read_unlock();
> 
>          return napi_local;
>   }
> 

Benchmark (bench_page_pool_simple) results from before and after
patchset with patches 1-5m and rcu lock removal as requested.

| Test name  |Cycles |   1-5 |    | Nanosec |    1-5 |        |      % |
| (tasklet_*)|Before | After |diff|  Before |  After |   diff | change |
|------------+-------+-------+----+---------+--------+--------+--------|
| fast_path  |    19 |    19 |   0|   5.399 |  5.492 |  0.093 |    1.7 |
| ptr_ring   |    54 |    57 |   3|  15.090 | 15.849 |  0.759 |    5.0 |
| slow       |   238 |   284 |  46|  66.134 | 78.909 | 12.775 |   19.3 |
#+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f

This test with patches 1-5 looks much better regarding performance.

--Jesper

https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org#e5-1650-pp01-dma-fix-v7-p1-5

Kernel:
  - 6.13.0-rc6-pp01-DMA-fix-v7-p1-5+ #5 SMP PREEMPT_DYNAMIC Thu Jan 16 
18:06:53 CET 2025 x86_64 GNU/Linux

Machine: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz

modprobe bench_page_pool_simple loops=100000000

Raw data:
[  187.309423] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  187.872849] time_bench: Type:no-softirq-page_pool01 Per elem: 19 
cycles(tsc) 5.539 ns (step:0) - (measurement period time:0.553906443 sec 
time_interval:553906443) - (invoke count:100000000 tsc_interval:1994123064)
[  187.892023] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  189.611070] time_bench: Type:no-softirq-page_pool02 Per elem: 61 
cycles(tsc) 17.095 ns (step:0) - (measurement period time:1.709580367 
sec time_interval:1709580367) - (invoke count:100000000 
tsc_interval:6154679394)
[  189.630414] bench_page_pool_simple: time_bench_page_pool03_slow(): 
Cannot use page_pool fast-path
[  197.222387] time_bench: Type:no-softirq-page_pool03 Per elem: 272 
cycles(tsc) 75.826 ns (step:0) - (measurement period time:7.582681388 
sec time_interval:7582681388) - (invoke count:100000000 
tsc_interval:27298499214)
[  197.241926] bench_page_pool_simple: pp_tasklet_handler(): 
in_serving_softirq fast-path
[  197.249968] bench_page_pool_simple: 
time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  197.808470] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 
19 cycles(tsc) 5.492 ns (step:0) - (measurement period time:0.549225541 
sec time_interval:549225541) - (invoke count:100000000 
tsc_interval:1977272238)
[  197.828174] bench_page_pool_simple: 
time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  199.422305] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 
57 cycles(tsc) 15.849 ns (step:0) - (measurement period time:1.584920736 
sec time_interval:1584920736) - (invoke count:100000000 
tsc_interval:5705890830)
[  199.442087] bench_page_pool_simple: time_bench_page_pool03_slow(): 
in_serving_softirq fast-path
[  207.342120] time_bench: Type:tasklet_page_pool03_slow Per elem: 284 
cycles(tsc) 78.909 ns (step:0) - (measurement period time:7.890955151 
sec time_interval:7890955151) - (invoke count:100000000 
tsc_interval:28408319289)


