Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF086E1D60
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNHjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDNHjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 03:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A10C4C06
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681457923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMIqjynha0lnhe23OoFWtNYm7T0bO0fGReoRZ9IdJV8=;
        b=glpkoFDPTQ3WbxNM6Rer3iskzi+SaflDFJXGiY8+/vurw81cypJntZblXnxKD2DQ4qkECW
        y9zlijC/ZTQwT64eDFWtUFFEAi39BOIYRTYzLQQsxY1YgRheyeQSESFTClsxFDYOxkejNh
        RysZbeuHKj02is0zlFtTikd6ztPS+9Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-CoRCvzTBMfWjdKarsiwRVw-1; Fri, 14 Apr 2023 03:38:42 -0400
X-MC-Unique: CoRCvzTBMfWjdKarsiwRVw-1
Received: by mail-wm1-f71.google.com with SMTP id p7-20020a05600c1d8700b003f0ba296ff6so383736wms.5
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 00:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681457921; x=1684049921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMIqjynha0lnhe23OoFWtNYm7T0bO0fGReoRZ9IdJV8=;
        b=jRAUhoYjAC18FfcEHOLuNgg+SF6areRNqEGtmlJt107tnyFoFeq7sbrfmsV2i4Gptw
         x1eGwmafXFMAAc7+fUuiakU5hhbmxBXPG+BkSeTlD25g6/YAP/4LUEtecEOaAFAcWUfB
         SXa/jxOxvjJ1IltpdniRVagW9rv+4h+XkbDg1jx1OEjukZRfAzZiDSGeIQheL2+NdwSg
         noSr1BSgzZ43q1b2Gq5rg0hrIuy1xRHraeTJ/mvcrlbfINZ+/KjUkInzvWE9j0JJCNLx
         xAsXTdZF4dVq2NtU58QSd2RbClUMxsmJRMVXue2C+zXY/SuWa0H3ahmwjiClifKV54df
         t87w==
X-Gm-Message-State: AAQBX9dWlZu3GLXYSctUPs35vELzJkUduhu+Isq/g8/QD9rJvXbiV+D0
        Gl4Qp65UO2KAWI+osG2CibXG4ND1T5k8EzLOHwuFyjgRX5zJ7EEwBr4yeFlbUC+IUZM65LkYPL4
        YHoI45dUs+sOm
X-Received: by 2002:a5d:688b:0:b0:2ef:ba74:663 with SMTP id h11-20020a5d688b000000b002efba740663mr3600342wru.27.1681457921244;
        Fri, 14 Apr 2023 00:38:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKnQLs9BRa6pmx717Y3ZbnYozswFnfUPMxvV8w2vmX/ki/yiZdrxC+QHPU+hLN+NERHNjBdQ==
X-Received: by 2002:a5d:688b:0:b0:2ef:ba74:663 with SMTP id h11-20020a5d688b000000b002efba740663mr3600321wru.27.1681457920950;
        Fri, 14 Apr 2023 00:38:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003f071466229sm3600005wmb.17.2023.04.14.00.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 00:38:40 -0700 (PDT)
Date:   Fri, 14 Apr 2023 03:38:37 -0400
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
Subject: Re: [PATCH net v1] virtio_net: bugfix overflow inside
 xdp_linearize_page()
Message-ID: <20230414033826-mutt-send-email-mst@kernel.org>
References: <20230414060835.74975-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414060835.74975-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 02:08:35PM +0800, Xuan Zhuo wrote:
> Here we copy the data from the original buf to the new page. But we
> not check that it may be overflow.
> 
> As long as the size received(including vnethdr) is greater than 3840
> (PAGE_SIZE -VIRTIO_XDP_HEADROOM). Then the memcpy will overflow.
> 
> And this is completely possible, as long as the MTU is large, such
> as 4096. In our test environment, this will cause crash. Since crash is
> caused by the written memory, it is meaningless, so I do not include it.
> 
> Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v1:  add Fixes tag
> 
>  drivers/net/virtio_net.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c0122..ea1bd4bb326d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -814,8 +814,13 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  				       int page_off,
>  				       unsigned int *len)
>  {
> -	struct page *page = alloc_page(GFP_ATOMIC);
> +	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	struct page *page;
> +
> +	if (page_off + *len + tailroom > PAGE_SIZE)
> +		return NULL;
> 
> +	page = alloc_page(GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
> 
> @@ -823,7 +828,6 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  	page_off += *len;
> 
>  	while (--*num_buf) {
> -		int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		unsigned int buflen;
>  		void *buf;
>  		int off;
> --
> 2.32.0.3.g01195cf9f

