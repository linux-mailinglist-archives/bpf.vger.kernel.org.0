Return-Path: <bpf+bounces-65480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBCB23D63
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 02:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC0F17BFFF
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5417332C;
	Wed, 13 Aug 2025 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIopnm/G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F71519A0;
	Wed, 13 Aug 2025 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046659; cv=none; b=DRLoqb6tPPriKZygvCr5CQmFp1w3ARQ5xjFzKVaMue+0zLKtTvHkHrmiCA7yPwxlOxF/UAEcHgRNuSocd61BAApfYDcQC4CQ3DmHRXyNIPzwfKjbndCd4utb9HWMMmD7jhBNXJsMoSlztX6u++OUMF6kBO7fw63yEmFywUp5zgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046659; c=relaxed/simple;
	bh=BatLEAv6inoz0FZ8JvuEzP76/MP7pxv+Ta6qxLyHpQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGfL2pMgmu9KHO94dw3XRF5uFv1E8cMCbAbeYoZ+CtJUXIj7P3NjY+WuB03Lr44jM1CkWS2rmLhmmWCpvJi/4++qDdtynsb80CTzDF4RtyUMDZsda/UU7LsfaJ/uXcUbf7SF82SYDKYlbuM++cTumZGy5latUpyI7rahPQUzWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIopnm/G; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-880f82dfc7fso429005639f.2;
        Tue, 12 Aug 2025 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755046657; x=1755651457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piSR5nex9DFTzXHAwgpbIUEgsWBlDBwTpvN1Y1WkcWc=;
        b=HIopnm/GJGZqtdwZDzvjve8NscMA+YYq3Y7029hpJ34xoG5cUj6rMJi6woV15CBXHS
         MMydjEBtVEXY/6pFgQv/5Yri0Cay3qduNVUY9aCVG2KAKaMKIA2z6Zp6j4LeG9qQ5Y7j
         4ZRFzhtTqszu/A5ccSpp13UWf+/tpJ3E2ppnj3UWmODfus8ol+68k3P0/j6L+eYshAOJ
         RlxtaaCReVdhHhqx47NZi7AlC2XJejIEVzdEzPmnLjGX68nVwvWvpFzpu7u02MZDPXl/
         aFtdpRH+RKAb1SgmBA7AFRs7zSPMjohoFhjgKFdfoUKRfPVxYGVRpv3CQ0HsRigKgbJN
         qhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755046657; x=1755651457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piSR5nex9DFTzXHAwgpbIUEgsWBlDBwTpvN1Y1WkcWc=;
        b=Zalii/p01yfc0miB8usoMGgc6jYK2LMTUxNMou6qd9q7Cb6TfygEjhkwYYXIIyrcyE
         UKprW1sVky7T2JU4V64c+CnL61pw/m5NovCL1xzk9Vzy/V+N+ZCz4zOy5Gm0SHLDzrAX
         S+s9yPFthNbYFOAeIiNkQWGTVNtIDS2rFVCvx9KPxLL9SD+ZrYiCfnZyl6cb06qbVC8I
         pfo5lpiZIVDmCoNooW3LnL0n5W6QILM/uAHH+iKT5lu5PUTQ4vd1GRvzEt4hEVvg0R/9
         MDj56FxvAxWkZKdwum5Dr7+QVzHjGlektKiIuDyZnur0JnTUGyl+ZJXnU2UmYlUucREn
         hs/g==
X-Forwarded-Encrypted: i=1; AJvYcCXhIn0SUp/8qWq5bZUV7zXKEO+Qo3jNxi2B7QDOrh1rUJBCDrb6WbPa9DSXc3bW+ibHuUMnXTPf@vger.kernel.org, AJvYcCXy/4/3VJwrLiOg35p+WRzzO+nZHtnGpHYhQxO/oKvQWOU1L0kvcW9Nbkjjh7XGdC1KEDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsMWpWdMurLknMsUk89KYKot+7V6winxr+wlW9JJrWuUpf0HQ
	oYVD2Xd2+u4py89G90a5l1D8WNsbmRkpd4TbPXvdlZSoEe1egXPeTAtUU3We8P5XvHll3gQx8Bq
	N27ckcba4DvxTyC+f1DfN/B7y6ATIhmk=
X-Gm-Gg: ASbGncuE/uhTbNTYBsDv2le778lbDqgjGlVT/dsOicpPM7R9OKmC4tZ1JBaSjLl3dI5
	23gUCAG7fkoHtFmuAAJp+FaHbaw0vPRLI9xlvKOgP/kMT6QfP7A4oYFCS4xD2vkvAz4MM7fYFK/
	jTu802OPEv0Zt+NSCT1Fa/vqDTlet1I3j+/1QLQTJ48iIujDT0I2HeJgeTF9EospJiqtVnggtCU
	2FlKgM=
X-Google-Smtp-Source: AGHT+IEUh62tQaInV5mOFSmgYT3FUfotGOeMJ7Iguqb4ivHkIyhLXWqWSftnFvH12A3Ss6SRIndqBgjNBoNPaGnIupo=
X-Received: by 2002:a6b:f110:0:b0:884:183:e55e with SMTP id
 ca18e2360f4ac-8842968d04bmr208936639f.9.1755046657003; Tue, 12 Aug 2025
 17:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
In-Reply-To: <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 08:57:00 +0800
X-Gm-Features: Ac12FXz72OYzD7FLjGDA3R0CtAurwOHcJydlV7mlz4qTpZOO49FldnWgYLAvDbU
Message-ID: <CAL+tcoCwKbeGmC5LLePyyabFcq5RTpux5+ZA2KV-wxQxVhx-CA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:30=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 11/08/2025 15.12, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Zerocopy mode has a good feature named multi buffer while copy mode has
> > to transmit skb one by one like normal flows. The latter might lose the
> > bypass power to some extent because of grabbing/releasing the same tx
> > queue lock and disabling/enabling bh and stuff on a packet basis.
> > Contending the same queue lock will bring a worse result.
> >
>
> I actually think that it is worth optimizing the non-zerocopy mode for
> AF_XDP.  My use-case was virtual net_devices like veth.
>
>
> > This patch supports batch feature by permitting owning the queue lock t=
o
> > send the generic_xmit_batch number of packets at one time. To further
> > achieve a better result, some codes[1] are removed on purpose from
> > xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> >
> > [1]
> > 1. advance the device check to granularity of sendto syscall.
> > 2. remove validating packets because of its uselessness.
> > 3. remove operation of softnet_data.xmit.recursion because it's not
> >     necessary.
> > 4. remove BQL flow control. We don't need to do BQL control because it
> >     probably limit the speed. An ideal scenario is to use a standalone =
and
> >     clean tx queue to send packets only for xsk. Less competition shows
> >     better performance results.
> >
> > Experiments:
> > 1) Tested on virtio_net:
>
> If you also want to test on veth, then an optimization is to increase
> dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non-zc
> AF_XDP packets getting reallocated by veth driver. I never completed
> upstreaming this[1] before I left Red Hat.  (virtio_net might also benefi=
t)
>
>   [1]
> https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benc=
hmark04.org

Oh, even though I'm not that familiar with veth, I am willing to learn
it these days. Thanks for sharing this with me!

>
>
> (more below...)
>
> > With this patch series applied, the performance number of xdpsock[2] go=
es
> > up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
> > If we test with another thread competing the same queue, a 28% increase
> > (from 405466 pps to 521076 pps) can be observed.
> > 2) Tested on ixgbe:
> > The results of zerocopy and copy mode are respectively 1303277 pps and
> > 1187347 pps. After this socket option took effect, copy mode reaches
> > 1472367 which was higher than zerocopy mode impressively.
> >
> > [2]: ./xdpsock -i eth1 -t  -S -s 64
> >
> > It's worth mentioning batch process might bring high latency in certain
> > cases. The recommended value is 32.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/linux/netdevice.h |   2 +
> >   net/core/dev.c            |  18 +++++++
> >   net/xdp/xsk.c             | 103 ++++++++++++++++++++++++++++++++++++-=
-
> >   3 files changed, 120 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5e5de4b0a433..27738894daa7 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3352,6 +3352,8 @@ u16 dev_pick_tx_zero(struct net_device *dev, stru=
ct sk_buff *skb,
> >
> >   int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev=
,
> > +                       struct netdev_queue *txq, u32 max_batch, u32 *c=
ur);
> >
> >   static inline int dev_queue_xmit(struct sk_buff *skb)
> >   {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 68dc47d7e700..7a512bd38806 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4742,6 +4742,24 @@ int __dev_queue_xmit(struct sk_buff *skb, struct=
 net_device *sb_dev)
> >   }
> >   EXPORT_SYMBOL(__dev_queue_xmit);
> >
> > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev=
,
> > +                       struct netdev_queue *txq, u32 max_batch, u32 *c=
ur)
> > +{
> > +     int ret =3D NETDEV_TX_BUSY;
> > +
> > +     local_bh_disable();
> > +     HARD_TX_LOCK(dev, txq, smp_processor_id());
> > +     for (; *cur < max_batch; (*cur)++) {
> > +             ret =3D netdev_start_xmit(skb[*cur], dev, txq, false);
>
> The last argument ('false') to netdev_start_xmit() indicate if there are
> 'more' packets to be sent. This allows the NIC driver to postpone
> writing the tail-pointer/doorbell. For physical hardware this is a large
> performance gain.
>
> If index have not reached 'max_batch' then we know 'more' packets are tru=
e.
>
>    bool more =3D !!(*cur !=3D max_batch);
>
> Can I ask you to do a test with netdev_start_xmit() using the 'more'
> boolian ?

Agreed, really insightful information. I'm taking note here. Will get
back more information here soon.

>
>
> > +             if (ret !=3D NETDEV_TX_OK)
> > +                     break;
> > +     }
> > +     HARD_TX_UNLOCK(dev, txq);
> > +     local_bh_enable();
> > +
> > +     return ret;
> > +}
> > +
> >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
> >   {
> >       struct net_device *dev =3D skb->dev;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7a149f4ac273..92ad82472776 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -780,9 +780,102 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >       return ERR_PTR(err);
> >   }
> >
> > -static int __xsk_generic_xmit(struct sock *sk)
> > +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> > +{
> > +     u32 max_batch =3D READ_ONCE(xs->generic_xmit_batch);
> > +     struct sk_buff **skb =3D xs->skb_batch;
> > +     struct net_device *dev =3D xs->dev;
> > +     struct netdev_queue *txq;
> > +     bool sent_frame =3D false;
> > +     struct xdp_desc desc;
> > +     u32 i =3D 0, j =3D 0;
> > +     u32 max_budget;
> > +     int err =3D 0;
> > +
> > +     mutex_lock(&xs->mutex);
> > +
> > +     /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> > +     if (unlikely(!xsk_is_bound(xs))) {
> > +             err =3D -ENXIO;
> > +             goto out;
> > +     }
> > +
> > +     if (xs->queue_id >=3D dev->real_num_tx_queues)
> > +             goto out;
> > +
> > +     if (unlikely(!netif_running(dev) ||
> > +                  !netif_carrier_ok(dev)))
> > +             goto out;
> > +
> > +     max_budget =3D READ_ONCE(xs->max_tx_budget);
> > +     txq =3D netdev_get_tx_queue(dev, xs->queue_id);
> > +     do {
> > +             for (; i < max_batch && xskq_cons_peek_desc(xs->tx, &desc=
, xs->pool); i++) {
> > +                     if (max_budget-- =3D=3D 0) {
> > +                             err =3D -EAGAIN;
> > +                             break;
> > +                     }
> > +                     /* This is the backpressure mechanism for the Tx =
path.
> > +                      * Reserve space in the completion queue and only=
 proceed
> > +                      * if there is space in it. This avoids having to=
 implement
> > +                      * any buffering in the Tx path.
> > +                      */
> > +                     err =3D xsk_cq_reserve_addr_locked(xs->pool, desc=
.addr);
> > +                     if (err) {
> > +                             err =3D -EAGAIN;
> > +                             break;
> > +                     }
> > +
> > +                     skb[i] =3D xsk_build_skb(xs, &desc);
>
> There is a missed opportunity for bulk allocating the SKBs here
> (via kmem_cache_alloc_bulk).
>
> But this also requires changing the SKB alloc function used by
> xsk_build_skb(). As a seperate patch, I recommend that you change the
> sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
> I expect this will be a large performance improvement on it's own.
> Can I ask you to benchmark this change before the batch xmit change?

Sure, I will do that.

>
> Opinions needed from other maintainers please (I might be wrong!):
> I don't think the socket level accounting done in sock_alloc_send_skb()
> is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism"
> code comment above.

Point taken. It seems no chance to remove it in this common helper.
Let me give it more thoughts :)

Thanks,
Jason

>
> --Jesper
>
> > +                     if (IS_ERR(skb[i])) {
> > +                             err =3D PTR_ERR(skb[i]);
> > +                             break;
> > +                     }
> > +
> > +                     xskq_cons_release(xs->tx);
> > +
> > +                     if (xp_mb_desc(&desc))
> > +                             xs->skb =3D skb[i];
> > +             }
> > +
> > +             if (i) {
> > +                     err =3D xsk_direct_xmit_batch(skb, dev, txq, i, &=
j);
> > +                     if  (err =3D=3D NETDEV_TX_BUSY) {
> > +                             err =3D -EAGAIN;
> > +                     } else if (err =3D=3D NET_XMIT_DROP) {
> > +                             j++;
> > +                             err =3D -EBUSY;
> > +                     }
> > +
> > +                     sent_frame =3D true;
> > +                     xs->skb =3D NULL;
> > +             }
> > +
> > +             if (err)
> > +                     goto out;
> > +             i =3D j =3D 0;
> > +     } while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool));
> > +
> > +     if (xskq_has_descs(xs->tx)) {
> > +             if (xs->skb)
> > +                     xsk_drop_skb(xs->skb);
> > +             xskq_cons_release(xs->tx);
> > +     }
> > +
> > +out:
> > +     for (; j < i; j++) {
> > +             xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb[j]));
> > +             xsk_consume_skb(skb[j]);
> > +     }
> > +     if (sent_frame)
> > +             __xsk_tx_release(xs);
> > +
> > +     mutex_unlock(&xs->mutex);
> > +     return err;
> > +}
> > +
> > +static int __xsk_generic_xmit(struct xdp_sock *xs)
> >   {
> > -     struct xdp_sock *xs =3D xdp_sk(sk);
> >       bool sent_frame =3D false;
> >       struct xdp_desc desc;
> >       struct sk_buff *skb;
> > @@ -871,11 +964,15 @@ static int __xsk_generic_xmit(struct sock *sk)
> >
> >   static int xsk_generic_xmit(struct sock *sk)
> >   {
> > +     struct xdp_sock *xs =3D xdp_sk(sk);
> >       int ret;
> >
> >       /* Drop the RCU lock since the SKB path might sleep. */
> >       rcu_read_unlock();
> > -     ret =3D __xsk_generic_xmit(sk);
> > +     if (READ_ONCE(xs->generic_xmit_batch))
> > +             ret =3D __xsk_generic_xmit_batch(xs);
> > +     else
> > +             ret =3D __xsk_generic_xmit(xs);
> >       /* Reaquire RCU lock before going into common code. */
> >       rcu_read_lock();
> >
>

