Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BD4FD698
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358905AbiDLIc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 04:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358585AbiDLHlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 03:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC676532F3
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649747901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqKnz8pGmfktt7oGYuukRZYK9Mv+h4jERKVTHEdiSyE=;
        b=e5Hjk98E6ZnBLlfH/A18rTtx++Oi3/5n/5BCO9BXhInmd1GB2Dyc5mqbkyX6Oer89t5qG0
        ecYMgK50TRNwUe3y+Kyd8F+lYG8h6CCuk7eFlbpYXnvYMxjCGYWplfKBZWla6gMllxcxcz
        zzgKksGDrklDYmbHz5yVvO3tGPtlYdk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-T_7x9fojOsaM-wpgL6PWFA-1; Tue, 12 Apr 2022 03:18:19 -0400
X-MC-Unique: T_7x9fojOsaM-wpgL6PWFA-1
Received: by mail-pl1-f200.google.com with SMTP id s18-20020a170902ea1200b001570031e832so6001058plg.6
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XqKnz8pGmfktt7oGYuukRZYK9Mv+h4jERKVTHEdiSyE=;
        b=FLutaCR6y1+wbiB6ijavKbrrvOZ3gElTr46ouCz2YE4G6KX8UEQYNdb2kqjYlp98V/
         NM5lrumew5pYPfQYrLGr61c4kvLheC4ORp4pKDFFgJ50KW3nTo7ridcJyd52iwUVQQxA
         xXAQpRPM0f4XKK09D0uhmjmJAk/C2bKOVzVwxbnkKuMJ6EualmHwW1l3QUzfD9idsFMP
         WYHmM7jQFcWv9hFEOoFNngC/NpYalS0ft4vMPKID5ZZxZX20KVmKQwndgN6/9q00P9NK
         0ZenYwx7dHd92SxoRGJWn/18LgX1gqLPiRwMstE8JCq5HGFOiUljuGkaSek2KXHpzrsB
         0fxA==
X-Gm-Message-State: AOAM531HWk8eUUftYfBtrAjWrBuSlR9BATGszOU0/m4AA+e7vSV+cMTW
        blWGQvgQ1fyioNOFTm2/rRtptDbVsH6qlVG7SXBMWotpPdZWAQmwyaoqAV5uxgVlBl5iC7Ylbx0
        YgzDAO7iIdknS
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr3438579pjv.23.1649747898721;
        Tue, 12 Apr 2022 00:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzICssTBKSRQgY3N4GxeG15GespIylagYZlURonRDEwf7ie2ERjdgg/5bb3D2p7nXDQN3bpIg==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr3438556pjv.23.1649747898477;
        Tue, 12 Apr 2022 00:18:18 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r76-20020a632b4f000000b003820643e1c2sm1827442pgr.59.2022.04.12.00.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:18:17 -0700 (PDT)
Message-ID: <bd6bec0d-00db-93ae-4d86-daa10f5d8e88@redhat.com>
Date:   Tue, 12 Apr 2022 15:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 28/32] virtio_net: set the default max ring size by
 find_vqs()
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
 <20220406034346.74409-29-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-29-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Use virtio_find_vqs_ctx_size() to specify the maximum ring size of tx,
> rx at the same time.
>
>                           | rx/tx ring size
> -------------------------------------------
> speed == UNKNOWN or < 10G| 1024
> speed < 40G              | 4096
> speed >= 40G             | 8192
>
> Call virtnet_update_settings() once before calling init_vqs() to update
> speed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


>   drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a801ea40908f..dad497a47b3a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2861,6 +2861,29 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
>   		   (unsigned int)GOOD_PACKET_LEN);
>   }
>   
> +static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
> +{
> +	u32 i, rx_size, tx_size;
> +
> +	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
> +		rx_size = 1024;
> +		tx_size = 1024;
> +
> +	} else if (vi->speed < SPEED_40000) {
> +		rx_size = 1024 * 4;
> +		tx_size = 1024 * 4;
> +
> +	} else {
> +		rx_size = 1024 * 8;
> +		tx_size = 1024 * 8;
> +	}
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		sizes[rxq2vq(i)] = rx_size;
> +		sizes[txq2vq(i)] = tx_size;
> +	}
> +}
> +
>   static int virtnet_find_vqs(struct virtnet_info *vi)
>   {
>   	vq_callback_t **callbacks;
> @@ -2868,6 +2891,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   	int ret = -ENOMEM;
>   	int i, total_vqs;
>   	const char **names;
> +	u32 *sizes;
>   	bool *ctx;
>   
>   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> @@ -2895,10 +2919,15 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   		ctx = NULL;
>   	}
>   
> +	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
> +	if (!sizes)
> +		goto err_sizes;
> +
>   	/* Parameters for control virtqueue, if any */
>   	if (vi->has_cvq) {
>   		callbacks[total_vqs - 1] = NULL;
>   		names[total_vqs - 1] = "control";
> +		sizes[total_vqs - 1] = 64;
>   	}
>   
>   	/* Allocate/initialize parameters for send/receive virtqueues */
> @@ -2913,8 +2942,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   			ctx[rxq2vq(i)] = true;
>   	}
>   
> -	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> -				  names, ctx, NULL);
> +	virtnet_config_sizes(vi, sizes);
> +
> +	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
> +				       names, sizes, ctx, NULL);
>   	if (ret)
>   		goto err_find;
>   
> @@ -2934,6 +2965,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   
>   
>   err_find:
> +	kfree(sizes);
> +err_sizes:
>   	kfree(ctx);
>   err_ctx:
>   	kfree(names);
> @@ -3252,6 +3285,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>   		vi->curr_queue_pairs = num_online_cpus();
>   	vi->max_queue_pairs = max_queue_pairs;
>   
> +	virtnet_init_settings(dev);
> +	virtnet_update_settings(vi);
> +
>   	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>   	err = init_vqs(vi);
>   	if (err)
> @@ -3264,8 +3300,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
>   	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
>   
> -	virtnet_init_settings(dev);
> -
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
>   		vi->failover = net_failover_create(vi->dev);
>   		if (IS_ERR(vi->failover)) {

