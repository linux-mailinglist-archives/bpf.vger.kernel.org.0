Return-Path: <bpf+bounces-65217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDCB1DBE0
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA201660A4
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1F26FDA4;
	Thu,  7 Aug 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmLgIvYb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642049641;
	Thu,  7 Aug 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584644; cv=none; b=ID6pN2c+F6/4twyA66uLTKL9D//dGoAgTDSfwVK9ulAo0uyyZOzO6eUk5SCFEaWCA/j4nzG4KZKEqM1Chc9bEg9b1nZ1Jeob1COOA6NlbYvkN60mpF2/CrHuVV69DLLJQ0SAMd6ThYY+N7bmEnfkZnwDeEpFY9LXltgNBHlGXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584644; c=relaxed/simple;
	bh=9xVcEE8dHvCKgLw3A2EtjL1F3dWcGsp/NdKexBm+kGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7Yf1QKLRNn7f+Gs3eZAm3OLkXzA9qGej6aw0u556vvp4K8U1UKCqR4PVQcMxG87BASrGeST47T9d/F/e4qqVJQECQDSBN9/W15hFirSlNkuD/LmJdzwKaO+cF3Hc8khI2VLcg2EOEsGI0kKgIM/ug2tFsJXwVCUGGBkE7Y0RSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmLgIvYb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32129c4e9a4so1101635a91.1;
        Thu, 07 Aug 2025 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754584641; x=1755189441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4Rv2UkLd+l2ALaEMAF3ScNbQvUgSCzzygPBpAZvWR8=;
        b=nmLgIvYbUhoZshECy513JB+nKX9+zji7+zToT0NvxyHm70B7rVoCC93/w7tTFp+7d/
         MOKSNNXDVzZS0uu2cISXoosVuzNUnoxgPIeQwhL4wsWc+++kLM7LHBnzmZrMAeNo9pqv
         Uq8+l3zKWxqxxOC73qoM9dds6YJGwac+srO2mqXrjt3vYlc+/ASgckNWXqrWaIesd8AN
         Vu9QTieTszVwpUwc0lrzPGkAc7iGjB9JK+YUS8KDyuOczUrIlKfsrm1x8w23KLHZwuW5
         SUBVkEnN5oNAKCcN199i2QupR199GD8Xb6g5nDVb/9Boazn7kjdBVXwmjwRlCrkFasJC
         WbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754584641; x=1755189441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4Rv2UkLd+l2ALaEMAF3ScNbQvUgSCzzygPBpAZvWR8=;
        b=iKr6FjyWw+2ApJsnYXQymkGKmAigX6l59Y7pJCDnmsuJRO3u3+cSyTupqrmHoeWjil
         M/LIkwGhI5Pr5XEtWAXaEOVwd51muol1K40wrM4ThTleA8MfOIy6Mv8Wzy2iPJwNBaMM
         +MjnLiww1+ucX5JyZDZJ9Uac085R2pnkfg2gsXwQsjz8apZ3qjWHQWiiM8qNIJhkx7AZ
         56B07N54BJKm8fgPaYLfhUbiaGYQO0C9P8X52YCwPmINYEmH+IhYXcz4SjPFpSUVmlmS
         LoK9r5Edt7WDs6A8YR2e+dGfXwjl3zQDAJ5Ryc+6Vye/vozavMtlJNwD0jlGtb38yAaj
         dFAw==
X-Forwarded-Encrypted: i=1; AJvYcCUiwTY3CraysK779gWMDCEd0rSDqbecFBHuTJbet9NdBU8rIIjRjbjSHWAejGI2tBYS3SzXAvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5+1pQ1VyzZ6dID/DTBPt/MZYKwtmgVFrx71dJSK2YLkyCNr5
	FiZXxSyX6vOTiHEYW91IpHXK5YOivzLGp2sy2wyEWop7bAtUypjWIfbx+A2m
X-Gm-Gg: ASbGncsfz6RyeSKrIGBRSZzuFbv/rMvtTivLSn2/r5gO5DJwcpVJuMe6vqn9egI8XlA
	hSLUJq0UuqvbiheNVqlQ7XTUYQKjrHguDbrwcFgpX2twuVNSzKDx3QTrKBEQNPdhlHHAGGVU/HK
	NBwZ9+sw4C1e4wuZUgoIh+jtJLaKyNObj+TsGn5vDyFou/goF87WpISB9HHiULYUe3G0OZJU0Su
	duG7bOwqId8Lr2Tq3BK4r6v0UOaEp/PHlCGJzLjliodGSfCaL+OQJttxMHi45Me67aU5H68pU42
	Ad3QiSH+98iLo0O+X5V9E4GbgIPsrwxnZRFXD6OzD8XJkFJjCwrotx5PRHguwxaG1f7NofgMBUm
	YWkIgp0MdhTcxdUBTn96XQXfrBuNrLBBxgYY8d22mCup0xmWkwkzEU/xCDD8=
X-Google-Smtp-Source: AGHT+IHm5nQ9zhzeq3xyETtEVEjWc+Z7onw9qIBlv6Qu/bmTEvJS1+sCQGif9pFvcoxqmgjH0V21WA==
X-Received: by 2002:a17:90b:380d:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-321673f595amr10074590a91.12.1754584641123;
        Thu, 07 Aug 2025 09:37:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31f63da57b4sm23210460a91.5.2025.08.07.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:37:20 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:37:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJTWQDcpkz3Q4eNU@mini-arch>
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
 <aJOGSRsXic53tkH7@mini-arch>
 <aJO+Uq6qNMqTsgtI@boxer>
 <aJSVhY4wWCLQLla4@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJSVhY4wWCLQLla4@boxer>

On 08/07, Maciej Fijalkowski wrote:
> On Wed, Aug 06, 2025 at 10:42:58PM +0200, Maciej Fijalkowski wrote:
> > On Wed, Aug 06, 2025 at 09:43:53AM -0700, Stanislav Fomichev wrote:
> > > On 08/06, Maciej Fijalkowski wrote:
> > > > Eryk reported an issue that I have put under Closes: tag, related to
> > > > umem addrs being prematurely produced onto pool's completion queue.
> > > > Let us make the skb's destructor responsible for producing all addrs
> > > > that given skb used.
> > > > 
> > > > Introduce struct xsk_addrs which will carry descriptor count with array
> > > > of addresses taken from processed descriptors that will be carried via
> > > > skb_shared_info::destructor_arg. This way we can refer to it within
> > > > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > > > coming from memory allocations, let us introduce kmem_cache of xsk_addrs
> > > > onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.
> > > > 
> > > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > > from day 1, but rather when xsk multi-buffer got introduced.
> > > > 
> > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
> > > > v1:
> > > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > > > v2:
> > > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > > > 
> > > > v1->v2:
> > > > * store addrs in array carried via destructor_arg instead having them
> > > >   stored in skb headroom; cleaner and less hacky approach;
> > > > v2->v3:
> > > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > > * set err when xsk_addrs allocation fails (Dan)
> > > > * change xsk_addrs layout to avoid holes
> > > > * free xsk_addrs on error path
> > > > * rebase
> > > > ---
> > > >  include/net/xdp_sock.h |  1 +
> > > >  net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
> > > >  net/xdp/xsk_queue.h    | 12 ++++++
> > > >  3 files changed, 89 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index ce587a225661..5ba9ad4c110f 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -61,6 +61,7 @@ struct xdp_sock {
> > > >  		XSK_BOUND,
> > > >  		XSK_UNBOUND,
> > > >  	} state;
> > > > +	struct kmem_cache *xsk_addrs_cache;
> > > >  
> > > >  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > >  	struct list_head tx_list;
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 9c3acecc14b1..d77cde0131be 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -36,6 +36,11 @@
> > > >  #define TX_BATCH_SIZE 32
> > > >  #define MAX_PER_SOCKET_BUDGET 32
> > > >  
> > > > +struct xsk_addrs {
> > > > +	u64 addrs[MAX_SKB_FRAGS + 1];
> > > > +	u32 num_descs;
> > > > +};
> > > > +
> > > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > > >  {
> > > >  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > > @@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> > > >  	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> > > >  }
> > > >  
> > > > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > > > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > > >  {
> > > >  	unsigned long flags;
> > > >  	int ret;
> > > >  
> > > >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > > > -	ret = xskq_prod_reserve_addr(pool->cq, addr);
> > > > +	ret = xskq_prod_reserve(pool->cq);
> > > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > >  
> > > >  	return ret;
> > > >  }
> > > >  
> > > > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > > > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > > > +				      struct sk_buff *skb)
> > > >  {
> > > > +	struct xsk_buff_pool *pool = xs->pool;
> > > > +	struct xsk_addrs *xsk_addrs;
> > > >  	unsigned long flags;
> > > > +	u32 num_desc, i;
> > > > +	u32 idx;
> > > > +
> > > > +	xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +	num_desc = xsk_addrs->num_descs;
> > > >  
> > > >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > > > -	xskq_prod_submit_n(pool->cq, n);
> > > > +	idx = xskq_get_prod(pool->cq);
> > > > +
> > > > +	for (i = 0; i < num_desc; i++, idx++)
> > > > +		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
> > > 
> > > optional nit: maybe do xskq_prod_write_addr(, idx+i, ) instead of 'idx++'
> > > in the loop? I got a bit confused here until I spotted that idx++..
> > > But up to you, feel free to ignore, maybe it's just me.
> 
> ugh i missed these comments. sure i can do that.
> 
> > > 
> > > > +	xskq_prod_submit_n(pool->cq, num_desc);
> > > > +
> > > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > > +	kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
> > > >  }
> > > >  
> > > >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > > @@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > >  }
> > > >  
> > > > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > > -{
> > > > -	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > > > -}
> > > > -
> > > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > > >  {
> > > >  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > > >  
> > > 
> > > [..]
> > > 
> > > > -	if (compl->tx_timestamp) {
> > > > +	if (compl->tx_timestamp)
> > > >  		/* sw completion timestamp, not a real one */
> > > >  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> > > > -	}
> > > 
> > > Seems to be unrelated, can probably drop if you happen to respin?
> 
> yes, i'll pull out this sophisticated change to separate commit:P
> 
> > > 
> > > > -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > > > +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> > > >  	sock_wfree(skb);
> > > >  }
> > > >  
> > > > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > > > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > > +{
> > > > +	struct xsk_addrs *addrs;
> > > > +
> > > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +	return addrs->num_descs;
> > > > +}
> > > > +
> > > > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> > > >  {
> > > > -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > > +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > > > +}
> > > > +
> > > > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > > > +{
> > > > +	struct xsk_addrs *addrs;
> > > >  
> > > > -	skb_shinfo(skb)->destructor_arg = (void *)num;
> > > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +	addrs->num_descs++;
> > > >  }
> > > >  
> > > >  static void xsk_consume_skb(struct sk_buff *skb)
> > > >  {
> > > >  	struct xdp_sock *xs = xdp_sk(skb->sk);
> > > >  
> > > > +	kmem_cache_free(xs->xsk_addrs_cache,
> > > > +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> > > >  	skb->destructor = sock_wfree;
> > > >  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > > >  	/* Free skb without triggering the perf drop trace */
> > > > @@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >  {
> > > >  	struct xsk_buff_pool *pool = xs->pool;
> > > >  	u32 hr, len, ts, offset, copy, copied;
> > > > +	struct xsk_addrs *addrs = NULL;
> > > >  	struct sk_buff *skb = xs->skb;
> > > >  	struct page *page;
> > > >  	void *buffer;
> > > > @@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >  			return ERR_PTR(err);
> > > >  
> > > >  		skb_reserve(skb, hr);
> > > > +
> > > > +		addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > > > +		if (!addrs)
> > > > +			return ERR_PTR(-ENOMEM);
> > > > +
> > > > +		xsk_set_destructor_arg(skb, addrs);
> > > >  	}
> > > >  
> > > >  	addr = desc->addr;
> > > > @@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  {
> > > >  	struct xsk_tx_metadata *meta = NULL;
> > > >  	struct net_device *dev = xs->dev;
> > > > +	struct xsk_addrs *addrs = NULL;
> > > >  	struct sk_buff *skb = xs->skb;
> > > >  	bool first_frag = false;
> > > >  	int err;
> > > > @@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  			err = skb_store_bits(skb, 0, buffer, len);
> > > >  			if (unlikely(err))
> > > >  				goto free_err;
> > > > +
> > > > +			addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > > > +			if (!addrs) {
> > > > +				err = -ENOMEM;
> > > > +				goto free_err;
> > > > +			}
> > > > +
> > > > +			xsk_set_destructor_arg(skb, addrs);
> > > > +
> > > >  		} else {
> > > >  			int nr_frags = skb_shinfo(skb)->nr_frags;
> > > >  			struct page *page;
> > > > @@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> > > >  	skb->destructor = xsk_destruct_skb;
> > > >  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > > -	xsk_set_destructor_arg(skb);
> > > > +
> > > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > > +	addrs->addrs[addrs->num_descs++] = desc->addr;
> > > >  
> > > >  	return skb;
> > > >  
> > > > @@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  
> > > >  	if (err == -EOVERFLOW) {
> > > >  		/* Drop the packet */
> > > > -		xsk_set_destructor_arg(xs->skb);
> > > > +		xsk_inc_skb_descs(xs->skb);
> > > >  		xsk_drop_skb(xs->skb);
> > > >  		xskq_cons_release(xs->tx);
> > > >  	} else {
> > > > @@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >  		 * if there is space in it. This avoids having to implement
> > > >  		 * any buffering in the Tx path.
> > > >  		 */
> > > > -		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > > > +		err = xsk_cq_reserve_locked(xs->pool);
> > > >  		if (err) {
> > > >  			err = -EAGAIN;
> > > >  			goto out;
> > > > @@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
> > > >  	xskq_destroy(xs->tx);
> > > >  	xskq_destroy(xs->fq_tmp);
> > > >  	xskq_destroy(xs->cq_tmp);
> > > > +	kmem_cache_destroy(xs->xsk_addrs_cache);
> > > >  
> > > >  	sock_orphan(sk);
> > > >  	sock->sk = NULL;
> > > > @@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
> > > >  
> > > >  	sock_prot_inuse_add(net, &xsk_proto, 1);
> > > >  
> > > 
> > > [..]
> > > 
> > > > +	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > > > +						sizeof(struct xsk_addrs), 0,
> > > > +						SLAB_HWCACHE_ALIGN, NULL);
> > > > +
> > > > +	if (!xs->xsk_addrs_cache) {
> > > > +		sk_free(sk);
> > > > +		return -ENOMEM;
> > > > +	}
> > > 
> > > Should we move this up to happen before sk_add_node_rcu? Otherwise we
> > > also have to do sk_del_node_init_rcu on !xs->xsk_addrs_cache here?
> > > 
> > > Btw, alternatively, why not make this happen at bind time when we know
> > > whether the socket is gonna be copy or zc? And do it only for the copy
> > > mode?
> > 
> > thanks for quick review Stan. makes sense to do it for copy mode only.
> > i'll send next revision tomorrow.
> 
> FWIW syzbot reported an issue that "xsk_generic_xmit_cache" exists, so
> probably we should include queue id within name so that each socket gets
> its own cache with unique name.

Interesting. I was wondering whether it's gonna be confusing to see
multiple "xsk_generic_xmit_cache" entries in /proc/slabinfo, but looks
like it's not allowed :-)

