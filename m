Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD476581ED7
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 06:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiG0E37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 00:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiG0E35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 00:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C7EE3CBFE
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658896196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3R1yCR4JjKjOL2e44LtMos911qHy0R24gXLvjAAiWw=;
        b=GRocGC4JuprwQRQMlEOpFQwmRMmMqptK6oQf3/ovSLl01+S9VHxuR3GVCo088Dyj7sgYXc
        sGzwZxSjsfN9rY1CXygcJpZljujLpQtHORUqGHpAdL/rDWCbwnixxFS0/XF2+sJBWIP1Bc
        3vjVEHC1YksjS4i+m6xC7A4TkdgWjsU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-0P9RaXjTMSGEfXtBb2PmJQ-1; Wed, 27 Jul 2022 00:29:53 -0400
X-MC-Unique: 0P9RaXjTMSGEfXtBb2PmJQ-1
Received: by mail-pg1-f199.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so7318540pgc.13
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m3R1yCR4JjKjOL2e44LtMos911qHy0R24gXLvjAAiWw=;
        b=voq67XdU4PL87OCM/l/VM81eYYnV0kv8RDtKQhPDtCfVEVJuDRM+s5Ct0pVJF6Bwcy
         d+0pIHUgltOozYFtXrmG5y5NDDoU1FAJNoQSEsVkLAB1oKaEyD/Cev6Gc0yrtCxwiZ1z
         xAcazt5RcacHAsPFuYL8BL3GQp3uPjQlevd3LFxsQPrPvKPHGOnZGnsu9ZEQX2pv7k/Y
         DFbOv1tafqseFeHsh1bwsuxRiCSCLNF1qkBYG6YKkSjFloon2SLoW1fqr0/+61q5smYQ
         7+cyTuyZiJaR3JxgkBU7Cl8oM5anmBgB/Wb6Mf//wARkRNkPdKBHNLlaKBh/Pbn+DqIw
         pJdw==
X-Gm-Message-State: AJIora/p5OJNjA7SQw+AXjZAenPcBHI2dYmXlj6l+zAiUcafPxWdsPL+
        3kVOtZph6hOK6tN2jnipuJ3cHDWfuMR4tmt6/ywjZmc7QxOF+htJ56Ucj2N0FEVAFnRIFw7zepQ
        VG0JPnzsCoaae
X-Received: by 2002:a62:29c3:0:b0:52b:f774:7242 with SMTP id p186-20020a6229c3000000b0052bf7747242mr12643020pfp.67.1658896192595;
        Tue, 26 Jul 2022 21:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJEmlIFJw4XLwcoDuJY/DA3iRQl4vi72zW5Nqvakm1GQ10IUCcyGSf9WmnEO/2tbD5Ja9IXw==
X-Received: by 2002:a62:29c3:0:b0:52b:f774:7242 with SMTP id p186-20020a6229c3000000b0052bf7747242mr12642976pfp.67.1658896192306;
        Tue, 26 Jul 2022 21:29:52 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090abf8400b001f10b31e7a7sm469679pjs.32.2022.07.26.21.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 21:29:51 -0700 (PDT)
Message-ID: <4de63999-2c35-3208-709b-2a67d696fec6@redhat.com>
Date:   Wed, 27 Jul 2022 12:29:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 18/42] virtio_ring: packed: extract the logic of alloc
 queue
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-19-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-19-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/7/26 15:22, Xuan Zhuo 写道:
> Separate the logic of packed to create vring queue.
>
> This feature is required for subsequent virtuqueue reset vring.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 80 +++++++++++++++++++++++-------------
>   1 file changed, 51 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 891900b31c3d..10cc2b7e3588 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1857,19 +1857,10 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
>   	kfree(vring_packed->desc_extra);
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
> +static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
> +				    struct virtio_device *vdev,
> +				    u32 num)
>   {
> -	struct vring_virtqueue *vq;
>   	struct vring_packed_desc *ring;
>   	struct vring_packed_desc_event *driver, *device;
>   	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> @@ -1881,7 +1872,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   				 &ring_dma_addr,
>   				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>   	if (!ring)
> -		goto err_ring;
> +		goto err;
> +
> +	vring_packed->vring.desc         = ring;
> +	vring_packed->ring_dma_addr      = ring_dma_addr;
> +	vring_packed->ring_size_in_bytes = ring_size_in_bytes;
>   
>   	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
>   
> @@ -1889,13 +1884,47 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   				   &driver_event_dma_addr,
>   				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>   	if (!driver)
> -		goto err_driver;
> +		goto err;
> +
> +	vring_packed->vring.driver          = driver;
> +	vring_packed->event_size_in_bytes   = event_size_in_bytes;
> +	vring_packed->driver_event_dma_addr = driver_event_dma_addr;
>   
>   	device = vring_alloc_queue(vdev, event_size_in_bytes,
>   				   &device_event_dma_addr,
>   				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>   	if (!device)
> -		goto err_device;
> +		goto err;
> +
> +	vring_packed->vring.device          = device;
> +	vring_packed->device_event_dma_addr = device_event_dma_addr;
> +
> +	vring_packed->vring.num = num;
> +
> +	return 0;
> +
> +err:
> +	vring_free_packed(vring_packed, vdev);
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
> +	struct vring_virtqueue_packed vring_packed = {};
> +	struct vring_virtqueue *vq;
> +
> +	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
> +		goto err_ring;
>   
>   	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>   	if (!vq)
> @@ -1918,17 +1947,14 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>   		!context;
>   
> -	vq->packed.ring_dma_addr = ring_dma_addr;
> -	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
> -	vq->packed.device_event_dma_addr = device_event_dma_addr;
> +	vq->packed.ring_dma_addr = vring_packed.ring_dma_addr;
> +	vq->packed.driver_event_dma_addr = vring_packed.driver_event_dma_addr;
> +	vq->packed.device_event_dma_addr = vring_packed.device_event_dma_addr;
>   
> -	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
> -	vq->packed.event_size_in_bytes = event_size_in_bytes;
> +	vq->packed.ring_size_in_bytes = vring_packed.ring_size_in_bytes;
> +	vq->packed.event_size_in_bytes = vring_packed.event_size_in_bytes;
>   
> -	vq->packed.vring.num = num;
> -	vq->packed.vring.desc = ring;
> -	vq->packed.vring.driver = driver;
> -	vq->packed.vring.device = device;
> +	vq->packed.vring = vring_packed.vring;
>   
>   	vq->packed.next_avail_idx = 0;
>   	vq->packed.avail_wrap_counter = 1;
> @@ -1967,11 +1993,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   err_desc_state:
>   	kfree(vq);
>   err_vq:
> -	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> -err_device:
> -	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> -err_driver:
> -	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> +	vring_free_packed(&vring_packed, vdev);
>   err_ring:
>   	return NULL;
>   }

