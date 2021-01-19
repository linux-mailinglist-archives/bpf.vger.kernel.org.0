Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8E2FBA04
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbhASOk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 09:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389157AbhASJwN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Jan 2021 04:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611049843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDToM82xeMKamVLIGfz7Nyf28zoLDtL7EisG0SsbIaw=;
        b=K7QbPlArjNl2ZwwtJzdrcuuGro61fmNKwP0Oq25qFy4JGKI4uregH8ezCyBZomwBzVDJcB
        MNvTzThOgFmBQ+61Z1SQz8wBIgI5VoBaSP2eb87REyStN2XAQRd7JTLaPYRqswykuytd8R
        VWM6l9GCzqhaNz8rCFQu7TkE/uxBQDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-NM_fOMsXPF2uQPX6AnAObw-1; Tue, 19 Jan 2021 04:50:38 -0500
X-MC-Unique: NM_fOMsXPF2uQPX6AnAObw-1
Received: by mail-wr1-f70.google.com with SMTP id j8so391931wrx.17
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 01:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDToM82xeMKamVLIGfz7Nyf28zoLDtL7EisG0SsbIaw=;
        b=DDWQJxSEVt7lkb//LpCRpPATfP8C9OM0gKLukTw9vjSFhaXmjg2lWsYq/3jrcD2s+V
         qNjuYawm2kWu9F+DeYwmZpuwBMgz+fGk6zKbOzNBdpQHUIkFwzZm4T7kxPdE0SRV//2w
         L5Mwi1sgICMGZlrMTHD2Yjf6PpAo+CDQsrl9+0cknb9I2BPy9nhprxcNeOOaJTj/AMCB
         jRPbwP0Xc7E2v5+d2Qh5GiJHUxUDYEFP9iyiv2X0ph0uIApzAFTtzQQ+GmOt7CwStY7y
         uUT6OhnHCPQxtoDL44sbR7zlSRjOrzLZMgO3lsaeT1T5EhqzRGZKpo+dcqqVJw6BiqQy
         00iw==
X-Gm-Message-State: AOAM531BXA+wDN2xbBW8VZF5O8aP7r7IKlu9p2Zw651PjcILlvw3iiXI
        p2IWfWIFXLbZkklPv+HavP/LmSGSW9gbUpqjmufYBMazQhtRB4h0mmNZgpFMj2b4gPYU+ocghrH
        1wEKL9tvpj+tL
X-Received: by 2002:a5d:6749:: with SMTP id l9mr3480131wrw.395.1611049835236;
        Tue, 19 Jan 2021 01:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQA3wzZZMN3tnDPlscHS6t87wN39DxSkIQdglcuApSG944ZAiQro8EcY9yc+c5nyrHouGySA==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr3480112wrw.395.1611049834999;
        Tue, 19 Jan 2021 01:50:34 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id s1sm35531280wrv.97.2021.01.19.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 01:50:34 -0800 (PST)
Date:   Tue, 19 Jan 2021 04:50:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
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
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] xsk: build skb by page
Message-ID: <20210119045004-mutt-send-email-mst@kernel.org>
References: <cover.1611048724.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611048724.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 05:45:09PM +0800, Xuan Zhuo wrote:
> v2:
>     1. add priv_flags IFF_TX_SKB_NO_LINEAR instead of netdev_feature
>     2. split the patch to three:
>         a. add priv_flags IFF_TX_SKB_NO_LINEAR
>         b. virtio net add priv_flags IFF_TX_SKB_NO_LINEAR
>         c. When there is support this flag, construct skb without linear space
>     3. use ERR_PTR() and PTR_ERR() to handle the err
> 
> 
> v1 message log:
> ---------------
> 
> This patch is used to construct skb based on page to save memory copy
> overhead.
> 
> This has one problem:
> 
> We construct the skb by fill the data page as a frag into the skb. In
> this way, the linear space is empty, and the header information is also
> in the frag, not in the linear space, which is not allowed for some
> network cards. For example, Mellanox Technologies MT27710 Family
> [ConnectX-4 Lx] will get the following error message:
> 
>     mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8, qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
>     00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
>     WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
>     00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
>     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
>     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb
> 
> I also tried to use build_skb to construct skb, but because of the
> existence of skb_shinfo, it must be behind the linear space, so this
> method is not working. We can't put skb_shinfo on desc->addr, it will be
> exposed to users, this is not safe.
> 
> Finally, I added a feature NETIF_F_SKB_NO_LINEAR to identify whether the
> network card supports the header information of the packet in the frag
> and not in the linear space.
> 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%

Just making sure, are these test results with v2?

> 
> Xuan Zhuo (3):
>   net: add priv_flags for allow tx skb without linear
>   virtio-net: support IFF_TX_SKB_NO_LINEAR
>   xsk: build skb by page
> 
>  drivers/net/virtio_net.c  |   3 +-
>  include/linux/netdevice.h |   3 ++
>  net/xdp/xsk.c             | 112 ++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 99 insertions(+), 19 deletions(-)
> 
> --
> 1.8.3.1

