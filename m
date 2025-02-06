Return-Path: <bpf+bounces-50668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51295A2AA9F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 15:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2B83A92E7
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5D22E3F3;
	Thu,  6 Feb 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VWyBHEcG"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD591EA7C6;
	Thu,  6 Feb 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850521; cv=none; b=cojb32m0MstFuwJWXcOaIKqPw7OBlot4yhhNXlVsWK1obZrddDH88cyFAoRwpVTWn3maTBqUFUEkV0TWORMnGx0lOpjR2BBUoqrg8FdHFST/BKuzpGwpG1IS30PlreEG2s8l2wrvpDeSaJtC/fbnfgccy0ri784GlO32dJ9Q4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850521; c=relaxed/simple;
	bh=gqNJYSiNsK6cpWnWjSxz9u29vlUEbxiiNXPlAKaKdaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NjBf443aPl4lt8VbdxPgYAniVhoqiRXarhsEfFjvfHXR8hdZsOj6E+4379I909VrW7CQ/CZdYl42kP7tMqE+inV3sQqAeR3RmTeKUGne+R63MAdk98upVTxNKLPznPmfk0T9RqFaIzGFAJjVMDLD695Jkms5GnY9GM3xVZARwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VWyBHEcG; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516E1Chb3635411
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 6 Feb 2025 08:01:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738850472;
	bh=JzgXDfs7zolLM+ECMRMomq4NQK9sGoV7mYHLd1cpZVo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VWyBHEcG11Mm9E81MM4ZcZVa8kxViqwaJRsrM5RFvCmQwgzNjEx6LADeoBb6YmeiH
	 SDfLHGu8sgOq6g1h2Lp2byT6n5codLVs7aXewmoNKbUrONPJsgE7/aVyRw7BLkJVLN
	 2nDpP/BrcLvOI8GsO2v5E51nyGo6J7X/ywvicuJw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516E1Cdt015489;
	Thu, 6 Feb 2025 08:01:12 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 08:01:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 08:01:12 -0600
Received: from [172.24.23.168] (lt9560gk3.dhcp.ti.com [172.24.23.168])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516E142U027248;
	Thu, 6 Feb 2025 08:01:04 -0600
Message-ID: <631429d8-9da6-4333-80ce-6ff59e5ecdf6@ti.com>
Date: Thu, 6 Feb 2025 19:31:03 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net 1/3] net: ti: icssg-prueth: Use
 page_pool API for RX buffer allocation
To: Ido Schimmel <idosch@idosch.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <dan.carpenter@linaro.org>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-2-m-malladi@ti.com> <Z5J4jjJ4_arvfF9E@shredder>
 <9287a623-5663-4705-b61a-3ab5f5cb2424@ti.com> <Z6OirBmdSLuY5YkI@shredder>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <Z6OirBmdSLuY5YkI@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/5/2025 11:11 PM, Ido Schimmel wrote:
> On Tue, Feb 04, 2025 at 11: 25: 02PM +0530, Malladi, Meghana wrote: > 
> Seems like none of the pages which have been allocated aren't getting > 
> recycled in the rx path after being used unless its some error case. 
> Will > try to fix this. 
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> v9dnXdhkXiNQgIoLtH6jcbhWBIydfvayMZ6bf68taZCHXfcLg8XIOscUa_XNxqzQWA$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Tue, Feb 04, 2025 at 11:25:02PM +0530, Malladi, Meghana wrote:
>> Seems like none of the pages which have been allocated aren't getting
>> recycled in the rx path after being used unless its some error case. Will
>> try to fix this.
> 
> skb_mark_for_recycle() should help with page recycling when an skb that
> uses them is freed.
> 
> Anyway, I believe that I don't see put call when tearing down the Rx
> ring because prueth_rx_cleanup() is using page_pool_recycle_direct()
> when it shouldn't. AFAICT, prueth_rx_cleanup() is only called from the
> control path (upon ndo_stop()) and not in NAPI context.
> 

Ok I will use skb_mark_for_recycle()/page_pool_recycle_direct() 
accordingly to recycle the pages.

>> Also I have noticed, in prueth_prepare_rx_chan() pages are allocated per
>> number of descriptors for a channel, but they are not being used when a
>> packet is being recieved (in emac_rx_packet()) and rather new page is
>> allocated for the next upcoming packet. Is this a valid design, what are
>> your thoughts on this ?
> 
> The new page is possibly a page that was recycled into the pool when a
> previous packet was freed / dropped.
> 
> [...]
> 
>> Yes I will add PP_FLAG_DMA_SYNC_DEV as well.
>> I believe page_pool_dma_sync_for_cpu() needs to be called sync Rx page for
>> CPU, am I right ? If so can you tell me, in what all cases should I call
>> this function.
> 
> Before accessing the packet data.
>

Ok, thanks.

>> https://urldefense.com/v3/__https://lkml.iu.edu/hypermail/linux/ 
> kernel/2312.1/06353.html__;!!G3vK!R- 
> autrVAgf5rAbl3CYoqlN5gRE_NqPqYRg1NHkJ405Q33b6uKiHFI73PeRky46dBYBWQpmFThUyD$ <https://urldefense.com/v3/__https://lkml.iu.edu/hypermail/linux/kernel/2312.1/06353.html__;!!G3vK!R-autrVAgf5rAbl3CYoqlN5gRE_NqPqYRg1NHkJ405Q33b6uKiHFI73PeRky46dBYBWQpmFThUyD$>
>> In the above link it is quoted - "Note that this version performs DMA sync
>> unconditionally, even if the associated PP doesn't perform sync-for-device"
>> for the page_pool_dma_sync_for_cpu() function. So does that mean if I am
>> using this function I don't need explicily sync for device call?
> 
> It's explained in the page pool documentation:
> 
> "Driver is always responsible for syncing the pages for the CPU. Drivers
> may choose to take care of syncing for the device as well or set the
> PP_FLAG_DMA_SYNC_DEV flag to request that pages allocated from the page
> pool are already synced for the device."
> 
> https://urldefense.com/v3/__https://docs.kernel.org/networking/ 
> page_pool.html*dma-sync__;Iw!!G3vK!R- 
> autrVAgf5rAbl3CYoqlN5gRE_NqPqYRg1NHkJ405Q33b6uKiHFI73PeRky46dBYBWQphNIm6Qm$ <https://urldefense.com/v3/__https://docs.kernel.org/networking/page_pool.html*dma-sync__;Iw!!G3vK!R-autrVAgf5rAbl3CYoqlN5gRE_NqPqYRg1NHkJ405Q33b6uKiHFI73PeRky46dBYBWQphNIm6Qm$>
> 


