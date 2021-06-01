Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32342396FA5
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhFAI5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 04:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhFAI5g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Jun 2021 04:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622537754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PY7QvG98jjhMnaQtt0qVDMLMnjgFKr3v5evHIzJFZPU=;
        b=gJ3aoqGDA7aSMhZGffwJItHWkXshCl0FpcnQvf8PPPqQDck8B+xUqFPcfLOFbZzfK1bh8U
        0MSSFH4M7F8Ek8/YX8YQnjuRfibJ3nD1AsW7oh31adbMSh6gUg0LefrnPziWcoSEPkuXK3
        Bh1CcmbIWl2pBhmlqUbzMORfB2K3OQI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-1jV1UtqVNWeMmlhGHxxBLg-1; Tue, 01 Jun 2021 04:55:53 -0400
X-MC-Unique: 1jV1UtqVNWeMmlhGHxxBLg-1
Received: by mail-pj1-f71.google.com with SMTP id k1-20020a17090a7f01b029015d0d4c2107so6598691pjl.0
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 01:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PY7QvG98jjhMnaQtt0qVDMLMnjgFKr3v5evHIzJFZPU=;
        b=C3mJw5gc/YsR2uodU5OlTVOyQ6Q2+2LkVNEWR6fg5PCkLA7StbClpPh5AqdWfwtjQq
         67V5fhzX9+ZE3ljLzw2Tmt8xB8JhA+Bqtkxp3GTRunlPVojKyi3dhuztqRbiUnbPsbeN
         XBTyRobbuS0Ax2E2QJUbp2s7E1kXeC0o9fbOP9JG5IwqmhKK8Jv2HCTQpUO7UWLebN8H
         IIDnRkQ1vMADW0gbPRSewUDYVToDPecaFtEC//g+H8Hm3PhdpxxhaN3kO+54s2Rb62OD
         1fBVimFFe2pyF/6a2bWZ9nTurcY+Lu5QDTKXQ9YNwGxhhVk1nPue+mY/pY5bEFU2z3f7
         KmFA==
X-Gm-Message-State: AOAM531PlXIWNGRc9qvMtyPGeU52CGAJX9GMlIQGqD46dIETbjOjjmwT
        OAoaSxnHwzna2YDEe8gBbc2HL1vy6xNJT6j1O4nedRVpQWmGNFd4hzOJ1qgCUUTvz9GHGeN5wdr
        kO4iI3b7hZZC5rTQLzs4vH0H8NTe6JcSXw4n/k7fP8ghQAPlrAMlzQXJeNR0fPx6d
X-Received: by 2002:a63:b507:: with SMTP id y7mr27012044pge.74.1622537752178;
        Tue, 01 Jun 2021 01:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKw7SvOWAkrqbo3g5ghE03u4CDleLTZxkw6OTAQFt0JQyWPfxEXSmv/ACbNht9ydqPWa3N+Q==
X-Received: by 2002:a63:b507:: with SMTP id y7mr27012023pge.74.1622537751925;
        Tue, 01 Jun 2021 01:55:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n17sm2261391pfv.125.2021.06.01.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:55:51 -0700 (PDT)
Subject: Re: [PATCH net v2 2/2] virtio_net: get build_skb() buf by data ptr
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601064000.66909-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3e0f4152-b41f-5cd4-ee38-95bae89ad1b2@redhat.com>
Date:   Tue, 1 Jun 2021 16:55:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601064000.66909-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2021/6/1 ÏÂÎç2:40, Xuan Zhuo Ð´µÀ:
> In the case of merge, the page passed into page_to_skb() may be a head
> page, not the page where the current data is located. So when trying to
> get the buf where the data is located, we should get buf based on
> headroom instead of offset.
>
> This patch solves this problem. But if you don't use this patch, the
> original code can also run, because if the page is not the page of the
> current data, the calculated tailroom will be less than 0, and will not
> enter the logic of build_skb() . The significance of this patch is to
> modify this logical problem, allowing more situations to use
> build_skb().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6b929aca155a..fa407eb8b457 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -401,18 +401,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   	/* If headroom is not 0, there is an offset between the beginning of the
>   	 * data and the allocated space, otherwise the data and the allocated
>   	 * space are aligned.
> +	 *
> +	 * Buffers with headroom use PAGE_SIZE as alloc size, see
> +	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>   	 */
> -	if (headroom) {
> -		/* Buffers with headroom use PAGE_SIZE as alloc size,
> -		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> -		 */
> -		truesize = PAGE_SIZE;
> -		tailroom = truesize - len - offset;
> -		buf = page_address(page);
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

