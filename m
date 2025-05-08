Return-Path: <bpf+bounces-57773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310DAB00CC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6211B9E5FFE
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E622284B2F;
	Thu,  8 May 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw+iZhll"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A7278E42;
	Thu,  8 May 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723601; cv=none; b=T0XsUdqBa1eXMP4mTnmxzwEiegh2Okz/b0qLStB2DHtoQNUIh3PhU322EZ4Oz4+y61Jst+sSZ2vuT9PWGq02gS05Qnt8muSUQ2MouOzokasSHDjWCBLU8zwkISVLzdqUq2Y6tpDfEd1TuOrGo/ljhrUtvSr/60sL3cL0PHkMzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723601; c=relaxed/simple;
	bh=+Ka9rQw2rJQtjCbggdFmFhBKb7v7zD+weIv/zWdBCFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTPx6sgy/lCs52yASktcEXY5e3F0DAbisx1x7ld/0uaNUwFr32FjioVEevCGRU91SEpkOYzkVphr39Yo8Z8xYGPNU78isrl4aHSCl0T0Kx016MtONl1VEMeGph6HMB2AtBpzEdioriJmzIA4Zr+a1pQBAShepBI0rt9OM3T4vVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw+iZhll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A98C4CEEB;
	Thu,  8 May 2025 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746723601;
	bh=+Ka9rQw2rJQtjCbggdFmFhBKb7v7zD+weIv/zWdBCFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zw+iZhlltYfFRLAYBj4A+NCyynTRu1LpOM4cJpmKK4XR/uaYcXClSLoQDgffCbcXW
	 3van7TqNKBpJP252o+x70ihXkIxVcZh6fdI6pkVzYCqr3QuqFzoSOM2TbGAKJtto6u
	 NzT2ZPDMsnN8mbDpVWOo5onjBWKIBRkqAUAEPbIVLLS8iWdNc1tHzIt49xOG5hqDeS
	 lbpejbhpmc+aDE/Vdu13ceJiSFlt3ImtvHsc2BFJ/RpfjhJ+xfhNfD77MZpGKI2D4k
	 syHDTQr5dIZFfC+hn9rqhn9OzDnFjHofVFpkKzFw68DNTBEQysatKsHNn5O7nq2XkB
	 fYSeYDVM31+XA==
Message-ID: <3fed59c6-e959-4863-b1c5-1927ef0d61df@kernel.org>
Date: Thu, 8 May 2025 18:59:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Stanislav Fomichev
 <stfomichev@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
 <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
 <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
 <B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
 <e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
 <6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
 <b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
 <B864BCB8-AEAE-4802-AB46-176D2CEEE862@nutanix.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <B864BCB8-AEAE-4802-AB46-176D2CEEE862@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 08/05/2025 05.18, Jon Kohler wrote:
> 
>> On May 7, 2025, at 4:58 PM, Jesper Dangaard Brouer<hawk@kernel.org>  wrote:
>>
>> On 07/05/2025 21.57, Jon Kohler wrote:
>>>> On May 7, 2025, at 3:04 PM, Jesper Dangaard Brouer<hawk@kernel.org>  wrote:
>>>>
>>>> On 07/05/2025 19.47, Jon Kohler wrote:
>>>>>> On May 7, 2025, at 1:21 PM, Willem de Bruijn<willemdebruijn.kernel@gmail.com>  wrote:
>>>>>>
>>>>>> Jesper Dangaard Brouer wrote:
>>>>>>>
>>>>>>> On 07/05/2025 19.02, Zvi Effron wrote:
>>>>>>>> On Wed, May 7, 2025 at 9:37 AM Jesper Dangaard Brouer<hawk@kernel.org>  wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 07/05/2025 15.29, Willem de Bruijn wrote:
>>>>>>>>>> Stanislav Fomichev wrote:
>>>>>>>>>>> On 05/06, Jon Kohler wrote:
>>>>>>>>>>>> Introduce new XDP helpers:
>>>>>>>>>>>> - xdp_headlen: Similar to skb_headlen
>>>>>>>>> I really dislike xdp_headlen(). This "headlen" originates from an SKB
>>>>>>>>> implementation detail, that I don't think we should carry over into XDP
>>>>>>>>> land.
>>>>>>>>> We need to come up with something that isn't easily mis-read as the
>>>>>>>>> header-length.
>>>>>>>> ... snip ...
>>>>>>>>
>>>>>>>>>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer
>>>>>>>> How about xdp_datalen()?
>>>>>>> Yes, I like xdp_datalen() 🙂
>>>>>> This is confusing in that it is the inverse of skb->data_len:
>>>>>> which is exactly the part of the data not in the skb head.
>>>>>>
>>>>>> There is value in consistent naming. I've never confused headlen
>>>>>> with header len.
>>>>>>
>>>>>> But if diverging, at least let's choose something not
>>>>>> associated with skbs with a different meaning.
>>>>> Brainstorming a few options:
>>>>> - xdp_head_datalen() ?
>>>>> - xdp_base_datalen() ?
>>>>> - xdp_base_headlen() ?
>>>>> - xdp_buff_datalen() ?
>>>>> - xdp_buff_headlen() ?
>>>>> - xdp_datalen() ? (ZivE, JesperB)
>>>>> - xdp_headlen() ? (WillemB, JonK, StanislavF, JacobK, DanielB)
>>>> What about keeping it really simple: xdp_buff_len() ?
>>> This is suspiciously close to xdp_get_buff_len(), so there could be some
>>> confusion there, since that takes paged/frags into account transparently.
>> Good point.
>>
>>>> Or even simpler: xdp_len() as the function documentation already
>>>> describe this doesn't include frags.
>>> There is a neat hint from Lorenzo’s change in bpf.h for bpf_xdp_get_buff_len()
>>> that talks about both linear and paged length. Also, xdp_buff_flags’s
>>> XDP_FLAGS_HAS_FRAGS says non-linear xdp buff.
>>> Taking those hints, what about:
>>> xdp_linear_len() == xdp->data_end - xdp->data
>>> xdp_paged_len() == sinfo->xdp_frags_size
>>> xdp_get_buff_len() == xdp_linear_len() + xdp_paged_len()
>> I like xdp_linear_len() as it is descriptive/clear.
 >
> Ok thanks, I’ll send out a v4 to codify that.

I'll ack a V4 with that change.

I do notice Jakub isn't a fan of the patch in general, but it seems
quite popular given the other high profile kernel developers that acked
in V3.  I think it increase code readability for people that are less
familiar with XDP code and meaning of the pointers (e.g. data_hard_start
vs. data_end vs. data vs. data_meta). (We don't even have some ascii art
showing these pointers).

--Jesper



