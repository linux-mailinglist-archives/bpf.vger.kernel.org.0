Return-Path: <bpf+bounces-30945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B58D4B0D
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCFF2858C4
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C917C7B8;
	Thu, 30 May 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYoUB2yK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803771761BC
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070008; cv=none; b=J1yt9kpshP+QdEjExUc/fAd1t+gQBj5gNnAMgvVrVAyFW13t6+DrKUyujP2mTMULaduBEJ1y8gYv3o+pjBH2PPAMLMGSP1rmc6vp05h2UjRrtFJew40FFnBdbHVWvQdA4Dbl04cmqVz/lnmE9MnRtHwQOspFvk0WFTCZk7uF/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070008; c=relaxed/simple;
	bh=a5RoNmw3LEtmCv84g3foK1aKa72JGF8L3MC+ZOG8Gz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5liQnIoi4nHhhx4RyCDvR9MzZv3fkMUSf2VwuhbMb6I60/97o/0UnaqbG9HuSdlCaNkk9aIfhdx+/9IIWTAlZiN/6EoSf6Bq0H/8DSsrVihxWSykPOfS/p2RI2OdwNNN6WX4mYhwuLAiKV62eAcq54QuqPppgkgSNW5B8CR1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYoUB2yK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717070006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
	b=dYoUB2yK8wI973HlEW6hqEZjYiKLqgw+weL8SDlL300SVkfNv3GUgFYT1En0RujrVzZ+0q
	4dXt987YVTGI6psnh4HnlhQzOHsS6njp1qXjJBgCl3Cdxc3N5JltuBnh2jIkSqfS9y9pL9
	bHcjyy3tl9Q6Y4dooSI3OWAr759LBHs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-7E34DQp3M_qqGXbMHiYLuw-1; Thu, 30 May 2024 07:53:23 -0400
X-MC-Unique: 7E34DQp3M_qqGXbMHiYLuw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42114e7ec89so5571735e9.1
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 04:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070002; x=1717674802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
        b=geLf+mOjAW0/hpmplwXHxh83LytFBmb9yLVp0Jb/Zhpvbi3V0LMlFvpBMb1JVxuOFu
         sTcDRBX/o/yeKmt3scqpqFVTSaDV89gL1PhfzOielne+v+1cLfKyTy/a2W8yVrRCAyAp
         cHirGZHU2Cc0AyrDc3zhsH4Zuk5TNsA8xYmY4yQt3p6CqEwg48CXmMuLlIsgtng2iTg0
         o2ZwGI1FXsJ7hvLLfh6m2AFmFFZA42KO9RWi/S+92d3O59+J3WDEnifwqVN9OMLo6+6b
         40oCHeqWmljE6MMsmmXd6BPv4dihI8Mgx+zW6Q37Cmj56f1kkwahMa10AFaSuIZqtXU3
         dyBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQOJi49lquDbjKO4p1pYCux2vBkGC6lCIB5UkG8BcpEUavuwLRqcciG6TiZ5w6z0hPqnutddpySTQB1trsHsErNOy9
X-Gm-Message-State: AOJu0Yy5u7AvYrU/VxGz29eWbaGGqH3qLNtPrpuJTRhOGBZRlaZR4/rM
	E6Ktg8DrhfzRvR76Rylz+hLu3QyBG8yP4sBwAUhNqw1cu04Aip0jOZEy3pOoplGpyHu9T63sKoN
	TJNBI/l2pezZBHo0tbgTubU/2AunUem2LyHf+KP/dH6pRi6u01w==
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345935e9.16.1717070002018;
        Thu, 30 May 2024 04:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEceci61giza+Mfylw+1jbKk7Vb1KMIlL8tVEyZVSFKJGK4nLI8VQ/9gqBvA2EqJRwnujJi8g==
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345615e9.16.1717070001403;
        Thu, 30 May 2024 04:53:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706ea02sm23212155e9.30.2024.05.30.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:53:20 -0700 (PDT)
Date: Thu, 30 May 2024 07:53:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Message-ID: <20240530075003-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>

On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> Thanks.
> 
> v2:
>     1. Add five commits. That provides some helper for sq to support premapped
>        mode. And the last one refactors distinguishing xmit types.
> 
> v1:
>     1. resend for the new net-next merge window
> 


It's great that you are working on this but
I'd like to see the actual use of this first.

> 
> Xuan Zhuo (12):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_ring: virtqueue_set_dma_premapped() support to disable
>   virtio_net: refactor the xmit type
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 248 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
>  drivers/virtio/virtio_ring.c                  | 118 +++-
>  include/linux/virtio.h                        |  12 +-
>  9 files changed, 606 insertions(+), 401 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> 
> --
> 2.32.0.3.g01195cf9f


