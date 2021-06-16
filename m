Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE253A960F
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhFPJ24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 05:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhFPJ2z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 05:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623835609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RW3o2HEy7SyzLUmjGnLmHDNB/DJgysCOrmXEWJSfZLs=;
        b=fJLqiFcANiFcR63LQMTUBf5kZscpdGWIdxna07wP0M+gNVz77//a2MSaYuLnD65UURAAPe
        evRtGJGE7Z10p+B+Hsf2n1ONb12mUp4FeKo6XtQxAdcJLJb2HlT7YQfb9+qc5uiMSB3+Wu
        UDhk4VZwjP9GQtRp+rN1iYliZ1lhjtw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-OT1rwqHOOEibA1-oWy80pg-1; Wed, 16 Jun 2021 05:26:48 -0400
X-MC-Unique: OT1rwqHOOEibA1-oWy80pg-1
Received: by mail-pg1-f199.google.com with SMTP id k193-20020a633dca0000b029021ff326b222so1119295pga.9
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 02:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RW3o2HEy7SyzLUmjGnLmHDNB/DJgysCOrmXEWJSfZLs=;
        b=KEoR3j/TUbJyPYolsP/JENH3SKkgvVsE8W4Q4u+j4I5bNFNANR3gee3u1k0dEP7W8+
         EOtTcg8C7p1qLJHUAsgmKUDIw2crtSxgwiW4+4YvlAGIVYBDmcSQh8Z/Pqa+1IYvFw3H
         GWMWRg8WPinnTTZQcXmYqQEjuHXwgXUU7PyQ/QO6gxnI4bh50LQN8N8/v7uNhmabFNqH
         G+kONzfkaPtOupbySbCsu0jItd7jBoIqE+hkC7SNU0iEXJKI6XV3wMxoeVrLjwKS0nxH
         KyWbe8+7c+TX5zLwVmltIv9/UZ9O1CpxTUTf7dY99pJ6Y1UNWs2B2IxqOhGWTDpAHBo8
         Fd7A==
X-Gm-Message-State: AOAM533MOtNSbhvZVym0gMTTP47pQekpLn64xxrKxEvGceTnnvOW01R2
        h3Wsmswsj1Jm0Jly9Pwiop5EGNjeZnsvQ4GSKnQpfIBgs6hSwTlV//QBCFS7BL6i0FdePvZpKwx
        Rak79+WF4B1kA
X-Received: by 2002:a17:902:9006:b029:107:394a:387 with SMTP id a6-20020a1709029006b0290107394a0387mr7997054plp.35.1623835605708;
        Wed, 16 Jun 2021 02:26:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEJ42y2sE35k74Q+Nctex4+yH8HLQmbZfHrBUlaSUqNZemHWxeVundizfyeLItBIHst18R3w==
X-Received: by 2002:a17:902:9006:b029:107:394a:387 with SMTP id a6-20020a1709029006b0290107394a0387mr7997030plp.35.1623835605279;
        Wed, 16 Jun 2021 02:26:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bg16sm1701165pjb.16.2021.06.16.02.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 02:26:44 -0700 (PDT)
Subject: Re: [PATCH net-next v5 12/15] virtio-net: support AF_XDP zc tx
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        "dust . li" <dust.li@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-13-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <99116ba9-9c17-a519-471d-98ae96d049d9@redhat.com>
Date:   Wed, 16 Jun 2021 17:26:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-13-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2021/6/10 下午4:22, Xuan Zhuo 写道:
> AF_XDP(xdp socket, xsk) is a high-performance packet receiving and
> sending technology.
>
> This patch implements the binding and unbinding operations of xsk and
> the virtio-net queue for xsk zero copy xmit.
>
> The xsk zero copy xmit depends on tx napi. Because the actual sending
> of data is done in the process of tx napi. If tx napi does not
> work, then the data of the xsk tx queue will not be sent.
> So if tx napi is not true, an error will be reported when bind xsk.
>
> If xsk is active, it will prevent ethtool from modifying tx napi.
>
> When reclaiming ptr, a new type of ptr is added, which is distinguished
> based on the last two digits of ptr:
> 00: skb
> 01: xdp frame
> 10: xsk xmit ptr
>
> All sent xsk packets share the virtio-net header of xsk_hdr. If xsk
> needs to support csum and other functions later, consider assigning xsk
> hdr separately for each sent packet.
>
> Different from other physical network cards, you can reinitialize the
> channel when you bind xsk. And vrtio does not support independent reset
> channel, you can only reset the entire device. I think it is not
> appropriate for us to directly reset the entire setting. So the
> situation becomes a bit more complicated. We have to consider how
> to deal with the buffer referenced in vq after xsk is unbind.
>
> I added the ring size struct virtnet_xsk_ctx when xsk been bind. Each xsk
> buffer added to vq corresponds to a ctx. This ctx is used to record the
> page where the xsk buffer is located, and add a page reference. When the
> buffer is recycling, reduce the reference to page. When xsk has been
> unbind, and all related xsk buffers have been recycled, release all ctx.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>   drivers/net/virtio/Makefile     |   1 +
>   drivers/net/virtio/virtio_net.c |  20 +-
>   drivers/net/virtio/virtio_net.h |  37 +++-
>   drivers/net/virtio/xsk.c        | 346 ++++++++++++++++++++++++++++++++
>   drivers/net/virtio/xsk.h        |  99 +++++++++
>   5 files changed, 497 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/net/virtio/xsk.c
>   create mode 100644 drivers/net/virtio/xsk.h
>
> diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> index ccc80f40f33a..db79d2e7925f 100644
> --- a/drivers/net/virtio/Makefile
> +++ b/drivers/net/virtio/Makefile
> @@ -4,3 +4,4 @@
>   #
>   
>   obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> +obj-$(CONFIG_VIRTIO_NET) += xsk.o
> diff --git a/drivers/net/virtio/virtio_net.c b/drivers/net/virtio/virtio_net.c
> index 395ec1f18331..40d7751f1c5f 100644
> --- a/drivers/net/virtio/virtio_net.c
> +++ b/drivers/net/virtio/virtio_net.c
> @@ -1423,6 +1423,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>   
>   	txq = netdev_get_tx_queue(vi->dev, index);
>   	__netif_tx_lock(txq, raw_smp_processor_id());
> +	work_done += virtnet_poll_xsk(sq, budget);
>   	free_old_xmit(sq, true);
>   	__netif_tx_unlock(txq);
>   
> @@ -2133,8 +2134,16 @@ static int virtnet_set_coalesce(struct net_device *dev,
>   	if (napi_weight ^ vi->sq[0].napi.weight) {
>   		if (dev->flags & IFF_UP)
>   			return -EBUSY;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			/* xsk xmit depend on the tx napi. So if xsk is active,
> +			 * prevent modifications to tx napi.
> +			 */
> +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> +				continue;


So this can result tx NAPI is used by some queues buy not the others. I 
think such inconsistency breaks the semantic of set_coalesce() which 
assumes the operation is done at the device not some specific queues.

How about just fail here?


> +
>   			vi->sq[i].napi.weight = napi_weight;
> +		}
>   	}
>   
>   	return 0;
> @@ -2407,6 +2416,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   	switch (xdp->command) {
>   	case XDP_SETUP_PROG:
>   		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> +	case XDP_SETUP_XSK_POOL:
> +		return virtnet_xsk_pool_setup(dev, xdp);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -2466,6 +2477,7 @@ static const struct net_device_ops virtnet_netdev = {
>   	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
>   	.ndo_bpf		= virtnet_xdp,
>   	.ndo_xdp_xmit		= virtnet_xdp_xmit,
> +	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
>   	.ndo_features_check	= passthru_features_check,
>   	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>   	.ndo_set_features	= virtnet_set_features,
> @@ -2569,10 +2581,12 @@ static void free_unused_bufs(struct virtnet_info *vi)
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>   		struct virtqueue *vq = vi->sq[i].vq;
>   		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
> -			if (!is_xdp_frame(buf))
> +			if (is_skb_ptr(buf))
>   				dev_kfree_skb(buf);
> -			else
> +			else if (is_xdp_frame(buf))
>   				xdp_return_frame(ptr_to_xdp(buf));
> +			else
> +				virtnet_xsk_ctx_tx_put(ptr_to_xsk(buf));
>   		}
>   	}
>   
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index 931cc81f92fb..e3da829887dc 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -135,6 +135,16 @@ struct send_queue {
>   	struct virtnet_sq_stats stats;
>   
>   	struct napi_struct napi;
> +
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +
> +		/* xsk wait for tx inter or softirq */
> +		bool need_wakeup;
> +
> +		/* ctx used to record the page added to vq */
> +		struct virtnet_xsk_ctx_head *ctx_head;
> +	} xsk;
>   };
>   
>   /* Internal representation of a receive virtqueue */
> @@ -188,6 +198,13 @@ static inline void virtqueue_napi_schedule(struct napi_struct *napi,
>   	}
>   }
>   
> +#include "xsk.h"
> +
> +static inline bool is_skb_ptr(void *ptr)
> +{
> +	return !((unsigned long)ptr & (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG));
> +}
> +
>   static inline bool is_xdp_frame(void *ptr)
>   {
>   	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> @@ -206,25 +223,39 @@ static inline struct xdp_frame *ptr_to_xdp(void *ptr)
>   static inline void __free_old_xmit(struct send_queue *sq, bool in_napi,
>   				   struct virtnet_sq_stats *stats)
>   {
> +	unsigned int xsknum = 0;
>   	unsigned int len;
>   	void *ptr;
>   
>   	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		if (!is_xdp_frame(ptr)) {
> +		if (is_skb_ptr(ptr)) {
>   			struct sk_buff *skb = ptr;
>   
>   			pr_debug("Sent skb %p\n", skb);
>   
>   			stats->bytes += skb->len;
>   			napi_consume_skb(skb, in_napi);
> -		} else {
> +		} else if (is_xdp_frame(ptr)) {
>   			struct xdp_frame *frame = ptr_to_xdp(ptr);
>   
>   			stats->bytes += frame->len;
>   			xdp_return_frame(frame);
> +		} else {
> +			struct virtnet_xsk_ctx_tx *ctx;
> +
> +			ctx = ptr_to_xsk(ptr);
> +
> +			/* Maybe this ptr was sent by the last xsk. */
> +			if (ctx->ctx.head->active)
> +				++xsknum;
> +
> +			stats->bytes += ctx->len;
> +			virtnet_xsk_ctx_tx_put(ctx);
>   		}
>   		stats->packets++;
>   	}
> -}
>   
> +	if (xsknum)
> +		virtnet_xsk_complete(sq, xsknum);
> +}
>   #endif
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> new file mode 100644
> index 000000000000..f98b68576709
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * virtio-net xsk
> + */
> +
> +#include "virtio_net.h"
> +
> +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> +
> +static struct virtnet_xsk_ctx *virtnet_xsk_ctx_get(struct virtnet_xsk_ctx_head *head)
> +{
> +	struct virtnet_xsk_ctx *ctx;
> +
> +	ctx = head->ctx;
> +	head->ctx = ctx->next;
> +
> +	++head->ref;
> +
> +	return ctx;
> +}
> +
> +#define virtnet_xsk_ctx_tx_get(head) ((struct virtnet_xsk_ctx_tx *)virtnet_xsk_ctx_get(head))
> +
> +static void virtnet_xsk_check_queue(struct send_queue *sq)
> +{
> +	struct virtnet_info *vi = sq->vq->vdev->priv;
> +	struct net_device *dev = vi->dev;
> +	int qnum = sq - vi->sq;
> +
> +	/* If it is a raw buffer queue, it does not check whether the status
> +	 * of the queue is stopped when sending. So there is no need to check
> +	 * the situation of the raw buffer queue.
> +	 */
> +	if (is_xdp_raw_buffer_queue(vi, qnum))
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
> +		netif_stop_subqueue(dev, qnum);
> +}
> +
> +void virtnet_xsk_complete(struct send_queue *sq, u32 num)
> +{
> +	struct xsk_buff_pool *pool;
> +
> +	rcu_read_lock();
> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (!pool) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	xsk_tx_completed(pool, num);
> +	rcu_read_unlock();
> +
> +	if (sq->xsk.need_wakeup) {
> +		sq->xsk.need_wakeup = false;
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +	}
> +}
> +
> +static int virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> +			    struct xdp_desc *desc)
> +{
> +	struct virtnet_xsk_ctx_tx *ctx;
> +	struct virtnet_info *vi;
> +	u32 offset, n, len;
> +	struct page *page;
> +	void *data;
> +
> +	vi = sq->vq->vdev->priv;
> +
> +	data = xsk_buff_raw_get_data(pool, desc->addr);
> +	offset = offset_in_page(data);
> +
> +	ctx = virtnet_xsk_ctx_tx_get(sq->xsk.ctx_head);
> +
> +	/* xsk unaligned mode, desc may use two pages */
> +	if (desc->len > PAGE_SIZE - offset)
> +		n = 3;
> +	else
> +		n = 2;
> +
> +	sg_init_table(sq->sg, n);
> +	sg_set_buf(sq->sg, &xsk_hdr, vi->hdr_len);
> +
> +	/* handle for xsk first page */
> +	len = min_t(int, desc->len, PAGE_SIZE - offset);
> +	page = vmalloc_to_page(data);
> +	sg_set_page(sq->sg + 1, page, len, offset);
> +
> +	/* ctx is used to record and reference this page to prevent xsk from
> +	 * being released before this xmit is recycled
> +	 */


I'm a little bit surprised that this is done manually per device instead 
of doing it in xsk core.


> +	ctx->ctx.page = page;
> +	get_page(page);
> +
> +	/* xsk unaligned mode, handle for the second page */
> +	if (len < desc->len) {
> +		page = vmalloc_to_page(data + len);
> +		len = min_t(int, desc->len - len, PAGE_SIZE);
> +		sg_set_page(sq->sg + 2, page, len, 0);
> +
> +		ctx->ctx.page_unaligned = page;
> +		get_page(page);
> +	} else {
> +		ctx->ctx.page_unaligned = NULL;
> +	}
> +
> +	return virtqueue_add_outbuf(sq->vq, sq->sg, n,
> +				   xsk_to_ptr(ctx), GFP_ATOMIC);
> +}
> +
> +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> +				  struct xsk_buff_pool *pool,
> +				  unsigned int budget,
> +				  bool in_napi, int *done,
> +				  struct virtnet_sq_stats *stats)
> +{
> +	struct xdp_desc desc;
> +	int err, packet = 0;
> +	int ret = -EAGAIN;
> +
> +	while (budget-- > 0) {
> +		if (sq->vq->num_free < 2 + MAX_SKB_FRAGS) {


AF_XDP doesn't use skb, so I don't see why MAX_SKB_FRAGS is used.

Looking at virtnet_xsk_xmit(), it looks to me 3 is more suitable here. 
Or did AF_XDP core can handle queue full gracefully then we don't even 
need to worry about this?


> +			ret = -EBUSY;


-ENOSPC looks better.


> +			break;
> +		}
> +
> +		if (!xsk_tx_peek_desc(pool, &desc)) {
> +			/* done */
> +			ret = 0;
> +			break;
> +		}
> +
> +		err = virtnet_xsk_xmit(sq, pool, &desc);
> +		if (unlikely(err)) {


If we always reserve sufficient slots, this should be an unexpected 
error, do we need log this as what has been done in start_xmit()?

         /* This should not happen! */
         if (unlikely(err)) {
                 dev->stats.tx_fifo_errors++;
                 if (net_ratelimit())
                         dev_warn(&dev->dev,
                                  "Unexpected TXQ (%d) queue failure: %d\n",
                                  qnum, err);


> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		++packet;
> +	}
> +
> +	if (packet) {
> +		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> +			++stats->kicks;
> +
> +		*done += packet;
> +		stats->xdp_tx += packet;
> +
> +		xsk_tx_release(pool);
> +	}
> +
> +	return ret;
> +}
> +
> +static int virtnet_xsk_run(struct send_queue *sq, struct xsk_buff_pool *pool,
> +			   int budget, bool in_napi)
> +{
> +	struct virtnet_sq_stats stats = {};
> +	int done = 0;
> +	int err;
> +
> +	sq->xsk.need_wakeup = false;
> +	__free_old_xmit(sq, in_napi, &stats);
> +
> +	/* return err:
> +	 * -EAGAIN: done == budget
> +	 * -EBUSY:  done < budget
> +	 *  0    :  done < budget
> +	 */


It's better to move the comment to the implementation of 
virtnet_xsk_xmit_batch().


> +xmit:
> +	err = virtnet_xsk_xmit_batch(sq, pool, budget - done, in_napi,
> +				     &done, &stats);
> +	if (err == -EBUSY) {
> +		__free_old_xmit(sq, in_napi, &stats);
> +
> +		/* If the space is enough, let napi run again. */
> +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)


The comment does not match the code.


> +			goto xmit;
> +		else
> +			sq->xsk.need_wakeup = true;
> +	}
> +
> +	virtnet_xsk_check_queue(sq);
> +
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	sq->stats.packets += stats.packets;
> +	sq->stats.bytes += stats.bytes;
> +	sq->stats.kicks += stats.kicks;
> +	sq->stats.xdp_tx += stats.xdp_tx;
> +	u64_stats_update_end(&sq->stats.syncp);
> +
> +	return done;
> +}
> +
> +int virtnet_poll_xsk(struct send_queue *sq, int budget)
> +{
> +	struct xsk_buff_pool *pool;
> +	int work_done = 0;
> +
> +	rcu_read_lock();
> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (pool)
> +		work_done = virtnet_xsk_run(sq, pool, budget, true);
> +	rcu_read_unlock();
> +	return work_done;
> +}
> +
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct xsk_buff_pool *pool;
> +	struct send_queue *sq;
> +
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;


I wonder how we can hit this check. Note that we prevent the user from 
modifying queue pairs when XDP is enabled:

         /* For now we don't support modifying channels while XDP is loaded
          * also when XDP is loaded all RX queues have XDP programs so 
we only
          * need to check a single RX queue.
          */
         if (vi->rq[0].xdp_prog)
                 return -EINVAL;

> +
> +	sq = &vi->sq[qid];
> +
> +	rcu_read_lock();


Can we simply use rcu_read_lock_bh() here?


> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (pool) {
> +		local_bh_disable();
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +		local_bh_enable();
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static struct virtnet_xsk_ctx_head *virtnet_xsk_ctx_alloc(struct xsk_buff_pool *pool,
> +							  struct virtqueue *vq)
> +{
> +	struct virtnet_xsk_ctx_head *head;
> +	u32 size, n, ring_size, ctx_sz;
> +	struct virtnet_xsk_ctx *ctx;
> +	void *p;
> +
> +	ctx_sz = sizeof(struct virtnet_xsk_ctx_tx);
> +
> +	ring_size = virtqueue_get_vring_size(vq);
> +	size = sizeof(*head) + ctx_sz * ring_size;
> +
> +	head = kmalloc(size, GFP_ATOMIC);
> +	if (!head)
> +		return NULL;
> +
> +	memset(head, 0, sizeof(*head));
> +
> +	head->active = true;
> +	head->frame_size = xsk_pool_get_rx_frame_size(pool);
> +
> +	p = head + 1;
> +	for (n = 0; n < ring_size; ++n) {
> +		ctx = p;
> +		ctx->head = head;
> +		ctx->next = head->ctx;
> +		head->ctx = ctx;
> +
> +		p += ctx_sz;
> +	}
> +
> +	return head;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +				   struct xsk_buff_pool *pool,
> +				   u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct send_queue *sq;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +
> +	/* xsk zerocopy depend on the tx napi.
> +	 *
> +	 * All data is actually consumed and sent out from the xsk tx queue
> +	 * under the tx napi mechanism.
> +	 */
> +	if (!sq->napi.weight)
> +		return -EPERM;
> +
> +	memset(&sq->xsk, 0, sizeof(sq->xsk));
> +
> +	sq->xsk.ctx_head = virtnet_xsk_ctx_alloc(pool, sq->vq);
> +	if (!sq->xsk.ctx_head)
> +		return -ENOMEM;
> +
> +	/* Here is already protected by rtnl_lock, so rcu_assign_pointer is
> +	 * safe.
> +	 */
> +	rcu_assign_pointer(sq->xsk.pool, pool);
> +
> +	return 0;
> +}
> +
> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct send_queue *sq;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +
> +	/* Here is already protected by rtnl_lock, so rcu_assign_pointer is
> +	 * safe.
> +	 */
> +	rcu_assign_pointer(sq->xsk.pool, NULL);
> +
> +	/* Sync with the XSK wakeup and with NAPI. */
> +	synchronize_net();
> +
> +	if (READ_ONCE(sq->xsk.ctx_head->ref))
> +		WRITE_ONCE(sq->xsk.ctx_head->active, false);
> +	else
> +		kfree(sq->xsk.ctx_head);
> +
> +	sq->xsk.ctx_head = NULL;
> +
> +	return 0;
> +}
> +
> +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	if (xdp->xsk.pool)
> +		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> +					       xdp->xsk.queue_id);
> +	else
> +		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> +}
> +
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> new file mode 100644
> index 000000000000..54948e0b07fc
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __XSK_H__
> +#define __XSK_H__
> +
> +#define VIRTIO_XSK_FLAG	BIT(1)
> +
> +/* When xsk disable, under normal circumstances, the network card must reclaim
> + * all the memory that has been sent and the memory added to the rq queue by
> + * destroying the queue.
> + *
> + * But virtio's queue does not support separate setting to been disable.


This is a call for us to implement per queue enable/disable. Virtio-mmio 
has such facility but virtio-pci only allow to disable a queue (not enable).


> "Reset"
> + * is not very suitable.
> + *
> + * The method here is that each sent chunk or chunk added to the rq queue is
> + * described by an independent structure struct virtnet_xsk_ctx.
> + *
> + * We will use get_page(page) to refer to the page where these chunks are
> + * located. And these pages will be recorded in struct virtnet_xsk_ctx. So these
> + * chunks in vq are safe. When recycling, put the these page.
> + *
> + * These structures point to struct virtnet_xsk_ctx_head, and ref records how
> + * many chunks have not been reclaimed. If active == 0, it means that xsk has
> + * been disabled.
> + *
> + * In this way, even if xsk has been unbundled with rq/sq, or a new xsk and
> + * rq/sq  are bound, and a new virtnet_xsk_ctx_head is created. It will not
> + * affect the old virtnet_xsk_ctx to be recycled. And free all head and ctx when
> + * ref is 0.


This looks complicated and it will increase the footprint. Consider the 
performance penalty and the complexity, I would suggest to use reset 
instead.

Then we don't need to introduce such context.

Thanks


> + */
> +struct virtnet_xsk_ctx;
> +struct virtnet_xsk_ctx_head {
> +	struct virtnet_xsk_ctx *ctx;
> +
> +	/* how many ctx has been add to vq */
> +	u64 ref;
> +
> +	unsigned int frame_size;
> +
> +	/* the xsk status */
> +	bool active;
> +};
> +
> +struct virtnet_xsk_ctx {
> +	struct virtnet_xsk_ctx_head *head;
> +	struct virtnet_xsk_ctx *next;
> +
> +	struct page *page;
> +
> +	/* xsk unaligned mode will use two page in one desc */
> +	struct page *page_unaligned;
> +};
> +
> +struct virtnet_xsk_ctx_tx {
> +	/* this *MUST* be the first */
> +	struct virtnet_xsk_ctx ctx;
> +
> +	/* xsk tx xmit use this record the len of packet */
> +	u32 len;
> +};
> +
> +static inline void *xsk_to_ptr(struct virtnet_xsk_ctx_tx *ctx)
> +{
> +	return (void *)((unsigned long)ctx | VIRTIO_XSK_FLAG);
> +}
> +
> +static inline struct virtnet_xsk_ctx_tx *ptr_to_xsk(void *ptr)
> +{
> +	unsigned long p;
> +
> +	p = (unsigned long)ptr;
> +	return (struct virtnet_xsk_ctx_tx *)(p & ~VIRTIO_XSK_FLAG);
> +}
> +
> +static inline void virtnet_xsk_ctx_put(struct virtnet_xsk_ctx *ctx)
> +{
> +	put_page(ctx->page);
> +	if (ctx->page_unaligned)
> +		put_page(ctx->page_unaligned);
> +
> +	--ctx->head->ref;
> +
> +	if (ctx->head->active) {
> +		ctx->next = ctx->head->ctx;
> +		ctx->head->ctx = ctx;
> +	} else {
> +		if (!ctx->head->ref)
> +			kfree(ctx->head);
> +	}
> +}
> +
> +#define virtnet_xsk_ctx_tx_put(ctx) \
> +	virtnet_xsk_ctx_put((struct virtnet_xsk_ctx *)ctx)
> +
> +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> +int virtnet_poll_xsk(struct send_queue *sq, int budget);
> +void virtnet_xsk_complete(struct send_queue *sq, u32 num);
> +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> +#endif

