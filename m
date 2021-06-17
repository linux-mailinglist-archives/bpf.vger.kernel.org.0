Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9E3AA95A
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 05:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQDJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 23:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhFQDJf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 23:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623899248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMQv9oH5M2Iy204odLTWw8+glUtgOSzA8bgiiuKdmss=;
        b=OcrdlY2vVImMPe6BXWZMgJJnXcJoQ6jtUC98XrgvaRW2RS0jErZdDvPDnOPc07pnh04n5G
        inuQsrIPqoWZ9cKykNdGSh+z6YQ7eZKyYaCQrxe9RCw80QQ1I5uQxM26hrlPjznPg3gj53
        sY/44XvS2dfTa2sxmM+TLaVjpgDhfpU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-hAqROoQZMJqe6O89yUlFaw-1; Wed, 16 Jun 2021 23:07:26 -0400
X-MC-Unique: hAqROoQZMJqe6O89yUlFaw-1
Received: by mail-pj1-f70.google.com with SMTP id w4-20020a17090a4f44b029016bab19a594so5240208pjl.4
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 20:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UMQv9oH5M2Iy204odLTWw8+glUtgOSzA8bgiiuKdmss=;
        b=M5C7HtpHGQlK6zVLHO2gCRu2XtQkddXaFRETSGT+Qs2m1ijqaNcUfu0eZ4V0UoLhfo
         OFpNSyWVYxku84QNcjaAbUgjFoD/ciEgXau/ZWgH5yQEgkWUabJswYovy5lvwWTnRLKr
         gqhEpTGGoBXybLKfV5nwGCrRWRYP3Gwj9qOdb/VlsrRJkZCfx1NIFweUS/8SPtY3ydxn
         Erxz4srm8jtgzzBKT64hpgtdozIdRCbpnERAVLMpwSwfBqR/uixUmossn0AU4rmgjY01
         uw7s+ztyvtXV7P4XGnQvlvAA+aRd2c5tFFEWF6zZt1UmfyLx+iANdRHxtnyFCkZ/OeXa
         M5kg==
X-Gm-Message-State: AOAM531rcpEcSV4D4ts1CnaZtshbpR5V2SNp1HCOCt2tp+5jzOP3qfQZ
        fNhvp+A+UKbL3SsZKf7qJiTJR+5mvdi5hZEQkbMnP2cYr91k7oTJrXr+nHUcCRWvlqMca5tTVLG
        G9jNjB2MDcPzm
X-Received: by 2002:a63:344d:: with SMTP id b74mr2827254pga.266.1623899245813;
        Wed, 16 Jun 2021 20:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS2x+Jc2Kml1O/dOiSY0qquwtdpUMptUnjji8wtNEfdMdakI18DQJ4a92xTd3nzX5F2jAyRg==
X-Received: by 2002:a63:344d:: with SMTP id b74mr2827234pga.266.1623899245520;
        Wed, 16 Jun 2021 20:07:25 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u38sm3514424pgm.14.2021.06.16.20.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:07:24 -0700 (PDT)
Subject: Re: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
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
 <20210610082209.91487-15-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c5d955f5-6c8b-03df-9e16-56b700aa9f22@redhat.com>
Date:   Thu, 17 Jun 2021 11:07:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-15-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2021/6/10 ÏÂÎç4:22, Xuan Zhuo Ð´µÀ:
> Calling virtqueue_napi_schedule() in wakeup results in napi running on
> the current cpu. If the application is not busy, then there is no
> problem. But if the application itself is busy, it will cause a lot of
> scheduling.
>
> If the application is continuously sending data packets, due to the
> continuous scheduling between the application and napi, the data packet
> transmission will not be smooth, and there will be an obvious delay in
> the transmission (you can use tcpdump to see it). When pressing a
> channel to 100% (vhost reaches 100%), the cpu where the application is
> located reaches 100%.
>
> This patch sends a small amount of data directly in wakeup. The purpose
> of this is to trigger the tx interrupt. The tx interrupt will be
> awakened on the cpu of its affinity, and then trigger the operation of
> the napi mechanism, napi can continue to consume the xsk tx queue. Two
> cpus are running, cpu0 is running applications, cpu1 executes
> napi consumption data. The same is to press a channel to 100%, but the
> utilization rate of cpu0 is 12.7% and the utilization rate of cpu1 is
> 2.9%.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio/xsk.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 36cda2dcf8e7..3973c82d1ad2 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -547,6 +547,7 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	struct xsk_buff_pool *pool;
> +	struct netdev_queue *txq;
>   	struct send_queue *sq;
>   
>   	if (!netif_running(dev))
> @@ -559,11 +560,28 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>   
>   	rcu_read_lock();
>   	pool = rcu_dereference(sq->xsk.pool);
> -	if (pool) {
> -		local_bh_disable();
> -		virtqueue_napi_schedule(&sq->napi, sq->vq);
> -		local_bh_enable();
> -	}
> +	if (!pool)
> +		goto end;
> +
> +	if (napi_if_scheduled_mark_missed(&sq->napi))
> +		goto end;
> +
> +	txq = netdev_get_tx_queue(dev, qid);
> +
> +	__netif_tx_lock_bh(txq);
> +
> +	/* Send part of the packet directly to reduce the delay in sending the
> +	 * packet, and this can actively trigger the tx interrupts.
> +	 *
> +	 * If no packet is sent out, the ring of the device is full. In this
> +	 * case, we will still get a tx interrupt response. Then we will deal
> +	 * with the subsequent packet sending work.
> +	 */
> +	virtnet_xsk_run(sq, pool, sq->napi.weight, false);


This looks tricky, and it won't be efficient since there could be some 
contention on the tx lock.

I wonder if we can simulate the interrupt via IPI like what RPS did.

In the long run, we may want to extend the spec to support interrupt 
trigger though driver.

Thanks


> +
> +	__netif_tx_unlock_bh(txq);
> +
> +end:
>   	rcu_read_unlock();
>   	return 0;
>   }

