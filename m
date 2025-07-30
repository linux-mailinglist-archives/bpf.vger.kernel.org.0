Return-Path: <bpf+bounces-64710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3873FB16376
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D727E1AA3E03
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49761C3C11;
	Wed, 30 Jul 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OHY6gjjN"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E152DCF42;
	Wed, 30 Jul 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888510; cv=none; b=lDHT3ODtw0CXQV2ggC6onsMuIxH6ZX3IHLtz0efEgFz9k+jTjPyMuAriRKqXkk3xLLcVnXElP0u/dSQtWOgzKJs8W60DWadk+0TjI7UGA0LuRUsBUeo53qxgY8NnXs/pFdMRMfzyMjNhCaDu8bxxCODGtyvQShi6R+Z65LA+olA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888510; c=relaxed/simple;
	bh=fkckccSyliv1upVL1rwY+95w9R7G/KX0DfE2SjKAKN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OXoeYIjgkOfIgbTo+tRvmCWwTUL0KWynSa3xo5RpcnzwfqJwOZKtf7Nuq3ExzALjxE8baWbxOrkf0Zls3F4fVnDG/PGBSNp2TEfe8v2WAa3+12VHw19K4YBd6vfapchhRxigsTvIYEHvGXFOqT0hXWYWT5J8Ep7N493kDht6Q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OHY6gjjN; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UFEGSR2817950;
	Wed, 30 Jul 2025 10:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753888457;
	bh=7ua0MFYmmJwgIqN6yZsCwPYOXI20biJTE8N4JNQBlDw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OHY6gjjN8f48a5pFEOih/K5sacIY6GHdPtjlSHyoUV9MFCdjpxyGn2bJFzV7DLSw5
	 9H4L57FBpaKmKf7gPe4dV2kBEa0SCFo6cc2t2Wc1VyBr3WQcAYw+y7o6DcoN1EPjPo
	 3HWB+1d6IWNAeH/SmYllNdtSSMHaSPFttWlARtLA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UFEGJf2644967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 10:14:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 10:14:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 10:14:16 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UFEAqb1134002;
	Wed, 30 Jul 2025 10:14:11 -0500
Message-ID: <daee58ee-2d20-4cb0-b5bb-2e4dc1ff7b20@ti.com>
Date: Wed, 30 Jul 2025 20:44:09 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
To: Jakub Kicinski <kuba@kernel.org>
CC: <namcao@linutronix.de>, <jacob.e.keller@intel.com>, <sdf@fomichev.me>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250721124918.3347679-1-m-malladi@ti.com>
 <20250723171947.76995990@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20250723171947.76995990@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 7/24/25 05:49, Jakub Kicinski wrote:
> On Mon, 21 Jul 2025 18:19:18 +0530 Meghana Malladi wrote:
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index 12f25cec6255..a0e7def33e8e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -757,15 +757,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
>>   		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
>>   
>>   		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
>> -		if (*xdp_state == ICSSG_XDP_PASS)
>> -			skb = xdp_build_skb_from_buff(&xdp);
>> -		else
>> +		if (*xdp_state != ICSSG_XDP_PASS)
>>   			goto requeue;
>> -	} else {
>> -		/* prepare skb and send to n/w stack */
>> -		skb = napi_build_skb(pa, PAGE_SIZE);
>>   	}
>>   
>> +	/* prepare skb and send to n/w stack */
>> +	skb = napi_build_skb(pa, PAGE_SIZE);
>>   	if (!skb) {
>>   		ndev->stats.rx_dropped++;
>>   		page_pool_recycle_direct(pool, page);
> 
> I'm not sure this is correct. We seem to hardcode headroom to
> PRUETH_HEADROOM lower in this function. If XDP adds or removes
> network headers and then returns XDP_PASS we'll look for the packet
> at the wrong offset.
> 

Yes that makes sense. Thanks for pointing it out. I think I have the 
right fix in mind. Will post it shortly as v2.

> We just merged some XDP tests, could you try running
> tools/testing/selftests/drivers/net/xdp.py ?
> Some general instructions can be found here:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests
> 
> Not sure how stable the test is for all NICs but I think the
>   xdp.test_xdp_native_adjst_head_grow_data
> test case will exercise what I'm suspecting will fail.

It took me some time to install all the dependencies and get this tool 
running with the fix I mentioned above [1]. But I am not sure the error 
logs I got [2] are the one which you were expecting or some stability 
issue with the test. Can you please take a look at it.

[1]: 
https://gist.github.com/MeghanaMalladiTI/ce6a440f05fbdfb2d4363f672296d7d8
[2]:https://gist.github.com/MeghanaMalladiTI/52fe9d06c114562be08105d73f91ba62 


If the fix I attached here [1] makes sense, I will go ahead and post 
this as v2.

Thanks.

