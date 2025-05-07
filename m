Return-Path: <bpf+bounces-57713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C38AAED84
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6083BBBDD
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F928FFCB;
	Wed,  7 May 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDUi6ys7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45F28F930;
	Wed,  7 May 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651523; cv=none; b=VMGgnvqqmz/6nEG0gzqy5k05k9x9wEtYXC2s951e5SmO0j9ysMJgLyNBPZGluBquivMVJEPUc0aAwMSzT5HdoAGv0lsLfGDXDWkr9+NKhp1rDIIbRDo5YWf5knpcB9U+bXG8uAnxDXjjHLtQ28kOeWu66WeSOMOESHR2ngXGw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651523; c=relaxed/simple;
	bh=mdg9PRWN4cq2FGKqhaePByKFmIZPYYxT7Jr2c7f5fxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8xiA0O3yp7LnHq4MLRXPFJY6pgcin+SZiuZhamiRoDLJlQjKnIZc1+c1tSLONGrt+Fu8RkIvfU3hEmi3AJu5JlFqnKdZjMiYwoIFrzIBmZKt+mccPYGSfq0kFJr0yjG97bxeTbmFVCW4R/LaN6wAGF7BgPkeQ7mzM5JkW09xuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDUi6ys7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69153C4CEE2;
	Wed,  7 May 2025 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746651520;
	bh=mdg9PRWN4cq2FGKqhaePByKFmIZPYYxT7Jr2c7f5fxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vDUi6ys7pZr49+eqFiJXYBqhtb7N1vvucMIA5yqItXEu8cvIDm3E7jgwgIlMLT/1D
	 PZxOVvnI5CA0lFt/8mRyyALkiwyfL01q4N3OutcgjoBnIMV0TaSM6jnvnVgbfyQ/Lt
	 gM8hkqnDcWI+NefPhadzqwi5LTgCCRhf4YJ8ZvR4STjA7XAyDX89giy/JiKQTdMjQK
	 T4Khos88Aqtaq1kclR4c5x0CeCLfNJYo7WECINhhtyo4hc3FVzdIvZ6R8XdZCRF+0e
	 OzNh14iCODTQi9Zxb45LHE9Gbbk9dHgOlVMXXcC45x6s1NpXy0ruHUUKf4n8CFNQAO
	 4qOoGF8FtJexA==
Message-ID: <b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
Date: Wed, 7 May 2025 22:58:33 +0200
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/05/2025 21.57, Jon Kohler wrote:
> 
> 
>> On May 7, 2025, at 3:04 PM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 07/05/2025 19.47, Jon Kohler wrote:
>>>> On May 7, 2025, at 1:21 PM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>>>>
>>>>
>>>> Jesper Dangaard Brouer wrote:
>>>>>
>>>>>
>>>>> On 07/05/2025 19.02, Zvi Effron wrote:
>>>>>> On Wed, May 7, 2025 at 9:37 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 07/05/2025 15.29, Willem de Bruijn wrote:
>>>>>>>> Stanislav Fomichev wrote:
>>>>>>>>> On 05/06, Jon Kohler wrote:
>>>>>>>>>> Introduce new XDP helpers:
>>>>>>>>>> - xdp_headlen: Similar to skb_headlen
>>>>>>>
>>>>>>> I really dislike xdp_headlen(). This "headlen" originates from an SKB
>>>>>>> implementation detail, that I don't think we should carry over into XDP
>>>>>>> land.
>>>>>>> We need to come up with something that isn't easily mis-read as the
>>>>>>> header-length.
>>>>>>
>>>>>> ... snip ...
>>>>>>
>>>>>>>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer
>>>>>>
>>>>>> How about xdp_datalen()?
>>>>>
>>>>> Yes, I like xdp_datalen() :-)
>>>>
>>>> This is confusing in that it is the inverse of skb->data_len:
>>>> which is exactly the part of the data not in the skb head.
>>>>
>>>> There is value in consistent naming. I've never confused headlen
>>>> with header len.
>>>>
>>>> But if diverging, at least let's choose something not
>>>> associated with skbs with a different meaning.
>>> Brainstorming a few options:
>>> - xdp_head_datalen() ?
>>> - xdp_base_datalen() ?
>>> - xdp_base_headlen() ?
>>> - xdp_buff_datalen() ?
>>> - xdp_buff_headlen() ?
>>> - xdp_datalen() ? (ZivE, JesperB)
>>> - xdp_headlen() ? (WillemB, JonK, StanislavF, JacobK, DanielB)
>>
>> What about keeping it really simple: xdp_buff_len() ?
> 
> This is suspiciously close to xdp_get_buff_len(), so there could be some
> confusion there, since that takes paged/frags into account transparently.

Good point.

>>
>> Or even simpler: xdp_len() as the function documentation already
>> describe this doesn't include frags.
> 
> There is a neat hint from Lorenzo’s change in bpf.h for bpf_xdp_get_buff_len()
> that talks about both linear and paged length. Also, xdp_buff_flags’s
> XDP_FLAGS_HAS_FRAGS says non-linear xdp buff.
> 
> Taking those hints, what about:
> xdp_linear_len() == xdp->data_end - xdp->data
> xdp_paged_len() == sinfo->xdp_frags_size
> xdp_get_buff_len() == xdp_linear_len() + xdp_paged_len()
> 

I like xdp_linear_len() as it is descriptive/clear.


> Just a thought. If not, that’s ok. I’m happy to do xdp_len, but do you then have a
> suggestion about getting the non-linear size only?
>

I've not checked if we have API users that need to get the non-linear 
size only...

A history rant:
XDP started out as being limited to one-page ("packet-pages" was my
original bad name).  With a fixed XDP_HEADROOM of 256 bytes and reserved
tailroom of 320 bytes sizeof(skb_shared_info) to be compatible with
creating an SKB (that can use this as a "head" page).  Limiting max MTU
to be 3502 (assuming Eth(14)+2 VLAN headers=18).
These constraints were why XDP was so fast.  As time goes on we continue
to add features and performance paper-cuts. Today, XDP_HEADROOM have
become variable, leading to checks all over.  With XDP multi-buffer
support getting more features, we also have to add check all over for that.
WARNING to end-users: XDP programs that use xdp.frags and the associated
helpers are really SLOW (as these helper need to copy out data to stack
or elsewhere).  XDP is only fast if your XDP prog read the linear path
with the older helpers (direct access) and ignore if packet have frags.
We are slowly but surely making XDP slower and slower by paper-cuts.
Guess, we should clearly document that, such that people don't think XDP
multi-buffer access is fast.  Sorry for the rant.


>>
>> To Jon, you seems to be on a cleanup spree:
>> For SKBs netstack have this diagram documented [1].  Which also explains
>> the concept of a "head" buffer, which isn't a concept for XDP.  I would
>> really like to see a diagram documenting both xdp_buff and xdp_frame
>> data structures via ascii art, like the one for SKBs. (Hint, this is
>> actually defined in the header file include/linux/skbuff.h, but
>> converted to RST/HTML format.)
>>
>> [1] https://docs.kernel.org/networking/skbuff.html
> 
> I certainly am in a cleanup sort of mood, happy to help here. I see what
> you're talking about, I’ll take a stab at this in a separate patch. Thanks
> for the push and tip!

Thanks for the cleanups.
--Jesper

