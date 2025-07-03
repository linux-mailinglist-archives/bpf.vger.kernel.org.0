Return-Path: <bpf+bounces-62292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF8AF7769
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3223B9732
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911E2EA75C;
	Thu,  3 Jul 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW2d+f+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA92E9729;
	Thu,  3 Jul 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552792; cv=none; b=oT754BS58cCsYYlVDlaLyyNl1k8aMqGIlePIQnieNgbhkoPlkvMYtuAHZM02D7QS/adwTXudEE/kI1Q/aju9L5Ocp74CVpla65kpehbAocRiIAAUwctq0Rt77Du3/uXsMQ/zhCVjZGYjtSjhEipjsIZ2joAdHTpiqIYe6pbzroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552792; c=relaxed/simple;
	bh=t/lzYAScSYcowAD4kORVO31oj0LWoDd6SmabJ4ZAZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyZd/W3lkhb34YlXcHwpogVOapEbF3c1ilYHmK9lMkJDP6WuEWR4X08tt4FtMCBfq3pDOTqmB4NXZABpY9CU576XV60M+Nl1mdlIOx4AG3QMfqoHa84LH0Eb1+R+X28uqlVv72FiI8IOYyM1o4ooz7xpYYJIETGP7XcOMoTHxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW2d+f+B; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e058c64a76so10837165ab.0;
        Thu, 03 Jul 2025 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552789; x=1752157589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1+e6JEcSQ9wA61myKIMjOe/DNpFYs5m8+tLYA1VUWM=;
        b=CW2d+f+BporozjwSooG7wxjZ4u2C1W1NUcf8oUXrvqkhj01X6vZWcNLtuarfX7xcnL
         BNPjxIZueP/T+mFOED0BIBopdtbo7EK31H+Ao39V5EznxCR8zMVit5ujOhbo4YCQQgsz
         eZawooffmGqzxs0E7xcSCNomQFuU9Cat62TYFNTM0t0DCSOUwndvhuPFjcsCPRwei1js
         J3xzNNbtyH4UNdpha7W+UwmwP0zS8ae7cW+TOZfMns1amHeODdwYNzMKL6KNbSfoj5Fm
         fsflRZWquPF7e038rviuXh4ImbZBLDpCD0W1uOHn1uSHFTugSJp1qHRvUAS78SNp9PhT
         BsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552789; x=1752157589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1+e6JEcSQ9wA61myKIMjOe/DNpFYs5m8+tLYA1VUWM=;
        b=XO116xO7BP33nQrrW5Ak3uuKWuTxwa+PZJVemGnR28ruFF3+CNxhgmsEutpstDr/K2
         iljH2gMn00i5Qid06FZpXxW/gaDkozZVFt4Rsch96LHbYsQt1jxUaUDQEhWhH/gIX9bA
         RXCIUQZ+hMYbXQqVrYthVBndVUIqFTKZeZOS9H/rIGfARvNd4vtQaYdMuZoav8r0edyR
         C3RQvtQdixRFSKlWg2//uk/AcHnZLW+aC64EW2kkHjIRmyCF/irlBEjlLRMoeQkMfzAw
         PrRG1CWPjGu/ckTdPyRnxNnWJksiKq9zApzrjM6PNEtMZsFGK1FY9M4HlpJyhrasc/01
         xjvg==
X-Forwarded-Encrypted: i=1; AJvYcCX+JILSKV1ZV0NeVks7M7UQpV6Zmdsgghxg8xANyRhEEqbzg/cazhdEV0uVHFXebJSN2ulyzPP3@vger.kernel.org, AJvYcCXQVZzTqrlTPmpsVZsiZoXytSqceUeyrKavCfO8Jlrlqq9R0GW4ZWupHRlp6t3OpZnKdZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmGj7f99qEHcqW/5POkwJGzdEw4208rW9p4CYQGAYTFpbjxcN
	4p9z5LmDKqNU0YXMwYZHI9CHCLqtHpWKMST30o+lmKnisOlUc7iFn7C9P3/4D2dnHsLDn/nfhga
	qGuP7f39LPGk0vwh0MjB1mrnR55ggnYXSlz3dBxR4fA==
X-Gm-Gg: ASbGncsD4Dp0i7JVEgMD+B3j6ug64nAZUSSh9saVqdaUM3CT1sL0YbMXBSmOAoLCYLC
	R9OVZCWqPJZhLX3ydJlQNma2hIdUn6MzYGhYG1f4QKVLWPPvNpRNDG3/jZedRyvXl5rk/iXHd44
	SDG+9QXN7cd4xNBBJOxd5YDYPZAZbgIo2wA3FtHa0vX0g=
X-Google-Smtp-Source: AGHT+IEGNwqVphVnWzBbQh42Ll2oq3KA7XCQZvW4HLGy1/mVx9t4+7oMoZb5Wx90sHTg0dk/aO7JcO9rjP3Von5TnuU=
X-Received: by 2002:a05:6e02:b47:b0:3de:119f:5261 with SMTP id
 e9e14a558f8ab-3e054934c6fmr85781735ab.3.1751552789161; Thu, 03 Jul 2025
 07:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <aGZ2vcgz/sqFWWHN@boxer> <CAL+tcoDVwpoNws5QeJwB67JmjzQkpbVXvd5Nb9dv_9CHS_rbzQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDVwpoNws5QeJwB67JmjzQkpbVXvd5Nb9dv_9CHS_rbzQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 22:25:51 +0800
X-Gm-Features: Ac12FXyC5vglZI1tQT3owB5L8yYjfPnLrDlG84mTbPAvuMCbc6wRXUZdWyJYziY
Message-ID: <CAL+tcoD90Vrx__82uMYM2oAX_-kXqR6bi4U0=aXG8PpwPFJ1cg@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:09=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Maciej,
>
> Thanks for the review.
>
> On Thu, Jul 3, 2025 at 8:26=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, Jun 27, 2025 at 07:01:21PM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch provides a setsockopt method to let applications leverage =
to
> > > adjust how many descs to be handled at most in one send syscall. It
> > > mitigates the situation where the default value (32) that is too smal=
l
> > > leads to higher frequency of triggering send syscall.
> > >
> > > Considering the prosperity/complexity the applications have, there is=
 no
> > > absolutely ideal suggestion fitting all cases. So keep 32 as its defa=
ult
> > > value like before.
> > >
> > > The patch does the following things:
> > > - Add XDP_MAX_TX_BUDGET socket option.
> > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > - Set tx_budget_spent to 32 by default in the initialization phase as=
 a
> > >   per-socket granular control. 32 is also the min value for
> > >   tx_budget_spent.
> > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > >
> > > The idea behind this comes out of real workloads in production. We us=
e a
> > > user-level stack with xsk support to accelerate sending packets and
> > > minimize triggering syscalls. When the packets are aggregated, it's n=
ot
> > > hard to hit the upper bound (namely, 32). The moment user-space stack
> > > fetches the -EAGAIN error number passed from sendto(), it will loop t=
o try
> > > again until all the expected descs from tx ring are sent out to the d=
river.
> > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency o=
f
> > > sendto() and higher throughput/PPS.
> > >
> > > Here is what I did in production, along with some numbers as follows:
> > > For one application I saw lately, I suggested using 128 as max_tx_bud=
get
> > > because I saw two limitations without changing any default configurat=
ion:
> > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > this was I counted how many descs are transmitted to the driver at on=
e
> > > time of sendto() based on [1] patch and then I calculated the
> > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > suitable value because 1) it covers most of the cases, 2) a higher
> > > number would not bring evident results. After twisting the parameters=
,
> > > a stable improvement of around 4% for both PPS and throughput and les=
s
> > > resources consumption were found to be observed by strace -c -p xxx:
> > > 1) %time was decreased by 7.8%
> > > 2) error counter was decreased from 18367 to 572
> > >
> > > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxi=
ng@gmail.com/
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > v6
> > > Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonx=
ing@gmail.com/
> > > 1. use [32, xs->tx->nentries] range
> > > 2. Since setsockopt may generate a different value, add getsockopt to=
 help
> > >    application know what value takes effect finally.
> > >
> > > v5
> > > Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonx=
ing@gmail.com/
> > > 1. remove changes around zc mode
> > >
> > > v4
> > > Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonx=
ing@gmail.com/
> > > 1. remove getsockopt as it seems no real use case.
> > > 2. adjust the position of max_tx_budget to make sure it stays with ot=
her
> > > read-most fields in one cacheline.
> > > 3. set one as the lower bound of max_tx_budget
> > > 4. add more descriptions/performance data in Doucmentation and commit=
 message.
> > >
> > > V3
> > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonx=
ing@gmail.com/
> > > 1. use a per-socket control (suggested by Stanislav)
> > > 2. unify both definitions into one
> > > 3. support setsockopt and getsockopt
> > > 4. add more description in commit message
> > >
> > > V2
> > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonx=
ing@gmail.com/
> > > 1. use a per-netns sysctl knob
> > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > ---
> > >  Documentation/networking/af_xdp.rst |  9 +++++++
> > >  include/net/xdp_sock.h              |  1 +
> > >  include/uapi/linux/if_xdp.h         |  1 +
> > >  net/xdp/xsk.c                       | 39 ++++++++++++++++++++++++++-=
--
> > >  tools/include/uapi/linux/if_xdp.h   |  1 +
> > >  5 files changed, 47 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/netw=
orking/af_xdp.rst
> > > index dceeb0d763aa..253afee00162 100644
> > > --- a/Documentation/networking/af_xdp.rst
> > > +++ b/Documentation/networking/af_xdp.rst
> > > @@ -442,6 +442,15 @@ is created by a privileged process and passed to=
 a non-privileged one.
> > >  Once the option is set, kernel will refuse attempts to bind that soc=
ket
> > >  to a different interface.  Updating the value requires CAP_NET_RAW.
> > >
> > > +XDP_MAX_TX_BUDGET setsockopt
> > > +----------------------------
> > > +
> > > +This setsockopt sets the maximum number of descriptors that can be h=
andled
> > > +and passed to the driver at one send syscall. It is applied in the n=
on-zero
> >
> > just 'copy mode' would be enough IMHO.
>
> Okay.
>
> >
> > > +copy mode to allow application to tune the per-socket maximum iterat=
ion for
> > > +better throughput and less frequency of send syscall.
> > > +Allowed range is [32, xs->tx->nentries].
> > > +
> > >  XDP_STATISTICS getsockopt
> > >  -------------------------
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index e8bd6ddb7b12..ce587a225661 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -84,6 +84,7 @@ struct xdp_sock {
> > >       struct list_head map_list;
> > >       /* Protects map_list */
> > >       spinlock_t map_list_lock;
> > > +     u32 max_tx_budget;
> > >       /* Protects multiple processes in the control path */
> > >       struct mutex mutex;
> > >       struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
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
> > > index 72c000c0ae5f..41efe7b27b0e 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -33,8 +33,8 @@
> > >  #include "xdp_umem.h"
> > >  #include "xsk.h"
> > >
> > > -#define TX_BATCH_SIZE 32
> > > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > > +#define TX_BUDGET_SIZE 32
> > > +#define MAX_PER_SOCKET_BUDGET 32
> >
> > that could have stayed as it was before?
>
> Sorry, I don't think so because one definition has nothing to do with
> the other one. Why do we need to bind them together?
>
> >
> > >
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > > @@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> >
> > you're breaking RCT here...
>
> What's the RCT? Never heard of this abbreviation.
>
> > maybe you could READ_ONCE() the budget right
> > before the while() loop and keep the declaration only at the top of fun=
c?
> >
> > also nothing wrong with keeping @max_batch as a name for this budget.
> >
> > >       bool sent_frame =3D false;
> > >       struct xdp_desc desc;
> > >       struct sk_buff *skb;
> > > @@ -797,7 +797,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >               goto out;
> > >
> > >       while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > > -             if (max_batch-- =3D=3D 0) {
> > > +             if (max_budget-- =3D=3D 0) {
> > >                       err =3D -EAGAIN;
> > >                       goto out;
> > >               }
> > > @@ -1437,6 +1437,21 @@ static int xsk_setsockopt(struct socket *sock,=
 int level, int optname,
> > >               mutex_unlock(&xs->mutex);
> > >               return err;
> > >       }
> > > +     case XDP_MAX_TX_BUDGET:
> > > +     {
> > > +             unsigned int budget;
> > > +
> > > +             if (optlen !=3D sizeof(budget))
> > > +                     return -EINVAL;
> > > +             if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > > +                     return -EFAULT;
> > > +             if (!xs->tx || xs->tx->nentries < TX_BUDGET_SIZE)
> > > +                     return -EACCES;
> > > +
> > > +             WRITE_ONCE(xs->max_tx_budget,
> > > +                        clamp(budget, TX_BUDGET_SIZE, xs->tx->nentri=
es));
> >
> > I think it would be better to throw errno when budget set by user is
> > bigger than nentries. you do it for min case, let's do it for max case =
as
> > well and skip the clamp() altogether?
>
> Okay.
>
> After this, do you think it's necessary to keep the getsockopt()?
>
> >
> > this is rather speculative that someone would ever set such a big budge=
t
> > but silently setting a lower value than provided might be confusing to =
me.
> > i'd rather get an error thrown at my face and find out the valid range.
>
> On point.
>
> >
> > > +             return 0;
> > > +     }
> > >       default:
> > >               break;
> > >       }
> > > @@ -1588,6 +1603,21 @@ static int xsk_getsockopt(struct socket *sock,=
 int level, int optname,
> > >
> > >               return 0;
> > >       }
> > > +     case XDP_MAX_TX_BUDGET:
> > > +     {
> > > +             unsigned int budget;
> > > +
> > > +             if (len < sizeof(budget))
> > > +                     return -EINVAL;
> > > +
> > > +             budget =3D READ_ONCE(xs->max_tx_budget);
> > > +             if (copy_to_user(optval, &budget, sizeof(budget)))
> > > +                     return -EFAULT;
> > > +             if (put_user(sizeof(budget), optlen))
> > > +                     return -EFAULT;
> > > +
> > > +             return 0;
> > > +     }
> > >       default:
> > >               break;
> > >       }
> > > @@ -1734,6 +1764,7 @@ static int xsk_create(struct net *net, struct s=
ocket *sock, int protocol,
> > >
> > >       xs =3D xdp_sk(sk);
> > >       xs->state =3D XSK_READY;
> > > +     xs->max_tx_budget =3D TX_BUDGET_SIZE;
> > >       mutex_init(&xs->mutex);
> > >
> > >       INIT_LIST_HEAD(&xs->map_list);
> > > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/l=
inux/if_xdp.h
> > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > --- a/tools/include/uapi/linux/if_xdp.h
> > > +++ b/tools/include/uapi/linux/if_xdp.h
> > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > >  #define XDP_UMEM_COMPLETION_RING     6
> > >  #define XDP_STATISTICS                       7
> > >  #define XDP_OPTIONS                  8
> > > +#define XDP_MAX_TX_BUDGET            9
> >
> > could we have 'SKB' in name?
>
> Like XDP_MAX_TX_BUDGET_SKB ?

XDP_MAX_TX_SKB_BUDGET sounds better, I assume.

Thanks,
Jason

