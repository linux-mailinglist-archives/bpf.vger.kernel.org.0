Return-Path: <bpf+bounces-49050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A08A13A3D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0EB167B0D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35881DED6F;
	Thu, 16 Jan 2025 12:52:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FD1DE8BB;
	Thu, 16 Jan 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031931; cv=none; b=rrY4lG0BE5CvRn6NfByus2YT6s6nniTPioekI+nR8lZYa1ebThGlvKp7eqo1kWavpzHxJtJo8F1yx3TrFvZEF+8T+g4padL8Bl4dA9KrRPFSmyTonD9l9NhUGem4v2rBsjQlMSJhOWo74xqNA5WwzK+ka9NKQgIbY199U2vSWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031931; c=relaxed/simple;
	bh=eUdOT2Un72yDGZvOoQ8OJIwBSP/aANwUwNwJcybgR00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k1TsujAjge9xxfxZSAM0xlhPGmB1rkqFIdm6EC/nf21gQ39AZeelpJDdLNLtHBGwkQsnDBWV6DaxC1ZUry9HnhcoV9XBBiGaHA8y0dkGxB6lDAJ5DJ16yBfJEH8s/Bd2PlWH6nAvItIxgvgIpDKufQgT70Wnvu5G2JR3vRJhpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YYjR348srz1xmTj;
	Thu, 16 Jan 2025 20:51:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D57C1A016C;
	Thu, 16 Jan 2025 20:52:05 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jan 2025 20:52:05 +0800
Message-ID: <1bef4a35-efaa-4083-8ed5-8818fe285db5@huawei.com>
Date: Thu, 16 Jan 2025 20:52:04 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <3a853e1b-b5bf-4709-b8f6-e466e3e7375e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/16 1:40, Jesper Dangaard Brouer wrote:
> 
> 
> On 15/01/2025 12.33, Yunsheng Lin wrote:
>> On 2025/1/14 22:31, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 10/01/2025 14.06, Yunsheng Lin wrote:
>>>> This patchset fix a possible time window problem for page_pool and
>>>> the dma API misuse problem as mentioned in [1], and try to avoid the
>>>> overhead of the fixing using some optimization.
>>>>
>>>>   From the below performance data, the overhead is not so obvious
>>>> due to performance variations for time_bench_page_pool01_fast_path()
>>>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>>>> for time_bench_page_pool03_slow() for fixing the bug.
>>>>
>>>
>>> My benchmarking on x86_64 CPUs looks significantly different.
>>>   - CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz
>>>
>>> Benchmark (bench_page_pool_simple) results from before and after patchset:
>>>
>>> | Test name  | Cycles |       |    |Nanosec |        |       |      % |
>>> | (tasklet_*)| Before | After |diff| Before |  After |  diff | change |
>>> |------------+--------+-------+----+--------+--------+-------+--------|
>>> | fast_path  |     19 |    24 |   5|  5.399 |  6.928 | 1.529 |   28.3 |
>>> | ptr_ring   |     54 |    79 |  25| 15.090 | 21.976 | 6.886 |   45.6 |
>>> | slow       |    238 |   299 |  61| 66.134 | 83.298 |17.164 |   26.0 |
>>> #+TBLFM: $4=$3-$2::$7=$6-$5::$8=(($7/$5)*100);%.1f
>>>
>>> My above testing show a clear performance regressions across three
>>> different page_pool operating modes.
>>
>> I retested it on arm64 server patch by patch as the raw performance
>> data in the attachment, it seems the result seemed similar as before.
>>
>> Before this patchset:
>>              fast_path              ptr_ring            slow
>> 1.         31.171 ns               60.980 ns          164.917 ns
>> 2.         28.824 ns               60.891 ns          170.241 ns
>> 3.         14.236 ns               60.583 ns          164.355 ns
>>
>> With patch 1-4:
>> 4.         31.443 ns               53.242 ns          210.148 ns
>> 5.         31.406 ns               53.270 ns          210.189 ns
>>
>> With patch 1-5:
>> 6.         26.163 ns               53.781 ns          189.450 ns
>> 7.         26.189 ns               53.798 ns          189.466 ns
>>
>> With patch 1-8:
>> 8.         28.108 ns               68.199 ns          202.516 ns
>> 9.         16.128 ns               55.904 ns          202.711 ns
>>
>> I am not able to get hold of a x86 server yet, I might be able
>> to get one during weekend.
>>
>> Theoretically, patch 1-4 or 1-5 should not have much performance
>> impact for fast_path and ptr_ring except for the rcu_lock mentioned
>> in page_pool_napi_local(), so it would be good if patch 1-5 is also
>> tested in your testlab with the rcu_lock removing in
>> page_pool_napi_local().
>>
> 
> What are you saying?
>  - (1) test patch 1-5
>  - or (2) test patch 1-5 but revert patch 2 with page_pool_napi_local()

patch 1-5 with below applied.

--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1207,10 +1207,8 @@ static bool page_pool_napi_local(const struct page_pool *pool)
        /* Synchronizated with page_pool_destory() to avoid use-after-free
         * for 'napi'.
         */
-       rcu_read_lock();
        napi = READ_ONCE(pool->p.napi);
        napi_local = napi && READ_ONCE(napi->list_owner) == cpuid;
-       rcu_read_unlock();

        return napi_local;
 }


