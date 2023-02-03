Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC346892CE
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBCIyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCIyy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 03:54:54 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA5F1F4B9;
        Fri,  3 Feb 2023 00:54:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vao5d02_1675414487;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vao5d02_1675414487)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 16:54:48 +0800
Message-ID: <1675414355.7766702-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 20/33] virtio_net: xsk: introduce virtnet_rq_bind_xsk_pool()
Date:   Fri, 3 Feb 2023 16:52:35 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
 <20230203034642-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203034642-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 3 Feb 2023 03:48:33 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:45PM +0800, Xuan Zhuo wrote:
> > This function is used to bind or unbind xsk pool to virtnet rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/Makefile     |  2 +-
> >  drivers/net/virtio/main.c       |  8 ++---
> >  drivers/net/virtio/virtio_net.h | 16 ++++++++++
> >  drivers/net/virtio/xsk.c        | 56 +++++++++++++++++++++++++++++++++
> >  4 files changed, 76 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/net/virtio/xsk.c
> >
> > diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> > index 15ed7c97fd4f..8c2a884d2dba 100644
> > --- a/drivers/net/virtio/Makefile
> > +++ b/drivers/net/virtio/Makefile
> > @@ -5,4 +5,4 @@
> >
> >  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> >
> > -virtio_net-y := main.o
> > +virtio_net-y := main.o xsk.o
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 049a3bb9d88d..0ee23468b795 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -110,7 +110,6 @@ struct padded_vnet_hdr {
> >  	char padding[12];
> >  };
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> >
> >  static void *xdp_to_ptr(struct xdp_frame *ptr)
> > @@ -1351,8 +1350,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >   * before we're receiving packets, or from refill_work which is
> >   * careful to disable receiving (using napi_disable).
> >   */
> > -static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > -			  gfp_t gfp)
> > +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
> >  {
> >  	int err;
> >  	bool oom;
> > @@ -1388,7 +1386,7 @@ static void skb_recv_done(struct virtqueue *rvq)
> >  	virtqueue_napi_schedule(&rq->napi, rvq);
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> >  {
> >  	napi_enable(napi);
> >
> > @@ -3284,7 +3282,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  		xdp_return_frame(ptr_to_xdp(buf));
> >  }
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
>
> If you are making this an API now you better document
> what it does. Same applies to other stuff you are
> making non-static.

I agree.

>
>
> >  {
> >  	struct virtnet_info *vi = vq->vdev->priv;
> >  	int i = vq2rxq(vq);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > index b46f083a630a..4a7633714802 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -168,6 +168,12 @@ struct send_queue {
> >
> >  	/* Record whether sq is in reset state. */
> >  	bool reset;
> > +
> > +	struct {
> > +		struct xsk_buff_pool __rcu *pool;
> > +
> > +		dma_addr_t hdr_dma_address;
> > +	} xsk;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -200,6 +206,13 @@ struct receive_queue {
> >  	char name[16];
> >
> >  	struct xdp_rxq_info xdp_rxq;
> > +
> > +	struct {
> > +		struct xsk_buff_pool __rcu *pool;
> > +
> > +		/* xdp rxq used by xsk */
> > +		struct xdp_rxq_info xdp_rxq;
> > +	} xsk;
> >  };
> >
> >  static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > @@ -274,4 +287,7 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			unsigned int *xdp_xmit,
> >  			struct virtnet_rq_stats *stats);
> >  int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
> > +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp);
> > +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi);
> > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  #endif
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > new file mode 100644
> > index 000000000000..e01ff2abea11
> > --- /dev/null
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * virtio-net xsk
> > + */
> > +
> > +#include "virtio_net.h"
> > +
> > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> > +				    struct xsk_buff_pool *pool, struct net_device *dev)
>
> This static function is unused after this patch, so compiler will
> complain. Yes it's just a warning but still not nice.

Otherwise, we need merge some patches, which will increase the difficulty of
review.

Is there a better way to deal with? Remove Static?

Thanks.


>
>
> > +{
> > +	bool running = netif_running(vi->dev);
> > +	int err, qindex;
> > +
> > +	qindex = rq - vi->rq;
> > +
> > +	if (pool) {
> > +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, dev, qindex, rq->napi.napi_id);
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
> > +	} else {
> > +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +	}
> > +
> > +	if (running)
> > +		napi_disable(&rq->napi);
> > +
> > +	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
> > +	if (err)
> > +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> > +
> > +	if (pool) {
> > +		if (err)
> > +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > +		else
> > +			rcu_assign_pointer(rq->xsk.pool, pool);
> > +	} else {
> > +		rcu_assign_pointer(rq->xsk.pool, NULL);
> > +	}
> > +
> > +	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> > +		schedule_delayed_work(&vi->refill, 0);
> > +
> > +	if (running)
> > +		virtnet_napi_enable(rq->vq, &rq->napi);
> > +
> > +	return err;
> > +}
> > --
> > 2.32.0.3.g01195cf9f
>
