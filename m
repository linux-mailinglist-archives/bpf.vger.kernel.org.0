Return-Path: <bpf+bounces-61529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A4AE864B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C79817E665
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BEB26656D;
	Wed, 25 Jun 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjNUTOv0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628528D8FB;
	Wed, 25 Jun 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861279; cv=none; b=CwjLLh15uzutjoupgktWWcJOMygff5YQzsOlOxPfQ+ROc4i8u/sotRlPZXCf0byhlo4KjWTyJ1TQ+gtWl+qKhcrsPvWEBqkl6Px3sQMBxT/n08/JdrirTfHossvYqKZiHg136M1OOBZVM91nFjPmdKIZsZKuNUXBfN7cYXsSoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861279; c=relaxed/simple;
	bh=Z/AeoenbUGinh1j2XpcfN1DLfShTFchVD4CasX1XSSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVGhS49DF0p8+oaAmfz0a/pCgwvlaURVhcn+7X/Dg0vvrFK9xlxrYO2tAxN0KzNK2EueJJFhm7VhpGvAQyBMhP0sLcr75qrbvCClyopFRrvJzzNliAhIOTETAnlDptn7wAZMVDNjk1+iXa2jkrUOvdCm5MTLtrcQA5msBGpfNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjNUTOv0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df34b727dcso7371275ab.2;
        Wed, 25 Jun 2025 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750861277; x=1751466077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73firwkFGU0VIpzvcoJAAGBtq9CpAKQSh63K1Y8NuW0=;
        b=BjNUTOv0Y+veADOyIaHRtHqmtYFmMXEWQU0OIz6U1PA9maP5GlGCMZ8Hnvxc3r/R0x
         snY/JsdhBvUllk71ggXGv2AaOrPOsJZe9ogLBdJm6AvNfRSfJq383zBex9Fi50RKbtuS
         h8DcyyT6wL3+AS+ssV7Y+gLyMx6h85+DY7nIcfeF0JfdIoPdbMVqBy/H+3XevJQiYu1n
         HOSMNodSlBQt2izLjDDX9At3dv+D2vVI1iJRwc1vGuh/6fij2md6uQKAQSrsRKJOXktP
         MuCPWix5zv6chCG+FLXOTpNSa8WaOvsx6WAp/ihAOeJZAt4L90JNgXYi+wcoBF6uY6LO
         U7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861277; x=1751466077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73firwkFGU0VIpzvcoJAAGBtq9CpAKQSh63K1Y8NuW0=;
        b=D4avkjp0uvEkY0UyxlAKW213XzCixEiL1Ib89JTXOFH+SJBeDge1sTkQDE8DkSbgNO
         MR7mpJSRCB4n2OVQiZ/fsDKDe+U7ecmUjDVd3XAsm8+LCidZ3RpsFBFeNjiSRUMYIUrr
         OK74H0II11+VBKk9UchMzjRdREiXTR72lYVqZee+TcrH3xGcNdGQIBNTEFLInR4sPy6z
         SLZOXiP16MHznaSxGywDbWndtcKs85hG2bjYBB1MmNW20tJB3fpObQuWgp0ZYrzpwlbg
         uJwbN3Wjf9r2yzofyMW8qMpUclw+OeYrIjsolKbg8Jmj/C8P9b0sw28c4c2g3+1ueq2x
         pIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgg0drvqTe1RrP/5hegiuL5JlrdTuK0gYI49UHE0qllI3jJJqKEx13U3jBgnwTg5iHwRE=@vger.kernel.org, AJvYcCWSAhJJeN479t9J3yLbxfwYgIwBKg20LUpPoFAfgVvxTkxL27y70rZ7g+KYmWPMNsrBl4uqqNxl@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV9Qe7RYkSvxc6p3gxTkouzfcBhkt1zkjO7JPo022jsPIg1CL
	hFSZx9LOmNdGm5DSNuxKwSQlAf+y1DzuZ9+vqQ+DWldswPb4xXQR77DvFHMokJFPsyh5O9jBQKR
	5TUa1wP1WwjrpfOecqM1Kz6m1J49vtkcUDOdDEpOlCQ==
X-Gm-Gg: ASbGncuLHhjSGVoOth65Gxldb5LeinrB7vENEyJZ3bsCWDxmHGNOGvCb2Qd/UdBZwpE
	QwR2+2SDBARRsFEC3UpMFOsBFjWlbONx0HnqLX4qLjJTfaCgJ4lEIFa+ooEsOkV5AAdhACRKrf3
	qTQp6i3OrfElFcCDCfv8LRgfRy1qNVPZ7G5/uxhAITmVg=
X-Google-Smtp-Source: AGHT+IGoze6V3cplGyM7QdPbvtH9ZE908tCerukEcecaDNK3u32O7l1Fz6T/E6lmSY7lnhpOJ/WSwzairYOxoPKz8kA=
X-Received: by 2002:a05:6e02:b28:b0:3df:3208:968e with SMTP id
 e9e14a558f8ab-3df328e2c22mr38972795ab.14.1750861277029; Wed, 25 Jun 2025
 07:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625123527.98209-1-kerneljasonxing@gmail.com>
 <685bfbe2b5f51_21d18929413@willemb.c.googlers.com.notmuch> <aFv+aJFkVt/ehouG@boxer>
In-Reply-To: <aFv+aJFkVt/ehouG@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 22:20:40 +0800
X-Gm-Features: Ac12FXxiB2GDDrb7EiIMiTy71y7t3tvL-b27rRxUorBwdUGsqjSpN-gRqwiqwM0
Message-ID: <CAL+tcoDwm8TOJ5BUXtm3E5mQ7hdHxUXuemUS+JO75-bd7Tj8VA@mail.gmail.com>
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

On Wed, Jun 25, 2025 at 9:50=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 25, 2025 at 09:38:42AM -0400, Willem de Bruijn wrote:
> > Jason Xing wrote:
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
> > > - Convert TX_BATCH_SIZE tx_budget_spent.
> > > - Set tx_budget_spent to 32 by default in the initialization phase as=
 a
> > >   per-socket granular control.
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
> > >  Documentation/networking/af_xdp.rst |  8 ++++++++
> > >  include/net/xdp_sock.h              |  1 +
> > >  include/uapi/linux/if_xdp.h         |  1 +
> > >  net/xdp/xsk.c                       | 20 ++++++++++++++++----
> > >  tools/include/uapi/linux/if_xdp.h   |  1 +
> > >  5 files changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/netw=
orking/af_xdp.rst
> > > index dceeb0d763aa..9eb6f7b630a5 100644
> > > --- a/Documentation/networking/af_xdp.rst
> > > +++ b/Documentation/networking/af_xdp.rst
> > > @@ -442,6 +442,14 @@ is created by a privileged process and passed to=
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
> > > +copy mode to allow application to tune the per-socket maximum iterat=
ion for
> > > +better throughput and less frequency of send syscall. Default is 32.
> > > +
> > >  XDP_STATISTICS getsockopt
> > >  -------------------------
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index e8bd6ddb7b12..ce587a225661 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -84,6 +84,7 @@ struct xdp_sock {
> > >     struct list_head map_list;
> > >     /* Protects map_list */
> > >     spinlock_t map_list_lock;
> > > +   u32 max_tx_budget;
> > >     /* Protects multiple processes in the control path */
> > >     struct mutex mutex;
> > >     struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.=
h
> > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > --- a/include/uapi/linux/if_xdp.h
> > > +++ b/include/uapi/linux/if_xdp.h
> > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > >  #define XDP_UMEM_COMPLETION_RING   6
> > >  #define XDP_STATISTICS                     7
> > >  #define XDP_OPTIONS                        8
> > > +#define XDP_MAX_TX_BUDGET          9
> > >
> > >  struct xdp_umem_reg {
> > >     __u64 addr; /* Start of packet data area */
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 72c000c0ae5f..97aded3555c1 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -33,8 +33,7 @@
> > >  #include "xdp_umem.h"
> > >  #include "xsk.h"
> > >
> > > -#define TX_BATCH_SIZE 32
> > > -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> > > +#define MAX_PER_SOCKET_BUDGET 32
> > >
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > >     bool sent_frame =3D false;
> > >     struct xdp_desc desc;
> > >     struct sk_buff *skb;
> > > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >             goto out;
> > >
> > >     while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > > -           if (max_batch-- =3D=3D 0) {
> > > +           if (max_budget-- =3D=3D 0) {
> > >                     err =3D -EAGAIN;
> > >                     goto out;
> > >             }
> > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock,=
 int level, int optname,
> > >             mutex_unlock(&xs->mutex);
> > >             return err;
> > >     }
> > > +   case XDP_MAX_TX_BUDGET:
> > > +   {
> > > +           unsigned int budget;
> > > +
> > > +           if (optlen !=3D sizeof(budget))
> > > +                   return -EINVAL;
> > > +           if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> > > +                   return -EFAULT;
> > > +
> > > +           WRITE_ONCE(xs->max_tx_budget, max(budget, 1));
> >
> > I still think that this needs a more sane upper bound than U32_MAX.

The reason why I didn't touch is that I refer to some existing
mechanisms, like net.ipv4.tcp_limit_output_bytes that also doesn't
constrain its max value for a single flow.

I really don't think it matters because 1) normally no one sets that
large value to hope one send call can deal with that many desc, 2) the
so-called proper value that may do harm to some unexpected cases which
I'm unware of for now. I wonder why not give the user a choice. After
all, it's his own decision.

> >
> > One limiting factor is the XSK TxQ length. At least it should be
> > possible to fail if trying to set beyond that.
>
> +1 and I don't really see a reason for something below 32.

Really? U32_MAX is a very very large value.

> So how about
> [32, xs->tx->nentries] range?
>
> Also if there's no xsk tx ring present we could bail out.

Sorry, I'm not sure about this. It seems to add more dependencies. But
my opinion on the lower bound is one just like dev_weight :)

Thanks,
Jason

>
> >
> > > +           return 0;
> > > +   }
> > >     default:
> > >             break;
> > >     }
> > > @@ -1734,6 +1745,7 @@ static int xsk_create(struct net *net, struct s=
ocket *sock, int protocol,
> > >
> > >     xs =3D xdp_sk(sk);
> > >     xs->state =3D XSK_READY;
> > > +   xs->max_tx_budget =3D 32;
> > >     mutex_init(&xs->mutex);
> > >
> > >     INIT_LIST_HEAD(&xs->map_list);
> > > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/l=
inux/if_xdp.h
> > > index 44f2bb93e7e6..07c6d21c2f1c 100644
> > > --- a/tools/include/uapi/linux/if_xdp.h
> > > +++ b/tools/include/uapi/linux/if_xdp.h
> > > @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
> > >  #define XDP_UMEM_COMPLETION_RING   6
> > >  #define XDP_STATISTICS                     7
> > >  #define XDP_OPTIONS                        8
> > > +#define XDP_MAX_TX_BUDGET          9
> > >
> > >  struct xdp_umem_reg {
> > >     __u64 addr; /* Start of packet data area */
> > > --
> > > 2.41.3
> > >
> >
> >

