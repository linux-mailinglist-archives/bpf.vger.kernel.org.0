Return-Path: <bpf+bounces-32277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0290A7AE
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871141F246D6
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6AD18FDA6;
	Mon, 17 Jun 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CkwAs9Lf"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113653368;
	Mon, 17 Jun 2024 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610592; cv=none; b=ZUOy/xc1katrwMTkFzpD02XYJWXHhvrixEBmCBqxrXWaeVWW62ByBTfU9D+hJazEx+3P7ZR5I4nl9SpTNbnBEgxZ4rsaV+J9TRGReP1SS0STyT93aop4RJeyVyRfNgCbUxqnC/86hAUqI/KMHib8pbQXn4o9V2KqBFjuBrajZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610592; c=relaxed/simple;
	bh=g0ub0kWlMCU+P5kBE9dptzJyUoAtPN8Idom3eMusCAA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=gy23zjA0twgIqu7rmQsRkVd721EXCbD9IB8isNoFr7QIfeZ0HROlQcE9FeBj9NWLOHb57TDrbhM3mGQd7z+eGM/iFV6gQTLGR/w/iWxyhbesk5BpmjnuG5w1zbkLQpGJAxIHFRU/H4HNJXQCzVz6tLsHJrH9HrL+JPx4b9usF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CkwAs9Lf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718610581; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=KYR9SwGVtqFkGHv3uaZwzc247rXbNZZkPqvMhUHb0K0=;
	b=CkwAs9Lf4/UYU5UQIB3h4qehoRaYEuC9DT5QPNOHvr+sSmJsJqGt2B7GhF/Ch5d2lsq8GmPTB8WLO2fMI1d+qeL9TNHDCzGzf1dIbrHxzuQJx2/6pUe0uCtVsRu9WcEhHMdlRKLGR1ipU5zWgWT7CQZom/nhV+ujXuZRK8vhPt8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8aXqde_1718610580;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8aXqde_1718610580)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 15:49:40 +0800
Message-ID: <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
Date: Mon, 17 Jun 2024 15:43:11 +0800
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
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
In-Reply-To: <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 17 Jun 2024 14:19:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 201 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 200 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 88ab9ea1646f..35fd8bca7fcf 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -26,6 +26,7 @@
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/netdev_queues.h>
> >  #include <uapi/linux/virtio_ring.h>
> > +#include <net/xdp_sock_drv.h>
> >
> >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> >  module_param(napi_weight, int, 0444);
> > @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
> >
> >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> >
> > +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
>
> Does this mean AF_XDP only supports virtio_net_hdr_mrg_rxbuf but not othe=
rs?

Sorry, this is the old code.

Should be virtio_net_common_hdr.

Here we should use the max size of the virtio-net header.

>
> > +
> >  static const unsigned long guest_offloads[] =3D {
> >         VIRTIO_NET_F_GUEST_TSO4,
> >         VIRTIO_NET_F_GUEST_TSO6,
> > @@ -321,6 +324,12 @@ struct send_queue {
> >         bool premapped;
> >
> >         struct virtnet_sq_dma_info dmainfo;
> > +
> > +       struct {
> > +               struct xsk_buff_pool *pool;
> > +
> > +               dma_addr_t hdr_dma_address;
> > +       } xsk;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -372,6 +381,13 @@ struct receive_queue {
> >
> >         /* Record the last dma info to free after new pages is allocate=
d. */
> >         struct virtnet_rq_dma *last_dma;
> > +
> > +       struct {
> > +               struct xsk_buff_pool *pool;
> > +
> > +               /* xdp rxq used by xsk */
> > +               struct xdp_rxq_info xdp_rxq;
> > +       } xsk;
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for in=
direction table and keysize
> > @@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct send_qu=
eue *sq)
> >  /* This function must be called immediately after creating the vq, or =
after vq
> >   * reset, and before adding any buffers to it.
> >   */
> > -static __maybe_unused int virtnet_sq_set_premapped(struct send_queue *=
sq, bool premapped)
> > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premap=
ped)
> >  {
> >         if (premapped) {
> >                 int r;
> > @@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(struc=
t virtnet_info *vi)
> >         return virtnet_set_guest_offloads(vi, offloads);
> >  }
> >
> > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct re=
ceive_queue *rq,
> > +                                   struct xsk_buff_pool *pool)
> > +{
> > +       int err, qindex;
> > +
> > +       qindex =3D rq - vi->rq;
> > +
> > +       if (pool) {
> > +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qin=
dex, rq->napi.napi_id);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > +                                                MEM_TYPE_XSK_BUFF_POOL=
, NULL);
> > +               if (err < 0) {
> > +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +                       return err;
> > +               }
> > +
> > +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > +       }
> > +
> > +       virtnet_rx_pause(vi, rq);
> > +
> > +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +       if (err) {
> > +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d =
err: %d\n", qindex, err);
> > +
> > +               pool =3D NULL;
> > +       }
> > +
> > +       if (!pool)
> > +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
>
> Let's use err label instead of duplicating xdp_rxq_info_unreg() here?
>
> > +
> > +       rq->xsk.pool =3D pool;
> > +
> > +       virtnet_rx_resume(vi, rq);
> > +
> > +       return err;
> > +}
> > +
> > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > +                                   struct send_queue *sq,
> > +                                   struct xsk_buff_pool *pool)
> > +{
> > +       int err, qindex;
> > +
> > +       qindex =3D sq - vi->sq;
> > +
> > +       virtnet_tx_pause(vi, sq);
> > +
> > +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +       if (err)
> > +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d =
err: %d\n", qindex, err);
> > +       else
> > +               err =3D virtnet_sq_set_premapped(sq, !!pool);
> > +
> > +       if (err)
> > +               pool =3D NULL;
> > +
> > +       sq->xsk.pool =3D pool;
> > +
> > +       virtnet_tx_resume(vi, sq);
> > +
> > +       return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > +                                  struct xsk_buff_pool *pool,
> > +                                  u16 qid)
> > +{
> > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct receive_queue *rq;
> > +       struct send_queue *sq;
> > +       struct device *dma_dev;
> > +       dma_addr_t hdr_dma;
> > +       int err;
> > +
> > +       /* In big_packets mode, xdp cannot work, so there is no need to
> > +        * initialize xsk of rq.
> > +        *
> > +        * Support for small mode firstly.
>
> This comment is kind of confusing, I think mergeable mode is also
> supported. If it's true, we can simply remove it.

For the commit num limit of the net-next, I have to remove some commits.

So the mergeable mode is not supported by this patch set.

I plan to support the merge mode after this patch set.


>
> > +        */
> > +       if (vi->big_packets)
> > +               return -ENOENT;
> > +
> > +       if (qid >=3D vi->curr_queue_pairs)
> > +               return -EINVAL;
> > +
> > +       sq =3D &vi->sq[qid];
> > +       rq =3D &vi->rq[qid];
> > +
> > +       /* xsk tx zerocopy depend on the tx napi.
> > +        *
> > +        * All xsk packets are actually consumed and sent out from the =
xsk tx
> > +        * queue under the tx napi mechanism.
> > +        */
> > +       if (!sq->napi.weight)
> > +               return -EPERM;
> > +
> > +       /* For the xsk, the tx and rx should have the same device. But
> > +        * vq->dma_dev allows every vq has the respective dma dev. So I=
 check
> > +        * the dma dev of vq and sq is the same dev.
> > +        */
> > +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> > +               return -EPERM;
>
> I don't understand how a different DMA device matters here. It looks
> like the code is using per virtqueue DMA below.

The af-xdp may use one buffer to receive from the rx and reuse this buffer =
to
send by the tx.  So the dma dev of sq and rq should be the same one.

Thanks.

>
> > +
> > +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> > +       if (!dma_dev)
> > +               return -EPERM;
> > +
> > +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_=
TO_DEVICE);
> > +       if (dma_mapping_error(dma_dev, hdr_dma))
> > +               return -ENOMEM;
> > +
> > +       err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> > +       if (err)
> > +               goto err_xsk_map;
> > +
> > +       err =3D virtnet_rq_bind_xsk_pool(vi, rq, pool);
> > +       if (err)
> > +               goto err_rq;
> > +
> > +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> > +       if (err)
> > +               goto err_sq;
> > +
> > +       /* Now, we do not support tx offset, so all the tx virtnet hdr =
is zero.
> > +        * So all the tx packets can share a single hdr.
> > +        */
> > +       sq->xsk.hdr_dma_address =3D hdr_dma;
> > +
> > +       return 0;
> > +
> > +err_sq:
> > +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +err_rq:
> > +       xsk_pool_dma_unmap(pool, 0);
> > +err_xsk_map:
> > +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> > +       return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> > +{
> > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct xsk_buff_pool *pool;
> > +       struct device *dma_dev;
> > +       struct receive_queue *rq;
> > +       struct send_queue *sq;
> > +       int err1, err2;
> > +
> > +       if (qid >=3D vi->curr_queue_pairs)
> > +               return -EINVAL;
> > +
> > +       sq =3D &vi->sq[qid];
> > +       rq =3D &vi->rq[qid];
> > +
> > +       pool =3D sq->xsk.pool;
> > +
> > +       err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> > +       err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +
> > +       xsk_pool_dma_unmap(pool, 0);
> > +
> > +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> > +
> > +       dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len,=
 DMA_TO_DEVICE);
> > +
> > +       return err1 | err2;
> > +}
> > +
> > +static int virtnet_xsk_pool_setup(struct net_device *dev, struct netde=
v_bpf *xdp)
> > +{
> > +       if (xdp->xsk.pool)
> > +               return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> > +                                              xdp->xsk.queue_id);
> > +       else
> > +               return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> > +}
> > +
> >  static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *pr=
og,
> >                            struct netlink_ext_ack *extack)
> >  {
> > @@ -5302,6 +5499,8 @@ static int virtnet_xdp(struct net_device *dev, st=
ruct netdev_bpf *xdp)
> >         switch (xdp->command) {
> >         case XDP_SETUP_PROG:
> >                 return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> > +       case XDP_SETUP_XSK_POOL:
> > +               return virtnet_xsk_pool_setup(dev, xdp);
> >         default:
> >                 return -EINVAL;
> >         }
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

