Return-Path: <bpf+bounces-12520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF77CD5C8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D5281B08
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2282125A2;
	Wed, 18 Oct 2023 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4F11C80;
	Wed, 18 Oct 2023 07:56:36 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A2BC;
	Wed, 18 Oct 2023 00:56:32 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuQ2b0W_1697615788;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuQ2b0W_1697615788)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 15:56:29 +0800
Message-ID: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce virtqueue_dma_[un]map_page_attrs
Date: Wed, 18 Oct 2023 15:53:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
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

Hi Michael,

Do you think it's appropriate to push the first two patches of this patch set to
linux 6.6?

Thanks.

On Wed, 11 Oct 2023 17:27:08 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Introduce virtqueue_dma_[un]map_page_attrs() to do dma/unmap for pages.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  7 +++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b3ded56722f4..36aae63336b8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3111,6 +3111,58 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>
> +/**
> + * virtqueue_dma_map_page_attrs - map page DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @page: the page to do dma
> + * @offset: the offset inside the page
> + * @size: the size of the page to do dma
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * The caller calls this to do dma mapping in advance. The DMA address can be
> + * passed to this _vq when it is in pre-mapped mode.
> + *
> + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> + */
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return (dma_addr_t)(page_to_phys(page) + offset);
> +
> +	return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_map_page_attrs);
> +
> +/**
> + * virtqueue_dma_unmap_page_attrs - unmap page DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: the dma address to unmap
> + * @size: the size of the buffer
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> + *
> + */
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_page_attrs);
> +
>  /**
>   * virtqueue_dma_map_single_attrs - map DMA for _vq
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1cf7b004348b..d7c7f4fdee2f 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -212,6 +212,13 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
>
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs);
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs);
>  dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
>  					  enum dma_data_direction dir, unsigned long attrs);
>  void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> --
> 2.32.0.3.g01195cf9f
>

