Return-Path: <bpf+bounces-65664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE79B26BD4
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672A41CE5CBC
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B7D221FB6;
	Thu, 14 Aug 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdZYZAPh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F11C5486;
	Thu, 14 Aug 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187108; cv=none; b=PYSAIoRwn3JqDioEKtq27Gq5qQF/7pyxljwnRn/nSiOytGRX+/d0PD05IAOdSwfqj1yNsNDa0+fhfn76Gq3I3NGgX27xi52IfvFBBFBWmys1+I4e1hW8vK2+B23fAoYw3eApwwmlzuhH7H3sUDpaJI3VxFoOKqPSsIuaDwG6a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187108; c=relaxed/simple;
	bh=Y5BCUY/vfZOJE/H9WaGMwKhbW4Km+J9Jr+jMcFeKmaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5o4CndmYqe9G12fF1YVUZZVxpljlUh5trTLBY+Bvh+simREeRnry9sy3bZoMSHmMh1tA5utuUHPTaLZR9jEgotj56aCxKUs7IcW/soOz/0EK4qbyCWoHyFjmK//60URAiqKdllLC/K7sfxKd6jGTwJf5I4vXpVOYS0uN1Nx/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdZYZAPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5767FC4CEED;
	Thu, 14 Aug 2025 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755187107;
	bh=Y5BCUY/vfZOJE/H9WaGMwKhbW4Km+J9Jr+jMcFeKmaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JdZYZAPh1M8qq680u8pfMCh5XH71WAVCRZ5tr47DrGsgnX+sCL7rpO3cXA+JLS4PS
	 aMLWMXXec9SD0dWMHoIkigo7Ji3poUJI4PRQH2MUFjtqxtwHOvOitDWPWb8QgUbP+B
	 U5UDCDJIgCLrJVi/uv+aud+k1HG1p4IpJCnhYi4EO3XKAW+zpR56aQe5Zlg5QgQ/X6
	 JQ8yDH7P1qcVqXzm8DjtuR2AQ+4E9t03AOyEZ+LYL4LXYoFJp4GRWFpsMFtsNjTQQ9
	 DAc/8H+RN2ASV+dzOeoZWIO+9hRa4wqiYO+hX3hChT6VRHL5v14POkIxBMJkPjkTpL
	 oLvCjly3fnS7g==
Message-ID: <8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
Date: Thu, 14 Aug 2025 17:58:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mlx5_core memory management issue
To: Dragos Tatulea <dtatulea@nvidia.com>, Chris Arges
 <carges@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 tariqt@nvidia.com, saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3> <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
 <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
 <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
 <tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 16.42, Dragos Tatulea wrote:
> On Thu, Aug 14, 2025 at 01:26:37PM +0200, Jesper Dangaard Brouer wrote:
>>
>>
>> On 13/08/2025 22.24, Dragos Tatulea wrote:
>>> On Wed, Aug 13, 2025 at 07:26:49PM +0000, Dragos Tatulea wrote:
>>>> On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
>>>>> On 2025-08-12 16:25:58, Chris Arges wrote:
>>>>>> On 2025-08-12 20:19:30, Dragos Tatulea wrote:
>>>>>>> On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
>>>>>>>> On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
>>>>>>>>
>>>>>>>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>>>>>>>> index 482d284a1553..484216c7454d 100644
>>>>>>>>> --- a/kernel/bpf/devmap.c
>>>>>>>>> +++ b/kernel/bpf/devmap.c
>>>>>>>>> @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>>>>>>>>>            /* If not all frames have been transmitted, it is our
>>>>>>>>>             * responsibility to free them
>>>>>>>>>             */
>>>>>>>>> +       xdp_set_return_frame_no_direct();
>>>>>>>>>            for (i = sent; unlikely(i < to_send); i++)
>>>>>>>>>                    xdp_return_frame_rx_napi(bq->q[i]);
>>>>>>>>> +       xdp_clear_return_frame_no_direct();
>>>>>>>>
>>>>>>>> Why can't this instead just be xdp_return_frame(bq->q[i]); with no
>>>>>>>> "no_direct" fussing?
>>>>>>>>
>>>>>>>> Wouldn't this be the safest way for this function to call frame completion?
>>>>>>>> It seems like presuming the calling context is napi is wrong?
>>>>>>>>
>>>>>>> It would be better indeed. Thanks for removing my horse glasses!
>>>>>>>
>>>>>>> Once Chris verifies that this works for him I can prepare a fix patch.
>>>>>>>
>>>>>> Working on that now, I'm testing a kernel with the following change:
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>>>>> index 3aa002a47..ef86d9e06 100644
>>>>>> --- a/kernel/bpf/devmap.c
>>>>>> +++ b/kernel/bpf/devmap.c
>>>>>> @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>>>>>>            * responsibility to free them
>>>>>>            */
>>>>>>           for (i = sent; unlikely(i < to_send); i++)
>>>>>> -               xdp_return_frame_rx_napi(bq->q[i]);
>>>>>> +               xdp_return_frame(bq->q[i]);
>>>>>>    out:
>>>>>>           bq->count = 0;
>>>>>
>>>>> This patch resolves the issue I was seeing and I am no longer able to
>>>>> reproduce the issue. I tested for about 2 hours, when the reproducer usually
>>>>> takes about 1-2 minutes.
>>>>>
>>>> Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.
>>>>
>>
>> Looking at code ... there are more cases we need to deal with.
>> If simply replacing xdp_return_frame_rx_napi() with xdp_return_frame.
>>
>> The normal way to fix this is to use the helpers:
>>   - xdp_set_return_frame_no_direct();
>>   - xdp_clear_return_frame_no_direct()
>>
>> Because __xdp_return() code[1] via xdp_return_frame_no_direct() will
>> disable those napi_direct requests.
>>
>>   [1] https://elixir.bootlin.com/linux/v6.16/source/net/core/xdp.c#L439
>>
>> Something doesn't add-up, because the remote CPUMAP bpf-prog that redirects
>> to veth is running in cpu_map_bpf_prog_run_xdp()[2] and that function
>> already uses the xdp_set_return_frame_no_direct() helper.
>>
>>   [2] https://elixir.bootlin.com/linux/v6.16/source/kernel/bpf/cpumap.c#L189
>>
>> I see the bug now... attached a patch with the fix.
>> The scope for the "no_direct" forgot to wrap the xdp_do_flush() call.
>>
>> Looks like bug was introduced in 11941f8a8536 ("bpf: cpumap: Implement
>> generic cpumap") v5.15.
>>
> Nice! Thanks for looking at this! Will you send the patch separately?
> 

Yes, I will send the patch as an official patch.

I want to give both of you credit, so I'm considering adding these tags
to the patch description (WDYT):

Found-by: Dragos Tatulea <dtatulea@nvidia.com>
Reported-by: Chris Arges <carges@cloudflare.com>


>>>> As follow up work it would be good to have a way to catch this family of
>>>> issues. Something in the lines of the patch below.
>>>>
>>
>> Yes, please, we want something that can catch these kind of hard to find
>> bugs.
>>
> Will send a patch when I find some time.
>

Great! :-)

>>>> Thanks,
>>>> Dragos
>>>>
>>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>>> index f1373756cd0f..0c498fbd8df6 100644
>>>> --- a/net/core/page_pool.c
>>>> +++ b/net/core/page_pool.c
>>>> @@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>>>>    {
>>>>           lockdep_assert_no_hardirq();
>>>> +#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
>>>> +       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
>>> I meant to negate the condition here.
>>>
>>
>> The XDP code have evolved since the xdp_set_return_frame_no_direct()
>> calls were added.  Now page_pool keeps track of pp->napi and
>> pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
>> (and maybe it allows us to remove the no_direct helpers).
>>
> So you mean to drop the napi_direct flag in __xdp_return and let
> page_pool_put_unrefed_netmem() decide if direct should be used by
> page_pool_napi_local()?

Yes, something like that, but I would like Kuba/Jakub's input, as IIRC
he introduced the page_pool->cpuid and page_pool->napi.

There are some corner-cases we need to consider if they are valid.  If
cpumap get redirected to the *same* CPU as "previous" NAPI instance,
which then makes page_pool->cpuid match, is it then still valid to do
"direct" return(?).

--Jesper

