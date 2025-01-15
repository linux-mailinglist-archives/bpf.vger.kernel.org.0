Return-Path: <bpf+bounces-48958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3DA12A09
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2493A3D58
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8284C1D5AB8;
	Wed, 15 Jan 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svJ45p4O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D01D514E;
	Wed, 15 Jan 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962826; cv=none; b=V7p1iRtdboHNumu34ldaeKJKfGR7Um0J6dQZJsneJnucEh4ga+Z5AACkWeGe95xA5wz3ISwTQAOABzRRV3e//Z6FWWCukNHlb3WQIS6UzCfV1NTnZ/eigjRv0KM8fMd+xS9HPBX3qJlxV5FAXYd3Scqh4PynqC7R5lvXfC8TJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962826; c=relaxed/simple;
	bh=MnSQMXREVVBMVqqG4DNkPoiFHSbXoUAQ7+YSxlu2cok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sP/UCX8Uwl8RJ/Y0PI5y+V4k8wPVP+igLhat76StN983CXDoTE82PP/NYTGoZPQfD7puHSkUAmENTq0s+F3mWNm6mLtOe/+0hTxwSzugyobxhpN4L6G0ROq8L4w+mwZbt6DalM/R305CA6Gn3uR0vfMN6oxgfVMgdQ4MT8ltbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svJ45p4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48597C4CEE0;
	Wed, 15 Jan 2025 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736962825;
	bh=MnSQMXREVVBMVqqG4DNkPoiFHSbXoUAQ7+YSxlu2cok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=svJ45p4OZzWwWOCVuCmsBOLH/Sb0FwOy4O6Wp/nYfGoUPPMIu4eZ5AeCKRw09uHlp
	 EvOQeh7YceB+VBH+j4VkwK6PCfrLADM0+kATjPLjH7aCrzR0PAMZpFDYT80+5rN/KI
	 PnsupXJ14Gkmz1GrEPVem0zwAxnL1TuB7n4nFvfuDjEqXhzeC/ujVDdr2lQV1Y4Krq
	 c5zmA3nAPBk25FZ7Mu0Zv4qFKeQNdCCQrsNUzOhg17VhdcEwcC5/s9KNK8G1BbWH5e
	 QEVGA5UezKKiGKayItoNcXhtg6FCRgXsglzQd6JOrixy3ENiUZAh6D0jRRsWRcPnhA
	 wzQYoGNu+WDCA==
Message-ID: <3a853e1b-b5bf-4709-b8f6-e466e3e7375e@kernel.org>
Date: Wed, 15 Jan 2025 18:40:18 +0100
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <c02e856e-6ec5-49d0-8527-2647695a0174@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/01/2025 12.33, Yunsheng Lin wrote:
> On 2025/1/14 22:31, Jesper Dangaard Brouer wrote:
>>
>>
>> On 10/01/2025 14.06, Yunsheng Lin wrote:
>>> This patchset fix a possible time window problem for page_pool and
>>> the dma API misuse problem as mentioned in [1], and try to avoid the
>>> overhead of the fixing using some optimization.
>>>
>>>   From the below performance data, the overhead is not so obvious
>>> due to performance variations for time_bench_page_pool01_fast_path()
>>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>>> for time_bench_page_pool03_slow() for fixing the bug.
>>>
>>
>> My benchmarking on x86_64 CPUs looks significantly different.
>>   - CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>>
>> Benchmark (bench_page_pool_simple) results from before and after patchset:
>>
>> | Test name  | Cycles |       |    |Nanosec |        |       |      % |
>> | (tasklet_*)| Before | After |diff| Before |  After |  diff | change |
>> |------------+--------+-------+----+--------+--------+-------+--------|
>> | fast_path  |     19 |    24 |   5|  5.399 |  6.928 | 1.529 |   28.3 |
>> | ptr_ring   |     54 |    79 |  25| 15.090 | 21.976 | 6.886 |   45.6 |
>> | slow       |    238 |   299 |  61| 66.134 | 83.298 |17.164 |   26.0 |
>> #+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f
>>
>> My above testing show a clear performance regressions across three
>> different page_pool operating modes.
> 
> I retested it on arm64 server patch by patch as the raw performance
> data in the attachment, it seems the result seemed similar as before.
> 
> Before this patchset:
>              fast_path              ptr_ring            slow
> 1.         31.171 ns               60.980 ns          164.917 ns
> 2.         28.824 ns               60.891 ns          170.241 ns
> 3.         14.236 ns               60.583 ns          164.355 ns
> 
> With patch 1-4:
> 4.         31.443 ns               53.242 ns          210.148 ns
> 5.         31.406 ns               53.270 ns          210.189 ns
> 
> With patch 1-5:
> 6.         26.163 ns               53.781 ns          189.450 ns
> 7.         26.189 ns               53.798 ns          189.466 ns
> 
> With patch 1-8:
> 8.         28.108 ns               68.199 ns          202.516 ns
> 9.         16.128 ns               55.904 ns          202.711 ns
> 
> I am not able to get hold of a x86 server yet, I might be able
> to get one during weekend.
> 
> Theoretically, patch 1-4 or 1-5 should not have much performance
> impact for fast_path and ptr_ring except for the rcu_lock mentioned
> in page_pool_napi_local(), so it would be good if patch 1-5 is also
> tested in your testlab with the rcu_lock removing in
> page_pool_napi_local().
> 

What are you saying?
  - (1) test patch 1-5
  - or (2) test patch 1-5 but revert patch 2 with page_pool_napi_local()

--Jesper

>>
>>
>> Data also available in:
>>   - https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org
>>

