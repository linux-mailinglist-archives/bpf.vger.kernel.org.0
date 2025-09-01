Return-Path: <bpf+bounces-67119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B58B3EBFA
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 18:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFFA189F215
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2740321F3F;
	Mon,  1 Sep 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX0RZIhU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51785320A3B;
	Mon,  1 Sep 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743020; cv=none; b=STSO+G+Vg4LCqr9ZIM9wrMMHd4MbQXoceC0r7RLJjGRrIoNhoudJ9FNevakVtuj9I+YXCvXcVLlt4ryC+5VwBe2n+i2tdda9OWGDgdwpMrtLwinuw5WzaF/aYkWXIdliUUpY4qRs02jg/HkqAKSoIEzWPKuLyRMXkgzjNkTxvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743020; c=relaxed/simple;
	bh=tXiI7q7ykLMWXfVGgFSRQZ954QTpHjnBBg1I+80CyKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY18r/3H+Gi8qOg9aihkRGPoLM5y0rIdhNPhoDcyXXIWbsSPmOJYhdanDr3NWhe3+5iEGEIr/0C36tgrLo5pikWhAZta9u79o0qJT5+ZtTuCQUP+nSaIkz5iPxal498Fd5Bh0rNTLFdZkHwVbN9mDiH9LQf1AAZT68FwCDzw9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX0RZIhU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ee6485e7d7so50065345ab.3;
        Mon, 01 Sep 2025 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743017; x=1757347817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZsvWb8E9IuoO+1O2QpXkkr4TSoIxCiqUgSMjO6osR8=;
        b=kX0RZIhUlSVvuA7TyxL1gGMG+VULUYN5e+O8ecr/hTuR3jn5XRzWdW9A8z2y+mKuWY
         2q0vSzbUSSwlGQE++sgFiWO053ml/za488KWIpHPs16RtBZaXLGpiL8fYnYWrWbNMX1t
         PB7Pe+gGT5FcnTDzf4o94MgQb/+Hn1oFUFdpafdAkgRfCG/uweHfEeAN0wcm7jS1adxo
         VU/O9vhUL9OZW3y6Bbbc+aDrg6HqE2r4u5kfkCpj0JRshRwiXr+WklS2fxW+aM3Hcr4+
         BsaviwXEk6mG5iqel+3jxy3kmiprYjlDdGJy78UhX/v3lKaodLwkmGZtzm56ewZOUMZG
         IBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743017; x=1757347817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZsvWb8E9IuoO+1O2QpXkkr4TSoIxCiqUgSMjO6osR8=;
        b=bbpa4shl+ACQd57yzseC9CHBLy4SgesUSAyGW3yMaKFQDVKu+V3RtOHI+1R1pQn5ZP
         rgYpNAxMTW7kF02o6qI9x6m8D/qK/YwHV9KN8JTBsjaPnQ4L52jEy0wvWTBu71/5XKk4
         kklSE6Os+dA5bueB1E7X058Pv1LrRV6XBKexpi1FMgQs/yJF25MNnELw5nnKA4QCyIDV
         BH3itjPxheJQ54JBf6xkmXbIZwVFdSKmLMqifLd2cYcIYy1yDnrvfnZmfYJL/8gek26d
         ySKpOp1U5sU5XeICcGaL6oQ6TnPBj5D83itvMCrRK43okVeZEyt4MuNy7plqGSTcKTCw
         eejw==
X-Forwarded-Encrypted: i=1; AJvYcCVjlrjQtAr0Oh5d8YPBRwLrq8w+KyEoCqZuBpOHgYePaPk4PuwbR6ae9dKnpQ7PxP7Jv4Ib1Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMSRTpYPb+rZSaz+90HqFLT0hqtapEAiWWVQSFBWw+EJRRdqz
	sKGw0tbVDs0Ap9c4Gqb422jIKOqWGZkI7IBGaaoy5MbusNwgPhYgJ8vK3L77GvZHLKPrkA/hQZw
	Ab/WvEFTjDFne666AotiFMmQC+PF375Y=
X-Gm-Gg: ASbGncuURVYp3C5KIrVNHNek2Sl1en0fLoGT5oXE79NJS129AB/R15NQcj/RHAEzGdx
	4vAeUxRO1CPHIoRV6uc1Qe0Qfk6mllv/5YJGnYkZ7WqoCdi2XTU2ItR/BuHqQ/V58tH5TRC+BKN
	Dqg39mXYvqzbNqnHM2KnpB9AOAZDLFANs2aJ3kOfFnjcJ0u743dbV66+uIZQ+lkNXMimDJ8C7R4
	eWrTM5i+M2Naqbfug==
X-Google-Smtp-Source: AGHT+IGnAGOD0yGUNbeS1TnUdS5O/e898YNyS807AqWh2oOTT9d+4g73iVDxp4VNyeqEENdrKsx8dwXFC2Rjav20yU4=
X-Received: by 2002:a05:6e02:2145:b0:3eb:9bfa:b6b1 with SMTP id
 e9e14a558f8ab-3f3ffda2b1emr190212905ab.3.1756743017068; Mon, 01 Sep 2025
 09:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 00:09:39 +0800
X-Gm-Features: Ac12FXxOLxJT3W1seMfDg1677SJXSX1DbcgLrASxAYVavlCs_ahtrvnhJo-rP94
Message-ID: <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:10=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
>
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when XSK multi-buffer got introduced.
>
> In order to mitigate performance impact as much as possible, mimic the
> linear and frag parts within skb by storing the first address from XSK
> descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
> via list. The nodes that will go onto list will be allocated via
> kmem_cache. xsk_destruct_skb() will consume address stored at
> ::destructor_arg and optionally go through list from ::cb, if count of
> descriptors associated with this particular skb is bigger than 1.
>
> Previous approach where whole array for storing UMEM addresses from XSK
> descriptors was pre-allocated during first fragment processing yielded
> too big performance regression for 64b traffic. In current approach
> impact is much reduced on my tests and for jumbo frames I observed
> traffic being slower by at most 9%.
>
> Magnus suggested to have this way of processing special cased for
> XDP_SHARED_UMEM, so we would identify this during bind and set different
> hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> given that results looked promising on my side I decided to have a
> single data path for XSK generic Tx. I suppose other auxiliary stuff
> such as helpers introduced in this patch would have to land as well in
> order to make it work, so we might have ended up with more noisy diff.
>
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting =
multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@=
partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>
> Jason, please test this v7 on your setup, I would appreciate if you
> would report results from your testbed. Thanks!
>
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@i=
ntel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@i=
ntel.com/
> v3:
> https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@i=
ntel.com/
> v4:
> https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@i=
ntel.com/
> v5:
> https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> v6:
> https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@i=
ntel.com/
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
> v5->v6:
> * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
>   (Stan)
> * unregister netdev notifier if creating kmem_cache fails (Stan)
> v6->v7:
> * don't include Acks from Magnus/Stan; let them review the new
>   approach:)
> * store first desc at sk_buff::destructor_arg and rest of frags in list
>   stored at sk_buff::cb
> * keep the kmem_cache but don't use it for allocation of whole array at
>   one shot but rather alloc single nodes of list
>
> ---
>  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
>  net/xdp/xsk_queue.h | 12 ++++++
>  2 files changed, 97 insertions(+), 14 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..3d12d1fbda41 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,6 +36,20 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>
> +struct xsk_addr_node {
> +       u64 addr;
> +       struct list_head addr_node;
> +};
> +
> +struct xsk_addr_head {
> +       u32 num_descs;
> +       struct list_head addrs_list;
> +};
> +
> +static struct kmem_cache *xsk_tx_generic_cache;
> +
> +#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> +
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -532,24 +546,41 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags=
)
>         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
>  }
>
> -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 ad=
dr)
> +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
>         unsigned long flags;
>         int ret;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
> -       ret =3D xskq_prod_reserve_addr(pool->cq, addr);
> +       ret =3D xskq_prod_reserve(pool->cq);
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>
>         return ret;
>  }
>
> -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> +static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> +                                     struct sk_buff *skb)
>  {
> +       struct xsk_addr_node *pos, *tmp;
>         unsigned long flags;
> +       u32 i =3D 0;
> +       u32 idx;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
> -       xskq_prod_submit_n(pool->cq, n);
> +       idx =3D xskq_get_prod(pool->cq);
> +
> +       xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destruc=
tor_arg);
> +       i++;
> +
> +       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {
> +                       xskq_prod_write_addr(pool->cq, idx + i, pos->addr=
);
> +                       i++;
> +                       list_del(&pos->addr_node);
> +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> +               }
> +       }
> +       xskq_prod_submit_n(pool->cq, i);
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>
> @@ -562,9 +593,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_poo=
l *pool, u32 n)
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>
> +static void xsk_inc_num_desc(struct sk_buff *skb)
> +{
> +       XSKCB(skb)->num_descs++;
> +}
> +
>  static u32 xsk_get_num_desc(struct sk_buff *skb)
>  {
> -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> +       return XSKCB(skb)->num_descs;
>  }
>
>  static void xsk_destruct_skb(struct sk_buff *skb)
> @@ -576,23 +612,32 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>                 *compl->tx_timestamp =3D ktime_get_tai_fast_ns();
>         }
>
> -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb)=
);
> +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
>         sock_wfree(skb);
>  }
>
> -static void xsk_set_destructor_arg(struct sk_buff *skb)
> +static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
>  {
> -       long num =3D xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> -
> -       skb_shinfo(skb)->destructor_arg =3D (void *)num;
> +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> +       XSKCB(skb)->num_descs =3D 0;
> +       skb_shinfo(skb)->destructor_arg =3D (void *)addr;
>  }
>
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>         struct xdp_sock *xs =3D xdp_sk(skb->sk);
> +       u32 num_descs =3D xsk_get_num_desc(skb);
> +       struct xsk_addr_node *pos, *tmp;
> +
> +       if (unlikely(num_descs > 1)) {

I suspect the use of 'unlikely'. For some application turning on the
multi-buffer feature, if it tries to transmit a large chunk of data,
it can become 'likely' then. So it depends how people use it.

> +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {

It seems no need to use xxx_safe() since the whole process (from
allocating skb to freeing skb) makes sure each skb can be processed
atomically?

> +                       list_del(&pos->addr_node);
> +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> +               }
> +       }
>
>         skb->destructor =3D sock_wfree;
> -       xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> +       xsk_cq_cancel_locked(xs->pool, num_descs);
>         /* Free skb without triggering the perf drop trace */
>         consume_skb(skb);
>         xs->skb =3D NULL;
> @@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>                         return ERR_PTR(err);
>
>                 skb_reserve(skb, hr);
> +
> +               xsk_set_destructor_arg(skb, desc->addr);
>         }
>
>         addr =3D desc->addr;
> @@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>                         err =3D skb_store_bits(skb, 0, buffer, len);
>                         if (unlikely(err))
>                                 goto free_err;
> +
> +                       xsk_set_destructor_arg(skb, desc->addr);
>                 } else {
>                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
>                         struct page *page;
> @@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>         skb->destructor =3D xsk_destruct_skb;
>         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> -       xsk_set_destructor_arg(skb);
> +
> +       xsk_inc_num_desc(skb);
> +       if (unlikely(xsk_get_num_desc(skb) > 1)) {
> +               struct xsk_addr_node *xsk_addr;
> +
> +               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> +               if (!xsk_addr) {

num of descs needs to be decreased by one here? We probably miss the
chance to add this addr node into the list this time. Sorry, I'm not
so sure if this err path handles correctly.

Thanks,
Jason

> +                       err =3D -ENOMEM;
> +                       goto free_err;
> +               }
> +               xsk_addr->addr =3D desc->addr;
> +               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_li=
st);
> +       }
>
>         return skb;
>
> @@ -769,7 +830,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>
>         if (err =3D=3D -EOVERFLOW) {
>                 /* Drop the packet */
> -               xsk_set_destructor_arg(xs->skb);
> +               xsk_inc_num_desc(xs->skb);
>                 xsk_drop_skb(xs->skb);
>                 xskq_cons_release(xs->tx);
>         } else {
> @@ -812,7 +873,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                  * if there is space in it. This avoids having to impleme=
nt
>                  * any buffering in the Tx path.
>                  */
> -               err =3D xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +               err =3D xsk_cq_reserve_locked(xs->pool);
>                 if (err) {
>                         err =3D -EAGAIN;
>                         goto out;
> @@ -1815,8 +1876,18 @@ static int __init xsk_init(void)
>         if (err)
>                 goto out_pernet;
>
> +       xsk_tx_generic_cache =3D kmem_cache_create("xsk_generic_xmit_cach=
e",
> +                                                sizeof(struct xsk_addr_n=
ode),
> +                                                0, SLAB_HWCACHE_ALIGN, N=
ULL);
> +       if (!xsk_tx_generic_cache) {
> +               err =3D -ENOMEM;
> +               goto out_unreg_notif;
> +       }
> +
>         return 0;
>
> +out_unreg_notif:
> +       unregister_netdevice_notifier(&xsk_netdev_notifier);
>  out_pernet:
>         unregister_pernet_subsys(&xsk_net_ops);
>  out_sk:
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 46d87e961ad6..f16f390370dc 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct x=
sk_queue *q)
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
>         u32 free_entries =3D q->nentries - (q->cached_prod - q->cached_co=
ns);
> @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_=
queue *q, u64 addr)
>         return 0;
>  }
>
> +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u6=
4 addr)
> +{
> +       struct xdp_umem_ring *ring =3D (struct xdp_umem_ring *)q->ring;
> +
> +       ring->desc[idx & q->ring_mask] =3D addr;
> +}
> +
>  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struc=
t xdp_desc *descs,
>                                               u32 nb_entries)
>  {
> --
> 2.34.1
>

