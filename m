Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEE6689D8
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 04:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbjAMDCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 22:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjAMDCe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 22:02:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FFC22
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 19:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673578908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ub9B39X8MRFyrGtvqxhhYjK9a/AoifHHX9bCecEWoAw=;
        b=VKt/Dvl+LKJUl42sOEtg2fNha035GdSRpgDQ3rMA35TTiflTgqhMXk6ywRfbGiiUf6Y/dY
        r6+CVL3m4fRh5CrYiWqWatBvGyj0/1waklxc1RrEGLnuP/mCkdQLsFShnDPc0V1dhkckTb
        ufkITrtdpB6uzENLQr0/0PfE3dcEuRE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-M9FayJkgMIif7soutIVy8Q-1; Thu, 12 Jan 2023 22:01:41 -0500
X-MC-Unique: M9FayJkgMIif7soutIVy8Q-1
Received: by mail-pj1-f71.google.com with SMTP id h1-20020a17090a470100b0022646263abfso9237493pjg.6
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 19:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub9B39X8MRFyrGtvqxhhYjK9a/AoifHHX9bCecEWoAw=;
        b=GXB+l1SjlDEDjUh6KoPbBIjrVwm1IbqxxyZ///tL7QWIU2NYGDQyYnq7gHPu1H4/rs
         CVkR3AY7ztcvqmgXgi7JOmXLCMXkhBu1n0Pwfcs4fq4rlTIMqWIGyZ9OfDLxKW6QiAIw
         FdyowfGVdk0mQ377ofoqFK4ViB29jVA3ODuJQY9QAjNAw4OeON4IJPVnnlCeBNuBikAb
         JrjqgoQnH8/Pk7AmcjkbHUJZXVyF4D7J/0b6NJlLPPBfOhm7yxq5zi+u4V+YA6NvzGm5
         ZImBxt6Y4THnGTB3Y0vNSll10I7LROHGj6LlvSwl/lwGh2PqVWhtFD/39NWGUVndxyuC
         bLUQ==
X-Gm-Message-State: AFqh2krpGhGWQn9MkuMd5IN7Q1QrZxRqwoz4p+RC/n+JAq7k3+/haf2s
        XzlN9rorJLvO0fktm3Wz5ccHoXfZvzejhMy9f/LuFxL2ZEpfcitvemx3Y62+gNeQedThOm4VxYi
        F5hrZfac7LJsC
X-Received: by 2002:aa7:8c4e:0:b0:58b:b9ce:cda1 with SMTP id e14-20020aa78c4e000000b0058bb9cecda1mr467958pfd.28.1673578900625;
        Thu, 12 Jan 2023 19:01:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu3KUVj0slCwdLiWf1ZOLvZA2fN6H1Bow8JxY2zNZLQXjTLaghTKRdRCHo8QThqZ5rZgxuHjA==
X-Received: by 2002:aa7:8c4e:0:b0:58b:b9ce:cda1 with SMTP id e14-20020aa78c4e000000b0058bb9cecda1mr467940pfd.28.1673578900348;
        Thu, 12 Jan 2023 19:01:40 -0800 (PST)
Received: from [10.72.12.164] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 128-20020a620586000000b0058b9dc62071sm2504036pff.6.2023.01.12.19.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 19:01:39 -0800 (PST)
Message-ID: <673b165c-e971-2dd3-38e5-0cdb1cd3bbac@redhat.com>
Date:   Fri, 13 Jan 2023 11:01:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/9] virtio-net: construct multi-buffer xdp in
 mergeable
Content-Language: en-US
To:     Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230103064012.108029-1-hengqi@linux.alibaba.com>
 <20230103064012.108029-6-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230103064012.108029-6-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2023/1/3 14:40, Heng Qi 写道:
> Build multi-buffer xdp using virtnet_build_xdp_buff_mrg().
>
> For the prefilled buffer before xdp is set, we will probably use
> vq reset in the future. At the same time, virtio net currently
> uses comp pages, and bpf_xdp_frags_increase_tail() needs to calculate
> the tailroom of the last frag, which will involve the offset of the
> corresponding page and cause a negative value, so we disable tail
> increase by not setting xdp_rxq->frag_size.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/net/virtio_net.c | 58 ++++++++++++++++++++++++++++++----------
>   1 file changed, 44 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 699e376b8f8b..ab01cf3855bc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1036,7 +1036,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	unsigned int metasize = 0;
>   	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>   	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> -	unsigned int frame_sz;
> +	unsigned int frame_sz, xdp_room;
>   	int err;
>   
>   	head_skb = NULL;
> @@ -1057,11 +1057,14 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	rcu_read_lock();
>   	xdp_prog = rcu_dereference(rq->xdp_prog);
>   	if (xdp_prog) {
> +		unsigned int xdp_frags_truesz = 0;
> +		struct skb_shared_info *shinfo;
>   		struct xdp_frame *xdpf;
>   		struct page *xdp_page;
>   		struct xdp_buff xdp;
>   		void *data;
>   		u32 act;
> +		int i;
>   
>   		/* Transient failure which in theory could occur if
>   		 * in-flight packets from before XDP was enabled reach
> @@ -1077,14 +1080,16 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   		 */
>   		frame_sz = truesize;
>   
> -		/* This happens when rx buffer size is underestimated
> -		 * or headroom is not enough because of the buffer
> -		 * was refilled before XDP is set. This should only
> -		 * happen for the first several packets, so we don't
> -		 * care much about its performance.
> +		/* This happens when headroom is not enough because
> +		 * of the buffer was prefilled before XDP is set.
> +		 * This should only happen for the first several packets.
> +		 * In fact, vq reset can be used here to help us clean up
> +		 * the prefilled buffers, but many existing devices do not
> +		 * support it, and we don't want to bother users who are
> +		 * using xdp normally.
>   		 */
> -		if (unlikely(num_buf > 1 ||
> -			     headroom < virtnet_get_headroom(vi))) {
> +		if (!xdp_prog->aux->xdp_has_frags &&
> +		    (num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
>   			/* linearize data for XDP */
>   			xdp_page = xdp_linearize_page(rq, &num_buf,
>   						      page, offset,
> @@ -1095,17 +1100,29 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   			if (!xdp_page)
>   				goto err_xdp;
>   			offset = VIRTIO_XDP_HEADROOM;
> +		} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
> +			xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> +						  sizeof(struct skb_shared_info));
> +			if (len + xdp_room > PAGE_SIZE)
> +				goto err_xdp;
> +
> +			xdp_page = alloc_page(GFP_ATOMIC);
> +			if (!xdp_page)
> +				goto err_xdp;
> +
> +			memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> +			       page_address(page) + offset, len);
> +			frame_sz = PAGE_SIZE;
> +			offset = VIRTIO_XDP_HEADROOM;
>   		} else {
>   			xdp_page = page;
>   		}
>   
> -		/* Allow consuming headroom but reserve enough space to push
> -		 * the descriptor on if we get an XDP_TX return code.
> -		 */
>   		data = page_address(xdp_page) + offset;
> -		xdp_init_buff(&xdp, frame_sz - vi->hdr_len, &rq->xdp_rxq);
> -		xdp_prepare_buff(&xdp, data - VIRTIO_XDP_HEADROOM + vi->hdr_len,
> -				 VIRTIO_XDP_HEADROOM, len - vi->hdr_len, true);
> +		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> +						 &num_buf, &xdp_frags_truesz, stats);
> +		if (unlikely(err))
> +			goto err_xdp_frags;
>   
>   		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>   		stats->xdp_packets++;
> @@ -1201,6 +1218,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   				__free_pages(xdp_page, 0);
>   			goto err_xdp;
>   		}
> +err_xdp_frags:
> +		if (unlikely(xdp_page != page))
> +			__free_pages(xdp_page, 0);
> +
> +		if (xdp_buff_has_frags(&xdp)) {
> +			shinfo = xdp_get_shared_info_from_buff(&xdp);
> +			for (i = 0; i < shinfo->nr_frags; i++) {
> +				xdp_page = skb_frag_page(&shinfo->frags[i]);
> +				put_page(xdp_page);
> +			}
> +		}
> +
> +		goto err_xdp;
>   	}
>   	rcu_read_unlock();
>   

