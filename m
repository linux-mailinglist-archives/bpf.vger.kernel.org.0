Return-Path: <bpf+bounces-78751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F377AD1AE98
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680F4301AD16
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EE352F95;
	Tue, 13 Jan 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwJQHrN8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A130352C3B;
	Tue, 13 Jan 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330381; cv=none; b=sC9iCtV0f4MGmF/OSnhqC0qG+xPznK3Hwn5ST/T8S4osUNapLsZHiU0TzquG8VKNomlgRyl/miw0Cph5iLKiZi5wslrBsf4G2+peCLNVsmWDMLDZVoGAwfkKd8jmeHknnEr5lGPvc/3cO42ApT0kM512hZoi3aj+kqQVRI12KDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330381; c=relaxed/simple;
	bh=IaYCk5AV+POZj/ED4ZWmEONB7R/2K+ZYIpDzpu9rJBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REczjSIIoeOpVLqjPZZMn694dhcQnuzAZR9Himc5KMob2ZeiWtDHpjb4zSCDpDqOAOt//OLTN3nhJJal+rpSxiqQ61GWAgET+9tWPLiU9omoMpzG57VeV+dzyis0BjxoO+SHMB9t3J3XeZu+G0yzJ0WhyvLj2AK/ZYnEDIlz8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwJQHrN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AE5C19422;
	Tue, 13 Jan 2026 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330380;
	bh=IaYCk5AV+POZj/ED4ZWmEONB7R/2K+ZYIpDzpu9rJBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YwJQHrN8/WZuVd8DEiONBEUw3GT0IYaD4s7Tvz+c73GT1hYAD1r6pXvjVCpoN/Fmw
	 6Dfgj8baImfprvw2MaH8bhtBOzgiSH9LeYnWLY4eUgKetq6LpRmCP+pQ4I3Pf1G5zd
	 aGIJRkSs4J5u/iCv4iuaT8MIQl5ek6tpsObbvokhmzxWUGvJgobIxcGSIhw5eMyrlo
	 aBRGzBNZod3cAZ+ubXUEwF/PAq+Ud1Wn7ur6kPCI0ceOALn5cxvFeW5kh9hF5lYt3i
	 MJ9V+3SN5EK1ZAszMGsXHXb7vv5A0nqNbni6n0aJgAc6msv8I8qFKczJpJdkHLOkIA
	 7DwMzal1Tkc+g==
Message-ID: <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
Date: Tue, 13 Jan 2026 19:52:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Willem Ferguson <wferguson@cloudflare.com>,
 Arthur Fabre <arthur@arthurfabre.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
 <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/01/2026 13.09, Paolo Abeni wrote:
> On 1/13/26 4:08 AM, Jakub Kicinski wrote:
>> On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
>>> This series is split out of [1] following discussion with Jakub.
>>>
>>> To copy XDP metadata into an skb extension when skb_metadata_set() is
>>> called, we need to locate the metadata contents.
>>
>> "When skb_metadata_set() is called"? I think that may cause perf
>> regressions unless we merge major optimizations at the same time?
>> Should we defer touching the drivers until we have a PoC and some
>> idea whether allocating the extension right away is manageable or
>> we are better off doing it via a kfunc in TC (after GRO)?
>> To be clear putting the metadata in an extension right away would
>> indeed be much cleaner, just not sure how much of the perf hit we
>> can optimize away..
> 
> I agree it would be better deferring touching the driver before we have
> proof there will not be significant regressions.

It will be a performance regression to (as cover-letter says):
  "To copy XDP metadata into an skb extension when skb_metadata_set() is 
called".
The XDP to TC-ingress code path is a fast-path IMHO.

*BUT* this patchset isn't doing that. To me it looks like a cleanup
patchset that simply makes it consistent when skb_metadata_set() called.
Selling it as a pre-requirement for doing copy later seems fishy.


> IIRC, at early MPTCP impl time, Eric suggested increasing struct sk_buff
> size as an alternative to the mptcp skb extension, leaving the added
> trailing part uninitialized when the sk_buff is allocated.
> 
> If skb extensions usage become so ubicuos they are basically allocated
> for each packet, the total skb extension is kept under strict control
> and remains reasonable (assuming it is :), perhaps we could consider
> revisiting the above mentioned approach?


I really like this idea.  As using the uninitialized tail room in the
SKB (memory area) will make SKB extensions fast.  Today SKBs are
allocated via SLUB-alloacator cache-aligned so the real size is 256
bytes.  On my system the actual SKB (sk_buff) size is 232 bytes (already
leaving us 24 bytes). The area that gets zero-initialized is only 192
bytes (3 cache-lines).  My experience with the SLUB allocator is that
increasing the object size doesn't increase the allocation cost (below
PAGE_SIZE).  So, the suggestion of simply allocating a larger sk_buff is
valid as it doesn't cost more (if we don't touch those cache-lines).  We
could even make it a CONFIG compile time option how big this area should be.

For Jakub this unfortunately challenge/breaks the design of keeping
data_meta area valid deeper into the netstack.  With all the challenges
around encapsulation/decap it seems hard/infeasible to maintain this
area in-front of the packet data pointer deeper into the netstack.

Instead of blindly copying XDP data_meta area into a single SKB
extension.  What if we make it the responsibility of the TC-ingress BPF-
hook to understand the data_meta format and via (kfunc) helpers
transfer/create the SKB extension that it deems relevant.
Would this be an acceptable approach that makes it easier to propagate
metadata deeper in netstack?

--Jesper

p.s. For compact storage of SKB extensions in the SKB tail-area, we
could revisit Arthur's "traits" (compact-KV storage).


