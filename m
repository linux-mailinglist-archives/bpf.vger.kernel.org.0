Return-Path: <bpf+bounces-65284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2822B1F03E
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B2D7AC817
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311402222C8;
	Fri,  8 Aug 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEeY/Q2I"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5301EA91
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754688714; cv=none; b=r+9C3O5jnE4OexVLGPDTXsrvN0pVcJXHhosHSy1YqAhf/O0VGIvKFE9U3ypXSZbmpVL2meIawaEjueCaClKHrPWkCGzhiWtciv6hU9vT8re7qluw95kwMTxMinMlqGKxFp/SFQuTxlPhz2xw44WVE9W5TnVBd9jWK6CEOvuquwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754688714; c=relaxed/simple;
	bh=SZz6YrdANxo2wtVekMvJalu96H0sxblAmKiPlZuVZd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSzQPZVzjXNS/rD6md2JClqiBsDMNuBXtGTcCRpU1rh6T3+69oiw7ptYsMsfUBiaGg8qvdCdDc+g6058p9gQV5x08g84EDkzS8gvcXuH7IrE+DZ9CbI7NZIZIHFh0IaHuzosMZdENzMV879z588nc8frvuBm22A2fEvzx+glqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEeY/Q2I; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754688700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy1OHQn7a5mHql5BsO+HMy70fvmaW3m2Pja8vp+9DMU=;
	b=iEeY/Q2I8GwwRClmOrXUu+XjsYzrjQ47UrRmiiwh0quB+ga9T5mmRMMOq08RJG5/KkTc/q
	nFDCihZTT1vdvZjTDEsBJgA8CJR0fYx6HAW4CDjHidMX70XLt6fSFipRkmOakYtSaO5Q0y
	vflz3SA6Fgjo13LPm4srDIx1hIRKO2w=
Date: Fri, 8 Aug 2025 14:31:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
 <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
 <7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
 <87h5yi82gp.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87h5yi82gp.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/8/25 4:41 AM, Jakub Sitnicki wrote:
> On Thu, Aug 07, 2025 at 05:33 PM -07, Martin KaFai Lau wrote:
>> On 8/4/25 5:52 AM, Jakub Sitnicki wrote:
>>> +/* Check that skb_meta dynptr is empty */
>>> +SEC("tc")
>>> +int ing_cls_dynptr_empty(struct __sk_buff *ctx)
>>> +{
>>> +	struct bpf_dynptr data, meta;
>>> +	struct ethhdr *eth;
>>> +
>>> +	bpf_dynptr_from_skb(ctx, 0, &data);
>>> +	eth = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*eth));
>>
>> If this is bpf_dynptr_slice() instead of bpf_dynptr_slice_rdwr() and...
>>
>>> +	if (!eth)
>>> +		goto out;
>>> +	/* Ignore non-test packets */
>>> +	if (eth->h_proto != 0)
>>> +		goto out;
>>> +	/* Packet write to trigger unclone in prologue */
>>> +	eth->h_proto = 42;
>>
>> ... remove this eth->h_proto write.
>>
>> Then bpf_dynptr_write() will succeed. like,
>>
>>          bpf_dynptr_from_skb(ctx, 0, &data);
>>          eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
>> 	if (!eth)
>>                  goto out;
>>
>> 	/* Ignore non-test packets */
>>          if (eth->h_proto != 0)
>> 		goto out;
>>
>>          bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>>          /* Expect write to fail because skb is a clone. */
>>          err = bpf_dynptr_write(&meta, 0, (void *)eth, sizeof(*eth), 0);
>>
>> The bpf_dynptr_write for a skb dynptr will do the pskb_expand_head(). The
>> skb_meta dynptr write is only a memmove. It probably can also do
>> pskb_expand_head() and change it to keep the data_meta.
>>
>> Another option is to set the DYNPTR_RDONLY_BIT in bpf_dynptr_from_skb_meta() for
>> a clone skb. This restriction can be removed in the future.
> 
> Ah, crap. Forgot that bpf_dynptr_write->bpf_skb_store_bytes calls
> bpf_try_make_writable(skb) behind the scenes.
> 
> OK, so the head page copy for skb clone happens either in BPF prologue
> or lazily inside bpf_dynptr_write() call today.
> 
> Best if I make it consistent for skb_meta from the start, no?
> 
> Happy to take a shot at tweaking pskb_expand_head() to keep the metadata
> in tact, while at it.

There is no write helper for the data_meta now. It must directly write to 
skb->data_meta, so data_meta is a read-only for a clone now. I guess the current 
use case is mostly for tc to read the data_meta immediately after the xdp prog 
has added it (fwiw, it is how we tried to use it also), so it is usually not a 
clone (?). Not even sure if it currently has a write use case considering, 1) 
there is no bpf_"skb"_adjust_meta, and 2) the upper layer cannot use it.

No strong opinion to either copy the metadata on a clone or set the dynptr 
rdonly for a clone. I am ok with either way.

A brain dump:
On one hand, it is hard to comment without visibility on how will it look like 
when data_meta can be preserved in the future, e.g. what may be the overhead but 
there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is 
some flexibility. On the other hand, having a copy will be less surprise on the 
clone skb like what we have discovered in this and the earlier email thread but 
I suspect there is actually no write use case on the skb data_meta now.


