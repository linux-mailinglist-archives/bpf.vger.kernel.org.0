Return-Path: <bpf+bounces-12017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C547C6934
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEC61C210DE
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB3210E7;
	Thu, 12 Oct 2023 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIPkrXSa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DF20B38
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:13:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7713F1718
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697101998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LilWhAMwJSNCjqPLdL8lOODHHHbgf2yQ5atXlvOll+E=;
	b=bIPkrXSa8j0nwxDTVN5NFrfVU6nOCSaQyCKHFAaQz0HO/8vfXYaPdsjFVk8fOnxF4icd+A
	Uts1fd0k71+zk/F03VNm7p5xfZK5sMQ4eNZ1Q/6VVs749+n+lhSvN5FA+2UavRCozjWlM0
	zEgROotJCkeEmRoHnhS9nB0cchyFUo4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-gYgGeu9kN8SqR6C4-njYOg-1; Thu, 12 Oct 2023 05:13:16 -0400
X-MC-Unique: gYgGeu9kN8SqR6C4-njYOg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3233a13b47eso515431f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101995; x=1697706795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LilWhAMwJSNCjqPLdL8lOODHHHbgf2yQ5atXlvOll+E=;
        b=oKXtCyESQssmkjXfMjpZADME72NPBXpn6Op06w5HG24MwWAqD9v9hhnN0PXZRd2dKl
         CjoddkS3kZ+16fAHyrSBfEnrB9s3ZV8Xof/Z/mIcxBUqPLlpW9XJgC3a+KyGjtdRShbT
         wXw+3KCJW1ES5HqqiOdVr1DU752ol0MQlvZ6M/GpLIn2uhBw5d+SUahVl0Sxk7398NVr
         i2WswwN9YxXZ/ZAaZaGLu7gY0ZAPsRKZ+cVf0EUNl73c/zodZ2O6HWl2RuVHS63RaKew
         O0NbUuio+ULoKJCZ3yY3oVyFbrHLslutJmM4ToNv4YHUta4knZprfYCvuAhM1WmXVC6/
         nfBw==
X-Gm-Message-State: AOJu0YxWUsGHbsc91zAuQuUaKKu8fZE4nzz4L6qr+7CI7sd3UuJCi0hi
	/i2uL1ysob+T+VTokm3yy53Y9NhYafGO2hSIMuJ3uRmokMCMh9qBD1lm3pE1pXeB08mM6hszHSq
	5TY+wpxZzoE7T
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id w12-20020adff9cc000000b0031f98b44b62mr18218345wrr.37.1697101995333;
        Thu, 12 Oct 2023 02:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSpW0SO/rNFTY5n3WpVsZ+/7XSDbtL1/d1JpDZJXFSNm6HWBH1Ut8sxrQgkbB6ePpIfifh1w==
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id w12-20020adff9cc000000b0031f98b44b62mr18218327wrr.37.1697101995005;
        Thu, 12 Oct 2023 02:13:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0032179c4a46dsm17807510wrx.100.2023.10.12.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:13:14 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:13:11 -0400
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
Subject: Re: [PATCH vhost 08/22] virtio_net: virtnet_poll_tx support
 rescheduled
Message-ID: <20231012051159-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-9-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 05:27:14PM +0800, Xuan Zhuo wrote:
> virtnet_poll_tx() support to return budget when busy to be rescheduled.
> 
> When retval < budget, napi_poll() in dev.c will exit directly. And
> virtqueue_napi_complete() will be called to close napi.
> 
> When retval == budget, the napi_poll() in dev.c will re-add napi to the
> queue.
> 
> The purpose of this patch is to support xsk xmit in virtio_poll_tx() for
> subsequent patch.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index bcfd31a55076..f32cfa189972 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1976,6 +1976,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	unsigned int index = vq2txq(sq->vq);
>  	struct netdev_queue *txq;
> +	int busy = 0;
>  	int opaque;
>  	bool done;
>  
> @@ -1993,6 +1994,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  		netif_tx_wake_queue(txq);
>  
> +	if (busy) {
> +		__netif_tx_unlock(txq);
> +		return budget;
> +	}
> +
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>  
>  	done = napi_complete_done(napi, 0);

This just adds a bit of dead code.
Pls just squash into that patch.

> -- 
> 2.32.0.3.g01195cf9f


