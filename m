Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0426B8E3E
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNJMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCNJMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 05:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C4984C8
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678785104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7LMCjgV3148z08653yeBgRUZqj0U6BVbsGsCqJdIQw=;
        b=UUmXT6TdicxGcS/N2oLsddDc+beSuRQlkIWlJFwTPtLLM9p/POYSUTGgKM1B2fd7g7akvj
        gcHm+MSFmW5IeNZ65v+xF6s1ysODHCtaiOjbrHX5wQzCXCBkqU0lsl1UCDZNzdGjoBC9Zs
        z1QHEmXZWxd1+qV/OdXrKdvCHmQ1Oek=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-pp92jQavPBuQBdyJYLZZuw-1; Tue, 14 Mar 2023 05:11:42 -0400
X-MC-Unique: pp92jQavPBuQBdyJYLZZuw-1
Received: by mail-ed1-f72.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso12502791edb.16
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 02:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7LMCjgV3148z08653yeBgRUZqj0U6BVbsGsCqJdIQw=;
        b=Cy2xQ6BwErNbA7tCrcFxYH3u33O0ofvkBh81dCnW1I4nHsLZxl1DtVXx1srXpZ71Xn
         4mbymiSG99l9Yst63c0UXOOdFUvKXqm3oEEdlekCnn0lKxE19SnWy90atajWWhGAMxli
         XKDQ466KbECq8Bqqi2bPCiSRqpSxsaC26fhd7m6eJOQpaQQ9cVBPvEu55YbnOUlwzc3r
         bPYcvdadOCbDYPHZNIaoTFwVCUR62ef94rBVTe94pDfquSn+IiWRqP0jpXmKL+tYfJX8
         Zk2fRbBm2iqAqybjVlbXEmu8kEJZ9tgGCWCV/8+t/tldsLKEwPQBNKO5Bd6ErP+xS1nw
         0aGQ==
X-Gm-Message-State: AO0yUKWKH7Z6/0IAvQqGnxrr6XoK73zR1mSkx64Kbqkwaba3fpVtVOGo
        ectQKUrFqBLXta5HwD8xqAhWW93543FdhdnPnNoehq5UuovvVrsX+F3wEV7ICxRt+4FOYU0VerW
        LbODEcl79OkSf
X-Received: by 2002:a17:907:746:b0:92b:ae6c:23e7 with SMTP id xc6-20020a170907074600b0092bae6c23e7mr1868573ejb.56.1678785099438;
        Tue, 14 Mar 2023 02:11:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set+bdi1ysk/4yWOK0bSSOg12ZBcLDKbIuHqp5BWiooRh0XX2E3g6+Wpi5yzgkrXZjiEs1t2Sbg==
X-Received: by 2002:a17:907:746:b0:92b:ae6c:23e7 with SMTP id xc6-20020a170907074600b0092bae6c23e7mr1868546ejb.56.1678785099140;
        Tue, 14 Mar 2023 02:11:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:4129:3ef9:ea05:f0ca:6b81])
        by smtp.gmail.com with ESMTPSA id hd31-20020a170907969f00b0092d58e24e11sm356116ejc.137.2023.03.14.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:11:38 -0700 (PDT)
Date:   Tue, 14 Mar 2023 05:11:32 -0400
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
        Heng Qi <hengqi@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 2/2] virtio_net: free xdp shinfo frags when
 build_skb_from_xdp_buff() fails
Message-ID: <20230314051049-mutt-send-email-mst@kernel.org>
References: <20230314083901.40521-1-xuanzhuo@linux.alibaba.com>
 <20230314083901.40521-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314083901.40521-3-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 04:39:01PM +0800, Xuan Zhuo wrote:
> build_skb_from_xdp_buff() may return NULL, on this
> scene we need to free the frags of xdp shinfo.

s/on this scene/in this case/

> 
> Fixes: fab89bafa95b ("virtio-net: support multi-buffer xdp")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8ecf7a341d54..d36183be0481 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1273,9 +1273,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  		switch (act) {
>  		case XDP_PASS:
> +			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +			if (!head_skb)
> +				goto err_xdp_frags;
> +
>  			if (unlikely(xdp_page != page))
>  				put_page(page);
> -			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  			rcu_read_unlock();
>  			return head_skb;
>  		case XDP_TX:
> -- 
> 2.32.0.3.g01195cf9f

