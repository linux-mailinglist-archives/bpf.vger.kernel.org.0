Return-Path: <bpf+bounces-66040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF19B2CE46
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C855E5F06
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85A343D88;
	Tue, 19 Aug 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKwJj1/j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6D343D66;
	Tue, 19 Aug 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636484; cv=none; b=ZCdQYGtlIxbbrg41ahpdbfRz/hHj9LD+/uNuf0evEoyZXDQexEhYMDj0hjN8601n6uvb4F+5btwcjt2lSHPHZ5sWgbsBZdUY48Qx9oVL7hHlwOubm1Yicun2XjpZvH7DK58T+T/tAg0KXw0BWpKURws9WigwX2wXh9id3FEbWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636484; c=relaxed/simple;
	bh=kmMJk/i9FbzroXRaoP0xDtPOnPlXlqrWn8r/VwjugYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwvZ29ksaNkpnHWp4dj8wwFc1gJxaLPpNPXae/RhdHebWTNVN84ivAMh3uOldS1S3yu0b+yqrK4wTUHPGOEdg4sz8QwWWjlx9Yt/GdkO6+gEpnT5zPE4YEBXHKLGQbfHmRkis/UXuyYGnosMSQz9yk84LsT5ABZ8JwhchyMy5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKwJj1/j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24457f47492so38615255ad.0;
        Tue, 19 Aug 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636482; x=1756241282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pciKooAzOs9iHte3/tBKtKB0pwUgvkClWihYyKKXjSE=;
        b=VKwJj1/jBdW28dQ+Z8WZXzlUaEdEEGVPbxnlRdoOegTwx3rNX+QRLd3M/PGiK2KGO8
         UNADEnjOYAbV0FkmpbcxE5vxKDZiz6Utw1JeJ+FH3XrSoTsiwMdw+dc3dWLVW8EIHAYo
         k5fSFPZgfB+nAAS/ze9T7LboVZ3n/PDimShCM+kqxsnjUCbtnaYmbxg0OPFx4hQJPOIA
         RQmTe1Dq2dElSplZg5+Q31pQtUsEW8T5Tt0c3ABldlK0rO+SQBEEeOewYedrYP60SX64
         xdGY1pT3DXDZxijUhXE0QQqi7Ze/zNfAe9tByQl4wZmFNvKnmXp3cAhrzdNKzvYIKxjf
         PIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636482; x=1756241282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pciKooAzOs9iHte3/tBKtKB0pwUgvkClWihYyKKXjSE=;
        b=wFvRMOlZMJW+gEiZIqIACytTs5ilWpgJTtruTNUMItbVtxmMP81UL1cRDuBaKkGa7y
         EPi9KJwxS4CZaqb0WhN2OsRABImjQoddxNcoWOKlXsUAq6v9wIHYzEspVssp/YlgxfGs
         UxnCSSym0a5HYvsu4JiHd9yfflfboU9Nfqr2IeQIdWcJjHl4MhmUw110plH72Jb41A1h
         zr1x8bjGEznUF6rypdb8Sz52PCTmTKFKK2wVFzsrSlgvwDd7BDJ2TAWk8evTmKWrF56m
         o+i2+SvCh4dGNELBZJ8ovqrr2u2lbGTeA5Y7jwoouRTzB5gLC/QUXCzGbPwX4Kw0snIv
         ep2A==
X-Forwarded-Encrypted: i=1; AJvYcCW58/YRNypaybGZIlObFFLSXsE8o7su+GBIv2A9a+PcRu623PFe1fyFiG7r0/ADjX+LRGGhKrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cBDJgjDaBBucyYTIdxVFtYyZFoROeozNcsPSrI+od7tMYT7j
	Wf8k0bGE0Ykw1ftu2FqXq15+9GAVtVwU+F0+jpHoHeJzBCw6O2svlS0=
X-Gm-Gg: ASbGncv4PmUYi5FoEbiwpOQF7ibejBMrJr0as13ASO1nYyP3+JCJ5bgcrIVIgG0JCJL
	8IFGp6lzcaErmIWcymvOVKuTMVv7FVLjGQqH5TTp546MPc6oylfc5Cp9ddj77MVXcMiYXESO93K
	d56t3bjXKyemCSdPQdw7imueXM+Ko40y9Mc4qrZHvMILvRxQ4Bm9OpnHWcH/OK52UO488wFQdNB
	gwz8NJb9T5Ywm3KINDiNUODDP0y7IZMmezKlLNR+YLh9L4FlFAwND3mGZP5pK2kUYkmqbpBfOE8
	s3GD9uXSYUXNxMtjZe8pXooJpbPHpJL2pjzzgokCpDSyIdhc0c50Mb8+a9p48NTzhDC3opNt2mK
	ot2WgMnnBvWWTyqk4rfoOcv13VmB8pvWxhSo3FCViyo4AjZo5pY8yMtzwCMk=
X-Google-Smtp-Source: AGHT+IH49v4Lbm+wxXKzsStlLz+dsTOgc+Eiu9txC8KiYc/WtKK/1DJe3L6KrD02Guy4/6/8XFC9fw==
X-Received: by 2002:a17:902:c94c:b0:240:bf59:26bb with SMTP id d9443c01a7336-245ef153c4cmr4466765ad.19.1755636481428;
        Tue, 19 Aug 2025 13:48:01 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-324e2538d08sm78242a91.8.2025.08.19.13.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:48:01 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:48:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v5 bpf] xsk: fix immature cq descriptor production
Message-ID: <aKTjACALTDMrzuxJ@mini-arch>
References: <20250819115518.2240942-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819115518.2240942-1-maciej.fijalkowski@intel.com>

On 08/19, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Introduce struct xsk_addrs which will carry descriptor count with array
> of addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb(). In order to mitigate the overhead that will be
> coming from memory allocations, let us introduce kmem_cache of
> xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> system.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> 
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> v3:
> https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> v4:
> https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
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
> v3->v4:
> * have kmem_cache as percpu vars
> * don't drop unnecessary braces (unrelated) (Stan)
> * use idx + i in xskq_prod_write_addr (Stan)
> * alloc kmem_cache on bind (Stan)
> * keep num_descs as first member in xsk_addrs (Magnus)
> * add ack from Magnus
> v4->v5:
> * have a single kmem_cache per xsk subsystem (Stan)
> 
> ---
>  net/xdp/xsk.c       | 91 +++++++++++++++++++++++++++++++++++++--------
>  net/xdp/xsk_queue.h | 12 ++++++
>  2 files changed, 87 insertions(+), 16 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..012991de9df2 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,6 +36,13 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> +struct xsk_addrs {
> +	u32 num_descs;
> +	u64 addrs[MAX_SKB_FRAGS + 1];
> +};
> +
> +static struct kmem_cache *xsk_tx_generic_cache;
> +
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
> +	for (i = 0; i < num_desc; i++)
> +		xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addrs[i]);
> +	xskq_prod_submit_n(pool->cq, num_desc);
> +
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
>  }
>  
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> @@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
> @@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
>  	}
>  
> -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
>  	sock_wfree(skb);
>  }
>  
> -static void xsk_set_destructor_arg(struct sk_buff *skb)
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
>  {
> -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> +	struct xsk_addrs *addrs;
>  
> -	skb_shinfo(skb)->destructor_arg = (void *)num;
> +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	return addrs->num_descs;
> +}
> +
> +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> +{
> +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> +}
> +
> +static void xsk_inc_skb_descs(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *addrs;
> +
> +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +	addrs->num_descs++;
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>  	struct xdp_sock *xs = xdp_sk(skb->sk);
>  
> +	kmem_cache_free(xsk_tx_generic_cache,
> +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
>  	skb->destructor = sock_wfree;
>  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
>  	/* Free skb without triggering the perf drop trace */
> @@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
>  	u32 hr, len, ts, offset, copy, copied;
> +	struct xsk_addrs *addrs = NULL;
>  	struct sk_buff *skb = xs->skb;
>  	struct page *page;
>  	void *buffer;
> @@ -623,6 +656,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> +
> +		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +		if (!addrs)
> +			return ERR_PTR(-ENOMEM);

Do we need to kfree the skb that we allocated on line 621 above? (maybe
not because I always get confused by the mb/overflow handling here)

> +
> +		xsk_set_destructor_arg(skb, addrs);
>  	}
>  
>  	addr = desc->addr;
> @@ -662,6 +701,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  {
>  	struct xsk_tx_metadata *meta = NULL;
>  	struct net_device *dev = xs->dev;
> +	struct xsk_addrs *addrs = NULL;
>  	struct sk_buff *skb = xs->skb;
>  	bool first_frag = false;
>  	int err;
> @@ -694,6 +734,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			err = skb_store_bits(skb, 0, buffer, len);
>  			if (unlikely(err))
>  				goto free_err;
> +
> +			addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
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
> @@ -759,7 +808,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
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
> @@ -769,7 +820,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  	if (err == -EOVERFLOW) {
>  		/* Drop the packet */
> -		xsk_set_destructor_arg(xs->skb);
> +		xsk_inc_skb_descs(xs->skb);
>  		xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
>  	} else {
> @@ -812,7 +863,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		 * if there is space in it. This avoids having to implement
>  		 * any buffering in the Tx path.
>  		 */
> -		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +		err = xsk_cq_reserve_locked(xs->pool);
>  		if (err) {
>  			err = -EAGAIN;
>  			goto out;
> @@ -1815,6 +1866,14 @@ static int __init xsk_init(void)
>  	if (err)
>  		goto out_pernet;
>  
> +	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> +						 sizeof(struct xsk_addrs), 0,
> +						 SLAB_HWCACHE_ALIGN, NULL);
> +	if (!xsk_tx_generic_cache) {
> +		err = -ENOMEM;
> +		goto out_pernet;

This probably needs an unregister_netdevice_notifier call?

