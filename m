Return-Path: <bpf+bounces-62294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309ABAF7911
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9649584A52
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73B2EFDBD;
	Thu,  3 Jul 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB74sdYn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59D2E7BD6;
	Thu,  3 Jul 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554460; cv=none; b=sI3RYnGR/yZzgx2RjKuIZk4jolelTBHjFz0PlInsFgMoFZ+ExJi80CjMKDB+wqd4jsRxwkVD8/WJYWeQVwyui5Bqw+EsbTDe11R+MwnHp6LUIPFTubM7/UC8nELmNgyXCV5CY4R8YhVsHlQIUOz0dsvEvfCG8uDuyytQ8syIFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554460; c=relaxed/simple;
	bh=+L+sgiPde8M+nxDi8/TAQdt3U4c55Lty6+GXGUuYbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQOHrNiQnAaIQ0tWCPZYee+s3OIbz4QEiJ1iDKP5jPhcwBRKz298GXAVTKltDfW8dOelngPvODpHQ/NAnPfnj7bt/eM7VXC/f3ttAceoVe7xW00/VprxpO4cNe4X+huJMdAEZYWru9LNuNPA19yvfHwkvRp8kbrRMt/gDPd4L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB74sdYn; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so120695ab.0;
        Thu, 03 Jul 2025 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751554458; x=1752159258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seiVh9yjx3DESsgzorSpQthmvkhkXqFPzF8juopQ0sw=;
        b=MB74sdYn3Gpwhyip2KS4WV53/BSPcNrDQv9Y0r4mB/jDaXmIXsE7fGRPNDgmdiwB2I
         nJt37kElF8y+fo9X4qYeXr/MQHbDMgzl+hk35xN5w9qYRk3DF5mWQDpYWMGTrs0Ew7mi
         QuiupA9ZFKODMPskIPzs5MAreJ1Jx4jXZTPqcqsmP+3eDIuyNK0Vt2BWbNMbnE5Bf7kc
         bHVntNfnO4e+Azu16lm+BFJmrS6izz4Z5LqTvZCcuFZa3dIxAElFKjQucoAb/xKaMNH+
         5AxacBnadeUccvLzCjOMfK1u0f9QQ98FR27ZdNzEND8XltvI24Q99NQZDavfJGUrltNE
         f6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554458; x=1752159258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seiVh9yjx3DESsgzorSpQthmvkhkXqFPzF8juopQ0sw=;
        b=g2c1vg+lTiJ4THRV+pSOPQHCjIIOAGyYTB6DzJrh4OKDYa9chTxZPZC+Bh5Uz8k3bE
         A+D4ad9DcCo7z4vFSY9mZ13KilvRRGjAthg0jOMEH+AhlmZ0OSwGqJyiBFaxSprBRq6g
         vFRvYnQ4NeDo+egEn0/9a2/2FT/1aw9/dltWRvcc4JMd7IlKnqh79JVGvlwpz+3PqjE6
         ZO2HsCqFLX9PFBR0WzxSxbfFqmkoAUhUWRAUsmhentLR8M5jPcLhrXxc5IjsIWsnAlRw
         u4KOl7KjygZNQDmkSdZ0C7YJcxBiyHkhOW2zsu6W5pIs7NqTJpA+74e9ZMa47Bt7n99g
         ss0g==
X-Forwarded-Encrypted: i=1; AJvYcCVH2enmH/gXUWpfAmShpElZ1dOhOPGAwHAJgke+2m8wqYg5ciTIwGAHA+9R0GhPG4CINus=@vger.kernel.org, AJvYcCWoelArhI5MwKfOUUbcsidEQqQdDvVmnN6TxUmZXJf5A86Mp0yVId2/e7TWldew5YoCPyColGHT@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjPI5tXyseGyoH+43Bb4PNjhRZcnESnrBF7WQzrUWXOtdzBp9
	Hq8wP0qjRX2kokoM4KwJl5ekZkjzCvgGCjwHW0QFcH8VTY+7GAlYtdM2CjwPEXMNIc5vXpM3GaR
	p8jLWTz5QSPDzGMWwplSm5ebenRRjZLA=
X-Gm-Gg: ASbGncsOgHHTOhVMLB1ITrsAz3pC6YF0TWTZGMudd49klLRPbCr9zOiJdF7uZohsQ+Y
	UVWqAqG3tTrreW/7/JHfNeiM1I2lSSTY0iCgI5VmVsnlEvauU0Sn6aZ6kjTcgYHOXng6h5nG21V
	XZr9R+n1KVG7bqQ6mjMjl3kEU4UQ2VpNl4LTHei8dZvg==
X-Google-Smtp-Source: AGHT+IF6z8Em4qw5WBOqO1oP5W8yfSCXXmPsn/NHYCCRgM1MEH0/K22HRd5zLqbo363pKF/hl5Is4UX82CFxD3GMOXw=
X-Received: by 2002:a05:6e02:1487:b0:3dd:f3e1:2899 with SMTP id
 e9e14a558f8ab-3e05493f74dmr80935005ab.2.1751554457989; Thu, 03 Jul 2025
 07:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <aGZ2vcgz/sqFWWHN@boxer> <CAL+tcoDVwpoNws5QeJwB67JmjzQkpbVXvd5Nb9dv_9CHS_rbzQ@mail.gmail.com>
 <CAL+tcoD90Vrx__82uMYM2oAX_-kXqR6bi4U0=aXG8PpwPFJ1cg@mail.gmail.com>
In-Reply-To: <CAL+tcoD90Vrx__82uMYM2oAX_-kXqR6bi4U0=aXG8PpwPFJ1cg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 22:53:41 +0800
X-Gm-Features: Ac12FXzoR-uiMnDb51FciusSAfhPeFlLhPVkAAa2K6qAATqYpj17PJv2PqbHgeI
Message-ID: <CAL+tcoDcTGYBFayBNUATz2zoYCCbbFKbJ-ifnVLmcmGx5=0GEQ@mail.gmail.com>
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

On Thu, Jul 3, 2025 at 10:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jul 3, 2025 at 9:09=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > Hi Maciej,
> >
> > Thanks for the review.
> >
> > On Thu, Jul 3, 2025 at 8:26=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Fri, Jun 27, 2025 at 07:01:21PM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch provides a setsockopt method to let applications leverag=
e to
> > > > adjust how many descs to be handled at most in one send syscall. It
> > > > mitigates the situation where the default value (32) that is too sm=
all
> > > > leads to higher frequency of triggering send syscall.
> > > >
> > > > Considering the prosperity/complexity the applications have, there =
is no
> > > > absolutely ideal suggestion fitting all cases. So keep 32 as its de=
fault
> > > > value like before.
> > > >
> > > > The patch does the following things:
> > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > > - Set tx_budget_spent to 32 by default in the initialization phase =
as a
> > > >   per-socket granular control. 32 is also the min value for
> > > >   tx_budget_spent.
> > > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > > >
> > > > The idea behind this comes out of real workloads in production. We =
use a
> > > > user-level stack with xsk support to accelerate sending packets and
> > > > minimize triggering syscalls. When the packets are aggregated, it's=
 not
> > > > hard to hit the upper bound (namely, 32). The moment user-space sta=
ck
> > > > fetches the -EAGAIN error number passed from sendto(), it will loop=
 to try
> > > > again until all the expected descs from tx ring are sent out to the=
 driver.
> > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency=
 of
> > > > sendto() and higher throughput/PPS.
> > > >
> > > > Here is what I did in production, along with some numbers as follow=
s:
> > > > For one application I saw lately, I suggested using 128 as max_tx_b=
udget
> > > > because I saw two limitations without changing any default configur=
ation:
> > > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > > this was I counted how many descs are transmitted to the driver at =
one
> > > > time of sendto() based on [1] patch and then I calculated the
> > > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > > suitable value because 1) it covers most of the cases, 2) a higher
> > > > number would not bring evident results. After twisting the paramete=
rs,
> > > > a stable improvement of around 4% for both PPS and throughput and l=
ess
> > > > resources consumption were found to be observed by strace -c -p xxx=
:
> > > > 1) %time was decreased by 7.8%
> > > > 2) error counter was decreased from 18367 to 572
> > > >
> > > > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljason=
xing@gmail.com/
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > v6
> > > > Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljaso=
nxing@gmail.com/
> > > > 1. use [32, xs->tx->nentries] range
> > > > 2. Since setsockopt may generate a different value, add getsockopt =
to help
> > > >    application know what value takes effect finally.
> > > >
> > > > v5
> > > > Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljaso=
nxing@gmail.com/
> > > > 1. remove changes around zc mode
> > > >
> > > > v4
> > > > Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljaso=
nxing@gmail.com/
> > > > 1. remove getsockopt as it seems no real use case.
> > > > 2. adjust the position of max_tx_budget to make sure it stays with =
other
> > > > read-most fields in one cacheline.
> > > > 3. set one as the lower bound of max_tx_budget
> > > > 4. add more descriptions/performance data in Doucmentation and comm=
it message.
> > > >
> > > > V3
> > > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljaso=
nxing@gmail.com/
> > > > 1. use a per-socket control (suggested by Stanislav)
> > > > 2. unify both definitions into one
> > > > 3. support setsockopt and getsockopt
> > > > 4. add more description in commit message
> > > >
> > > > V2
> > > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljaso=
nxing@gmail.com/
> > > > 1. use a per-netns sysctl knob
> > > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > > ---
> > > >  Documentation/networking/af_xdp.rst |  9 +++++++
> > > >  include/net/xdp_sock.h              |  1 +
> > > >  include/uapi/linux/if_xdp.h         |  1 +
> > > >  net/xdp/xsk.c                       | 39 +++++++++++++++++++++++++=
+---
> > > >  tools/include/uapi/linux/if_xdp.h   |  1 +
> > > >  5 files changed, 47 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/ne=
tworking/af_xdp.rst
> > > > index dceeb0d763aa..253afee00162 100644
> > > > --- a/Documentation/networking/af_xdp.rst
> > > > +++ b/Documentation/networking/af_xdp.rst
> > > > @@ -442,6 +442,15 @@ is created by a privileged process and passed =
to a non-privileged one.
> > > >  Once the option is set, kernel will refuse attempts to bind that s=
ocket
> > > >  to a different interface.  Updating the value requires CAP_NET_RAW=
.
> > > >
> > > > +XDP_MAX_TX_BUDGET setsockopt
> > > > +----------------------------
> > > > +
> > > > +This setsockopt sets the maximum number of descriptors that can be=
 handled
> > > > +and passed to the driver at one send syscall. It is applied in the=
 non-zero
> > >
> > > just 'copy mode' would be enough IMHO.
> >
> > Okay.
> >
> > >
> > > > +copy mode to allow application to tune the per-socket maximum iter=
ation for
> > > > +better throughput and less frequency of send syscall.
> > > > +Allowed range is [32, xs->tx->nentries].
> > > > +
> > > >  XDP_STATISTICS getsockopt
> > > >  -------------------------
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index e8bd6ddb7b12..ce587a225661 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -84,6 +84,7 @@ struct xdp_sock {
> > > >       struct list_head map_list;
> > > >       /* Protects map_list */
> > > >       spinlock_t map_list_lock;
> > > > +     u32 max_tx_budget;
> > > >       /* Protects multiple processes in the control path */
> > > >       struct mutex mutex;
> > > >       struct xsk_queue *fq_tmp; /* Only as tmp storage before bind =
*/
> > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xd=
p.h
> > > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > > --- a/include/uapi/linux/if_xdp.h
> > > > +++ b/include/uapi/linux/if_xdp.h
> > > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > > >  #define XDP_UMEM_COMPLETION_RING     6
> > > >  #define XDP_STATISTICS                       7
> > > >  #define XDP_OPTIONS                  8
> > > > +#define XDP_MAX_TX_BUDGET            9
> > > >
> > > >  struct xdp_umem_reg {
> > > >       __u64 addr; /* Start of packet data area */
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 72c000c0ae5f..41efe7b27b0e 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -33,8 +33,8 @@
> > > >  #include "xdp_umem.h"
> > > >  #include "xsk.h"
> > > >
> > > > -#define TX_BATCH_SIZE 32
> > > > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > > > +#define TX_BUDGET_SIZE 32
> > > > +#define MAX_PER_SOCKET_BUDGET 32
> > >
> > > that could have stayed as it was before?
> >
> > Sorry, I don't think so because one definition has nothing to do with
> > the other one. Why do we need to bind them together?
> >
> > >
> > > >
> > > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > > >  {
> > > > @@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > >  {
> > > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > >
> > > you're breaking RCT here...
> >
> > What's the RCT? Never heard of this abbreviation.
> >
> > > maybe you could READ_ONCE() the budget right
> > > before the while() loop and keep the declaration only at the top of f=
unc?
> > >
> > > also nothing wrong with keeping @max_batch as a name for this budget.
> > >
> > > >       bool sent_frame =3D false;
> > > >       struct xdp_desc desc;
> > > >       struct sk_buff *skb;
> > > > @@ -797,7 +797,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >               goto out;
> > > >
> > > >       while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > > > -             if (max_batch-- =3D=3D 0) {
> > > > +             if (max_budget-- =3D=3D 0) {
> > > >                       err =3D -EAGAIN;
> > > >                       goto out;
> > > >               }
> > > > @@ -1437,6 +1437,21 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > > >               mutex_unlock(&xs->mutex);
> > > >               return err;
> > > >       }
> > > > +     case XDP_MAX_TX_BUDGET:
> > > > +     {
> > > > +             unsigned int budget;
> > > > +
> > > > +             if (optlen !=3D sizeof(budget))
> > > > +                     return -EINVAL;
> > > > +             if (copy_from_sockptr(&budget, optval, sizeof(budget)=
))
> > > > +                     return -EFAULT;
> > > > +             if (!xs->tx || xs->tx->nentries < TX_BUDGET_SIZE)
> > > > +                     return -EACCES;
> > > > +
> > > > +             WRITE_ONCE(xs->max_tx_budget,
> > > > +                        clamp(budget, TX_BUDGET_SIZE, xs->tx->nent=
ries));
> > >
> > > I think it would be better to throw errno when budget set by user is
> > > bigger than nentries. you do it for min case, let's do it for max cas=
e as
> > > well and skip the clamp() altogether?
> >
> > Okay.
> >
> > After this, do you think it's necessary to keep the getsockopt()?
> >
> > >
> > > this is rather speculative that someone would ever set such a big bud=
get
> > > but silently setting a lower value than provided might be confusing t=
o me.
> > > i'd rather get an error thrown at my face and find out the valid rang=
e.
> >
> > On point.
> >
> > >
> > > > +             return 0;
> > > > +     }
> > > >       default:
> > > >               break;
> > > >       }
> > > > @@ -1588,6 +1603,21 @@ static int xsk_getsockopt(struct socket *soc=
k, int level, int optname,
> > > >
> > > >               return 0;
> > > >       }
> > > > +     case XDP_MAX_TX_BUDGET:
> > > > +     {
> > > > +             unsigned int budget;
> > > > +
> > > > +             if (len < sizeof(budget))
> > > > +                     return -EINVAL;
> > > > +
> > > > +             budget =3D READ_ONCE(xs->max_tx_budget);
> > > > +             if (copy_to_user(optval, &budget, sizeof(budget)))
> > > > +                     return -EFAULT;
> > > > +             if (put_user(sizeof(budget), optlen))
> > > > +                     return -EFAULT;
> > > > +
> > > > +             return 0;
> > > > +     }
> > > >       default:
> > > >               break;
> > > >       }
> > > > @@ -1734,6 +1764,7 @@ static int xsk_create(struct net *net, struct=
 socket *sock, int protocol,
> > > >
> > > >       xs =3D xdp_sk(sk);
> > > >       xs->state =3D XSK_READY;
> > > > +     xs->max_tx_budget =3D TX_BUDGET_SIZE;
> > > >       mutex_init(&xs->mutex);
> > > >
> > > >       INIT_LIST_HEAD(&xs->map_list);
> > > > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi=
/linux/if_xdp.h
> > > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > > --- a/tools/include/uapi/linux/if_xdp.h
> > > > +++ b/tools/include/uapi/linux/if_xdp.h
> > > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > > >  #define XDP_UMEM_COMPLETION_RING     6
> > > >  #define XDP_STATISTICS                       7
> > > >  #define XDP_OPTIONS                  8
> > > > +#define XDP_MAX_TX_BUDGET            9
> > >
> > > could we have 'SKB' in name?
> >
> > Like XDP_MAX_TX_BUDGET_SKB ?
>
> XDP_MAX_TX_SKB_BUDGET sounds better, I assume.

Updated v7 at https://lore.kernel.org/all/20250703145045.58271-1-kerneljaso=
nxing@gmail.com/
.

Cross finger :S

Thanks,
Jason

