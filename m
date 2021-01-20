Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665452FCC3D
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 09:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbhATIBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 03:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729874AbhATH7H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 02:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611129462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UrxbpNYHnK4DEP6WSgA1c696nQ5LZj2MHb845FTR0o=;
        b=JfaiPu/Ton8/Of7IxLmCwZ1eB5RJt5u+/eW7JyxyVxouHCDfLt/KUxbVLI1lLaY69C9jNa
        rU1Q43WsLRQ+oavZ004yx50VUrtCIdOga3zxZSwbyF27P/ijYaimQeNbYe8ZhAvV+YRJBG
        v1wEptLCLXXmM7Y09vynoewdnbsLfBU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-mS3HoupuMWaP5Q7wq9Ojkw-1; Wed, 20 Jan 2021 02:57:40 -0500
X-MC-Unique: mS3HoupuMWaP5Q7wq9Ojkw-1
Received: by mail-wr1-f72.google.com with SMTP id e12so11078359wrp.10
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 23:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UrxbpNYHnK4DEP6WSgA1c696nQ5LZj2MHb845FTR0o=;
        b=XUO+Cy4N0M0B7Fz4StFk3XvcnzjcFjopxmBvCBmZmNgfvhOwUxBL9WYAKGmHoTsTSz
         wG+RWRLwNWLUWfXoRKx792vQKRp6XTOmJ3uOGxHs6uYD0ExiZqu21gETzvdGjrh12bG1
         dMrr5ODgjA/kxsYL5BdXsykN2NQkDFXLN9oO3pVrvdNHN4W+LNai4PfY2DQviW9WakB9
         6V3FWJPaez0Rvo2oSlS6tTUtS69qvAioI0kzW85oC3+w2qbp/febwk8TZMxV31DONBrC
         dp+hpV/rMRSsuJfr0eZ+kHavHKtEmsLz6VVgrBgE5zpj3hIyKlY5gR1IQB81hPfLMUJb
         /w/Q==
X-Gm-Message-State: AOAM531n8ejJXNE6giAxw9npAB2lfYbk+/G7hFcQM63iE7sBWRby/Yea
        JaELzFc+CFanDZBfFaXcZb9SVPmoFSnV4PVS25ThZI6riXBnVJjm0GsPxGVmTmbWR7rLofRDzXJ
        28sztQATZHuOm
X-Received: by 2002:a1c:a784:: with SMTP id q126mr3058485wme.52.1611129459057;
        Tue, 19 Jan 2021 23:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIpBmdXLlNr8vbRKHAMR3mn1UgNMPNu1agQMsKN5OdQKV4XJ/XAHPr6RwZNDY4dCN1R7xGyw==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr3058476wme.52.1611129458879;
        Tue, 19 Jan 2021 23:57:38 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id k9sm2510093wma.17.2021.01.19.23.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 23:57:38 -0800 (PST)
Date:   Wed, 20 Jan 2021 02:57:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bjorn.topel@intel.com,
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
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] virtio-net: support IFF_TX_SKB_NO_LINEAR
Message-ID: <20210120025729-mutt-send-email-mst@kernel.org>
References: <cover.1611128806.git.xuanzhuo@linux.alibaba.com>
 <d54438cec1fc86a1cb0166098493b1aa6a15885a.1611128806.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54438cec1fc86a1cb0166098493b1aa6a15885a.1611128806.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 03:49:10PM +0800, Xuan Zhuo wrote:
> Virtio net supports the case where the skb linear space is empty, so add
> priv_flags.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba8e637..f2ff6c3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2972,7 +2972,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		return -ENOMEM;
>  
>  	/* Set up network device as normal. */
> -	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
> +	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
> +			   IFF_TX_SKB_NO_LINEAR;
>  	dev->netdev_ops = &virtnet_netdev;
>  	dev->features = NETIF_F_HIGHDMA;
>  
> -- 
> 1.8.3.1

