Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6D6ACBCF
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 19:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCFSAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 13:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCFSAv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 13:00:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49053D93D
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678125463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I738/18sbvHmC2+417kvwhaipDQYnMqOKuRA/kftVmQ=;
        b=eZedemGiOo93yExjWAsgTGoPeo9GxDZmPVtB/6vbWUCMo1Yzrocw9xT4ZXArFD6Qnhx54m
        MqktMZe/RkxJdKpUpOhCnVAzgeb1SMtwVykZlCL/GFhXRxLeYuKXBbh58yj+2++v+zCZUD
        bbgjdiwrxvRYXSjouAJfwO6VY1GtCXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-xQeWKPgcOVOVZlwxMrk0nA-1; Mon, 06 Mar 2023 12:57:40 -0500
X-MC-Unique: xQeWKPgcOVOVZlwxMrk0nA-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so7073915wml.2
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 09:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I738/18sbvHmC2+417kvwhaipDQYnMqOKuRA/kftVmQ=;
        b=fZ0C4ZpToV5D3Q5Hjcy2AT4MNloWGunc2+1SofeNLKGl9NezqmwyBmTLmc2v8GEAnX
         DDwONE+9wIxyS52IlCivXaVxrymm3up4+dNCahqeeRYU4dN6qA7ADgM87BT+8adumBip
         ox25Grn+QOIISu+bzqFDbEO0P7TQxXJlWi57AwcU9DX3dOP+F0QuN0uovg1e8DS6BcKb
         ohdMLSUC2GnlBohcOxwHth5LqXllU9IeyRkWv9vA2++kPTmhkPvXscQfKndfcdDGfq+R
         VPdp/2IunAXsrJQOs7bi/MR4ZKVix37CtfMLbgSOrlHOs+ohsVxrChPkqrSsKHYaLAVl
         2zSw==
X-Gm-Message-State: AO0yUKU6YWz9GS4DVfIzU0qYqbSREQU5I30QY5Cjv6nKbNjR8lw10acI
        RMsYG9mbfWKi3bGUTf9pb7PJpGGkn3fTTSDQV6Y2eW6YZ5KDkFATX46/apKPMc4pZUaCTkcxn8n
        zd+F+E4UNpn4Z
X-Received: by 2002:a05:600c:4f53:b0:3ea:dbdd:b59c with SMTP id m19-20020a05600c4f5300b003eadbddb59cmr10192595wmq.15.1678125458889;
        Mon, 06 Mar 2023 09:57:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/7vZlQ5uxUx+GGtLM0+if0KbUiPqDYTkq6I2qARMVnh5tT0y/ZRu7nd7JUJRS0jmoNHNwt9Q==
X-Received: by 2002:a05:600c:4f53:b0:3ea:dbdd:b59c with SMTP id m19-20020a05600c4f5300b003eadbddb59cmr10192578wmq.15.1678125458554;
        Mon, 06 Mar 2023 09:57:38 -0800 (PST)
Received: from redhat.com ([2.52.23.160])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c16c500b003e20fa01a86sm10602188wmn.13.2023.03.06.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:57:38 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:57:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        Yichun Zhang <yichun@openresty.com>
Subject: Re: [PATCH net 2/2] virtio_net: add checking sq is full inside xdp
 xmit
Message-ID: <20230306125344-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 06, 2023 at 12:15:35PM +0800, Xuan Zhuo wrote:
> If the queue of xdp xmit is not an independent queue, then when the xdp
> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> the following error.
> 
> net ens4: Unexpected TXQ (0) queue failure: -28
> 
> This patch adds a check whether sq is full in XDP Xmit.
> 
> Reported-by: Yichun Zhang <yichun@openresty.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 777de0ec0b1b..3001b9a548e5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -302,6 +302,8 @@ struct padded_vnet_hdr {
>  
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
> +			  struct send_queue *sq);
>  
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -341,6 +343,16 @@ static int rxq2vq(int rxq)
>  	return rxq * 2;
>  }
>  

I'd really rather we ordered functions reasonably so declarations
are not needed.

> +static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> +{
> +	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> +		return false;
> +	else if (q < vi->curr_queue_pairs)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
>  {
>  	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> @@ -686,6 +698,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  	ret = nxmit;
>  
> +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> +		check_sq_full(vi, dev, sq);
> +
>  	if (flags & XDP_XMIT_FLUSH) {
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
>  			kicks = 1;
> @@ -1784,16 +1799,6 @@ static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
>  	}
>  }
>  
> -static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> -{
> -	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> -		return false;
> -	else if (q < vi->curr_queue_pairs)
> -		return true;
> -	else
> -		return false;
> -}
> -
>  static void virtnet_poll_cleantx(struct receive_queue *rq)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
> -- 
> 2.32.0.3.g01195cf9f

