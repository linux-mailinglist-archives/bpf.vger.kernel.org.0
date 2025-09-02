Return-Path: <bpf+bounces-67133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A740B3F16A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC926486B6C
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED200846F;
	Tue,  2 Sep 2025 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDbdYDDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC80800;
	Tue,  2 Sep 2025 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756771390; cv=none; b=d48lWEX7QadT3iU+mCJlj7UOY9o1clCUOoEYg0AIFRpNe75cqPpnABFhOR8UfQGKGRPuAQBJVMllE3vu8QrQmYZThtF6mhcPEL7Z8PuG+7j4b5QdZ0D76KNxiiqCJ3+wxz+iZoFPy5kAOBOz/q5cob3PBLG7FGhr4f7f52ttfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756771390; c=relaxed/simple;
	bh=Geitvja3O228NzUBTEi0zE6TvgFlscsUnzakAI5JDlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KulsdhaYnvbgjMiTUjSrv6XLA1cbncS/aQp+hGHS4PZpTf0rbT1+Euxn2lSfPZDkVjdaUYH1eqOWm0JVj2fmEhzAbvZFedd6aOcxhzKaTOw7ihMnebVZhZik788PR1rUiSKJYB3dlcJSLVBUzA45fg8e5ZPZgBIN+kBGc7zl/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDbdYDDU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f024dfdfdaso47754405ab.1;
        Mon, 01 Sep 2025 17:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756771388; x=1757376188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOg6KXLjSPrb5PsVDFm2c1S9anYWt7fB4SqUjbgQDK8=;
        b=mDbdYDDUqK8xuGnigLRMtqdlfEpj94boJlxE06BZOuV/KblFrOc3AVYb72UnGuObr/
         SLT44VzDSjaolIBA4hGKzYNgdMtY/VZxXKz8zc2+eI2t1XF+q3pBjnnIJgceoVA0xPpJ
         Z5fdTF4Qef4Zfih/RKi6TLat/O2RcQ2ONW0OJuxsMA0UQ3qxZrZfJMK6Vqs0/JAIgqbY
         oAAYhPbr2DjM6yxWRwF4GKA57br9TdoRlFjU5hGYagAgimOaGyrWP8JIgx3b1e/K52xa
         IcriMrSYVtPJftJgIWFZkR7j2HVtJ425OokOMgknTXCn3vUBasB0SVWXKjeNTZmhJXPW
         EWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756771388; x=1757376188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOg6KXLjSPrb5PsVDFm2c1S9anYWt7fB4SqUjbgQDK8=;
        b=CIXaQmC1o+a2kSD2rfcGo8wkBj8pM38+dB41iCwl1vFAiHxukaLXg53pEfPkd3Rvcg
         PXbGdSyUtOTOX26z6Z+DTNaowIUBn5ZtqDR9wzH4zKYYIpptbduiJg0kieHopqQwL3dM
         BK9ImZvn3fhyqOHvcNkhhlq21Dhs0aEC6VMecb/5Zdzn/wvcb64fFFXeookTuVIhIzzg
         3W50y+OBo28AhIsiJRqBnJVECq/KYC3FmVGSY0RMYyzzvsHiwxjmlWI744blA209In9T
         LcwDTu28TuBdLOZAFWEp5MMvNlFhNUKp7HmpMJde7blcGOgGR7C+IgAxEqizKCe5J6Sh
         bNpA==
X-Forwarded-Encrypted: i=1; AJvYcCXZK5yQn8ZPdrZtomekr2azKFs7qrYOUyTSZsZUDoPmegDW45nAtJ/QTMZXCGpKpF5vVXIKI28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6o3CAPsWw0GP0pxqRf/zCoHyicu+AlXMyaC95E1fzwKoVGHd
	ybFR5sG7nR7CFPX7lS87uBCSsLUSrTfCkk09oqhQ83qfrVMOUUespr/Eseb4JiLP30Xs+3XAdrW
	adwQJHVIP63iOETTWLy/Qiew+ANzVFVDbVqOVc8dnDA==
X-Gm-Gg: ASbGncsL9DOWzZyynJHr13PVlSkhwaq1CfTDkwcRPIRTLmxS/19eFGDXtC4nsUBJweM
	jABPPgZl66XxHl7L2x1pnuzDIW+Qe4QQXOPghFi9o3h4HE1SPU6nS6cWVDe2mENk+iixx58aP9f
	5cpWkesbmRiVgKiyTs8MnPILo1twDhdNQCdrdov7gXGHv4rtBnOq/MlUg2gc6Yt4L8CkYuBG+6l
	v4Ak8RJbcfY1fmk
X-Google-Smtp-Source: AGHT+IHDt1yQyaugRJpO4792/i0DBKRm7lNbK0yBTXBk1nhxrv+LAPHRTuiVfOTTCED94QR0q1TC0q1QJ8MQKdv7Si8=
X-Received: by 2002:a05:6e02:250a:b0:3f0:c326:538a with SMTP id
 e9e14a558f8ab-3f4027b87ffmr162897405ab.27.1756771387605; Mon, 01 Sep 2025
 17:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com> <aLYD2iq+traoJZ7R@boxer>
In-Reply-To: <aLYD2iq+traoJZ7R@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 08:02:30 +0800
X-Gm-Features: Ac12FXzLOQr1B4GQbOEPJGpQSZdLADQPxc3O63Y2b7GuriQ8oCjHmGgGz3apu2o
Message-ID: <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:37=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Sep 02, 2025 at 12:09:39AM +0800, Jason Xing wrote:
> > On Sat, Aug 30, 2025 at 2:10=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > Eryk reported an issue that I have put under Closes: tag, related to
> > > umem addrs being prematurely produced onto pool's completion queue.
> > > Let us make the skb's destructor responsible for producing all addrs
> > > that given skb used.
> > >
> > > Commit from fixes tag introduced the buggy behavior, it was not broke=
n
> > > from day 1, but rather when XSK multi-buffer got introduced.
> > >
> > > In order to mitigate performance impact as much as possible, mimic th=
e
> > > linear and frag parts within skb by storing the first address from XS=
K
> > > descriptor at sk_buff::destructor_arg. For fragments, store them at :=
:cb
> > > via list. The nodes that will go onto list will be allocated via
> > > kmem_cache. xsk_destruct_skb() will consume address stored at
> > > ::destructor_arg and optionally go through list from ::cb, if count o=
f
> > > descriptors associated with this particular skb is bigger than 1.
> > >
> > > Previous approach where whole array for storing UMEM addresses from X=
SK
> > > descriptors was pre-allocated during first fragment processing yielde=
d
> > > too big performance regression for 64b traffic. In current approach
> > > impact is much reduced on my tests and for jumbo frames I observed
> > > traffic being slower by at most 9%.
> > >
> > > Magnus suggested to have this way of processing special cased for
> > > XDP_SHARED_UMEM, so we would identify this during bind and set differ=
ent
> > > hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> > > given that results looked promising on my side I decided to have a
> > > single data path for XSK generic Tx. I suppose other auxiliary stuff
> > > such as helpers introduced in this patch would have to land as well i=
n
> > > order to make it work, so we might have ended up with more noisy diff=
.
> > >
> > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for support=
ing multi-buffer in Tx path")
> > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kuban=
ski@partner.samsung.com/
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >
> > > Jason, please test this v7 on your setup, I would appreciate if you
> > > would report results from your testbed. Thanks!
> > >
> > > v1:
> > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkows=
ki@intel.com/
> > > v2:
> > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkows=
ki@intel.com/
> > > v3:
> > > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkows=
ki@intel.com/
> > > v4:
> > > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkows=
ki@intel.com/
> > > v5:
> > > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > > v6:
> > > https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkows=
ki@intel.com/
> > >
> > > v1->v2:
> > > * store addrs in array carried via destructor_arg instead having them
> > >   stored in skb headroom; cleaner and less hacky approach;
> > > v2->v3:
> > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > * set err when xsk_addrs allocation fails (Dan)
> > > * change xsk_addrs layout to avoid holes
> > > * free xsk_addrs on error path
> > > * rebase
> > > v3->v4:
> > > * have kmem_cache as percpu vars
> > > * don't drop unnecessary braces (unrelated) (Stan)
> > > * use idx + i in xskq_prod_write_addr (Stan)
> > > * alloc kmem_cache on bind (Stan)
> > > * keep num_descs as first member in xsk_addrs (Magnus)
> > > * add ack from Magnus
> > > v4->v5:
> > > * have a single kmem_cache per xsk subsystem (Stan)
> > > v5->v6:
> > > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fail=
s
> > >   (Stan)
> > > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > > v6->v7:
> > > * don't include Acks from Magnus/Stan; let them review the new
> > >   approach:)
> > > * store first desc at sk_buff::destructor_arg and rest of frags in li=
st
> > >   stored at sk_buff::cb
> > > * keep the kmem_cache but don't use it for allocation of whole array =
at
> > >   one shot but rather alloc single nodes of list
> > >
> > > ---
> > >  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-----=
--
> > >  net/xdp/xsk_queue.h | 12 ++++++
> > >  2 files changed, 97 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 9c3acecc14b1..3d12d1fbda41 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -36,6 +36,20 @@
> > >  #define TX_BATCH_SIZE 32
> > >  #define MAX_PER_SOCKET_BUDGET 32
> > >
> > > +struct xsk_addr_node {
> > > +       u64 addr;
> > > +       struct list_head addr_node;
> > > +};
> > > +
> > > +struct xsk_addr_head {
> > > +       u32 num_descs;
> > > +       struct list_head addrs_list;
> > > +};
> > > +
> > > +static struct kmem_cache *xsk_tx_generic_cache;
> > > +
> > > +#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> > > +
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > @@ -532,24 +546,41 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 f=
lags)
> > >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, fla=
gs);
> > >  }
> > >
> > > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u6=
4 addr)
> > > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >  {
> > >         unsigned long flags;
> > >         int ret;
> > >
> > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > -       ret =3D xskq_prod_reserve_addr(pool->cq, addr);
> > > +       ret =3D xskq_prod_reserve(pool->cq);
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >
> > >         return ret;
> > >  }
> > >
> > > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > > +static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> > > +                                     struct sk_buff *skb)
> > >  {
> > > +       struct xsk_addr_node *pos, *tmp;
> > >         unsigned long flags;
> > > +       u32 i =3D 0;
> > > +       u32 idx;
> > >
> > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > -       xskq_prod_submit_n(pool->cq, n);
> > > +       idx =3D xskq_get_prod(pool->cq);
> > > +
> > > +       xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->des=
tructor_arg);
> > > +       i++;
> > > +
> > > +       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs=
_list, addr_node) {
> > > +                       xskq_prod_write_addr(pool->cq, idx + i, pos->=
addr);
> > > +                       i++;
> > > +                       list_del(&pos->addr_node);
> > > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > > +               }
> > > +       }
> > > +       xskq_prod_submit_n(pool->cq, i);
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >  }
> > >
> > > @@ -562,9 +593,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff=
_pool *pool, u32 n)
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >  }
> > >
> > > +static void xsk_inc_num_desc(struct sk_buff *skb)
> > > +{
> > > +       XSKCB(skb)->num_descs++;
> > > +}
> > > +
> > >  static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >  {
> > > -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > > +       return XSKCB(skb)->num_descs;
> > >  }
> > >
> > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > > @@ -576,23 +612,32 @@ static void xsk_destruct_skb(struct sk_buff *sk=
b)
> > >                 *compl->tx_timestamp =3D ktime_get_tai_fast_ns();
> > >         }
> > >
> > > -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(=
skb));
> > > +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
> > >         sock_wfree(skb);
> > >  }
> > >
> > > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > > +static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> > >  {
> > > -       long num =3D xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > -
> > > -       skb_shinfo(skb)->destructor_arg =3D (void *)num;
> > > +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > +       XSKCB(skb)->num_descs =3D 0;
> > > +       skb_shinfo(skb)->destructor_arg =3D (void *)addr;
> > >  }
> > >
> > >  static void xsk_consume_skb(struct sk_buff *skb)
> > >  {
> > >         struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > > +       u32 num_descs =3D xsk_get_num_desc(skb);
> > > +       struct xsk_addr_node *pos, *tmp;
> > > +
> > > +       if (unlikely(num_descs > 1)) {
> >
> > I suspect the use of 'unlikely'. For some application turning on the
> > multi-buffer feature, if it tries to transmit a large chunk of data,
> > it can become 'likely' then. So it depends how people use it.
>
> This pattern is used in major of XDP multi-buffer related code, for
> example:
> $ grep -irn "xdp_buff_has_frags" net/core/xdp.c
> 553:    if (likely(!xdp_buff_has_frags(xdp)))
> 641:    if (unlikely(xdp_buff_has_frags(xdp))) {
> 777:    if (unlikely(xdp_buff_has_frags(xdp)) &&
>
> Drivers however tend to be mixed around this.

I see. And I have no strong opinion on this.

>
> >
> > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs=
_list, addr_node) {
> >
> > It seems no need to use xxx_safe() since the whole process (from
> > allocating skb to freeing skb) makes sure each skb can be processed
> > atomically?
>
> We're deleting nodes from linked list so we need the @tmp for further lis=
t
> traversal, I'm not following your statement about atomicity here?

I mean this list is chained around each skb. It's not possible for one
skb to do the allocation operation and free operation at the same
time, right? That means it's not possible for one list to do the
delete operation and add operation at the same time. If so, the
xxx_safe() seems unneeded.

>
> >
> > > +                       list_del(&pos->addr_node);
> > > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > > +               }
> > > +       }
> > >
> > >         skb->destructor =3D sock_wfree;
> > > -       xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > > +       xsk_cq_cancel_locked(xs->pool, num_descs);
> > >         /* Free skb without triggering the perf drop trace */
> > >         consume_skb(skb);
> > >         xs->skb =3D NULL;
> > > @@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(str=
uct xdp_sock *xs,
> > >                         return ERR_PTR(err);
> > >
> > >                 skb_reserve(skb, hr);
> > > +
> > > +               xsk_set_destructor_arg(skb, desc->addr);
> > >         }
> > >
> > >         addr =3D desc->addr;
> > > @@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >                         err =3D skb_store_bits(skb, 0, buffer, len);
> > >                         if (unlikely(err))
> > >                                 goto free_err;
> > > +
> > > +                       xsk_set_destructor_arg(skb, desc->addr);
> > >                 } else {
> > >                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
> > >                         struct page *page;
> > > @@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct xdp_=
sock *xs,
> > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > >         skb->destructor =3D xsk_destruct_skb;
> > >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > -       xsk_set_destructor_arg(skb);
> > > +
> > > +       xsk_inc_num_desc(skb);
> > > +       if (unlikely(xsk_get_num_desc(skb) > 1)) {
> > > +               struct xsk_addr_node *xsk_addr;
> > > +
> > > +               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, =
GFP_KERNEL);
> > > +               if (!xsk_addr) {
> >
> > num of descs needs to be decreased by one here? We probably miss the
> > chance to add this addr node into the list this time. Sorry, I'm not
> > so sure if this err path handles correctly.
>
> In theory yes, but xsk_consume_skb() will not crash without this by any
> means. If we would have a case where we failed on second frag, @num_descs
> would indeed by 2 but addrs_list would just be empty.

I wasn't stating very clearly. If the second frag fails on the above
step, next time in xsk_consume_skb() the same skb will try to revisit
the second frag/desc because of xsk_cq_cancel_locked(xs->pool, 1); in
xsk_build_skb(). Then it will try to re-allocate the page for the
second desc by calling alloc_page() in xsk_consume_skb()? IIUC, it
will be messy around this skb. Finally, the descs of this skb will be
increased to 3, which should be 2 actually if the skb only needs to
carry two frags/descs?

Thanks,
Jason

