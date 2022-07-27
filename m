Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA2581F01
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiG0Eho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiG0Ehn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 00:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E5113D5B3
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658896661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eglJXh28UWwMt7nfBux4PPlOeAEHThKdFwbJ4et/2A8=;
        b=KDMXYbcDiB7Ovgd+MI+K7xaBbNi7yacHpY1GoMG1w1bZR9EHU3UIQwWosku1d0XlbFfEfM
        LIclddEpErPX5YDJWz3/qNH1oLz2Qbn/JRCJLLtpeJSsPciYp/WE6LLN6dAWPi8/33hw3Q
        E8FKgOhlzNzSNh5ZjgCtTCFaHT0UZZM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-D_PTObRQNmyB-uLFWt5UwA-1; Wed, 27 Jul 2022 00:37:39 -0400
X-MC-Unique: D_PTObRQNmyB-uLFWt5UwA-1
Received: by mail-pf1-f200.google.com with SMTP id r7-20020aa79627000000b00528beaf82c3so5440270pfg.8
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eglJXh28UWwMt7nfBux4PPlOeAEHThKdFwbJ4et/2A8=;
        b=3aCCB0xErr8XDdhUrRub7MWvH5zxZyYNG2E9zdw2DrZBE8RN4SrPy5+fRdQLJKwQxp
         2DAzkZ5EbLf7kRO+PAAM4O7xuqQ93mHRJqMuQDHVRnN0wtva3idEiePaanrNzGR9sKN1
         6BhuEm0T5GaqFNaHH3rPlLvxXyAgzveMd7e1PfugyPDWZ3cbU4/cikYBi2tBE2r0XuFP
         UybVvzlFAZnRdULpj+DE0Hn1znMMsILOpgdcWjhKTCJrcFb/LE6paXQz5NKE0gnCAyw8
         QPuHMOO/VrTf+5AO4BPma8/co65Odk4RCA7VetkwMRCB8201sNS6GizG0M6F+RzvIZsV
         GGiA==
X-Gm-Message-State: AJIora8cHgLasuwn/R8evZPK86/xFHvSTN/iVjp3bxxI7mf0dQEuDMJv
        WVEeekgpKxgdCHSxwOdB8JIML6OBwmAjNwe/Utb3tc8wl79z22SV18TOzQwVrM+u7EfNq7JgDue
        pa56NLUEr/tIV
X-Received: by 2002:a17:90b:4c51:b0:1f2:46b2:7c28 with SMTP id np17-20020a17090b4c5100b001f246b27c28mr2510295pjb.231.1658896657994;
        Tue, 26 Jul 2022 21:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcSW0SH/oE3E1QIJ9xZXlmolMaePDPPfBCRfkcaVWN7oKvG/J6RPnSNe2Qq4YMnD3xbv2vjg==
X-Received: by 2002:a17:90b:4c51:b0:1f2:46b2:7c28 with SMTP id np17-20020a17090b4c5100b001f246b27c28mr2510272pjb.231.1658896657718;
        Tue, 26 Jul 2022 21:37:37 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b0016a0bf0ce32sm12698532plg.70.2022.07.26.21.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 21:37:30 -0700 (PDT)
Message-ID: <980553b7-ba12-bcdf-0be0-8f3da5985441@redhat.com>
Date:   Wed, 27 Jul 2022 12:37:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 32/42] virtio_pci: support VIRTIO_F_RING_RESET
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
 <20220726072225.19884-33-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-33-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/7/26 15:22, Xuan Zhuo 写道:
> This patch implements virtio pci support for QUEUE RESET.
>
> Performing reset on a queue is divided into these steps:
>
>   1. notify the device to reset the queue
>   2. recycle the buffer submitted
>   3. reset the vring (may re-alloc)
>   4. mmap vring to device, and enable the queue
>
> This patch implements virtio_reset_vq(), virtio_enable_resetq() in the
> pci scenario.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_pci_common.c | 12 +++-
>   drivers/virtio/virtio_pci_modern.c | 88 ++++++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ca51fcc9daab..ad258a9d3b9f 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -214,9 +214,15 @@ static void vp_del_vq(struct virtqueue *vq)
>   	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&vp_dev->lock, flags);
> -	list_del(&info->node);
> -	spin_unlock_irqrestore(&vp_dev->lock, flags);
> +	/*
> +	 * If it fails during re-enable reset vq. This way we won't rejoin
> +	 * info->node to the queue. Prevent unexpected irqs.
> +	 */
> +	if (!vq->reset) {
> +		spin_lock_irqsave(&vp_dev->lock, flags);
> +		list_del(&info->node);
> +		spin_unlock_irqrestore(&vp_dev->lock, flags);
> +	}
>   
>   	vp_dev->del_vq(info);
>   	kfree(info);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9041d9a41b7d..c3b9f2761849 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>   			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
>   		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> +
> +	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> +		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
>   }
>   
>   /* virtio config->finalize_features() implementation */
> @@ -199,6 +202,87 @@ static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
>   	return 0;
>   }
>   
> +static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	struct virtio_pci_vq_info *info;
> +	unsigned long flags;
> +
> +	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> +		return -ENOENT;
> +
> +	vp_modern_set_queue_reset(mdev, vq->index);
> +
> +	info = vp_dev->vqs[vq->index];
> +
> +	/* delete vq from irq handler */
> +	spin_lock_irqsave(&vp_dev->lock, flags);
> +	list_del(&info->node);
> +	spin_unlock_irqrestore(&vp_dev->lock, flags);
> +
> +	INIT_LIST_HEAD(&info->node);
> +
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> +	__virtqueue_break(vq);
> +#endif
> +
> +	/* For the case where vq has an exclusive irq, call synchronize_irq() to
> +	 * wait for completion.
> +	 *
> +	 * note: We can't use disable_irq() since it conflicts with the affinity
> +	 * managed IRQ that is used by some drivers.
> +	 */
> +	if (vp_dev->per_vq_vectors && info->msix_vector != VIRTIO_MSI_NO_VECTOR)
> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, info->msix_vector));
> +
> +	vq->reset = true;
> +
> +	return 0;
> +}
> +
> +static int vp_modern_enable_vq_after_reset(struct virtqueue *vq)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	struct virtio_pci_vq_info *info;
> +	unsigned long flags, index;
> +	int err;
> +
> +	if (!vq->reset)
> +		return -EBUSY;
> +
> +	index = vq->index;
> +	info = vp_dev->vqs[index];
> +
> +	if (vp_modern_get_queue_reset(mdev, index))
> +		return -EBUSY;
> +
> +	if (vp_modern_get_queue_enable(mdev, index))
> +		return -EBUSY;
> +
> +	err = vp_active_vq(vq, info->msix_vector);
> +	if (err)
> +		return err;
> +
> +	if (vq->callback) {
> +		spin_lock_irqsave(&vp_dev->lock, flags);
> +		list_add(&info->node, &vp_dev->virtqueues);
> +		spin_unlock_irqrestore(&vp_dev->lock, flags);
> +	} else {
> +		INIT_LIST_HEAD(&info->node);
> +	}
> +
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> +	__virtqueue_unbreak(vq);
> +#endif
> +
> +	vp_modern_set_queue_enable(&vp_dev->mdev, index, true);
> +	vq->reset = false;
> +
> +	return 0;
> +}
> +
>   static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>   {
>   	return vp_modern_config_vector(&vp_dev->mdev, vector);
> @@ -413,6 +497,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>   	.set_vq_affinity = vp_set_vq_affinity,
>   	.get_vq_affinity = vp_get_vq_affinity,
>   	.get_shm_region  = vp_get_shm_region,
> +	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
> +	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
>   };
>   
>   static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -431,6 +517,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>   	.set_vq_affinity = vp_set_vq_affinity,
>   	.get_vq_affinity = vp_get_vq_affinity,
>   	.get_shm_region  = vp_get_shm_region,
> +	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
> +	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
>   };
>   
>   /* the PCI probing function */

