Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D84562F86
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiGAJJe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiGAJJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CF7C3135F
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656666569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saiQ5wFJJA8eA9HPaDwAsrYblDAAKsPCjYisojMTkZw=;
        b=FcgJlsXS+Jj7GhH3qNZ0DCfniHmml1vRkQERzXVrbEF353ccSva8BAvsqCC8oximKvzcrz
        Z7f9O3yOU2PPntH1gBtid/136C4AMSeEsaOzf4I1X1c9pTZTg+E6h8nLAuyzS5M/3QAtqT
        HndaYb5snwkKJqiNWoNBk4athLN7/MA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-U_Ry0evLOZWVe-EagwFYnA-1; Fri, 01 Jul 2022 05:09:28 -0400
X-MC-Unique: U_Ry0evLOZWVe-EagwFYnA-1
Received: by mail-pg1-f200.google.com with SMTP id h190-20020a636cc7000000b003fd5d5452cfso1023798pgc.8
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=saiQ5wFJJA8eA9HPaDwAsrYblDAAKsPCjYisojMTkZw=;
        b=ulr1EeMbwUyR2mOYLWQd1NjZqXwwm2Dz1Q4c6Rz1EBrIo2J3f1p+8agldxuRSZtTMj
         7+Z2x+9JyQhzUt8e5/I5+uJkOsNgQmbAqFM4CHrlM747KgVp8tPNqL5aaIufKs7cWanY
         Cz3WlGnOItnGCKeeKbGp6wAmOoH8KcTiZ89g3cVMP45njjKDsyf/sbHKPjLWtELQ7Kmp
         zp2eiAb+oeu/rsDcnyXbVM/BeA3IAoPxbVb4Wt7QUrdFO0qShL/sxZOBt+ZTSOLJJFkp
         FofzBJt7TeTKXa4n9HkPvUk3vTN3y363McpXToHhKmomyBFf51kdpz+cjl8mZHvfk4nt
         99Pw==
X-Gm-Message-State: AJIora+C3FudDiSDvwkEbElMP0IXPx6PPbnP5NupYLS9HFHzoydyWUIZ
        e3v37GdfIGZzhUo51M3eXmWZneUuhquYSDtf5tze2H4jOME+IBcpTFwPPUXCpE98PZVfqhlFHtW
        7rVnurvLWiPR1
X-Received: by 2002:a17:90a:fa8c:b0:1ec:9f5c:846d with SMTP id cu12-20020a17090afa8c00b001ec9f5c846dmr15441626pjb.73.1656666567459;
        Fri, 01 Jul 2022 02:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vA1dTIazYR3bB1gNFv3RFbJN8Z3XTbc6Oeecp05m0N8NOinTXnkwxvAjkIm4tnkL8fohP/9Q==
X-Received: by 2002:a17:90a:fa8c:b0:1ec:9f5c:846d with SMTP id cu12-20020a17090afa8c00b001ec9f5c846dmr15441568pjb.73.1656666567223;
        Fri, 01 Jul 2022 02:09:27 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001674d61c1c6sm14812024plb.272.2022.07.01.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:09:26 -0700 (PDT)
Message-ID: <6256ad45-1606-f805-3427-ecee360c011f@redhat.com>
Date:   Fri, 1 Jul 2022 17:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 14/40] virtio_ring: split: introduce
 virtqueue_resize_split()
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
 <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> virtio ring split supports resize.
>
> Only after the new vring is successfully allocated based on the new num,
> we will release the old vring. In any case, an error is returned,
> indicating that the vring still points to the old vring.
>
> In the case of an error, re-initialize(virtqueue_reinit_split()) the
> virtqueue to ensure that the vring can be used.
>
> In addition, vring_align, may_reduce_num are necessary for reallocating
> vring, so they are retained for creating vq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9c83c5e6d5a9..1aaa1e5f9991 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -212,6 +212,7 @@ struct vring_virtqueue {
>   };
>   
>   static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> +static void vring_free(struct virtqueue *_vq);
>   
>   /*
>    * Helpers.
> @@ -1114,6 +1115,37 @@ static struct virtqueue *vring_create_virtqueue_split(
>   	return vq;
>   }
>   
> +static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct vring_virtqueue_split vring = {};
> +	struct virtio_device *vdev = _vq->vdev;
> +	int err;
> +
> +	err = vring_alloc_queue_split(&vring, vdev, num, vq->split.vring_align,
> +				      vq->split.may_reduce_num);
> +	if (err)
> +		goto err;


It's better to have decouple the allocation future more to avoid any 
rewind here in the future.

But the patch should be fine.

So

Acked-by: Jason Wang <jasowang@redhat.com>


> +
> +	err = vring_alloc_state_extra_split(&vring);
> +	if (err) {
> +		vring_free_split(&vring, vdev);
> +		goto err;
> +	}
> +
> +	vring_free(&vq->vq);
> +
> +	virtqueue_init(vq, vring.vring.num);
> +	virtqueue_vring_attach_split(vq, &vring);
> +	virtqueue_vring_init_split(vq);
> +
> +	return 0;
> +
> +err:
> +	virtqueue_reinit_split(vq);
> +	return -ENOMEM;
> +}
> +
>   
>   /*
>    * Packed ring specific functions - *_packed().

