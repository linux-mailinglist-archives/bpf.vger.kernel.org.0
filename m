Return-Path: <bpf+bounces-12999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133AE7D2FC8
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F9D1C209EE
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE914A90;
	Mon, 23 Oct 2023 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN/PrI38"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05F14A81;
	Mon, 23 Oct 2023 10:25:13 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F2DB;
	Mon, 23 Oct 2023 03:25:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cd4450c79so3865651cf.0;
        Mon, 23 Oct 2023 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698056709; x=1698661509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVH4K1NnGARKSXYIw4n1F4TDwvMMZ5jkOdUPeFeVWpg=;
        b=AN/PrI38wFS9BqXRCHrBMKJ31G/BFuxOBT12wBeo9yPek2pY4qJdDBjRs04j7Q5uLp
         7g+Td6SsA/9XT0OG5+UtkKlbCcT+/1Z0Ay8liuTIAGxcgaVYFdv7lcLZvjNMpASDIeMy
         OqGawwrluaHts7SAEgZqUtJGLxKANqsySDWvIijAyROsmPpk8+3in22B1Q/XQBmThhDR
         Pj8SDwjJTXgAVu568Nz94/aqT0/2YzauaUUiJ1yCXrvDRYAqFWUwC8fzETi894BcQ1d1
         lRCGRQKbVJomGdd9+vo9Wlbl1QXdQq6RJThXZNuee1kbnfCHQ9sz7i/hzxzflmBIA4bw
         Jm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056709; x=1698661509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVH4K1NnGARKSXYIw4n1F4TDwvMMZ5jkOdUPeFeVWpg=;
        b=f6hDWkYLRm2tmDe1ZQrUHvhXHJVeyPTRv+NPSZI1rHuKdRff+TUxdpyNy4toQV7yy2
         l+LYy2oKQfKHTxLtCaur2sHVIbBe4yQJehJAPHtgDsgtuq3yTBn6Btm+4ard2qFQlutd
         sIKDylj5vicVQhI3fb7El+Uy5VZgFHC70i7L5kMYEj3TM4Rpm8iZFcC9CHv0V3sO+IWc
         A5WLizXWBPEMgpYhsrc3qKFiCyLDnE5W0ybS2egf1ReLC/7mAHKN3nCb3a4vnNGJ6gRm
         tHfUz4dKr6sKCqJkevrqgs4FrxUP+gSpUJpC/lDuZTRN7gH0u6gaEt9mrXUowmNk9s48
         5E4Q==
X-Gm-Message-State: AOJu0YxMOq9RRvrqQ7yaofxl/6H50/qdlxahgzZ+cxGvX9TOwpA0HTjg
	WL8fdSJ6Rr+xZxGkkkuoWewRnyTE20dCJYOLWYM=
X-Google-Smtp-Source: AGHT+IFvcwEZ020RUmWYKhdHB7LQjDBBag+UV3TQuEWrDX07Iosm3sZlfkSkS1/IX2i9wcYAq9aJ0TKHHMV0S8U6ZmA=
X-Received: by 2002:a05:6214:21ec:b0:66a:d2c1:992d with SMTP id
 p12-20020a05621421ec00b0066ad2c1992dmr8938026qvj.0.1698056709348; Mon, 23 Oct
 2023 03:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
 <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
 <CABKxMyONtPR1pWLdBiK5M-NJoc5S6rpyYYUQWa0J2R+eyajOsg@mail.gmail.com>
 <CAJ8uoz3Vq1aHzB6Ew-yCQF8On9EP_9BSB4rOvqEgMXeA5=wZgw@mail.gmail.com> <CABKxMyNy-jOqEuQYCLrOUu1r3M-dJp+RD-KDsXbytXtwJqO4hg@mail.gmail.com>
In-Reply-To: <CABKxMyNy-jOqEuQYCLrOUu1r3M-dJp+RD-KDsXbytXtwJqO4hg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Oct 2023 12:24:58 +0200
Message-ID: <CAJ8uoz0MfVw2gZFuJJec51_8qaN0SS4gHStorivVpCprG2LY-w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
To: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Oct 2023 at 11:37, =E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance=
.com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8819=E6=97=A5=E5=91=A8=E5=9B=9B 17:13=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, 19 Oct 2023 at 10:41, =E9=BB=84=E6=9D=B0 <huangjie.albert@byted=
ance.com> wrote:
> > >
> > > Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:41=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Mon, 16 Oct 2023 at 05:17, Albert Huang
> > > > <huangjie.albert@bytedance.com> wrote:
> > > > >
> > > > > In the previous implementation, when multiple xsk sockets were
> > > > > associated with a single xsk_buff_pool, a situation could arise
> > > > > where the xsk_tx_list maintained data at the front for one xsk
> > > > > socket while starving the xsk sockets at the back of the list.
> > > > > This could result in issues such as the inability to transmit pac=
kets,
> > > > > increased latency, and jitter. To address this problem, we introd=
uced
> > > > > a new variable called tx_budget_cache, which limits each xsk to t=
ransmit
> > > > > a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation en=
sures
> > > > > equitable opportunities for subsequent xsk sockets to send tx des=
criptors.
> > > > > The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
> > > >
> > > > Hi Albert. Yes you are correct that there is nothing hindering this=
 to
> > > > happen in the code at the moment, so let us fix it.
> > > >
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  include/net/xdp_sock.h |  6 ++++++
> > > > >  net/xdp/xsk.c          | 18 ++++++++++++++++++
> > > > >  2 files changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > index 69b472604b86..f617ff54e38c 100644
> > > > > --- a/include/net/xdp_sock.h
> > > > > +++ b/include/net/xdp_sock.h
> > > > > @@ -44,6 +44,7 @@ struct xsk_map {
> > > > >         struct xdp_sock __rcu *xsk_map[];
> > > > >  };
> > > > >
> > > > > +#define MAX_XSK_TX_BUDGET 16
> > > >
> > > > I think something like MAX_PER_SOCKET_BUDGET would be clearer.
> > > >
> > > > >  struct xdp_sock {
> > > > >         /* struct sock must be the first member of struct xdp_soc=
k */
> > > > >         struct sock sk;
> > > > > @@ -63,6 +64,11 @@ struct xdp_sock {
> > > > >
> > > > >         struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > > >         struct list_head tx_list;
> > > > > +       /* Record the actual number of times xsk has transmitted =
a tx
> > > > > +        * descriptor, with a maximum limit not exceeding MAX_XSK=
_TX_BUDGET
> > > > > +        */
> > > > > +       u32 tx_budget_cache;
> > > > > +
> > > > >         /* Protects generic receive. */
> > > > >         spinlock_t rx_lock;
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index f5e96e0d6e01..087f2675333c 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
> > > > >
> > > > >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_des=
c *desc)
> > > > >  {
> > > > > +       u32 xsk_full_count =3D 0;
> > > >
> > > > Enough with a bool;
> > > >
> > > > >         struct xdp_sock *xs;
> > > > >
> > > > >         rcu_read_lock();
> > > > > +again:
> > > > >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> > > > > +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> > > > > +                       xsk_full_count++;
> > > > > +                       continue;
> > > > > +               }
> > > >
> > > > The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
> > > > for the <=3D 2 socket case. If I have 3 sockets sharing a
> > > > netdev/queue_id, the two first sockets can still starve the third o=
ne
> > > > since the total budget per send is 32. You need to go through the l=
ist
> > > > of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
> > > > compute this dynamically before each call. Or cache this value
> > > > somehow, in the pool for example. Actually, the refcount in the
> > > > buf_pool will tell you how many sockets are sharing the same buf_po=
ol.
> > > > Try using that to form MAX_XSK_TX_BUDGET on the fly.
> > > >
> > > > Another simpler way of accomplishing this would be to just reorder =
the
> > > > list every time. Put the first socket last in the list every time. =
The
> > > > drawback of this is that you need to hold the xsk_tx_list_lock whil=
e
> > > > doing this so might be slower. The per socket batch size would also=
 be
> > > > 32 and you would not receive "fairness" over a single call to
> > > > sendto(). Would that be a problem for you?
> > > >
> > >
> > > Currently, there are two paths in the kernel that consume TX queue de=
scriptors:
> > >
> > > 1=E3=80=81Native XSK
> > > xsk_tx_peek_desc
> > >      xskq_cons_peek_desc
> > >
> > > In the first scenario, we consume TX descriptors by sequentially
> > > traversing the pool->xsk_tx_list
> > > without any implicit code logic to ensure fairness. This can lead to =
a
> > > scenario of starvation,
> > > making it a top priority for us to address.
> > >
> > > 2=E3=80=81Generic XSK
> > > __xsk_sendmsg (or xsk_poll)
> > >      xsk_generic_xmit
> > >         __xsk_generic_xmit
> > >               xskq_cons_peek_desc
> > >
> > > In the second scenario, TX descriptors are consumed by using sendto.
> > > Currently, __xsk_generic_xmit
> > > sends a maximum of 32 TX descriptors each time, and the process
> > > scheduling strategy already
> > > ensures a certain level of fairness. In this scenario, should we
> > > consider not addressing it and
> > > instead prioritize the first scenario?
> >
> > Agree. The first scenario is the problematic one. One problem we have
> > to solve there is that the batch size is up to the driver in the
> > zero-copy case so the xsk core has no idea. Maybe introduce a pointer
> > that tells us what socket to get packets from first and make sure this
> > pointer gets updated to the next socket in the list every time the
> > function is exited? Please make sure that the one socket case is not
> > hurt.
>
> The method of "introducing a pointer that tells us which socket to get
> packets from first" is useful, but it requires us to manage socket
> additions and removals. This would introduce
> locking operations.
>
> So it seems that the following code is simple enough and appears to
> solve the problem:
>
> 1.During each iteration, check if the current socket being traversed
> has exhausted its quota. If it has, skip it and continue iterating
> through the remaining sockets.
> 2.If all sockets have been traversed, and no available transmission
> descriptors (tx desc) have been found, consider whether it's time to
> start a fresh iteration.
> 3.The logic for a fresh iteration involves checking if any socket has
> used up its quota during the traversal. If any socket has reached its
> quota, set the tx_budget_cache of all sockets to 0 and begin a new
> iteration of the list.
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f5e96e0d6e01..2cf2822e9d16 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
>
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  {
> +       bool xsk_cache_full =3D false;
>         struct xdp_sock *xs;
>
>         rcu_read_lock();
> +again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               if (xs->tx_budget_cache >=3D MAX_PER_SOCKET_BUDGET) {

The problem here is what to set this MAX_PER_SOCKET_BUDGET to? We do
not want to penalize the one socket per page pool case, so this would
then have to be very large. But this might not be a problem as all new
drivers are using the batched interface (since Maciej is forcing
everyone to use it :-) ), and it will only go this path that you are
modifying in the multiple sockets per page pool case. So I think it's
fine. But still, what is a good value? 32 or 64?

> +                       xsk_cache_full =3D true;
> +                       continue;
> +               }
> +
>                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
>                         if (xskq_has_descs(xs->tx))
>                                 xskq_cons_release(xs->tx);
>                         continue;
>                 }
>
> +               xs->tx_budget_cache++;
> +
>                 /* This is the backpressure mechanism for the Tx path.
>                  * Reserve space in the completion queue and only proceed
>                  * if there is space in it. This avoids having to impleme=
nt
> @@ -436,6 +445,15 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
> struct xdp_desc *desc)
>                 return true;
>         }
>
> +not_found:

You are not using this label, but I am probably not seeing all the code her=
e.

> +       if (xsk_cache_full =3D=3D true) {
> +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) =
{
> +                       xs->tx_budget_cache =3D 0;
> +               }
> +               xsk_cache_full =3D false;
> +               goto again;
> +       }
> +
>  out:
>         rcu_read_unlock();
>         return false;
>
> Although this method cannot achieve perfect fairness, it prevents any
> sockets from starving

That is perfectly fine. We should not aim for perfect fairness since
that would be prohibitively expensive. If someone wants that, they can
implement that code on top of this.

Your approach looks good to me. Please produce a patch.

Thanks!

> >
> > > Additionally, based on my understanding, there should not be
> > > applications concurrently using generic
> > > XSK and native XSK on the same pool.
> >
> > That is correct.
> >
> > > Magnus, how do you view this issue? I'm concerned that striving for
> > > absolute fairness might introduce
> > > additional complexity in the logic.
> >
> > Is this a problem that you have observed or need to guard against in
> > an application? If so, let us fix it.
>
> Currently, we are facing issue 1.
>
> >
> > > BR
> > > Albert
> > >
> > >
> > >
> > > > > +
> > > > >                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
> > > > >                         if (xskq_has_descs(xs->tx))
> > > > >                                 xskq_cons_release(xs->tx);
> > > > >                         continue;
> > > > >                 }
> > > > >
> > > > > +               xs->tx_budget_cache++;
> > > > > +
> > > > >                 /* This is the backpressure mechanism for the Tx =
path.
> > > > >                  * Reserve space in the completion queue and only=
 proceed
> > > > >                  * if there is space in it. This avoids having to=
 implement
> > > > > @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *=
pool, struct xdp_desc *desc)
> > > > >                 return true;
> > > > >         }
> > > > >
> > > > > +       if (unlikely(xsk_full_count > 0)) {
> > > > > +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, t=
x_list) {
> > > > > +                       xs->tx_budget_cache =3D 0;
> > > > > +               }
> > > > > +               xsk_full_count =3D 0;
> > > > > +               goto again;
> > > > > +       }
> > > > > +
> > > > >  out:
> > > > >         rcu_read_unlock();
> > > > >         return false;
> > > > > @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, st=
ruct sockaddr *addr, int addr_len)
> > > > >         xs->zc =3D xs->umem->zc;
> > > > >         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
> > > > >         xs->queue_id =3D qid;
> > > > > +       xs->tx_budget_cache =3D 0;
> > > > >         xp_add_xsk(xs->pool, xs);
> > > > >
> > > > >  out_unlock:
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > >

