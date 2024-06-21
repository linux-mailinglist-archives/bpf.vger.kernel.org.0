Return-Path: <bpf+bounces-32720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BE9124DD
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5E2870AD
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB3150987;
	Fri, 21 Jun 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjrRL1lw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31E40861;
	Fri, 21 Jun 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972121; cv=none; b=QFPYIKmXsaCJZ0mpYpvnGbg/vbF0KmyH8WOLV4G61by709GhpN/tpP+mSoU/hcZE72eS1BZVyPpAlSO1glBQVU50hzcV75s2aW313OJQTNGWlqzQ7liG/PWkbmi1tZO3Y4xKf9CrPpKOUBDxQ2e9OzcAvdMgS1Do6RoaGyis9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972121; c=relaxed/simple;
	bh=cIPNiu/gEF0HK1CBHnIMlx3R04l5LgkBN4c4sNzkFzg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fIcmx+V1Cbz4JR1Yz0nq4aVXndubT+J7CDOn0foO8E8y2tqyXsX86Pn9qtYGjBt1x/Hq87rLfTx41rR/HWnavFuQBxupOy197txC2gc0lsPiDo3yjfDHcWap4dHJKKYpOrTT9EoQ/S0r39m01Lw5jPicS5gqEx+EpjyoLMaJCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjrRL1lw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7954dcf3158so112011185a.3;
        Fri, 21 Jun 2024 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718972119; x=1719576919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E6XacsjAwWDKM7tAVWRLWVOqk2WqIKzpAc0VY30v6o=;
        b=VjrRL1lw6kiGem2y5tzeeX7QuFqaLlZ6Kkdp7njOQK/OS77W/Z+Nx2tc1jouC1U/RU
         5X4fiGPvq9m/WDEdbLpE3RJfqOqt7g6TpMJAyICU0VMuOM5I+qzGKQTi73upqr5KjV9O
         j9Lu2XOx2ebjXcGbfgUA+005yomw07+sjUsHF7mF6f3pt399fWVUG40qf/KgvfXXLhcg
         NMgm3lg/a23UPilmIFSiTSvEvl/Yvr1WtYvv9FdmQSDf7OmZehQog6kcqKN1Lj0pJdeb
         cKFCydGbUtNwV3EG10PalwCP0AGICfykHsY8a9VQJJ449LuIVmE3cj8492QqyUvJ74Aq
         HQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718972119; x=1719576919;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2E6XacsjAwWDKM7tAVWRLWVOqk2WqIKzpAc0VY30v6o=;
        b=aPA05k1u8iSNNzMmYRINMhsRLGk2hp1pila1VItPahzF5YKZGDXJYCHfqsY1C1x9Oz
         081b7+/Pf94TDhgNDt3czjRUyCGfYRquU0RGaZECQCy1Cl6PquonnfmKKXVECHxo+pYB
         Cf79ojQv5pq4OZbZhntn8SZfsxqGratxF8xruhHT25geXVOjLh6+6CZFBma0irX24Pjh
         6GBeIh0YDPEv9+uLjUdvsFgBmozTisyFpRHiHapGyNcEu21wu5KnRHo8fRrGRNj5bz9f
         SSAhDCVMHdyo3vJ2uSVtdO1H76bN/k0/pQ5ZmuCnzb42yk+wAOInLoutU1tmxDujXqPw
         AcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXjprUtXeWAvFJaLki47x6MeMFGrgFTP7ZEeBtEfnl32rNzgJoy12apKS5A33sF8JTjbSihtd/Eggz5Mg8iGYECHepTUvvhcZ/B4m8GzOJgfDXOjt2rMRPH9YeUUy0p93SVg24ypCeYPfFHQWMcX90bJCviqhjd01/p
X-Gm-Message-State: AOJu0YwsLmZpxKFCOF+xSyyeeIEEdZ3esdUJYvC2g4QaTIWgoKYNccHl
	ERmWc8EnAk7e2Aii8RsDGI4Tq5CANXDU8BwBIt5V0yySK+qwdYMo
X-Google-Smtp-Source: AGHT+IEn9FUQygN9w/1i0M1N6zLdsUlHCdn8LnwTaa/JuDCqlYaQXN/DUjsKv+XrwynmaavdzDNtwA==
X-Received: by 2002:a05:620a:2606:b0:795:5896:f842 with SMTP id af79cd13be357-79bb3ee6e0fmr719006285a.76.1718972118698;
        Fri, 21 Jun 2024 05:15:18 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce930b8dsm80912885a.102.2024.06.21.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:15:16 -0700 (PDT)
Date: Fri, 21 Jun 2024 08:15:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 Mina Almasry <almasrymina@google.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 David Howells <dhowells@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Richard Gobert <richardbgobert@gmail.com>, 
 Antoine Tenart <atenart@kernel.org>, 
 Yan Zhai <yan@cloudflare.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?UTF-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
In-Reply-To: <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> Software GRO is currently controlled by a single switch, i.e.
> 
>   ethtool -K dev gro on|off
> 
> However, this is not always desired. When GRO is enabled, even if the
> kernel cannot GRO certain traffic, it has to run through the GRO receive
> handlers with no benefit.
> 
> There are also scenarios that turning off GRO is a requirement. For
> example, our production environment has a scenario that a TC egress hook
> may add multiple encapsulation headers to forwarded skbs for load
> balancing and isolation purpose. The encapsulation is implemented via
> BPF. But the problem arises then: there is no way to properly offload a
> double-encapsulated packet, since skb only has network_header and
> inner_network_header to track one layer of encapsulation, but not two.
> On the other hand, not all the traffic through this device needs double
> encapsulation. But we have to turn off GRO completely for any ingress
> device as a result.
> 
> Introduce a bit on skb so that GRO engine can be notified to skip GRO on
> this skb, rather than having to be 0-or-1 for all traffic.
> 
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/linux/netdevice.h |  9 +++++++--
>  include/linux/skbuff.h    | 10 ++++++++++
>  net/Kconfig               | 10 ++++++++++
>  net/core/gro.c            |  2 +-
>  net/core/gro_cells.c      |  2 +-
>  net/core/skbuff.c         |  4 ++++
>  6 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c83b390191d4..2ca0870b1221 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2415,11 +2415,16 @@ struct net_device {
>  	((dev)->devlink_port = (port));				\
>  })
>  
> -static inline bool netif_elide_gro(const struct net_device *dev)
> +static inline bool netif_elide_gro(const struct sk_buff *skb)
>  {
> -	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> +	if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
>  		return true;
> +
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	return skb->gro_disabled;
> +#else
>  	return false;
> +#endif

Yet more branches in the hot path.

Compile time configurability does not help, as that will be
enabled by distros.

For a fairly niche use case. Where functionality of GRO already
works. So just a performance for a very rare case at the cost of a
regression in the common case. A small regression perhaps, but death
by a thousand cuts.

>  }
>  
>  #define	NETDEV_ALIGN		32
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f4cda3fbdb75..48b10ece95b5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1008,6 +1008,9 @@ struct sk_buff {
>  #if IS_ENABLED(CONFIG_IP_SCTP)
>  	__u8			csum_not_inet:1;
>  #endif
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	__u8			gro_disabled:1;
> +#endif
>  
>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>  	__u16			tc_index;	/* traffic control index */
> @@ -1215,6 +1218,13 @@ static inline bool skb_wifi_acked_valid(const struct sk_buff *skb)
>  #endif
>  }
>  
> +static inline void skb_disable_gro(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	skb->gro_disabled = 1;
> +#endif
> +}
> +
>  /**
>   * skb_unref - decrement the skb's reference count
>   * @skb: buffer
> diff --git a/net/Kconfig b/net/Kconfig
> index 9fe65fa26e48..47d1ee92df15 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -289,6 +289,16 @@ config MAX_SKB_FRAGS
>  	  and in drivers using build_skb().
>  	  If unsure, say 17.
>  
> +config SKB_GRO_CONTROL
> +	bool "allow disable GRO on per-packet basis"
> +	default y
> +	help
> +	  By default GRO can only be enabled or disabled per network device.
> +	  This can be cumbersome for certain scenarios.
> +	  Toggling this option will allow disabling GRO for selected packets,
> +	  e.g. by XDP programs, so that it is more flexibile.
> +	  Extra overhead should be minimal.
> +
>  config RPS
>  	bool "Receive packet steering"
>  	depends on SMP && SYSFS
> diff --git a/net/core/gro.c b/net/core/gro.c
> index b3b43de1a650..46232a0d1983 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -476,7 +476,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>  	enum gro_result ret;
>  	int same_flow;
>  
> -	if (netif_elide_gro(skb->dev))
> +	if (netif_elide_gro(skb))
>  		goto normal;
>  
>  	gro_list_prepare(&gro_list->list, skb);
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b..1bf15783300f 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>  	if (unlikely(!(dev->flags & IFF_UP)))
>  		goto drop;
>  
> -	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(skb)) {
>  		res = netif_rx(skb);
>  		goto unlock;
>  	}
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2315c088e91d..82bd297921c1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6030,6 +6030,10 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	ipvs_reset(skb);
>  	skb->mark = 0;
>  	skb_clear_tstamp(skb);
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	/* hand back GRO control to next netns */
> +	skb->gro_disabled = 0;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(skb_scrub_packet);
>  
> -- 
> 2.30.2
> 
> 



