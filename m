Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852254FCCCA
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiDLDAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiDLDAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 23:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C29FD27CC6
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649732309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kb270zTcKFgdb0H5CrhMTvFSHJ9sEAjIYD+VUSYpTQc=;
        b=BMvJ/N89BCRoPm2xCjmo92Pdzay1HFuy+iOb8bEGquxE8os6FR4wrquMeC0StV+8WPg45p
        fO5G1f7h5LHU5oBGH1T+K/7lsYYescDbp0QDvhDlvARi9QfopreBlMWG/ZtxepngjP8GCo
        Twq5uO5BhiEBVZ246qx/YHkGgZI4bGk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-ltCJiYy8PVChLH41e8rpYA-1; Mon, 11 Apr 2022 22:58:26 -0400
X-MC-Unique: ltCJiYy8PVChLH41e8rpYA-1
Received: by mail-pj1-f71.google.com with SMTP id mw8-20020a17090b4d0800b001c717bb058eso753578pjb.0
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kb270zTcKFgdb0H5CrhMTvFSHJ9sEAjIYD+VUSYpTQc=;
        b=n6B08yhjGYvjbaROV1jPAHFGD6eMuwpYmuaXllkoVEUeJHWewAr6jsnLsfwKaczvS3
         hb4oOcsVCu3S+9/CBK8SzU8v5GNOjZabEgsJY2QSqpG10LssVyOpjkcOHH99JiuJUDqs
         JkYlNdp/dR3O4OGFoq15ZqAfbiWhwiKvjr7DtKGWRApPlUNXurL0FeDxV2p8Vg4w8j7g
         5xLOLVJuzY3FK0QEiTZYXySZXtNanSWoaMelrH2UGEvqTPFw0yzsrUOk+IgpIseDMD6U
         /M8lTHPEjtWsF/WyoC/x9K9aHrvpo8O914GGE3qF+4pigRbxkCPWo+UDkU/wX0JJFVQ4
         kPiA==
X-Gm-Message-State: AOAM530m7KWtXiMD2T2fX8HoIY6EDg0ueyX/gb0gVofs7/GGn1pqCk54
        IpWlQpkJp+SD9itwM056kU9OkX0b6cXZWhYgvNRlncrzH1pybPYmf6nEAPnYTUrRgFwOpto8DNr
        mPHsGWaRv7GQN
X-Received: by 2002:a17:902:7c01:b0:158:3dd6:d1ba with SMTP id x1-20020a1709027c0100b001583dd6d1bamr13393394pll.120.1649732305615;
        Mon, 11 Apr 2022 19:58:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0eBbGj1OUtWYDo7mmUONDwOeZaEnnKcRCtxgJd2sVmvnSsbaW8//LNh4m+6WALJ5MiKzuew==
X-Received: by 2002:a17:902:7c01:b0:158:3dd6:d1ba with SMTP id x1-20020a1709027c0100b001583dd6d1bamr13393363pll.120.1649732305374;
        Mon, 11 Apr 2022 19:58:25 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm999882pgb.11.2022.04.11.19.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 19:58:24 -0700 (PDT)
Message-ID: <14b0c4ea-038a-8688-7ca0-4ea0ef407aba@redhat.com>
Date:   Tue, 12 Apr 2022 10:58:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 05/32] virtio_ring: extract the logic of freeing vring
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
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
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-6-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Introduce vring_free() to free the vring of vq.
>
> Subsequent patches will use vring_free() alone.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cb6010750a94..33fddfb907a6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2301,14 +2301,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>   }
>   EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>   
> -void vring_del_virtqueue(struct virtqueue *_vq)
> +static void vring_free(struct virtqueue *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
>   
> -	spin_lock(&vq->vq.vdev->vqs_list_lock);
> -	list_del(&_vq->list);
> -	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> -
>   	if (vq->we_own_ring) {
>   		if (vq->packed_ring) {
>   			vring_free_queue(vq->vq.vdev,
> @@ -2339,6 +2335,18 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>   		kfree(vq->split.desc_state);
>   		kfree(vq->split.desc_extra);
>   	}
> +}
> +
> +void vring_del_virtqueue(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	spin_lock(&vq->vq.vdev->vqs_list_lock);
> +	list_del(&_vq->list);
> +	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> +
> +	vring_free(_vq);
> +
>   	kfree(vq);
>   }
>   EXPORT_SYMBOL_GPL(vring_del_virtqueue);

