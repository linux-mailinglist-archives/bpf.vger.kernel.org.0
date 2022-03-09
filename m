Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1542B4D2AD8
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 09:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiCIIsf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 03:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiCIIse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 03:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C972DF46
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 00:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646815652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ffS413S/InwxV5O0x2uo8HI1Zzb6CIePH7gzRiVJ4s=;
        b=Rwu3uEKXiY3vULpMLR0RIcM/P/wSI4F1NJkTUIWktGlJU9Eq3ESjd4L3dsZfrDYzMFMEuN
        WSfhYG63Qw8+iDjrwvNPVNglT7dr36vvxpvvWk+Id7csxdHqd6zzDHe9yuyoEE1QBCzq3G
        CVOFoQNo3X1fRk4PA40/BpLQXE0EbeU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-CDbNl7-yNNuWUsi1J6J5kg-1; Wed, 09 Mar 2022 03:47:31 -0500
X-MC-Unique: CDbNl7-yNNuWUsi1J6J5kg-1
Received: by mail-pl1-f200.google.com with SMTP id e13-20020a17090301cd00b00150145346f9so799491plh.23
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 00:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ffS413S/InwxV5O0x2uo8HI1Zzb6CIePH7gzRiVJ4s=;
        b=l7VjkEavQo6aIpIh5L7jP5Yronb+wwXHphe2LUtpBPgAx5OUSMl5oRR8M0X41tYDFw
         DDY1cWHGB8s6TqrSZ28fVKgb1FONUu/qPnPG98YUX5keFV8YL2CKHaiXeKAPTblOcRCI
         qFYk0f6f7Cb4faiaFf3D1hFD/bY5V+Vmxj8+bQ0eALB7VKtdpxna2vqcb9orsofudTNC
         5ZpUU58CduQjSGnSW85KPXwtC9/9CuJrOVDb30oIOhWtHA1nEDpxM1FMIUfaKyd8ZzX4
         Z/33FAxTTrgXu+THCcmAqXTgqCbdazl4RcoyTxT/wrSWTZXKA1/AdPtJROL4SUezX21n
         cG+A==
X-Gm-Message-State: AOAM530WVfIcj3+uMbmAbPGqeoyBJaXtph1M9gb4CBuCByE2I7aUCt+3
        LPX9rX017lzN2Wi7/GhPt80qJQ9/M6rUvBqsugk/lmkTnW/ws88rZTQolyA13lBxWEthJwcuPDb
        zcsbKahrZ5mDD
X-Received: by 2002:a63:4756:0:b0:373:e14b:5848 with SMTP id w22-20020a634756000000b00373e14b5848mr17589434pgk.337.1646815649942;
        Wed, 09 Mar 2022 00:47:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8AxlCNXVWTVj7iH9SvFqBnT+ALE8NBgyTqiezfIt6S/mnWP42+w8t2ODBwFju+xJKaGATOA==
X-Received: by 2002:a63:4756:0:b0:373:e14b:5848 with SMTP id w22-20020a634756000000b00373e14b5848mr17589411pgk.337.1646815649649;
        Wed, 09 Mar 2022 00:47:29 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l17-20020a637011000000b0037d5eac87e3sm1577760pgc.18.2022.03.09.00.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:47:29 -0800 (PST)
Message-ID: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
Date:   Wed, 9 Mar 2022 16:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/3/8 下午8:35, Xuan Zhuo 写道:
> Performing reset on a queue is divided into four steps:
>
>   1. reset_vq()                     - notify the device to reset the queue
>   2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
>   3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
>   4. enable_reset_vq()              - mmap vring to device, and enable the queue
>
> So add two callbacks reset_vq, enable_reset_vq to struct
> virtio_config_ops.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   include/linux/virtio_config.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4d107ad31149..d51906b1389f 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -74,6 +74,15 @@ struct virtio_shm_region {
>    * @set_vq_affinity: set the affinity for a virtqueue (optional).
>    * @get_vq_affinity: get the affinity for a virtqueue (optional).
>    * @get_shm_region: get a shared memory region based on the index.
> + * @reset_vq: reset a queue individually (optional).
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	Caller should guarantee that the vring is not accessed by any functions
> + *	of virtqueue.


We probably need to be more accurate here:

1) reset_vq will guarantee that the callbacks are disabled or synchronized
2) except for the callback, the caller should guarantee ...

Thanks


> + * @enable_reset_vq: enable a reset queue
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	If reset_vq is set, then enable_reset_vq must also be set.
>    */
>   typedef void vq_callback_t(struct virtqueue *);
>   struct virtio_config_ops {
> @@ -100,6 +109,8 @@ struct virtio_config_ops {
>   			int index);
>   	bool (*get_shm_region)(struct virtio_device *vdev,
>   			       struct virtio_shm_region *region, u8 id);
> +	int (*reset_vq)(struct virtqueue *vq);
> +	int (*enable_reset_vq)(struct virtqueue *vq);
>   };
>   
>   /* If driver didn't advertise the feature, it will never appear. */

