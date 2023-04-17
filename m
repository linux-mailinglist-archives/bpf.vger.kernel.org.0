Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F56E4005
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDQGo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQGo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 02:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9510DE
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681713823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HU6O3KzfQ0zQunJtU8XAVLCiL1L8OjBQOXvK0FwCmb0=;
        b=SJNcCko2bzU9iqUeCY2VMmR8opCF/1eIy4Vmu6i1x2svw+CSPdOWtoYfwZE7mugrcOeTxS
        SKKh61lZbU9rZ2p2K6o5WRqQRtozrqwepxoO+QTRFHVdIFXdmkE5dQxa9TwnY0eHJX5ocz
        5/ZJ6yuxy6cIrJUNSBGMY6RjnzhaGXg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-ovEWVLrWNm2g96iap2ItXA-1; Mon, 17 Apr 2023 02:43:41 -0400
X-MC-Unique: ovEWVLrWNm2g96iap2ItXA-1
Received: by mail-qt1-f198.google.com with SMTP id i17-20020ac85c11000000b003ef3220ad7aso605252qti.7
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713821; x=1684305821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU6O3KzfQ0zQunJtU8XAVLCiL1L8OjBQOXvK0FwCmb0=;
        b=QZAg8jYVfI0YfX7hdNTQMp/6stOyoAsEQkCvklTXxjFYkFozG44sVG3M12waY6Elhf
         pfR03KnuwxDyMhdxifgV8JjPbbvx3rU1wR6SfEyYdJ8R1ejnVCnwpPcVTA+pXG32ti7B
         KeemSFvxL4FdR76Fzv03D+pvX1I/akr5GSszpm2+qzquBCkFjcYz+ruef9h5+DhyFZVO
         HPDrvXoruNRzszrtloGpSc1OSeWHyTOdx7ZFRtyne3m0r/WZHLImp/G6A8e7ifUZYlep
         Tbw6qSOh3hd8VGXWYYXPVQX02iZOfP6ThrSbjhJcFqITlBDrHIYwShPZl4krMkb6jtjS
         AuVQ==
X-Gm-Message-State: AAQBX9c7D51oSaHwPfBUXaz11s1IfPYZoKTMPh3eEV+h4MlbJcBCWfa5
        vIlMZV3CdqA0O0VZujEIXxjYSoKreqIztDIUpoB/mgBmWZ39bq+TrdLIiLIhNBlydAOPYKw8hEp
        k02CeUKImGkn6
X-Received: by 2002:a05:622a:1756:b0:3bf:d8b6:4ca1 with SMTP id l22-20020a05622a175600b003bfd8b64ca1mr20925350qtk.28.1681713821382;
        Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350aze/kYu2ExuJQuREbYNzivfTsLWddfaCb28LVbISLKnDjQ8eKYMKUloj0ytrzWgoKdCDYq1w==
X-Received: by 2002:a05:622a:1756:b0:3bf:d8b6:4ca1 with SMTP id l22-20020a05622a175600b003bfd8b64ca1mr20925333qtk.28.1681713821133;
        Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
Received: from redhat.com ([185.199.103.251])
        by smtp.gmail.com with ESMTPSA id ay43-20020a05620a17ab00b0074577e835f2sm2985905qkb.48.2023.04.16.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:43:40 -0700 (PDT)
Date:   Mon, 17 Apr 2023 02:43:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <20230417024216-mutt-send-email-mst@kernel.org>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 11:27:50AM +0800, Xuan Zhuo wrote:
> @@ -532,9 +545,9 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
>  	xskb->xdp.data_meta = xskb->xdp.data;
>  
>  	if (pool->dma_need_sync) {
> -		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> -						 pool->frame_len,
> -						 DMA_BIDIRECTIONAL);
> +		pool->dma_ops.sync_single_range_for_device(pool->dev, xskb->dma, 0,
> +							   pool->frame_len,
> +							   DMA_BIDIRECTIONAL);
>  	}
>  	return &xskb->xdp;
>  }
> @@ -670,15 +683,15 @@ EXPORT_SYMBOL(xp_raw_get_dma);
>  
>  void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
>  {
> -	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> -				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> +	xskb->pool->dma_ops.sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> +						      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
>  }
>  EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
>  
>  void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
>  				 size_t size)
>  {
> -	dma_sync_single_range_for_device(pool->dev, dma, 0,
> -					 size, DMA_BIDIRECTIONAL);
> +	pool->dma_ops.sync_single_range_for_device(pool->dev, dma, 0,
> +						   size, DMA_BIDIRECTIONAL);
>  }
>  EXPORT_SYMBOL(xp_dma_sync_for_device_slow);

So you add an indirect function call on data path? Won't this be costly?

> -- 
> 2.32.0.3.g01195cf9f

