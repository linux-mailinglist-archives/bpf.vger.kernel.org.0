Return-Path: <bpf+bounces-32724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B5912674
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5C1284767
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BB1553BF;
	Fri, 21 Jun 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WweC6dPU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07915444C;
	Fri, 21 Jun 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975616; cv=none; b=h3zPKd3KZYl4ESdqwUZVgMRwoLq4C5UVxAULJSlTB+9dj7UHYlfSFa3ImHL0696yXyD+TRLE3lNY2+pCeBdPizKVeXB9XNUWsEZf8CM9rE96O8vfVwAUYv1hfA652fn/t+i79w9na9ZM7R6Ivff+hVeoFvbw0x1vcGE9W1eSuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975616; c=relaxed/simple;
	bh=WQsisy3R83VOdcBN5ISga9KLt1DhdQDaVlt49Nw2AZE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aSefwhVd0rNGhuinUqMUrUFSLtArN477fDcYsSZNJnFLOCltZsZ7CEfiJt7Ywhx+FoeS9pg6gtz4Tp3FMKBHmWid6C7I8CP9DpbaVvRH13ZfpjU6euIcElKU2UwRJ/4aZjP2S9WM/OwsgRD+D0DTbAN3UEsAjKuEJSb2QAB3x6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WweC6dPU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=b29xoMgpaZYss8C1W6FlfyXZaKncrRZNVZcstAF/Ncg=; b=WweC6dPUYHi8DEVygI3BSkBQmQ
	Ae7doyUsfR9TzH6E1g77VsjyTNxEYnc0nDKgESK1+avBGUYJz9RRo3yxsk2lZBbrVyp5ZzAHLTOOt
	WC5dLrl4TLmItYcrp1oQ3shB3jZCmoo45ZyT2C+BXSqoSraTgs1fuWJh1+X4u/MqYoVNtmrnRW0VP
	ANCq0ruG86bxmleHhW6s4BqhtRhwomsYZAMdRM3osz/Y/TTjoTJn3cHn2q4QuvQ0SqrBH3aibM7NP
	oEnLSzpI7FlrXZAU1za2Ixd48OJ2PGCA/0b4SncUWvLFM4p6L1ixyc8a+7TDnYyQraZGgaZNkxP3P
	DxMpAong==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKdg7-0003iB-W7; Fri, 21 Jun 2024 14:47:44 +0200
Received: from [178.197.248.18] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKdg7-000Kcg-0M;
	Fri, 21 Jun 2024 14:47:42 +0200
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, Mina Almasry <almasrymina@google.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 David Howells <dhowells@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Ahern <dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>,
 Antoine Tenart <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net>
Date: Fri, 21 Jun 2024 14:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27313/Fri Jun 21 10:28:08 2024)

On 6/21/24 2:15 PM, Willem de Bruijn wrote:
> Yan Zhai wrote:
>> Software GRO is currently controlled by a single switch, i.e.
>>
>>    ethtool -K dev gro on|off
>>
>> However, this is not always desired. When GRO is enabled, even if the
>> kernel cannot GRO certain traffic, it has to run through the GRO receive
>> handlers with no benefit.
>>
>> There are also scenarios that turning off GRO is a requirement. For
>> example, our production environment has a scenario that a TC egress hook
>> may add multiple encapsulation headers to forwarded skbs for load
>> balancing and isolation purpose. The encapsulation is implemented via
>> BPF. But the problem arises then: there is no way to properly offload a
>> double-encapsulated packet, since skb only has network_header and
>> inner_network_header to track one layer of encapsulation, but not two.
>> On the other hand, not all the traffic through this device needs double
>> encapsulation. But we have to turn off GRO completely for any ingress
>> device as a result.
>>
>> Introduce a bit on skb so that GRO engine can be notified to skip GRO on
>> this skb, rather than having to be 0-or-1 for all traffic.
>>
>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>> ---
>>   include/linux/netdevice.h |  9 +++++++--
>>   include/linux/skbuff.h    | 10 ++++++++++
>>   net/Kconfig               | 10 ++++++++++
>>   net/core/gro.c            |  2 +-
>>   net/core/gro_cells.c      |  2 +-
>>   net/core/skbuff.c         |  4 ++++
>>   6 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index c83b390191d4..2ca0870b1221 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -2415,11 +2415,16 @@ struct net_device {
>>   	((dev)->devlink_port = (port));				\
>>   })
>>   
>> -static inline bool netif_elide_gro(const struct net_device *dev)
>> +static inline bool netif_elide_gro(const struct sk_buff *skb)
>>   {
>> -	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
>> +	if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
>>   		return true;
>> +
>> +#ifdef CONFIG_SKB_GRO_CONTROL
>> +	return skb->gro_disabled;
>> +#else
>>   	return false;
>> +#endif
> 
> Yet more branches in the hot path.
> 
> Compile time configurability does not help, as that will be
> enabled by distros.
> 
> For a fairly niche use case. Where functionality of GRO already
> works. So just a performance for a very rare case at the cost of a
> regression in the common case. A small regression perhaps, but death
> by a thousand cuts.

Mentioning it here b/c it perhaps fits in this context, longer time ago
there was the idea mentioned to have BPF operating as GRO engine which
might also help to reduce attack surface by only having to handle packets
of interest for the concrete production use case. Perhaps here meta data
buffer could be used to pass a notification from XDP to exit early w/o
aggregation.

