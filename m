Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663057C754
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGUJP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGUJPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 05:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2634420F7B
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658394953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Escg7n0ywUK4qdukC0pSCylFb7FUJQPzR61HHZ9/jsk=;
        b=YdR8+OhkYXCqebYJmKY4J3pCFDk51CUVUgiPsUTfEyYcnZTjwipKwpFYjxZFeE1Iq77GrX
        jN138psrhyRR1jQ8QHKxXRlhdyXd0v0kZhBCg7aGWevxOGMvgtO+iSYqR7GrKfZNzgB7rD
        4kPeAAYawlJCzOZUX6vfHIhQVoqRwas=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-X6aKu0UwNC-mp2EDiU3-gA-1; Thu, 21 Jul 2022 05:15:52 -0400
X-MC-Unique: X6aKu0UwNC-mp2EDiU3-gA-1
Received: by mail-pl1-f200.google.com with SMTP id s6-20020a170902a50600b0016d2e77252eso859980plq.18
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 02:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Escg7n0ywUK4qdukC0pSCylFb7FUJQPzR61HHZ9/jsk=;
        b=xEccV+6dY1MKnsR0Uc8qG+nWJjKWIs7mHw7AUgoBo0s5PwZcSWgDIQM/Gso5N9WGD7
         MMxPhnRnBbiNe4LpzRSpOPu8VFrOb0VgQGGjKem2vMV1CZb9hdrTRxQLrqHclIgTwfCq
         5iFfLxHrgs8gI/Vz75xEysCD0svSP3VEdG3ZGea4gRgsAgfy4WkCX2t8tPEW9t6nhUZz
         hEeF0Tdj0gXq4Az6BlCKP9K5YUgowhlNPDWUQRaPacLvU0cPgVxZp9+EY5bj+kgLNQvp
         G5856CZAmvdoa8w7RC23+gaAsPUwFpHShugHIlsCDplqTRVU0jnTMJuDmZmaZTgXrBU4
         FuQA==
X-Gm-Message-State: AJIora8PVCz0e7Qdc9aER2+MCtCC+E3XCEG2txjTkho584G8BTYbbKkc
        pkLjcQ958Il9P89tyEtigV5J6d7xO8JeEcrpWbLz09KMi2wCnp2tkx1p5kZEFMeKYIEz3KnhuJv
        UfTN8rSJOfwBF
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id x14-20020a056a00188e00b0052ab545559fmr43170866pfh.18.1658394949135;
        Thu, 21 Jul 2022 02:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tse0avmLLaWWihH80dsCqYgwTb5M+a/h7oTDBCS5V2QWyEFXUICi4yWw1kN7K6oki4/v7zfQ==
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id x14-20020a056a00188e00b0052ab545559fmr43170831pfh.18.1658394948796;
        Thu, 21 Jul 2022 02:15:48 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b0041239bf9be8sm1036316pga.1.2022.07.21.02.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:15:48 -0700 (PDT)
Message-ID: <14c8469c-8609-78c6-308e-a00051634ce6@redhat.com>
Date:   Thu, 21 Jul 2022 17:15:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 22/40] virtio_ring: introduce virtqueue_resize()
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
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/7/20 11:04, Xuan Zhuo 写道:
> Introduce virtqueue_resize() to implement the resize of vring.
> Based on these, the driver can dynamically adjust the size of the vring.
> For example: ethtool -G.
>
> virtqueue_resize() implements resize based on the vq reset function. In
> case of failure to allocate a new vring, it will give up resize and use
> the original vring.
>
> During this process, if the re-enable reset vq fails, the vq can no
> longer be used. Although the probability of this situation is not high.
>
> The parameter recycle is used to recycle the buffer that is no longer
> used.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
>   include/linux/virtio.h       |  3 ++
>   2 files changed, 72 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b092914e9dcd..cf4379175163 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2545,6 +2545,75 @@ struct virtqueue *vring_create_virtqueue(
>   }
>   EXPORT_SYMBOL_GPL(vring_create_virtqueue);
>   
> +/**
> + * virtqueue_resize - resize the vring of vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @num: new ring num
> + * @recycle: callback for recycle the useless buffer
> + *
> + * When it is really necessary to create a new vring, it will set the current vq
> + * into the reset state. Then call the passed callback to recycle the buffer
> + * that is no longer used. Only after the new vring is successfully created, the
> + * old vring will be released.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
> + *  vq can still work normally
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -E2BIG/-EINVAL: num error
> + * -EPERM: Operation not permitted
> + *
> + */
> +int virtqueue_resize(struct virtqueue *_vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = vq->vq.vdev;
> +	void *buf;
> +	int err;
> +
> +	if (!vq->we_own_ring)
> +		return -EPERM;
> +
> +	if (num > vq->vq.num_max)
> +		return -E2BIG;
> +
> +	if (!num)
> +		return -EINVAL;
> +
> +	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
> +		return 0;
> +
> +	if (!vdev->config->disable_vq_and_reset)
> +		return -ENOENT;
> +
> +	if (!vdev->config->enable_vq_after_reset)
> +		return -ENOENT;
> +
> +	err = vdev->config->disable_vq_and_reset(_vq);
> +	if (err)
> +		return err;
> +
> +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> +		recycle(_vq, buf);
> +
> +	if (vq->packed_ring)
> +		err = virtqueue_resize_packed(_vq, num);
> +	else
> +		err = virtqueue_resize_split(_vq, num);
> +
> +	if (vdev->config->enable_vq_after_reset(_vq))
> +		return -EBUSY;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_resize);
> +
>   /* Only available for split ring */
>   struct virtqueue *vring_new_virtqueue(unsigned int index,
>   				      unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 129bde7521e3..62e31bca5602 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>   dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>   dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf));
> +
>   /**
>    * virtio_device - representation of a device using virtio
>    * @index: unique position on the virtio bus

