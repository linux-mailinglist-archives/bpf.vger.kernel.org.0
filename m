Return-Path: <bpf+bounces-3434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B974273DEB1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF281C208AF
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34378C08;
	Mon, 26 Jun 2023 12:15:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F428F40
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:15:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E42965
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687781678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22WmVT+7Zmhki4DbVPIS8XuRnrKCCPWq47wid/h9Rn0=;
	b=b88JNUT59dFj9kZGnBqWaTH1mJd6T/mG08IZ5sM5FCnlX4nCQYMSajsnVJwYHSUTOYwLJP
	hOBhdj/Ymj0S0kdKM19Xo8Dax3KKv7RUTsrIgkA5q6kSo1WwepuUQ/zX7DFNsvOSDl/jSN
	Oe80unUxndE6XwKyKHkhHk3KGVSAq6w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-4gxoXiArNsa6xKk6SH0mQQ-1; Mon, 26 Jun 2023 08:14:37 -0400
X-MC-Unique: 4gxoXiArNsa6xKk6SH0mQQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f8727c7fb6so2227784e87.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 05:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781676; x=1690373676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22WmVT+7Zmhki4DbVPIS8XuRnrKCCPWq47wid/h9Rn0=;
        b=Glw+NbWeaR2PpJTlPcwplalshAJzSk9EchcGZxqaKBFKzdms82rQqhZBb45hILk32g
         68YoI2FqfjnYxRHTHTBVlKzuuDtIUFWxll/IaYfeeQ5gVGswaPaRG6JrwiEP94wyivkn
         54KDzNKM6BCg8PVU/cNagzX2TEL1ToxHBn20CCBH/E8FULPIU8Hzskz7b/7W+ZCXzF4I
         Ic2V8dak1yBOWPyfnjtcCOzAEhOal5iwTxQTI4vexPJv5FMhPFXXM/vvRBDzzcObvLLV
         YS/rHnwQ2cpBrxg/zpFd+eCd7wxTVRTD1/eTsMMQCsAPJXuL3DrdVYnh4Xk106+0mKQR
         wuFg==
X-Gm-Message-State: AC+VfDyT0FNgbXquMnncBHnUWsMtotE5QOYiTV8IabSVKc2w6gOv0qj3
	EtTZxchsd6Me3OF6HG4sMorEGbPIC3SC1eBxIwFwT4Kvh0RiAp7NClgRLieSVVvd9DfbaLoEh+s
	QxW/JUm5bz9EN
X-Received: by 2002:a19:e602:0:b0:4f9:5781:862a with SMTP id d2-20020a19e602000000b004f95781862amr8962211lfh.38.1687781675996;
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55GtGYtuZHkDMDjKepbhLCFc+83Ou0uEamg9IC7SkfjaY0Zu3aOZfXSgKOYHGrIGxJiQt99A==
X-Received: by 2002:a19:e602:0:b0:4f9:5781:862a with SMTP id d2-20020a19e602000000b004f95781862amr8962188lfh.38.1687781675607;
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id q15-20020a056000136f00b0031122bd3c82sm7249465wrz.17.2023.06.26.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:14:35 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:14:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] virtio-net: remove GUEST_CSUM check for
 XDP
Message-ID: <20230626081418-mutt-send-email-mst@kernel.org>
References: <20230626120301.380-1-hengqi@linux.alibaba.com>
 <20230626120301.380-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626120301.380-3-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 08:03:01PM +0800, Heng Qi wrote:
> XDP and GUEST_CSUM no longer conflict now, so we removed the

removed -> remove

> check for GUEST_CSUM for XDP loading/unloading.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v1->v2:
>   - Rewrite the commit log.
> 
>  drivers/net/virtio_net.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0a715e0fbc97..2e4bd9a05c85 100644
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
> @@ -3437,10 +3436,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


