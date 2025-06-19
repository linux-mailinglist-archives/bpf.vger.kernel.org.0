Return-Path: <bpf+bounces-61133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C56AE1026
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 01:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606CD177AC0
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 23:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8E28DF39;
	Thu, 19 Jun 2025 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA8zKaQM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF322154B;
	Thu, 19 Jun 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750377268; cv=none; b=EFeh/4R6jx+VjBiZW2jFytdgZkK+YtXRad7DroEC3CC5JjnP3gdBis/KabXppEyuQZYz7PojgM+bvEfrIBUjD4cElZkYtuKcnLmMEOEeIMmrKXAFBekxdSAZ/OoXRq2+WMdO+Z/dIJ7s7PHHwg2bWydvudppo+pFIAWVA2A5r4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750377268; c=relaxed/simple;
	bh=/tuvN6LrtcwFYmp1ZVzr6nxhR6adJs9/q2eoTwDv/9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSydW4iDpVq9q+8TF3nbpsZ4gBwcg/BxltbSuRB8Rpdf9yWeKyKzKNh6zcJviDLX1u1CvHVJuKN8BCtisfuXg7eG9SJ8Vq7Omajecn8Nqcztplw3UFGxwbAaS/+mjUrTEKcWD74iP/wEDxwaLGt1HE2xBj+fjJ3wPvcNDnoDtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA8zKaQM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddda14b56cso5384735ab.0;
        Thu, 19 Jun 2025 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750377266; x=1750982066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s6JNF6wQih8WEYTbj1ApTwcC5asUmF/UcxX8oyscI4=;
        b=TA8zKaQMpOqltPzgFeA1cUOJ9EyhtgxOBY081djYSHIzOKEPiwEBqUsS4yNWpaU9MM
         9CxNes/YlVHv/pAf8q7mXLiKPivwzI8IASbrPJmkATM+yHswR/MCeD9l2CLX8Iylf+O+
         ZJ4ueIP+KfqxA2LZaouB0o4X5TL4g24dkeQRnJqbfkO0S/16PsTYiygnqdoR1NVMqE8C
         hD21U7rlHBBZ3rBzZXZ2plyNXklmHrwtqeof4HtFQVRu3gdvSIuCrBgHFKRUPijxsH2w
         wlXO3qxA835iiETY1Adg+PhBxVMhKSTjEXi5SbZhm4e7KJlgmMYdIcj1s9KH7ZOZQKdt
         IK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750377266; x=1750982066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s6JNF6wQih8WEYTbj1ApTwcC5asUmF/UcxX8oyscI4=;
        b=Go7bciSdvh6GXRWNrhgy8CnHXvVv9sHBZzyCJ4lXk89S9YL9mXU6eZP9Iieakwvk8Y
         H8qw8ACSzZLhpf1PFJFSR/e9e/tMnhMBex44IKOPq8YxlSwGDKhAgd9LjTuVMgRe+KOI
         RXSz9pB2qhI8IEDLkTjrvCYRzcExufqkwjciDzQdqPrp5Gbf30tisQPev5EKzv8qS4wt
         da04d3aIC4+qMbyRoJdR6zonuwt5tvBGGT4Isa0v3u2v8EB0L7A4rcA7pdsZmy5/hB77
         QFEUFoOVpeVHSDv5vs2plXhPTbHkYriBPdwiFRTMifVlcWUCuXKBPEnv5kUL+F/6oJlZ
         n3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUhNQ7ZRSRn/MxyRZrOKKtrAzfaDosvzA8YOvrYa4FOS0hw4NYnnfuaMBerfiiFfkFIFf229v9x@vger.kernel.org, AJvYcCXL/4rzasYmXLUGLkZtD0o4AvrgUfNIgG1/LGM9UNJwNU1ezQ14aZbd6WbGXV7BvqJZeIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQ+Vn3sRn9OnvFdeulHP+WFfdLHyFX87gchT7vZFAtbYlPhHR
	/EIL9JTYPdOuLiz2th4K41K9jeeySBlpNHpW+m1wOudO4LiEJbbFsxZbj4F0kPYVrPO7vgTz6oj
	S8J29gma/OLnD4I885zToBwGa/bhOpFo=
X-Gm-Gg: ASbGncv5qb+aEpdPgkDV70sEacGLkvFq4Y63DZIlA7a6qG0VGu9ri7XolBivsDYxYLV
	QY08q/Z88prN134D89L864bnyrygiC+QoNvRM10yYAvKIrdLx4IeiR4nrObLmmlu/FjkP/OGDmc
	syQuIoG7bnbd4IzVWAjuRvzlKjFkfpk08KNlOlk7n/u4U=
X-Google-Smtp-Source: AGHT+IGJoXe6QQSPv3ed0xSm+AIZjjb791htpGDsxT7TAuwXYXNHuOvXQGKU0bXf6y1eQRg5ppo1JP9fP2wDDJ1L9GY=
X-Received: by 2002:a05:6e02:1fce:b0:3dc:76ad:7990 with SMTP id
 e9e14a558f8ab-3de38cb978bmr8200475ab.15.1750377266072; Thu, 19 Jun 2025
 16:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com> <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
In-Reply-To: <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 07:53:49 +0800
X-Gm-Features: AX0GCFvw6Wxd1Fw5DJa49mEgyHo28AVLIW3VvreifpxOGow9TH-r_UxqS1KShxQ
Message-ID: <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
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

On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The patch does the following things:
> > - Add XDP_MAX_TX_BUDGET socket option.
> > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
> >   tx_budget_spent.
> > - tx_budget_spent is set to 32 by default in the initialization phase.
> >   It's a per-socket granular control.
> >
> > The idea behind this comes out of real workloads in production. We use =
a
> > user-level stack with xsk support to accelerate sending packets and
> > minimize triggering syscall. When the packets are aggregated, it's not
> > hard to hit the upper bound (namely, 32). The moment user-space stack
> > fetches the -EAGAIN error number passed from sendto(), it will loop to =
try
> > again until all the expected descs from tx ring are sent out to the dri=
ver.
> > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequencies o=
f
> > sendto(). Besides, applications leveraging this setsockopt can adjust
> > its proper value in time after noticing the upper bound issue happening=
.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > V3
> > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxin=
g@gmail.com/
> > 1. use a per-socket control (suggested by Stanislav)
> > 2. unify both definitions into one
> > 3. support setsockopt and getsockopt
> > 4. add more description in commit message
>
> +1 on an XSK setsockopt only

May I ask why only setsockopt? In tradition, dev_tx_weight can be read
and written through running sysctl. I think they are the same?

>
> >
> > V2
> > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxin=
g@gmail.com/
> > 1. use a per-netns sysctl knob
> > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > ---
> >  include/net/xdp_sock.h            |  3 ++-
> >  include/uapi/linux/if_xdp.h       |  1 +
> >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++------
> >  tools/include/uapi/linux/if_xdp.h |  1 +
> >  4 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index e8bd6ddb7b12..8eecafad92c0 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -65,11 +65,12 @@ struct xdp_sock {
> >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> >       struct list_head tx_list;
> >       /* record the number of tx descriptors sent by this xsk and
> > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
> > +      * when it exceeds max_tx_budget, an opportunity needs
> >        * to be given to other xsks for sending tx descriptors, thereby
> >        * preventing other XSKs from being starved.
> >        */
> >       u32 tx_budget_spent;
> > +     u32 max_tx_budget;
>
> This probably does not need to be a u32?

From what I've known, it's not possible to set a very large value like
1000 which probably brings side effects.

But it seems we'd better not limit the use of this max_tx_budget? We
don't know what the best fit for various use cases is. If the type
needs to be downsized to a smaller one like u16, another related
consideration is that dev_tx_weight deserves the same treatment?

Or let me adjust to 'int' then?

> It does fit in an existing hole. Is it also a warm cacheline wherever
> this is touched in the hot path?

Oh, right.  max_tx_budget is almost a read-only member while the rest
of the same cacheline are frequently changed. I'm going to change as
below:
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 8eecafad92c0..fca7723ad8b3 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -70,7 +70,6 @@ struct xdp_sock {
         * preventing other XSKs from being starved.
         */
        u32 tx_budget_spent;
-       u32 max_tx_budget;

        /* Statistics */
        u64 rx_dropped;
@@ -85,6 +84,7 @@ struct xdp_sock {
        struct list_head map_list;
        /* Protects map_list */
        spinlock_t map_list_lock;
+       u32 max_tx_budget;
        /* Protects multiple processes in the control path */
        struct mutex mutex;
        struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */

Then it will be put into one read-mostly cacheline and also not add an
extra hole :)

>
> >
> >       /* Statistics */
> >       u64 rx_dropped;
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_UMEM_COMPLETION_RING     6
> >  #define XDP_STATISTICS                       7
> >  #define XDP_OPTIONS                  8
> > +#define XDP_MAX_TX_BUDGET            9
> >
> >  struct xdp_umem_reg {
> >       __u64 addr; /* Start of packet data area */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72c000c0ae5f..7c47f665e9d1 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -33,9 +33,6 @@
> >  #include "xdp_umem.h"
> >  #include "xsk.h"
> >
> > -#define TX_BATCH_SIZE 32
> > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > -
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >       if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, s=
truct xdp_desc *desc)
> >       rcu_read_lock();
> >  again:
> >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > +
> > +             if (xs->tx_budget_spent >=3D max_budget) {
> >                       budget_exhausted =3D true;
> >                       continue;
> >               }
> > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >       struct xdp_sock *xs =3D xdp_sk(sk);
> > -     u32 max_batch =3D TX_BATCH_SIZE;
> > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> >       bool sent_frame =3D false;
> >       struct xdp_desc desc;
> >       struct sk_buff *skb;
> > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >               goto out;
> >
> >       while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > -             if (max_batch-- =3D=3D 0) {
> > +             if (max_budget-- =3D=3D 0) {
> >                       err =3D -EAGAIN;
> >                       goto out;
> >               }
> > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock, i=
nt level, int optname,
> >               mutex_unlock(&xs->mutex);
> >               return err;
> >       }
> > +     case XDP_MAX_TX_BUDGET:
> > +     {
> > +             unsigned int budget;
> > +
> > +             if (optlen < sizeof(budget))
> > +                     return -EINVAL;
> > +             if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > +                     return -EFAULT;
> > +
> > +             WRITE_ONCE(xs->max_tx_budget, budget);
>
> Sanitize input: bounds check

Thanks for catching this.

I will change it like this:
    WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?

Thanks,
Jason

>
> > +             return 0;
> > +     }
> >       default:
> >               break;
> >       }
> > @@ -1588,6 +1599,18 @@ static int xsk_getsockopt(struct socket *sock, i=
nt level, int optname,
> >
> >               return 0;
> >       }
> > +     case XDP_MAX_TX_BUDGET:
> > +     {
> > +             unsigned int budget =3D READ_ONCE(xs->max_tx_budget);
> > +
> > +             if (copy_to_user(optval, &budget, sizeof(budget)))
> > +                     return -EFAULT;
> > +             if (put_user(sizeof(budget), optlen))
> > +                     return -EFAULT;
> > +
> > +             return 0;
> > +     }
> > +
> >       default:
> >               break;
> >       }
> > @@ -1734,6 +1757,7 @@ static int xsk_create(struct net *net, struct soc=
ket *sock, int protocol,
> >
> >       xs =3D xdp_sk(sk);
> >       xs->state =3D XSK_READY;
> > +     xs->max_tx_budget =3D 32;
> >       mutex_init(&xs->mutex);
> >
> >       INIT_LIST_HEAD(&xs->map_list);
> > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/lin=
ux/if_xdp.h
> > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > --- a/tools/include/uapi/linux/if_xdp.h
> > +++ b/tools/include/uapi/linux/if_xdp.h
> > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_UMEM_COMPLETION_RING     6
> >  #define XDP_STATISTICS                       7
> >  #define XDP_OPTIONS                  8
> > +#define XDP_MAX_TX_BUDGET            9
> >
> >  struct xdp_umem_reg {
> >       __u64 addr; /* Start of packet data area */
> > --
> > 2.43.5
> >
>
>

