Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB96893B7
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjBCJ3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 04:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjBCJ26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 04:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B721A06
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675416493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsU65vSYMoLwf6f2388a7fWZo5jYwY0l9gKI5hM1R9Q=;
        b=bNhuw+GPv7TRE3IrqLmY0BDlTFMW4Oq9AT6jqU9oikcumuqjjD+zj8Q88PtiaDwW9ZlM3z
        yVA17yr+KUQ74rpWRJ3oDnEJkpN5e6JhHo6KiwYJVl6306PB5M2lb+ULU/UOCC1rDG+tkV
        ZLx4TpSfxvZmHVPwIGZBzG1ju+RH/sU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-iLXFq_0DMVuZx8GmTPgylA-1; Fri, 03 Feb 2023 04:28:09 -0500
X-MC-Unique: iLXFq_0DMVuZx8GmTPgylA-1
Received: by mail-ej1-f70.google.com with SMTP id m21-20020a1709060d9500b0088ca6c7af4cso3529784eji.21
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 01:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsU65vSYMoLwf6f2388a7fWZo5jYwY0l9gKI5hM1R9Q=;
        b=o5/oDstSk7oClGY9xo0mwPNuglFZSjSlCy1mWMSvMC5RkSxPN9s74DMp5E1E7gWcrZ
         v0nQOi1yN66A+n0Vrrr11+K6nPZrWrMMCXkNcByGeNYFBsj7Tx97kd/oEg3/lJdXRpV8
         K/bEnTlYORDnlIlUuc8KpPmVfQFIY/pCN907iksSzsswwG8HgpcQJmk0+Mtom/9ptIKq
         iL1QkjtReFmaApXh/41AiW3nmxI2drXbZmQyCbzBYCh4VJp/61BCpnyUN2lJ1AACqzda
         bIEDk0AyRC30l6EfjeWjpaDw4svEsASzJOhhTyRIYTRywG6sqGc2YBZ0EIkzwMjf1IuF
         pA1A==
X-Gm-Message-State: AO0yUKVgn99OvWiU/lTW3AvrRZh2TCQDtbpQQHAS8pkyQePB4Il+FmHW
        PUtQdep1Av3GeKjeWCEfV5DAgFWGf33YTAKvuUXRrIxxc1sRfqFXNSlSNzZzczMtothLmeefVEJ
        yZkoSjBP44fjJ
X-Received: by 2002:a17:906:48c4:b0:889:1734:566a with SMTP id d4-20020a17090648c400b008891734566amr8542295ejt.76.1675416488267;
        Fri, 03 Feb 2023 01:28:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+U194lNou1XUYRKDR7htcVFwuAYkg0KOzkfL07aTO/JQHiXlT5eGkkPBCWmAlDr1VjJuxM8g==
X-Received: by 2002:a17:906:48c4:b0:889:1734:566a with SMTP id d4-20020a17090648c400b008891734566amr8542284ejt.76.1675416488013;
        Fri, 03 Feb 2023 01:28:08 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id c19-20020a17090603d300b0088519b9206bsm1088980eja.130.2023.02.03.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:28:07 -0800 (PST)
Date:   Fri, 3 Feb 2023 04:28:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
Subject: Re: [PATCH 20/33] virtio_net: xsk: introduce
 virtnet_rq_bind_xsk_pool()
Message-ID: <20230203042624-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
 <20230203034642-mutt-send-email-mst@kernel.org>
 <1675414355.7766702-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675414355.7766702-3-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 04:52:35PM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 03:48:33 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:45PM +0800, Xuan Zhuo wrote:
> > > This function is used to bind or unbind xsk pool to virtnet rq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/Makefile     |  2 +-
> > >  drivers/net/virtio/main.c       |  8 ++---
> > >  drivers/net/virtio/virtio_net.h | 16 ++++++++++
> > >  drivers/net/virtio/xsk.c        | 56 +++++++++++++++++++++++++++++++++
> > >  4 files changed, 76 insertions(+), 6 deletions(-)
> > >  create mode 100644 drivers/net/virtio/xsk.c
> > >
> > > diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> > > index 15ed7c97fd4f..8c2a884d2dba 100644
> > > --- a/drivers/net/virtio/Makefile
> > > +++ b/drivers/net/virtio/Makefile
> > > @@ -5,4 +5,4 @@
> > >
> > >  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> > >
> > > -virtio_net-y := main.o
> > > +virtio_net-y := main.o xsk.o
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 049a3bb9d88d..0ee23468b795 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -110,7 +110,6 @@ struct padded_vnet_hdr {
> > >  	char padding[12];
> > >  };
> > >
> > > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >
> > >  static void *xdp_to_ptr(struct xdp_frame *ptr)
> > > @@ -1351,8 +1350,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > >   * before we're receiving packets, or from refill_work which is
> > >   * careful to disable receiving (using napi_disable).
> > >   */
> > > -static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > > -			  gfp_t gfp)
> > > +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
> > >  {
> > >  	int err;
> > >  	bool oom;
> > > @@ -1388,7 +1386,7 @@ static void skb_recv_done(struct virtqueue *rvq)
> > >  	virtqueue_napi_schedule(&rq->napi, rvq);
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > >  {
> > >  	napi_enable(napi);
> > >
> > > @@ -3284,7 +3282,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >  		xdp_return_frame(ptr_to_xdp(buf));
> > >  }
> > >
> > > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> >
> > If you are making this an API now you better document
> > what it does. Same applies to other stuff you are
> > making non-static.
> 
> I agree.
> 
> >
> >
> > >  {
> > >  	struct virtnet_info *vi = vq->vdev->priv;
> > >  	int i = vq2rxq(vq);
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > index b46f083a630a..4a7633714802 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -168,6 +168,12 @@ struct send_queue {
> > >
> > >  	/* Record whether sq is in reset state. */
> > >  	bool reset;
> > > +
> > > +	struct {
> > > +		struct xsk_buff_pool __rcu *pool;
> > > +
> > > +		dma_addr_t hdr_dma_address;
> > > +	} xsk;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -200,6 +206,13 @@ struct receive_queue {
> > >  	char name[16];
> > >
> > >  	struct xdp_rxq_info xdp_rxq;
> > > +
> > > +	struct {
> > > +		struct xsk_buff_pool __rcu *pool;
> > > +
> > > +		/* xdp rxq used by xsk */
> > > +		struct xdp_rxq_info xdp_rxq;
> > > +	} xsk;
> > >  };
> > >
> > >  static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > > @@ -274,4 +287,7 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > >  			unsigned int *xdp_xmit,
> > >  			struct virtnet_rq_stats *stats);
> > >  int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
> > > +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp);
> > > +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi);
> > > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >  #endif
> > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > new file mode 100644
> > > index 000000000000..e01ff2abea11
> > > --- /dev/null
> > > +++ b/drivers/net/virtio/xsk.c
> > > @@ -0,0 +1,56 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * virtio-net xsk
> > > + */
> > > +
> > > +#include "virtio_net.h"
> > > +
> > > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> > > +				    struct xsk_buff_pool *pool, struct net_device *dev)
> >
> > This static function is unused after this patch, so compiler will
> > complain. Yes it's just a warning but still not nice.
> 
> Otherwise, we need merge some patches, which will increase the difficulty of
> review.
> 
> Is there a better way to deal with? Remove Static?
> 
> Thanks.

In this case review is not made easier because the API does not make
much sense by its own and is undocumented anyway. To review one has to
jump back and forth between multiple patches - that is harder not easier
than a single bigger patch. Others in this thread already commented that
the patches are too small.


> 
> >
> >
> > > +{
> > > +	bool running = netif_running(vi->dev);
> > > +	int err, qindex;
> > > +
> > > +	qindex = rq - vi->rq;
> > > +
> > > +	if (pool) {
> > > +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, dev, qindex, rq->napi.napi_id);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > > +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> > > +		if (err < 0) {
> > > +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > +			return err;
> > > +		}
> > > +
> > > +		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > > +	} else {
> > > +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > +	}
> > > +
> > > +	if (running)
> > > +		napi_disable(&rq->napi);
> > > +
> > > +	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
> > > +	if (err)
> > > +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> > > +
> > > +	if (pool) {
> > > +		if (err)
> > > +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > +		else
> > > +			rcu_assign_pointer(rq->xsk.pool, pool);
> > > +	} else {
> > > +		rcu_assign_pointer(rq->xsk.pool, NULL);
> > > +	}
> > > +
> > > +	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> > > +		schedule_delayed_work(&vi->refill, 0);
> > > +
> > > +	if (running)
> > > +		virtnet_napi_enable(rq->vq, &rq->napi);
> > > +
> > > +	return err;
> > > +}
> > > --
> > > 2.32.0.3.g01195cf9f
> >

