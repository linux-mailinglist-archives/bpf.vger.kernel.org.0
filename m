Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCEE3AA985
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 05:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhFQD0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 23:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhFQD0O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 23:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623900246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2YA3pPwX5KufYHZusNwV1Ms/tC5NgvQ2lY4eCYE9qw=;
        b=DSCD6Depk82GdWEIyvmUobkMAaJaDhM7Qd/F7TAe4KoN2RHY9nEcIsiLY2kKOVDfMQ9l89
        qDr64J2Vd7TuKOE9n8aJt7zZ2UnKIBqSF+Pxyb6q2KRQbgE7b/qnqM62wt9dOQtzzQ3EXV
        JGHm5NSnK+dwMSRhaKdK1Yes+KFtPzo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-QitVxbTuPVu9yGmfXdP56g-1; Wed, 16 Jun 2021 23:24:05 -0400
X-MC-Unique: QitVxbTuPVu9yGmfXdP56g-1
Received: by mail-pl1-f200.google.com with SMTP id bh7-20020a170902a987b029011744126551so1150368plb.3
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 20:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P2YA3pPwX5KufYHZusNwV1Ms/tC5NgvQ2lY4eCYE9qw=;
        b=XN0Vs2dYL/YQHCP6EWm2BA+qqB1gpwh+XwInKa4Z7y8B5a7U2E8w1McAuyTQ+aD8Kz
         hx/BQln9JkhuUnZg0yQ0bX4P8sTFJw+lYXZpBhToacsQlE38ByvL54mzJzjY6AP6rb+I
         qos6pfWBUTAxkJiltZDWFGJuwjmrTHsgqzzN0SSUXeAsUdItfcN+uRjYg/GvbDDiuLTo
         xNa89zdVBmI/NP6aMn3LF+VFOrM6KMQkjtkcH3N6rIQyY88tGYPhzK0wh+DlfLX4xPXj
         rLR+j0opnF6rEy3daOmK9r6G+Dh/t3SZJPaWI6fs8N0GPB6HlGZY/cc3K4+KrA70wxXo
         up3A==
X-Gm-Message-State: AOAM532WUkMrQKrc2m+Sp4x08Xw4mOi31xk/r4Cj76VRDQfaF8/p/6zT
        rPiTUFSXGJqJTHgFJ4NqDJ9SqzHLmZrv4Vn0OPDKJf7/2SHtn3Sr1JSv6x5Fbag1L/XgCtqh6FZ
        W6PHkUX7/40vS
X-Received: by 2002:a62:800d:0:b029:2f0:fe27:2935 with SMTP id j13-20020a62800d0000b02902f0fe272935mr3108396pfd.15.1623900244007;
        Wed, 16 Jun 2021 20:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLsgZLhkeGRgsw9sNEy2BSQC7XLsAdd6KI8S9BIqhLUelD+ESONzXLb6Bkzo6ZqDFo4Y+zFQ==
X-Received: by 2002:a62:800d:0:b029:2f0:fe27:2935 with SMTP id j13-20020a62800d0000b02902f0fe272935mr3108370pfd.15.1623900243689;
        Wed, 16 Jun 2021 20:24:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y20sm3880550pfb.207.2021.06.16.20.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:24:03 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/15] virtio-net: support AF_XDP zc rx
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        "dust . li" <dust.li@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-14-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d036be55-6d85-f64c-21c5-926403e18ff4@redhat.com>
Date:   Thu, 17 Jun 2021 11:23:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-14-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


ÔÚ 2021/6/10 ÏÂÎç4:22, Xuan Zhuo Ð´µÀ:
> Compared to the case of xsk tx, the case of xsk zc rx is more
> complicated.
>
> When we process the buf received by vq, we may encounter ordinary
> buffers, or xsk buffers. What makes the situation more complicated is
> that in the case of mergeable, when num_buffer > 1, we may still
> encounter the case where xsk buffer is mixed with ordinary buffer.
>
> Another thing that makes the situation more complicated is that when we
> get an xsk buffer from vq, the xsk bound to this xsk buffer may have
> been unbound.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


This is somehow similar to the case of tx where we don't have per vq reset.

[...]

>   
> -	if (vi->mergeable_rx_bufs)
> +	if (is_xsk_ctx(ctx))
> +		skb = receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
> +	else if (vi->mergeable_rx_bufs)
>   		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>   					stats);
>   	else if (vi->big_packets)
> @@ -1175,6 +1296,14 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>   	int err;
>   	bool oom;
>   
> +	/* Because virtio-net does not yet support flow direct,


Note that this is not the case any more. RSS has been supported by 
virtio spec and qemu/vhost/tap now. We just need some work on the 
virtio-net driver part (e.g the ethool interface).

Thanks


