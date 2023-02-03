Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B396892A8
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 09:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBCIte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBCItd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 03:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3F22DD9
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675414124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAKc94Ixe1rZj/Kzn4+Ft2huDa+LD1uWLCdlu0GoQEk=;
        b=ISsnwsNXy7WqQ5He2Gil1Nhf3F7Nh5mU4xBuW1Hri+uFzJ1bAva5A6olDWc8muUtdlVKz9
        AkWbIOwb29YsxYL23tywZ22z/gs+in09NrvsdMGJC0KbakZQRXhI2m/ERDw5tcRp3ddGgo
        KLzirggBXfAly5KT1SgYEB7dRvRlgZM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-hVNPwsuaOIKJ0eo77fW5FQ-1; Fri, 03 Feb 2023 03:48:42 -0500
X-MC-Unique: hVNPwsuaOIKJ0eo77fW5FQ-1
Received: by mail-ed1-f71.google.com with SMTP id ec37-20020a0564020d6500b004a94daceb81so781400edb.18
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 00:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAKc94Ixe1rZj/Kzn4+Ft2huDa+LD1uWLCdlu0GoQEk=;
        b=h+RvcOfV6OTpn+3x4nBRq34pm93hBm8COq4LBePsPPf6r2Y00HksIBVbezGrXx7lgs
         4R4Wti/PnwStSFdJqb9sHlw8MIeuazFlhhrrbEuK1OcyS88LTx0MRmCP+iEMlTHZDwwF
         g7B+9OF4jH1XhnBUL/z9Jv+A4u5lgAK7P8vRyxGzOF89BNYVxi0A9NNMHa9xlfNlsl+6
         O9OH7+/KOU1774hOQuqv68RrQAmz3tq0ZM+dh83La798SsqMZbVDbaHcmWq7vCvVphRR
         qjhdB2oK8h5/OiXdeGj26zOAVT44IOBlHNLWEzeXi4jb4OOuGjjPkDrjbWMpnqQOmX0c
         IDMA==
X-Gm-Message-State: AO0yUKUgb/HCZ2goSM+ewCDttuwFuVuQjIYl2KzqNDFWoSM1ehsTyJUQ
        2Ha/YPQqe+3dHFWw5Liq31P/qm/k6AgA1fVLXFw4Zes9GLej73Ip9HBQr8in7FFuUYk8H+Q3RR/
        CHdUEteZTl/q/
X-Received: by 2002:a17:907:6087:b0:887:5f45:d688 with SMTP id ht7-20020a170907608700b008875f45d688mr9561682ejc.41.1675414118820;
        Fri, 03 Feb 2023 00:48:38 -0800 (PST)
X-Google-Smtp-Source: AK7set89lm9S151OquZnuoyt8nL85dYjqpw2IBo88NRgrkXAApp4gVR7Yo3jPOqbvdp2IEZXVkmbZQ==
X-Received: by 2002:a17:907:6087:b0:887:5f45:d688 with SMTP id ht7-20020a170907608700b008875f45d688mr9561666ejc.41.1675414118604;
        Fri, 03 Feb 2023 00:48:38 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906841800b00889310a3fcbsm1035683ejx.210.2023.02.03.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:48:37 -0800 (PST)
Date:   Fri, 3 Feb 2023 03:48:33 -0500
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
Message-ID: <20230203034642-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 07:00:45PM +0800, Xuan Zhuo wrote:
> This function is used to bind or unbind xsk pool to virtnet rq.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/Makefile     |  2 +-
>  drivers/net/virtio/main.c       |  8 ++---
>  drivers/net/virtio/virtio_net.h | 16 ++++++++++
>  drivers/net/virtio/xsk.c        | 56 +++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/virtio/xsk.c
> 
> diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> index 15ed7c97fd4f..8c2a884d2dba 100644
> --- a/drivers/net/virtio/Makefile
> +++ b/drivers/net/virtio/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  
> -virtio_net-y := main.o
> +virtio_net-y := main.o xsk.o
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 049a3bb9d88d..0ee23468b795 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -110,7 +110,6 @@ struct padded_vnet_hdr {
>  	char padding[12];
>  };
>  
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  
>  static void *xdp_to_ptr(struct xdp_frame *ptr)
> @@ -1351,8 +1350,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>   * before we're receiving packets, or from refill_work which is
>   * careful to disable receiving (using napi_disable).
>   */
> -static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> -			  gfp_t gfp)
> +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
>  {
>  	int err;
>  	bool oom;
> @@ -1388,7 +1386,7 @@ static void skb_recv_done(struct virtqueue *rvq)
>  	virtqueue_napi_schedule(&rq->napi, rvq);
>  }
>  
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>  {
>  	napi_enable(napi);
>  
> @@ -3284,7 +3282,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  		xdp_return_frame(ptr_to_xdp(buf));
>  }
>  
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)

If you are making this an API now you better document
what it does. Same applies to other stuff you are
making non-static.


>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	int i = vq2rxq(vq);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index b46f083a630a..4a7633714802 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -168,6 +168,12 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +
> +		dma_addr_t hdr_dma_address;
> +	} xsk;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -200,6 +206,13 @@ struct receive_queue {
>  	char name[16];
>  
>  	struct xdp_rxq_info xdp_rxq;
> +
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +
> +		/* xdp rxq used by xsk */
> +		struct xdp_rxq_info xdp_rxq;
> +	} xsk;
>  };
>  
>  static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> @@ -274,4 +287,7 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			unsigned int *xdp_xmit,
>  			struct virtnet_rq_stats *stats);
>  int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
> +bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp);
> +void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi);
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  #endif
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> new file mode 100644
> index 000000000000..e01ff2abea11
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * virtio-net xsk
> + */
> +
> +#include "virtio_net.h"
> +
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> +				    struct xsk_buff_pool *pool, struct net_device *dev)

This static function is unused after this patch, so compiler will
complain. Yes it's just a warning but still not nice.


> +{
> +	bool running = netif_running(vi->dev);
> +	int err, qindex;
> +
> +	qindex = rq - vi->rq;
> +
> +	if (pool) {
> +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, dev, qindex, rq->napi.napi_id);
> +		if (err < 0)
> +			return err;
> +
> +		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> +		if (err < 0) {
> +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +			return err;
> +		}
> +
> +		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +	} else {
> +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +	}
> +
> +	if (running)
> +		napi_disable(&rq->napi);
> +
> +	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
> +	if (err)
> +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> +
> +	if (pool) {
> +		if (err)
> +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +		else
> +			rcu_assign_pointer(rq->xsk.pool, pool);
> +	} else {
> +		rcu_assign_pointer(rq->xsk.pool, NULL);
> +	}
> +
> +	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +		schedule_delayed_work(&vi->refill, 0);
> +
> +	if (running)
> +		virtnet_napi_enable(rq->vq, &rq->napi);
> +
> +	return err;
> +}
> -- 
> 2.32.0.3.g01195cf9f

