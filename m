Return-Path: <bpf+bounces-12016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050ED7C6911
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364C91C210A9
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180C20B3E;
	Thu, 12 Oct 2023 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZHM/35G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39665210E1
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:11:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ECC91
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697101867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
	b=DZHM/35G31g828rkgGAO+AUZ5fyciIcS+aKVYg/plliemcEdzKag95VZe0cIIKz3zLgTSL
	j7EtpoPgSPAyl4QO5NZRW97YDQObhTWNk+ARa2zL1iaLVM9Ibx3rPhwBb2Fm91oE0E1AW+
	qy2OBYYwtGowHbviSOKv0WYmNhXYnqU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-EN4kcDHNP5Sc_GthfUvZzg-1; Thu, 12 Oct 2023 05:11:00 -0400
X-MC-Unique: EN4kcDHNP5Sc_GthfUvZzg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4059475c174so6283895e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101859; x=1697706659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
        b=NNkSW9jKEqEbq5PzYb1u/SkfrgVrkJPAwCZ41n1eBxSsupxyw9nlEUYreEzRhIYTgX
         auQ+FJ2cJC/D6dK9+/Xbq+wf0vk2bp/C5eBpdQoUCYp7sxWQsoTlfG4aXWwBRriFT+nu
         2N8nfYXwo5xTRbUx8f6wxTo/Lb2aH4fZKbdyhLP0QnUZYJY62Zhx18tIezquQB+zDjxK
         5JGdN4OeS44KdqlPRuIPNRuyjvaVfPU1XLLBYTTpcpbLkpNrF4P9hGfm7GXrxR1ntp13
         BHVnL+npYXHx6Q+gpUVZ7M1Ttset2xrGv164WIrDsxMzkuiOxZ2j8v0oxDdfajhsqzoD
         RJhA==
X-Gm-Message-State: AOJu0YxmaCRmnnYo0EfYihjUQ+a/4ag9Ln9vO6CkUn0NPvCF2P78zRiv
	hSyAUX0yvrSq5tdFokzoAMJ+ngdWSr4vA3HumD5ZnsUlPZbawqkZcf+6od018jGCBYo3IqhUVr9
	FSDmADf2uMjT/Fq3Kt93x
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id x21-20020a05600c21d500b00402ee710029mr21887101wmj.10.1697101859463;
        Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGS+ZPrNCjZO/nefYmxLR7WYca/gn0IK+gNcR2C/7QxR8YxUcJKE4ATwpT+VU575s2Y1WmA==
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id x21-20020a05600c21d500b00402ee710029mr21887081wmj.10.1697101859026;
        Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003fbe791a0e8sm19097092wml.0.2023.10.12.02.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:10:58 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:10:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012050936-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> If send queue sent some packets, we update the tx timeout
> record to prevent the tx timeout.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/xsk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 7abd46bb0e3d..e605f860edb6 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  
>  	virtnet_xsk_check_queue(sq);
>  
> +	if (stats.packets) {
> +		struct netdev_queue *txq;
> +		struct virtnet_info *vi;
> +
> +		vi = sq->vq->vdev->priv;
> +
> +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> +		txq_trans_cond_update(txq);
> +	}
> +
>  	u64_stats_update_begin(&sq->stats.syncp);
>  	sq->stats.packets += stats.packets;
>  	sq->stats.bytes += stats.bytes;

I don't get what this is doing. Is there some kind of race here you
are trying to address? And what introduced the race?

> -- 
> 2.32.0.3.g01195cf9f


