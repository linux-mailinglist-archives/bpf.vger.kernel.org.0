Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1E6F0FE7
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 03:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbjD1BJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjD1BJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBF5268D
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682644114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIlO9U65Fa78/bYD7F0pTgvbn+G5S4dqydIF9IQsHyM=;
        b=UBUZ00/KxZotHGMslz0MXHfvm21ILlico26MI20/vyrQpJL3r+MxQWTNvBijf9p7FsPvq3
        fFTNjiGSJtrc9hXIAIMtzB9HXnvnh6l+I/74n8bmwHq5c9CfIjn4WCnFQ8NYTcyVCrzTQQ
        dTahGP7XEZqG49NBJ87ZCRjItMDmMPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-gWaxj2g5NxaQKn7RRBXmCQ-1; Thu, 27 Apr 2023 21:08:33 -0400
X-MC-Unique: gWaxj2g5NxaQKn7RRBXmCQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fe3fb8e32aso3400938f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 18:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644110; x=1685236110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIlO9U65Fa78/bYD7F0pTgvbn+G5S4dqydIF9IQsHyM=;
        b=I4avcQpfTSnXlwHak9jlO2bQDk87qQz0Zjg2LVfxcSYso1JKvF6hbbDDLfCnBiF3C3
         2EJn3ajK0cwuVNgIAeiwL9IFUvbLna4KU4QyumTS8Tqc289Ebw+uPLRbqtntc+rgAUa2
         wFB9ORNH6EbtHEyxJH7LHLygtBGlqa3OIvtpvnlToN4GVMtfwQLre4P3UE0T/BG9EUYH
         CG0Hh43J5maFagFeXLKPQJOLYz4ltTOBUA9YfxuezAoV3K/C7I0f40ep10hED6o96NBm
         ogG+ERpoLa8uqvISZG4+Jo5ehpXAHUATq98EFuQksyBjmhx6ImKRYxToXaydhHwZrt28
         z1wg==
X-Gm-Message-State: AC+VfDzb9PNTYtcXYp3EJcXoA4OHeiEdDEix6u2q6sE+3Q/c57Pr4Vkv
        HbDYo92QL2+0zaPL1iisLmHYyMXCEDqwVe4k2Hy2bzzgoeVslsRu1oQ//SdJL3bydbv27RH/NQm
        xtajSs4dcjKE8
X-Received: by 2002:a05:6000:12c8:b0:303:a2e4:e652 with SMTP id l8-20020a05600012c800b00303a2e4e652mr2432532wrx.14.1682644110297;
        Thu, 27 Apr 2023 18:08:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43yyZywMx1CB2ADiJh65tjfwD1uFSRC7hVGQKqY+xMXE6kvoExBkKUH0cVOJuari+LUhVLcQ==
X-Received: by 2002:a05:6000:12c8:b0:303:a2e4:e652 with SMTP id l8-20020a05600012c800b00303a2e4e652mr2432520wrx.14.1682644110024;
        Thu, 27 Apr 2023 18:08:30 -0700 (PDT)
Received: from redhat.com ([2.52.19.183])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003f3195be0a0sm3088178wmi.31.2023.04.27.18.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:08:29 -0700 (PDT)
Date:   Thu, 27 Apr 2023 21:08:25 -0400
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
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/15] virtio_net: small: avoid double
 counting in xdp scenarios
Message-ID: <20230427210802-mutt-send-email-mst@kernel.org>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
 <20230427030534.115066-13-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427030534.115066-13-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 11:05:31AM +0800, Xuan Zhuo wrote:
> Avoid the problem that some variables(headroom and so on) will repeat
> the calculation when process xdp.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>


this is "code duplication" not "double counting".


> ---
>  drivers/net/virtio_net.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b8ec642899c9..f832ab8a3e6e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1027,11 +1027,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	struct sk_buff *skb;
>  	struct bpf_prog *xdp_prog;
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> -	unsigned int headroom = vi->hdr_len + header_offset;
> -	unsigned int buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> -			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	struct page *page = virt_to_head_page(buf);
> +	unsigned int header_offset;
> +	unsigned int headroom;
> +	unsigned int buflen;
>  
>  	len -= vi->hdr_len;
>  	stats->bytes += len;
> @@ -1059,6 +1058,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	rcu_read_unlock();
>  
>  skip_xdp:
> +	header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +	headroom = vi->hdr_len + header_offset;
> +	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> +		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
>  	skb = build_skb(buf, buflen);
>  	if (!skb)
>  		goto err;
> -- 
> 2.32.0.3.g01195cf9f

