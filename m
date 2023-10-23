Return-Path: <bpf+bounces-12988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A761B7D2E95
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB06AB20EE1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A53134D9;
	Mon, 23 Oct 2023 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B/QKvSwZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCCF13AC3
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:37:31 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B00B7
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:37:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50906f941so46431911fa.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698053846; x=1698658646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHmFglyUVEPX00nAamiQ/LBEnj3er0a+eO4EDfWMZRI=;
        b=B/QKvSwZQx43iS8yxCscYYbBf/ij5pGOpyTO9kCdlcnsEdskH5dLgWjt7A1vE9kQs3
         mtoGPsMtq9dN3O6feI6CYF9i3k80USLHD9rJ7GK+5HhiPsLZEUP1/UZx8GEsQo1YjI+t
         HDyvepFKPxPXWmJhqQgVSdtabyEhoxpYWE+RYlha8vSOh5KjJEFqb3/Hr4B87YEVCiS+
         TPVkATkWJVVXX8ggBggrab4bYMH9zG1hI32BseVf8bYXbPE4Da+q6PLyIAy0xybnqkR7
         4AvrI14m92XhOPs5q/NQtGgwdTY6feM7WJ5tSb8ozLX2kcZA4tm1UzK6zyjTohMWQiJn
         6FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698053846; x=1698658646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHmFglyUVEPX00nAamiQ/LBEnj3er0a+eO4EDfWMZRI=;
        b=VPz0fPsT3pvTx3yl7hnx/xvS7aYKnrQcdzEDTgRyekpOYHfheiDKBhZrS2KWdx4m8i
         7057BuJFQ2Y1F5G0/KaucngCy5YcuZcYHq5raCCxcMDQdXbx3FJ+wdkoMO5A1sZ1gCfo
         O7JEGsCNMGol0k0KXvsjMf42fcmgKv/rxo+r6bOa5ir7l5Vr5YktmdbvhWIDApiKAz/7
         lj0dB1P1w09AamGMe/qcHeTm+KVc3z3rTj7GcgWvs9CkBcVIx67acVSflNe4phDET3Zw
         8/xY3M2edj5dZlA5VoLDVO+BKZ4TyPqCOLakz3xDKPVHYjMsdJwaBPVponK9VPazCyns
         hGOg==
X-Gm-Message-State: AOJu0YxKXgtclxr3tn43eUIX4TZTK+pvnSsviBOltTIJezIrMA/WJJe4
	3fa4qQsY2a99NOcJ/Ofmtkl1W6WfnpD0iInweOHWmw==
X-Google-Smtp-Source: AGHT+IHyNKPXGpldHRqPIL5oYoerq2ZPzq41R0gAnppxdlM5gZLgnBfeekHEUx7aAiSz3w0SqRzvEa7bHRBzp0OxB+E=
X-Received: by 2002:a2e:be2b:0:b0:2bb:78ad:56cb with SMTP id
 z43-20020a2ebe2b000000b002bb78ad56cbmr6300815ljq.37.1698053846379; Mon, 23
 Oct 2023 02:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
 <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
 <CABKxMyONtPR1pWLdBiK5M-NJoc5S6rpyYYUQWa0J2R+eyajOsg@mail.gmail.com> <CAJ8uoz3Vq1aHzB6Ew-yCQF8On9EP_9BSB4rOvqEgMXeA5=wZgw@mail.gmail.com>
In-Reply-To: <CAJ8uoz3Vq1aHzB6Ew-yCQF8On9EP_9BSB4rOvqEgMXeA5=wZgw@mail.gmail.com>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 23 Oct 2023 17:37:15 +0800
Message-ID: <CABKxMyNy-jOqEuQYCLrOUu1r3M-dJp+RD-KDsXbytXtwJqO4hg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
To: Magnus Karlsson <magnus.karlsson@gmail.com>
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

Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=
=8819=E6=97=A5=E5=91=A8=E5=9B=9B 17:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 19 Oct 2023 at 10:41, =E9=BB=84=E6=9D=B0 <huangjie.albert@bytedan=
ce.com> wrote:
> >
> > Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:41=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 16 Oct 2023 at 05:17, Albert Huang
> > > <huangjie.albert@bytedance.com> wrote:
> > > >
> > > > In the previous implementation, when multiple xsk sockets were
> > > > associated with a single xsk_buff_pool, a situation could arise
> > > > where the xsk_tx_list maintained data at the front for one xsk
> > > > socket while starving the xsk sockets at the back of the list.
> > > > This could result in issues such as the inability to transmit packe=
ts,
> > > > increased latency, and jitter. To address this problem, we introduc=
ed
> > > > a new variable called tx_budget_cache, which limits each xsk to tra=
nsmit
> > > > a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensu=
res
> > > > equitable opportunities for subsequent xsk sockets to send tx descr=
iptors.
> > > > The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
> > >
> > > Hi Albert. Yes you are correct that there is nothing hindering this t=
o
> > > happen in the code at the moment, so let us fix it.
> > >
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  6 ++++++
> > > >  net/xdp/xsk.c          | 18 ++++++++++++++++++
> > > >  2 files changed, 24 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 69b472604b86..f617ff54e38c 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -44,6 +44,7 @@ struct xsk_map {
> > > >         struct xdp_sock __rcu *xsk_map[];
> > > >  };
> > > >
> > > > +#define MAX_XSK_TX_BUDGET 16
> > >
> > > I think something like MAX_PER_SOCKET_BUDGET would be clearer.
> > >
> > > >  struct xdp_sock {
> > > >         /* struct sock must be the first member of struct xdp_sock =
*/
> > > >         struct sock sk;
> > > > @@ -63,6 +64,11 @@ struct xdp_sock {
> > > >
> > > >         struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > >         struct list_head tx_list;
> > > > +       /* Record the actual number of times xsk has transmitted a =
tx
> > > > +        * descriptor, with a maximum limit not exceeding MAX_XSK_T=
X_BUDGET
> > > > +        */
> > > > +       u32 tx_budget_cache;
> > > > +
> > > >         /* Protects generic receive. */
> > > >         spinlock_t rx_lock;
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index f5e96e0d6e01..087f2675333c 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
> > > >
> > > >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc =
*desc)
> > > >  {
> > > > +       u32 xsk_full_count =3D 0;
> > >
> > > Enough with a bool;
> > >
> > > >         struct xdp_sock *xs;
> > > >
> > > >         rcu_read_lock();
> > > > +again:
> > > >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> > > > +                       xsk_full_count++;
> > > > +                       continue;
> > > > +               }
> > >
> > > The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
> > > for the <=3D 2 socket case. If I have 3 sockets sharing a
> > > netdev/queue_id, the two first sockets can still starve the third one
> > > since the total budget per send is 32. You need to go through the lis=
t
> > > of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
> > > compute this dynamically before each call. Or cache this value
> > > somehow, in the pool for example. Actually, the refcount in the
> > > buf_pool will tell you how many sockets are sharing the same buf_pool=
.
> > > Try using that to form MAX_XSK_TX_BUDGET on the fly.
> > >
> > > Another simpler way of accomplishing this would be to just reorder th=
e
> > > list every time. Put the first socket last in the list every time. Th=
e
> > > drawback of this is that you need to hold the xsk_tx_list_lock while
> > > doing this so might be slower. The per socket batch size would also b=
e
> > > 32 and you would not receive "fairness" over a single call to
> > > sendto(). Would that be a problem for you?
> > >
> >
> > Currently, there are two paths in the kernel that consume TX queue desc=
riptors:
> >
> > 1=E3=80=81Native XSK
> > xsk_tx_peek_desc
> >      xskq_cons_peek_desc
> >
> > In the first scenario, we consume TX descriptors by sequentially
> > traversing the pool->xsk_tx_list
> > without any implicit code logic to ensure fairness. This can lead to a
> > scenario of starvation,
> > making it a top priority for us to address.
> >
> > 2=E3=80=81Generic XSK
> > __xsk_sendmsg (or xsk_poll)
> >      xsk_generic_xmit
> >         __xsk_generic_xmit
> >               xskq_cons_peek_desc
> >
> > In the second scenario, TX descriptors are consumed by using sendto.
> > Currently, __xsk_generic_xmit
> > sends a maximum of 32 TX descriptors each time, and the process
> > scheduling strategy already
> > ensures a certain level of fairness. In this scenario, should we
> > consider not addressing it and
> > instead prioritize the first scenario?
>
> Agree. The first scenario is the problematic one. One problem we have
> to solve there is that the batch size is up to the driver in the
> zero-copy case so the xsk core has no idea. Maybe introduce a pointer
> that tells us what socket to get packets from first and make sure this
> pointer gets updated to the next socket in the list every time the
> function is exited? Please make sure that the one socket case is not
> hurt.

The method of "introducing a pointer that tells us which socket to get
packets from first" is useful, but it requires us to manage socket
additions and removals. This would introduce
locking operations.

So it seems that the following code is simple enough and appears to
solve the problem:

1.During each iteration, check if the current socket being traversed
has exhausted its quota. If it has, skip it and continue iterating
through the remaining sockets.
2.If all sockets have been traversed, and no available transmission
descriptors (tx desc) have been found, consider whether it's time to
start a fresh iteration.
3.The logic for a fresh iteration involves checking if any socket has
used up its quota during the traversal. If any socket has reached its
quota, set the tx_budget_cache of all sockets to 0 and begin a new
iteration of the list.

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..2cf2822e9d16 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);

 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+       bool xsk_cache_full =3D false;
        struct xdp_sock *xs;

        rcu_read_lock();
+again:
        list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+               if (xs->tx_budget_cache >=3D MAX_PER_SOCKET_BUDGET) {
+                       xsk_cache_full =3D true;
+                       continue;
+               }
+
                if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
                        if (xskq_has_descs(xs->tx))
                                xskq_cons_release(xs->tx);
                        continue;
                }

+               xs->tx_budget_cache++;
+
                /* This is the backpressure mechanism for the Tx path.
                 * Reserve space in the completion queue and only proceed
                 * if there is space in it. This avoids having to implement
@@ -436,6 +445,15 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
struct xdp_desc *desc)
                return true;
        }

+not_found:
+       if (xsk_cache_full =3D=3D true) {
+               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+                       xs->tx_budget_cache =3D 0;
+               }
+               xsk_cache_full =3D false;
+               goto again;
+       }
+
 out:
        rcu_read_unlock();
        return false;

Although this method cannot achieve perfect fairness, it prevents any
sockets from starving

>
> > Additionally, based on my understanding, there should not be
> > applications concurrently using generic
> > XSK and native XSK on the same pool.
>
> That is correct.
>
> > Magnus, how do you view this issue? I'm concerned that striving for
> > absolute fairness might introduce
> > additional complexity in the logic.
>
> Is this a problem that you have observed or need to guard against in
> an application? If so, let us fix it.

Currently, we are facing issue 1.

>
> > BR
> > Albert
> >
> >
> >
> > > > +
> > > >                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
> > > >                         if (xskq_has_descs(xs->tx))
> > > >                                 xskq_cons_release(xs->tx);
> > > >                         continue;
> > > >                 }
> > > >
> > > > +               xs->tx_budget_cache++;
> > > > +
> > > >                 /* This is the backpressure mechanism for the Tx pa=
th.
> > > >                  * Reserve space in the completion queue and only p=
roceed
> > > >                  * if there is space in it. This avoids having to i=
mplement
> > > > @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *po=
ol, struct xdp_desc *desc)
> > > >                 return true;
> > > >         }
> > > >
> > > > +       if (unlikely(xsk_full_count > 0)) {
> > > > +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_=
list) {
> > > > +                       xs->tx_budget_cache =3D 0;
> > > > +               }
> > > > +               xsk_full_count =3D 0;
> > > > +               goto again;
> > > > +       }
> > > > +
> > > >  out:
> > > >         rcu_read_unlock();
> > > >         return false;
> > > > @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, stru=
ct sockaddr *addr, int addr_len)
> > > >         xs->zc =3D xs->umem->zc;
> > > >         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
> > > >         xs->queue_id =3D qid;
> > > > +       xs->tx_budget_cache =3D 0;
> > > >         xp_add_xsk(xs->pool, xs);
> > > >
> > > >  out_unlock:
> > > > --
> > > > 2.20.1
> > > >
> > > >

