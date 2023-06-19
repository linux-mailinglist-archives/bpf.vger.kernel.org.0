Return-Path: <bpf+bounces-2840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8A735594
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 13:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ACF1C20A9C
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEACD30D;
	Mon, 19 Jun 2023 11:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7DD2EB
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 11:16:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF194
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687173388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjEAfJghksu1SJUgn3rz+yBlMTbzJEHlYaYWibsDohc=;
	b=Q1Ssm0bmNYrDlRjQYJS3dkMFiTzbqPANE2LMIonJkED/pDWr8jh1boSGeTQtPezZTAGRfB
	yyiMFN02Wgn35A4r/8S5CBwDyHczXgqq0fR7MSEiKPOQ+ne9khV/vYpzo8Yc9Ecs1eeQ6H
	nUkUf9dMpeC+hwK5jsLIxmSwGIRg6vo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-_izPyXeUNhajdIaEorJCwA-1; Mon, 19 Jun 2023 07:16:26 -0400
X-MC-Unique: _izPyXeUNhajdIaEorJCwA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f9b0f64149so3786955e9.0
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687173385; x=1689765385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjEAfJghksu1SJUgn3rz+yBlMTbzJEHlYaYWibsDohc=;
        b=YnY7T9+T0PjjuTvWlasHUMWgHs+kZW35XQ8ZLcnnI+1qZuSTxektM6Q6CR9qJcX9v9
         VRxT7QuQaGtzVTbmtqjGStolNjLxsc6NA9MH4zAPbpqWGC/IXy+4mSJ+fpA6ZcSo7b5P
         3Jbq+BQGFZUOxHa3LwvAwTD7PndpVL0ZZa/coo2GkXkigGMAk1nEn8ZtEEXKDFDWy3d8
         wfxP9TKq15gc05z9WLMbCeeMS6QekKgbtrSfv48qOviHXLa67CuSjOdeXJWkvHEGT1mh
         /kt3j/K7nyn6MLkhx6Ko1ST/EUtH75SIndL+QErQrlaOIvDXeVTT1fr54BSxACZJUpP0
         RUUA==
X-Gm-Message-State: AC+VfDwT9vdEfxNcyQj3nr4FG1Gns3qZKJj2f+6b2BEXVuZAi0Q2xWqP
	RNFxTWa2QRv4lS8arkZ/LXqMU+E7DI9/GJGpw/niTygEIVqm8AGT2DLW9uRzvOCHSyVopJkGbjF
	5EclDbhgoY15N
X-Received: by 2002:a05:600c:2249:b0:3f9:b2a7:b36b with SMTP id a9-20020a05600c224900b003f9b2a7b36bmr1075789wmm.20.1687173385672;
        Mon, 19 Jun 2023 04:16:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75N+q1sVQam1zh+tUCQOW5Oo0O0K+Xc83mZbHlz2qA1EbIkxhSNF+0yCbza5d6XmS1SxCFtQ==
X-Received: by 2002:a05:600c:2249:b0:3f9:b2a7:b36b with SMTP id a9-20020a05600c224900b003f9b2a7b36bmr1075777wmm.20.1687173385315;
        Mon, 19 Jun 2023 04:16:25 -0700 (PDT)
Received: from redhat.com ([2.52.15.156])
        by smtp.gmail.com with ESMTPSA id m12-20020adfe0cc000000b003078681a1e8sm31367429wri.54.2023.06.19.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:16:24 -0700 (PDT)
Date: Mon, 19 Jun 2023 07:16:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 4/4] virtio-net: remove F_GUEST_CSUM check for
 XDP loading
Message-ID: <20230619071347-mutt-send-email-mst@kernel.org>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-5-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105738.117733-5-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 06:57:38PM +0800, Heng Qi wrote:
> Lay the foundation for the subsequent patch

which subsequent patch? this is the last one in series.

> to complete the coexistence
> of XDP and virtio-net guest csum.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 25b486ab74db..79471de64b56 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -60,7 +60,6 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO6,
>  	VIRTIO_NET_F_GUEST_ECN,
>  	VIRTIO_NET_F_GUEST_UFO,
> -	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
>  	VIRTIO_NET_F_GUEST_USO6,
>  	VIRTIO_NET_F_GUEST_HDRLEN

What is this doing? Drop support for VIRTIO_NET_F_GUEST_CSUM? Why?
This will disable all of guest offloads I think ..


> @@ -3522,10 +3521,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> -		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
> -		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> +		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW, disable GRO_HW first");
>  		return -EOPNOTSUPP;
>  	}
>  
> -- 
> 2.19.1.6.gb485710b


