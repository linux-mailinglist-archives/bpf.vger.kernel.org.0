Return-Path: <bpf+bounces-3139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091673A0AA
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C214E281956
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750E1EA72;
	Thu, 22 Jun 2023 12:15:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEB1E538
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 12:15:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139519BE
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687436115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOOEpKJmbrvrHc4n4U3Z1IinZ+biEmkwBZwWRzwqyDY=;
	b=XENws3HQCURFT8QF3QGvVQvk6zfE70oF8ljgfSxqS43iqG8tKlDSCH0cFpDbwgfyW7sMLa
	koQL88WDJ32g+imm5/XYFItyu87xE/I7AtZ37NLMEbryfM+DwkWqVU8JgEZ6rdi53sCn1C
	IeLB9skO8/sILjFoL2lNcbLCujUzUWQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-q3C2cN3OOn67d6EqwcXxHg-1; Thu, 22 Jun 2023 08:15:13 -0400
X-MC-Unique: q3C2cN3OOn67d6EqwcXxHg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-978a991c3f5so531149866b.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 05:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436112; x=1690028112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOOEpKJmbrvrHc4n4U3Z1IinZ+biEmkwBZwWRzwqyDY=;
        b=jaM61EctKPo1XK+bJpoI8gxCru1OMnxj2At/05UzvYYcqHcwUkbaORf5MJtKF8YgYK
         SL3SOXR5yyrepAv6WfaxBUrM/PdQ2luQ+qQDEwW8H9gDVAFgWrfwoAMjjLGCUSRwjNzw
         4DSc2dWw54oL7JrhobRl9yCoqTz7m071RdktL1Ds51H3DTRLkG8DvV/aB8+3iA3q0MF7
         kec/n6PUtjAA+HDE8wNR3XKPMNCUBxrYE64SHz+hE6Fybp6YeTTObf2BDNgGUT9YKWr3
         rKmHt913mS64YS3wEvSnhQhtX11ocFHuZP6xu8JLKZLcoApJfRwj0l5SjT0vHCkkdiQH
         udYg==
X-Gm-Message-State: AC+VfDwyjK8xDZncaiYk8/O5d87/f13sCDbpbGrPTY1tAMfChh1Of5t3
	uoj78q75FxgRSGynnl6NgDPzSUP6mlAYGi0fhbo8zHPgyok8yiciCmOwxOcq84Bfs5jbadTFos9
	A7Ce+DtlrnveV
X-Received: by 2002:a17:907:1c09:b0:988:2037:c67f with SMTP id nc9-20020a1709071c0900b009882037c67fmr13876544ejc.2.1687436112069;
        Thu, 22 Jun 2023 05:15:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BnGQUmZqH3wCAuqqvKcydV9ctXP25IFw5XPeRVs7XkHzUh7X6H37O1udI3TR+W8xCsVJDaA==
X-Received: by 2002:a17:907:1c09:b0:988:2037:c67f with SMTP id nc9-20020a1709071c0900b009882037c67fmr13876524ejc.2.1687436111729;
        Thu, 22 Jun 2023 05:15:11 -0700 (PDT)
Received: from redhat.com ([2.52.149.110])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00988955f7b5esm4573800ejy.157.2023.06.22.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:15:11 -0700 (PDT)
Date: Thu, 22 Jun 2023 08:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v10 10/10] virtio_net: support dma premapped
Message-ID: <20230622081142-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 05:22:06PM +0800, Xuan Zhuo wrote:
> Introduce the module param "experiment_premapped" to enable the function
> that the virtio-net do dma mapping.
> 
> If that is true, the vq of virtio-net is under the premapped mode.
> It just handle the sg with dma_address. And the driver must get the dma
> address of the buffer to unmap after get the buffer from virtio core.
> 
> That will be useful when AF_XDP is enable, AF_XDP tx and the kernel packet
> xmit will share the tx queue, so the skb xmit must support the premapped
> mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


I put this in next but I don't think this is going upstream
in its current form, certainly not with the experiment_premapped mod config
that no one will know how to enable. If you want to experiment,
keep it in your private tree, experimenting on humans requires
an ethics board approval and consent forms :)

Spreading the "premapped" boolean all of the place is also
far from pretty, I wonder why we can't only specify it when adding.

> ---
>  drivers/net/virtio_net.c | 163 +++++++++++++++++++++++++++++++++------
>  1 file changed, 141 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c0122..5898212fcb3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,10 +26,11 @@
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
>  
> -static bool csum = true, gso = true, napi_tx = true;
> +static bool csum = true, gso = true, napi_tx = true, experiment_premapped;
>  module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
> +module_param(experiment_premapped, bool, 0644);
>  
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> @@ -142,6 +143,9 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	/* The vq is premapped mode. */
> +	bool premapped;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -174,6 +178,9 @@ struct receive_queue {
>  	char name[16];
>  
>  	struct xdp_rxq_info xdp_rxq;
> +
> +	/* The vq is premapped mode. */
> +	bool premapped;
>  };
>  
>  /* This structure can contain rss message with maximum settings for indirection table and keysize
> @@ -546,6 +553,105 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	return skb;
>  }
>  
> +static int virtnet_generic_unmap(struct virtqueue *vq, struct virtqueue_detach_cursor *cursor)
> +{
> +	enum dma_data_direction dir;
> +	dma_addr_t addr;
> +	u32 len;
> +	int err;
> +
> +	do {
> +		err = virtqueue_detach(vq, cursor, &addr, &len, &dir);
> +		if (!err || err == -EAGAIN)
> +			dma_unmap_page_attrs(virtqueue_dma_dev(vq), addr, len, dir, 0);
> +
> +	} while (err == -EAGAIN);
> +
> +	return err;
> +}
> +
> +static void *virtnet_detach_unused_buf(struct virtqueue *vq, bool premapped)
> +{
> +	struct virtqueue_detach_cursor cursor;
> +	void *buf;
> +
> +	if (!premapped)
> +		return virtqueue_detach_unused_buf(vq);
> +
> +	buf = virtqueue_detach_unused_buf_premapped(vq, &cursor);
> +	if (buf)
> +		virtnet_generic_unmap(vq, &cursor);
> +
> +	return buf;
> +}
> +
> +static void *virtnet_get_buf_ctx(struct virtqueue *vq, bool premapped, u32 *len, void **ctx)
> +{
> +	struct virtqueue_detach_cursor cursor;
> +	void *buf;
> +
> +	if (!premapped)
> +		return virtqueue_get_buf_ctx(vq, len, ctx);
> +
> +	buf = virtqueue_get_buf_premapped(vq, len, ctx, &cursor);
> +	if (buf)
> +		virtnet_generic_unmap(vq, &cursor);
> +
> +	return buf;
> +}
> +
> +#define virtnet_rq_get_buf(rq, plen, pctx) \
> +({ \
> +	typeof(rq) _rq = (rq); \
> +	virtnet_get_buf_ctx(_rq->vq, _rq->premapped, plen, pctx); \
> +})
> +
> +#define virtnet_sq_get_buf(sq, plen, pctx) \
> +({ \
> +	typeof(sq) _sq = (sq); \
> +	virtnet_get_buf_ctx(_sq->vq, _sq->premapped, plen, pctx); \
> +})
> +
> +static int virtnet_add_sg(struct virtqueue *vq, bool premapped,
> +			  struct scatterlist *sg, unsigned int num, bool out,
> +			  void *data, void *ctx, gfp_t gfp)
> +{
> +	enum dma_data_direction dir;
> +	struct device *dev;
> +	int err, ret;
> +
> +	if (!premapped)
> +		return virtqueue_add_sg(vq, sg, num, out, data, ctx, gfp);
> +
> +	dir = out ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +	dev = virtqueue_dma_dev(vq);
> +
> +	ret = dma_map_sg_attrs(dev, sg, num, dir, 0);
> +	if (ret != num)
> +		goto err;
> +
> +	err = virtqueue_add_sg(vq, sg, num, out, data, ctx, gfp);
> +	if (err < 0)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	dma_unmap_sg_attrs(dev, sg, num, dir, 0);
> +	return -ENOMEM;
> +}
> +
> +static int virtnet_add_outbuf(struct send_queue *sq, unsigned int num, void *data)
> +{
> +	return virtnet_add_sg(sq->vq, sq->premapped, sq->sg, num, true, data, NULL, GFP_ATOMIC);
> +}
> +
> +static int virtnet_add_inbuf(struct receive_queue *rq, unsigned int num, void *data,
> +			     void *ctx, gfp_t gfp)
> +{
> +	return virtnet_add_sg(rq->vq, rq->premapped, rq->sg, num, false, data, ctx, gfp);
> +}
> +
>  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>  {
>  	unsigned int len;
> @@ -553,7 +659,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>  	unsigned int bytes = 0;
>  	void *ptr;
>  
> -	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> +	while ((ptr = virtnet_sq_get_buf(sq, &len, NULL)) != NULL) {
>  		if (likely(!is_xdp_frame(ptr))) {
>  			struct sk_buff *skb = ptr;
>  
> @@ -667,8 +773,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  			    skb_frag_size(frag), skb_frag_off(frag));
>  	}
>  
> -	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -				   xdp_to_ptr(xdpf), GFP_ATOMIC);
> +	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>  	if (unlikely(err))
>  		return -ENOSPC; /* Caller handle free/refcnt */
>  
> @@ -744,7 +849,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  
>  	/* Free up any pending old buffers before queueing new ones. */
> -	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> +	while ((ptr = virtnet_sq_get_buf(sq, &len, NULL)) != NULL) {
>  		if (likely(is_xdp_frame(ptr))) {
>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>  
> @@ -828,7 +933,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  		void *buf;
>  		int off;
>  
> -		buf = virtqueue_get_buf(rq->vq, &buflen);
> +		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
>  		if (unlikely(!buf))
>  			goto err_buf;
>  
> @@ -1119,7 +1224,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  		return -EINVAL;
>  
>  	while (--*num_buf > 0) {
> -		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> +		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>  		if (unlikely(!buf)) {
>  			pr_debug("%s: rx error: %d buffers out of %d missing\n",
>  				 dev->name, *num_buf,
> @@ -1344,7 +1449,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	while (--num_buf) {
>  		int num_skb_frags;
>  
> -		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> +		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>  		if (unlikely(!buf)) {
>  			pr_debug("%s: rx error: %d buffers out of %d missing\n",
>  				 dev->name, num_buf,
> @@ -1407,7 +1512,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  err_skb:
>  	put_page(page);
>  	while (num_buf-- > 1) {
> -		buf = virtqueue_get_buf(rq->vq, &len);
> +		buf = virtnet_rq_get_buf(rq, &len, NULL);
>  		if (unlikely(!buf)) {
>  			pr_debug("%s: rx error: %d buffers missing\n",
>  				 dev->name, num_buf);
> @@ -1534,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	alloc_frag->offset += len;
>  	sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
>  		    vi->hdr_len + GOOD_PACKET_LEN);
> -	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> +	err = virtnet_add_inbuf(rq, 1, buf, ctx, gfp);
>  	if (err < 0)
>  		put_page(virt_to_head_page(buf));
>  	return err;
> @@ -1581,8 +1686,8 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>  
>  	/* chain first in list head */
>  	first->private = (unsigned long)list;
> -	err = virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_skbfrags + 2,
> -				  first, gfp);
> +	err = virtnet_add_inbuf(rq, vi->big_packets_num_skbfrags + 2,
> +				first, NULL, gfp);
>  	if (err < 0)
>  		give_pages(rq, first);
>  
> @@ -1645,7 +1750,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  
>  	sg_init_one(rq->sg, buf, len);
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
> -	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> +	err = virtnet_add_inbuf(rq, 1, buf, ctx, gfp);
>  	if (err < 0)
>  		put_page(virt_to_head_page(buf));
>  
> @@ -1768,13 +1873,13 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		void *ctx;
>  
>  		while (stats.packets < budget &&
> -		       (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
> +		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
>  			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
>  			stats.packets++;
>  		}
>  	} else {
>  		while (stats.packets < budget &&
> -		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> +		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
>  			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
>  			stats.packets++;
>  		}
> @@ -1984,7 +2089,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  			return num_sg;
>  		num_sg++;
>  	}
> -	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
> +	return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>  
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -3552,15 +3657,17 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		struct virtqueue *vq = vi->sq[i].vq;
> -		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> -			virtnet_sq_free_unused_buf(vq, buf);
> +		struct send_queue *sq = &vi->sq[i];
> +
> +		while ((buf = virtnet_detach_unused_buf(sq->vq, sq->premapped)) != NULL)
> +			virtnet_sq_free_unused_buf(sq->vq, buf);
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		struct virtqueue *vq = vi->rq[i].vq;
> -		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> -			virtnet_rq_free_unused_buf(vq, buf);
> +		struct receive_queue *rq = &vi->rq[i];
> +
> +		while ((buf = virtnet_detach_unused_buf(rq->vq, rq->premapped)) != NULL)
> +			virtnet_rq_free_unused_buf(rq->vq, buf);
>  	}
>  }
>  
> @@ -3658,6 +3765,18 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		vi->rq[i].vq = vqs[rxq2vq(i)];
>  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>  		vi->sq[i].vq = vqs[txq2vq(i)];
> +
> +		if (experiment_premapped) {
> +			if (!virtqueue_set_premapped(vi->rq[i].vq))
> +				vi->rq[i].premapped = true;
> +			else
> +				netdev_warn(vi->dev, "RXQ (%d) enable premapped failure.\n", i);
> +
> +			if (!virtqueue_set_premapped(vi->sq[i].vq))
> +				vi->sq[i].premapped = true;
> +			else
> +				netdev_warn(vi->dev, "TXQ (%d) enable premapped failure.\n", i);
> +		}
>  	}
>  
>  	/* run here: ret == 0. */
> -- 
> 2.32.0.3.g01195cf9f


