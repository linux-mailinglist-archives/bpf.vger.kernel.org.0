Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8F562F4E
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiGAJAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiGAJAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D2F186D7
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656666015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lQ6iUMnyQRqa4PGLu8+SgKnRgrhBYKLGeVI6yaxhUA=;
        b=RDjsMza4BbaVYNboiC8jjABNXleTsbHxCQr2QdOKtJy78s6cPyS5JCNi61Nb3jkL6RxDRj
        DJStoUkbw+YyefyrytWoDNRmEbiImHv4uM6+cvu5JRbMKJrtPZI2aGCDtZkaBQE2GiIS2n
        jsBeHTPOPTy6Mb3OjI1kTmnv7jp5E4I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-ivx_y-06OMiTORFZ4DJn8g-1; Fri, 01 Jul 2022 05:00:14 -0400
X-MC-Unique: ivx_y-06OMiTORFZ4DJn8g-1
Received: by mail-pj1-f69.google.com with SMTP id u6-20020a17090a1d4600b001ec8200fe70so1147280pju.1
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8lQ6iUMnyQRqa4PGLu8+SgKnRgrhBYKLGeVI6yaxhUA=;
        b=DzdngklAWhR48hPG49H1UqyhIj1HAw2Gq+aEzSaFWVIh2iiukCLV9Ql7m9pvVZojZY
         CPgz7Twmdz8gl9TaQYC4WSIMoVXx30FoN8rwf51Hc3D6vGro0IYFB/sdqPxHR4FVO1me
         JHPNepMsEmq8jNvnc/avKqaebpeLGuYJO+sY9dDgBTb90rKg0neE2VCV8HGFn158iNrp
         Z9XtdGM2OPFmWE8AdH+UpNlUUzvPi+LNB/eNZKgDtGMAcC/KJgqyHUyCs6+dzcb7Zen6
         V6N8KXlc1n0NJNAXyH8pjaz0BNO8H98onwhksi8rMIaxVF5j7MIo2md4hySlF6qozQTI
         H1xQ==
X-Gm-Message-State: AJIora837z2rog2TgD3zaBGyKBTJPXx7gPHTc9GjXQh8Okalv1JcmtKA
        M5jLjpJ/U4fxJR2eW6somSLZsqInD5ogSNg83zIXCLilai+Ts84M9B8he0I7eEPqJ7st4zps9YM
        XRuFei81UlOz/
X-Received: by 2002:a63:f102:0:b0:40d:1d1f:770c with SMTP id f2-20020a63f102000000b0040d1d1f770cmr11192892pgi.521.1656666013395;
        Fri, 01 Jul 2022 02:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urKvm6LYkWKw16uIXqxBex7xUdVqhH17lRqnYeTgkb25NL8EQ+hO2PmoLH55tznJBr8D0cFQ==
X-Received: by 2002:a63:f102:0:b0:40d:1d1f:770c with SMTP id f2-20020a63f102000000b0040d1d1f770cmr11192864pgi.521.1656666013152;
        Fri, 01 Jul 2022 02:00:13 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm15332754plg.101.2022.07.01.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:00:12 -0700 (PDT)
Message-ID: <e24fec52-72a4-caaf-e31f-0adc5a6593d7@redhat.com>
Date:   Fri, 1 Jul 2022 17:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 10/40] virtio_ring: split: extract the logic of attach
 vring
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
 <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> Separate the logic of attach vring, subsequent patches will call it
> separately.
>
> Since the "struct vring_virtqueue_split split" is created on the
> stack and has been initialized to 0. So using
> split->queue_dma_addr/split->queue_size_in_bytes assignment for
> queue_dma_addr/queue_size_in_bytes can keep the same as the original
> code.
>
> On the other hand, subsequent patches can use the "struct
> vring_virtqueue_split split" obtained by vring_alloc_queue_split() to
> directly complete the attach operation.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cedd340d6db7..9025bd373d3b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -940,6 +940,18 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> +static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
> +					 struct vring_virtqueue_split *vring)
> +{
> +	vq->split.queue_dma_addr = vring->queue_dma_addr;
> +	vq->split.queue_size_in_bytes = vring->queue_size_in_bytes;
> +
> +	vq->split.vring = vring->vring;
> +
> +	vq->split.desc_state = vring->desc_state;
> +	vq->split.desc_extra = vring->desc_extra;
> +}
> +
>   static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring)
>   {
>   	struct vring_desc_state_split *state;
> @@ -2287,10 +2299,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>   		!context;
>   
> -	vq->split.queue_dma_addr = 0;
> -	vq->split.queue_size_in_bytes = 0;
> -
> -	vq->split.vring = _vring;
>   	vq->split.avail_flags_shadow = 0;
>   	vq->split.avail_idx_shadow = 0;
>   
> @@ -2310,10 +2318,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   		return NULL;
>   	}
>   
> -	vq->split.desc_state = vring.desc_state;
> -	vq->split.desc_extra = vring.desc_extra;
> -
>   	virtqueue_init(vq, vring.vring.num);
> +	virtqueue_vring_attach_split(vq, &vring);
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);

