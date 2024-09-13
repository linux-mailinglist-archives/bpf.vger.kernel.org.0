Return-Path: <bpf+bounces-39791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCE977749
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 05:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1254B284DC8
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416115539F;
	Fri, 13 Sep 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbu5pCp6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E07E0E9
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197701; cv=none; b=DjGv3AdVwWwwPorgft5+fkHXQdtHaWdAt3E6TWhEviBHzP4mIIZHbkeq6HRJLzFEf1dpn0ccY5r1odFzyVDrh6f7ih7zd04i+6mFhR4p/afwN/JDKizT1fEsRwWqns1Ayhuf0tuQ1KGbkJjzdCn/htixp6ydV8f2AfceM4U3308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197701; c=relaxed/simple;
	bh=Uf8pz8GZZOrJfqVyY2w8iaFekkV4JJlgwu8AIVoKy9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmuuYJw7F2OZR89A2sSItbZ8TMbrXXTqqNp/oTMQFglhYWzrMpBrr2RyBsDtmEDoxa2NGoVhh6Z8n9av+jrwXjVtX1NuLbL/LFzmCV12KDZZLXSLW3suv7CFYSOf5ZbgYXCTUJ4yDHmlywIC8fhn4nP3/9sZSKUMmstUR/ZSiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bbu5pCp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726197697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBmazPo7oDZzY5LkfEPsqnAnQz8NHw4FFkvvHEVzrBM=;
	b=Bbu5pCp6F3WF9f+BPPcXDxkQPgJuxP7syHdDp20WSRHVbBL6wFz+Yv+aNiYaOsnj2ngHt7
	OvvX8X9gLZIneu347L85O+l+6TbT2qwREHB2sieC19sYxWvjhTf/b5LsSXRAOT65c0YfA+
	/CKe4YZyZWxXlNGdRIRXkKZFXVwsy3w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-o9hBX2VqMyeXv_oIO2o1Zg-1; Thu, 12 Sep 2024 23:21:36 -0400
X-MC-Unique: o9hBX2VqMyeXv_oIO2o1Zg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2daa02872c1so1624086a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 20:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197695; x=1726802495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBmazPo7oDZzY5LkfEPsqnAnQz8NHw4FFkvvHEVzrBM=;
        b=UKISbjSK7LSFBzNayJ90Y6PcOGYbWIXl/IGii01vvZuXvBFNgV6cxXBbRn/e+tNMx8
         lkdPXZacRHZcsYJvvO8f/W9HQw6XvPR4SvwF0GmcsXagbj4bENPKcnTR8Q0qdc0ApFzw
         k19lx7zT6KHYIhPSU9vJP38xm0ECCEiylrB0R3Nld+UD/4F1qolkQ6s2IDO15BvBjUoF
         hf0O59rmDL1Hi8P8HDhDRleoe7Sn/GgjwNZ6wAdfLWQuguRLBEl+tYeFhESmN6mxTQOP
         LbZ78n9neBIWXMXgqaMQh5vuefhNOKjD48gxuGtWB9OsH8MWJ6eSQTAny/eRV3NZYAXk
         lffg==
X-Forwarded-Encrypted: i=1; AJvYcCWg59H7MxGSKzdZ6WsACwNDPCCNhKO4eVmvcb2Tt1vzZPo3QVawijvr1Z8YPBlh4flC1iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDikM53FPM4iwW5CX8/C4vb2dw8elo261q95QFX7BrypnukyN
	cjkBuvV2xG/EZLaVtjGeo9bJ07ndCqt1UMgYGsyxanMLSLf+hOOvSPxp6GPS4zXShBfr/J6Ie4C
	SqBUga2ivjbLkP47fyiOmFmnhftGEFL1uOqcqtrVRejdZPf+TuuWYzY1zsaQxPd6MobAua4+2Mp
	v0NdJ9hwdptwRAvYTHpHmgNjys
X-Received: by 2002:a17:90a:c915:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2db9ffa1624mr5959723a91.4.1726197695527;
        Thu, 12 Sep 2024 20:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUzkOSDTB5L8PdzNmSnOyQ4G7HAHJ9LPtYXF+5ar6cK9jEe4+yKgNBgFe5Lt1usc2izXTKaE7mLIr1bBjXIak=
X-Received: by 2002:a17:90a:c915:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2db9ffa1624mr5959678a91.4.1726197694804; Thu, 12 Sep 2024
 20:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-11-xuanzhuo@linux.alibaba.com> <CACGkMEv5DZgm1B5CXeHnP4ZPmZzQv7zWHT5=D1oH-h_bin2p7w@mail.gmail.com>
 <1726130924.279801-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726130924.279801-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:21:21 +0800
Message-ID: <CACGkMEtgWw9J4Y8fQCWY4ED_=Bdi6ArmOMMA2OjyGbOOu90OTg@mail.gmail.com>
Subject: Re: [PATCH net-next 10/13] virtio_net: xsk: tx: support xmit xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Sep 2024 12:31:32 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The driver's tx napi is very important for XSK. It is responsible for
> > > obtaining data from the XSK queue and sending it out.
> > >
> > > At the beginning, we need to trigger tx napi.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 127 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 125 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 221681926d23..3743694d3c3b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -516,10 +516,13 @@ enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > >         VIRTNET_XMIT_TYPE_ORPHAN,
> > >         VIRTNET_XMIT_TYPE_XDP,
> > > +       VIRTNET_XMIT_TYPE_XSK,
> > >  };
> > >
> > >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_ORPHAN \
> > > -                               | VIRTNET_XMIT_TYPE_XDP)
> > > +                               | VIRTNET_XMIT_TYPE_XDP | VIRTNET_XMI=
T_TYPE_XSK)
> > > +
> > > +#define VIRTIO_XSK_FLAG_OFFSET 4
> > >
> > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > >  {
> > > @@ -543,6 +546,11 @@ static int virtnet_add_outbuf(struct send_queue =
*sq, int num, void *data,
> > >                                     GFP_ATOMIC);
> > >  }
> > >
> > > +static u32 virtnet_ptr_to_xsk(void *ptr)
> > > +{
> > > +       return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > +}
> > > +
> >
> > This needs a better name, otherwise readers might be confused.
> >
> > E.g something like virtnet_ptr_to_xsk_buff_len()?
> >
> > >  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > >  {
> > >         sg_assign_page(sg, NULL);
> > > @@ -584,6 +592,10 @@ static void __free_old_xmit(struct send_queue *s=
q, struct netdev_queue *txq,
> > >                         stats->bytes +=3D xdp_get_frame_len(frame);
> > >                         xdp_return_frame(frame);
> > >                         break;
> > > +
> > > +               case VIRTNET_XMIT_TYPE_XSK:
> > > +                       stats->bytes +=3D virtnet_ptr_to_xsk(ptr);
> > > +                       break;
> >
> > Do we miss xsk_tx_completed() here?
> >
> > >                 }
> > >         }
> > >         netdev_tx_completed_queue(txq, stats->napi_packets, stats->na=
pi_bytes);
> > > @@ -1393,6 +1405,97 @@ static int virtnet_xsk_wakeup(struct net_devic=
e *dev, u32 qid, u32 flag)
> > >         return 0;
> > >  }
> > >
> > > +static void *virtnet_xsk_to_ptr(u32 len)
> > > +{
> > > +       unsigned long p;
> > > +
> > > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > > +
> > > +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK)=
;
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_one(struct send_queue *sq,
> > > +                               struct xsk_buff_pool *pool,
> > > +                               struct xdp_desc *desc)
> > > +{
> > > +       struct virtnet_info *vi;
> > > +       dma_addr_t addr;
> > > +
> > > +       vi =3D sq->vq->vdev->priv;
> > > +
> > > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > > +
> > > +       sg_init_table(sq->sg, 2);
> > > +
> > > +       sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
> > > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > > +
> > > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > > +                                   virtnet_xsk_to_ptr(desc->len), GF=
P_ATOMIC);
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > > +                                 struct xsk_buff_pool *pool,
> > > +                                 unsigned int budget,
> > > +                                 u64 *kicks)
> > > +{
> > > +       struct xdp_desc *descs =3D pool->tx_descs;
> > > +       bool kick =3D false;
> > > +       u32 nb_pkts, i;
> > > +       int err;
> > > +
> > > +       budget =3D min_t(u32, budget, sq->vq->num_free);
> > > +
> > > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > > +       if (!nb_pkts)
> > > +               return 0;
> > > +
> > > +       for (i =3D 0; i < nb_pkts; i++) {
> > > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > > +               if (unlikely(err)) {
> > > +                       xsk_tx_completed(sq->xsk_pool, nb_pkts - i);
> >
> > Should we kick in this condition?
> >
> > > +                       break;
> > > +               }
> > > +
> > > +               kick =3D true;
> > > +       }
> > > +
> > > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notif=
y(sq->vq))
> >
> > Can we simply use virtqueue_kick() here?
> >
> > > +               (*kicks)++;
> > > +
> > > +       return i;
> > > +}
> > > +
> > > +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_=
pool *pool,
> > > +                            int budget)
> > > +{
> > > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > > +       struct virtnet_sq_free_stats stats =3D {};
> > > +       struct net_device *dev =3D vi->dev;
> > > +       u64 kicks =3D 0;
> > > +       int sent;
> > > +
> > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), tr=
ue, &stats);
> >
> > I haven't checked in depth, but I wonder if we have some side effects
> > when using non NAPI tx mode:
> >
> >         if (napi->weight)
> >                 virtqueue_napi_schedule(napi, vq);
> >         else
> >                 /* We were probably waiting for more output buffers. */
> >                 netif_wake_subqueue(vi->dev, vq2txq(vq));
> >
> > Does this mean xsk will suffer the same issue like when there's no xsk
> > xmit request, we could end up with no way to reclaim xmitted xsk
> > buffers? (Or should we disallow AF_XDP to be used for non TX-NAPI
> > mode?)
>
> Disallow AF_XDP to be used for non TX-NAPI mode.
>
> The last patch #9 does this.
>
> #9 [PATCH net-next 09/13] virtio_net: xsk: prevent disable tx napi

Great, for some reason I miss that.

Thanks

>
> Thanks.
> >
> > > +
> > > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > > +
> > > +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > > +               check_sq_full_and_disable(vi, vi->dev, sq);
> > > +
> > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > +       u64_stats_add(&sq->stats.packets, stats.packets);
> > > +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> > > +       u64_stats_add(&sq->stats.kicks,   kicks);
> > > +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> > > +       u64_stats_update_end(&sq->stats.syncp);
> > > +
> > > +       if (xsk_uses_need_wakeup(pool))
> > > +               xsk_set_tx_need_wakeup(pool);
> > > +
> > > +       return sent =3D=3D budget;
> > > +}
> > > +
> > >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > >                                    struct send_queue *sq,
> > >                                    struct xdp_frame *xdpf)
> > > @@ -2949,6 +3052,7 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> > >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > >         unsigned int index =3D vq2txq(sq->vq);
> > >         struct netdev_queue *txq;
> > > +       bool xsk_busy =3D false;
> > >         int opaque;
> > >         bool done;
> > >
> > > @@ -2961,7 +3065,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >         txq =3D netdev_get_tx_queue(vi->dev, index);
> > >         __netif_tx_lock(txq, raw_smp_processor_id());
> > >         virtqueue_disable_cb(sq->vq);
> > > -       free_old_xmit(sq, txq, !!budget);
> > > +
> > > +       if (sq->xsk_pool)
> > > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk_pool, budge=
t);
> > > +       else
> > > +               free_old_xmit(sq, txq, !!budget);
> > >
> > >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > >                 if (netif_tx_queue_stopped(txq)) {
> > > @@ -2972,6 +3080,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >                 netif_tx_wake_queue(txq);
> > >         }
> > >
> > > +       if (xsk_busy) {
> > > +               __netif_tx_unlock(txq);
> > > +               return budget;
> > > +       }
> > > +
> > >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > >
> > >         done =3D napi_complete_done(napi, 0);
> > > @@ -5974,6 +6087,12 @@ static void free_receive_page_frags(struct vir=
tnet_info *vi)
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf)
> > >  {
> > > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > > +       struct send_queue *sq;
> > > +       int i =3D vq2rxq(vq);
> > > +
> > > +       sq =3D &vi->sq[i];
> > > +
> > >         switch (virtnet_xmit_ptr_strip(&buf)) {
> > >         case VIRTNET_XMIT_TYPE_SKB:
> > >         case VIRTNET_XMIT_TYPE_ORPHAN:
> > > @@ -5983,6 +6102,10 @@ static void virtnet_sq_free_unused_buf(struct =
virtqueue *vq, void *buf)
> > >         case VIRTNET_XMIT_TYPE_XDP:
> > >                 xdp_return_frame(buf);
> > >                 break;
> > > +
> > > +       case VIRTNET_XMIT_TYPE_XSK:
> > > +               xsk_tx_completed(sq->xsk_pool, 1);
> > > +               break;
> > >         }
> > >  }
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
> > Thanks
> >
>


