Return-Path: <bpf+bounces-34049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A65929E10
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026911C22078
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5A3BBE9;
	Mon,  8 Jul 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HoT65ho9"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB357A29;
	Mon,  8 Jul 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426267; cv=none; b=I/UyPahj8OVat1n+TF2keraooSKBDMiHtP4n8bcqcLwaKpmlMYmpCTjVkTEXYaQuBpPgoknPtn2S92j6aAjx//+1M3h8NGWv1XAL27t0njP3TTAaltFiocAE/kDldjH+nDi6v4kAyM7myed2O0mHcMnXNyVwqdpUGepfYJOnRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426267; c=relaxed/simple;
	bh=tR2QOvwOv5wX8tZJY/QBLViOdPjGlaIRioIgFXAMgL4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Dt782+W97BncqCkeZDl9B+wjlXpamrqVtIMRiivAMUph1yXPyt/Mriin5F8FhhmMK8NnDbZ7DC/3CHe6oi12IW52J+z3QwFauy1ZrgKxZYPCwjD0Qb8hWbMf47TtUEeHU2A0Vf79YETHfi+552ZVeZd89Gn5bosRTO4mgcI02IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HoT65ho9; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720426255; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=GWsB9SbhmXsK0ZQJnjUR9N8g5i+dYHg7pcDUr4T6FzE=;
	b=HoT65ho9oeJCPZjXXwIL8JRmyKojOb32q8wuFfo0wqCt4v0hlmvM4YLEjff0MPBZ37kP26w5BFh9uQe5oly7eSKye33q+4pBGBby1rpq3ZgP6H/9+safl1tKwLKDn3lmO8VRLbPftrk+tkbAsp54Jpj69G4xKOBLk/LpWvh7fW8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WA2Tyo6_1720426254;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA2Tyo6_1720426254)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 16:10:55 +0800
Message-ID: <1720426188.2428002-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 09/10] virtio_net: xsk: rx: support recv small mode
Date: Mon, 8 Jul 2024 16:09:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
 <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
 <1720424536.972943-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEukkp9FxLfBGTXvSGso48Ugy2-m3rWNFiVGuEa52LT_-Q@mail.gmail.com>
In-Reply-To: <CACGkMEukkp9FxLfBGTXvSGso48Ugy2-m3rWNFiVGuEa52LT_-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 8 Jul 2024 16:08:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 8, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Mon, 8 Jul 2024 15:00:50 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Fri, Jul 5, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > In the process:
> > > > 1. We may need to copy data to create skb for XDP_PASS.
> > > > 2. We may need to call xsk_buff_free() to release the buffer.
> > > > 3. The handle for xdp_buff is difference from the buffer.
> > > >
> > > > If we pushed this logic into existing receive handle(merge and smal=
l),
> > > > we would have to maintain code scattered inside merge and small (an=
d big).
> > > > So I think it is a good choice for us to put the xsk code into an
> > > > independent function.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >
> > > > v7:
> > > >    1. rename xdp_construct_skb to xsk_construct_skb
> > > >    2. refactor virtnet_receive()
> > > >
> > > >  drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 168 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 2b27f5ada64a..64d8cd481890 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
> > > >  };
> > > >
> > > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void =
*buf);
> > > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct x=
dp_buff *xdp,
> > > > +                              struct net_device *dev,
> > > > +                              unsigned int *xdp_xmit,
> > > > +                              struct virtnet_rq_stats *stats);
> > > > +static void virtnet_receive_done(struct virtnet_info *vi, struct r=
eceive_queue *rq,
> > > > +                                struct sk_buff *skb, u8 flags);
> > > >
> > > >  static bool is_xdp_frame(void *ptr)
> > > >  {
> > > > @@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist =
*sg, dma_addr_t addr, u32 len)
> > > >         sg->length =3D len;
> > > >  }
> > > >
> > > > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > > +                                  struct receive_queue *rq, void *=
buf, u32 len)
> > > > +{
> > > > +       struct xdp_buff *xdp;
> > > > +       u32 bufsize;
> > > > +
> > > > +       xdp =3D (struct xdp_buff *)buf;
> > > > +
> > > > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->=
hdr_len;
> > > > +
> > > > +       if (unlikely(len > bufsize)) {
> > > > +               pr_debug("%s: rx error: len %u exceeds truesize %u\=
n",
> > > > +                        vi->dev->name, len, bufsize);
> > > > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > > > +               xsk_buff_free(xdp);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       xsk_buff_set_size(xdp, len);
> > > > +       xsk_buff_dma_sync_for_cpu(xdp);
> > > > +
> > > > +       return xdp;
> > > > +}
> > > > +
> > > > +static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
> > > > +                                        struct xdp_buff *xdp)
> > > > +{
> > > > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > > > +       struct sk_buff *skb;
> > > > +       unsigned int size;
> > > > +
> > > > +       size =3D xdp->data_end - xdp->data_hard_start;
> > > > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > > > +       if (unlikely(!skb)) {
> > > > +               xsk_buff_free(xdp);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > > > +
> > > > +       size =3D xdp->data_end - xdp->data_meta;
> > > > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > > > +
> > > > +       if (metasize) {
> > > > +               __skb_pull(skb, metasize);
> > > > +               skb_metadata_set(skb, metasize);
> > > > +       }
> > > > +
> > > > +       xsk_buff_free(xdp);
> > > > +
> > > > +       return skb;
> > > > +}
> > > > +
> > > > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device=
 *dev, struct virtnet_info *vi,
> > > > +                                                struct receive_que=
ue *rq, struct xdp_buff *xdp,
> > > > +                                                unsigned int *xdp_=
xmit,
> > > > +                                                struct virtnet_rq_=
stats *stats)
> > > > +{
> > > > +       struct bpf_prog *prog;
> > > > +       u32 ret;
> > > > +
> > > > +       ret =3D XDP_PASS;
> > > > +       rcu_read_lock();
> > > > +       prog =3D rcu_dereference(rq->xdp_prog);
> > > > +       if (prog)
> > > > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmi=
t, stats);
> > > > +       rcu_read_unlock();
> > > > +
> > > > +       switch (ret) {
> > > > +       case XDP_PASS:
> > > > +               return xsk_construct_skb(rq, xdp);
> > > > +
> > > > +       case XDP_TX:
> > > > +       case XDP_REDIRECT:
> > > > +               return NULL;
> > > > +
> > > > +       default:
> > > > +               /* drop packet */
> > > > +               xsk_buff_free(xdp);
> > > > +               u64_stats_inc(&stats->drops);
> > > > +               return NULL;
> > > > +       }
> > > > +}
> > > > +
> > > > +static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struc=
t receive_queue *rq,
> > > > +                                   void *buf, u32 len,
> > > > +                                   unsigned int *xdp_xmit,
> > > > +                                   struct virtnet_rq_stats *stats)
> > > > +{
> > > > +       struct net_device *dev =3D vi->dev;
> > > > +       struct sk_buff *skb =3D NULL;
> > > > +       struct xdp_buff *xdp;
> > > > +       u8 flags;
> > > > +
> > > > +       len -=3D vi->hdr_len;
> > > > +
> > > > +       u64_stats_add(&stats->bytes, len);
> > > > +
> > > > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > > > +       if (!xdp)
> > > > +               return;
> > > > +
> > > > +       if (unlikely(len < ETH_HLEN)) {
> > > > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > > > +               DEV_STATS_INC(dev, rx_length_errors);
> > > > +               xsk_buff_free(xdp);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       flags =3D ((struct virtio_net_common_hdr *)(xdp->data - vi-=
>hdr_len))->hdr.flags;
> > > > +
> > > > +       if (!vi->mergeable_rx_bufs)
> > > > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp,=
 xdp_xmit, stats);
> > >
> > > I wonder if we add the mergeable support in the next patch would it be
> > > better to re-order the patch? For example, the xsk binding needs to be
> > > moved to the last patch, otherwise we break xsk with a mergeable
> > > buffer here?
> >
> > If you worry that the user works with this commit, I want to say you do=
 not
> > worry.
> >
> > Because the flags NETDEV_XDP_ACT_XSK_ZEROCOPY is not added. I plan to a=
dd that
> > after the tx is completed.
>
> Ok, this is something I missed, it would be better to mention it
> somewhere (or it is already there but I miss it).


OK. I will add it to next version cover.

Thanks.


>
> >
> > I do test by adding this flags locally.
> >
> > Thanks.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> >
> > >
> > > Or anything I missed here?
> > >
> > > Thanks
> > >
> >
>

