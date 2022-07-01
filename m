Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F022563067
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiGAJjw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiGAJjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61AD274357
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656668389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
        b=PaITlvTG1hJCz7f7vx6xXHcCF7/FLQs2YtmRau83iRQBD2MNBUTLBFgNDlMgX5GjUfjf4V
        fOcDS10rLrG0L4P5pPgslCsaCGiZQCp0Vo+TKOoyjYnCUTJIpBM5tPrSH+BEbSJRM+zNeP
        jEJ7OZlJR8uwQpg8FC5JSjMJvbPC31g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-Tg1pdsGeO-2nhDfyhwpXGQ-1; Fri, 01 Jul 2022 05:39:48 -0400
X-MC-Unique: Tg1pdsGeO-2nhDfyhwpXGQ-1
Received: by mail-pl1-f198.google.com with SMTP id i5-20020a170902c94500b0016a644a6008so1218321pla.1
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
        b=D9uFTUk4WGzMWMDk39dM2HsxCqq2fTs7Z0gcqg/qdNCNQJVvqwqLDGaZU703p2GQBL
         oSvk9ll+NVgVeWJDjnRf1Y3UCQwqMo+r0TEZRHT1NYSEIDbJPfDawD04Rm7rlg049QwA
         +FQZEN4rvw68C9TWr0b9MkwvSP3vpD1QSr0cwiOYJJvkTx10OVkTnXTwPsEAS+MbSDey
         6U3Jz1gvzqAw45ngpzDFWgqW71xX8et0gbKHArkfeP5SQA8kNWXu/3+XenbHAgqinyk7
         eKMxL514hUPLMkaaaIuHhlt02vBB0gld4gccgNy0hd+og5iybL0GnpSp3mo4zm2HUoTE
         apKA==
X-Gm-Message-State: AJIora+xozImrvcvBfKw2XGDry6qGtWeC/tTAVXXMZhKi0M35kX0QeGo
        L2QR95cShktCPGcHvj/pGEFVDKg1o2K4uGx9ej4djkDEheBPuIzWfAHxQ4bxJxCfrlRKBOs3ucZ
        53PPVD+Uv6NZ8
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id u10-20020a63454a000000b00411bbffb079mr4669456pgk.507.1656668387166;
        Fri, 01 Jul 2022 02:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQXl0Mg32c6PANnbBYsi+TCYur6T2X1Z6vqtoZHDXDxtmKbFKHms2mPc6lxJgdRzWP3sExWg==
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id u10-20020a63454a000000b00411bbffb079mr4669428pgk.507.1656668386921;
        Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy18-20020a17090b325200b001e31803540fsm6079692pjb.6.2022.07.01.02.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Message-ID: <494bcf3f-d42c-f05b-cbdb-d4ba834bd118@redhat.com>
Date:   Fri, 1 Jul 2022 17:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 28/40] virtio_pci: introduce helper to get/set queue
 reset
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
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> Introduce new helpers to implement queue reset and get queue reset
> status.
>
>   https://github.com/oasis-tcs/virtio-spec/issues/124
>   https://github.com/oasis-tcs/virtio-spec/issues/139
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_pci_modern_dev.c | 35 ++++++++++++++++++++++++++
>   include/linux/virtio_pci_modern.h      |  2 ++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..07415654247c 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>   #include <linux/virtio_pci_modern.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/delay.h>
>   
>   /*
>    * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,40 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>   }
>   EXPORT_SYMBOL_GPL(vp_modern_set_status);
>   
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +
> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>   /*
>    * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>    * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index beebc7a4a31d..ded01157f864 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -134,4 +134,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>   				       u16 index, resource_size_t *pa);
>   int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>   void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>   #endif

