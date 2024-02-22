Return-Path: <bpf+bounces-22494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F2A85F555
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2461C2272E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7939861;
	Thu, 22 Feb 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKWMaG1r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41793717C;
	Thu, 22 Feb 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596647; cv=none; b=HrUTYb+UL+w5nZBrHvya59ZCj1/QxxjcZH82o0lctVhbPvC9bL0+wFjUmJDfjMwTe8NW5O+mboJV65cLXuRigw2jxBPWWb+JtUE56ZB5xrBN69tXKnveX6FwQM/JE6WHa4+hSC33945Cr1z17NV8shhf4K1rsGSfvH6I1+3o5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596647; c=relaxed/simple;
	bh=tSCey7ELn07ZU9G79jg+PQl0/S1XaKqMN+IGgH7so/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZljmNY5oMDwjweFsrEJLivQHl/JibNCEhtje2NkKFdW198vuTGiNhsRSDB9Ooue0cu6gbfze2A2Oy+GesIvq6MUFoYJ0uU7c1zzBTwxMhe5CKb1DXTjNbcCSP3tg5fvmBAD7W2WiXNRs2+UEER/qAl8CMS3hukFQWp6N2nGxXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKWMaG1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776BCC433C7;
	Thu, 22 Feb 2024 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708596647;
	bh=tSCey7ELn07ZU9G79jg+PQl0/S1XaKqMN+IGgH7so/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XKWMaG1rDE8S2F4Hq5jrogc5oGjI3onN35wJZU9oOP7BocfcdgMcBx3o1+7smOHy8
	 WOJASqOCGIm/K8H+GcTqROYQV3NBqgDcVrYCWTnAJVW6ZSdRSMCDw21xeN/3xgGtnh
	 /valzWQDyvWH2Vcmtzbb7yJqDnw7NYC0qBpu1bxl6+IRtovEbr28sYC5DK5MMRS1GY
	 cBdXKplni5mq+8wwzS6wgVp6xthTIoo7iBqTHUrnUUFu7UCgsmo95cK6mfuekph9la
	 IuFLgTMUKS98IDolsrr/nf9HNCaaqxqWTa9wkEsJ7hW3xT8TOWUEogaB5EbgP1lAnh
	 8Zah+axbDNJ6A==
Message-ID: <f782b460-38fc-4c2b-b886-870760a96ece@kernel.org>
Date: Thu, 22 Feb 2024 11:10:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240214163607.RjjT5bO_@linutronix.de> <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de> <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
 <20240220120821.1Tbz6IeI@linutronix.de>
 <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>
 <20240220153206.AUZ_zP24@linutronix.de>
 <20240222092228.4ACXUrvU@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240222092228.4ACXUrvU@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/02/2024 10.22, Sebastian Andrzej Siewior wrote:
> On 2024-02-20 16:32:08 [+0100], To Jesper Dangaard Brouer wrote:
>>>
>>>   Ethtool(i40e2) stat:     15028585 (  15,028,585) <= tx-0.packets /sec
>>>   Ethtool(i40e2) stat:     15028589 (  15,028,589) <= tx_packets /sec
>>
>> -t1 in ixgbe
>> Show adapter(s) (eth1) statistics (ONLY that changed!)
>> Ethtool(eth1    ) stat:    107857263 (    107,857,263) <= tx_bytes /sec
>> Ethtool(eth1    ) stat:    115047684 (    115,047,684) <= tx_bytes_nic /sec
>> Ethtool(eth1    ) stat:      1797621 (      1,797,621) <= tx_packets /sec
>> Ethtool(eth1    ) stat:      1797636 (      1,797,636) <= tx_pkts_nic /sec
>> Ethtool(eth1    ) stat:    107857263 (    107,857,263) <= tx_queue_0_bytes /sec
>> Ethtool(eth1    ) stat:      1797621 (      1,797,621) <= tx_queue_0_packets /sec
> …
>> while sending with ixgbe while running perf top on the box:
>> | Samples: 621K of event 'cycles', 4000 Hz, Event count (approx.): 49979376685 lost: 0/0 drop: 0/0
>> | Overhead  CPU  Command          Shared Object             Symbol
>> |   31.98%  000  kpktgend_0       [kernel]                  [k] xas_find
>> |    6.72%  000  kpktgend_0       [kernel]                  [k] pfn_to_dma_pte
>> |    5.63%  000  kpktgend_0       [kernel]                  [k] ixgbe_xmit_frame_ring
>> |    4.78%  000  kpktgend_0       [kernel]                  [k] dma_pte_clear_level
>> |    3.16%  000  kpktgend_0       [kernel]                  [k] __iommu_dma_unmap
> 
> I disabled the iommu and I get to

Yes, clearly IOMMU code that cause the performance issue for you.

This driver doesn't use page_pool, so I want to point out (for people
finding this post in the future) that page_pool keeps DMA mappings for
recycled frame, which should address the IOMMU overhead issue here.

> 
> Ethtool(eth1    ) stat:     14158562 (     14,158,562) <= tx_packets /sec
> Ethtool(eth1    ) stat:     14158685 (     14,158,685) <= tx_pkts_nic /sec
> 
> looks like a small improvement… It is not your 15 but close. -t2 does
> improve the situation. 

You cannot reach 15Mpps on 10Gbit/s as wirespeed for 10G is 14.88Mpps.

Congratulations, I think this 14.15 Mpps is as close to wirespeed as it
possible on your hardware.

BTW what CPU are you using?

> There is a warning from DMA mapping code but ;)

It is a warning from IOMMU code?
It usually means there is a real DMA unmap bug (which we should fix).

--Jesper

