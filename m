Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E4B7F20
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 05:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiBPEOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 23:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244884AbiBPEOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 23:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A50C70F43
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644984858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZzXDlkg8qpp836DOF70vnwiHmJbthJI/zN4W9Z2xN8=;
        b=EzdNMmtv5Rd/qO95LWSBe5maMaYMu6wMmHd8lLeXFREnlEwQpCWUNF0ydUfPaDdcXdjeuk
        K0Dpk/5DbGS6MfBCnHOCV49yRUd+2kWWmhfnkURhPBniwYYMem330KktIAolqONJOCfDNs
        2Fx75dqlUHkcCXt6FcAbNuGMS23bSVk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-qx_retiEMXyLypv4-TcVNA-1; Tue, 15 Feb 2022 23:14:16 -0500
X-MC-Unique: qx_retiEMXyLypv4-TcVNA-1
Received: by mail-lf1-f69.google.com with SMTP id c25-20020a056512325900b0043fc8f2e1f6so272006lfr.6
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZzXDlkg8qpp836DOF70vnwiHmJbthJI/zN4W9Z2xN8=;
        b=q0NLKQfE2h42v+TN0urhHRl98CVrOsi7OHBMaF9ecaDtV/05F4aMJ5jRN5p3bEG0Ef
         1aQptgFhsUpZsLc8q0aPMhzW3/vTDprz1qoeYb2lkALouHlbgrUpiWSImgLNqZLnFhnv
         67eS3rAdl7ETEioKhVezLPdv/6HC2eaD1k5z8ZAPMUpOqYibPjl9LgQGF3krS9NmCEIq
         wGstYV2Db+o5tANBEH0+BFTTSjUb8u56AAvyyhponFFEUCDnAKUBKPLSdk9lzmp6w44P
         LEVVviRFTiPQRccNok8GU9d/ltBBu8rSghkQTPmPPr2FIUbc9BiOQpmwDXhxY3zxLy5h
         AYlg==
X-Gm-Message-State: AOAM531FEf+0lRvc5hLHl1n1gpPLX2MOeiW0acIDYEELuyAzzdaaz7vg
        oWlAPxzl2q1/AKjFRcCiDkk1zpdLyxbOJS79Qs+442RsyoypkagIASoqD1FxZlBUYSQ5wxzFfmn
        9aPK24R6JtcmRtEY4RFTm9xBF6YsQ
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id a18-20020ac25052000000b00443146654d1mr695785lfm.348.1644984855432;
        Tue, 15 Feb 2022 20:14:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCAG1I3PjRcaajqL3n64IiD74nD8SpMkMRtyRZkpOu/QbR/KwjGOeEPPB35QpIuFZlxJwaBkCDwPf6m6r5XE8=
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id
 a18-20020ac25052000000b00443146654d1mr695771lfm.348.1644984855160; Tue, 15
 Feb 2022 20:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com> <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 12:14:04 +0800
Message-ID: <CACGkMEsdySbtHN4SNSmX8sD6Y7S=dj3oxq5a3EBhRG1qUeT24A@mail.gmail.com>
Subject: Re: [PATCH v5 19/22] virtio: add helper virtio_set_max_ring_num()
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 4:15 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Added helper virtio_set_max_ring_num() to set the upper limit of ring
> num when creating a virtqueue.
>
> Can be used to limit ring num before find_vqs() call. Or change ring num
> when re-enable reset queue.

Do we have a chance that RX and TX may want different ring size? If
yes, it might be even better to have per vq limit via find_vqs()?

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c  |  6 ++++++
>  include/linux/virtio.h        |  1 +
>  include/linux/virtio_config.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1a123b5e5371..a77a82883e44 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -943,6 +943,9 @@ static struct virtqueue *vring_create_virtqueue_split(
>         size_t queue_size_in_bytes;
>         struct vring vring;
>
> +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> +               num = vdev->max_ring_num;
> +
>         /* We assume num is a power of 2. */
>         if (num & (num - 1)) {
>                 dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
> @@ -1692,6 +1695,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>         size_t ring_size_in_bytes, event_size_in_bytes;
>
> +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> +               num = vdev->max_ring_num;
> +
>         ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
>
>         ring = vring_alloc_queue(vdev, ring_size_in_bytes,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1153b093c53d..45525beb2ec4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -127,6 +127,7 @@ struct virtio_device {
>         struct list_head vqs;
>         u64 features;
>         void *priv;
> +       u16 max_ring_num;
>  };
>
>  static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index cd7f7f44ce38..d7cb2d0341ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -200,6 +200,36 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>         return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  }
>
> +/**
> + * virtio_set_max_ring_num - set max ring num
> + * @vdev: the device
> + * @num: max ring num. Zero clear the limit.
> + *
> + * When creating a virtqueue, use this value as the upper limit of ring num.
> + *
> + * Returns 0 on success or error status
> + */
> +static inline
> +int virtio_set_max_ring_num(struct virtio_device *vdev, u16 num)
> +{

Having a dedicated helper for a per device parameter usually means the
use cases are greatly limited. For example, this seems can only be
used when DRIVER_OK is not set?

And in patch 17 this function is called even if we only modify the RX
size, this is probably another call for a more flexible API as I
suggest like exporting vring allocation/deallocation helper and extend
find_vqs()?

Thanks


> +       if (!num) {
> +               vdev->max_ring_num = num;
> +               return 0;
> +       }
> +
> +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +               if (!is_power_of_2(num)) {
> +                       num = __rounddown_pow_of_two(num);
> +
> +                       if (!num)
> +                               return -EINVAL;
> +               }
> +       }
> +
> +       vdev->max_ring_num = num;
> +       return 0;
> +}
> +
>  static inline
>  struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
>                                         vq_callback_t *c, const char *n)
> --
> 2.31.0
>

