Return-Path: <bpf+bounces-67687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B8BB4829A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 04:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD3017B379
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 02:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9A1EBFE0;
	Mon,  8 Sep 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9m2nkiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67C1B87F2;
	Mon,  8 Sep 2025 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298408; cv=none; b=Yvj6OIiMYE0GXFZaMEOHBFKZNa0IHAQgK/UcktP5h476C8Rg1pd+cQBE99L0XWr83JtZPvSrYrjPO+MybK+4U6osPtexPUXIntylN8ibn5UYhnLC30OB3FGXFGmOnZWWT0FM/11Z4VxJPa9KkVSI+2Qys3OEegi5HhK4G/x8qbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298408; c=relaxed/simple;
	bh=zo42/wjKpt7G+qw5sVfTbmgKWtr8AZ9KQ/NBxzcAJ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj1ROXEXK8hM4hNKHy4ODxCHdHqrrkbFhpLp5Xbz18B82OVSoXERRNvUql8fLeikm6rgUURWQBWmsCvF+Ti1wQvWrULPyUk3SvYlV6Jo96kn1Sj7pFA/s8qnaniKUaaHltLCeFeW2svqr7MI/Y2Gv+cyiTVl5aONuz7YUhCkPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9m2nkiv; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f664c47ac9so22609585ab.2;
        Sun, 07 Sep 2025 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757298405; x=1757903205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKWvySzWJat18AGVts8d21jsFhMMlrxadhW2bRjy+yU=;
        b=e9m2nkivZfEBdlT+/yKfNqw32LsSazk3Igj+P8bybgIsLUonKkBAqw+a7V2OmJR79/
         xRMO/74WJIksqoLaQNYphXLIW8+DL6bZ0ZQsMUkUx8h/fE5gt4lpDQnbE5k1gmzsgFd2
         uiPP4oKY5phtaQpKKZLz+zE56PciVs0/UoVJJ8Tw6Vln5qGaDr2tdkr5QYrmNOpOwYvR
         KSoreqMxY4GewIEN89jzrVH1sOBoQGmlxpH9SZPdo9ruI6xOzFXZAaKj0HGs5IOn5hMa
         PzdfNpEK418WOTOubWs/f7dyLi/JTnf3MpENEV7G9Ynk0Up3ymkxv7OsFbL/Upf1xHkO
         2Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757298405; x=1757903205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKWvySzWJat18AGVts8d21jsFhMMlrxadhW2bRjy+yU=;
        b=Hmsjg2R+yWqGd9MzgBKmBmKAmGARmsyC53P1YNAHbboig9M1eGtceemeUKwTrLbCut
         dd6/w2TJ0483djqLrJ6QowCPnrWJp0w9CsDBy+Io4Y3by85DFZyycRjujBpq7oJgBbaq
         sJgym+97lBHCDM29yrNiABdQgCUnjfVJePDbMO1bfPcBv3XEFdQRatn7FKzBR8soot2J
         iI/uFETTyf578Ja+3fgxA45WPv9boCeSOkaS32uwCUyR0Jei0Rq1UOQ34n8mS59asRCS
         8nW1r2DHGFlGu9y47IxvANxFq29egv5RMsmwZnbgbd/f3nIJUqmFzgded5M+jFvNJUv9
         KwUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHL8Q/Eyj9aSx4S2eEH+Hu2dUW8lApLfSyj9/qH9F4vCvP7wxCY6wr6bep8gPYFndhfyDSXKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnFt6KBxVSjMGWLElojaI2XNznOv6ks5sja9cDBAnfqnmeOyr
	dXghGwDYvOET0SUH6g6aIH5SNlCARvgTjcRGpsV1/Wwfp2TizSrs4B1M2sHV8q89ludQTrp1IN2
	ugo0w0ybUDaWgTpd1qYwTA6uRAEQb6DAo+o+GI5DeUA==
X-Gm-Gg: ASbGnct5hmQzfS2jRRVXEVdAPrrqFhtov93ZNb56GY1GQLYmNbXAR+n69aG8EvNcFwv
	sAaN9n2fWE6EltoJ+SDIuNaK89SiQzybq1Ef6F7so2onDt6QJiILzJL/vOSyAkEvT71uqT5QF/D
	a3bpVOWWu5cZPP/i18UDK1XThNdTI2arO3c+3eDV8eBlV9gQertjBd24XS+p3MFKIleCenWl1wk
	DN9p8/Dxg8=
X-Google-Smtp-Source: AGHT+IGU/1zalxz9wTU2SvwU3vfFkZ9jX3VYp3UpaQeHN5eLQ6m6U8e8cuuxSf7ptKVwwUZM/lXUnoMQGR8m3FXh5MA=
X-Received: by 2002:a05:6e02:3c06:b0:3f0:a48b:151b with SMTP id
 e9e14a558f8ab-3fd8a398275mr97697525ab.31.1757298405366; Sun, 07 Sep 2025
 19:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904194907.2342177-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250904194907.2342177-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 8 Sep 2025 10:26:08 +0800
X-Gm-Features: Ac12FXxAxVckqQ1YOtNIaZQeoA2IQYVRnBPKeEfGXIlgfSQiMdeF-3sbNbMCffo
Message-ID: <CAL+tcoCX0X8mNa1xn-B6T=WoCmAVcMBD0haFO+AaxscwN_F0=Q@mail.gmail.com>
Subject: Re: [PATCH v9 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, aleksander.lobakin@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:49=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
>
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
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
> would have to land as well in order to make it work.
>
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting =
multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@=
partner.samsung.com/
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
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
> v7:
> https://lore.kernel.org/bpf/20250829180950.2305157-1-maciej.fijalkowski@i=
ntel.com/
> v8:
> https://lore.kernel.org/bpf/07646dce-dab4-4afe-a09a-e6a83502ac30@intel.co=
m/T/
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
> v7->v8:
> * fix a problem around incrementing num_descs when kmem_cache failed to
>   provide us chunk of memory (Jason)
> * restore Ack from Stanislav
> * include BUILD_BUG_ON to cover xsk_addr_head future growth (Stan)
> * s/i/descs_processed/ in xsk_cq_submit_addr_locked() (Magnus)
> v8->v9:
> * fix 32bit build warnings by uintptr_t casts on void * <-> u64
>   conversion
>
> ---
>  net/xdp/xsk.c       | 113 ++++++++++++++++++++++++++++++++++++++------
>  net/xdp/xsk_queue.h |  12 +++++
>  2 files changed, 111 insertions(+), 14 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..72e34bd2d925 100644
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
> @@ -532,24 +546,43 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags=
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
> +       u32 descs_processed =3D 0;
>         unsigned long flags;
> +       u32 idx;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
> -       xskq_prod_submit_n(pool->cq, n);
> +       idx =3D xskq_get_prod(pool->cq);
> +
> +       xskq_prod_write_addr(pool->cq, idx,
> +                            (u64)(uintptr_t)skb_shinfo(skb)->destructor_=
arg);
> +       descs_processed++;
> +
> +       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {
> +                       xskq_prod_write_addr(pool->cq, idx + descs_proces=
sed,
> +                                            pos->addr);
> +                       descs_processed++;
> +                       list_del(&pos->addr_node);
> +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> +               }
> +       }
> +       xskq_prod_submit_n(pool->cq, descs_processed);
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>
> @@ -562,9 +595,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_poo=
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
> @@ -576,23 +614,33 @@ static void xsk_destruct_skb(struct sk_buff *skb)
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
> +       BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> +       XSKCB(skb)->num_descs =3D 0;
> +       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
>  }
>
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>         struct xdp_sock *xs =3D xdp_sk(skb->sk);
> +       u32 num_descs =3D xsk_get_num_desc(skb);
> +       struct xsk_addr_node *pos, *tmp;
> +
> +       if (unlikely(num_descs > 1)) {
> +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {
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
> @@ -609,6 +657,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>  {
>         struct xsk_buff_pool *pool =3D xs->pool;
>         u32 hr, len, ts, offset, copy, copied;
> +       struct xsk_addr_node *xsk_addr;
>         struct sk_buff *skb =3D xs->skb;
>         struct page *page;
>         void *buffer;
> @@ -623,6 +672,19 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>                         return ERR_PTR(err);
>
>                 skb_reserve(skb, hr);
> +
> +               xsk_set_destructor_arg(skb, desc->addr);
> +       } else {
> +               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> +               if (!xsk_addr)

nit: unlikely(). No need to respin :)

> +                       return ERR_PTR(-ENOMEM);
> +
> +               /* in case of -EOVERFLOW that could happen below,
> +                * xsk_consume_skb() will release this node as whole skb
> +                * would be dropped, which implies freeing all list eleme=
nts
> +                */
> +               xsk_addr->addr =3D desc->addr;
> +               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_li=
st);
>         }
>
>         addr =3D desc->addr;
> @@ -694,8 +756,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>                         err =3D skb_store_bits(skb, 0, buffer, len);
>                         if (unlikely(err))
>                                 goto free_err;
> +
> +                       xsk_set_destructor_arg(skb, desc->addr);
>                 } else {
>                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
> +                       struct xsk_addr_node *xsk_addr;
>                         struct page *page;
>                         u8 *vaddr;
>
> @@ -710,12 +775,22 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>                                 goto free_err;
>                         }
>
> +                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he, GFP_KERNEL);
> +                       if (!xsk_addr) {

same here.

Thanks,
Jason

> +                               __free_page(page);
> +                               err =3D -ENOMEM;
> +                               goto free_err;
> +                       }
> +
>                         vaddr =3D kmap_local_page(page);
>                         memcpy(vaddr, buffer, len);
>                         kunmap_local(vaddr);
>
>                         skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE=
_SIZE);
>                         refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> +
> +                       xsk_addr->addr =3D desc->addr;
> +                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->=
addrs_list);
>                 }
>
>                 if (first_frag && desc->options & XDP_TX_METADATA) {
> @@ -759,7 +834,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>         skb->destructor =3D xsk_destruct_skb;
>         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> -       xsk_set_destructor_arg(skb);
> +       xsk_inc_num_desc(skb);
>
>         return skb;
>
> @@ -769,7 +844,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>
>         if (err =3D=3D -EOVERFLOW) {
>                 /* Drop the packet */
> -               xsk_set_destructor_arg(xs->skb);
> +               xsk_inc_num_desc(xs->skb);
>                 xsk_drop_skb(xs->skb);
>                 xskq_cons_release(xs->tx);
>         } else {
> @@ -812,7 +887,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                  * if there is space in it. This avoids having to impleme=
nt
>                  * any buffering in the Tx path.
>                  */
> -               err =3D xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +               err =3D xsk_cq_reserve_locked(xs->pool);
>                 if (err) {
>                         err =3D -EAGAIN;
>                         goto out;
> @@ -1815,8 +1890,18 @@ static int __init xsk_init(void)
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
> 2.43.0
>

