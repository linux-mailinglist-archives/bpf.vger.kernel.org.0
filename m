Return-Path: <bpf+bounces-57206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF0AA6DC1
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F34C3282
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A023C4F7;
	Fri,  2 May 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yHhrXQDF"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1A23184A;
	Fri,  2 May 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176905; cv=none; b=jFsP4CUp8pSeRtWI94H2vxOBHaYO0UTvCvWgHHU3kYxm9p6tlzVk0s83HhmMUsGR0wkmgXCKWOZMEvb4zRqcoE85xOM7cx6xG/c7AW2reVRgxQ6oY8YCmG6UQerc3i/yqqTDuFUBO7bDF2JobhoEx77X4QZ9ETC4/BlWn/4z2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176905; c=relaxed/simple;
	bh=eNLevQHHQAD4rAIc55GjBUxARGFUE3AIHvX1ZNgcr9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UO8vRJJ6k7BLSJPeRz2AlZeK1D6smXBZvJBJJAjcynNHrGEJv1Q/8qx0SQXVsoZdkNGbVXNcgnUJB05GGKrFfqHYPpAziQqzb0qYQHs+DXhpTAf/pCP8zWj7vA9AZ7BVZhzIJP9rtPPR9omp6MYDS7vn/7eMOsUORBZ3d4N1yhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yHhrXQDF; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54297thx3827106
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 May 2025 04:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746176875;
	bh=MCXA41Ish/7Jei7o/eseHM2xmg9pFZPuBLzeUlIR67s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yHhrXQDFMyCoPhhHLWtaWNqza8g8gbzocqHe3jZNQr4zIl5LCrvxpjVAUbxomKH9w
	 C58fcII/WAi7JUFCBV0zhEBEQyKRvw4bqTkhgQQkjgzdhRFW2JMi43DfREvQU0U+WO
	 rqMLMfS6RdmTrGDUTpphESBUVEulV/0e0vPbl1sA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54297t4N021278
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:07:55 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 04:07:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 04:07:54 -0500
Received: from [172.24.30.16] (lt9560gk3.dhcp.ti.com [172.24.30.16])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54297nmp052556;
	Fri, 2 May 2025 04:07:50 -0500
Message-ID: <f6434e4a-c37c-41dc-91b4-0cc2d33730ba@ti.com>
Date: Fri, 2 May 2025 14:37:49 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: ti: icssg-prueth: Fix kernel panic during
 concurrent Tx queue access
To: Jesper Dangaard Brouer <hawk@kernel.org>, <dan.carpenter@linaro.org>,
        <john.fastabend@gmail.com>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
 <20250428120459.244525-5-m-malladi@ti.com>
 <074a9a19-9050-44dd-a0bf-536ae8318da2@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <074a9a19-9050-44dd-a0bf-536ae8318da2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jesper,

On 5/2/2025 12:44 PM, Jesper Dangaard Brouer wrote:
> 
> 
> On 28/04/2025 14.04, Meghana Malladi wrote:
>> Add __netif_tx_lock() to ensure that only one packet is being
>> transmitted at a time to avoid race conditions in the netif_txq
>> struct and prevent packet data corruption. Failing to do so causes
>> kernel panic with the following error:
>>
>> [ 2184.746764] ------------[ cut here ]------------
>> [ 2184.751412] kernel BUG at lib/dynamic_queue_limits.c:99!
>> [ 2184.756728] Internal error: Oops - BUG: 00000000f2000800 [#1] 
>> PREEMPT SMP
>>
>> logs: https://gist.github.com/ 
>> MeghanaMalladiTI/9c7aa5fc3b7fb03f87c74aad487956e9
>>
>> The lock is acquired before calling emac_xmit_xdp_frame() and released 
>> after the
>> call returns. This ensures that the TX queue is protected from 
>> concurrent access
>> during the transmission of XDP frames.
>>
>> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icssg_common.c | 7 ++++++-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 7 ++++++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/ 
>> net/ethernet/ti/icssg/icssg_common.c
>> index a120ff6fec8f..e509b6ff81e7 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -660,6 +660,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, 
>> struct xdp_buff *xdp,
>>               struct page *page, u32 *len)
>>   {
>>       struct net_device *ndev = emac->ndev;
>> +    struct netdev_queue *netif_txq;
>> +    int cpu = smp_processor_id();
>>       struct bpf_prog *xdp_prog;
>>       struct xdp_frame *xdpf;
>>       u32 pkt_len = *len;
>> @@ -679,8 +681,11 @@ static u32 emac_run_xdp(struct prueth_emac *emac, 
>> struct xdp_buff *xdp,
>>               goto drop;
>>           }
>> -        q_idx = smp_processor_id() % emac->tx_ch_num;
>> +        q_idx = cpu % emac->tx_ch_num;
>> +        netif_txq = netdev_get_tx_queue(ndev, q_idx);
>> +        __netif_tx_lock(netif_txq, cpu);
>>           result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
>> +        __netif_tx_unlock(netif_txq);
>>           if (result == ICSSG_XDP_CONSUMED) {
>>               ndev->stats.tx_dropped++;
>>               goto drop;
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/ 
>> net/ethernet/ti/icssg/icssg_prueth.c
>> index ee35fecf61e7..b31060e7f698 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1075,20 +1075,25 @@ static int emac_xdp_xmit(struct net_device 
>> *dev, int n, struct xdp_frame **frame
>>   {
>>       struct prueth_emac *emac = netdev_priv(dev);
>>       struct net_device *ndev = emac->ndev;
>> +    struct netdev_queue *netif_txq;
>> +    int cpu = smp_processor_id();
>>       struct xdp_frame *xdpf;
>>       unsigned int q_idx;
>>       int nxmit = 0;
>>       u32 err;
>>       int i;
>> -    q_idx = smp_processor_id() % emac->tx_ch_num;
>> +    q_idx = cpu % emac->tx_ch_num;
>> +    netif_txq = netdev_get_tx_queue(ndev, q_idx);
>>       if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>>           return -EINVAL;
>>       for (i = 0; i < n; i++) {
>>           xdpf = frames[i];
>> +        __netif_tx_lock(netif_txq, cpu);
>>           err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
>> +        __netif_tx_unlock(netif_txq);
> 
> Why are you taking and releasing this lock in a loop?
> 
> XDP gain performance by sending a batch of 'n' packets.
> This approach looks like a performance killer.
> 

Yes, I agree with you. This wasn't the intended change. Thank you for 
pointing this out. The lock and unlock should happen outside the loop. 
Will fix this in v2.

> 
>>           if (err != ICSSG_XDP_TX) {
>>               ndev->stats.tx_dropped++;
>>               break;
> 
> 

-- 
Thanks,
Meghana Malladi


