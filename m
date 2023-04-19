Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75B6E7418
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjDSHgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjDSHf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 03:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9589037
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681889708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6WZsldECgcH7W7pwyXswAdWrzNZ/jMrMZVb+N3FzJQ=;
        b=Cn0r6l8Wm5Gsls/RAtlNIx3D+Y/1ty5ZuvQvx7kx5pkWj9Ws9DRqdyRQZiMNHD19Z6FM1Q
        3N0XbSQ7vRXeIs4VWjpE0KjqbB66lI9pE1ehIF0ETkfpgvGV1Tt3O2n7swso7m9MS4n+Vi
        Ku/FsJ3JS4WTW3TgB910kw5aB9aXEaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-yTbLClLFMMWAOP-RjB7XNQ-1; Wed, 19 Apr 2023 03:35:07 -0400
X-MC-Unique: yTbLClLFMMWAOP-RjB7XNQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2fa5d643cd8so727600f8f.2
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889706; x=1684481706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6WZsldECgcH7W7pwyXswAdWrzNZ/jMrMZVb+N3FzJQ=;
        b=cvYE3R0Eu4DF+j5hsCYf1BNi41Vh1CKQPng6WnxCeTguRZTHXt1rD/g9bwyT5FuH5g
         7WOqTizA51S6rO2w0yM7g85ZdO/dIbBACpR9NqKe8V4WXwrTTPN7AosbdS1z95tp7BF0
         uIhryuDyw1ZlXk34NXG7iMW0PzDxNJUB3uQcI+8dR46l0iRJDpKdm8y+U5MvInu0z1sn
         sDzTWWTQRLE6AikcTfnHSD917ws2RsmvY9oKY8wMyqNTxN+RBNaP/Qm/ZECpcnu8Qkn3
         9pQ3DmB/Xgevy3mwz7aq5mF9NiJzrskIRTWd04NHD/0Hz3sKCx+xnPnxWlwCMNkI7gL3
         38aA==
X-Gm-Message-State: AAQBX9fjp57m6Va9XJbX7/BnUuywBRX/xsBOr/xbuoo4uUURqimlyc0h
        cYb3AzygAxGZkpAdwiRxJd11ajL5ptNwHy3+53YkCw7VESrzDQJ0A/3ErZ5Me/aZ3uSk8kOLZlO
        TeVirR1EB1xiV
X-Received: by 2002:adf:f203:0:b0:2f6:de1f:acb6 with SMTP id p3-20020adff203000000b002f6de1facb6mr3331796wro.34.1681889706258;
        Wed, 19 Apr 2023 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvQzgJcNa5oFUiKgVF/Ubwg9HDlxjq/9Gihac0CNYXVV9qe+d31ECu9kVTWy4hBWTvUpZvxg==
X-Received: by 2002:adf:f203:0:b0:2f6:de1f:acb6 with SMTP id p3-20020adff203000000b002f6de1facb6mr3331780wro.34.1681889705988;
        Wed, 19 Apr 2023 00:35:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:19dd:3a43:9645:16eb:e84c])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm1251313wmq.38.2023.04.19.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 00:35:05 -0700 (PDT)
Date:   Wed, 19 Apr 2023 03:34:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make me a reviewer of VIRTIO CORE AND NET
 DRIVERS
Message-ID: <20230419033449-mutt-send-email-mst@kernel.org>
References: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 03:16:10PM +0800, Xuan Zhuo wrote:
> First of all, I personally love open source, linux and virtio. I have
> also participated in community work such as virtio for a long time.
> 
> I think I am familiar enough with virtio/virtio-net and is adequate as a
> reviewer.
> 
> Every time there is some patch/bug, I wish I can get pinged
> and I will feedback on that.
> 
> For me personally, being a reviewer is an honor and a responsibility,
> and it also makes it easier for me to participate in virtio-related
> work. And I will spend more time reviewing virtio patch. Better advance
> virtio development
> 
> I had some contributions to virtio/virtio-net and some support for it.
> 
> * per-queue reset
> * virtio-net xdp
> * some bug fix
> * ......
> 
> I make a humble request to grant the reviewer role for the virtio core
> and net drivers.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I'll queue this, thanks

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cacd6074fb89..700b00a9e225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22064,6 +22064,7 @@ F:	include/uapi/linux/virtio_console.h
>  VIRTIO CORE AND NET DRIVERS
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-vdpa
> -- 
> 2.32.0.3.g01195cf9f

