Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2E562F5B
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGAJBJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGAJBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B0991C92E
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656666061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Pfa1YaU+250DlLqgk/RZjJpc0atpStbB6YSlMBczcM=;
        b=cfyP75+8zLg2oYJp7CJswZLJpsTbl6vLrazas3Sxa7ZiPYIy0r/DoRF+dNhWVF8sH0u/wp
        OO9ofkNjWCY6BliV3aNRkz4h+EkTmAv+qm3aZbWuJvXhJJfmt0IAc3VdYjdclkCq+Grett
        4UounPdX2dUzRzuzI+joRqITTIcO098=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-0X2GF7tLNnq6y2fy9A82oA-1; Fri, 01 Jul 2022 05:01:00 -0400
X-MC-Unique: 0X2GF7tLNnq6y2fy9A82oA-1
Received: by mail-pg1-f197.google.com with SMTP id t142-20020a635f94000000b0040d27168bf7so1013877pgb.20
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Pfa1YaU+250DlLqgk/RZjJpc0atpStbB6YSlMBczcM=;
        b=2BrRvWCFnVWju6C/7Y2engKbL97tWDuz41bvl9vBYN4hVqZQ53Wj9G/QW2q9KISqRq
         z+qslzp3Bvl4CVULiL8zKK45MA3xiLXD1eYNXSDz39Kgbhdn/WtqCybRWGL71sSsiptd
         aEI54sZRM2+PjoJnaUL0xJ7kUqG1oNhk2pFjbpVlVO8YB1vyBJB+LcKRqIpX9sYbTWka
         DTYSZR/rr9Hwfr9ljGRjksR+ngq8oTKPrgUtjeBhPT9H/Ld9/9imhFldiYXL0a50EsUC
         ZC8ItWVGJojEhanKeQUbdPs+MHWqZSH8Qw/IUQfxa2k8cqBxBkx4M80eWEHHmX5pe0Bt
         EPoA==
X-Gm-Message-State: AJIora+k07M9yDJmkFOvoMufTiNcAUXxyuG8syxJBrXsLvYzesJg9oVT
        ymuOzLez03C6O40Zw0dxda/Sq+218h+rhAXLYtmrZNrN5eXduoK3qG3qDnrgRA7hlE9EXJth8po
        GzaMBne8gBc3N
X-Received: by 2002:a17:90b:4c4d:b0:1ec:bb28:9819 with SMTP id np13-20020a17090b4c4d00b001ecbb289819mr15145844pjb.140.1656666059269;
        Fri, 01 Jul 2022 02:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ucPJubIDOfAC58GNC+QtWFq5Jmmypvil1fzM2cvP6k6UqH+HE5csI2QsEYjQoPJIF0N0566w==
X-Received: by 2002:a17:90b:4c4d:b0:1ec:bb28:9819 with SMTP id np13-20020a17090b4c4d00b001ecbb289819mr15145815pjb.140.1656666059033;
        Fri, 01 Jul 2022 02:00:59 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b00169071538a0sm14858030plb.267.2022.07.01.02.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:00:58 -0700 (PDT)
Message-ID: <cbdd2030-a4b3-afdd-b22d-cb8223524b20@redhat.com>
Date:   Fri, 1 Jul 2022 17:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 11/40] virtio_ring: split: extract the logic of vring
 init
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
 <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
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
> Separate the logic of initializing vring, and subsequent patches will
> call it separately.
>
> This function completes the variable initialization of split vring. It
> together with the logic of atatch constitutes the initialization of
> vring.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9025bd373d3b..35540daaa1e7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -940,6 +940,24 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> +static void virtqueue_vring_init_split(struct vring_virtqueue *vq)
> +{
> +	struct virtio_device *vdev;
> +
> +	vdev = vq->vq.vdev;
> +
> +	vq->split.avail_flags_shadow = 0;
> +	vq->split.avail_idx_shadow = 0;
> +
> +	/* No callback?  Tell other side not to bother us. */
> +	if (!vq->vq.callback) {
> +		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
> +					vq->split.avail_flags_shadow);
> +	}
> +}
> +
>   static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
>   					 struct vring_virtqueue_split *vring)
>   {
> @@ -2299,17 +2317,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>   		!context;
>   
> -	vq->split.avail_flags_shadow = 0;
> -	vq->split.avail_idx_shadow = 0;
> -
> -	/* No callback?  Tell other side not to bother us. */
> -	if (!callback) {
> -		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
> -					vq->split.avail_flags_shadow);
> -	}
> -
>   	vring.vring = _vring;
>   
>   	err = vring_alloc_state_extra_split(&vring);
> @@ -2320,6 +2327,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   
>   	virtqueue_init(vq, vring.vring.num);
>   	virtqueue_vring_attach_split(vq, &vring);
> +	virtqueue_vring_init_split(vq);
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);

