Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E78562F2B
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiGAIzZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiGAIzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 04:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 784FC1BE84
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656665722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkjeVHLiRKnGx+SDkOMpqWolwraAwFwTa3XTNY2+eNo=;
        b=BiQ/niCXleD3uwPY3G3/np0TOzvcBKs/6U+ORi5JCLm4ojnjbdjqdA5hVJo07MMgH7JZTV
        PQ3wCKBxdHEZHlB3JavXIalOGsXa2zusxR71uAQ2rciP2PqOfw2nA0Ad5cZoxMIY8/Upoi
        nN58IUusREzSIf5IjihKykW1pIe1zLk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-lRvh__HTPXy-Rm1eoHtaow-1; Fri, 01 Jul 2022 04:55:21 -0400
X-MC-Unique: lRvh__HTPXy-Rm1eoHtaow-1
Received: by mail-pl1-f200.google.com with SMTP id b13-20020a170902e94d00b001692fd82122so1147917pll.14
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 01:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lkjeVHLiRKnGx+SDkOMpqWolwraAwFwTa3XTNY2+eNo=;
        b=qNQr2evDIbFJCQBnCS8DTvbWfvSfm1X76lANwAcy8kd3B/c/ZQxkSaAwruHkYIh0ce
         NT7sAfaMEptR4CuOHw7ZhG07N145MP6DwOGtMAQOinHsqy39HPGXSWpR+k4oLSsO9DzW
         DojmgYGqLOk/P3YnQWdHDEkcmM3OEWumwrOUzNuvthq/c75C6KHzaUd8Ar+97kCYsDVs
         3oVBJNNRzsphRHv5aYzJLeIMoX6591uYKzZMIQEFxGaBRNgsKeWMU9F9RiPVKxNj5ajv
         F9NdpnKMruwAevVTxbKpNOuAAwTmR6RRSEHLcVedqSekeW164ZWauNmqAtaklj60NvKZ
         q4WQ==
X-Gm-Message-State: AJIora8xmtKIoLr+pxG/wtOBoi58/UPYTFSvfryCC6aPuWtnryNqYxSr
        lhIHxbst3MqBcyPs3NohkUU47JhbCFnz+0k1MSVNLw9JP1YZSzQmQBzoUgvVu6j+x57aUX333lH
        0zov04PfUhTk1
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id l3-20020a170903244300b0016a2b657eddmr18561888pls.20.1656665719996;
        Fri, 01 Jul 2022 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sLP/MnYa3Xp+qYQJlIuiumTLO6KyhDeS6ZBk4hW4qZwr9I7787jFOGOD5WGdVtJecP+R32Tg==
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id l3-20020a170903244300b0016a2b657eddmr18561866pls.20.1656665719734;
        Fri, 01 Jul 2022 01:55:19 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b001663e1881ecsm14988996pln.306.2022.07.01.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 01:55:19 -0700 (PDT)
Message-ID: <c4d24e5c-1a3e-e577-462e-c9ebde90d659@redhat.com>
Date:   Fri, 1 Jul 2022 16:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 09/40] virtio_ring: split: extract the logic of alloc
 state and extra
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
 <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> Separate the logic of creating desc_state, desc_extra, and subsequent
> patches will call it independently.
>
> Since only the structure vring is passed into __vring_new_virtqueue(),
> when creating the function vring_alloc_state_extra_split(), we prefer to
> use vring_virtqueue_split as a parameter, and it will be more convenient
> to pass vring_virtqueue_split to some subsequent functions.
>
> So a new vring_virtqueue_split variable is added in
> __vring_new_virtqueue().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 58 +++++++++++++++++++++++++-----------
>   1 file changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a9ceb9c16c54..cedd340d6db7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -204,6 +204,7 @@ struct vring_virtqueue {
>   #endif
>   };
>   
> +static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>   
>   /*
>    * Helpers.
> @@ -939,6 +940,32 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> +static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring)
> +{
> +	struct vring_desc_state_split *state;
> +	struct vring_desc_extra *extra;
> +	u32 num = vring->vring.num;
> +
> +	state = kmalloc_array(num, sizeof(struct vring_desc_state_split), GFP_KERNEL);
> +	if (!state)
> +		goto err_state;
> +
> +	extra = vring_alloc_desc_extra(num);
> +	if (!extra)
> +		goto err_extra;
> +
> +	memset(state, 0, num * sizeof(struct vring_desc_state_split));
> +
> +	vring->desc_state = state;
> +	vring->desc_extra = extra;
> +	return 0;
> +
> +err_extra:
> +	kfree(state);
> +err_state:
> +	return -ENOMEM;
> +}
> +
>   static void vring_free_split(struct vring_virtqueue_split *vring,
>   			     struct virtio_device *vdev)
>   {
> @@ -2224,7 +2251,7 @@ EXPORT_SYMBOL_GPL(vring_interrupt);
>   
>   /* Only available for split ring */
>   struct virtqueue *__vring_new_virtqueue(unsigned int index,
> -					struct vring vring,
> +					struct vring _vring,
>   					struct virtio_device *vdev,
>   					bool weak_barriers,
>   					bool context,
> @@ -2232,7 +2259,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   					void (*callback)(struct virtqueue *),
>   					const char *name)
>   {
> +	struct vring_virtqueue_split vring = {};


Nit: to reduce the change-set, let's use vring_split here?

Other looks good.

Thanks


>   	struct vring_virtqueue *vq;
> +	int err;
>   
>   	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>   		return NULL;
> @@ -2261,7 +2290,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	vq->split.queue_dma_addr = 0;
>   	vq->split.queue_size_in_bytes = 0;
>   
> -	vq->split.vring = vring;
> +	vq->split.vring = _vring;
>   	vq->split.avail_flags_shadow = 0;
>   	vq->split.avail_idx_shadow = 0;
>   
> @@ -2273,30 +2302,23 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   					vq->split.avail_flags_shadow);
>   	}
>   
> -	vq->split.desc_state = kmalloc_array(vring.num,
> -			sizeof(struct vring_desc_state_split), GFP_KERNEL);
> -	if (!vq->split.desc_state)
> -		goto err_state;
> +	vring.vring = _vring;
>   
> -	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
> -	if (!vq->split.desc_extra)
> -		goto err_extra;
> +	err = vring_alloc_state_extra_split(&vring);
> +	if (err) {
> +		kfree(vq);
> +		return NULL;
> +	}
>   
> -	memset(vq->split.desc_state, 0, vring.num *
> -			sizeof(struct vring_desc_state_split));
> +	vq->split.desc_state = vring.desc_state;
> +	vq->split.desc_extra = vring.desc_extra;
>   
> -	virtqueue_init(vq, vq->split.vring.num);
> +	virtqueue_init(vq, vring.vring.num);
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);
>   	spin_unlock(&vdev->vqs_list_lock);
>   	return &vq->vq;
> -
> -err_extra:
> -	kfree(vq->split.desc_state);
> -err_state:
> -	kfree(vq);
> -	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
>   

