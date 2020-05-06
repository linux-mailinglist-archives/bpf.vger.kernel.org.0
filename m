Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA31C6A27
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEFHhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 03:37:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbgEFHhu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 03:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588750668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1DqHn9dPlmj80heFjYayVPfLacQlouJrbO3+dn30g+Y=;
        b=IGosKOOhtur924OsjKmcDnLD1Co+WRdGMjZjU8XKvleAKVOpDZBRqnAZs4cYKveWm5PGRL
        wYoC6n/164dbOuenEzD+SF6nSPP+y+AgjRygzhX8ZYBRAKxW8dI8/N6Y5JSEleZch8dNJS
        6oz35GaK5vnBLxwzgSADBIpUq99+fu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-ouOM_977PHe1w2PMaDHPCA-1; Wed, 06 May 2020 03:37:47 -0400
X-MC-Unique: ouOM_977PHe1w2PMaDHPCA-1
Received: by mail-wr1-f70.google.com with SMTP id u4so868169wrm.13
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 00:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DqHn9dPlmj80heFjYayVPfLacQlouJrbO3+dn30g+Y=;
        b=HOaMCacP4Q6PPxciQBbWRxYlwJVgdCPpPFi4GVakIlFHY1IgwTHUxIzAtPWn0qtJd+
         rtIkwzbonpBH1d5sPGyIcF2MGTfVwwdfFi0+f7jptqfyLi6jl3UQWunbJ0p5cgg5rAwY
         JLqmsOVkhNkXw/XBkywyGKy+wL2wAajKJSEOut2u/sR/+jsLnNoQ1vsKTNEELl7PHzNI
         sTozpk8j0sDj2Cl/9LJLgzlNv3nShjgsJ1TevqfJ3TM9IH3ADFy6pGStaCxEBilSExI1
         Cfg04lsVlCO2F0GYfG0L56LF5CvfuHDg3sAmraYzH2SXii2jRbuEhjfHOzycCjn3lV/R
         Hndg==
X-Gm-Message-State: AGi0PubbdS9yIPcEHJlW8mb94gs+I1hicKDhL5YETVvvcyvPYk+yG0n/
        FHtYBexOA9OPuNr52iH915ojk8aFGL1pIRq85Bx2aNGIwU2MNnbxM2dQEeXCxRJ7ijskKsZvqU5
        lXYQ2XCsKIE1Q
X-Received: by 2002:adf:ce10:: with SMTP id p16mr7691544wrn.144.1588750665672;
        Wed, 06 May 2020 00:37:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLylGfrIQvy8pwm2otNVLPO1o3cMHW4JbPm3GLxsqO+x+n/Q0pR35QnHj4F0DC4IEX6mTgYDA==
X-Received: by 2002:adf:ce10:: with SMTP id p16mr7691526wrn.144.1588750665498;
        Wed, 06 May 2020 00:37:45 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id 19sm1655337wmo.3.2020.05.06.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 00:37:45 -0700 (PDT)
Date:   Wed, 6 May 2020 03:37:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize
 calculation for mergeable buffers
Message-ID: <20200506033259-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506061633.16327-2-jasowang@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
> We should not exclude headroom and tailroom when XDP is set. So this
> patch fixes this by initializing the truesize from PAGE_SIZE when XDP
> is set.
> 
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Seems too aggressive, we do not use up the whole page for the size.



> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 98dd75b665a5..3f3aa8308918 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1184,7 +1184,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	char *buf;
>  	void *ctx;
>  	int err;
> -	unsigned int len, hole;
> +	unsigned int len, hole, truesize;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
>  	 * means rx frags coalescing won't work, but consider we've
> @@ -1194,6 +1194,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>  		return -ENOMEM;
>  
> +	truesize = headroom ? PAGE_SIZE : len;
>  	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
>  	buf += headroom; /* advance address leaving hole at front of pkt */
>  	get_page(alloc_frag->page);

Is this really just on the XDP path? Looks like a confusing way to
detect that.


> @@ -1205,11 +1206,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  		 * the current buffer.
>  		 */
>  		len += hole;
> +		truesize += hole;
>  		alloc_frag->offset += hole;
>  	}
>  
>  	sg_init_one(rq->sg, buf, len);
> -	ctx = mergeable_len_to_ctx(len, headroom);
> +	ctx = mergeable_len_to_ctx(truesize, headroom);
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0)
>  		put_page(virt_to_head_page(buf));
> -- 
> 2.20.1

