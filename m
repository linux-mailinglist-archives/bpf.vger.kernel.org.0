Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA0688558
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBBR1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 12:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjBBR1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 12:27:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683506B35E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675358773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6WKJ+xTBuqvHJA/DgjJYK9bFyVaTh4ihb15FuQHGdbU=;
        b=NPRTwZXW58S3YBbmdCqzMahGDswTvbD8uAAietX4kOcgjYpqr8cLfwnAd/udJpNSvyF64P
        M8Xj41uSTXRM3yEgr2uMk5ujWtMfc4Q2bVd1yMaleaaEFYyu6f1BeN8/k7K1UH8mJvNwnR
        70i31MzSH6J9pA1W+SjEMsG5F7tyb2A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-wTlZzc_MNf2Pj701Bce-Fg-1; Thu, 02 Feb 2023 12:26:06 -0500
X-MC-Unique: wTlZzc_MNf2Pj701Bce-Fg-1
Received: by mail-wm1-f71.google.com with SMTP id j37-20020a05600c1c2500b003deaf780ab6so1273370wms.4
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 09:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WKJ+xTBuqvHJA/DgjJYK9bFyVaTh4ihb15FuQHGdbU=;
        b=EW2FAmby91IOkWOMARwp8I/DZaDaZT0s3a//yngzvhy3QugNz9LqV1cRAEgES/cNSG
         00SZvT4WJSTtNye5s3vXJklo2ExbLev76nUebzsqY4DueAJH5BCpGBnfzDWagv1SjB3Y
         g+gMOvZh41F647EvhZI940gsWRqcy2/eX8/FXaFS3abtyEKxTEefGaUfmvX45nu4kwP8
         JZgs29+mMHnKZAEwTe/U3S+Yd3x86DcD8qN1IM/m9eBHVdHZGk6EV4t/d7i5o0yn9n/2
         SACGzZWeiKoDlaFmNGKxfiOoWdx+uF8yB/3zK9y+XHXjlC6q+2b7jN22Ecy5RRyoej64
         mRYQ==
X-Gm-Message-State: AO0yUKX8B5uGvttSNtUaYGafB2WqsT+kyv5AuotShxZRKKjbHNt/saJq
        wqGLkh6vebd356zHNr1MXy49AMpxB2/NDWO+K81OhvUfbBT6GrIpwzHkQ6woztaY6dUjBLTWdyM
        6BkFOZ1S5gkME
X-Received: by 2002:a05:600c:1e0b:b0:3da:1e35:dfec with SMTP id ay11-20020a05600c1e0b00b003da1e35dfecmr6910500wmb.4.1675358765642;
        Thu, 02 Feb 2023 09:26:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/z5RmItaflCIcRIT8kR78dHQV5cx7Dg457PMDawnbySjhpBnXC5/Fk1nq6JbSLeIjJqL5pxQ==
X-Received: by 2002:a05:600c:1e0b:b0:3da:1e35:dfec with SMTP id ay11-20020a05600c1e0b00b003da1e35dfecmr6910475wmb.4.1675358765455;
        Thu, 02 Feb 2023 09:26:05 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003dd1c15e7fcsm6365187wmq.15.2023.02.02.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:26:04 -0800 (PST)
Date:   Thu, 2 Feb 2023 12:25:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Message-ID: <20230202122445-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> we must stop tx napi from being disabled.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index ed79e750bc6c..232cf151abff 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  		return ret;
>  
>  	if (update_napi) {
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			/* xsk xmit depend on the tx napi. So if xsk is active,

depends.

> +			 * prevent modifications to tx napi.
> +			 */
> +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> +				continue;
> +
>  			vi->sq[i].napi.weight = napi_weight;

I don't get it.
changing napi weight does not work then.
why is this ok?


> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.32.0.3.g01195cf9f

