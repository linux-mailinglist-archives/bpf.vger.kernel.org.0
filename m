Return-Path: <bpf+bounces-42272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7C9A1983
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 05:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA27B227E6
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F413B29B;
	Thu, 17 Oct 2024 03:51:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F022D05E;
	Thu, 17 Oct 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137113; cv=none; b=CCxvFb0j3vzK1BKxaszOc5a4wRD2gwrEaG7s6Pm7lupkzCcO80Te+uQ2LDhCWRspJ0Niaz2fYKd0slx1wePn5nsLCfTZVdugFGmztOqk6FJaQPbGKcbgaUG4U7ERjgif2H8iQaJ23wlPovEjytbpNzJ1d/4UhNAK+o7Tsy+xQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137113; c=relaxed/simple;
	bh=KBSmgoKWd/GgRU0uLa3i0Dqsp9OYyeb7JKqvvVU6VAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Btgt+SU9GPgJZyil0hw7evkZxcRbW+6ZkXRNlqOq4kkg42qKfSUmuIRzpB9HdqWCd9x9fVLZvCoFUJBoMbD+aiEiPdkCV99tgTflZCsMrqwK2qhYhfK2NcmJwpQm8SsWlJUy89N7yBDtG2rchaTm363HQ8cK2l1DxDkPvXViOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XTYlC605hz1j9v8;
	Thu, 17 Oct 2024 11:50:31 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C47291A0188;
	Thu, 17 Oct 2024 11:51:46 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 11:51:45 +0800
Message-ID: <4d80b2fd-17d8-a7bd-0e80-7d33c9764810@huawei.com>
Date: Thu, 17 Oct 2024 11:51:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<andre.guedes@intel.com>, <maciej.fijalkowski@intel.com>,
	<jithu.joseph@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
 <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/17 7:12, Jacob Keller wrote:
> 
> 
> On 10/16/2024 4:06 PM, Jacob Keller wrote:
>>
>>
>> On 10/16/2024 11:53 AM, Simon Horman wrote:
>>> On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
>>>> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
>>>> which is zero, this fix smatch warnings:
>>>> drivers/net/ethernet/intel/igc/igc_main.c:2533
>>>>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
>>>>
>>>> Fixes: 26575105d6ed ("igc: Add initial XDP support")
>>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>>>> index 6e70bca15db1..c3d6e20c0be0 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>>> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>>>>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
>>>>  
>>>>  out:
>>>> -	return ERR_PTR(-res);
>>>> +	return res ? ERR_PTR(-res) : NULL;
>>>
>>> I think this is what PTR_ERR_OR_ZERO() is for.
>>
>> Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
>> extracting an error from a pointer. This is converting an error into a
>> pointer.
>>
>> I am not sure what is really expected here. If res is zero, shouldn't we
>> be returning an skb pointer and not NULL?
>>
>> Why does igc_xdp_run_prog even return a sk_buff pointer at all? It never
>> actually returns an skb...
>>
>> This feels like the wrong fix entirely.
>>
>> __igc_xdp_run_prog returns a custom value for the action, between
>> IGC_XDP_PASS, IGC_XDP_TX, IGC_XDP_REDIRECT, or IGC_XDP_CONSUMED.
>>
>> This function is called by igc_xdp_run_prog which converts this to a
>> negative error code with the sk_buff pointer type.
>>
>> All so that we can assign a value to the skb pointer in
>> ice_clean_rx_irq, and check it with IS_ERR
>>
>> I don't like this fix, I think we could drop the igc_xdp_run_prog
>> wrapper, call __igc_xdp_run_prog directly and check its return value
>> instead of this method of using an error pointer.
> 
> Indeed, this SKB error stuff was added by 26575105d6ed ("igc: Add
> initial XDP support") which claims to be aligning with other Intel drivers.
> 
> But the other Intel drivers just have a function that returns the xdp
> result and checks it directly.
>Thanks for review，maybe can fix this as commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")?

> Perhaps this is due to the way that the igc driver shares rings between
> XDP and the regular path?
> 
> Its not clear to me, but I think this fix is not what I would do.
> 
> .

