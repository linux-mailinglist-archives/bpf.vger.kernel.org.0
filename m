Return-Path: <bpf+bounces-57670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D91AAE76B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437583BC73C
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E428C2B0;
	Wed,  7 May 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7Qu/EDJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6191F7586;
	Wed,  7 May 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637725; cv=none; b=o2IatKiqF17fagbc5oAB8LOaa7/yw1tUY6/5IWcIRF/G96ihUVqOcRmrXLU+F4rsMTgCYKl+jTQSElxmsVaujEp83G8/KV/MVSI5S6IEdhV20kY07GVMWD4KGQZQdCUbY8YIgnAhm895J0DEd83DTQeda6fEsOaoxkohUvz8qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637725; c=relaxed/simple;
	bh=Jq9bflgMyv//ExGbdW2q5bnL262ltP3uzPizW6R3qgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfYZqvCGPBr5Tjr1O4Y51SNnOWeuskm5e2+4osLms+ubxKVZZKrpsvC5FHfEnWboPy9GsIlA0GbQb6cCvPuG7q/sW4t2wvoj1RrDoFs0qU3NiFlFvgIopEGLju03eN++/9wmYiOIlAkHuSF3rifT9Kde7dByRf/ul4xJX+z2QdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7Qu/EDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D120C4CEE2;
	Wed,  7 May 2025 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746637724;
	bh=Jq9bflgMyv//ExGbdW2q5bnL262ltP3uzPizW6R3qgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e7Qu/EDJig6b64oE/qqwoKYK9fSwUPPOSXLMM56GRafS+LNckWgaWgkQbvfMyNmXH
	 VrJGB002uH44KNM4HIKdInCOpxtAdwtQIKV666ZD+fF3Y04tT1DjZrW1qJY8WcIKwE
	 UX9D0Yr8aWD9VxZfS/v7j562BLp2c1ga71QoXBg9mtO0BcsWOeqJ+aBYojpNELyQ3u
	 D8hclkjDfymw3CSRW65O1lsBDxxTdNomGizR3NaKVtd4WwCb23fdUoWU9BGHVLtR3d
	 eCuahVLurdKoKssDrvzWZmnhnaeWTrMx3uB9C7m5uPeHSkx4iFO8X25S/GUkHuGo3/
	 HPZQOxm3Lug2A==
Message-ID: <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
Date: Wed, 7 May 2025 19:08:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
To: Zvi Effron <zeffron@riotgames.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jon Kohler <jon@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/05/2025 19.02, Zvi Effron wrote:
> On Wed, May 7, 2025 at 9:37 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 07/05/2025 15.29, Willem de Bruijn wrote:
>>> Stanislav Fomichev wrote:
>>>> On 05/06, Jon Kohler wrote:
>>>>> Introduce new XDP helpers:
>>>>> - xdp_headlen: Similar to skb_headlen
>>
>> I really dislike xdp_headlen(). This "headlen" originates from an SKB
>> implementation detail, that I don't think we should carry over into XDP
>> land.
>> We need to come up with something that isn't easily mis-read as the
>> header-length.
> 
> ... snip ...
> 
>>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer
> 
> How about xdp_datalen()?

Yes, I like xdp_datalen() :-)
--Jesper

> On Wed, May 7, 2025 at 9:37 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 07/05/2025 15.29, Willem de Bruijn wrote:
>>> Stanislav Fomichev wrote:
>>>> On 05/06, Jon Kohler wrote:
>>>>> Introduce new XDP helpers:
>>>>> - xdp_headlen: Similar to skb_headlen
>>
>> I really dislike xdp_headlen().  This "headlen" originates from an SKB
>> implementation detail, that I don't think we should carry over into XDP
>> land.
>> We need to come up with something that isn't easily mis-read as the
>> header-length.
>>
>>>>> - xdp_headroom: Similar to skb_headroom
>>>>> - xdp_metadata_len: Similar to skb_metadata_len
>>>>>
>>
>> I like naming of these.
>>
>>>>> Integrate these helpers into tap, tun, and XDP implementation to start.
>>>>>
>>>>> No functional changes introduced.
>>>>>
>>>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>>>>> ---
>>>>> v2->v3: Integrate feedback from Stanislav
>>>>> https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1794658-1-jon@nutanix.com/
>>>>
>>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>>
>>
>> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> pw: cr
>>

