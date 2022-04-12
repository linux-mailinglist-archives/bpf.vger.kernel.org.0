Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD494FCF7C
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348815AbiDLGbC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 02:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348699AbiDLGbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 02:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4567935867
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649744924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96mvZW2N60Bc/yiEAvufsCeVXhKGkkUOXQ1a79/ykgI=;
        b=JOqlVN9XiybdHVtOTH7Axb8I48N+2ZQ5l0XuAsHfILN36vB2l+BciH0e9dtNmyxCA8SdER
        e2GFdKZ9NpmTBynabRvbM23nJxB/EvyHuiV4K6Onqhii/s7XXJSqRw3cOYHdK3jDcFZ879
        das85TA8zugg/MacD5n83FltgUaU15Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-1fHil2rqNWuKEgX83-wuiA-1; Tue, 12 Apr 2022 02:28:42 -0400
X-MC-Unique: 1fHil2rqNWuKEgX83-wuiA-1
Received: by mail-pf1-f197.google.com with SMTP id h131-20020a628389000000b005056723a9dcso8696754pfe.8
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=96mvZW2N60Bc/yiEAvufsCeVXhKGkkUOXQ1a79/ykgI=;
        b=DcZWa0YJbqfWJU8h2LorPHsj/jChVoXig8ufpWRaQnzYeFy1KKIMTEd0fuzK1b1MSV
         cUutIdCPIDc1jwqpu9pGmauFGylAuqBUFdy6TkIzDgpX4s8sGenwVvDoVpyJq93MMF6u
         5AW+KXOdCd3o8f6AnGP+GTkiFDx0U7Z/or/LoQIKJOxc0a6IvV7l2221ikkTADucYZT4
         SLpqCiA5FK1+DWOxQbAZ8cm02AIlhJqeKYYYh8ac9fQiFtqLpgR5RnE3yl1RpiAmcXwI
         QiRM4UFBYSsuSSyrfReBm0IuN7nmekXtkLkq6LYjIuSQwvWz8X45B/Jt4N0HpBXvMtI6
         Hjww==
X-Gm-Message-State: AOAM532Y6IRwGiHpNP4Rji2qIQN72fshKMTiupGP19g1NdH6AXxetr31
        VYGUoFRS6DAhcdCgSZt5lmOEO8/Pnf1i4BEtwcXUGjTwFRRVOWmLs43e8huU/HHRvKPaDZjhtSu
        3EY1w5PpQsD9/
X-Received: by 2002:a17:90a:600b:b0:1cb:8ba5:d3bc with SMTP id y11-20020a17090a600b00b001cb8ba5d3bcmr3322137pji.42.1649744921372;
        Mon, 11 Apr 2022 23:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsTZb815vqxK0EhXJcoHB9RSXY3UmD7WoV1CP0Y3EhajIsat86IZWa2d15JEEcfRFMnydtCQ==
X-Received: by 2002:a17:90a:600b:b0:1cb:8ba5:d3bc with SMTP id y11-20020a17090a600b00b001cb8ba5d3bcmr3322121pji.42.1649744921156;
        Mon, 11 Apr 2022 23:28:41 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001cb66e3e1f8sm1483400pjb.0.2022.04.11.23.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:28:40 -0700 (PDT)
Message-ID: <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
Date:   Tue, 12 Apr 2022 14:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc
 queue
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Separate the logic of packed to create vring queue.
>
> For the convenience of passing parameters, add a structure
> vring_packed.
>
> This feature is required for subsequent virtuqueue reset vring.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++--------
>   1 file changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 33864134a744..ea451ae2aaef 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1817,19 +1817,17 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>   	return desc_extra;
>   }
>   
> -static struct virtqueue *vring_create_virtqueue_packed(
> -	unsigned int index,
> -	unsigned int num,
> -	unsigned int vring_align,
> -	struct virtio_device *vdev,
> -	bool weak_barriers,
> -	bool may_reduce_num,
> -	bool context,
> -	bool (*notify)(struct virtqueue *),
> -	void (*callback)(struct virtqueue *),
> -	const char *name)
> +static int vring_alloc_queue_packed(struct virtio_device *vdev,
> +				    u32 num,
> +				    struct vring_packed_desc **_ring,
> +				    struct vring_packed_desc_event **_driver,
> +				    struct vring_packed_desc_event **_device,
> +				    dma_addr_t *_ring_dma_addr,
> +				    dma_addr_t *_driver_event_dma_addr,
> +				    dma_addr_t *_device_event_dma_addr,
> +				    size_t *_ring_size_in_bytes,
> +				    size_t *_event_size_in_bytes)
>   {
> -	struct vring_virtqueue *vq;
>   	struct vring_packed_desc *ring;
>   	struct vring_packed_desc_event *driver, *device;
>   	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> @@ -1857,6 +1855,52 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	if (!device)
>   		goto err_device;
>   
> +	*_ring                   = ring;
> +	*_driver                 = driver;
> +	*_device                 = device;
> +	*_ring_dma_addr          = ring_dma_addr;
> +	*_driver_event_dma_addr  = driver_event_dma_addr;
> +	*_device_event_dma_addr  = device_event_dma_addr;
> +	*_ring_size_in_bytes     = ring_size_in_bytes;
> +	*_event_size_in_bytes    = event_size_in_bytes;


I wonder if we can simply factor out split and packed from struct 
vring_virtqueue:

struct vring_virtqueue {
     union {
         struct {} split;
         struct {} packed;
     };
};

to

struct vring_virtqueue_split {};
struct vring_virtqueue_packed {};

Then we can do things like:

vring_create_virtqueue_packed(struct virtio_device *vdev, u32 num, 
struct vring_virtqueue_packed *packed);

and

vring_vritqueue_attach_packed(struct vring_virtqueue *vq, struct 
vring_virtqueue_packed packed);

Thanks


> +
> +	return 0;
> +
> +err_device:
> +	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> +
> +err_driver:
> +	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> +
> +err_ring:
> +	return -ENOMEM;
> +}
> +
> +static struct virtqueue *vring_create_virtqueue_packed(
> +	unsigned int index,
> +	unsigned int num,
> +	unsigned int vring_align,
> +	struct virtio_device *vdev,
> +	bool weak_barriers,
> +	bool may_reduce_num,
> +	bool context,
> +	bool (*notify)(struct virtqueue *),
> +	void (*callback)(struct virtqueue *),
> +	const char *name)
> +{
> +	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> +	struct vring_packed_desc_event *driver, *device;
> +	size_t ring_size_in_bytes, event_size_in_bytes;
> +	struct vring_packed_desc *ring;
> +	struct vring_virtqueue *vq;
> +
> +	if (vring_alloc_queue_packed(vdev, num, &ring, &driver, &device,
> +				     &ring_dma_addr, &driver_event_dma_addr,
> +				     &device_event_dma_addr,
> +				     &ring_size_in_bytes,
> +				     &event_size_in_bytes))
> +		goto err_ring;
> +
>   	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>   	if (!vq)
>   		goto err_vq;
> @@ -1939,9 +1983,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	kfree(vq);
>   err_vq:
>   	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> -err_device:
>   	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> -err_driver:
>   	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
>   err_ring:
>   	return NULL;

