Return-Path: <bpf+bounces-42497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E19A4AF7
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 04:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64331C217C2
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD69B1CC89A;
	Sat, 19 Oct 2024 02:41:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD751BDAAF;
	Sat, 19 Oct 2024 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729305685; cv=none; b=F3fJcnRgVb2klTH6QL59HD1Wq/pHePtkY5RuVlbZXxVD0bV93JPckGxEcX34uE2A3GL4EIWZDB4bnXG6zMda0ErdjLkrkDercHUiXi90p7ypPur8S6KRs1kWanyz6+AaKGdBmWZ0DQDuviH3ZtXM7Fqop0ashdqL4yNJT5mAKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729305685; c=relaxed/simple;
	bh=UzjDwqhpvxNW8+/cRxptfg4HWKRfjIWdNCm5/YldLOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IYbpunpMyfW2hf1GqbLeLBnbpRi6D1tzVyIKYgnuiNLQQLQg7eiwINijtV/rx+SbJWc+DEQuyW5/lPH3zFmlmir6mCWaZ+fWsfOcYxVTnwKwnA09cIhJSCrdqHsA3eQFy3s97iy9aqgmEVH81T43wfcFgRuuwavKGWPSoD9CMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XVlk92X8pz1T88X;
	Sat, 19 Oct 2024 10:23:45 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5347E18006C;
	Sat, 19 Oct 2024 10:25:41 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 10:25:40 +0800
Message-ID: <1ae4bc8e-caa3-5ba1-f018-30b4a2801955@huawei.com>
Date: Sat, 19 Oct 2024 10:25:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 net 3/4] ixgbe: Fix passing 0 to ERR_PTR in
 ixgbe_run_xdp()
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
 <20241018023734.1912166-4-yuehaibing@huawei.com> <ZxJTHIc3HPKxkD09@boxer>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <ZxJTHIc3HPKxkD09@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/18 20:22, Maciej Fijalkowski wrote:
> On Fri, Oct 18, 2024 at 10:37:33AM +0800, Yue Haibing wrote:
>> ixgbe_run_xdp() converts customed xdp action to a negative error code
>> with the sk_buff pointer type which be checked with IS_ERR in
>> ixgbe_clean_rx_irq(). Remove this error pointer handing instead use
>> plain int return value.
>>
>> Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
>>  1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 8b8404d8c946..78bf97ab0524 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -1908,10 +1908,6 @@ bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
>>  {
>>  	struct net_device *netdev = rx_ring->netdev;
>>  
>> -	/* XDP packets use error pointer so abort at this point */
>> -	if (IS_ERR(skb))
>> -		return true;
>> -
>>  	/* Verify netdev is present, and that packet does not have any
>>  	 * errors that would be unacceptable to the netdev.
>>  	 */
>> @@ -2219,9 +2215,9 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>>  	return skb;
>>  }
>>  
>> -static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>> -				     struct ixgbe_ring *rx_ring,
>> -				     struct xdp_buff *xdp)
>> +static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>> +			 struct ixgbe_ring *rx_ring,
>> +			 struct xdp_buff *xdp)
> 
> please align args. checkpatch didn't yell at you?

These have aligned in my patch and checkpatch passed.

yuehaibing@localhost:~/code/net$ ./scripts/checkpatch.pl 0003-ixgbe-Fix-passing-0-to-ERR_PTR-in-ixgbe_run_xdp.patch
total: 0 errors, 0 warnings, 0 checks, 67 lines checked

0003-ixgbe-Fix-passing-0-to-ERR_PTR-in-ixgbe_run_xdp.patch has no obvious style problems and is ready for submission.

> 
>>  {
>>  	int err, result = IXGBE_XDP_PASS;
>>  	struct bpf_prog *xdp_prog;
>> @@ -2271,7 +2267,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>>  		break;
>>  	}
>>  xdp_out:
>> -	return ERR_PTR(-result);
>> +	return result;
>>  }
>>  
>>  static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
>> @@ -2329,6 +2325,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>  	unsigned int offset = rx_ring->rx_offset;
>>  	unsigned int xdp_xmit = 0;
>>  	struct xdp_buff xdp;
>> +	int xdp_res;
>>  
>>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>>  #if (PAGE_SIZE < 8192)
>> @@ -2374,12 +2371,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>>  			xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, size);
>>  #endif
>> -			skb = ixgbe_run_xdp(adapter, rx_ring, &xdp);
>> +			xdp_res = ixgbe_run_xdp(adapter, rx_ring, &xdp);
>>  		}
>>  
>> -		if (IS_ERR(skb)) {
>> -			unsigned int xdp_res = -PTR_ERR(skb);
>> -
>> +		if (xdp_res) {
>>  			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
>>  				xdp_xmit |= xdp_res;
>>  				ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
>> @@ -2399,7 +2394,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>  		}
>>  
>>  		/* exit if we failed to retrieve a buffer */
>> -		if (!skb) {
>> +		if (!xdp_res && !skb) {
>>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>>  			rx_buffer->pagecnt_bias++;
>>  			break;
>> @@ -2413,7 +2408,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>  			continue;
>>  
>>  		/* verify the packet layout is correct */
>> -		if (ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
>> +		if (xdp_res || ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
>>  			continue;
>>  
>>  		/* probably a little skewed due to removing CRC */
>> -- 
>> 2.34.1
>>
> 
> 
> .

