Return-Path: <bpf+bounces-61631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148D7AE939D
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B14A604C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD5194AD5;
	Thu, 26 Jun 2025 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwp8Xf0p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD003335C7;
	Thu, 26 Jun 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750900602; cv=none; b=gyrsf+ZL+sK1BmVcMFMs7oE0J2ubo3UITG7haPpXrtGdWIcWYQYC5qrCip+o1Lwc7Yr8FYG45F0qjP3RAVBcTKq2uOVK865vw/mcFNxkfBpaWRQcQsr0KzUQg0vU/cwfBCQ4toL0aGxJeQ9onUsTY3UUCavT99SW9+6GoLHUebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750900602; c=relaxed/simple;
	bh=fZmEkcRaphS1Pzp0p2e7DQb6gDbkGOjJ9wLn/H2FEj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQU98+0KB5WYwtVjQke8WOCaUq9aATRAmVaL7gJLupraz6gmjA+dL6EMPu4FRgEjmr9ARqq4RQBQqx6rxxZs5hcSeYNN82t8Ghkwz+jtCx1uIvnwlnjjz0CAcC32Xo2AsJhl5u53gNCAPktCAbOdlCe2BEab5+4FNO2ddz+sWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwp8Xf0p; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df303e45d3so1753025ab.0;
        Wed, 25 Jun 2025 18:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750900600; x=1751505400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPjTX8a7bDkTwMmxbizDS1L5yf8OvTy1ffktEu+LZNY=;
        b=Qwp8Xf0pbncFk2nCeEwF2Q4gMtYIIknaRc6iePEyJZL2GjAks1PdInGqVmn3e1YUey
         s5EqOHNcyl0e9pkoyPCWQ8Jawiq+lOz8JYi4cSCpuvtortQJxo+G+o0nL7tR6ICss3bz
         fk79cyxKi3RAsE5q51Vc2Gmmp6JRCUlg2fFoARWdcaUr3lOgkREBDpEC1cDjRe4ti50r
         tnadW61SKhAVL3yj8q8hrJtnIx7D5FosnyurhplGcyBdUvx80tjyHw3Qdo/BiU8Se2A7
         D493xCHfXeB5cIfN3sH9eJN3uRFiWaSNeYdIUQqSIi2RE26bm1WSqZb8w0vREyOx1u0J
         iPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750900600; x=1751505400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPjTX8a7bDkTwMmxbizDS1L5yf8OvTy1ffktEu+LZNY=;
        b=qK1VGkU6cjUdOmb+Pdg+oiLTg++Rfmqy/YQdJgDARQRB4tx6OnCrFY8S+i9ytr/W3A
         Vbq3Bh2oSf+NIhsXEQmTDMAyCPq350iMYhajccAgp+4DXJU8AzHP42pIMHUupLi3GjmX
         SAQOTHEpgv4E4Ka3KWSLNaERnctsINZA9IHv3TyPlDptk8Q5s4cTY+5xrrmazFMbhwCB
         KQwWEXt4xIQDhUytFnWuHmuXLKZaj2jK9xRa53906lEsIgU6pgoQlJJOTIt7DO2x1avT
         jOVfpfFaux8lBDfhHUvhRc8wPGQOLxeh/yeYFmfpRP1VMKNnk4rljoeYpefne7pHstC7
         J8OA==
X-Forwarded-Encrypted: i=1; AJvYcCW1BegEBzzZqEZvG7jndp3w9h1CtSPcwcWhl92lhw1TWxh5kNAFljZZx29JdiLQEdfRv4BmK5SR@vger.kernel.org, AJvYcCWR9LHd6uJz0zQzo6f4bHeo+Dzl+1k6c6ya/4UfuFw2eMRIMLa82gXI3i4EMWTzyAPASdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpg5TVe+vM0e7xP4FMxwcJZEWL459pBO2dBOBI94CCs5XCB3oS
	TFNyeYCAbsqmQKUugdjOzz7s1UhII0Il9aP8NlhZAyUw2SOp7ijz2EmQJf6wMglafTdN3TCY+1I
	+Q165thEk7oGpYUo3HSQfSTT3PDBrE0c=
X-Gm-Gg: ASbGnctGk/DNVAZ64/6fslVfvLxyljjS3sPAa1JdEO5m8enl9RTKU/Z4I5T5sdLEuxQ
	0IxCPq1XRiHFVWJgdlWJLS63CRbpXBge6ufA7n4pORR+0Hf/Hm2gawmXC1z89LX91AiTcziEHEN
	X/dZ3+iTYMz/q1dWp0IsaR+Pjzx2w/AxzqIrmBm8EWAkdMFuAGprBj
X-Google-Smtp-Source: AGHT+IHxI/wBMLUevRgmclJysFQpqQNablAbPvYRZiZCEaUvYJLvwDTGPm1aGxZijAcYbARN+gVz4SSLb1h/7HYlce0=
X-Received: by 2002:a05:6e02:1a63:b0:3dd:babf:9b00 with SMTP id
 e9e14a558f8ab-3df3287f2e6mr63549095ab.1.1750900599690; Wed, 25 Jun 2025
 18:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625123527.98209-1-kerneljasonxing@gmail.com>
 <685bfbe2b5f51_21d18929413@willemb.c.googlers.com.notmuch>
 <aFv+aJFkVt/ehouG@boxer> <CAL+tcoDwm8TOJ5BUXtm3E5mQ7hdHxUXuemUS+JO75-bd7Tj8VA@mail.gmail.com>
In-Reply-To: <CAL+tcoDwm8TOJ5BUXtm3E5mQ7hdHxUXuemUS+JO75-bd7Tj8VA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Jun 2025 09:16:03 +0800
X-Gm-Features: Ac12FXyAx2smAUo9NkXhznKH_45qyMoFCVjSLpziQfVqTf6yrNEW44J24FTkQaw
Message-ID: <CAL+tcoA92M4ywB9xKZoW_GMib18nakWkQpX_GQdYYotKC_5ORg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: xsk: introduce XDP_MAX_TX_BUDGET setsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 10:20=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Wed, Jun 25, 2025 at 9:50=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 25, 2025 at 09:38:42AM -0400, Willem de Bruijn wrote:
> > > Jason Xing wrote:
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
> > > > - Convert TX_BATCH_SIZE tx_budget_spent.
> > > > - Set tx_budget_spent to 32 by default in the initialization phase =
as a
> > > >   per-socket granular control.
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
> > > >  Documentation/networking/af_xdp.rst |  8 ++++++++
> > > >  include/net/xdp_sock.h              |  1 +
> > > >  include/uapi/linux/if_xdp.h         |  1 +
> > > >  net/xdp/xsk.c                       | 20 ++++++++++++++++----
> > > >  tools/include/uapi/linux/if_xdp.h   |  1 +
> > > >  5 files changed, 27 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/ne=
tworking/af_xdp.rst
> > > > index dceeb0d763aa..9eb6f7b630a5 100644
> > > > --- a/Documentation/networking/af_xdp.rst
> > > > +++ b/Documentation/networking/af_xdp.rst
> > > > @@ -442,6 +442,14 @@ is created by a privileged process and passed =
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
> > > > +copy mode to allow application to tune the per-socket maximum iter=
ation for
> > > > +better throughput and less frequency of send syscall. Default is 3=
2.
> > > > +
> > > >  XDP_STATISTICS getsockopt
> > > >  -------------------------
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index e8bd6ddb7b12..ce587a225661 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -84,6 +84,7 @@ struct xdp_sock {
> > > >     struct list_head map_list;
> > > >     /* Protects map_list */
> > > >     spinlock_t map_list_lock;
> > > > +   u32 max_tx_budget;
> > > >     /* Protects multiple processes in the control path */
> > > >     struct mutex mutex;
> > > >     struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xd=
p.h
> > > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > > --- a/include/uapi/linux/if_xdp.h
> > > > +++ b/include/uapi/linux/if_xdp.h
> > > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > > >  #define XDP_UMEM_COMPLETION_RING   6
> > > >  #define XDP_STATISTICS                     7
> > > >  #define XDP_OPTIONS                        8
> > > > +#define XDP_MAX_TX_BUDGET          9
> > > >
> > > >  struct xdp_umem_reg {
> > > >     __u64 addr; /* Start of packet data area */
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 72c000c0ae5f..97aded3555c1 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -33,8 +33,7 @@
> > > >  #include "xdp_umem.h"
> > > >  #include "xsk.h"
> > > >
> > > > -#define TX_BATCH_SIZE 32
> > > > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > > > +#define MAX_PER_SOCKET_BUDGET 32
> > > >
> > > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > > >  {
> > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > >  {
> > > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > >     bool sent_frame =3D false;
> > > >     struct xdp_desc desc;
> > > >     struct sk_buff *skb;
> > > > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >             goto out;
> > > >
> > > >     while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > > > -           if (max_batch-- =3D=3D 0) {
> > > > +           if (max_budget-- =3D=3D 0) {
> > > >                     err =3D -EAGAIN;
> > > >                     goto out;
> > > >             }
> > > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > > >             mutex_unlock(&xs->mutex);
> > > >             return err;
> > > >     }
> > > > +   case XDP_MAX_TX_BUDGET:
> > > > +   {
> > > > +           unsigned int budget;
> > > > +
> > > > +           if (optlen !=3D sizeof(budget))
> > > > +                   return -EINVAL;
> > > > +           if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > > > +                   return -EFAULT;
> > > > +
> > > > +           WRITE_ONCE(xs->max_tx_budget, max(budget, 1));
> > >
> > > I still think that this needs a more sane upper bound than U32_MAX.
>
> The reason why I didn't touch is that I refer to some existing
> mechanisms, like net.ipv4.tcp_limit_output_bytes that also doesn't
> constrain its max value for a single flow.
>
> I really don't think it matters because 1) normally no one sets that
> large value to hope one send call can deal with that many desc, 2) the
> so-called proper value that may do harm to some unexpected cases which
> I'm unware of for now. I wonder why not give the user a choice. After
> all, it's his own decision.
>
> > >
> > > One limiting factor is the XSK TxQ length. At least it should be
> > > possible to fail if trying to set beyond that.
> >
> > +1 and I don't really see a reason for something below 32.
>
> Really? U32_MAX is a very very large value.
>
> > So how about
> > [32, xs->tx->nentries] range?

Sorry, I still think one is an appropriate lower value because setting
a lower value than 32 is not that a big bad thing for users or even
not a bad thing at all. The first version of the value is 16 which had
been used for a while. I guess Willem is worried that a too large
value may have an adverse impact on the system/xsk flow?

> >
> > Also if there's no xsk tx ring present we could bail out.
>
> Sorry, I'm not sure about this. It seems to add more dependencies. But
> my opinion on the lower bound is one just like dev_weight :)

After rethinking setting xs->tx->nentries as its upper bound, it makes
sense to me overall. But I'm not sure if such a case can happen in the
real world:
1) CPU 0: keep calling sendto() or poll() syscall to driver the xsk to
send the packets (in __xsk_generic_xmit())
2) CPU 1: keep writing the data into the tx ring in the application
(like by using xsk_ring_prod__submit(xsk->tx, index))
?
If the asynchrony of writing and sending desc might happen, the
'xs->tx->nentries' doesn't have a strong underlying theory to support
any more. At least, AFAIK, with my limited knowledge, we don't
prohibit users from trying the above scenario, right?

Since the patch was marked as change-requested, please allow me to ask
one more time: if we really need a valid max number for it?

Thanks,
Jason

>
> Thanks,
> Jason
>
> >
> > >
> > > > +           return 0;
> > > > +   }
> > > >     default:
> > > >             break;
> > > >     }
> > > > @@ -1734,6 +1745,7 @@ static int xsk_create(struct net *net, struct=
 socket *sock, int protocol,
> > > >
> > > >     xs =3D xdp_sk(sk);
> > > >     xs->state =3D XSK_READY;
> > > > +   xs->max_tx_budget =3D 32;
> > > >     mutex_init(&xs->mutex);
> > > >
> > > >     INIT_LIST_HEAD(&xs->map_list);
> > > > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi=
/linux/if_xdp.h
> > > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > > --- a/tools/include/uapi/linux/if_xdp.h
> > > > +++ b/tools/include/uapi/linux/if_xdp.h
> > > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > > >  #define XDP_UMEM_COMPLETION_RING   6
> > > >  #define XDP_STATISTICS                     7
> > > >  #define XDP_OPTIONS                        8
> > > > +#define XDP_MAX_TX_BUDGET          9
> > > >
> > > >  struct xdp_umem_reg {
> > > >     __u64 addr; /* Start of packet data area */
> > > > --
> > > > 2.41.3
> > > >
> > >
> > >

