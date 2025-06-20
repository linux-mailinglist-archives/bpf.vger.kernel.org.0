Return-Path: <bpf+bounces-61134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2FAE102D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 02:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5F7189D2A8
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567DEBE;
	Fri, 20 Jun 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlECBBVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49D17E;
	Fri, 20 Jun 2025 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750377820; cv=none; b=KC/621Xrk/aw0fFpCzRi7I5EUm+HqFQTOq6fN7xwVvHNgfjQFzL8Pef5WBLAPTjkVRw/pbopmLGcMruh0rLOBdVDbblFpOUL9RuPN7v5Zqn3f/xzDNAueV/iblWXXcmCmpYewr0nGr6VoGLfHPvAhi3/WAIaJq9BuipMeZZ1F7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750377820; c=relaxed/simple;
	bh=jeAccuPDv3qbmsqoTLNMk4jTZ3fo/N8LbHt5/4JNdPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvn6SW5D/E1Krc21RFCKvDhuPO6rWfvOH7IRGuhxiQKl3Q+N6RNRye2pCcvi5hHeARO05J/6QWblkPjdQgRnLfJQRzDaJQfhRiZThsII1r+P0ZCDVfqMqzJibBwCY9gcC73VWSc+fY2lm5T4b1prDlMTStpfklgQ52Gx6H7peiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlECBBVT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddc4ad070bso4513545ab.3;
        Thu, 19 Jun 2025 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750377815; x=1750982615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikYajK8wEmwAfiUy+la+c0gnZiANBhufyeoZBeZzRDE=;
        b=TlECBBVTGLb1ZHqNgPjFabYgAHB+cVNiwh2L806DOfOM5crz80lA3Dtu1DV7mIk7Fm
         LAcDOmudTswfe/T9fy/oSIA0A1aaId8YUM2GpW5l5DzwRQDx8qnayzuFmKY0l4trPqUf
         d8LVwt3fnhMIllErbKMt5utK4RbnN/JU8oay/j704xSFZG3lYFgKAV/qQrA4SlmeuPe1
         HzgndKnbA+1Vcd+guZW6aqZIsBzxHxs+TBB++7jYqjSQsQYpxxIUxA2P21IXYecSaxq0
         8c+Yr72q3cEYjOqTJ3n+Gc9OmDCQk48goQDP2WRFt4pu4fIBnRkFLe5u7o+qewMyp5TO
         hLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750377815; x=1750982615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikYajK8wEmwAfiUy+la+c0gnZiANBhufyeoZBeZzRDE=;
        b=SUufJyU+Bp044aNuAxMfxpJLvRYP9trkFGuXLwh2o2Q8hAJzrUkJ56lrYdTkKhBHNG
         d8U0Q1i2etCuc7okOfg8vMxiLnOn2YCG1YM6LCuV2+Gyd89zxVdjlBoHtR/oUvJeEYSw
         ZQ7H/Chq4qVSjjCgN4//rX2Np4vV0DexN1DeEX60+FOJDqQkIjQSINel/Zlb9xoxGaKE
         EhF9XHlKyWdE6RfxEkXUQBfA3Kd6MwcIpCmq0vrUwwg/J3quDXlHoJYhR+9LvaFZP6lj
         3JH2yMYiN2q4i3KqT6ei+tzXcsWrCVghIrjc7KxvGOSSvjBoc7jB1PcMF3bF+HK2L62K
         RjEg==
X-Forwarded-Encrypted: i=1; AJvYcCUrkFWUZpOBRPYVyFJKy2/lU1CFP8oM2whKKvOvnnYisdiPv8j8D+OITMFniurVQBY1QD0=@vger.kernel.org, AJvYcCVhJteIezYA8dgVACerLgktFlrdnsnhC95Yiy1i3a//qikMjd539Fg29pyOrPtdawAQKPfHVkI+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8J46q7OLh3TpP1qj8iuxwoQbQVZYh5eJVtjgx8V6OyfXfRviq
	8kbRdpvUbq0HY3Aa7VjhzLvisp/VEqkbng+OLTOCyuBFRaFDJhioskSZtI9j3NwekS38DMg/mnC
	Iix0fY70ibYifZGDmYgcKe0m5At+TZ3E=
X-Gm-Gg: ASbGncubGO5eNMeUwJQT3VRudk5Akb84f3JUBdqjIALI0aZ23O8QD2+Ht+mOgwXIZRU
	2heAzLr9NMl/xAH4+4mR88lyCOFZUYes3Ok6WKjB2IGg9zTTaDXZCt42C4d1f4a9QMG4iyt9F2/
	GbNgnw31JHOvBkHkWaq2CQe38Gb9lIqOdTQis0ekkEHA==
X-Google-Smtp-Source: AGHT+IFBQk8LYMi18bjmRT3lSEWeN4TGg64i76nu1fgiyUJWcDI3mOgRBG54Be957rqRqzRgXZGAMAWe+Czmit6dzYw=
X-Received: by 2002:a05:6e02:2404:b0:3dc:8746:962b with SMTP id
 e9e14a558f8ab-3de38cb0971mr9195345ab.15.1750377815364; Thu, 19 Jun 2025
 17:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch> <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
In-Reply-To: <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 08:02:59 +0800
X-Gm-Features: AX0GCFv9MWG5rS371QTJuEOEDL8L3hkLbeQg6S4BiX7dbJ893Hv4CU-Fhw0vkj4
Message-ID: <CAL+tcoBhoi-NOav0TPcotbuMDydnusTJMeK4JpPZmdsQoWmv+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 7:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The patch does the following things:
> > > - Add XDP_MAX_TX_BUDGET socket option.
> > > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
> > >   tx_budget_spent.
> > > - tx_budget_spent is set to 32 by default in the initialization phase=
.
> > >   It's a per-socket granular control.
> > >
> > > The idea behind this comes out of real workloads in production. We us=
e a
> > > user-level stack with xsk support to accelerate sending packets and
> > > minimize triggering syscall. When the packets are aggregated, it's no=
t
> > > hard to hit the upper bound (namely, 32). The moment user-space stack
> > > fetches the -EAGAIN error number passed from sendto(), it will loop t=
o try
> > > again until all the expected descs from tx ring are sent out to the d=
river.
> > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequencies=
 of
> > > sendto(). Besides, applications leveraging this setsockopt can adjust
> > > its proper value in time after noticing the upper bound issue happeni=
ng.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > V3
> > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonx=
ing@gmail.com/
> > > 1. use a per-socket control (suggested by Stanislav)
> > > 2. unify both definitions into one
> > > 3. support setsockopt and getsockopt
> > > 4. add more description in commit message
> >
> > +1 on an XSK setsockopt only
>
> May I ask why only setsockopt? In tradition, dev_tx_weight can be read
> and written through running sysctl. I think they are the same?
>
> >
> > >
> > > V2
> > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonx=
ing@gmail.com/
> > > 1. use a per-netns sysctl knob
> > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > ---
> > >  include/net/xdp_sock.h            |  3 ++-
> > >  include/uapi/linux/if_xdp.h       |  1 +
> > >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++----=
--
> > >  tools/include/uapi/linux/if_xdp.h |  1 +
> > >  4 files changed, 34 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index e8bd6ddb7b12..8eecafad92c0 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -65,11 +65,12 @@ struct xdp_sock {
> > >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > >       struct list_head tx_list;
> > >       /* record the number of tx descriptors sent by this xsk and
> > > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
> > > +      * when it exceeds max_tx_budget, an opportunity needs
> > >        * to be given to other xsks for sending tx descriptors, thereb=
y
> > >        * preventing other XSKs from being starved.
> > >        */
> > >       u32 tx_budget_spent;
> > > +     u32 max_tx_budget;
> >
> > This probably does not need to be a u32?
>
> From what I've known, it's not possible to set a very large value like
> 1000 which probably brings side effects.
>
> But it seems we'd better not limit the use of this max_tx_budget? We
> don't know what the best fit for various use cases is. If the type
> needs to be downsized to a smaller one like u16, another related
> consideration is that dev_tx_weight deserves the same treatment?
>
> Or let me adjust to 'int' then?
>
> > It does fit in an existing hole. Is it also a warm cacheline wherever
> > this is touched in the hot path?
>
> Oh, right.  max_tx_budget is almost a read-only member while the rest
> of the same cacheline are frequently changed. I'm going to change as
> below:
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 8eecafad92c0..fca7723ad8b3 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -70,7 +70,6 @@ struct xdp_sock {
>          * preventing other XSKs from being starved.
>          */
>         u32 tx_budget_spent;
> -       u32 max_tx_budget;
>
>         /* Statistics */
>         u64 rx_dropped;
> @@ -85,6 +84,7 @@ struct xdp_sock {
>         struct list_head map_list;
>         /* Protects map_list */
>         spinlock_t map_list_lock;
> +       u32 max_tx_budget;
>         /* Protects multiple processes in the control path */
>         struct mutex mutex;
>         struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
>
> Then it will be put into one read-mostly cacheline and also not add an
> extra hole :)
>
> >
> > >
> > >       /* Statistics */
> > >       u64 rx_dropped;
> > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.=
h
> > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > --- a/include/uapi/linux/if_xdp.h
> > > +++ b/include/uapi/linux/if_xdp.h
> > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > >  #define XDP_UMEM_COMPLETION_RING     6
> > >  #define XDP_STATISTICS                       7
> > >  #define XDP_OPTIONS                  8
> > > +#define XDP_MAX_TX_BUDGET            9
> > >
> > >  struct xdp_umem_reg {
> > >       __u64 addr; /* Start of packet data area */
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 72c000c0ae5f..7c47f665e9d1 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -33,9 +33,6 @@
> > >  #include "xdp_umem.h"
> > >  #include "xsk.h"
> > >
> > > -#define TX_BATCH_SIZE 32
> > > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > > -
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > >       if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,=
 struct xdp_desc *desc)
> > >       rcu_read_lock();
> > >  again:
> > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > +
> > > +             if (xs->tx_budget_spent >=3D max_budget) {
> > >                       budget_exhausted =3D true;
> > >                       continue;
> > >               }
> > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > >       bool sent_frame =3D false;
> > >       struct xdp_desc desc;
> > >       struct sk_buff *skb;
> > > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >               goto out;
> > >
> > >       while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > > -             if (max_batch-- =3D=3D 0) {
> > > +             if (max_budget-- =3D=3D 0) {
> > >                       err =3D -EAGAIN;
> > >                       goto out;
> > >               }
> > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock,=
 int level, int optname,
> > >               mutex_unlock(&xs->mutex);
> > >               return err;
> > >       }
> > > +     case XDP_MAX_TX_BUDGET:
> > > +     {
> > > +             unsigned int budget;
> > > +
> > > +             if (optlen < sizeof(budget))
> > > +                     return -EINVAL;
> > > +             if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > > +                     return -EFAULT;
> > > +
> > > +             WRITE_ONCE(xs->max_tx_budget, budget);
> >
> > Sanitize input: bounds check
>
> Thanks for catching this.
>
> I will change it like this:
>     WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?

Oh, don't bother to modify the above line. Only modifying the
if-statement at the beginning would suffice:

if (optlen !=3D sizeof(budget))
        return -EINVAL;

Thanks,
Jason

