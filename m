Return-Path: <bpf+bounces-65481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9DB23D92
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 03:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D41564D00
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6534C92;
	Wed, 13 Aug 2025 01:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5b7ZQts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD02C0F87;
	Wed, 13 Aug 2025 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046982; cv=none; b=dOUeUZpE+ERaGLlbf6PlfsT3d89+gj71PXx2yl4MVHwUnAOcQqUPYvEdhC3oJ24IDhkCCaOpTEJA90C0GqvCeuUBlJvq34JoYA0YbMxz/AgM356OqwRSw9+/9PU/tMoBUTzqQsLRc+Z2g4LME6Z9XydxqX2AvI00bO6GdPr6dcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046982; c=relaxed/simple;
	bh=Xk2DrTDNv6ZQGw/IdDXtrQnR08AHDuNdkH3iQI5zNGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZR6mIMKBQnXD/rJ5pG8She5STLL+frw7WbEL2dSYaZFBx6xPVVNzFKGpbaAXvzBizF3e5rWONPWDDAidFUoFpwVQVihyVaPc7TeIUYN5xWyYR1wNI87+a7aKp8Ew5qGx6gDOxrM/RS2cWli//lRqlZpcQmJL01LnyKPXhL5SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5b7ZQts; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e52146df5cso63534635ab.2;
        Tue, 12 Aug 2025 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755046979; x=1755651779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRPAT3HwXVTcpPbZQ3zle/fx+TPLgTb+Mzo2UxDFlsw=;
        b=C5b7ZQtsQ7+yR5TeU3hilXjGhuvylyoxmAmqPRzJbf1gbxQSiu9cjpuPlMpXS+SFMX
         hZHJxV4lpxJGzLbbdc3ZUCc7kElIDnHN1OPHv7A8XuC+keRqc9voRXTjLFQvqw5kc3sH
         cRqjihMhQyh81aAzStDG+7KOQyPs2OeTP13Bp9hai8nke3uG9sB5PLcTW5h0DIlPcMV/
         yZNHatF5i/c9IzVJiB2XshxDeKYhXy6FlNyMySOtoq7xm9hKIraFpvfGNLKDIBnAtGFM
         NYfCXvyPtAMnXoMZkWA/0DMUbzq22o3sp87i7LzI3aBa2aecM1iuEdIohc11x9E/bH57
         aBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755046979; x=1755651779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRPAT3HwXVTcpPbZQ3zle/fx+TPLgTb+Mzo2UxDFlsw=;
        b=AI24F4zFBg6usTaWf49M78q0AWenZrDPaF3FVjaN1/VCKGMjDlLvj8DSlheceg1//D
         9o036X17/ihrOZ/vSrEIP8SbJnpWYmmBWtw76pM7/PZuQCesC/3K1RC92qh/zToRlQlB
         zSGba/PxmhBZlVLFZBDl8jmO9XRcnagC7a/W89ex9O++6tK6fn2hGgpPRmMpJhXgvaCU
         34HS152HLIMy/gvqDmP8ZGNzU1Bx+1ncwF+Yebg6YPamLdkWp0wbXgow1pf27Jffd1yr
         RU0Cmq3zlWVMJo7rf0uqNW1mQFWpdI+silH2wrqt0/ASHaN54oAKyWw/42OYiVSvfgjl
         uKWw==
X-Forwarded-Encrypted: i=1; AJvYcCWfDyghKKRHSh48zcxbj8WaoW+3mA3QIGDXNsjs+JFwcAMJh3ornhw2twLWNEUW7rtW4H1V5n3G@vger.kernel.org, AJvYcCXbLwxNlz9IgXiCTQlQiExK3oSqcTNbO3bL0sZkU+e8UOmBIkA/mkWyLJDDt0b01p9SJZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3a+g8pcC/AAUQv9i0ZOHwXodcJTmEKr2PXYR4OK4WAQZyROXV
	lh4Eph2Fk0a4/G6ekbImrmV4h6LrTlfV4xns9T6BnsLgkonFvGDeimtcBovUXERj3f59KSBS7M7
	I7hKuiUEvlbqPIe24oK8kpl4YaySLNEM=
X-Gm-Gg: ASbGnct47IaKqyMvba1wGsMOw3W6xjWpmdv3CHueMmTkygrRmutYscxTU1RBkciNxpV
	TR2EggSVZREPfFB4X7KH/k8Qkm+/j1gLh/Uvt7cF0ON+M6Rdaa4cZ+5hwfXdbySODNA+cPMG8rt
	kqpGStaOkz5ir9Ww5QGCESRlXgcEKUR1Fq3WiuW2vayjgoRKrZ90wPCSDMAk1x8FV4ghMsO4Gvs
	/mS4w==
X-Google-Smtp-Source: AGHT+IEruQ+h6PJZggV88xUVIhLVLaAvdxBIQPy50u2V4nZ/eTByrIKeaGsya1bViUEB27ketnMlwtcXFYnN9KSiJ6I=
X-Received: by 2002:a05:6e02:194a:b0:3e5:5357:6ddf with SMTP id
 e9e14a558f8ab-3e56749628dmr20796605ab.15.1755046979205; Tue, 12 Aug 2025
 18:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <aJt+kBqXT/RgLGvR@boxer>
In-Reply-To: <aJt+kBqXT/RgLGvR@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 09:02:21 +0800
X-Gm-Features: Ac12FXwvuyoL5wHd6RkeguHuvov4ZEt-G0ToT4Q3wxr6Z_UkIgAp7Zqi_acjZPE
Message-ID: <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:49=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wrote:
> >
> >
> > On 11/08/2025 15.12, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Zerocopy mode has a good feature named multi buffer while copy mode h=
as
> > > to transmit skb one by one like normal flows. The latter might lose t=
he
> > > bypass power to some extent because of grabbing/releasing the same tx
> > > queue lock and disabling/enabling bh and stuff on a packet basis.
> > > Contending the same queue lock will bring a worse result.
> > >
> >
> > I actually think that it is worth optimizing the non-zerocopy mode for
> > AF_XDP.  My use-case was virtual net_devices like veth.
> >
> >
> > > This patch supports batch feature by permitting owning the queue lock=
 to
> > > send the generic_xmit_batch number of packets at one time. To further
> > > achieve a better result, some codes[1] are removed on purpose from
> > > xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> > >
> > > [1]
> > > 1. advance the device check to granularity of sendto syscall.
> > > 2. remove validating packets because of its uselessness.
> > > 3. remove operation of softnet_data.xmit.recursion because it's not
> > >     necessary.
> > > 4. remove BQL flow control. We don't need to do BQL control because i=
t
> > >     probably limit the speed. An ideal scenario is to use a standalon=
e and
> > >     clean tx queue to send packets only for xsk. Less competition sho=
ws
> > >     better performance results.
> > >
> > > Experiments:
> > > 1) Tested on virtio_net:
> >
> > If you also want to test on veth, then an optimization is to increase
> > dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non-z=
c
> > AF_XDP packets getting reallocated by veth driver. I never completed
> > upstreaming this[1] before I left Red Hat.  (virtio_net might also bene=
fit)
> >
> >  [1] https://github.com/xdp-project/xdp-project/blob/main/areas/core/ve=
th_benchmark04.org
> >
> >
> > (more below...)
> >
> > > With this patch series applied, the performance number of xdpsock[2] =
goes
> > > up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
> > > If we test with another thread competing the same queue, a 28% increa=
se
> > > (from 405466 pps to 521076 pps) can be observed.
> > > 2) Tested on ixgbe:
> > > The results of zerocopy and copy mode are respectively 1303277 pps an=
d
> > > 1187347 pps. After this socket option took effect, copy mode reaches
> > > 1472367 which was higher than zerocopy mode impressively.
> > >
> > > [2]: ./xdpsock -i eth1 -t  -S -s 64
> > >
> > > It's worth mentioning batch process might bring high latency in certa=
in
> > > cases. The recommended value is 32.
>
> Given the issue I spotted on your ixgbe batching patch, the comparison
> against zc performance is probably not reliable.

I have to clarify the thing: zc performance was tested without that
series applied. That means without that series, the number is 1303277
pps. What I used is './xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64'.

>
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >   include/linux/netdevice.h |   2 +
> > >   net/core/dev.c            |  18 +++++++
> > >   net/xdp/xsk.c             | 103 +++++++++++++++++++++++++++++++++++=
+--
> > >   3 files changed, 120 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 5e5de4b0a433..27738894daa7 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3352,6 +3352,8 @@ u16 dev_pick_tx_zero(struct net_device *dev, st=
ruct sk_buff *skb,
> > >   int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev=
);
> > >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *d=
ev,
> > > +                     struct netdev_queue *txq, u32 max_batch, u32 *c=
ur);
> > >   static inline int dev_queue_xmit(struct sk_buff *skb)
> > >   {
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 68dc47d7e700..7a512bd38806 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4742,6 +4742,24 @@ int __dev_queue_xmit(struct sk_buff *skb, stru=
ct net_device *sb_dev)
> > >   }
> > >   EXPORT_SYMBOL(__dev_queue_xmit);
> > > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *d=
ev,
> > > +                     struct netdev_queue *txq, u32 max_batch, u32 *c=
ur)
> > > +{
> > > +   int ret =3D NETDEV_TX_BUSY;
> > > +
> > > +   local_bh_disable();
> > > +   HARD_TX_LOCK(dev, txq, smp_processor_id());
> > > +   for (; *cur < max_batch; (*cur)++) {
> > > +           ret =3D netdev_start_xmit(skb[*cur], dev, txq, false);
> >
> > The last argument ('false') to netdev_start_xmit() indicate if there ar=
e
> > 'more' packets to be sent. This allows the NIC driver to postpone
> > writing the tail-pointer/doorbell. For physical hardware this is a larg=
e
> > performance gain.
> >
> > If index have not reached 'max_batch' then we know 'more' packets are t=
rue.
> >
> >   bool more =3D !!(*cur !=3D max_batch);
> >
> > Can I ask you to do a test with netdev_start_xmit() using the 'more' bo=
olian
> > ?
> >
> >
> > > +           if (ret !=3D NETDEV_TX_OK)
> > > +                   break;
> > > +   }
> > > +   HARD_TX_UNLOCK(dev, txq);
> > > +   local_bh_enable();
> > > +
> > > +   return ret;
> > > +}
> > > +
> > >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
> > >   {
> > >     struct net_device *dev =3D skb->dev;
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 7a149f4ac273..92ad82472776 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -780,9 +780,102 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > >     return ERR_PTR(err);
> > >   }
> > > -static int __xsk_generic_xmit(struct sock *sk)
> > > +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> > > +{
> > > +   u32 max_batch =3D READ_ONCE(xs->generic_xmit_batch);
> > > +   struct sk_buff **skb =3D xs->skb_batch;
> > > +   struct net_device *dev =3D xs->dev;
> > > +   struct netdev_queue *txq;
> > > +   bool sent_frame =3D false;
> > > +   struct xdp_desc desc;
> > > +   u32 i =3D 0, j =3D 0;
> > > +   u32 max_budget;
> > > +   int err =3D 0;
> > > +
> > > +   mutex_lock(&xs->mutex);
> > > +
> > > +   /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> > > +   if (unlikely(!xsk_is_bound(xs))) {
> > > +           err =3D -ENXIO;
> > > +           goto out;
> > > +   }
> > > +
> > > +   if (xs->queue_id >=3D dev->real_num_tx_queues)
> > > +           goto out;
> > > +
> > > +   if (unlikely(!netif_running(dev) ||
> > > +                !netif_carrier_ok(dev)))
> > > +           goto out;
> > > +
> > > +   max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > +   txq =3D netdev_get_tx_queue(dev, xs->queue_id);
> > > +   do {
> > > +           for (; i < max_batch && xskq_cons_peek_desc(xs->tx, &desc=
, xs->pool); i++) {
>
> here we should think how to come up with slightly modified version of
> xsk_tx_peek_release_desc_batch() for generic xmit needs, or what could we
> borrow from this approach that will be applicable here.

Okay, I will dig into it more. Thanks.

>
> > > +                   if (max_budget-- =3D=3D 0) {
> > > +                           err =3D -EAGAIN;
> > > +                           break;
> > > +                   }
> > > +                   /* This is the backpressure mechanism for the Tx =
path.
> > > +                    * Reserve space in the completion queue and only=
 proceed
> > > +                    * if there is space in it. This avoids having to=
 implement
> > > +                    * any buffering in the Tx path.
> > > +                    */
> > > +                   err =3D xsk_cq_reserve_addr_locked(xs->pool, desc=
.addr);
> > > +                   if (err) {
> > > +                           err =3D -EAGAIN;
> > > +                           break;
> > > +                   }
> > > +
> > > +                   skb[i] =3D xsk_build_skb(xs, &desc);
> >
> > There is a missed opportunity for bulk allocating the SKBs here
> > (via kmem_cache_alloc_bulk).
>
> +1
>
> >
> > But this also requires changing the SKB alloc function used by
> > xsk_build_skb(). As a seperate patch, I recommend that you change the
> > sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
> > I expect this will be a large performance improvement on it's own.
> > Can I ask you to benchmark this change before the batch xmit change?
> >
> > Opinions needed from other maintainers please (I might be wrong!):
> > I don't think the socket level accounting done in sock_alloc_send_skb()
> > is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism=
"
> > code comment above.
>
> Thanks for bringing this up, I had the same feeling.
>
> >
> > --Jesper
> >
> > > +                   if (IS_ERR(skb[i])) {
> > > +                           err =3D PTR_ERR(skb[i]);
> > > +                           break;
> > > +                   }
> > > +
> > > +                   xskq_cons_release(xs->tx);
> > > +
> > > +                   if (xp_mb_desc(&desc))
> > > +                           xs->skb =3D skb[i];
> > > +           }
> > > +
> > > +           if (i) {
> > > +                   err =3D xsk_direct_xmit_batch(skb, dev, txq, i, &=
j);
> > > +                   if  (err =3D=3D NETDEV_TX_BUSY) {
> > > +                           err =3D -EAGAIN;
> > > +                   } else if (err =3D=3D NET_XMIT_DROP) {
> > > +                           j++;
> > > +                           err =3D -EBUSY;
> > > +                   }
> > > +
> > > +                   sent_frame =3D true;
> > > +                   xs->skb =3D NULL;
> > > +           }
> > > +
> > > +           if (err)
> > > +                   goto out;
> > > +           i =3D j =3D 0;
> > > +   } while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool));
>
> from the quick glance i don't follow why you have this call here whilst
> having it above in the while loop.

Because it avoids the first unnecessary xskq_cons_peek_desc() check.

>
> BTW do we have something bulk skb freeing in the kernel? given we're gonn=
a
> eventually do kmem_cache_alloc_bulk for skbs then could we do
> kmem_cache_free_bulk() as well?

Good point. Let me deal with it :)

Thanks,
Jason

>
> > > +
> > > +   if (xskq_has_descs(xs->tx)) {
> > > +           if (xs->skb)
> > > +                   xsk_drop_skb(xs->skb);
> > > +           xskq_cons_release(xs->tx);
> > > +   }
> > > +
> > > +out:
> > > +   for (; j < i; j++) {
> > > +           xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb[j]));
> > > +           xsk_consume_skb(skb[j]);
> > > +   }
> > > +   if (sent_frame)
> > > +           __xsk_tx_release(xs);
> > > +
> > > +   mutex_unlock(&xs->mutex);
> > > +   return err;
> > > +}
> > > +
> > > +static int __xsk_generic_xmit(struct xdp_sock *xs)
> > >   {
> > > -   struct xdp_sock *xs =3D xdp_sk(sk);
> > >     bool sent_frame =3D false;
> > >     struct xdp_desc desc;
> > >     struct sk_buff *skb;
> > > @@ -871,11 +964,15 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >   static int xsk_generic_xmit(struct sock *sk)
> > >   {
> > > +   struct xdp_sock *xs =3D xdp_sk(sk);
> > >     int ret;
> > >     /* Drop the RCU lock since the SKB path might sleep. */
> > >     rcu_read_unlock();
> > > -   ret =3D __xsk_generic_xmit(sk);
> > > +   if (READ_ONCE(xs->generic_xmit_batch))
> > > +           ret =3D __xsk_generic_xmit_batch(xs);
> > > +   else
> > > +           ret =3D __xsk_generic_xmit(xs);
> > >     /* Reaquire RCU lock before going into common code. */
> > >     rcu_read_lock();
> >
> >

