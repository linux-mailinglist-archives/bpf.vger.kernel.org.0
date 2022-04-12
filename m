Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD44FD9BC
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbiDLIcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 04:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356942AbiDLHjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18A604AE24
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649747432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGztLdiF5mtFDYQ2uVl1kOorRSYT0ewhcVo9olRY7S8=;
        b=HtSDtF3GfIh2a1LWwATVkxUnUJ/KDLg6KYrVUW4x0yfptNUYAZpmyGDqn2k4AKtxBIRnbw
        wqMlTOhIr/WzDAcOVsggEn2RwJB6v9fvUKmuETb276i8fqfvxV7mZYiUd02sJjbPbQPX+R
        hq11e2Mk9Iyg38ctmy9djLZrqSCsgEg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-VRs-Hmv-NJ-yFgvGcuFudA-1; Tue, 12 Apr 2022 03:10:28 -0400
X-MC-Unique: VRs-Hmv-NJ-yFgvGcuFudA-1
Received: by mail-pj1-f69.google.com with SMTP id u10-20020a17090adb4a00b001cb7b5a79e8so1093259pjx.5
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NGztLdiF5mtFDYQ2uVl1kOorRSYT0ewhcVo9olRY7S8=;
        b=Iqs0jyXVZ8hhtBqjcvO7MZZdePGlrFL9brl4V3J76g/p9zdoqqgwdnVmGh1qwFewn0
         Zcy26JL3tqoZSJZ5U4Uy3aL/WjBfIZxNjbOmI5s7vkQlaFCJbz5u95gp/7XSbfrRiGrx
         IwCYJte9KIQE32vvXvH86UA86SYLT+UQW8+TcQsWEHvwhs6f0JT9Kemflx0qeLJzAGw8
         XzkZbjTYo3n0Hti51wq4xDUVyI9OlbHHvLn+z7XlOVLgLywC5FNo2RhJlKWp/WG4BjuU
         XU4LLqt8y5ATkCKB3/T/6bnrypHX8KvhhJEXxJ7Di5DJWloHYl/G15bP+uNE0iV6Lb2W
         rIGA==
X-Gm-Message-State: AOAM5337lPAswKvb/SDheT5KSano5ptNK0VmRcyZfjZRM2RWThUxCX69
        om2UbOuNnU9XadfPfNJWF1f1necLewWsKvCSPfw9JfP1kcDDT29qLeQZnhOYuFvd0VFCjCK7Fkm
        jXLp7l0951m1F
X-Received: by 2002:a17:902:e84d:b0:155:d31c:5c93 with SMTP id t13-20020a170902e84d00b00155d31c5c93mr35994574plg.103.1649747426839;
        Tue, 12 Apr 2022 00:10:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxURT6e2iGDAZLnkWghXtDjSJ+7RYFzdSBEwH3dHydzlCPkYSiq+vvQpN+h1WUkOhsXje4cAA==
X-Received: by 2002:a17:902:e84d:b0:155:d31c:5c93 with SMTP id t13-20020a170902e84d00b00155d31c5c93mr35994542plg.103.1649747426525;
        Tue, 12 Apr 2022 00:10:26 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b00505bf6f2b36sm6154997pfo.205.2022.04.12.00.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:10:25 -0700 (PDT)
Message-ID: <a0bcbceb-c550-b915-eb40-4e5769ae597d@redhat.com>
Date:   Tue, 12 Apr 2022 15:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 24/32] virtio: find_vqs() add arg sizes
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
 <20220406034346.74409-25-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-25-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> find_vqs() adds a new parameter sizes to specify the size of each vq
> vring.
>
> 0 means use the maximum size supported by the backend.


Does this mean driver still need to prepare a array of 0 or it can 
simply pass NULL to find_vqs()?

Thanks


>
> In the split scenario, the meaning of size is the largest size, because
> it may be limited by memory, the virtio core will try a smaller size.
> And the size is power of 2.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   arch/um/drivers/virtio_uml.c             |  2 +-
>   drivers/platform/mellanox/mlxbf-tmfifo.c |  1 +
>   drivers/remoteproc/remoteproc_virtio.c   |  1 +
>   drivers/s390/virtio/virtio_ccw.c         |  1 +
>   drivers/virtio/virtio_mmio.c             |  1 +
>   drivers/virtio/virtio_pci_common.c       |  2 +-
>   drivers/virtio/virtio_pci_common.h       |  2 +-
>   drivers/virtio/virtio_pci_modern.c       |  7 +++++--
>   drivers/virtio/virtio_vdpa.c             |  1 +
>   include/linux/virtio_config.h            | 14 +++++++++-----
>   10 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 904993d15a85..6af98d130840 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -998,7 +998,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>   
>   static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -		       const char * const names[], const bool *ctx,
> +		       const char * const names[], u32 sizes[], const bool *ctx,
>   		       struct irq_affinity *desc)
>   {
>   	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 1ae3c56b66b0..8be13d416f48 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -928,6 +928,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>   					struct virtqueue *vqs[],
>   					vq_callback_t *callbacks[],
>   					const char * const names[],
> +					u32 sizes[],
>   					const bool *ctx,
>   					struct irq_affinity *desc)
>   {
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 7611755d0ae2..baad31c9da45 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -158,6 +158,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>   				 struct virtqueue *vqs[],
>   				 vq_callback_t *callbacks[],
>   				 const char * const names[],
> +				 u32 sizes[],
>   				 const bool * ctx,
>   				 struct irq_affinity *desc)
>   {
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 468da60b56c5..f0c814a54e78 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -634,6 +634,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   			       struct virtqueue *vqs[],
>   			       vq_callback_t *callbacks[],
>   			       const char * const names[],
> +			       u32 sizes[],
>   			       const bool *ctx,
>   			       struct irq_affinity *desc)
>   {
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a41abc8051b9..9d5a674bdeec 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -461,6 +461,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		       struct virtqueue *vqs[],
>   		       vq_callback_t *callbacks[],
>   		       const char * const names[],
> +		       u32 sizes[],
>   		       const bool *ctx,
>   		       struct irq_affinity *desc)
>   {
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 863d3a8a0956..826ea2e35d54 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -427,7 +427,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
>   /* the config->find_vqs() implementation */
>   int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -		const char * const names[], const bool *ctx,
> +		const char * const names[], u32 sizes[], const bool *ctx,
>   		struct irq_affinity *desc)
>   {
>   	int err;
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 23f6c5c678d5..859eed559e10 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -113,7 +113,7 @@ void vp_del_vqs(struct virtio_device *vdev);
>   /* the config->find_vqs() implementation */
>   int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -		const char * const names[], const bool *ctx,
> +		const char * const names[], u32 sizes[], const bool *ctx,
>   		struct irq_affinity *desc);
>   const char *vp_bus_name(struct virtio_device *vdev);
>   
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index cb5d38f1c9c8..3b35e5056165 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -343,12 +343,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   			      struct virtqueue *vqs[],
>   			      vq_callback_t *callbacks[],
> -			      const char * const names[], const bool *ctx,
> +			      const char * const names[],
> +			      u32 sizes[],
> +			      const bool *ctx,
>   			      struct irq_affinity *desc)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>   	struct virtqueue *vq;
> -	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
> +	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, sizes, ctx,
> +			     desc);
>   
>   	if (rc)
>   		return rc;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 39e4c08eb0f2..ac86d3a6633c 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -269,6 +269,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   				struct virtqueue *vqs[],
>   				vq_callback_t *callbacks[],
>   				const char * const names[],
> +				u32 sizes[],
>   				const bool *ctx,
>   				struct irq_affinity *desc)
>   {
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d4adcd0e1c57..0f7def7ddfd2 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,7 @@ struct virtio_shm_region {
>    *		include a NULL entry for vqs that do not need a callback
>    *	names: array of virtqueue names (mainly for debugging)
>    *		include a NULL entry for vqs unused by driver
> + *	sizes: array of virtqueue sizes
>    *	Returns 0 on success or error status
>    * @del_vqs: free virtqueues found by find_vqs().
>    * @get_features: get the array of feature bits for this device.
> @@ -98,7 +99,9 @@ struct virtio_config_ops {
>   	void (*reset)(struct virtio_device *vdev);
>   	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
>   			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -			const char * const names[], const bool *ctx,
> +			const char * const names[],
> +			u32 sizes[],
> +			const bool *ctx,
>   			struct irq_affinity *desc);
>   	void (*del_vqs)(struct virtio_device *);
>   	u64 (*get_features)(struct virtio_device *vdev);
> @@ -206,7 +209,7 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
>   	const char *names[] = { n };
>   	struct virtqueue *vq;
>   	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL,
> -					 NULL);
> +					 NULL, NULL);
>   	if (err < 0)
>   		return ERR_PTR(err);
>   	return vq;
> @@ -218,7 +221,8 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   			const char * const names[],
>   			struct irq_affinity *desc)
>   {
> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> +	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL,
> +				      NULL, desc);
>   }
>   
>   static inline
> @@ -227,8 +231,8 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>   			const char * const names[], const bool *ctx,
>   			struct irq_affinity *desc)
>   {
> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
> -				      desc);
> +	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL,
> +				      ctx, desc);
>   }
>   
>   /**

