Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15C395541
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEaGNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 02:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhEaGNA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 May 2021 02:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622441480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFtzwgziSoZ8iozEmB6Ecc/Oz0muKre3EGFmRB+A8Zw=;
        b=LxEXndpd9iVJjq8e5kSD3QD2JezW9fNkuZeibjWMjA5xFEkEvkf4YmPn5q0PCzU97oWWAX
        oZplPss0QNoUonOEh8Dfn9jDgj/z0pwa9qm3bjEHGbtTyjrMTVwtgkYMfWQzKOroSS3Mtn
        7nDbxtz2mboIwRupyCv24NMpOF5bIB0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-lI1wde9bPBefcXlBxRFTvw-1; Mon, 31 May 2021 02:11:18 -0400
X-MC-Unique: lI1wde9bPBefcXlBxRFTvw-1
Received: by mail-pg1-f199.google.com with SMTP id s7-20020a6352470000b029021b9013c124so6644116pgl.19
        for <bpf@vger.kernel.org>; Sun, 30 May 2021 23:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gFtzwgziSoZ8iozEmB6Ecc/Oz0muKre3EGFmRB+A8Zw=;
        b=gc9z4M++k0sqFvUWZOz+7udL/zbMZVbJDlo2uzqm2nYuwAfiyzr9JA2SKfheLyqRD9
         c1eQi9ANLTMUi9nnaOQoAfSE0doEAQAqdb5M+ULpDOENDDz27ohnNVUp8K7WCYtVT3lj
         PUpTBkcJZI2VDQbvJmZS9KeenZBWykwQtc4m6oxBufghl+N5riYmx3cnJDFIyPr6juIn
         ycGG3oZVPFmVLzbczzpAvHr+1C7ik18B05aAm8Cr9d3PWBOmkP69PtuxCTPz/NnEwbCd
         G0LziIGnuaiJbJKppyMoJhiEpmgYUxRfigGEeS3w9E0PiKtA78v9z/nZ3akrlw0uh+y9
         IAJQ==
X-Gm-Message-State: AOAM533mwsv980wW+NNm2dyF+PNqN92MmtEzYBskPKZ+EQlLAR3mZFSt
        fuNFqvp7nI7ff34sQd6KY48k7rQEcJFe2aesaGoxUtqibkEUp5UONQaZf+Ch9V6nAgE1PSlEYLJ
        VwkGd+frHnoa/ZbSCXLLk7jZL2IVMzwEnHY7Mb27P82PPn7O5uYZhq1R9y5RB7tyK
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr20901104pgr.426.1622441476799;
        Sun, 30 May 2021 23:11:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxutLeevxA6LuaKonk96FQO3so1MTRdYBSNys4UBNveOmY1P9CbnJDYcS/TPJxyyRyHmM3yvA==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr20901072pgr.426.1622441476476;
        Sun, 30 May 2021 23:11:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a9sm9621387pfo.69.2021.05.30.23.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:11:16 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20210514151637.117596-1-xuanzhuo@linux.alibaba.com>
 <20210514151637.117596-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2920ec92-43ac-714f-69b5-281467d1d5ad@redhat.com>
Date:   Mon, 31 May 2021 14:10:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210514151637.117596-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2021/5/14 下午11:16, Xuan Zhuo 写道:
> In the case of merge, the page passed into page_to_skb() may be a head
> page, not the page where the current data is located.


I don't get how this can happen?

Maybe you can explain a little bit more?

receive_mergeable() call page_to_skb() in two places:

1) XDP_PASS for linearized page , in this case we use xdp_page
2) page_to_skb() for "normal" page, in this case the page contains the data

Thanks


> So when trying to
> get the buf where the data is located, you should directly use the
> pointer(p) to get the address corresponding to the page.
>
> At the same time, the offset of the data in the page should also be
> obtained using offset_in_page().
>
> This patch solves this problem. But if you don’t use this patch, the
> original code can also run, because if the page is not the page of the
> current data, the calculated tailroom will be less than 0, and will not
> enter the logic of build_skb() . The significance of this patch is to
> modify this logical problem, allowing more situations to use
> build_skb().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e46c12dde08..073fec4c0df1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -407,8 +407,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
>   		 */
>   		truesize = PAGE_SIZE;
> -		tailroom = truesize - len - offset;
> -		buf = page_address(page);
> +
> +		/* page maybe head page, so we should get the buf by p, not the
> +		 * page
> +		 */
> +		tailroom = truesize - len - offset_in_page(p);
> +		buf = (char *)((unsigned long)p & PAGE_MASK);
>   	} else {
>   		tailroom = truesize - len;
>   		buf = p;

