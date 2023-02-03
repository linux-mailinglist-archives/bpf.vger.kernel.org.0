Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563F068931F
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 10:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjBCJIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 04:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjBCJIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 04:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D270D45889
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675415239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcpnbERMPxMIk4rSMsJPyxbYfxtUlhTSWcolKETapCs=;
        b=QonDO71I+IC38McjLdJn0LyvUsulYFwgWVF/c6081rfwhCkoWFPWNbuXyha1o7RmFimrMz
        XZAwCL29Igx8Y9HuDt9irMfiHyiw0VVhpzdzWQcLO9q2Yr32BvfGTDqtxQsznoG9da/HjU
        A/7/v+h7UVMj/i+n8+XNscxJK9PcB0c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-l4IFd95OMtG3k4KvSlFxJQ-1; Fri, 03 Feb 2023 04:07:17 -0500
X-MC-Unique: l4IFd95OMtG3k4KvSlFxJQ-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a0564021e8900b004a7a094690cso2450010edf.9
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 01:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcpnbERMPxMIk4rSMsJPyxbYfxtUlhTSWcolKETapCs=;
        b=zZBlZeOety0d2orTsEQ564ubsUu5CJ8PJ667N5b2YdLpZm0ScqeqPEihLwiORog0OH
         zzr3jaq0Z0BngCBwZlAdc0swgyq1qx5pQmL0KUa1hbxPuEZ0PMz5T6dPzvhWzFwXMmNd
         sHnbyI3hd805jZgBPKVwskoC+5aAHaEfp5vyYxt/iMMTjXvN/Xr6qRGEPN0qsDPb0N2j
         uodpw/k2Zd2dn0ydC0kXJw0BveX2vATogHVDMP3ybFrN6KCJw8Qshq81ltQLXT/XGumF
         R/A22Msfpev8KDA9f20gka5/Cp5dS5Y6qHDjZKVCRM8ktz+DeLF3wKXNeRROVn7gG9QD
         6vMw==
X-Gm-Message-State: AO0yUKUYK8sGf8u1u1owkNrlPNU5QqH0CCEN6H1dbqqm+XcDMB6YmhoJ
        Y85e5h/be2goRIpavzsByR2Pubton7+N4TmmPzAqpx5dM34Q/hfuHAgs5/slFES2NdgSCtEVt24
        qrTp39oNWsWkF
X-Received: by 2002:a50:d088:0:b0:4a2:3d3d:a3d9 with SMTP id v8-20020a50d088000000b004a23d3da3d9mr9092225edd.2.1675415236394;
        Fri, 03 Feb 2023 01:07:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/JGZiQysBGfBbJ3E1QUQsRtGGsv7wF/0eyNNTeOrg2il3rlRP8/URTnNDtbpX9I5F+ED6I/Q==
X-Received: by 2002:a50:d088:0:b0:4a2:3d3d:a3d9 with SMTP id v8-20020a50d088000000b004a23d3da3d9mr9092201edd.2.1675415236167;
        Fri, 03 Feb 2023 01:07:16 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id b9-20020a0564021f0900b004a21304f5a0sm799006edb.72.2023.02.03.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:07:15 -0800 (PST)
Date:   Fri, 3 Feb 2023 04:07:10 -0500
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
Subject: Re: [PATCH 07/33] virtio_ring: add api virtio_dma_map() for advance
 dma
Message-ID: <20230203040621-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202110058.130695-8-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 07:00:32PM +0800, Xuan Zhuo wrote:
> Added virtio_dma_map() to map DMA addresses for virtual memory in
> advance. The purpose of adding this function is to check
> vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
> the parameter of dma_map_page().

No this looks like the implementation not the purpose.
I am guessing the purpose is to keep memory mapped
across multiple add/get buf operations right?

> Added virtio_dma_unmap() for unmap DMA address.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 80 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  9 ++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 7dfce7001f9f..67eda7bc23ea 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3022,4 +3022,84 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>  
> +/**
> + * virtio_dma_map_page - get the DMA addr of the memory for virtio device
> + * @dev: virtio device
> + * @page: the page of the memory to DMA
> + * @offset: the offset of the memory inside page
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * Returns the DMA addr. DMA_MAPPING_ERROR means error.
> + */
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +			       unsigned int length, enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return page_to_phys(page) + offset;
> +
> +	return dma_map_page(vdev->dev.parent, page, offset, length, dir);
> +}
> +
> +/**
> + * virtio_dma_map - get the DMA addr of the memory for virtio device
> + * @dev: virtio device
> + * @addr: the addr to DMA
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * Returns the DMA addr.
> + */
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +			  enum dma_data_direction dir)
> +{
> +	struct page *page;
> +	size_t offset;
> +
> +	page = virt_to_page(addr);
> +	offset = offset_in_page(addr);
> +
> +	return virtio_dma_map_page(dev, page, offset, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_map);
> +
> +/**
> + * virtio_dma_mapping_error - check dma address
> + * @dev: virtio device
> + * @addr: DMA address
> + *
> + * Returns 0 means dma valid. Other means invalid dma address.
> + */
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return 0;
> +
> +	return dma_mapping_error(vdev->dev.parent, addr);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
> +
> +/**
> + * virtio_dma_unmap - unmap DMA addr
> + * @dev: virtio device
> + * @dma: DMA address
> + * @length: memory length
> + * @dir: DMA direction
> + */
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return;
> +
> +	dma_unmap_page(vdev->dev.parent, dma, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3ca2edb1aef3..ce89126becc5 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
> +#include <linux/dma-mapping.h>
>  
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -218,4 +219,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
> +
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +			       unsigned int length, enum dma_data_direction dir);
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +			  enum dma_data_direction dir);
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.32.0.3.g01195cf9f

