Return-Path: <bpf+bounces-16245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724027FEC20
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958CE1C209B7
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5F3AC04;
	Thu, 30 Nov 2023 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+1FHY37"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AB10F1
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701337566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfGI1qlZAEAF2BhJp3RmJxUya50qDURSNVaHY6y9EXQ=;
	b=U+1FHY37/Pn3SjfZwwZL8EhYDSM0wvCGofnyA465OdN7FFx5iRcIoaD1pY5JJM3NpwcGVi
	MzC8tWJ/jQfQB9BtEbaBirpX0ZYKXlDiwBBmKMmCywA1H55DcVxGEEloAcdbOx9w7TRyH+
	xVDpsFE9IGuwER4tCijK8E0TS58QlBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-4bSl4dm3MZqDVSA0Ou4dnA-1; Thu, 30 Nov 2023 04:46:05 -0500
X-MC-Unique: 4bSl4dm3MZqDVSA0Ou4dnA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3331258269fso803911f8f.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337563; x=1701942363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfGI1qlZAEAF2BhJp3RmJxUya50qDURSNVaHY6y9EXQ=;
        b=EDLBVWrTgvJGdI/+5llmHLBt1DlvUz1q0X/induO/LhjMby3qpY+iD5kZAAvPsbE6N
         XkmIvfMjgxDJimHWY+/xIAM4ZfRkl2U4ML/RZIyz+AVSc1uGfTDOMeraQqFqxafAcGEd
         zRlRGEW06yYnXsoA7dMP3cS/kJ7UXfp2gkMKNX1hQ5FXTdQ00TK8GdP597l0dDMpI9N2
         YvoOIPc2dv+d2PDBOuwmnfZDJMLzX7JqXiwviON5cGk0Kkb0W8WgvUqkAFaaB19AWS6e
         7UyUIwRnj2tJ7ikBEaZ7w6DZxLlz6+npj9JstQlcnK7aozHLG2jSm150UShSm0OKUUuN
         FmEQ==
X-Gm-Message-State: AOJu0Yw7sS+4Ms3mJ4OiHmjkjdGX7eQqO/9VV5CH2bwP9c2ZA8ZMhqfU
	qpdnfu0TEE1k1Uh53svjrYiBjflUffO/yQRE3TjUDBrsvgatxe7bniNW8YmJ+7s/09lYEq1EocD
	GIPDH8RiVtywejjgIJmC+
X-Received: by 2002:adf:f18a:0:b0:333:2003:f8d5 with SMTP id h10-20020adff18a000000b003332003f8d5mr1300585wro.47.1701337563314;
        Thu, 30 Nov 2023 01:46:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ1YqAf91AEdYFb/UmG1d2aec7j4UFFqWCYZRHFF8ZmzzWbiemhO2JFaP7Qe8H76kv8gs1Wg==
X-Received: by 2002:adf:f18a:0:b0:333:2003:f8d5 with SMTP id h10-20020adff18a000000b003332003f8d5mr1300567wro.47.1701337562911;
        Thu, 30 Nov 2023 01:46:02 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id t3-20020adfe443000000b00332fcdafc22sm1036634wrm.70.2023.11.30.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:46:02 -0800 (PST)
Date: Thu, 30 Nov 2023 04:45:58 -0500
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
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for
 virtqueue
Message-ID: <20231130044512-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>

On Thu, Aug 10, 2023 at 08:30:56PM +0800, Xuan Zhuo wrote:
> These API has been introduced:
> 
> * virtqueue_dma_need_sync
> * virtqueue_dma_sync_single_range_for_cpu
> * virtqueue_dma_sync_single_range_for_device
> 
> These APIs can be used together with the premapped mechanism to sync the
> DMA address.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  8 ++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 916479c9c72c..81ecb29c88f1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>  
> +/**
> + * virtqueue_dma_need_sync - check a dma address needs sync
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + *
> + * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
> + * synchronized
> + *
> + * return bool
> + */
> +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return false;
> +
> +	return dma_need_sync(vring_dma_dev(vq), addr);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> +
> +/**
> + * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: buf size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> + * the DMA address really needs to be synchronized
> + *
> + */
> +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +					     dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct device *dev = vring_dma_dev(vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_sync_single_range_for_cpu(dev, addr, offset, size,
> +				      DMA_BIDIRECTIONAL);
> +}


Why did you use DMA_BIDIRECTIONAL here?
Why is "dir" ignored?


> +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> +
> +/**
> + * virtqueue_dma_sync_single_range_for_device - dma sync for device
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: buf size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> + * the DMA address really needs to be synchronized
> + */
> +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +						dma_addr_t addr,
> +						unsigned long offset, size_t size,
> +						enum dma_data_direction dir)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct device *dev = vring_dma_dev(vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_sync_single_range_for_device(dev, addr, offset, size,
> +					 DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
> +
>  MODULE_LICENSE("GPL");

same question here.

> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 79e3c74391e0..1311a7fbe675 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs);
>  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +
> +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir);
> +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> +						unsigned long offset, size_t size,
> +						enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.32.0.3.g01195cf9f


