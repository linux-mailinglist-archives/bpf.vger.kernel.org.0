Return-Path: <bpf+bounces-12965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2A7D28B3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 04:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D97B20CDA
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777815A8;
	Mon, 23 Oct 2023 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126F637;
	Mon, 23 Oct 2023 02:47:20 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4ED51;
	Sun, 22 Oct 2023 19:47:16 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vud3n0v_1698029232;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vud3n0v_1698029232)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 10:47:13 +0800
Message-ID: <1698028779.8400478-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 16/19] virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
Date: Mon, 23 Oct 2023 10:39:39 +0800
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

1. We need to copy data to create skb for XDP_PASS.
2. We need to call xsk_buff_free() to release the buffer.
3. The handle for xdp_buff is difference.

virtnet_xdp_handler() is re-used. So the receive code is simple.

If we pushed this function into existing code, we would have to maintain
code scattered inside merge and small (and big). So I think it is a good
choice for us to put the xsk code into a function.


Thanks.


>
> Thanks
>

