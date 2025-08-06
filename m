Return-Path: <bpf+bounces-65144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A817B1C9E9
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C78218C354D
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816A29AB1B;
	Wed,  6 Aug 2025 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd+Rmgbx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082DBA34;
	Wed,  6 Aug 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498637; cv=none; b=UxLIaeq8WRu2bMP0/y5dU1vuXyBs3NiX9jWBkwj44L19FDThnprXom0E8Fz9jDmk0U4xWOk94J8bfZI4oeau+DBfhFyrojWDPgtzXeEtGYuRS+dxriPIJvVQZ7gc9RbY2yNi1fagERzmArNHu+uXKpvqcfzgWyYqyMFf0glSdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498637; c=relaxed/simple;
	bh=fwNXRzzwx26MnUn9YOuIa7ICL97IcaPFC9UinTlhcuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQb0WBTUBDdoR1V4EJ5P/siDVWNws1UweeP/lDpdTPvAcdiULsdh61lelkzqx8p8C+4eXhBw1X84PwP9RaN2X8KlEi5qyut2D66cte/+PhUYM3RPeYsa+P2Z9YPLfMrAMS3JkAqyJ6875fvE/0IOCHllTnKe78/FGtace3XjtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd+Rmgbx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso173970b3a.1;
        Wed, 06 Aug 2025 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754498635; x=1755103435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlrxxs62qjQ/IMYZlKLwt6zju+JyzoTVTYBouxofy4k=;
        b=Rd+RmgbxiBqGB8zBoWzA5Vs9xYWT148Oq5aC0vrE9JKr+BuSiuhgv4oyNDAHTUsWMS
         ttoebr3GNk8Ld3vPe6dR8rGQZt4lOYs5QInbrUZOpVhn3qLA0uoFWxXzDozQLhi52PsL
         6TEFBQ+oChoMHHGC3YaBGRMKiziy/MRTw7eLduw+q92VhyixzHK/ZRA7vYOc1MWgHATG
         v5xkEE69kBL3qsQ83VPauSxbM9ChWfLcedAviY+pE3krvHJoiM2wx7+o0cbL8h5vxSrr
         Y3qQTN9/tbDWz2fryWztvItQ6Of02DDMnDc1aFg8LTrPVFzBX0VsQdnDjv5DMw+Pg+c9
         /ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498635; x=1755103435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlrxxs62qjQ/IMYZlKLwt6zju+JyzoTVTYBouxofy4k=;
        b=VtjHOaEcElv/y4QeAhcDvAqyWUfuAeh7nDu8+AtvvAJFpLsW2om/igGo7y6RMIUuSm
         2VpYnBMTiYJA6+cvugioe7LU57Ts2FmBJ2ghOSHM6CMNEmeU4an0Oc9sI5RWT5dr1jAv
         SE/0WUoDb+g2BOKqsy1WSHGyEPYY0qnhTg5dcAhnnevlObGSDsKYtr4nm3BtOkWQ5/Gp
         lPw0UxShqpYmLGb/mD7jYAj3oPOpFINU7Pah4UKT+VWclvXAuwsJsD1cHzvQDHdOrzRB
         7G9JKhqU4is8qxgdyP3u4ttdBfuw+SPdTFfvb9q9uPZ6FdpZCzN22tU905DoV9KCEoUH
         oc7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3ctpat1nLtHVihXpJw8KKNTPldt7jj7n81YzJ7PySq8Xu/dV1iVayliSxg4P2SmH6q2lTNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJKVD1ibLII508hdZ32WpU/DwFjtU/uWFvnpbFLL3OXal2Fos
	20PlT/Ef6ktWUWiTRR5aD1Yw2M67qbHW/q04lWlzF2kY9ZLdIXYyUCM=
X-Gm-Gg: ASbGncuUdG2UT8bS0kAgIenSjzpnhLew0vNwB66UI2aNLFHp8egYvkFGSM1+OXQu07R
	sSiatSAa2vvsqJ96SpBcI5w7IZFuiWMHiRl7OUIrvwoqHZFZibMlr2P4zSBQaaPhfK1bOL2+o02
	h1HeyYe45kgBU4vJjhKVudblVDo9gQZ104ObEuHCGzrocjbuk9Ll9EaHnGwARmk/RHbnJ4AGtv5
	bdssf0/KaPvwdPDwBMMfa8PHK4sGHrB4zc1OBXL2luRSxnN6soaLqgngYf/JXF628+2G1VmXeYH
	nsgdPV3BX1DbogdhSqN4AVX7CgwFh3C1nH72yKrvWB8KrgQq6nrG1Y2MGxipqwjma2EsMlkkHnA
	rS2Gk116EXIFePCQCAtYdtOh+znOn7i4J82yIIYWI+ALGhxWur+dbD0/mZa8=
X-Google-Smtp-Source: AGHT+IERlJW0XjTH6g0fG5m/lo6IJb+eGUqeEGFGdT3gjFVKOMnPZ8WhzwMQof+ZzxSfQr9exKb9+w==
X-Received: by 2002:a05:6a00:1952:b0:76b:ef8f:c292 with SMTP id d2e1a72fcca58-76c2b000abfmr4057878b3a.16.1754498634963;
        Wed, 06 Aug 2025 09:43:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfbd22csm16048834b3a.65.2025.08.06.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:43:54 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:43:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJOGSRsXic53tkH7@mini-arch>
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>

On 08/06, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Introduce struct xsk_addrs which will carry descriptor count with array
> of addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb(). In order to mitigate the overhead that will be
> coming from memory allocations, let us introduce kmem_cache of xsk_addrs
> onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> 
> v1->v2:
> * store addrs in array carried via destructor_arg instead having them
>   stored in skb headroom; cleaner and less hacky approach;
> v2->v3:
> * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> * set err when xsk_addrs allocation fails (Dan)
> * change xsk_addrs layout to avoid holes
> * free xsk_addrs on error path
> * rebase
> ---
>  include/net/xdp_sock.h |  1 +
>  net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
>  net/xdp/xsk_queue.h    | 12 ++++++
>  3 files changed, 89 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ce587a225661..5ba9ad4c110f 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -61,6 +61,7 @@ struct xdp_sock {
>  		XSK_BOUND,
>  		XSK_UNBOUND,
>  	} state;
> +	struct kmem_cache *xsk_addrs_cache;
>  
>  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
>  	struct list_head tx_list;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..d77cde0131be 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,6 +36,11 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> +struct xsk_addrs {
> +	u64 addrs[MAX_SKB_FRAGS + 1];
> +	u32 num_descs;
> +};
> +
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
>  	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
>  }
>  
> -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
>  	unsigned long flags;
>  	int ret;
>  
>  	spin_lock_irqsave(&pool->cq_lock, flags);
> -	ret = xskq_prod_reserve_addr(pool->cq, addr);
> +	ret = xskq_prod_reserve(pool->cq);
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  
>  	return ret;
>  }
>  
> -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> +				      struct sk_buff *skb)
>  {
> +	struct xsk_buff_pool *pool = xs->pool;
> +	struct xsk_addrs *xsk_addrs;
>  	unsigned long flags;
> +	u32 num_desc, i;
> +	u32 idx;
> +
> +	xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	num_desc = xsk_addrs->num_descs;
>  
>  	spin_lock_irqsave(&pool->cq_lock, flags);
> -	xskq_prod_submit_n(pool->cq, n);
> +	idx = xskq_get_prod(pool->cq);
> +
> +	for (i = 0; i < num_desc; i++, idx++)
> +		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);

optional nit: maybe do xskq_prod_write_addr(, idx+i, ) instead of 'idx++'
in the loop? I got a bit confused here until I spotted that idx++..
But up to you, feel free to ignore, maybe it's just me.

> +	xskq_prod_submit_n(pool->cq, num_desc);
> +
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
>  }
>  
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> @@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>  
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
>  

[..]

> -	if (compl->tx_timestamp) {
> +	if (compl->tx_timestamp)
>  		/* sw completion timestamp, not a real one */
>  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> -	}

Seems to be unrelated, can probably drop if you happen to respin?

> -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
>  	sock_wfree(skb);
>  }
>  
> -static void xsk_set_destructor_arg(struct sk_buff *skb)
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *addrs;
> +
> +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	return addrs->num_descs;
> +}
> +
> +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
>  {
> -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> +}
> +
> +static void xsk_inc_skb_descs(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *addrs;
>  
> -	skb_shinfo(skb)->destructor_arg = (void *)num;
> +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	addrs->num_descs++;
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>  	struct xdp_sock *xs = xdp_sk(skb->sk);
>  
> +	kmem_cache_free(xs->xsk_addrs_cache,
> +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
>  	skb->destructor = sock_wfree;
>  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
>  	/* Free skb without triggering the perf drop trace */
> @@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
>  	u32 hr, len, ts, offset, copy, copied;
> +	struct xsk_addrs *addrs = NULL;
>  	struct sk_buff *skb = xs->skb;
>  	struct page *page;
>  	void *buffer;
> @@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> +
> +		addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> +		if (!addrs)
> +			return ERR_PTR(-ENOMEM);
> +
> +		xsk_set_destructor_arg(skb, addrs);
>  	}
>  
>  	addr = desc->addr;
> @@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  {
>  	struct xsk_tx_metadata *meta = NULL;
>  	struct net_device *dev = xs->dev;
> +	struct xsk_addrs *addrs = NULL;
>  	struct sk_buff *skb = xs->skb;
>  	bool first_frag = false;
>  	int err;
> @@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			err = skb_store_bits(skb, 0, buffer, len);
>  			if (unlikely(err))
>  				goto free_err;
> +
> +			addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> +			if (!addrs) {
> +				err = -ENOMEM;
> +				goto free_err;
> +			}
> +
> +			xsk_set_destructor_arg(skb, addrs);
> +
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
>  			struct page *page;
> @@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	skb->mark = READ_ONCE(xs->sk.sk_mark);
>  	skb->destructor = xsk_destruct_skb;
>  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> -	xsk_set_destructor_arg(skb);
> +
> +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	addrs->addrs[addrs->num_descs++] = desc->addr;
>  
>  	return skb;
>  
> @@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  	if (err == -EOVERFLOW) {
>  		/* Drop the packet */
> -		xsk_set_destructor_arg(xs->skb);
> +		xsk_inc_skb_descs(xs->skb);
>  		xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
>  	} else {
> @@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		 * if there is space in it. This avoids having to implement
>  		 * any buffering in the Tx path.
>  		 */
> -		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +		err = xsk_cq_reserve_locked(xs->pool);
>  		if (err) {
>  			err = -EAGAIN;
>  			goto out;
> @@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
>  	xskq_destroy(xs->tx);
>  	xskq_destroy(xs->fq_tmp);
>  	xskq_destroy(xs->cq_tmp);
> +	kmem_cache_destroy(xs->xsk_addrs_cache);
>  
>  	sock_orphan(sk);
>  	sock->sk = NULL;
> @@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>  
>  	sock_prot_inuse_add(net, &xsk_proto, 1);
>  

[..]

> +	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> +						sizeof(struct xsk_addrs), 0,
> +						SLAB_HWCACHE_ALIGN, NULL);
> +
> +	if (!xs->xsk_addrs_cache) {
> +		sk_free(sk);
> +		return -ENOMEM;
> +	}

Should we move this up to happen before sk_add_node_rcu? Otherwise we
also have to do sk_del_node_init_rcu on !xs->xsk_addrs_cache here?

Btw, alternatively, why not make this happen at bind time when we know
whether the socket is gonna be copy or zc? And do it only for the copy
mode?

