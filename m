Return-Path: <bpf+bounces-32913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4A914EAB
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106828393A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32BF144D15;
	Mon, 24 Jun 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Fl17fSLT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038BFC08;
	Mon, 24 Jun 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235818; cv=none; b=hTzx75bGAnoOYLRNSdhnWTnr16Nq0ChbaPnVh59LRiS9aFXNPPaFb5//yBuQur8ge4WImJgRCkQuQ9vHhhu21lyQlnG6/fSdGZvT9dDQ47vPUdCG1+Ci4uo4CFA4mpSQtTqrdzZSZH2iHuRY09rHa0T5pAFHDl/pCa/n1MR902k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235818; c=relaxed/simple;
	bh=HccfLGLs+2vAsVTdnhMXqed4ZyzI1sE4rwYvGiswFz0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G9FJX2ZePEjSzHbI6/rPoAhGFITSCIoBjA2qFTyhxhOV2FHJgmjASkkzkSUhd0b9WTa1zOIj+WLzMA93/w6TdNRyC3O/6SsW43usneXapTMekSYwMbb5ACrns6evbtj4T7VVu+qCz7a3sGR29rUDAnQiAmXPAGMRjedHmLmXryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Fl17fSLT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZMMmxbunf9noBGfoICHMb7iWweKWqqDXgeAEpAAQEoc=; b=Fl17fSLTHbjN96GEtB+/joCKBa
	tDhZfM6AAJlbovMNDQhaBLH5QKmja+3kOINAmRUWn2ShLXtptr7gJhY0ogLKLrZN8Dx38iOsupt7H
	ew3tgsvhmDUbXbJqqek4kENIlHLLiaDvhw5XSYdwX6qpNfZpf/yP5JgkFEjTT4Ehv81lKJKtbLUL6
	01bMLZrteKKfqTmzSiBcZE/ZS82rKH+yn0uDV0JAeYgerqAoLfmMzjrti7ZfBFSNym2/sQTarrQBU
	P3tz/Bb2zVTlCA7+1RyVMo7sf91ef0aaoF+DdEF72+6kMXJUCuuWuxs09q72ME6BnnPIstSAe1i1b
	Cb7OEh2g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sLjlt-000Nfq-3P; Mon, 24 Jun 2024 15:30:13 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sLjlt-0000YL-0v;
	Mon, 24 Jun 2024 15:30:12 +0200
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net>
 <CAO3-PbrhnvmdYmQubNsTX3gX917o=Q+MBWTBkxUd=YWt4dNGuA@mail.gmail.com>
 <e6553be1-4eaa-e90a-17f8-dece2bb95e7b@iogearbox.net>
 <CAO3-PboYruuLrF7D_rMiuG-AnWdR4BhsgP+MhVmOm-f3MzJFyQ@mail.gmail.com>
 <6677db8b2ef78_33522729492@willemb.c.googlers.com.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <caecbff8-ffc4-976b-4516-dba41848ef30@iogearbox.net>
Date: Mon, 24 Jun 2024 15:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6677db8b2ef78_33522729492@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27316/Mon Jun 24 10:26:29 2024)

On 6/23/24 10:23 AM, Willem de Bruijn wrote:
> Yan Zhai wrote:
>> On Fri, Jun 21, 2024 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 6/21/24 6:00 PM, Yan Zhai wrote:
>>>> On Fri, Jun 21, 2024 at 8:13 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> On 6/21/24 2:15 PM, Willem de Bruijn wrote:
>>>>>> Yan Zhai wrote:
>>>>>>> Software GRO is currently controlled by a single switch, i.e.
>>>>>>>
>>>>>>>      ethtool -K dev gro on|off
>>>>>>>
>>>>>>> However, this is not always desired. When GRO is enabled, even if the
>>>>>>> kernel cannot GRO certain traffic, it has to run through the GRO receive
>>>>>>> handlers with no benefit.
>>>>>>>
>>>>>>> There are also scenarios that turning off GRO is a requirement. For
>>>>>>> example, our production environment has a scenario that a TC egress hook
>>>>>>> may add multiple encapsulation headers to forwarded skbs for load
>>>>>>> balancing and isolation purpose. The encapsulation is implemented via
>>>>>>> BPF. But the problem arises then: there is no way to properly offload a
>>>>>>> double-encapsulated packet, since skb only has network_header and
>>>>>>> inner_network_header to track one layer of encapsulation, but not two.
>>>>>>> On the other hand, not all the traffic through this device needs double
>>>>>>> encapsulation. But we have to turn off GRO completely for any ingress
>>>>>>> device as a result.
>>>>>>>
>>>>>>> Introduce a bit on skb so that GRO engine can be notified to skip GRO on
>>>>>>> this skb, rather than having to be 0-or-1 for all traffic.
>>>>>>>
>>>>>>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>>>>>>> ---
>>>>>>>     include/linux/netdevice.h |  9 +++++++--
>>>>>>>     include/linux/skbuff.h    | 10 ++++++++++
>>>>>>>     net/Kconfig               | 10 ++++++++++
>>>>>>>     net/core/gro.c            |  2 +-
>>>>>>>     net/core/gro_cells.c      |  2 +-
>>>>>>>     net/core/skbuff.c         |  4 ++++
>>>>>>>     6 files changed, 33 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>>> index c83b390191d4..2ca0870b1221 100644
>>>>>>> --- a/include/linux/netdevice.h
>>>>>>> +++ b/include/linux/netdevice.h
>>>>>>> @@ -2415,11 +2415,16 @@ struct net_device {
>>>>>>>        ((dev)->devlink_port = (port));                         \
>>>>>>>     })
>>>>>>>
>>>>>>> -static inline bool netif_elide_gro(const struct net_device *dev)
>>>>>>> +static inline bool netif_elide_gro(const struct sk_buff *skb)
>>>>>>>     {
>>>>>>> -    if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
>>>>>>> +    if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
>>>>>>>                return true;
>>>>>>> +
>>>>>>> +#ifdef CONFIG_SKB_GRO_CONTROL
>>>>>>> +    return skb->gro_disabled;
>>>>>>> +#else
>>>>>>>        return false;
>>>>>>> +#endif
>>>>>>
>>>>>> Yet more branches in the hot path.
>>>>>>
>>>>>> Compile time configurability does not help, as that will be
>>>>>> enabled by distros.
>>>>>>
>>>>>> For a fairly niche use case. Where functionality of GRO already
>>>>>> works. So just a performance for a very rare case at the cost of a
>>>>>> regression in the common case. A small regression perhaps, but death
>>>>>> by a thousand cuts.
>>>>>
>>>>> Mentioning it here b/c it perhaps fits in this context, longer time ago
>>>>> there was the idea mentioned to have BPF operating as GRO engine which
>>>>> might also help to reduce attack surface by only having to handle packets
>>>>> of interest for the concrete production use case. Perhaps here meta data
>>>>> buffer could be used to pass a notification from XDP to exit early w/o
>>>>> aggregation.
>>>>
>>>> Metadata is in fact one of our interests as well. We discussed using
>>>> metadata instead of a skb bit to carry this information internally.
>>>> Since metadata is opaque atm so it seems the only option is to have a
>>>> GRO control hook before napi_gro_receive, and let BPF decide
>>>> netif_receive_skb or napi_gro_receive (echo what Paolo said). With BPF
>>>> it could indeed be more flexible, but the cons is that it could be
>>>> even more slower than taking a bit on skb. I am actually open to
>>>> either approach, as long as it gives us more control on when to enable
>>>> GRO :)
>>>
>>> Oh wait, one thing that just came to mind.. have you tried u64 per-CPU
>>> counter map in XDP? For packets which should not be GRO-aggregated you
>>> add count++ into the meta data area, and this forces GRO to not aggregate
>>> since meta data that needs to be transported to tc BPF layer mismatches
>>> (and therefore the contract/intent is that tc BPF needs to see the different
>>> meta data passed to it).
>>
>> We did this before accidentally (we put a timestamp for debugging
>> purposes in metadata) and this actually caused about 20% of OoO for
>> TCP in production: all PSH packets are reordered. GRO does not fire
>> the packet to the upper layer when a diff in metadata is found for a
>> non-PSH packet, instead it is queued as a “new flow” on the GRO list
>> and waits for flushing. When a PSH packet arrives, its semantic is to
>> flush this packet immediately and thus precedes earlier packets of the
>> same flow.
> 
> Is that a bug in XDP metadata handling for GRO?
> 
> Mismatching metadata should not be taken as separate flows, but as a
> flush condition.

Definitely a bug as it should flush. If noone is faster I can add it to my
backlog todo to fix it, but might probably take a week before I get to it.

Thanks,
Daniel

