Return-Path: <bpf+bounces-27066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C78A8C3A
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C267281A66
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA892C6A3;
	Wed, 17 Apr 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-braunschweig.de header.i=@tu-braunschweig.de header.b="F3tKMa4K"
X-Original-To: bpf@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18A2134B
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382741; cv=none; b=AJvyGtTRa9YC342KmLSHmYgi+IfNz7VySWfX3l9aOrVigIqRRxsJJ0PtY1nrvwjxcMiW3yGCMQ2x8W1VqBAmWP6XhX5z8e6kQBXsSyDtg2C9UAhRGpU+BIMjp6Gjlry76SFNEABsqCel07iUHPIzXCnr8EGnRYkXL9uHGqXghWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382741; c=relaxed/simple;
	bh=kGLQLDCQCtC+DekK+q91lBmyfdhGiXvS78w78Y99IpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/4uPsJuHPJFCa8XxtPeWbLuZaVqMaHTxVAHHqtQnqAkXxaWtF/tFx1Xoc+nvlRnVTSyP/2CqvYSnjPn1lEs0fFGNh1qe1CMkOKgM5vY5+l62klOX1b5JoYeqZYWTCWBeitkenUnginEHQ0I9Sy2BVIf+cE78URENEitdOm28Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-braunschweig.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-braunschweig.de header.i=@tu-braunschweig.de header.b=F3tKMa4K; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-braunschweig.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes12.ad.tu-bs.de (hermes12.rz.tu-bs.de [134.169.4.140])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id EB6D34E034E;
	Wed, 17 Apr 2024 21:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-braunschweig.de;
	s=exchange_neu; t=1713382729;
	bh=kGLQLDCQCtC+DekK+q91lBmyfdhGiXvS78w78Y99IpU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=F3tKMa4KT6jrQ+B6bo59HZkQjR2cVViT53rJYUuy1SiYMYqZfBDrBcxmEhAlLSOfu
	 j1U4EyfzSNuLobn+8xc86dhc4qWKzeD+9uCKi9D8QmJcSgmd5hf5V59F4mueQn2yQ4
	 lsZYkLUlqAm9ZeC0CrtM6TT8BO02o/EhSzDZfYisQCffw2nZC5ufkl9iSRlVCbzlpE
	 8Vddkz7ks+syVi/SNNMrTFntnUotxTqXS1zKOBpa476WHHWTV0Bpeksr17D8U1EZ9K
	 dyNrTjRNLKCbCNmbaJYi53Nj4pK7LdAdNmGmjQgJnwfQbfhP4WjFN7dshtjncUhCQn
	 FSbKzGNj8Qqqw==
Received: from [192.168.178.142] (134.169.9.110) by Hermes12.ad.tu-bs.de
 (134.169.4.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.32; Wed, 17 Apr
 2024 21:38:49 +0200
Message-ID: <9c019772-8c21-4eb5-908d-103f0966dc13@tu-braunschweig.de>
Date: Wed, 17 Apr 2024 21:38:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No direct copy from ctx to map possible, why?
To: Yonghong Song <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
 <4f62fa70-ac50-41ff-a685-db6c8aefb017@linux.dev>
 <6d224ee5-ca50-44a9-882e-074710bf8477@tu-braunschweig.de>
 <39a68b12-a921-471b-83ff-6d59b21aa4a9@linux.dev>
Content-Language: de-DE, en-US
From: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>
Autocrypt: addr=f.pfitzner@tu-braunschweig.de; keydata=
 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
In-Reply-To: <39a68b12-a921-471b-83ff-6d59b21aa4a9@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes04.ad.tu-bs.de (134.169.4.132) To
 Hermes12.ad.tu-bs.de (134.169.4.140)

> In your particular example, since you intend to copy xdp_md->data, you 
> can directly
> access that from xdp_md->data pointer, there is no need to copy ctx 
> which is not
> what you want. 
Thanks for your answer, but I think you misunderstood me. I need to 
store the packet's payload in a map (not the xdp_md structure itself), 
because my use case forces me to do so.

I write a program that reassembles split packets into a single one. 
Therefore I have to buffer packet fragments until all have been arrived. 
The only way in eBPF to realize such a buffer is a map, so I have to put 
the packet's payload in there. My problem is, that I have no clue how to 
do it properly as there is no direct way to put the payload into a map.

How would you put a packet with a size of 700 bytes into a map? What 
would be your strategy when you can only access your packet via the 
xdp_md structure? My strategy (and that's the best I have found so far) 
is to split this packet into two packets of size 350 bytes, so that I 
can process them on the stack consecutively.

On 4/16/24 5:22 AM, Yonghong Song wrote:
>
> On 4/15/24 1:25 PM, Fabian Pfitzner wrote:
>>> Looks like you intend to copy packet data. So from the above, 
>>> 'expected=fp,pkt,pkt_meta...', you can just put the first argument
>>> with xdp->data, right? 
>> Yes, I intend to copy packet data. What do you mean by "first 
>> argument"? I'd like to put the whole data that is depicted by 
>> xdp->data into a map that stores them as raw bytes (by using a char 
>> array as map element to store the data).
>
> Sorry, typo. 'first argument' should be 'third argument'.
>
>>
>>> Verifer rejects to 'ctx' since 'ctx' contents are subject to 
>>> verifier rewrite. So actual 'ctx' contents/layouts may not match 
>>> uapi definition. 
>> Sorry but I do not understand what you mean by "subject to verifier 
>> rewrite". What kind of rewrite happens when using the ctx as 
>> argument? Furthermore, am I correct that you assume that the uapi may 
>> dictate the structure of the data that can be stored in a map? How is 
>> it different to the case when first storing it on the stack and then 
>> putting it into a map?
>
> The UAPI xdp_md struct:
>
> struct xdp_md {
>         __u32 data;
>         __u32 data_end;
>         __u32 data_meta;
>         /* Below access go through struct xdp_rxq_info */
>         __u32 ingress_ifindex; /* rxq->dev->ifindex */
>         __u32 rx_queue_index;  /* rxq->queue_index  */
>
>         __u32 egress_ifindex;  /* txq->dev->ifindex */
> };
>
> The actual kernel representation of xdp_md:
>
> struct xdp_buff {
>         void *data;
>         void *data_end;
>         void *data_meta;
>         void *data_hard_start;
>         struct xdp_rxq_info *rxq;
>         struct xdp_txq_info *txq;
>         u32 frame_sz; /* frame size to deduce data_hard_end/reserved 
> tailroom*/
>         u32 flags; /* supported values defined in xdp_buff_flags */
> };
>
> You can see they are quite different. So to use pointee of 'ctx' as 
> the key, we
> need to allocate a space of sizeof(struct_md) to the stack and copy 
> necessary
> stuff to that structure. For example, xdp_md->ingress_ifindex = 
> xdp_buff->rxq->dev->ifindex, etc.
> Some fields actually does not make sense for copying, e.g., 
> data/data_end/data_meta in 64bit
> architecture. Since stack allocation is needed any way, so disabling 
> ctx and requires
> user explicit using stack make sense (if they want to use *ctx as map 
> update value).
>
> In your particular example, since you intend to copy xdp_md->data, you 
> can directly
> access that from xdp_md->data pointer, there is no need to copy ctx 
> which is not
> what you want.
>
>>
>> On 4/15/24 6:01 PM, Yonghong Song wrote:
>>>
>>> On 4/14/24 2:34 PM, Fabian Pfitzner wrote:
>>>> Hello,
>>>>
>>>> is there a specific reason why it is not allowed to copy data from 
>>>> ctx directly into a map via the bpf_map_update_elem helper?
>>>> I develop a XDP program where I need to store incoming packets 
>>>> (including the whole payload) into a map in order to buffer them.
>>>> I thought I could simply put them into a map via the mentioned 
>>>> helper function, but the verifier complains about expecting another 
>>>> type as "ctx" (R3 type=ctx expected=fp, pkt, pkt_meta, .....).
>>>
>>> Looks like you intend to copy packet data. So from the above, 
>>> 'expected=fp,pkt,pkt_meta...', you can just put the first argument
>>> with xdp->data, right?
>>> Verifer rejects to 'ctx' since 'ctx' contents are subject to 
>>> verifier rewrite. So actual 'ctx' contents/layouts may not match 
>>> uapi definition.
>>>
>>>>
>>>> I was able to circumvent this error by first putting the packet 
>>>> onto the stack (via xdp->data) and then write it into the map.
>>>> The only limitation with this is that I cannot store packets larger 
>>>> than 512 bytes due to the maximum stack size.
>>>>
>>>> I was also able to circumvent this by slicing chunks, that are 
>>>> smaller than 512 bytes, out of the packet so that I can use the 
>>>> stack as a clipboard before putting them into the map. This is a 
>>>> really ugly solution, but I have not found a better one yet.
>>>>
>>>> So my question is: Why does this limitation exist? I am not sure if 
>>>> its only related to XDP programs as this restriction is defined 
>>>> inside of the bpf_map_update_elem_proto struct (arg3_type restricts 
>>>> this), so I think it is a general limitation that affects all 
>>>> program types.
>>>>
>>>> Best regards,
>>>> Fabian Pfitzner
>>>>
>>>>
>>>>
>>>>
>>

