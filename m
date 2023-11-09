Return-Path: <bpf+bounces-14558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F897E64F3
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D2E1C2091D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E3107A0;
	Thu,  9 Nov 2023 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao1ckPKd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD310783
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:09:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F682737
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699517349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUoeYWUJDM0IWxWC+TFHuPPTNx4g+Umu7w6l7MZzjis=;
	b=Ao1ckPKdwVI0heZ9DoUtjUB9EMSDHUZtBzJzroLYoZ/hJbGU8EpnWOs4DJfB8QSFL9JuWY
	X2GNjqTASR2igotR6XkqWxrS+ZndDk9WYxYfXIsBOcI68Ji2nlq+/buKmA9clEwTn+9GAj
	htz4Il8uX6iR+PwUgg18dp//3u7jB7M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-cWHPaMmfOvW7dBTZPAB40Q-1; Thu, 09 Nov 2023 03:09:07 -0500
X-MC-Unique: cWHPaMmfOvW7dBTZPAB40Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9e31708ad72so46577366b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 00:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517346; x=1700122146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUoeYWUJDM0IWxWC+TFHuPPTNx4g+Umu7w6l7MZzjis=;
        b=XAtch0IgHlnXbQfLR+3kU72s2a13ckMyoQPcTNDS/6+TLNi91fc4YjSwAstd0Fq7nd
         2Czi3mPn34dcMlt7BL/QIRKNHgHyHwOh54ra+dcEwJeSz1Hlk6JOenv8rDx++FWcRmSF
         8yzL6mx4JLlI0yZYu80cfJYZhrzHQ9AkPczmS4dn5jJ/H/vChCCWiLKgC/dmOaFSTzeK
         tHevIh739+AZ+zCTHhOKlfG4Me4lTIPveediUbjvx3pY+/VrLOsaksWmV5YJR81sJPf/
         w7hnqB9CqxMnvwJbbvl6YE4rPpS+H4jvoiRyAcrC40ZRTffrXikiaotYgSLAvLmW/WCQ
         gglA==
X-Gm-Message-State: AOJu0Yz6uVeNPCnMVf4/pCe8zERbhZa9zbVH6ttiK76vHYpSdONLjGZi
	hwMUp+4qHNmsiC6/ubQnXOLbHuPbvZJRUZdluyJ5e4zC5ucvcmQnnZWixMY4tywTqL1M+IYyeqf
	nGeFbyHb2itnT
X-Received: by 2002:a17:907:94cf:b0:9be:2991:81fb with SMTP id dn15-20020a17090794cf00b009be299181fbmr4063691ejc.36.1699517345903;
        Thu, 09 Nov 2023 00:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYpu3wVHFEBLFOCNpjO1ckAkX39m7vNMdfJg1lqaCszlr215VR1rcwV9phhRRqhp7kEHHjtw==
X-Received: by 2002:a17:907:94cf:b0:9be:2991:81fb with SMTP id dn15-20020a17090794cf00b009be299181fbmr4063673ejc.36.1699517345524;
        Thu, 09 Nov 2023 00:09:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906359400b0098f33157e7dsm2189274ejb.82.2023.11.09.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:09:04 -0800 (PST)
Date: Thu, 9 Nov 2023 03:09:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/21] virtio_net: xsk: tx: support tx
Message-ID: <20231109030424-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-13-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107031227.100015-13-xuanzhuo@linux.alibaba.com>

On Tue, Nov 07, 2023 at 11:12:18AM +0800, Xuan Zhuo wrote:
> The driver's tx napi is very important for XSK. It is responsible for
> obtaining data from the XSK queue and sending it out.
> 
> At the beginning, we need to trigger tx napi.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  12 +++-
>  drivers/net/virtio/virtio_net.h |   3 +-
>  drivers/net/virtio/xsk.c        | 110 ++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |  13 ++++
>  4 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 6c608b3ce27d..ff6bc764089d 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2074,6 +2074,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	unsigned int index = vq2txq(sq->vq);
>  	struct netdev_queue *txq;
> +	int busy = 0;
>  	int opaque;
>  	bool done;
>  
> @@ -2086,11 +2087,20 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
>  	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, true);
> +
> +	if (sq->xsk.pool)
> +		busy |= virtnet_xsk_xmit(sq, sq->xsk.pool, budget);

You use bitwise or on errno values? What's going on here?


> +	else
> +		free_old_xmit(sq, true);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  		netif_tx_wake_queue(txq);
>  
> +	if (busy) {
> +		__netif_tx_unlock(txq);
> +		return budget;
> +	}
> +
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>  
>  	done = napi_complete_done(napi, 0);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index 442af4673bf8..1c21af47e13c 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -9,7 +9,8 @@
>  #include <net/xdp_sock_drv.h>
>  
>  #define VIRTIO_XDP_FLAG	BIT(0)
> -#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> +#define VIRTIO_XSK_FLAG	BIT(1)
> +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG)
>  
>  /* RX packet size EWMA. The average packet size is used to determine the packet
>   * buffer size when refilling RX rings. As the entire RX ring may be refilled
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 8b397787603f..caa448308232 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -4,9 +4,119 @@
>   */
>  
>  #include "virtio_net.h"
> +#include "xsk.h"
>  
>  static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
>  
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
> +{
> +	sg->dma_address = addr;
> +	sg->length = len;
> +}
> +
> +static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> +{
> +	struct virtnet_info *vi = sq->vq->vdev->priv;
> +	struct net_device *dev = vi->dev;
> +	int qnum = sq - vi->sq;
> +
> +	/* If it is a raw buffer queue, it does not check whether the status
> +	 * of the queue is stopped when sending. So there is no need to check
> +	 * the situation of the raw buffer queue.
> +	 */
> +	if (virtnet_is_xdp_raw_buffer_queue(vi, qnum))
> +		return;
> +
> +	/* If this sq is not the exclusive queue of the current cpu,
> +	 * then it may be called by start_xmit, so check it running out
> +	 * of space.
> +	 *
> +	 * Stop the queue to avoid getting packets that we are
> +	 * then unable to transmit. Then wait the tx interrupt.
> +	 */
> +	if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)

what does MAX_SKB_FRAGS have to do with it? And where's 2 coming from?

> +		netif_stop_subqueue(dev, qnum);
> +}
> +
> +static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> +				struct xsk_buff_pool *pool,
> +				struct xdp_desc *desc)
> +{
> +	struct virtnet_info *vi;
> +	dma_addr_t addr;
> +
> +	vi = sq->vq->vdev->priv;
> +
> +	addr = xsk_buff_raw_get_dma(pool, desc->addr);
> +	xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> +
> +	sg_init_table(sq->sg, 2);
> +
> +	sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
> +	sg_fill_dma(sq->sg + 1, addr, desc->len);
> +
> +	return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> +				    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
> +}
> +
> +static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
> +				  struct xsk_buff_pool *pool,
> +				  unsigned int budget,
> +				  u64 *kicks)
> +{
> +	struct xdp_desc *descs = pool->tx_descs;
> +	u32 nb_pkts, max_pkts, i;
> +	bool kick = false;
> +	int err;
> +
> +	/* Every xsk tx packet needs two desc(virtnet header and packet). So we
> +	 * use sq->vq->num_free / 2 as the limitation.
> +	 */
> +	max_pkts = min_t(u32, budget, sq->vq->num_free / 2);
> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, max_pkts);
> +	if (!nb_pkts)
> +		return 0;
> +
> +	for (i = 0; i < nb_pkts; i++) {
> +		err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> +		if (unlikely(err))
> +			break;
> +
> +		kick = true;
> +	}
> +
> +	if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> +		(*kicks)++;
> +
> +	return i;
> +}
> +
> +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> +		      int budget)
> +{
> +	u64 bytes = 0, packets = 0, kicks = 0;
> +	int sent;
> +
> +	virtnet_free_old_xmit(sq, true, &bytes, &packets);
> +
> +	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> +
> +	virtnet_xsk_check_queue(sq);
> +
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	u64_stats_add(&sq->stats.packets, packets);
> +	u64_stats_add(&sq->stats.bytes, bytes);
> +	u64_stats_add(&sq->stats.kicks, kicks);
> +	u64_stats_add(&sq->stats.xdp_tx,  sent);
> +	u64_stats_update_end(&sq->stats.syncp);
> +
> +	if (xsk_uses_need_wakeup(pool))
> +		xsk_set_tx_need_wakeup(pool);
> +
> +	return sent == budget;
> +}
> +
>  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
>  				    struct xsk_buff_pool *pool)
>  {
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 1918285c310c..73ca8cd5308b 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -3,5 +3,18 @@
>  #ifndef __XSK_H__
>  #define __XSK_H__
>  
> +#define VIRTIO_XSK_FLAG_OFFSET	4
> +
> +static inline void *virtnet_xsk_to_ptr(u32 len)
> +{
> +	unsigned long p;
> +
> +	p = len << VIRTIO_XSK_FLAG_OFFSET;
> +
> +	return (void *)(p | VIRTIO_XSK_FLAG);
> +}
> +
>  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> +		      int budget);
>  #endif
> -- 
> 2.32.0.3.g01195cf9f


