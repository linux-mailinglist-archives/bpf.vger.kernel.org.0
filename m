Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4502581E9D
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 06:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiG0EYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiG0EYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 00:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B8AB3B966
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658895878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yok+W8J1zKJN3VSngD/6A5xyt1kdGDnR3MRcZGx2JdM=;
        b=GXbzbq6Yn0nxpxgV8laBdeqo3LDMWiEwHWTb0R8WlnG6Jlv+zPTheRmdcsXee1lPPDPN5h
        eNrnSxLUzILjxaNXhP+vLLoDMkNSz98FHeNRHdcjKHYz1MVvI7zfi5E1eSZv9/1tTAQyKA
        NnfGo7D9+TgMhfMtJLxQ5cdLXJ8T9qg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-iOlTN1jZNjOkv6zsFEs_Dg-1; Wed, 27 Jul 2022 00:24:37 -0400
X-MC-Unique: iOlTN1jZNjOkv6zsFEs_Dg-1
Received: by mail-pg1-f197.google.com with SMTP id o10-20020a655bca000000b00412787983b3so7324966pgr.12
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 21:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yok+W8J1zKJN3VSngD/6A5xyt1kdGDnR3MRcZGx2JdM=;
        b=Lkc4ClW924VQBsQbCJMbjj6OCozGDmdqCJytpJ23ZThbNgam2TqscpoH98FVojTjva
         4yLCG96awMayUov6aNBbxg2idY6dhmHqhwdFMoykouZXEZVHzOF3RxWbkE4cWgzuX6Jv
         hXiZucCrv5TAso+s260a0iY6guTBXS3VKs4Oaz4lGVCvI410Hu8mFAF29c6dlabovVEM
         UOEKf11hiIP1VINeVn/LwcQw3Dlu9CCq3+RXAhqxYOldEfDXMmf8ggmliBkzhzcA/ZEJ
         uHO3sA24HxfeudpvXSZkiNolhc9wQ61S1pKt1ozsTtun1Iw+BbqkpcECUdf4qiXv/jP8
         Csig==
X-Gm-Message-State: AJIora/lobgdaqIZaTKka1yBp2N430RYAHkp06bmIwrWj+TFrCgxiN0S
        4RXDiCmfcdo/Ndh2Ry4x0v6FoNgUQvNb9XMUxd4vgFfpSu5SSg3IUYlkCCYKp00D21rGCLsr7qC
        V/Kbswa2MGAsf
X-Received: by 2002:a17:90a:ea90:b0:1f2:81cd:1948 with SMTP id h16-20020a17090aea9000b001f281cd1948mr2513893pjz.172.1658895875897;
        Tue, 26 Jul 2022 21:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shgnF0FTkAghWAebt2dLxHjIMnalV8dd87lEKXX5Ir9vcvUUz2DeWLC6lS50voh4OTJ1rbZA==
X-Received: by 2002:a17:90a:ea90:b0:1f2:81cd:1948 with SMTP id h16-20020a17090aea9000b001f281cd1948mr2513861pjz.172.1658895875684;
        Tue, 26 Jul 2022 21:24:35 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ik1-20020a170902ab0100b0016c48c52ce4sm12556176plb.204.2022.07.26.21.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 21:24:33 -0700 (PDT)
Message-ID: <113b77e4-ccc5-7a92-60db-26c25c184e20@redhat.com>
Date:   Wed, 27 Jul 2022 12:24:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 17/42] virtio_ring: packed: introduce
 vring_free_packed
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
 <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
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
> Free the structure struct vring_vritqueue_packed.
>
> Subsequent patches require it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58355e1ac7d7..891900b31c3d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1835,6 +1835,28 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>   	return desc_extra;
>   }
>   
> +static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
> +			      struct virtio_device *vdev)
> +{
> +	if (vring_packed->vring.desc)
> +		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
> +				 vring_packed->vring.desc,
> +				 vring_packed->ring_dma_addr);
> +
> +	if (vring_packed->vring.driver)
> +		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
> +				 vring_packed->vring.driver,
> +				 vring_packed->driver_event_dma_addr);
> +
> +	if (vring_packed->vring.device)
> +		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
> +				 vring_packed->vring.device,
> +				 vring_packed->device_event_dma_addr);
> +
> +	kfree(vring_packed->desc_state);
> +	kfree(vring_packed->desc_extra);
> +}
> +
>   static struct virtqueue *vring_create_virtqueue_packed(
>   	unsigned int index,
>   	unsigned int num,

