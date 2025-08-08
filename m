Return-Path: <bpf+bounces-65260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13374B1E5EC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84870188C8BC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CE270EDD;
	Fri,  8 Aug 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2QC52k4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186626FDA4;
	Fri,  8 Aug 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646502; cv=none; b=sHS71+ylXm4J6mHj0nDds90QXl0wvP4axiT1J2SIiApCJgRItJq5ShMil4GLBx3G75fb7MZGNgEPgLNKNU+T9FDgTZ0D8v8wBqczkRiDZugAj64wDRyehGqgue9CEvAhepspgybCsu4XiA3+u6D8dFZA1SmH4y9OtqJqkegv8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646502; c=relaxed/simple;
	bh=Z3aCGUiRGRXYnhwzpZp96GagW/dFRf1VQm9NeV+EI0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWBMbMdg5CH9gOhc3Sz6p2sJp1Dp082Lzt2WqStDhuOTg1NRMfpl+cq6CGtP+1rt+EIGV3uefY5j+5xCwreYFao5S6wmEvMin/ndaiB4zYlp+jTE0+3iXn7kWdcHJulnwvxdxfG22go81F/sqfyCOBXBg4R/FLbIi+eoH7d7dWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2QC52k4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7074bad0523so18464366d6.3;
        Fri, 08 Aug 2025 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754646500; x=1755251300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+G+YNgSEKGh3jkkSddxxuoVCVqNjWkkCuBgiOfNtFA=;
        b=j2QC52k4CI4pxfaInIHLdi8uVZn50k1/2PxP+zZcgf2b7KQ6CfrRPDJRCno87Iqz6t
         xNT0n/jGdwCTthy0PlylFywENm6xeUz4A33ByQ60r7janW58FahEfxsV/F8utFfaxOtC
         a/VqSOP/c169q4w6pmr4mFMifdnoqP3w1mos2bOJkWlp6FEQOHf+bKK1TvfkcjMXbrLp
         Jk+X0op2pP45+QEnQYNJxEJB1FF7G2z341yCqlDz0kjTqAG8X8V+iON9r3BT/Cbt5XX7
         oZc+2D3SdKUtrbyf/rFfTlPocZrPARe8BLS9PeF747Qwga9vhxnZdbtfu2kyBHIidpsT
         kF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754646500; x=1755251300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+G+YNgSEKGh3jkkSddxxuoVCVqNjWkkCuBgiOfNtFA=;
        b=XkdrozaV1nyoMKlP/Cp1AlmLVh4tmeIuZ3dVTifwWTcVtxIegkR5IfM+fEf5AylhRc
         yXeZhWSBhG1eH+gPrvUK4gEq2jVGoA68HwYQUCzufKF+H9EMRxRpGcNcsBw8qtX5C9bl
         ZIhQxy/pDpVPcKBIkZFaOcckFQNX5VKJyP8XElkOccBXZsHCCm+XtJupg/ZCeS5VRjnZ
         4j7uDaoTKvSy6J+kS7L+WqLwvSkDhUW9OW7aDJIe8wYL421MVeYRBMbuGCR52Xm3o5Dj
         p8dWcrHLXs0TqvoCydfhVdh97YcbNTFCp2CrnWaMM/pbuiNrXn07SC/TRUpcCInjbYol
         I3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWLXioMf+zQG95YlpB2UeTCA2tN3u+SpVxwlyEHma0HOqHlaMe52JjbeGwWS99cLKLKss5Gh9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsDyFqlswt8Cv/GQS5uh9HM6EWIAjmK3GBAmtcXXDRj5YQhhP
	u23oIdeCX6G8BKZFLae6F/bijyRl1Xz4nYvD5Kbi57rumCQq30moYogORSFCEeuhktnrphBZSNX
	8moYY/moFvB6OR7k3ts9irrhstTaqDMg=
X-Gm-Gg: ASbGncthVw49rsuwp+Kztb5t1ANCsWj8GIACXsWP9iG2RPtsA3/vusWKLe/QtJH06Qb
	jAVgAihoPU5e8RXUvlFKTdW4Fm2CFEIAFSXQ3PR8WYQCtoXCHtH0eg4Bb8Mdttg2D0raMT1P36/
	kaZl7rqdqu5dCvjApOiI5HvObQX3K+CPUV+82e8x2xip3MZ+zT0egLxJmVg+8iEpoo/sME1sUV9
	pvrLV0=
X-Google-Smtp-Source: AGHT+IGeJIB7voBByv2s49C5oMCusJDW0EIHmDPCst84q6MQPdyao9R/D95vG9OInoY4wI8iR3xrCws7HZ3q1NjdlP0=
X-Received: by 2002:ad4:5766:0:b0:709:5874:8363 with SMTP id
 6a1803df08f44-7099a3055d3mr40907536d6.23.1754646499612; Fri, 08 Aug 2025
 02:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 8 Aug 2025 11:48:08 +0200
X-Gm-Features: Ac12FXwgSlvI_MVrfV3Gm2wynwBvOUmzARCh6t-GBfAzv8yL9-yimrXcxBknTyE
Message-ID: <CAJ8uoz0fCccUDwrpRwqBtRjuTu3aRmapTcGu8Kw6z4dQkx1YxQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	aleksander.lobakin@intel.com, Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 17:41, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
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
>                 XSK_BOUND,
>                 XSK_UNBOUND,
>         } state;
> +       struct kmem_cache *xsk_addrs_cache;
>
>         struct xsk_queue *tx ____cacheline_aligned_in_smp;
>         struct list_head tx_list;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..d77cde0131be 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,6 +36,11 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>
> +struct xsk_addrs {
> +       u64 addrs[MAX_SKB_FRAGS + 1];
> +       u32 num_descs;
> +};

As you will have to produce a v4, I suggest that you put num_descs
first in this struct. The current allocation will lead to 2 cache line
accesses for the case when we have only one fragment. By setting it
first, it will reduced to one cache line access. Yes, we will create a
hole, but I think wasting 4 bytes here is worth it. What do you think?

Apart from that, looks good.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> +
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
>         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
>  }
>
> -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
>         unsigned long flags;
>         int ret;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
> -       ret = xskq_prod_reserve_addr(pool->cq, addr);
> +       ret = xskq_prod_reserve(pool->cq);
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>
>         return ret;
>  }
>
> -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> +                                     struct sk_buff *skb)
>  {
> +       struct xsk_buff_pool *pool = xs->pool;
> +       struct xsk_addrs *xsk_addrs;
>         unsigned long flags;
> +       u32 num_desc, i;
> +       u32 idx;
> +
> +       xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +       num_desc = xsk_addrs->num_descs;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
> -       xskq_prod_submit_n(pool->cq, n);
> +       idx = xskq_get_prod(pool->cq);
> +
> +       for (i = 0; i < num_desc; i++, idx++)
> +               xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
> +       xskq_prod_submit_n(pool->cq, num_desc);
> +
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
> +       kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
>  }
>
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> @@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>         struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
>
> -       if (compl->tx_timestamp) {
> +       if (compl->tx_timestamp)
>                 /* sw completion timestamp, not a real one */
>                 *compl->tx_timestamp = ktime_get_tai_fast_ns();
> -       }
>
> -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
>         sock_wfree(skb);
>  }
>
> -static void xsk_set_destructor_arg(struct sk_buff *skb)
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +       struct xsk_addrs *addrs;
> +
> +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +       return addrs->num_descs;
> +}
> +
> +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
>  {
> -       long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> +       skb_shinfo(skb)->destructor_arg = (void *)addrs;
> +}
> +
> +static void xsk_inc_skb_descs(struct sk_buff *skb)
> +{
> +       struct xsk_addrs *addrs;
>
> -       skb_shinfo(skb)->destructor_arg = (void *)num;
> +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +       addrs->num_descs++;
>  }
>
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>         struct xdp_sock *xs = xdp_sk(skb->sk);
>
> +       kmem_cache_free(xs->xsk_addrs_cache,
> +                       (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
>         skb->destructor = sock_wfree;
>         xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
>         /* Free skb without triggering the perf drop trace */
> @@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>         struct xsk_buff_pool *pool = xs->pool;
>         u32 hr, len, ts, offset, copy, copied;
> +       struct xsk_addrs *addrs = NULL;
>         struct sk_buff *skb = xs->skb;
>         struct page *page;
>         void *buffer;
> @@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                         return ERR_PTR(err);
>
>                 skb_reserve(skb, hr);
> +
> +               addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> +               if (!addrs)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               xsk_set_destructor_arg(skb, addrs);
>         }
>
>         addr = desc->addr;
> @@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  {
>         struct xsk_tx_metadata *meta = NULL;
>         struct net_device *dev = xs->dev;
> +       struct xsk_addrs *addrs = NULL;
>         struct sk_buff *skb = xs->skb;
>         bool first_frag = false;
>         int err;
> @@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>                         err = skb_store_bits(skb, 0, buffer, len);
>                         if (unlikely(err))
>                                 goto free_err;
> +
> +                       addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> +                       if (!addrs) {
> +                               err = -ENOMEM;
> +                               goto free_err;
> +                       }
> +
> +                       xsk_set_destructor_arg(skb, addrs);
> +
>                 } else {
>                         int nr_frags = skb_shinfo(skb)->nr_frags;
>                         struct page *page;
> @@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>         skb->mark = READ_ONCE(xs->sk.sk_mark);
>         skb->destructor = xsk_destruct_skb;
>         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> -       xsk_set_destructor_arg(skb);
> +
> +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +       addrs->addrs[addrs->num_descs++] = desc->addr;
>
>         return skb;
>
> @@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>
>         if (err == -EOVERFLOW) {
>                 /* Drop the packet */
> -               xsk_set_destructor_arg(xs->skb);
> +               xsk_inc_skb_descs(xs->skb);
>                 xsk_drop_skb(xs->skb);
>                 xskq_cons_release(xs->tx);
>         } else {
> @@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                  * if there is space in it. This avoids having to implement
>                  * any buffering in the Tx path.
>                  */
> -               err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +               err = xsk_cq_reserve_locked(xs->pool);
>                 if (err) {
>                         err = -EAGAIN;
>                         goto out;
> @@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
>         xskq_destroy(xs->tx);
>         xskq_destroy(xs->fq_tmp);
>         xskq_destroy(xs->cq_tmp);
> +       kmem_cache_destroy(xs->xsk_addrs_cache);
>
>         sock_orphan(sk);
>         sock->sk = NULL;
> @@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>
>         sock_prot_inuse_add(net, &xsk_proto, 1);
>
> +       xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> +                                               sizeof(struct xsk_addrs), 0,
> +                                               SLAB_HWCACHE_ALIGN, NULL);
> +
> +       if (!xs->xsk_addrs_cache) {
> +               sk_free(sk);
> +               return -ENOMEM;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 46d87e961ad6..f16f390370dc 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
>
>  /* Functions for producers */
>
> +static inline u32 xskq_get_prod(struct xsk_queue *q)
> +{
> +       return READ_ONCE(q->ring->producer);
> +}
> +
>  static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
>  {
>         u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
>         return 0;
>  }
>
> +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
> +{
> +       struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
> +
> +       ring->desc[idx & q->ring_mask] = addr;
> +}
> +
>  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
>                                               u32 nb_entries)
>  {
> --
> 2.34.1
>
>

