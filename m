Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5C3A961C
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFPJaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 05:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhFPJaV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 05:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623835695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zVitNKk74Er4xjOzMcHQzU2fhoa7EV3XbSfyR7Byfw=;
        b=G0qunneyXER2yr+bU90+6ycD5nEOMQEO50zFWGE2ktuC0Y5ikY0AZhqLqJ7rGWfkUkSkeU
        wXgP74KHQ56KlMvQNRQOMke6ru10m6QRxSXM5GguI5vA9mfMSR5RXKxHD1h0rJ2Qa0h2se
        OsSpvNzbhdLKxhk+L9KF7PMTDjDuCEE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-SUECgynSOGq_1pprq60dJA-1; Wed, 16 Jun 2021 05:28:13 -0400
X-MC-Unique: SUECgynSOGq_1pprq60dJA-1
Received: by mail-pj1-f70.google.com with SMTP id on11-20020a17090b1d0bb029016bba777f5fso1457673pjb.7
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 02:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2zVitNKk74Er4xjOzMcHQzU2fhoa7EV3XbSfyR7Byfw=;
        b=FzcYWNvgAuICt9TLblMKCvx9J0tceZ0OkciJdOixBRKMwVW6s8fbKoshMYzoRcdYHI
         GvFW1iEAydX09vRBUPPXAtW5/Zgs7S5FOH4FfSmt3S3gZHIPQcyY7rZl5LCSf6IfNW7y
         Leopz+VfhdJrgEFWJ9Q726YN6U3KUeB6q6MW4615j7ED14SM8w+JeEfto222KMFQXH1C
         W5AtImkI4h/k1FLddUbdFmuGFCvQKs0ugUrfKQ6acNUxZJgnwMsLE4ImvRdGpBbmw8O/
         3ssV8lU+IVOQ08Q3fYWk4dvAp7hkMm/nnvQK6HQ/BG8leag4tWJJCpzV875CJwEpBuqa
         5JKA==
X-Gm-Message-State: AOAM530zYxhotskt+TtxT4dkyCWaOVWoE0ZxYDAw6Dv0F3is7dGJJN2U
        cl4v9V1ABvlLix210KfWXZGtIBq22WuyIcoo+WNnXysh0yjHyaidZNgq3a4Y4OrA+EdpGnyrYXi
        5t7T4vPhQIVZu
X-Received: by 2002:a63:6644:: with SMTP id a65mr3966408pgc.431.1623835692229;
        Wed, 16 Jun 2021 02:28:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP1r2/tnSACBUqAVJSZsvh4f2v25ZAQ1BpTYQ8qzqXogVVtOU0xvIAm37d5R4P1bneZXCn0Q==
X-Received: by 2002:a63:6644:: with SMTP id a65mr3966377pgc.431.1623835692066;
        Wed, 16 Jun 2021 02:28:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d22sm1679372pgb.15.2021.06.16.02.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 02:28:11 -0700 (PDT)
Subject: Re: [PATCH net-next v5 03/15] virtio-net: add priv_flags
 IFF_NOT_USE_DMA_ADDR
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        "dust . li" <dust.li@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-4-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6cbab579-93a7-27db-9b8f-0f94f1b20b13@redhat.com>
Date:   Wed, 16 Jun 2021 17:27:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2021/6/10 ÏÂÎç4:21, Xuan Zhuo Ð´µÀ:
> virtio-net not use dma addr directly. So add this priv_flags
> IFF_NOT_USE_DMA_ADDR.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0416a7e00914..6c1233f0ab3e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3064,7 +3064,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   
>   	/* Set up network device as normal. */
>   	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
> -			   IFF_TX_SKB_NO_LINEAR;
> +			   IFF_TX_SKB_NO_LINEAR | IFF_NOT_USE_DMA_ADDR;


I wonder instead of doing trick like this, how about teach the virtio 
core to accept DMA address via sg?

Thanks


>   	dev->netdev_ops = &virtnet_netdev;
>   	dev->features = NETIF_F_HIGHDMA;
>   

