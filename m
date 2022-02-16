Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6324B7F28
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbiBPEOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 23:14:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245712AbiBPEOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 23:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A01BC75E64
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644984873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3b3uR5MMPzm1En/lQgKQ0CsRJyNewt+DAjMnvVIPGk=;
        b=JVu4MjmofYxcmO7//XTnAbPV0QeSHEj1Xb2A11wUnrbU6gXP3IKQhB7DFU//wbmy2U/9YV
        eZ6t1EvtR6A0BiU1iR0cIGXcgmCjj9pZpYAiaBGVDK7n+zUCN2BkM0fOYn+GYKsL2WvY6o
        2tuTGJflpwUApqA7d/ybUgXuvCzEga8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-fIMmpfv_OHqExD928dCrMg-1; Tue, 15 Feb 2022 23:14:32 -0500
X-MC-Unique: fIMmpfv_OHqExD928dCrMg-1
Received: by mail-lj1-f200.google.com with SMTP id p10-20020a2ea4ca000000b0023c8545494fso466523ljm.2
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3b3uR5MMPzm1En/lQgKQ0CsRJyNewt+DAjMnvVIPGk=;
        b=Oc2wECz60w6MgJvtzc6XRvRsSjkT1bMMSxFScTnu9f1LhXq3lOVXg+pv4UU0r1pWGV
         AHz4yd7jQWfTG8DwuXrQ7xzLbG+L/cWltod0b3yCvMnZnAf9Su9mB8mlwRuehVzqgpTl
         I04IgmUNjGuTcs6Z7dSQXEg6JmcgqYSCdQo3Tsuq+JM/Y6004aTrKnuuLTmOUIdxiaHY
         POIKwucWGdSz7jYRzZ33u9r8gvEHW7W6n8JDfsestZPprKgBLSnO2s9/DexqhNwvUmIW
         xtloLuCsnWjE5Nuui4ZVCCfM8rykzBNPBIechiV4XJNyjzsI1uEOKuCBVS7CHhBzPppH
         vKog==
X-Gm-Message-State: AOAM532r206u7ZZi5FeMAVJ+W5KPRTlg189bT9BwdL7j/4OfG6XC9hEp
        qkVWusy9/B8SWJWHld+vg19Jn9GZDtJ2vr3BF4HEonp04W2YLwgEb2mQWMUSfXD3VKOGHCaM2tP
        N94XXsvRqXp4r0pNyip11zsYfJrC0
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id cf8-20020a056512280800b0043f4baa7e5fmr679412lfb.498.1644984870822;
        Tue, 15 Feb 2022 20:14:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvGQ/nnJgLPQUQhwuqE8vh7JijE6JMtt5Dan0917QmW8EwCohodifZ+blu+a5ngcwNhPqmxW/s7gwTwysBlsY=
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr679397lfb.498.1644984870621; Tue, 15
 Feb 2022 20:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com> <20220214081416.117695-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-7-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 12:14:19 +0800
Message-ID: <CACGkMEt_WcAzcxYGyEvX8zATrbzxmMZzCJYhW_gsML0Ge5xvEA@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] virtio_ring: queue_reset: packed: support enable
 reset queue
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
> The purpose of this patch is to make vring packed support re-enable reset
> vq.
>
> Based on whether the incoming vq passed by vring_setup_virtqueue() is
> NULL or not, distinguish whether it is a normal create virtqueue or
> re-enable a reset queue.
>
> When re-enable a reset queue, reuse the original callback, name, indirect.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4639e1643c78..20659f7ca582 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1683,7 +1683,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         bool context,
>         bool (*notify)(struct virtqueue *),
>         void (*callback)(struct virtqueue *),
> -       const char *name)
> +       const char *name,
> +       struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq;
>         struct vring_packed_desc *ring;
> @@ -1713,13 +1714,20 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         if (!device)
>                 goto err_device;
>
> -       vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> -       if (!vq)
> -               goto err_vq;
> +       if (_vq) {
> +               vq = to_vvq(_vq);
> +       } else {
> +               vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> +               if (!vq)
> +                       goto err_vq;
> +
> +               vq->vq.callback = callback;
> +               vq->vq.name = name;
> +               vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> +                       !context;
> +       }

The code looks tricky. Except for the memory we don't even need to
touch any of the other attributes.

I'd suggest splitting out the vring allocation into a dedicated helper
that could be called by both vring_create_queue_XXX and the enable()
logic (and in the enable logic we don't even need to relocate if size
is not changed).

Thanks

>
> -       vq->vq.callback = callback;
>         vq->vq.vdev = vdev;
> -       vq->vq.name = name;
>         vq->vq.num_free = num;
>         vq->vq.index = index;
>         vq->we_own_ring = true;
> @@ -1736,8 +1744,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->last_add_time_valid = false;
>  #endif
>
> -       vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> -               !context;
>         vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>
>         if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> @@ -1778,7 +1784,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>                 goto err_desc_extra;
>
>         /* No callback?  Tell other side not to bother us. */
> -       if (!callback) {
> +       if (!vq->vq.callback) {
>                 vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>                 vq->packed.vring.driver->flags =
>                         cpu_to_le16(vq->packed.event_flags_shadow);
> @@ -1792,7 +1798,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  err_desc_extra:
>         kfree(vq->packed.desc_state);
>  err_desc_state:
> -       kfree(vq);
> +       if (!_vq)
> +               kfree(vq);
>  err_vq:
>         vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
>  err_device:
> @@ -2317,7 +2324,7 @@ struct virtqueue *vring_setup_virtqueue(
>         if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>                 return vring_create_virtqueue_packed(index, num, vring_align,
>                                 vdev, weak_barriers, may_reduce_num,
> -                               context, notify, callback, name);
> +                               context, notify, callback, name, vq);
>
>         return vring_create_virtqueue_split(index, num, vring_align,
>                         vdev, weak_barriers, may_reduce_num,
> --
> 2.31.0
>

