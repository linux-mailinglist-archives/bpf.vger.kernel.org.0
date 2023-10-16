Return-Path: <bpf+bounces-12254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E957CA3C5
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607E81F21D67
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19171C69B;
	Mon, 16 Oct 2023 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNoK/O4f"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA81C2BC;
	Mon, 16 Oct 2023 09:13:46 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484711D;
	Mon, 16 Oct 2023 02:13:39 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d32cc3957so4533766d6.0;
        Mon, 16 Oct 2023 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697447618; x=1698052418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV6DflMNBX14qMP7YfQLclHdhrT+garH2KzB7LF0MMg=;
        b=RNoK/O4fy/UBiTu6SHGBzuBC4jiZnCh7EB6uHnwCxqJ+6YQJJlvWZ6GddZm5H0NFpe
         1MIkzHFLN5D6F/RuuWugLblzGYBFfgZTxxhQXwjNQXZrtIP7zdSOiwAbbR0xddxIMtTn
         9qsyjLmlIXsUxMWT5SeKXmrsqouZizLEbbo4DQSSp3qzJ+Myn+OoX05Hntfwp1ezrqCv
         H2reiaur4ljbOPOxsNi2M5Iu704K36+14ZFP6NACAxqTT1XNPqZ1DabYTXOv5UMzzbvj
         MggJL2QNpOaZ3RZ6KwAO8WFK/fzmVF7e96fJ9N5LjXHKDTT+Zq8w+Fuxrbhvewq23zzb
         3pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447618; x=1698052418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV6DflMNBX14qMP7YfQLclHdhrT+garH2KzB7LF0MMg=;
        b=kUSS1cGSR3HnQZb5PYZuU8d73HJSnhldCSX0J3m5W6oylGBVCDw3ytzZ6bCUpgSVQ6
         AEXQ9Pg/ZJrq8ILoRLcKGwsI5zYNohMEx5eexzfnRsWotcnJIxasIqM/MC1p0We0eL/X
         FwJKbCZgTq9uesZz0Fi4I2PV4li8mZrSwsrpHJgApE3eftDshsb5vkozvUXm2Qyl8xZq
         2oL7CZwhJSx56LZs9HftPcouafXmDQC1MWolvN+5xHK4P4HcBeybEJ8rh2H9CHy4a21C
         towN1IA+bK4Q68NSlYCTpWaL0VgLDofzdxmTTP/hc4cb971XO8dQWAccful0H9SEjKEU
         s9Iw==
X-Gm-Message-State: AOJu0YzI9GRZYCKg/RpIVGpdAf2zMgiMUE7UQd/62xdXhE8EeA+Funik
	U0t7jRHya3wOFw9mLk6rwku/LyAUsU4EEXyw3a4=
X-Google-Smtp-Source: AGHT+IHkZ4yQKerCm8GItti5oh524Ivsp368Y5uJSdMgAnqBi2nogH76lTnfZdB9yZ0IaQ4sYzQKZgzfzjBG36KH4IU=
X-Received: by 2002:a05:6214:a63:b0:66d:1012:c16a with SMTP id
 ef3-20020a0562140a6300b0066d1012c16amr12047705qvb.1.1697447618114; Mon, 16
 Oct 2023 02:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
 <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com> <CABKxMyMieNNMXFMTRdof1W43ijvZq5e04nOkXFv5djzadXh0xQ@mail.gmail.com>
In-Reply-To: <CABKxMyMieNNMXFMTRdof1W43ijvZq5e04nOkXFv5djzadXh0xQ@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 16 Oct 2023 11:13:26 +0200
Message-ID: <CAJ8uoz069tKX60=j3PwsVrO64c+mRGvVYJJWPwTktrAuh=3fbg@mail.gmail.com>
Subject: Re: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 at 10:54, =E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance=
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
> thanks.
>
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
>
>  OK, this will be considered  in the next patch.
>
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
> > since the total budget per send is 32.
>
> Why is there a limit of 32? I'm not quite clear on the implications of th=
ese,
> Did I miss something?
> BR
> Albert

There is a define TX_BATCH_SIZE 32 that controls the max number of
packets a sendto() call can send before it exits. It is used in
__xsk_generic_xmit().

> >You need to go through the list
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
> Yes, I did consider this approach, but I abandoned it because it would lo=
se
> the performance advantages of lock-free operations(RCU read)
> thanks
> Albert

OK, then let us not consider it and try to make your current approach work.

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
>
> this section of code only enters when it's unable to acquire any TX
> descriptors and
> xsk_full_count > 0.
>
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

