Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0DE3DCFD4
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhHBEpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 00:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhHBEpX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Aug 2021 00:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627879514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWU1k5rzzQ7Vi8eeYiIsQOirmMRXBw0kSKn136zOB28=;
        b=JpsxOPlB/qRZ7Dx0aRNKXyHEZ82qp2t6scCPNwe+oY+eGvXrzZrmIebgK+A70l3+udYcaN
        9L6F9AV11ex1lWDkHcMxz13nb61uLM5P09RWbkokrXJp8G+290H2dQc9dkZobbelv1zvaL
        huHHSd+EyV8EK6HMwRZJFgjT/yoOleM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-4iPe_SE0MaCe5JTsodG1UA-1; Mon, 02 Aug 2021 00:45:13 -0400
X-MC-Unique: 4iPe_SE0MaCe5JTsodG1UA-1
Received: by mail-pj1-f70.google.com with SMTP id q63-20020a17090a17c5b02901774f4b30ebso12897946pja.1
        for <bpf@vger.kernel.org>; Sun, 01 Aug 2021 21:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CWU1k5rzzQ7Vi8eeYiIsQOirmMRXBw0kSKn136zOB28=;
        b=S+VvJ3xE2xjzbcxPtkst6pfk0vQlR4o34TQthJqqo6be38eJDhrii7kchVBf0yvpVC
         VxRdalr66eya1dEnG6np7SrwwCBQjyg2341C4A/mXobWp0qD4hueII7/U8D1ClWsJG1z
         AXniOy3/uCOG6J3PHAlE3rqZuvrNDIo+xxWgKdW6/tbXojqbnPCXTYeNoiAiJ9Z+fp8l
         UVEmS1LRaFsZWjn5XyMuL7NvdZfdvMxlK0LRikFhi8t+ECPBdxK/jp7XzPg1NO1uxUba
         SM4g7PrwGVUfi5pvv2SLqm9u6WL95/m/5oqgXeN1MYiKerJPAeV+rcrk3P+mbe5ax5Oa
         hqpw==
X-Gm-Message-State: AOAM532XAQR/nivlCedYhSykkegNx9CQ40T2oTuojSTZPEg5r3LdLKtR
        UmGCyqwchZ8c+PfB4m2h+ysiDZl2kOa6IYg+n9F0uaY1SppSyPFNNHtPgZR77Bo/sSPsqt50LGM
        ii/AbNGk+jqHcQzMAODk0+c0GtLN9ZNPdHO+zhlkXiC5hElNxmLZb1myVTJrDT4WF
X-Received: by 2002:a63:1359:: with SMTP id 25mr541184pgt.79.1627879512392;
        Sun, 01 Aug 2021 21:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoXngPrq5rRn9UeJyNSEFumVnGGLTEtq2/2ysIovNTb7ygYq/sFdvyihjsErzHXJFXhFvKSg==
X-Received: by 2002:a63:1359:: with SMTP id 25mr541160pgt.79.1627879512138;
        Sun, 01 Aug 2021 21:45:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j128sm10345988pfd.38.2021.08.01.21.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 21:45:11 -0700 (PDT)
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
To:     Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601070610-mutt-send-email-mst@kernel.org>
 <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7ec67d98-190e-343d-bc2b-6f42a7ee6402@redhat.com>
Date:   Mon, 2 Aug 2021 12:45:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2021/7/30 ÏÂÎç8:16, Jakub Kicinski Ð´µÀ:
> On Tue, 1 Jun 2021 07:06:43 -0400 Michael S. Tsirkin wrote:
>> On Tue, Jun 01, 2021 at 02:39:58PM +0800, Xuan Zhuo wrote:
>>> #1 Fixed a serious error.
>>> #2 Fixed a logical error, but this error did not cause any serious consequences.
>>>
>>> The logic of this piece is really messy. Fortunately, my refactored patch can be
>>> completed with a small amount of testing.
>> Looks good, thanks!
>> Also needed for stable I think.
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
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


I think we need commit the following codes since it's more easier to be 
understood.

Thanks


>
> ---
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56c3f8519093..74482a52f076 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -380,7 +380,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   				   struct page *page, unsigned int offset,
>   				   unsigned int len, unsigned int truesize,
>   				   bool hdr_valid, unsigned int metasize,
> -				   bool whole_page)
> +				   unsigned int headroom)
>   {
>   	struct sk_buff *skb;
>   	struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -398,28 +398,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   	else
>   		hdr_padded_len = sizeof(struct padded_vnet_hdr);
>   
> -	/* If whole_page, there is an offset between the beginning of the
> +	/* If headroom is not 0, there is an offset between the beginning of the
>   	 * data and the allocated space, otherwise the data and the allocated
>   	 * space are aligned.
>   	 *
>   	 * Buffers with headroom use PAGE_SIZE as alloc size, see
>   	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>   	 */
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
>   	len -= hdr_len;
>   	offset += hdr_padded_len;
> @@ -978,7 +966,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   				put_page(page);
>   				head_skb = page_to_skb(vi, rq, xdp_page, offset,
>   						       len, PAGE_SIZE, false,
> -						       metasize, true);
> +						       metasize,
> +						       VIRTIO_XDP_HEADROOM);
>   				return head_skb;
>   			}
>   			break;
> @@ -1029,7 +1018,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   	rcu_read_unlock();
>   
>   	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
> -			       metasize, !!headroom);
> +			       metasize, headroom);
>   	curr_skb = head_skb;
>   
>   	if (unlikely(!curr_skb))
>

