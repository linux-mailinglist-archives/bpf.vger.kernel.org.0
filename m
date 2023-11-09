Return-Path: <bpf+bounces-14561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86537E6511
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2CB20C71
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171110784;
	Thu,  9 Nov 2023 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db5A+1sO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F610793
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:19:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA882D4D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699517953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xE4TaI1xFoCeG0Et+qFiFcEYZ8Mpoef4JSlUW87OIww=;
	b=db5A+1sO0lJKNAixLz28ByfwtMGXxZe2T6CZuva+VJbLHlPjVQ+JkZQvs+c4+g3600Z6i6
	F4+w7LM7BjUDU/upR+RYFxGIr0LLi9qU5ZgIFS+UBNG3yg4VpNSOv75UD4ecIACY18IZEL
	BloHNMvtVJU2cF7h+ANsOQG3JDoXDJE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-0zhROnkVOY2ysJh-1wKo4A-1; Thu, 09 Nov 2023 03:19:11 -0500
X-MC-Unique: 0zhROnkVOY2ysJh-1wKo4A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c797b497e8so44484666b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 00:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517950; x=1700122750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE4TaI1xFoCeG0Et+qFiFcEYZ8Mpoef4JSlUW87OIww=;
        b=qdDw0riayIhAgHlB3X8oKrmBwB+E5FOIXLwbyhzjfM9lUr+hjMWDW2oOv09FhuQo9B
         +ZhquHfmdBeixqsmqTglE3IZ54NsZ5QzI3JUWgOg5q8hIbYotL+Gqu2/KJ72GRg6lzTy
         NDdJ1x0s7Idg8+efn4IbvviVSWbLUSKDOuQx8Yl/SkmOHxJAWly0w3ajHSBR5TZ6jNNw
         3Z06TQAFqRmHP40WevG3XHtu1INgyS8bS2lufTjP7cHtA5fn82pRWO/fzg3spBUEwZQI
         41JxCHpUJn9jCc/tYZxtJfT310SWoOvP4aznJRKBnPz87Nfm0yMKCP69KYXYT/i876az
         U75g==
X-Gm-Message-State: AOJu0YyYD0WaMa/6sTaa+b+/NroJWm6sQPEgCnGWwGM17aBk5QWLN8TA
	komFD880kaIhU9uau7db36w8TQ1ms1pARqBwcFs57//K7c4ZrImVF/gES4I1FBYt+nVSzxc8A5P
	uTrBMVu7HyGtX
X-Received: by 2002:a17:906:eec1:b0:9ae:7502:7d30 with SMTP id wu1-20020a170906eec100b009ae75027d30mr3326784ejb.57.1699517949883;
        Thu, 09 Nov 2023 00:19:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE85mNmjr2GJvt9X07Odv5atdHbnAvtDjyxWQli00YOJsFuWVyKjxhVxKuEH3lwcrhlzuTj1Q==
X-Received: by 2002:a17:906:eec1:b0:9ae:7502:7d30 with SMTP id wu1-20020a170906eec100b009ae75027d30mr3326766ejb.57.1699517949486;
        Thu, 09 Nov 2023 00:19:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906694700b0099293cdbc98sm2241746ejs.145.2023.11.09.00.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:19:08 -0800 (PST)
Date: Thu, 9 Nov 2023 03:19:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/21] virtio-net: support AF_XDP zero copy
Message-ID: <20231109031728-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>

On Tue, Nov 07, 2023 at 11:12:06AM +0800, Xuan Zhuo wrote:
> ## AF_XDP
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> At present, we have completed some preparation:
> 
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
> 
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
> 
> Virtio-net can not increase the queue num at will, so xsk shares the queue with
> kernel.
> 
> On the other hand, Virtio-Net does not support generate interrupt from driver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
> is also the local CPU, then we wake up napi directly.
> 
> This patch set includes some refactor to the virtio-net to let that to support
> AF_XDP.
> 
> ## performance
> 
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> 
> ### virtio PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>  ######################## NIC statistics for port 0 ########################
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> 
> 
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ############################################################################
> 
> ### AF_XDP PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>   ######################## NIC statistics for port 0  ########################
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> 
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   ############################################################################
> 
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> 
> ## maintain
> 
> I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
> virtio-net.
> 
> Please review.
> 
> Thanks.
> 
> v2
>     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
>     2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
>     3. split the commit "move to virtio_net.h" in last patch set. Just move the
>        struct/api to header when we use them.
>     4. add comments for some code
> 
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
>     3. fix some warnings
> 
> 
> Xuan Zhuo (21):
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: sq support premapped mode
>   virtio_net: xsk: bind/unbind xsk
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: move some api to header
>   virtio_net: xsk: tx: support tx
>   virtio_net: xsk: tx: support wakeup
>   virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
>   virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
>   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
>   virtio_net: xsk: rx: skip dma unmap when rq is bind with AF_XDP
>   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
>   virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
> 
>  MAINTAINERS                                 |   2 +-
>  drivers/net/Kconfig                         |   8 +-
>  drivers/net/Makefile                        |   2 +-
>  drivers/net/virtio/Kconfig                  |  13 +
>  drivers/net/virtio/Makefile                 |   8 +
>  drivers/net/{virtio_net.c => virtio/main.c} | 630 +++++++++-----------
>  drivers/net/virtio/virtio_net.h             | 346 +++++++++++
>  drivers/net/virtio/xsk.c                    | 498 ++++++++++++++++
>  drivers/net/virtio/xsk.h                    |  32 +
>  9 files changed, 1174 insertions(+), 365 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c => virtio/main.c} (92%)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h


Too much code duplications for my taste. Would there maybe be less if
everything was in a single file?


> --
> 2.32.0.3.g01195cf9f


