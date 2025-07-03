Return-Path: <bpf+bounces-62354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAAAF847B
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1173544019
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012A2DA765;
	Thu,  3 Jul 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZHiUw6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B492D5416;
	Thu,  3 Jul 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586470; cv=none; b=b0A27cCK08MYJp6mVoLjUbVSBx2NGAx4XrM8auPAIMwToUGhjRgowbdbd/cbE9s8Mj8w/9T83XCsl+HZQE+GqnhtRZUMCLD/8GXcxg1iz/J1Qv/bY/rcIU2Fj1IVnp3ynFACZSW6XRWR0tq41HhprI/zorn4+/KnlvO3SCOGC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586470; c=relaxed/simple;
	bh=JhrisTUjjwboOepd6URG1hyzjaEjGbldyn3c4LJF0kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIFsMwZLplnEEh75FJIdOVIxslBGjFahTnbpAdcu2r+IBOBXx2d4lhsa+xBxz3uhihse8TWuGcPr2cDcjYhKPsEJwo0kh/MQtJVGIB2iLX+7w/gw7z4dBBE5JP60QHqwynCkQJY+bF+y1sqW9gb+w1EPIKMFkEA9iHdAyqEP1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZHiUw6j; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-875b52a09d1so15004639f.0;
        Thu, 03 Jul 2025 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751586468; x=1752191268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQLKGV3U2CdFXlUgYtnwPBEJpuPq6tX2mdMxCMFIC7c=;
        b=nZHiUw6jbZHGAaCf/dQHRRTFaZdUbRjFoNzdx55frCTYg2tzeHK2ZEZn64oIFP9xhH
         VScRDbzB4GmFQQx8N5Mg+m4Wrltp8vvuXiZDJnJvPVIl9mevSy0IuE+bIdGzGICekreN
         SH1W23EIVPjMpn4+Iry57ulR85Qu3rXp08vRaJEZN5aKm/NEyKvQUsOwMlTlzKZN7+By
         WFheuHXG30cO1Rre5Hha5+Sx8TnApVtPI0cjmBFOwfOolsSuuNL/nfLZs7h6fADywQXb
         +ajHxJwOc9vt3Cn/OlwS1sDBCctNCXlQGt2GkKf68vK01I1zhbujsin2jJJbsEEsQqhe
         PNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751586468; x=1752191268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQLKGV3U2CdFXlUgYtnwPBEJpuPq6tX2mdMxCMFIC7c=;
        b=tCc9EA4R4+OLA7wnaJXPv09N/iOVab21qHgTBTdL/sIkUIAD/iGs1/SJp0DyGqFkVn
         X7ALgO18Nx18/+kDoct4HNWrvoBJyIqdojmNr4AkSrlFcbSGPD18/tF+e91pXw74gTx4
         k9MSETcTZlvDH4G/aoC3IsZY2zeUDd8PLeyqBNWO2YGd515uzvKPZUK0lMT0Hjn53t/1
         qx4TEhFDzYygWcPl6o3GRXOmITj98mm9uIbrgIcgJmOSnXl0WZtES7kyAwvocRFd/h1Z
         m5gNQG7/R/BslruqSY6AWpbwfffWc9LHeguoDIFyn6Hnc/RdSgwUOFqo+MXmP0wzwE3T
         LILA==
X-Forwarded-Encrypted: i=1; AJvYcCXpESi/WQkJ06YCRBhRJJ4TNmTxW7iPtrAAV89u3ByanzwUh6NLSANp/86jg4SUZq7MfKR9tZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxn7BSbcw8P/ZqiFNRNt2N3a3BRoxG8GhIajLNDCw5SLF1xfR
	54Uv+MsGM42msVKbg84MOD8C+RjT3BWl0O8Om95CyuALKucqFKeSeQUoQGuQqrRdYoQm2KANVd2
	Jm/inP0dxP0lXV/AdMigdQ6QSfMp79rk=
X-Gm-Gg: ASbGnctSa+BcKwxdzWMb8N0B8PCX+CJwoWXqDfrggqAe+kckCQcG8lkYVior1q7tVdK
	cbs/bhKcfvxIjEd+ORE5foKYynBL6QMST3nhcaWhQ7nZ01l8DxpZ2eLK1mj5K0hZkCoWxSNoTcf
	h2EAgdF0a4x32g1ydwTLQ9vTPpvxvpY5J4IXKExftQZys=
X-Google-Smtp-Source: AGHT+IGjls8BRUk8mviiLVJlcE94V6nectcHEzWwPO2Mc5e+sIkMcRCm5x7uqLhBySepDFu9ht5JRUnzG7M0DXtVlFo=
X-Received: by 2002:a05:6e02:1fc2:b0:3dc:7c44:d006 with SMTP id
 e9e14a558f8ab-3e1354bfa65mr4838415ab.8.1751586467657; Thu, 03 Jul 2025
 16:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Jul 2025 07:47:11 +0800
X-Gm-Features: Ac12FXyj-zpY0u9QdDeIjgfjSBZ-N9hlyrYFvzIxdB78XVguHj7xuO5zQxQjpUA
Message-ID: <CAL+tcoBkBpmnzM8zv285qf8Q9QvyRe7gRvZhNsjdtnrAaFsK1g@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Wed, Jul 2, 2025 at 6:17=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.

I wonder if you can add more descriptions on how the issue can be
triggered? I got lost there thoroughly. Probably he used too many
words than codes to explain, which took me a long time to
interpret/decrypt on my own. Please see the link below
https://lore.kernel.org/all/CAL+tcoAk3X2qM7gkeBw60hQ6VKd0Pv0jMtKaEB9uFw0DE=
=3DOY2A@mail.gmail.com/

Thanks,
Jason

>
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
>
> Store addrs at the beginning of skb's linear part and have a sanity
> check if in any case driver would encapsulate headers in a way that data
> would overwrite the [head, head + sizeof(xdp_desc::addr) *
> (MAX_SKB_FRAGS + 1)] region, which we dedicate for umem addresses that
> will be produced onto xsk_buff_pool's completion queue.
>
> This approach appears to survive scenario where underlying driver
> linearizes the skb because pskb_pull_tail() under the hood will copy
> header part to newly allocated memory. If this array would live in
> tailroom it would get overridden when pulling frags onto linear part.
> This happens when driver receives skb with frag count higher than what
> HW is able to swallow (I came across this case on ice driver that has
> maximum s/g count equal to 8).
>
> Initially we also considered storing 8-byte addr at the end of page
> allocated by frag but xskxceiver has a test which writes full 4k to frag
> and this resulted in corrupted addr.
>
> xsk_cq_submit_addr_locked() has to use xsk_get_num_desc() to find out
> frag count as skb that we deal with within destructor might not have the
> frags at all - as mentioned earlier drivers in their ndo_start_xmit()
> might linearize the skb. We will not use cached_prod to update
> producer's global state as its value might already have been increased,
> which would result in too many addresses being submitted onto cq.
>
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting =
multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@=
partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c       | 92 +++++++++++++++++++++++++++++++--------------
>  net/xdp/xsk_queue.h | 12 ++++++
>  2 files changed, 75 insertions(+), 29 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..86473073513c 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -528,27 +528,18 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags=
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
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&pool->cq_lock, flags);
> -       xskq_prod_submit_n(pool->cq, n);
> -       spin_unlock_irqrestore(&pool->cq_lock, flags);
> -}
> -
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  {
>         unsigned long flags;
> @@ -563,19 +554,6 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
>         return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
>  }
>
> -static void xsk_destruct_skb(struct sk_buff *skb)
> -{
> -       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_met=
a;
> -
> -       if (compl->tx_timestamp) {
> -               /* sw completion timestamp, not a real one */
> -               *compl->tx_timestamp =3D ktime_get_tai_fast_ns();
> -       }
> -
> -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb)=
);
> -       sock_wfree(skb);
> -}
> -
>  static void xsk_set_destructor_arg(struct sk_buff *skb)
>  {
>         long num =3D xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> @@ -600,11 +578,52 @@ static void xsk_drop_skb(struct sk_buff *skb)
>         xsk_consume_skb(skb);
>  }
>
> +static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> +                                     struct sk_buff *skb)
> +{
> +       unsigned long flags;
> +       u32 num_desc, i;
> +       u64 *addr;
> +       u32 idx;
> +
> +       if (unlikely(skb->data <=3D skb->head + sizeof(u64) * (MAX_SKB_FR=
AGS + 1))) {
> +               WARN(1, "possible corruption of umem addr array; dropping=
 skb");
> +               xsk_drop_skb(skb);
> +               return;
> +       }
> +
> +       num_desc =3D xsk_get_num_desc(skb);
> +
> +       spin_lock_irqsave(&pool->cq_lock, flags);
> +       idx =3D xskq_get_prod(pool->cq);
> +
> +       for (i =3D 0, addr =3D (u64 *)(skb->head); i < num_desc; i++, add=
r++, idx++)
> +               xskq_prod_write_addr(pool->cq, idx, *addr);
> +       xskq_prod_submit_n(pool->cq, num_desc);
> +
> +       spin_unlock_irqrestore(&pool->cq_lock, flags);
> +}
> +
> +static void xsk_destruct_skb(struct sk_buff *skb)
> +{
> +       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_met=
a;
> +
> +       if (compl->tx_timestamp) {
> +               /* sw completion timestamp, not a real one */
> +               *compl->tx_timestamp =3D ktime_get_tai_fast_ns();
> +       }
> +
> +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
> +       sock_wfree(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> +       size_t addr_arr_sz =3D sizeof(desc->addr) * (MAX_SKB_FRAGS + 1);
>         struct xsk_buff_pool *pool =3D xs->pool;
>         u32 hr, len, ts, offset, copy, copied;
> +       size_t addr_sz =3D sizeof(desc->addr);
>         struct sk_buff *skb =3D xs->skb;
>         struct page *page;
>         void *buffer;
> @@ -614,11 +633,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
>         if (!skb) {
>                 hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_he=
adroom));
>
> -               skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
> +               skb =3D sock_alloc_send_skb(&xs->sk, hr + addr_arr_sz, 1,=
 &err);
>                 if (unlikely(!skb))
>                         return ERR_PTR(err);
>
> -               skb_reserve(skb, hr);
> +               skb_reserve(skb, hr + addr_arr_sz);
>         }
>
>         addr =3D desc->addr;
> @@ -648,6 +667,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>         skb->data_len +=3D len;
>         skb->truesize +=3D ts;
>
> +       memcpy(skb->head + (addr_sz * xsk_get_num_desc(skb)),
> +              &desc->addr, addr_sz);
> +
>         refcount_add(ts, &xs->sk.sk_wmem_alloc);
>
>         return skb;
> @@ -656,10 +678,13 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
>  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>                                      struct xdp_desc *desc)
>  {
> +       size_t addr_arr_sz =3D sizeof(desc->addr) * (MAX_SKB_FRAGS + 1);
> +       size_t addr_sz =3D sizeof(desc->addr);
>         struct xsk_tx_metadata *meta =3D NULL;
>         struct net_device *dev =3D xs->dev;
>         struct sk_buff *skb =3D xs->skb;
>         bool first_frag =3D false;
> +       u8 *addr_arr;
>         int err;
>
>         if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> @@ -680,16 +705,21 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>
>                         hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->neede=
d_headroom));
>                         tr =3D dev->needed_tailroom;
> -                       skb =3D sock_alloc_send_skb(&xs->sk, hr + len + t=
r, 1, &err);
> +                       skb =3D sock_alloc_send_skb(&xs->sk,
> +                                                 hr + addr_arr_sz + len =
+ tr,
> +                                                 1, &err);
>                         if (unlikely(!skb))
>                                 goto free_err;
>
> -                       skb_reserve(skb, hr);
> +                       skb_reserve(skb, hr + addr_arr_sz);
>                         skb_put(skb, len);
>
>                         err =3D skb_store_bits(skb, 0, buffer, len);
>                         if (unlikely(err))
>                                 goto free_err;
> +                       addr_arr =3D skb->head;
> +                       memcpy(addr_arr, &desc->addr, addr_sz);
> +
>                 } else {
>                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
>                         struct page *page;
> @@ -712,6 +742,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>
>                         skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE=
_SIZE);
>                         refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> +
> +                       addr_arr =3D skb->head;
> +                       memcpy(addr_arr + (addr_sz * skb_shinfo(skb)->nr_=
frags),
> +                              &desc->addr, addr_sz);
>                 }
>
>                 if (first_frag && desc->options & XDP_TX_METADATA) {
> @@ -807,7 +841,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                  * if there is space in it. This avoids having to impleme=
nt
>                  * any buffering in the Tx path.
>                  */
> -               err =3D xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +               err =3D xsk_cq_reserve_locked(xs->pool);
>                 if (err) {
>                         err =3D -EAGAIN;
>                         goto out;
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
>

