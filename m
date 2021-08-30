Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F83FBDF0
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhH3VLQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 17:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237171AbhH3VLO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 17:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630357820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+618f6pIQ7QqyteZqRd+k8qoLUdo13s2E6E3MFo9/Y=;
        b=NBR8UifYubAHdJHB6EXmwlNxVjMKQkQZHD9XJ4wYjvp0rHMxjAfTQAP+yKJxE8Kef9PY0b
        8GCuFiWuzaNiheprjcJtK9VlQ/5X/JVkmc0cRFo9DLZIOa0UOOKY6BAo2A6IldcOsNYMP9
        plvRgjplpqeNTciVM+R113TksoBGH2w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-3hgwEIe8MXWlPCD1mXRXxg-1; Mon, 30 Aug 2021 17:10:18 -0400
X-MC-Unique: 3hgwEIe8MXWlPCD1mXRXxg-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so246367wmj.8
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H+618f6pIQ7QqyteZqRd+k8qoLUdo13s2E6E3MFo9/Y=;
        b=ui41gVT0ZPb7A0/ZhBHt0/XDlY2RA4CJVRN2eMv0jMc5Ck/yVJyobeSG5h6k5TRttZ
         JCxkVb3cW8uzasGLCsLCUTDfpKkIQKA3Gi10ZCsMRiWFpj+seMV2DmIdBOtXNc1ieIGB
         IuQ01TA7K9MGw35Sr9flj5rEnO9NWQjeBxzccKNxQ6PA/nGEnebHNkY4kagbQlVUQqp6
         8/SoMO2KFvl5mJey8El9n6lmEDEzzRAc6rlU/SgMnPEqvKEcbjsL0FUioCopLtiV6/g9
         byG5yCU1QDhSlLi/5v6MB+d3HpnS/1s/JWtdQPS+eua7AZHKiZmI2gHPtqLCEnierUHy
         JQEA==
X-Gm-Message-State: AOAM532fG6bF3tiAd7YvlHnQXmvGTijsCgz6LiJbY6IF6wz/Dj5ec7H3
        Qgd0D5qKKu+9oNu/FuD6aCznbX+3C69JJ0hH/hVlF1GzJKZTxBqBJ5xYY6AX0ivQ2wnY7rWkKTX
        1Yw+wUvrenL9w
X-Received: by 2002:a1c:f414:: with SMTP id z20mr933901wma.94.1630357817857;
        Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCALB10bxh63E5WvwArTBCCDlGaCHtgsikTuncNYNnIlBrCWXTlsk5nCq4LlIE12ZJaPWdQQ==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr933890wma.94.1630357817655;
        Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id g138sm601124wmg.34.2021.08.30.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:10:17 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:10:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_net: reduce raw_smp_processor_id() calling in
 virtnet_xdp_get_sq
Message-ID: <20210830170837-mutt-send-email-mst@kernel.org>
References: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 04:21:35PM +0800, Li RongQing wrote:
> smp_processor_id()/raw* will be called once each when not
> more queues in virtnet_xdp_get_sq() which is called in
> non-preemptible context, so it's safe to call the function
> smp_processor_id() once.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

commit log should probably explain why it's a good idea
to replace raw_smp_processor_id with smp_processor_id
in the case of curr_queue_pairs <= nr_cpu_ids.

> ---
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2e42210a6503..2a7b368c1da2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -528,19 +528,20 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>   * functions to perfectly solve these three problems at the same time.
>   */
>  #define virtnet_xdp_get_sq(vi) ({                                       \
> +	int cpu = smp_processor_id();                                   \
>  	struct netdev_queue *txq;                                       \
>  	typeof(vi) v = (vi);                                            \
>  	unsigned int qp;                                                \
>  									\
>  	if (v->curr_queue_pairs > nr_cpu_ids) {                         \
>  		qp = v->curr_queue_pairs - v->xdp_queue_pairs;          \
> -		qp += smp_processor_id();                               \
> +		qp += cpu;                                              \
>  		txq = netdev_get_tx_queue(v->dev, qp);                  \
>  		__netif_tx_acquire(txq);                                \
>  	} else {                                                        \
> -		qp = smp_processor_id() % v->curr_queue_pairs;          \
> +		qp = cpu % v->curr_queue_pairs;                         \
>  		txq = netdev_get_tx_queue(v->dev, qp);                  \
> -		__netif_tx_lock(txq, raw_smp_processor_id());           \
> +		__netif_tx_lock(txq, cpu);                              \
>  	}                                                               \
>  	v->sq + qp;                                                     \
>  })
> -- 
> 2.33.0.69.gc420321.dirty
> 
> 

