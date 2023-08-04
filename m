Return-Path: <bpf+bounces-6980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645D76FEF7
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61AD2825EF
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B3AD41;
	Fri,  4 Aug 2023 10:49:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A4A929;
	Fri,  4 Aug 2023 10:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677BC433C8;
	Fri,  4 Aug 2023 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691146184;
	bh=6wEAhsdKD605Kpg3pmFf+yAduxBEJdnh1zQ9VC2lH+Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HWD3/zqYL2D+G4Je/OVGF4ZX0qepzRs8cAalGTgD/1M3gd1oON28OHJ+cEk2gjdmR
	 d5pl63TF1E4YPNAhLXq58AJL4ZUsKdmoJhLMDnXA+p2G+I9Gf6+R5B6EQszD9XA9/1
	 b+cwGTNyrcoSkrLmKllZoF+ThD0t2sO4gtkecfF63NTCeVKKpOdjixNjbAsZnlWo5p
	 b9f00O44jqmbczxwg6818cY+ZG9a4ixjGXwazv2gZ8ArbYcHUgSEyAD9kuwLHtO66A
	 r7yzjcp9sE6yoaXGzfehBQl712NJVBCgRKkM7LFDLDekMkU1/ur6AUmMItCQdsUuuT
	 Gw+sHFTOuKQ+w==
Message-ID: <7d159ee4-7361-c04a-681e-1afc74765c5b@kernel.org>
Date: Fri, 4 Aug 2023 12:49:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
 wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
References: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
 <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 03.44, Jesse Brandeburg wrote:
> On 8/2/2023 11:07 AM, Haiyang Zhang wrote:
>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>> usage.
>>

Can you add some info on the performance improvement this patch gives?

Your previous post mentioned:
 > With iperf and 128 threads test, this patch improved the throughput 
by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to 
10-50%.


>> The standard page pool API is used.
>>
>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>> ---
>> V5:
>> In err path, set page_pool_put_full_page(..., false) as suggested by
>> Jakub Kicinski
>> V4:
>> Add nid setting, remove page_pool_nid_changed(), as suggested by
>> Jesper Dangaard Brouer
>> V3:
>> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
>> V2:
>> Use the standard page pool API as suggested by Jesper Dangaard Brouer
>> ---
> 
>> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
>> index 024ad8ddb27e..b12859511839 100644
>> --- a/include/net/mana/mana.h
>> +++ b/include/net/mana/mana.h
>> @@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
>>   	struct gdma_wqe_request wqe_req;
>>   
>>   	void *buf_va;
>> +	bool from_pool; /* allocated from a page pool */
> 
> suggest you use flags and not bools, as bools waste 7 bits each, plus
> your packing of this struct will be full of holes, made worse by this
> patch. (see pahole tool)
> 

Agreed.

> 
>>   
>>   	/* SGL of the buffer going to be sent has part of the work request. */
>>   	u32 num_sge;
>> @@ -330,6 +331,8 @@ struct mana_rxq {
>>   	bool xdp_flush;
>>   	int xdp_rc; /* XDP redirect return code */
>>   
>> +	struct page_pool *page_pool;
>> +
>>   	/* MUST BE THE LAST MEMBER:
>>   	 * Each receive buffer has an associated mana_recv_buf_oob.
>>   	 */
> 
> 
> The rest of the patch looks ok and is remarkably compact for a
> conversion to page pool. I'd prefer someone with more page pool exposure
> review this for correctness, but FWIW
 >

Both Jakub and I have reviewed the page_pool parts, and I think we are
in a good place.

Looking at the driver, I wonder why you are keeping the driver local
memory cache (when PP is also contains a memory cache) ?
(I assume there is a good reason, so this is not blocking patch)

> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Thanks for taking your time to review.

I'm ready to ACK once the description is improved a bit :-)

--Jesper
pw-bot: cr

