Return-Path: <bpf+bounces-32037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D5690621A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728851C211EE
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20012C466;
	Thu, 13 Jun 2024 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SqIADLRw"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23505179AF;
	Thu, 13 Jun 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246835; cv=none; b=VwwGt8m7U8ohYOsHItsHS27lhFmEbYdyjJCc1iQd1hLgvjge42uImOd4aLPgsHnZZK+vF91XyPrdldi7WiiC7ePKiYQvof7khgrxXXYhvHYCEm+APORFBIyjTOMXHNKM0AhKKFE082miKioagG+7cvhYeltJ+7VKe6iAWuciRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246835; c=relaxed/simple;
	bh=mFdYMMZ1R9O79ui5VKyl/O9Pmjs+AII+2JX5t6IWJoM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=lhgwy7vwP8f1XpTKbEZERk72nHnOxJa2uttupit60Y7DWtosmVBm1Bn05QxGN7GM9zmvZhyU/pAZSd+WjtXZxiKyuYVHm34LzNbK7npaUG/Egjw4TyF8y8w4nQFX0EseN6CtjfHn60LbBvPEgxxw6H7W/TYgucC1b58LToazM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SqIADLRw; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246824; h=Message-ID:Subject:Date:From:To;
	bh=jAW6uwbIBOI7hFZfAMUEtqVwC3hxJEOSwfQ72UWaY28=;
	b=SqIADLRw18Hrj0Yg2C+G9HbU7Yb0v3mcX88Ytbc3MNJRLdtzto3JDD+SnIpK2gtEp2okm8re2Ocqe8RuYFkgyNAx5BehMZKNiQ7WasW5USu6ViDL8dujSST0YGm28d2smbB4HpU6TpuYVg+3v4EpRjhZqsurqXnbt/rOeoZ3PNg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8MHDhS_1718246823;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8MHDhS_1718246823)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:47:03 +0800
Message-ID: <1718246630.9367933-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 09/15] virtio_net: xsk: bind/unbind xsk
Date: Thu, 13 Jun 2024 10:43:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
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
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-10-xuanzhuo@linux.alibaba.com>
 <20240612194235-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240612194235-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jun 2024 19:43:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jun 11, 2024 at 07:41:41PM +0800, Xuan Zhuo wrote:
> > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> I'd just squash with previous patch. This one is hard to review in
> isolation.

Why?

The previous patch is to supply a API to switch to premapped mode for sq.

This is to introduce the xsk. This patch just use the API.
I do not think we should merge these two patch.

Thanks.


>
> > ---
> >  drivers/net/virtio_net.c | 199 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 199 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4968ab7eb5a4..c82a0691632c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -26,6 +26,7 @@
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/netdev_queues.h>
> >  #include <uapi/linux/virtio_ring.h>
> > +#include <net/xdp_sock_drv.h>
> >
> >  static int napi_weight = NAPI_POLL_WEIGHT;
> >  module_param(napi_weight, int, 0444);
> > @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
> >
> >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> >
> > +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> > +
> >  static const unsigned long guest_offloads[] = {
> >  	VIRTIO_NET_F_GUEST_TSO4,
> >  	VIRTIO_NET_F_GUEST_TSO6,
> > @@ -320,6 +323,12 @@ struct send_queue {
> >  	bool premapped;
> >
> >  	struct virtnet_sq_dma_info dmainfo;
> > +
> > +	struct {
> > +		struct xsk_buff_pool *pool;
> > +
> > +		dma_addr_t hdr_dma_address;
> > +	} xsk;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -371,6 +380,13 @@ struct receive_queue {
> >
> >  	/* Record the last dma info to free after new pages is allocated. */
> >  	struct virtnet_rq_dma *last_dma;
> > +
> > +	struct {
> > +		struct xsk_buff_pool *pool;
> > +
> > +		/* xdp rxq used by xsk */
> > +		struct xdp_rxq_info xdp_rxq;
> > +	} xsk;
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for indirection table and keysize
> > @@ -5168,6 +5184,187 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
> >  	return virtnet_set_guest_offloads(vi, offloads);
> >  }
> >
> > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> > +				    struct xsk_buff_pool *pool)
> > +{
> > +	int err, qindex;
> > +
> > +	qindex = rq - vi->rq;
> > +
> > +	if (pool) {
> > +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qindex, rq->napi.napi_id);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> > +		if (err < 0) {
> > +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +			return err;
> > +		}
> > +
> > +		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > +	}
> > +
> > +	virtnet_rx_pause(vi, rq);
> > +
> > +	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +	if (err) {
> > +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> > +
> > +		pool = NULL;
> > +	}
> > +
> > +	if (!pool)
> > +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +
> > +	rq->xsk.pool = pool;
> > +
> > +	virtnet_rx_resume(vi, rq);
> > +
> > +	return err;
> > +}
> > +
> > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > +				    struct send_queue *sq,
> > +				    struct xsk_buff_pool *pool)
> > +{
> > +	int err, qindex;
> > +
> > +	qindex = sq - vi->sq;
> > +
> > +	virtnet_tx_pause(vi, sq);
> > +
> > +	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +	if (err)
> > +		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
> > +	else
> > +		err = virtnet_sq_set_premapped(sq, !!pool);
> > +
> > +	if (err)
> > +		pool = NULL;
> > +
> > +	sq->xsk.pool = pool;
> > +
> > +	virtnet_tx_resume(vi, sq);
> > +
> > +	return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > +				   struct xsk_buff_pool *pool,
> > +				   u16 qid)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +	struct receive_queue *rq;
> > +	struct send_queue *sq;
> > +	struct device *dma_dev;
> > +	dma_addr_t hdr_dma;
> > +	int err;
> > +
> > +	/* In big_packets mode, xdp cannot work, so there is no need to
> > +	 * initialize xsk of rq.
> > +	 *
> > +	 * Support for small mode firstly.
> > +	 */
> > +	if (vi->big_packets)
> > +		return -ENOENT;
> > +
> > +	if (qid >= vi->curr_queue_pairs)
> > +		return -EINVAL;
> > +
> > +	sq = &vi->sq[qid];
> > +	rq = &vi->rq[qid];
> > +
> > +	/* xsk tx zerocopy depend on the tx napi.
> > +	 *
> > +	 * All xsk packets are actually consumed and sent out from the xsk tx
> > +	 * queue under the tx napi mechanism.
> > +	 */
> > +	if (!sq->napi.weight)
> > +		return -EPERM;
> > +
> > +	/* For the xsk, the tx and rx should have the same device. But
> > +	 * vq->dma_dev allows every vq has the respective dma dev. So I check
> > +	 * the dma dev of vq and sq is the same dev.
> > +	 */
> > +	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
> > +		return -EPERM;
> > +
> > +	dma_dev = virtqueue_dma_dev(rq->vq);
> > +	if (!dma_dev)
> > +		return -EPERM;
> > +
> > +	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
> > +	if (dma_mapping_error(dma_dev, hdr_dma))
> > +		return -ENOMEM;
> > +
> > +	err = xsk_pool_dma_map(pool, dma_dev, 0);
> > +	if (err)
> > +		goto err_xsk_map;
> > +
> > +	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
> > +	if (err)
> > +		goto err_rq;
> > +
> > +	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
> > +	if (err)
> > +		goto err_sq;
> > +
> > +	/* Now, we do not support tx offset, so all the tx virtnet hdr is zero.
> > +	 * So all the tx packets can share a single hdr.
> > +	 */
> > +	sq->xsk.hdr_dma_address = hdr_dma;
> > +
> > +	return 0;
> > +
> > +err_sq:
> > +	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +err_rq:
> > +	xsk_pool_dma_unmap(pool, 0);
> > +err_xsk_map:
> > +	dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> > +	return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +	struct xsk_buff_pool *pool;
> > +	struct device *dma_dev;
> > +	struct receive_queue *rq;
> > +	struct send_queue *sq;
> > +	int err1, err2;
> > +
> > +	if (qid >= vi->curr_queue_pairs)
> > +		return -EINVAL;
> > +
> > +	sq = &vi->sq[qid];
> > +	rq = &vi->rq[qid];
> > +
> > +	pool = sq->xsk.pool;
> > +
> > +	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> > +	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +
> > +	xsk_pool_dma_unmap(pool, 0);
> > +
> > +	dma_dev = virtqueue_dma_dev(rq->vq);
> > +
> > +	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> > +
> > +	return err1 | err2;
> > +}
> > +
> > +static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
> > +{
> > +	if (xdp->xsk.pool)
> > +		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> > +					       xdp->xsk.queue_id);
> > +	else
> > +		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> > +}
> > +
> >  static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >  			   struct netlink_ext_ack *extack)
> >  {
> > @@ -5293,6 +5490,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> >  	switch (xdp->command) {
> >  	case XDP_SETUP_PROG:
> >  		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> > +	case XDP_SETUP_XSK_POOL:
> > +		return virtnet_xsk_pool_setup(dev, xdp);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > --
> > 2.32.0.3.g01195cf9f
>

