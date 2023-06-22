Return-Path: <bpf+bounces-3184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF973A8FE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE9281AC8
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474842107A;
	Thu, 22 Jun 2023 19:29:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2EB20690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 19:29:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3EE199B
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687462183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRta8SsE0Tw8cuva/KyRbcchl8Lyz8QZEEZxUtPCkDI=;
	b=NmzFkYE2wnjH0A2Zl6PQm27HDf6BTUl/xq/mCtjOmrEr0YxGMESbrwbevCSEBvM6JNqlTt
	a6ZQHL3jqpfLTV1LUhNBRCKQPq4/GSpW0k7lfB7dvePGZQhijx4CjlK/Gu6MULR0hDhYDs
	LOyAKCXhZRbuSRddjno8UPYpQTd1nVM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-8qx8xlmbMwiUL2kBthOz0g-1; Thu, 22 Jun 2023 15:29:40 -0400
X-MC-Unique: 8qx8xlmbMwiUL2kBthOz0g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31275586740so2264799f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 12:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687462176; x=1690054176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRta8SsE0Tw8cuva/KyRbcchl8Lyz8QZEEZxUtPCkDI=;
        b=AlrvbgWxs22ZmwSXptjKjh6r0rZaeox8W+/+hfgAARQMM2XHJ0uAVroAa969pxFGBK
         10LQeB/JaElgCNB8R/nkTGLohRTLsUQF6+EVygMDMo4tcZD9UmdeOI0iqEcyYKhFfYCN
         8s5bU0f27P+zEy+KM5VseEfbTSUMVIn6MfsvxAhlnQR33Ro6BHPgbyKdxWXoEIut9Vl1
         htnp7+S59MkSMag0QRSNeCQwTXJBPPXJbOEnagGS/5MX2uA2qt/uEzmZSlTdmLxNQ3iN
         AcBAZU28+uDuaUcEfjGLFUU/JlYQX2ga0/6IjtyPKLLrjyR3AetjP0+Y5YMLcppFZQ/S
         qMPQ==
X-Gm-Message-State: AC+VfDx7WOJe0WL20/PPXQa/vxouKf2pmTlXxZQXdOeGN1gEuOZDki2S
	sIAcx2dseP6Vts8Ob9AIE+EwVcO/iHvmkizb3g5bciEkXlPN7TX6Ab3m2+BBXUTNaTqZQIDLYVI
	IijmgvLQ1V8Jx
X-Received: by 2002:a5d:42d1:0:b0:30f:c1c3:8173 with SMTP id t17-20020a5d42d1000000b0030fc1c38173mr17909652wrr.26.1687462175951;
        Thu, 22 Jun 2023 12:29:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xcIvnNjmGvUcreU3fwq+Rc/TGChTJuWomOUUnVEYj+cZqBphH0cW7wMuv7XWbbdtLBODECg==
X-Received: by 2002:a5d:42d1:0:b0:30f:c1c3:8173 with SMTP id t17-20020a5d42d1000000b0030fc1c38173mr17909641wrr.26.1687462175610;
        Thu, 22 Jun 2023 12:29:35 -0700 (PDT)
Received: from redhat.com ([2.52.149.110])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d56c9000000b0030fb4b55c13sm7667369wrw.96.2023.06.22.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:29:34 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:29:31 -0400
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
Subject: Re: [PATCH vhost v10 07/10] virtio_ring: introduce helpers for
 premapped
Message-ID: <20230622152420-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602092206.50108-8-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 05:22:03PM +0800, Xuan Zhuo wrote:
> This patch introduces three helpers for premapped mode.
> 
> * virtqueue_get_buf_premapped
> * virtqueue_detach_unused_buf_premapped
> 
> The above helpers work like the non-premapped funcs. But a cursor is
> passed.
> 
> virtqueue_detach is used to get the dma info of the last buf by
>   cursor.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 83 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       | 10 +++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbc22daae7e1..6771b9661798 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2555,6 +2555,66 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  	return virtqueue_get_buf_ctx(_vq, len, NULL);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf);
> +
> +/**
> + * virtqueue_get_buf_premapped - get the next used buffer
> + * @_vq: the struct virtqueue we're talking about.
> + * @len: the length written into the buffer
> + * @ctx: extra context for the token
> + * @cursor: detach cursor
> + *
> + * If the device wrote data into the buffer, @len will be set to the
> + * amount written.  This means you don't need to clear the buffer
> + * beforehand to ensure there's no data leakage in the case of short
> + * writes.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * This is used for the premapped vq. The cursor is passed by the dirver, that
> + * is used for virtqueue_detach. That will be initialized by virtio core
> + * internally.

initialized how?

> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> +				  void **ctx,
> +				  struct virtqueue_detach_cursor *cursor)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx, cursor) :
> +				 virtqueue_get_buf_ctx_split(_vq, len, ctx, cursor);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_premapped);
> +
> +/**
> + * virtqueue_detach - get the dma info of last buf
> + * @_vq: the struct virtqueue we're talking about.
> + * @cursor: detach cursor
> + * @addr: the dma address
> + * @len: the length of the dma address
> + * @dir: the direction of the dma address
> + *
> + * This is used for the premapped vq. The cursor is initialized by
> + * virtqueue_get_buf_premapped or virtqueue_detach_unused_buf_premapped.
> + *
> + * Returns:
> + * -EAGAIN: there are more dma info, this function should be called more.

dma info is singular, so "there is".

I see you kept this idea of returning -EAGAIN on success.
Pls don't.


> + * -EINVAL: the process is done, should not call this function

here you really mean "a previous call returned 0"
we generally don't do defensive programming why do it here?

> + * 0: no more dma info

"no more" normally means "nothing was returned", not
"value returned and this was the last entry".


> + */
> +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_detach_packed(_vq, cursor, addr, len, dir) :
> +				 virtqueue_detach_split(_vq, cursor, addr, len, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach);
> +
>  /**
>   * virtqueue_disable_cb - disable callbacks
>   * @_vq: the struct virtqueue we're talking about.
> @@ -2682,6 +2742,29 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> +/**
> + * virtqueue_detach_unused_buf_premapped - detach first unused buffer
> + * @_vq: the struct virtqueue we're talking about.
> + * @cursor: detach cursor
> + *
> + * This is used for the premapped vq. The cursor is passed by the dirver, that
> + * is used for virtqueue_detach. That will be initialized by virtio core
> + * internally.
> + *
> + * Returns NULL or the "data" token handed to virtqueue_add_*().
> + * This is not valid on an active queue; it is useful for device
> + * shutdown or the reset queue.
> + */
> +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> +					    struct virtqueue_detach_cursor *cursor)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq, cursor) :
> +				 virtqueue_detach_unused_buf_split(_vq, cursor);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf_premapped);
> +
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 7f137c7a9034..0a11c5b32fe5 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_H
>  /* Everything a virtio driver needs to work with any particular virtio
>   * implementation. */
> +#include <linux/dma-mapping.h>
>  #include <linux/types.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
> @@ -88,6 +89,10 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
>  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
>  			    void **ctx);
>  
> +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> +				  void **ctx,
> +				  struct virtqueue_detach_cursor *cursor);
> +
>  void virtqueue_disable_cb(struct virtqueue *vq);
>  
>  bool virtqueue_enable_cb(struct virtqueue *vq);
> @@ -101,6 +106,8 @@ bool virtqueue_poll(struct virtqueue *vq, unsigned);
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> +					    struct virtqueue_detach_cursor *cursor);
>  
>  unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>  
> @@ -114,6 +121,9 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
>  
> +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir);
> +
>  /**
>   * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
> -- 
> 2.32.0.3.g01195cf9f


