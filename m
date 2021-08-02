Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD24B3DDE27
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhHBQ6g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 12:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhHBQ6f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Aug 2021 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627923505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLtJMTV3XxU3KgnKFo51GqvkBw6b2sHrRuc+JcFDw+A=;
        b=AdikwnAGI9E8i4fTc3z+35X5ArA3h1AjqoB3T4ZumUWARd+Yv4Uktud7Agf9VnnwjlE6p8
        eSYiZ96Ybd7fEDYhl5cjf0PpIMrojc2yqCJAAkgg50kzMmxBAEA5chtY3cKVkhJpgwtvVC
        9bjGT77k+P47gl3PZcHmfFaRI8EefgU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-FHVFAd-HNSmvasuWQvO7Rw-1; Mon, 02 Aug 2021 12:58:24 -0400
X-MC-Unique: FHVFAd-HNSmvasuWQvO7Rw-1
Received: by mail-ej1-f71.google.com with SMTP id o16-20020a1709066010b0290593804ff1e1so3269543ejj.19
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 09:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLtJMTV3XxU3KgnKFo51GqvkBw6b2sHrRuc+JcFDw+A=;
        b=irTQCoCc1nDLwvMyFxj2sTfEMwatwEtUX89zQyRY43W326W9vRXHbjE7JpW+kJ0sY3
         6ChbTZPKh2nGGrXFHExsYlleTH1AjgsJpBNhMRdUFFxT3xjfBnIAOI/pxKLxdrqMwMM4
         BZZmQLImFdOzCs5AIbQeqlz+FkDlQOcFC+hUImc54qYuG7MI25Eczvge9YkehmiJOgX4
         vBJyobhyFRrIiSAJsQJRI+ha2Wek0SXUuumu55404FDIHtB8RhkfbOaJr3UEIapjLpbi
         pOgd46HYuwjiH8P6RrKfzGXP47KsZptGMo1+7Osx8kQWAqjnIM7AWLXUzfjNekaEEB13
         +0WA==
X-Gm-Message-State: AOAM5318JsagdXY9rLndcOd7Uc+x81djXlPvtbC75OXTFC5kDa80yBTU
        X1JfGzuu4H56rv+8VAqgT6yCbgZ/BKT5aiDsGfSJE6GGIZPq30MT2KPWDeGRWxZgdyOjyHrA7nB
        g2PH0hsjxWRCi
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr20337191edt.321.1627923503312;
        Mon, 02 Aug 2021 09:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxATj21O1r3+lrhG39GL1DBPCTGKHsKjQ1WZRoae9Z7pfD25Idb0cd+cW5p1gKcyX1raoYWMw==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr20337179edt.321.1627923503167;
        Mon, 02 Aug 2021 09:58:23 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
        by smtp.gmail.com with ESMTPSA id j8sm6402996edr.23.2021.08.02.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:58:21 -0700 (PDT)
Date:   Mon, 2 Aug 2021 12:58:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
Message-ID: <20210802125720-mutt-send-email-mst@kernel.org>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601070610-mutt-send-email-mst@kernel.org>
 <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 30, 2021 at 05:16:43AM -0700, Jakub Kicinski wrote:
> On Tue, 1 Jun 2021 07:06:43 -0400 Michael S. Tsirkin wrote:
> > On Tue, Jun 01, 2021 at 02:39:58PM +0800, Xuan Zhuo wrote:
> > > #1 Fixed a serious error.
> > > #2 Fixed a logical error, but this error did not cause any serious consequences.
> > > 
> > > The logic of this piece is really messy. Fortunately, my refactored patch can be
> > > completed with a small amount of testing.  
> > 
> > Looks good, thanks!
> > Also needed for stable I think.
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Just a heads up folks, looks like we ended up merging both this and the
> net-next version of the patch set:
> 
> 8fb7da9e9907 virtio_net: get build_skb() buf by data ptr
> 5c37711d9f27 virtio-net: fix for unable to handle page fault for address
> 
> and
> 
> 7bf64460e3b2 virtio-net: get build_skb() buf by data ptr
> 6c66c147b9a4 virtio-net: fix for unable to handle page fault for address
> 
> Are you okay with the code as is or should we commit something like:

Yes:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Will you post this one then?


> ---
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56c3f8519093..74482a52f076 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -380,7 +380,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  				   struct page *page, unsigned int offset,
>  				   unsigned int len, unsigned int truesize,
>  				   bool hdr_valid, unsigned int metasize,
> -				   bool whole_page)
> +				   unsigned int headroom)
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -398,28 +398,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	else
>  		hdr_padded_len = sizeof(struct padded_vnet_hdr);
>  
> -	/* If whole_page, there is an offset between the beginning of the
> +	/* If headroom is not 0, there is an offset between the beginning of the
>  	 * data and the allocated space, otherwise the data and the allocated
>  	 * space are aligned.
>  	 *
>  	 * Buffers with headroom use PAGE_SIZE as alloc size, see
>  	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>  	 */
> -	if (whole_page) {
> -		/* Buffers with whole_page use PAGE_SIZE as alloc size,
> -		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> -		 */
> -		truesize = PAGE_SIZE;
> -
> -		/* page maybe head page, so we should get the buf by p, not the
> -		 * page
> -		 */
> -		tailroom = truesize - len - offset_in_page(p);
> -		buf = (char *)((unsigned long)p & PAGE_MASK);
> -	} else {
> -		tailroom = truesize - len;
> -		buf = p;
> -	}
> +	truesize = headroom ? PAGE_SIZE : truesize;
> +	tailroom = truesize - len - headroom;
> +	buf = p - headroom;
>  
>  	len -= hdr_len;
>  	offset += hdr_padded_len;
> @@ -978,7 +966,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				put_page(page);
>  				head_skb = page_to_skb(vi, rq, xdp_page, offset,
>  						       len, PAGE_SIZE, false,
> -						       metasize, true);
> +						       metasize,
> +						       VIRTIO_XDP_HEADROOM);
>  				return head_skb;
>  			}
>  			break;
> @@ -1029,7 +1018,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	rcu_read_unlock();
>  
>  	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
> -			       metasize, !!headroom);
> +			       metasize, headroom);
>  	curr_skb = head_skb;
>  
>  	if (unlikely(!curr_skb))

