Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B46F31EE
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjEAOXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 10:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA51B7
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682950937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RkzLjfDV3jDBH/5apcAJdC/NVfaw0NU9ehtudGGZu7o=;
        b=ddIP2qhUG7n42etd1gqsNqeQpX2u08hluf6FCkqF/1xBIEOLMTKO9lYEll+eogGOw9xkkW
        ag7DCzbi2rHJI56v+G8L3iG9ifjpIjxyUunqpnSO10AgCrSMOfUuDsy2lyC9XEUSsWTGFJ
        /dfkhMRjbmNxNiXeD5HDjUUj79UEALM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-JxRjaz-0Oz6f9CcuOt7eew-1; Mon, 01 May 2023 10:14:53 -0400
X-MC-Unique: JxRjaz-0Oz6f9CcuOt7eew-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f446161e5aso1570990f8f.1
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 07:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950484; x=1685542484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkzLjfDV3jDBH/5apcAJdC/NVfaw0NU9ehtudGGZu7o=;
        b=hFpXezo9+VIDKzpCC/FnEmCkAQuYSmcgWqbZUYIB45mtDVF9d/iT2aa0pcHKTIjfU5
         Cn+i+4dMRuFxO3X8LAfNuLh9GSJw59ESez6uwsbBANFoceMQ2V5A5C+Aiw3oJQcWwQKt
         DYTGp3LVMSjTHSiP6PI+RCc5FipKn8fIRBXZVwgsXzDVaPny4kQNY+VP1SszQsvrBdqM
         k9cyCfOo3pbBnBGVR/ejUN+iADiIcaAE34JZVZbYAjCE3zxDPwxGZ0+k6WQ0ZsygX+/K
         IlgwdP3dgviMhrZHJJuuyP+A8OARRWxNs+IqlAp5h+7MorYBGgDk2bMcvd0OnIrWlmnj
         BeQA==
X-Gm-Message-State: AC+VfDypskTtZtSdOBC7neLuqThBv0vLEA+gc9eYCD3v0a+NUL7m+h6i
        E8EA4Jg/Hdi3xobbscrQkQkBs1Z/4Xs7480ycUIPv6sKIuw50RSrJzIMegU2H2Dlf0qzMHc7upV
        6FqUJOSLXFiG3
X-Received: by 2002:a05:6000:509:b0:2fe:851c:672f with SMTP id a9-20020a056000050900b002fe851c672fmr9551050wrf.8.1682950484515;
        Mon, 01 May 2023 07:14:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bj2HHSdD3I+NdpPeXH4HQFptQUC3elBpKv3Fi3+yFl4cDAKLhdolkyoIR/w5qExxaIYONDQ==
X-Received: by 2002:a05:6000:509:b0:2fe:851c:672f with SMTP id a9-20020a056000050900b002fe851c672fmr9551040wrf.8.1682950484267;
        Mon, 01 May 2023 07:14:44 -0700 (PDT)
Received: from redhat.com ([31.210.184.46])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4410000000b002f79ea6746asm28263967wrq.94.2023.05.01.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:14:43 -0700 (PDT)
Date:   Mon, 1 May 2023 10:14:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        William Tu <witu@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net v1 1/2] virtio_net: Fix error unwinding of XDP
 initialization
Message-ID: <20230501101415-mutt-send-email-mst@kernel.org>
References: <20230428223712.67499-1-feliu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428223712.67499-1-feliu@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 06:37:12PM -0400, Feng Liu wrote:
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
> 
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Post with 2/2 in the same thread or better just squashed.

> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..fc6ee833a09f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1868,6 +1868,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +static void virtnet_disable_qp(struct virtnet_info *vi, int qp_index)
> +{
> +	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +	napi_disable(&vi->rq[qp_index].napi);
> +	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -1883,20 +1890,27 @@ static int virtnet_open(struct net_device *dev)
>  
>  		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->rq[i].napi.napi_id);
>  		if (err < 0)
> -			return err;
> +			goto err_xdp_info_reg;
>  
>  		err = xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
>  						 MEM_TYPE_PAGE_SHARED, NULL);
> -		if (err < 0) {
> -			xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -			return err;
> -		}
> +		if (err < 0)
> +			goto err_xdp_reg_mem_model;
>  
>  		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
>  		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
>  	}
>  
>  	return 0;
> +
> +	/* error unwinding of xdp init */
> +err_xdp_reg_mem_model:
> +	xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> +err_xdp_info_reg:
> +	for (i = i - 1; i >= 0; i--)
> +		virtnet_disable_qp(vi, i);
> +
> +	return err;
>  }
>  
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> -- 
> 2.37.1 (Apple Git-137.1)

