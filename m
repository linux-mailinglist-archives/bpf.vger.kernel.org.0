Return-Path: <bpf+bounces-15084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33887EBB4D
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 03:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103231C20ACE
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB0659;
	Wed, 15 Nov 2023 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143CA55;
	Wed, 15 Nov 2023 02:44:23 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E7C8;
	Tue, 14 Nov 2023 18:44:21 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwRB2Rd_1700016257;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwRB2Rd_1700016257)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 10:44:18 +0800
Message-ID: <1700015705.1762614-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 16/19] virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
Date: Wed, 15 Nov 2023 10:35:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
 <CACGkMEtvVBXupsiE8=Mt4CWJqckS5tF-w_ZdG2qs-AoYBWptWA@mail.gmail.com>
In-Reply-To: <CACGkMEtvVBXupsiE8=Mt4CWJqckS5tF-w_ZdG2qs-AoYBWptWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:57:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Implementing the logic of xsk rx. If this packet is not for XSK
> > determined in XDP, then we need to copy once to generate a SKB.
> > If it is for XSK, it is a zerocopy receive packet process.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       |  14 ++--
> >  drivers/net/virtio/virtio_net.h |   4 ++
> >  drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h        |   4 ++
> >  4 files changed, 137 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 0e740447b142..003dd67ab707 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -822,10 +822,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >         }
> >  }
> >
> > -static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> > -                              struct net_device *dev,
> > -                              unsigned int *xdp_xmit,
> > -                              struct virtnet_rq_stats *stats)
> > +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xd=
p,
> > +                       struct net_device *dev,
> > +                       unsigned int *xdp_xmit,
> > +                       struct virtnet_rq_stats *stats)
> >  {
> >         struct xdp_frame *xdpf;
> >         int err;
> > @@ -1589,13 +1589,17 @@ static void receive_buf(struct virtnet_info *vi=
, struct virtnet_rq *rq,
> >                 return;
> >         }
> >
> > -       if (vi->mergeable_rx_bufs)
> > +       rcu_read_lock();
> > +       if (rcu_dereference(rq->xsk.pool))
> > +               skb =3D virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_=
xmit, stats);
> > +       else if (vi->mergeable_rx_bufs)
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> >         else if (vi->big_packets)
> >                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> >         else
> >                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_x=
mit, stats);
> > +       rcu_read_unlock();
> >
> >         if (unlikely(!skb))
> >                 return;
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index 6e71622fca45..fd7f34703c9b 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -346,6 +346,10 @@ static inline bool virtnet_is_xdp_raw_buffer_queue=
(struct virtnet_info *vi, int
> >                 return false;
> >  }
> >
> > +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xd=
p,
> > +                       struct net_device *dev,
> > +                       unsigned int *xdp_xmit,
> > +                       struct virtnet_rq_stats *stats);
> >  void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
> >  void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
> >  void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index 841fb078882a..f1c64414fac9 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -13,6 +13,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_=
addr_t addr, u32 len)
> >         sg->length =3D len;
> >  }
> >
> > +static unsigned int virtnet_receive_buf_num(struct virtnet_info *vi, c=
har *buf)
> > +{
> > +       struct virtio_net_hdr_mrg_rxbuf *hdr;
> > +
> > +       if (vi->mergeable_rx_bufs) {
> > +               hdr =3D (struct virtio_net_hdr_mrg_rxbuf *)buf;
> > +               return virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> > +       }
> > +
> > +       return 1;
> > +}
> > +
> >  static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> >  {
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > @@ -37,6 +49,114 @@ static void virtnet_xsk_check_queue(struct virtnet_=
sq *sq)
> >                 netif_stop_subqueue(dev, qnum);
> >  }
> >
> > +static void merge_drop_follow_xdp(struct net_device *dev,
> > +                                 struct virtnet_rq *rq,
> > +                                 u32 num_buf,
> > +                                 struct virtnet_rq_stats *stats)
> > +{
> > +       struct xdp_buff *xdp;
> > +       u32 len;
> > +
> > +       while (num_buf-- > 1) {
> > +               xdp =3D virtqueue_get_buf(rq->vq, &len);
> > +               if (unlikely(!xdp)) {
> > +                       pr_debug("%s: rx error: %d buffers missing\n",
> > +                                dev->name, num_buf);
> > +                       dev->stats.rx_length_errors++;
> > +                       break;
> > +               }
> > +               stats->bytes +=3D len;
> > +               xsk_buff_free(xdp);
> > +       }
> > +}
> > +
> > +static struct sk_buff *construct_skb(struct virtnet_rq *rq,
> > +                                    struct xdp_buff *xdp)
> > +{
> > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > +       struct sk_buff *skb;
> > +       unsigned int size;
> > +
> > +       size =3D xdp->data_end - xdp->data_hard_start;
> > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +
> > +       size =3D xdp->data_end - xdp->data_meta;
> > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > +
> > +       if (metasize) {
> > +               __skb_pull(skb, metasize);
> > +               skb_metadata_set(skb, metasize);
> > +       }
> > +
> > +       return skb;
> > +}
> > +
> > +struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct vir=
tnet_info *vi,
> > +                                   struct virtnet_rq *rq, void *buf,
> > +                                   unsigned int len, unsigned int *xdp=
_xmit,
> > +                                   struct virtnet_rq_stats *stats)
> > +{
>
> I wonder if anything blocks us from reusing the existing XDP logic?
> Are there some subtle differences?


About this, "the existing XDP logic" do you mean virtnet_xdp_handler()?
This function reuse it.

virtnet_receive_xsk is on the same level with receive_mergeable.

I do the mergeable logic and small logic inside this function.
Do you have any question on why we introduce this function?

I tried to do inside receive_mergeable/small, but that be difficult.
Because that the buf,ctx is differ from the origin logic.
So I think introducing an new handler is the right way.

Thanks.


>
> Thanks
>

