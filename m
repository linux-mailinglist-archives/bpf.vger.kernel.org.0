Return-Path: <bpf+bounces-57698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD3AAEB3D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58171C08BC4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CE28E56F;
	Wed,  7 May 2025 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhRh0Bgp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2F28BA9F;
	Wed,  7 May 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644698; cv=none; b=gSBqzQ9BS6i2iBgMn6ta6RXCr/79osjVLCFoaiLHtIIBroXOlr+AmXmwv2Sr9AhfzWJuWaDfTLLLbIRGrVhwwbE1BfsApZ0OcLvanK/tHVg9kNrj2SuqA7xRET8SoCYkBjDBhNXA7amPaYJmxrH52Itlmp6T/ykRwSZucbxOcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644698; c=relaxed/simple;
	bh=CRCiIABz/kFgdTeK7BF7RrV6jJF7IbV0KFOhjFLNr0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eld+dsa8vz31mjm/uGV8UsUEuJI7MuxokMO7baw4Prxk7gIF/LPDnqBQjnw6wVdqC6Ulvp8/b2tuDOb944sDTVRv9t4Aq7jx0Ne433apCfNBRsfm4Im9u2XFQGBWzwbfdLg5Pcp09XRO+JxEPXdtP4srOMR29N/u4WZwcAv9smY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhRh0Bgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D653FC4CEE2;
	Wed,  7 May 2025 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746644698;
	bh=CRCiIABz/kFgdTeK7BF7RrV6jJF7IbV0KFOhjFLNr0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lhRh0BgpAtDuVzNTHwJeeIpZV8B/fvJdYcifpSbxeLTlR4qy4A9r+y4pzZ8G8SwIq
	 CSIscRiuqpRioY9xkq9ah4CoAGvtS52bMQn/IrpYa6s5DtvDZvPe/BGr119Socc93Q
	 6LtsrF4ntJJJpjELtxY8qmqyAUP2mcsha+jHKZ9jLCxshFATtyP9oH1uaI3NbXkd2T
	 T4TOR34KmE6bNQZ6kdLnw1vR5X9dn/jLMYyUyAhtAm/j9yxUdf+b+PD738FEq85M/s
	 aUaS15NG0gL0jr7L671fyi3WPfSu8xB+Y4zsO83HLOjHfDFLXydEO+j5dFM8DnJwGI
	 cE1Z69pdf4/1w==
Message-ID: <e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
Date: Wed, 7 May 2025 21:04:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
To: Jon Kohler <jon@nutanix.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Zvi Effron <zeffron@riotgames.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jason Wang <jasowang@redhat.com>,
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/05/2025 19.47, Jon Kohler wrote:
> 
> 
>> On May 7, 2025, at 1:21 PM, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>>
>>
>> Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 07/05/2025 19.02, Zvi Effron wrote:
>>>> On Wed, May 7, 2025 at 9:37 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 07/05/2025 15.29, Willem de Bruijn wrote:
>>>>>> Stanislav Fomichev wrote:
>>>>>>> On 05/06, Jon Kohler wrote:
>>>>>>>> Introduce new XDP helpers:
>>>>>>>> - xdp_headlen: Similar to skb_headlen
>>>>>
>>>>> I really dislike xdp_headlen(). This "headlen" originates from an SKB
>>>>> implementation detail, that I don't think we should carry over into XDP
>>>>> land.
>>>>> We need to come up with something that isn't easily mis-read as the
>>>>> header-length.
>>>>
>>>> ... snip ...
>>>>
>>>>>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer
>>>>
>>>> How about xdp_datalen()?
>>>
>>> Yes, I like xdp_datalen() :-)
>>
>> This is confusing in that it is the inverse of skb->data_len:
>> which is exactly the part of the data not in the skb head.
>>
>> There is value in consistent naming. I've never confused headlen
>> with header len.
>>
>> But if diverging, at least let's choose something not
>> associated with skbs with a different meaning.
> 
> Brainstorming a few options:
> - xdp_head_datalen() ?
> - xdp_base_datalen() ?
> - xdp_base_headlen() ?
> - xdp_buff_datalen() ?
> - xdp_buff_headlen() ?
> - xdp_datalen() ? (ZivE, JesperB)
> - xdp_headlen() ? (WillemB, JonK, StanislavF, JacobK, DanielB)
> 

What about keeping it really simple: xdp_buff_len() ?

Or even simpler: xdp_len() as the function documentation already
describe this doesn't include frags.

To Jon, you seems to be on a cleanup spree:
For SKBs netstack have this diagram documented [1].  Which also explains
the concept of a "head" buffer, which isn't a concept for XDP.  I would
really like to see a diagram documenting both xdp_buff and xdp_frame
data structures via ascii art, like the one for SKBs. (Hint, this is
actually defined in the header file include/linux/skbuff.h, but
converted to RST/HTML format.)

[1] https://docs.kernel.org/networking/skbuff.html

--Jesper

