Return-Path: <bpf+bounces-66580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F5B37232
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1128E17BD
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FD36C09D;
	Tue, 26 Aug 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrseOo+H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245136C08B;
	Tue, 26 Aug 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232600; cv=none; b=qc1rkrO6wX4mll8/VTJU/QMV7GVzRGDp3nZYqNlJuvg6t6/5db2SE8nXsG3tCLb1HFj4371i35fm05rttanySPGSHH+Uycx35o2trKrVnKDcsb7nWOob+hbOVi7kW/mT4QvvoZgTIhQS+ul7bLmFIpNEgYWPyxhOCxqCVfW/61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232600; c=relaxed/simple;
	bh=nG0LAoDZdbxXuN/Hr/0F6rww6bawQ9DQyl8dy8CNHmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOZfA9UHdsmVqTRMdqfNpwGL59gUGozg+PPFp69ue5bHItiahazwP1QCF3P5pjWR/j7ST0BP71JPJYLw4Ud4PSdmu+dY3SD/6ZxccbWV1lx631KJsAmgKrlfNg7i9KMR7t9eAvEHZkgKYOJyXr/vBzVQ2mVOd1XSSjLasvolc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrseOo+H; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70dd6c93071so6375026d6.3;
        Tue, 26 Aug 2025 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756232596; x=1756837396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0foMCM1hvjEeKXaZN/6MBKUAq8npEAyxEc6PIGRqNY=;
        b=VrseOo+HfLGGfrEaH0OBhSxWtQadExyjljlnNqmfG30HZ2ClaVtGXXvnEnnA/agtcQ
         rM53z1IHY0NYw/9y22IdJB4hysmXa0OTIjb62Jz3b6CTehl3Swl1KcN4csVuLPDN1sdd
         Z1HncLhYaX9pslz1d4F+OhFCylhhPZc/8ImVwjoOB4EMOkau6cUPJ3yom/3x5GYMETHN
         GgQPAunMAitTiulejef9Htqzz5mCYK45s/zVfEZAKyTFL4UBu9127FW8sNyBGxaXxnkH
         oQXk9WIwilrVVfD4Yi8bVXTCkLibKRYBDRehcdyVMokF0Go3Alyk4965DthhzAa3ePIP
         Tu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232596; x=1756837396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0foMCM1hvjEeKXaZN/6MBKUAq8npEAyxEc6PIGRqNY=;
        b=WM9Qv80h4ASqxMupC0xzeYPqltihVVeI/8dgj7Bc55NCTKSeLlfZtFq9vl7fMRWojv
         6zqRcEH1Xns5fxab/nIKamkNWpxF8/vBE8/CKwqDfedqYRxbEfwPUCOfreQ9DLTHeJUr
         jRnm9fsPEO4mCzgcexuOvnmv6Nu942rWIto5wc6Ce52AHu/9ownPRcJGx+gKYoNNWgZH
         gYr1whL5OY1qOA+MMsTL5oumE6G0E9jW82Wl5i1P9sSY9nGx2q4Z4t5sH77CcKklAoHb
         V59mQ14q6A87ln+ItNNDoyEb1+EK8MDQGO0e5TOLT3GREtNrYJzuohIRluNE0P2QR0iN
         uAvg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Lk7+MJIl98wdah/D+PthIT3FwuFRU3MpOsl7BSn6THlMM9l9itZVtESAic2IFDzEP+N50pnS@vger.kernel.org, AJvYcCVLtgvC8Z/RdvkJmvtjjG53xM73K2twPOK39aXOoZj11W84UyPMf8Srh4SKcAJttld8pbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/AY2x/0X9ojqqCwzLi7EmfRphClugk2Wqm5fQH4t5VAlRC6ZZ
	xN7mBHBuhFsB+63LTGGddJoAb2AH9Zu9gS/4gvYgleRhWETE6zBnjFEg5psK7O+lJvM9uC6yO+e
	11umUo2tGS/xTyl715Knsc+Mn3/f73ys=
X-Gm-Gg: ASbGnctfMGjP5fXnq7xQheH7bHMB5akBZyC/gXG8SBI68W2TM0sDQ7hUdl/P8aS9Wsa
	4Cwi2oP2c16Zn+u9tdhmX9NA7stRjwc/BRnayZg+dLVvaeboOxDTd8NMqiHOAtWaa/aybgWDrdw
	FzzDwYolLNmTpRaJqRx5cygOcpttY0F/cZtYjnZOTtuuFRKKnOqiaN5Cmz0eb8zD1RTLHRy1ZF5
	LB6S7kj
X-Google-Smtp-Source: AGHT+IEVnvtJqP/mct1oC46f9ueuzZHZZeXUWdZh3wHq0B/KLm5wsasZDFPdETADAGAT18pn6+xJSaadZyrhdztr5v0=
X-Received: by 2002:a05:6214:4b02:b0:70d:9f16:9a37 with SMTP id
 6a1803df08f44-70d9f16c223mr183770166d6.62.1756232595587; Tue, 26 Aug 2025
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com> <CAL+tcoD3Kj6h=RvkEJ_9vmJPWKGVcaLj4ws=JqRbE0TiyjDDWg@mail.gmail.com>
In-Reply-To: <CAL+tcoD3Kj6h=RvkEJ_9vmJPWKGVcaLj4ws=JqRbE0TiyjDDWg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 26 Aug 2025 20:23:04 +0200
X-Gm-Features: Ac12FXxh9dXBN_CQ0mKUK-fHC6Hxit2dnlUBB4nf4-f-lGJ75BEyztz8Tk5lz3U
Message-ID: <CAJ8uoz0v4sdj8YwadpCKpDSpY1JrJnO_kkEfHHyv+qAFMiKOOQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, aleksander.lobakin@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 18:07, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> On Wed, Aug 20, 2025 at 11:49=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> >
> > Introduce struct xsk_addrs which will carry descriptor count with array
> > of addresses taken from processed descriptors that will be carried via
> > skb_shared_info::destructor_arg. This way we can refer to it within
> > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > coming from memory allocations, let us introduce kmem_cache of
> > xsk_addrs. There will be a single kmem_cache for xsk generic xmit on th=
e
> > system.
> >
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when xsk multi-buffer got introduced.
> >
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supportin=
g multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubansk=
i@partner.samsung.com/
> > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski=
@intel.com/
> > v2:
> > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski=
@intel.com/
> > v3:
> > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski=
@intel.com/
> > v4:
> > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski=
@intel.com/
> > v5:
> > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> >
> > v1->v2:
> > * store addrs in array carried via destructor_arg instead having them
> >   stored in skb headroom; cleaner and less hacky approach;
> > v2->v3:
> > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > * set err when xsk_addrs allocation fails (Dan)
> > * change xsk_addrs layout to avoid holes
> > * free xsk_addrs on error path
> > * rebase
> > v3->v4:
> > * have kmem_cache as percpu vars
> > * don't drop unnecessary braces (unrelated) (Stan)
> > * use idx + i in xskq_prod_write_addr (Stan)
> > * alloc kmem_cache on bind (Stan)
> > * keep num_descs as first member in xsk_addrs (Magnus)
> > * add ack from Magnus
> > v4->v5:
> > * have a single kmem_cache per xsk subsystem (Stan)
> > v5->v6:
> > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
> >   (Stan)
> > * unregister netdev notifier if creating kmem_cache fails (Stan)
> >
> > ---
> >  net/xdp/xsk.c       | 95 +++++++++++++++++++++++++++++++++++++--------
> >  net/xdp/xsk_queue.h | 12 ++++++
> >  2 files changed, 91 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..989d5ffb4273 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -36,6 +36,13 @@
> >  #define TX_BATCH_SIZE 32
> >  #define MAX_PER_SOCKET_BUDGET 32
> >
> > +struct xsk_addrs {
> > +       u32 num_descs;
> > +       u64 addrs[MAX_SKB_FRAGS + 1];
> > +};
> > +
> > +static struct kmem_cache *xsk_tx_generic_cache;
>
> IMHO, adding a few heavy operations of allocating and freeing from
> cache in the hot path is not a good choice. What I've been trying so
> hard lately is to minimize the times of manipulating memory as much as
> possible :( Memory hotspot can be easily captured by perf.
>
> We might provide an new option in setsockopt() to let users
> specifically support this use case since it does harm to normal cases?

Agree with you that we should not harm the normal case here. Instead
of introducing a setsockopt, how about we detect the case when this
can happen in the code? If I remember correctly, it can only occur in
the XDP_SHARED_UMEM mode were the xsk pool is shared between
processes. If this can be tested (by introducing a new bit in the xsk
pool if that is necessary), we could have two potential skb
destructors: the old one for the "normal" case and the new one with
the list of addresses to complete (using the expensive allocations and
deallocations) when it is strictly required i.e., when the xsk pool is
shared. Maciej, you are more in to the details of this, so what do you
think? Would something like this be a potential path forward?

>
> > +
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 fla=
gs)
> >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags=
);
> >  }
> >
> > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 =
addr)
> > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> >         unsigned long flags;
> >         int ret;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       ret =3D xskq_prod_reserve_addr(pool->cq, addr);
> > +       ret =3D xskq_prod_reserve(pool->cq);
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >
> >         return ret;
> >  }
> >
> > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > +                                     struct sk_buff *skb)
> >  {
> > +       struct xsk_buff_pool *pool =3D xs->pool;
> > +       struct xsk_addrs *xsk_addrs;
> >         unsigned long flags;
> > +       u32 num_desc, i;
> > +       u32 idx;
> > +
> > +       xsk_addrs =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_a=
rg;
> > +       num_desc =3D xsk_addrs->num_descs;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       xskq_prod_submit_n(pool->cq, n);
> > +       idx =3D xskq_get_prod(pool->cq);
> > +
> > +       for (i =3D 0; i < num_desc; i++)
> > +               xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addr=
s[i]);
> > +       xskq_prod_submit_n(pool->cq, num_desc);
> > +
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > +       kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
> >  }
> >
> >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > @@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_p=
ool *pool, u32 n)
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  }
> >
> > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > -{
> > -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > -}
> > -
> >  static void xsk_destruct_skb(struct sk_buff *skb)
> >  {
> >         struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_m=
eta;
> > @@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> >                 *compl->tx_timestamp =3D ktime_get_tai_fast_ns();
> >         }
> >
> > -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(sk=
b));
> > +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> >         sock_wfree(skb);
> >  }
> >
> > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> >  {
> > -       long num =3D xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > +       struct xsk_addrs *addrs;
> >
> > -       skb_shinfo(skb)->destructor_arg =3D (void *)num;
> > +       addrs =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +       return addrs->num_descs;
> > +}
> > +
> > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_add=
rs *addrs)
> > +{
> > +       skb_shinfo(skb)->destructor_arg =3D (void *)addrs;
> > +}
> > +
> > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > +{
> > +       struct xsk_addrs *addrs;
> > +
> > +       addrs =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +       addrs->num_descs++;
> >  }
> >
> >  static void xsk_consume_skb(struct sk_buff *skb)
> >  {
> >         struct xdp_sock *xs =3D xdp_sk(skb->sk);
> >
> > +       kmem_cache_free(xsk_tx_generic_cache,
> > +                       (struct xsk_addrs *)skb_shinfo(skb)->destructor=
_arg);
>
> Replying to Daniel here: when EOVERFLOW occurs, it will finally go to
> above function and clear the allocated memory and skb.
>
> >         skb->destructor =3D sock_wfree;
> >         xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> >         /* Free skb without triggering the perf drop trace */
> > @@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >  {
> >         struct xsk_buff_pool *pool =3D xs->pool;
> >         u32 hr, len, ts, offset, copy, copied;
> > +       struct xsk_addrs *addrs =3D NULL;
>
> nit: no need to set to "NULL" at the begining.
>
> >         struct sk_buff *skb =3D xs->skb;
> >         struct page *page;
> >         void *buffer;
> > @@ -623,6 +656,14 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >                         return ERR_PTR(err);
> >
> >                 skb_reserve(skb, hr);
> > +
> > +               addrs =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_K=
ERNEL);
> > +               if (!addrs) {
> > +                       kfree(skb);
> > +                       return ERR_PTR(-ENOMEM);
> > +               }
> > +
> > +               xsk_set_destructor_arg(skb, addrs);
> >         }
> >
> >         addr =3D desc->addr;
> > @@ -662,6 +703,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >  {
> >         struct xsk_tx_metadata *meta =3D NULL;
> >         struct net_device *dev =3D xs->dev;
> > +       struct xsk_addrs *addrs =3D NULL;
> >         struct sk_buff *skb =3D xs->skb;
> >         bool first_frag =3D false;
> >         int err;
> > @@ -694,6 +736,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >                         err =3D skb_store_bits(skb, 0, buffer, len);
> >                         if (unlikely(err))
> >                                 goto free_err;
> > +
> > +                       addrs =3D kmem_cache_zalloc(xsk_tx_generic_cach=
e, GFP_KERNEL);
> > +                       if (!addrs) {
> > +                               err =3D -ENOMEM;
> > +                               goto free_err;
> > +                       }
> > +
> > +                       xsk_set_destructor_arg(skb, addrs);
> > +
> >                 } else {
> >                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
> >                         struct page *page;
> > @@ -759,7 +810,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> >         skb->destructor =3D xsk_destruct_skb;
> >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > -       xsk_set_destructor_arg(skb);
> > +
> > +       addrs =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +       addrs->addrs[addrs->num_descs++] =3D desc->addr;
> >
> >         return skb;
> >
> > @@ -769,7 +822,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >         if (err =3D=3D -EOVERFLOW) {
> >                 /* Drop the packet */
> > -               xsk_set_destructor_arg(xs->skb);
> > +               xsk_inc_skb_descs(xs->skb);
> >                 xsk_drop_skb(xs->skb);
> >                 xskq_cons_release(xs->tx);
> >         } else {
> > @@ -812,7 +865,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                  * if there is space in it. This avoids having to imple=
ment
> >                  * any buffering in the Tx path.
> >                  */
> > -               err =3D xsk_cq_reserve_addr_locked(xs->pool, desc.addr)=
;
> > +               err =3D xsk_cq_reserve_locked(xs->pool);
> >                 if (err) {
> >                         err =3D -EAGAIN;
> >                         goto out;
> > @@ -1815,8 +1868,18 @@ static int __init xsk_init(void)
> >         if (err)
> >                 goto out_pernet;
> >
> > +       xsk_tx_generic_cache =3D kmem_cache_create("xsk_generic_xmit_ca=
che",
> > +                                                sizeof(struct xsk_addr=
s), 0,
> > +                                                SLAB_HWCACHE_ALIGN, NU=
LL);
> > +       if (!xsk_tx_generic_cache) {
> > +               err =3D -ENOMEM;
> > +               goto out_unreg_notif;
> > +       }
> > +
> >         return 0;
> >
> > +out_unreg_notif:
> > +       unregister_netdevice_notifier(&xsk_netdev_notifier);
> >  out_pernet:
> >         unregister_pernet_subsys(&xsk_net_ops);
> >  out_sk:
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 46d87e961ad6..f16f390370dc 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct=
 xsk_queue *q)
> >
> >  /* Functions for producers */
> >
> > +static inline u32 xskq_get_prod(struct xsk_queue *q)
> > +{
> > +       return READ_ONCE(q->ring->producer);
> > +}
> > +
> >  static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
> >  {
> >         u32 free_entries =3D q->nentries - (q->cached_prod - q->cached_=
cons);
> > @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xs=
k_queue *q, u64 addr)
> >         return 0;
> >  }
> >
> > +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, =
u64 addr)
> > +{
> > +       struct xdp_umem_ring *ring =3D (struct xdp_umem_ring *)q->ring;
> > +
> > +       ring->desc[idx & q->ring_mask] =3D addr;
> > +}
> > +
> >  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, str=
uct xdp_desc *descs,
> >                                               u32 nb_entries)
> >  {
> > --
> > 2.34.1
> >
> >
>

