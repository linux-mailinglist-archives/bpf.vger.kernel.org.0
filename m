Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98D6F31E8
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjEAOQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjEAOQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 10:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2651E52
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682950541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y06KhFiSRmxfz+95pafw0MpGOEwTRg5/RLAX9104Y+A=;
        b=T1zyWRcO5GQ/EKFTkhEVGa3Q46xaQjVo/PhWdNlnmKw0qKdOeBN7JgD1PjrHTv0ROSsgzn
        TbZbpu2jlEXQZkrw8O0izP1SYFjQJBEmnChfge64XOocNNqtfKIjl28tNfeE76HUKXtNrc
        psvnWaRf1tIK2Tz+oHnOP5SI6ZzKjnk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-daMXg_1lM6a9F4_lMU75Uw-1; Mon, 01 May 2023 10:15:16 -0400
X-MC-Unique: daMXg_1lM6a9F4_lMU75Uw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f1757ebb1eso7151655e9.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 07:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950499; x=1685542499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y06KhFiSRmxfz+95pafw0MpGOEwTRg5/RLAX9104Y+A=;
        b=hAsNeK1m2J6afwtD4YHF5yptKe/Py310Pj01CEP+UPZ9B6tambx+eiLbEtulCVUCJr
         AKE5mpkrBT+JvY6WfsnWia61yXLMbac54VnN+maX+oVNr5AXD9P//nwXZySHzz3l6p/C
         jsZS777Dlnwv0tuOyQaQ33sImszTGbADjt7wxCs5JCOYOYWRr018YMW+vE35+je3hek2
         HQzy8ylbOdA2we6jnuKw4nxFtBDDYieWDsZVhSpJJjOQ0rRaLvIqMXbV7G5Q+Zv1YDVo
         5FQtmgC2+H01ViQpYVZ7PasbhZxQYkuIoy4+eg484+eH8xSoGmbH/3Z3GlqivGEro19D
         FVSA==
X-Gm-Message-State: AC+VfDwzBJRmtGHfSpPg2OkbCPlsBqUoDc7+e5YZuDC2uFD9rIjq/8cp
        dU1wVu5cSk3IFFq8NTrzQSTg2CKP09idHv4JJ2PHnjQXcpqJKUnOehUq3S/ZEtOa63PtDh3aElm
        Xwn/LopnMmDKg
X-Received: by 2002:a7b:c5d9:0:b0:3ed:b048:73f4 with SMTP id n25-20020a7bc5d9000000b003edb04873f4mr9553265wmk.5.1682950499076;
        Mon, 01 May 2023 07:14:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7y0Up0kde569/l4iM+Ve0RAZmTBkiozrp7NzXkC2ctDGii5Zttu8Ai2doElpYS4GvXCAS9ZQ==
X-Received: by 2002:a7b:c5d9:0:b0:3ed:b048:73f4 with SMTP id n25-20020a7bc5d9000000b003edb04873f4mr9553246wmk.5.1682950498792;
        Mon, 01 May 2023 07:14:58 -0700 (PDT)
Received: from redhat.com ([31.210.184.46])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003f173a2b2f6sm36487588wmo.12.2023.05.01.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:14:58 -0700 (PDT)
Date:   Mon, 1 May 2023 10:14:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        William Tu <witu@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net v1 2/2] virtio_net: Close queue pairs using helper
 function
Message-ID: <20230501101450-mutt-send-email-mst@kernel.org>
References: <20230428224346.68211-1-feliu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428224346.68211-1-feliu@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 06:43:46PM -0400, Feng Liu wrote:
> Use newly introduced helper function that exactly does the same of
> closing the queue pairs.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fc6ee833a09f..5cd78e154d14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2319,11 +2319,8 @@ static int virtnet_close(struct net_device *dev)
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_napi_tx_disable(&vi->sq[i].napi);
> -		napi_disable(&vi->rq[i].napi);
> -		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -	}
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		virtnet_disable_qp(vi, i);
>  
>  	return 0;
>  }
> -- 
> 2.37.1 (Apple Git-137.1)

