Return-Path: <bpf+bounces-12020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5B7C6959
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087A01C20ED9
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40021116;
	Thu, 12 Oct 2023 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB20B0C;
	Thu, 12 Oct 2023 09:21:41 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E6A9;
	Thu, 12 Oct 2023 02:21:39 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vu-2qJN_1697102496;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vu-2qJN_1697102496)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 17:21:36 +0800
Message-ID: <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Thu, 12 Oct 2023 17:18:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
 <20231012051416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231012051416-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 12 Oct 2023 05:15:52 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> > virtqueue_set_dma_premapped() adds a new parameter to disable the
> > virtqueue premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c     |  2 +-
> >  drivers/virtio/virtio_ring.c | 11 ++++++++---
> >  include/linux/virtio.h       |  2 +-
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fe7f314d65c9..6b5f47ebf9b2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  		return;
> >
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
> >  			continue;
> >
> >  		vi->rq[i].do_dma = true;
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 51d8f3299c10..b3ded56722f4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * 0: success.
> >   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> >   */
> > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  	u32 num;
> > @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> >  		return -EINVAL;
> >  	}
> >
> > -	vq->premapped = true;
> > -	vq->do_unmap = false;
> > +	if (mode) {
> > +		vq->premapped = true;
> > +		vq->do_unmap = false;
> > +	} else {
> > +		vq->premapped = false;
> > +		vq->do_unmap = vq->use_dma_api;
> > +	}
> >
> >  	END_USE(vq);
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 4cc614a38376..1cf7b004348b 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> >
> >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> >
> > -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
> >
> >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>
> Wait a sec I thought we never change premapped. If you make this
> dynamic don't you need a bunch of locking?
> Or maybe queue is empty when you change this?
> If yes pls add a bunch of BUG_ON checks to make sure this is not misused.


Actually, this api is called immediately after the vq init or vq reset.

We already have such a check.

Thanks.

/**
 * virtqueue_set_dma_premapped - set the vring premapped mode
 * @_vq: the struct virtqueue we're talking about.
 *
 * Enable the premapped mode of the vq.
 *
 * The vring in premapped mode does not do dma internally, so the driver must
 * do dma mapping in advance. The driver must pass the dma_address through
 * dma_address of scatterlist. When the driver got a used buffer from
 * the vring, it has to unmap the dma address.
 *
 * This function must be called immediately after creating the vq, or after vq
 * reset, and before adding any buffers to it.
 *
 * Caller must ensure we don't call this with other virtqueue operations
 * at the same time (except where noted).
 *
 * Returns zero or a negative error.
 * 0: success.
 * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
 */
int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
{
	struct vring_virtqueue *vq = to_vvq(_vq);
	u32 num;

	START_USE(vq);

	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;

-->	if (num != vq->vq.num_free) {
		END_USE(vq);
		return -EINVAL;
	}

	if (!vq->use_dma_api) {
		END_USE(vq);
		return -EINVAL;
	}

	if (mode) {
		vq->premapped = true;
		vq->do_unmap = false;
	} else {
		vq->premapped = false;
		vq->do_unmap = vq->use_dma_api;
	}

	END_USE(vq);

	return 0;
}
EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);


>
>
> > --
> > 2.32.0.3.g01195cf9f
>

