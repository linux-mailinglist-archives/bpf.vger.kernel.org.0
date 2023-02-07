Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AF68DBC5
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBGOiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjBGOh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:37:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE23EC71
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675780393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7UwxcvAseBsjh7pGrBqJ/wmKCj0VJ5wu3GBO8xXE30=;
        b=ASUr2GYAZ7wdURCLw3C3GnBjMbv4m6lRCYp2x28gx51BJDFRT9pCt7FPIsQ9/hjT/5OhQp
        jJnaU630jnlykPQQ4cbchv4VdWKdxamS8Ji9iLhjtjJiOdSzyK8nao/uVPi2EJAb4yK0eI
        5/yTz/luMX+psTH4AUT78YkxGnScjPI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-QN631AC1NA-bII2eSMrZaw-1; Tue, 07 Feb 2023 09:32:49 -0500
X-MC-Unique: QN631AC1NA-bII2eSMrZaw-1
Received: by mail-wm1-f70.google.com with SMTP id d14-20020a05600c34ce00b003dd07ce79c8so8225556wmq.1
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7UwxcvAseBsjh7pGrBqJ/wmKCj0VJ5wu3GBO8xXE30=;
        b=HZzxS8TO4ttQPMqGeksVVyRs1PbecfsYZ+ZG8fBhoPccYL4OHiL2aOcxiT6RNcOOJp
         sPwIKAyNyg3Yh8USTvaheN8PBdnlQjk3VQPyyT/o3vbtW1iiujvkfyXMhnXOeHKvk1PE
         mrW1rbAkQ0Kyi3GX7BX1p0Vj8xTanv4CkH4dYgdLJq9HPE54CV2+QW8pWAr4/yaPyRoO
         PBk+7bZsZ32JgsjG8xTAsjybS9WOZGF3TscJenXl7FKVgj4UOD01EQq//S+RxltpAV72
         MxrXqnaL+orrbzTkZO0dkCsU+j6t3Tj05ePiNqtJoU7RcehYFMg7eku5WiLRzfZBYYwW
         AnEA==
X-Gm-Message-State: AO0yUKUm7qipSjx1L5qSLbPpwE8UR68Q/w14xX/g+burggIV2diT7YWq
        LraoTlijZDbD95kqQoaO1xdv87wDUdYCKhYz82ZUQ0EKVCRIkmMrKAOFdtwnmZDMMEzaLBQd23o
        AYRiPOrkK4o3zeC2uMw==
X-Received: by 2002:adf:f692:0:b0:2bf:d0a4:3e63 with SMTP id v18-20020adff692000000b002bfd0a43e63mr2834810wrp.44.1675780275061;
        Tue, 07 Feb 2023 06:31:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9EMyvWAcesJnVx+zWygqLzgzk04YOqSIrlVesjXu4aN4SVh8ZHPZ0ICb66swxD2EjUb062cw==
X-Received: by 2002:adf:f692:0:b0:2bf:d0a4:3e63 with SMTP id v18-20020adff692000000b002bfd0a43e63mr2834785wrp.44.1675780274874;
        Tue, 07 Feb 2023 06:31:14 -0800 (PST)
Received: from redhat.com ([2.52.8.17])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb4c000000b002b6bcc0b64dsm11357157wrs.4.2023.02.07.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:31:14 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:31:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        lorenzo.bianconi@redhat.com, jasowang@redhat.com, hawk@kernel.org,
        john.fastabend@gmail.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH bpf-next] virtio_net: update xdp_features with xdp
 multi-buff
Message-ID: <20230207093102-mutt-send-email-mst@kernel.org>
References: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 10:53:40AM +0100, Lorenzo Bianconi wrote:
> Now virtio-net supports xdp multi-buffer so add it to xdp_features
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

makes sense


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 692dff071782..ddc3dc7ea73c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3281,7 +3281,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  				virtnet_clear_guest_offloads(vi);
>  		}
>  		if (!old_prog)
> -			xdp_features_set_redirect_target(dev, false);
> +			xdp_features_set_redirect_target(dev, true);
>  	} else {
>  		xdp_features_clear_redirect_target(dev);
>  		vi->xdp_enabled = false;
> @@ -3940,8 +3940,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	spin_lock_init(&vi->refill_lock);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> +		dev->xdp_features |= NETDEV_XDP_ACT_RX_SG;
> +	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>  		vi->rx_usecs = 0;
> -- 
> 2.39.1

