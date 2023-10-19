Return-Path: <bpf+bounces-12686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C27CF3B0
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E904BB20ED4
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D418171B8;
	Thu, 19 Oct 2023 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGuyxjWY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB3171A6;
	Thu, 19 Oct 2023 09:12:52 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB647136;
	Thu, 19 Oct 2023 02:12:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d32cc3957so10383776d6.0;
        Thu, 19 Oct 2023 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697706768; x=1698311568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWNooNg/Y6CGESg+ZjVOOHYVpkeT1UB3lOiWYIImT/s=;
        b=IGuyxjWYJOvFXlBIOY1hw46lKKQy/O85tQCMld3C8oHNchaniWPttj+YOhjhpLahS0
         giGm8iXiujWkZQdwFEah6hzDGqLxDL7DFUuq57XoBvM0p/Alz9cdde30iu2ihOgUQADx
         kGoiG3EJgyVott8I+EtehwWfwZuzNOQExeSs2syFsWUAqNlWTJAs/RzrKoBjRqgt6Lxn
         azkLiS/HuRQeNs0SKjl0tquCAjza5D2DsnRZ6XzcWXVtlSu3em+1eHDkmMBUDVAo5V+d
         asyCHZwmd+wizKFfUnilKM2t+DAJM9Tzm689Wx5BKVO/bX8VHdbvewk5Uoxzl2y9OGKp
         G2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706768; x=1698311568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWNooNg/Y6CGESg+ZjVOOHYVpkeT1UB3lOiWYIImT/s=;
        b=Wlz8v69dewJewhYiUR4RsKEzangrqUT0S/YHabmJUOre7jkTuiienLZFwlIMF+IVzE
         DTg2i7skexy/6TkQZ4NEVNamjm2FRknbYchDF2C0uGGl+Q9fEQsSKYTCqQ2aSXp/RPZQ
         tuS+C7BbiuzT9Tf3N6c1rfriWYJma895sGAjJf+YN1qAyumWcc5HWx1B4q+0/tg+H2ew
         bjv/ht83b1+S/jKxT8XHsF/8BpacyGQg5/MIBcX7kVSZmMfYv3izsTHgwGLJ4UqgN5jI
         IJLpaVuPORHT7xXGCIUf5vjenF0ofjkgmS+fWHG4wXu93ni0clcuzAwB4C2Ijzr5uWxz
         Xs9A==
X-Gm-Message-State: AOJu0YxEjCKJeexdZWAsEiyQxD9er/mGOPycQXGSQxLa8o4XgjoVFhKz
	6F6jCW3x3UMCXKg04jC7bbRt9M0IKHtHMhEI1us=
X-Google-Smtp-Source: AGHT+IGvkKwbx8ERyXOwHsQwi7t9BqKOLrtyKPG3RkU/n2283bQFmpTC88SU/oVLpAg3BfXBMYe6miuA/pSG6Ibp1c4=
X-Received: by 2002:a05:6214:3d8d:b0:66d:1b9b:196c with SMTP id
 om13-20020a0562143d8d00b0066d1b9b196cmr1700631qvb.2.1697706768487; Thu, 19
 Oct 2023 02:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
 <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com> <CABKxMyONtPR1pWLdBiK5M-NJoc5S6rpyYYUQWa0J2R+eyajOsg@mail.gmail.com>
In-Reply-To: <CABKxMyONtPR1pWLdBiK5M-NJoc5S6rpyYYUQWa0J2R+eyajOsg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 19 Oct 2023 11:12:37 +0200
Message-ID: <CAJ8uoz3Vq1aHzB6Ew-yCQF8On9EP_9BSB4rOvqEgMXeA5=wZgw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the
 end of the list
To: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Oct 2023 at 10:41, =E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance=
.com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 14:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, 16 Oct 2023 at 05:17, Albert Huang
> > <huangjie.albert@bytedance.com> wrote:
> > >
> > > In the previous implementation, when multiple xsk sockets were
> > > associated with a single xsk_buff_pool, a situation could arise
> > > where the xsk_tx_list maintained data at the front for one xsk
> > > socket while starving the xsk sockets at the back of the list.
> > > This could result in issues such as the inability to transmit packets=
,
> > > increased latency, and jitter. To address this problem, we introduced
> > > a new variable called tx_budget_cache, which limits each xsk to trans=
mit
> > > a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensure=
s
> > > equitable opportunities for subsequent xsk sockets to send tx descrip=
tors.
> > > The value of MAX_XSK_TX_BUDGET is temporarily set to 16.
> >
> > Hi Albert. Yes you are correct that there is nothing hindering this to
> > happen in the code at the moment, so let us fix it.
> >
> > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > ---
> > >  include/net/xdp_sock.h |  6 ++++++
> > >  net/xdp/xsk.c          | 18 ++++++++++++++++++
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index 69b472604b86..f617ff54e38c 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -44,6 +44,7 @@ struct xsk_map {
> > >         struct xdp_sock __rcu *xsk_map[];
> > >  };
> > >
> > > +#define MAX_XSK_TX_BUDGET 16
> >
> > I think something like MAX_PER_SOCKET_BUDGET would be clearer.
> >
> > >  struct xdp_sock {
> > >         /* struct sock must be the first member of struct xdp_sock */
> > >         struct sock sk;
> > > @@ -63,6 +64,11 @@ struct xdp_sock {
> > >
> > >         struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > >         struct list_head tx_list;
> > > +       /* Record the actual number of times xsk has transmitted a tx
> > > +        * descriptor, with a maximum limit not exceeding MAX_XSK_TX_=
BUDGET
> > > +        */
> > > +       u32 tx_budget_cache;
> > > +
> > >         /* Protects generic receive. */
> > >         spinlock_t rx_lock;
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index f5e96e0d6e01..087f2675333c 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
> > >
> > >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *d=
esc)
> > >  {
> > > +       u32 xsk_full_count =3D 0;
> >
> > Enough with a bool;
> >
> > >         struct xdp_sock *xs;
> > >
> > >         rcu_read_lock();
> > > +again:
> > >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > +               if (xs->tx_budget_cache >=3D MAX_XSK_TX_BUDGET) {
> > > +                       xsk_full_count++;
> > > +                       continue;
> > > +               }
> >
> > The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
> > for the <=3D 2 socket case. If I have 3 sockets sharing a
> > netdev/queue_id, the two first sockets can still starve the third one
> > since the total budget per send is 32. You need to go through the list
> > of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
> > compute this dynamically before each call. Or cache this value
> > somehow, in the pool for example. Actually, the refcount in the
> > buf_pool will tell you how many sockets are sharing the same buf_pool.
> > Try using that to form MAX_XSK_TX_BUDGET on the fly.
> >
> > Another simpler way of accomplishing this would be to just reorder the
> > list every time. Put the first socket last in the list every time. The
> > drawback of this is that you need to hold the xsk_tx_list_lock while
> > doing this so might be slower. The per socket batch size would also be
> > 32 and you would not receive "fairness" over a single call to
> > sendto(). Would that be a problem for you?
> >
>
> Currently, there are two paths in the kernel that consume TX queue descri=
ptors:
>
> 1=E3=80=81Native XSK
> xsk_tx_peek_desc
>      xskq_cons_peek_desc
>
> In the first scenario, we consume TX descriptors by sequentially
> traversing the pool->xsk_tx_list
> without any implicit code logic to ensure fairness. This can lead to a
> scenario of starvation,
> making it a top priority for us to address.
>
> 2=E3=80=81Generic XSK
> __xsk_sendmsg (or xsk_poll)
>      xsk_generic_xmit
>         __xsk_generic_xmit
>               xskq_cons_peek_desc
>
> In the second scenario, TX descriptors are consumed by using sendto.
> Currently, __xsk_generic_xmit
> sends a maximum of 32 TX descriptors each time, and the process
> scheduling strategy already
> ensures a certain level of fairness. In this scenario, should we
> consider not addressing it and
> instead prioritize the first scenario?

Agree. The first scenario is the problematic one. One problem we have
to solve there is that the batch size is up to the driver in the
zero-copy case so the xsk core has no idea. Maybe introduce a pointer
that tells us what socket to get packets from first and make sure this
pointer gets updated to the next socket in the list every time the
function is exited? Please make sure that the one socket case is not
hurt.

> Additionally, based on my understanding, there should not be
> applications concurrently using generic
> XSK and native XSK on the same pool.

That is correct.

> Magnus, how do you view this issue? I'm concerned that striving for
> absolute fairness might introduce
> additional complexity in the logic.

Is this a problem that you have observed or need to guard against in
an application? If so, let us fix it.

> BR
> Albert
>
>
>
> > > +
> > >                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
> > >                         if (xskq_has_descs(xs->tx))
> > >                                 xskq_cons_release(xs->tx);
> > >                         continue;
> > >                 }
> > >
> > > +               xs->tx_budget_cache++;
> > > +
> > >                 /* This is the backpressure mechanism for the Tx path=
.
> > >                  * Reserve space in the completion queue and only pro=
ceed
> > >                  * if there is space in it. This avoids having to imp=
lement
> > > @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool=
, struct xdp_desc *desc)
> > >                 return true;
> > >         }
> > >
> > > +       if (unlikely(xsk_full_count > 0)) {
> > > +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_li=
st) {
> > > +                       xs->tx_budget_cache =3D 0;
> > > +               }
> > > +               xsk_full_count =3D 0;
> > > +               goto again;
> > > +       }
> > > +
> > >  out:
> > >         rcu_read_unlock();
> > >         return false;
> > > @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, struct=
 sockaddr *addr, int addr_len)
> > >         xs->zc =3D xs->umem->zc;
> > >         xs->sg =3D !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
> > >         xs->queue_id =3D qid;
> > > +       xs->tx_budget_cache =3D 0;
> > >         xp_add_xsk(xs->pool, xs);
> > >
> > >  out_unlock:
> > > --
> > > 2.20.1
> > >
> > >

