Return-Path: <bpf+bounces-10543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DE7A9917
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A9BB218FD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28564447F;
	Thu, 21 Sep 2023 17:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003B199DB
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:22:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA79B59164
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695316810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYFUdBslfSemlERse4Us5f4NKymG/+Lupcjrt0UUg2s=;
	b=ZmmM59PdnY4yuT7LqNs4/OaPZJAK5tfHw6KhcI7f3YjjrNh0swPyX/xOjV5ZrNCF9qhdlO
	07Oc4RUsdKkYVz9ryLRU8ddIa9UMTTmqswwGDSry81COkyiP1rYEjvrM4juQ6jJR8M3Mde
	kkA0g7/ZO28eeAvVI/yUBp8zMup861U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-534w_DK9MPqB5a3vjC9KGg-1; Thu, 21 Sep 2023 10:03:11 -0400
X-MC-Unique: 534w_DK9MPqB5a3vjC9KGg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9d7a801a3so76020866b.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695304980; x=1695909780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYFUdBslfSemlERse4Us5f4NKymG/+Lupcjrt0UUg2s=;
        b=L1pgtU3LlIYB5uAbIn+IsRhw/asU9ubiYrWWHZCtVlrHyn8wOuQJRBsCM9XKGIZ4DI
         N9XwDvs0lXcqzbzx25s7xXm/8jGkDFl62a7z5VmOtWjIjd0H5SgZ8fQPaPeHx1cYgKv2
         4bhSvxCVTYw2wAAgbZHCJvDq/Jr6g6RQ8yRfiaBRQnTvNJgKSo4l0TNoYcfV+gGOO/pJ
         8ZpR97ibbhG7uhSflAi3gzVgp1MxmlpEWq75B+Xgn5AFs7nPjS+n5JJAuetp5741iQBW
         nOblvdMbnTj/d5MApo2mbndKpp8QucTZG2pmBAmIiThPdRPrlpbC/xb14OOBmY+qLdw2
         DyRA==
X-Gm-Message-State: AOJu0YxhrM5UzZnSh86CHXCJY8vQxRNXJpp3FDAsHKCPKXc88HwrgpQR
	mcFBjivLGhqjztcHZWjHUYqvLI4zcfwWsrcYEyviPON2hSl18wvG/YsPKSeG5jKYotK3n4rNvEZ
	OFjj5FHyQ7YAI
X-Received: by 2002:a17:906:13:b0:9a5:7e63:2e0 with SMTP id 19-20020a170906001300b009a57e6302e0mr5496779eja.30.1695304980544;
        Thu, 21 Sep 2023 07:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGDrtu0JFw6590Ay/MhiYHIEI6g5Txx1wcLitr4s1+bWtmtSPAeMYJ5QGJ2kmybduZxOWLIA==
X-Received: by 2002:a17:906:13:b0:9a5:7e63:2e0 with SMTP id 19-20020a170906001300b009a57e6302e0mr5496721eja.30.1695304980143;
        Thu, 21 Sep 2023 07:03:00 -0700 (PDT)
Received: from redhat.com ([2.52.150.187])
        by smtp.gmail.com with ESMTPSA id dt11-20020a170906b78b00b009ae482d70besm1079598ejb.134.2023.09.21.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:02:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 10:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue
 reset
Message-ID: <20230921100112-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> Introduce new helpers to implement queue reset and get queue reset
> status.
> 
>  https://github.com/oasis-tcs/virtio-spec/issues/124
>  https://github.com/oasis-tcs/virtio-spec/issues/139
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..869cb46bef96 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  /*
>   * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_status);
>  
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +

Actually, this does not validate that the config structure is big
enough. So it can access some unrelated memory. Don't know whether
that's exploitable e.g. for CoCo but not nice, anyway.
Need to validate the size and disable reset if it's too small.


> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->cfg.queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>  /*
>   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>   * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 05123b9a606f..c4eeb79b0139 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>  				       u16 index, resource_size_t *pa);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>  #endif
> -- 
> 2.31.0


