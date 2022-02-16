Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36C4B7F3B
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 05:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiBPEPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 23:15:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbiBPEPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 23:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3206FCB76
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644984890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DC/9cJ1rnmLdF2qNbTho1YXwyhPBz3aGkzgrZwTS3o8=;
        b=bI3ZXGAdwcmbB2rrD4p6rVvwB9WyFq6HAAlLJrjMS00dnlogTpq/iVC1k31HRqJrDJVxf9
        PNJZi2RuRcJiDuwDK44qqNXm1aKnRxoBl3pmwXp71+3vtow2GwcXgJA+BvuDD7ZgUvBh5w
        yYDXAm0hWArBmQ7XIIgvh3IkJN77C1g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-HOWSTiJANhGIKtA5IX9rzA-1; Tue, 15 Feb 2022 23:14:48 -0500
X-MC-Unique: HOWSTiJANhGIKtA5IX9rzA-1
Received: by mail-lj1-f200.google.com with SMTP id b17-20020a05651c0b1100b00244b873c6easo462413ljr.4
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DC/9cJ1rnmLdF2qNbTho1YXwyhPBz3aGkzgrZwTS3o8=;
        b=DNiGO5Ykz+Ns/HSC6NEu9j+3TR0jEG32o5diSJ5IRxminjHx0xto9FTGglkwLWBSVg
         Awwu+FbcPB+1N9L2mZmtBgeFh/b+Ow7vUQH5YDrPfEIyqvmhEtcdUMk6YtkEv1DRLLcK
         zPSzxDtsbjAJbMFa+RQ8wZ1Jod5wxytsiwRK2mOHN6xsD84jXL9nzNT0hZxIUFJ3ryon
         dT6ONDRZE1FO25A7YeOIxP7XCrL16Isjh058JQJQd4S5r96d83Nh5sYJF6TQ4QH+r3DS
         VVM16BJbNHVvVj/B2SsG6MYu71g0YxrpyFvr8OZQ70SVjDHvJpgcMpi54OfjRTRb23rt
         JSuw==
X-Gm-Message-State: AOAM530bN7/v9oXZKYutnPAZyb93aYaHhaOI2yEuzBdQiCZ4E1cptaAE
        8co/L/jtUrOUCUH+lBRqT3CmUbgnJ0o5PhnBZCGSVjDlYg7X3NDRcafB4LDmjJK3Rwh0KdKf2ip
        vue5zv/XHA8wvoUCdpqff/crqIIjn
X-Received: by 2002:a2e:b748:0:b0:245:fcd6:c4a3 with SMTP id k8-20020a2eb748000000b00245fcd6c4a3mr697744ljo.362.1644984887133;
        Tue, 15 Feb 2022 20:14:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgeUs3QA39CjiR99ZEeCfiGPEBhNSb5QEYePt31lVdV4ggOPIjPfM5qmPh3/hI8KyMESfuk+OJIcQQZtdXga4=
X-Received: by 2002:a2e:b748:0:b0:245:fcd6:c4a3 with SMTP id
 k8-20020a2eb748000000b00245fcd6c4a3mr697738ljo.362.1644984886923; Tue, 15 Feb
 2022 20:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com> <20220214081416.117695-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-9-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 12:14:36 +0800
Message-ID: <CACGkMEttDpjYZcsT7Eh0Nm50R27nTBOLDFwBaSKsJ+OL1x26vg@mail.gmail.com>
Subject: Re: [PATCH v5 08/22] virtio_ring: queue_reset: add vring_release_virtqueue()
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Added vring_release_virtqueue() to release the ring of the vq.
>
> In this process, vq is removed from the vdev->vqs queue. And the memory
> of the ring is released
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 +++++++++++++++++-
>  include/linux/virtio.h       | 12 ++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5dd17c7dd4a..b37753bdbbc4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1730,6 +1730,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->vq.vdev = vdev;
>         vq->vq.num_free = num;
>         vq->vq.index = index;
> +       vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;

So we don't have a similar check for detach_unused_buf(), I guess it
should be sufficient to document the API requirement. Otherwise we
probably need some barriers/ordering which are not worthwhile just for
figuring out bad API usage.

>         vq->we_own_ring = true;
>         vq->notify = notify;
>         vq->weak_barriers = weak_barriers;
> @@ -2218,6 +2219,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
>         vq->vq.vdev = vdev;
>         vq->vq.num_free = vring.num;
>         vq->vq.index = index;
> +       vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;
>         vq->we_own_ring = false;
>         vq->notify = notify;
>         vq->weak_barriers = weak_barriers;
> @@ -2397,11 +2399,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       __vring_del_virtqueue(vq);
> +       if (_vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
> +               __vring_del_virtqueue(vq);
>         kfree(vq);
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>
> +void vring_release_virtqueue(struct virtqueue *_vq)
> +{

If we agree on that we need a allocation routine, we probably need to
rename this as vring_free_virtqueue()

Thanks

> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +       if (_vq->reset != VIRTQUEUE_RESET_STAGE_DEVICE)
> +               return;
> +
> +       __vring_del_virtqueue(vq);
> +
> +       _vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
> +}
> +EXPORT_SYMBOL_GPL(vring_release_virtqueue);
> +
>  /* Manipulates transport-specific feature bits. */
>  void vring_transport_features(struct virtio_device *vdev)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 72292a62cd90..cdb2a551257c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -10,6 +10,12 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
>
> +enum virtqueue_reset_stage {
> +       VIRTQUEUE_RESET_STAGE_NONE,
> +       VIRTQUEUE_RESET_STAGE_DEVICE,
> +       VIRTQUEUE_RESET_STAGE_RELEASE,
> +};
> +
>  /**
>   * virtqueue - a queue to register buffers for sending or receiving.
>   * @list: the chain of virtqueues for this device
> @@ -32,6 +38,7 @@ struct virtqueue {
>         unsigned int index;
>         unsigned int num_free;
>         void *priv;
> +       enum virtqueue_reset_stage reset;
>  };
>
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> @@ -196,4 +203,9 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
> +/*
> + * Resets a virtqueue. Just frees the ring, not free vq.
> + * This function must be called after reset_vq().
> + */
> +void vring_release_virtqueue(struct virtqueue *vq);
>  #endif /* _LINUX_VIRTIO_H */
> --
> 2.31.0
>

