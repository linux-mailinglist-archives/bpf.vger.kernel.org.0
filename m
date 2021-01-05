Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837412EAAB7
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbhAEM1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 07:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728541AbhAEM0r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Jan 2021 07:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609849520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6qUNvQUkXdw/sySXAScAycZjE4SmiBEPqohhGFSYUA=;
        b=KomL4aKOosNZMAAfh26/N/URFFo9/CK6dg5QcJYKYNe/1t0yhugyD8F2JYXWFUGhUAazLT
        gQNJZir6QygeAD0AnaT1CrH5Su0GCg6wGLzAVm7/3AiBboMkofjn6jgh5JcGMBJj9l+iYA
        Bv/u6/4Pw9lOdJ+PZ4svYKLE7bDojYY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-f7-xQf7pPq6Zsbou2NBFQA-1; Tue, 05 Jan 2021 07:25:18 -0500
X-MC-Unique: f7-xQf7pPq6Zsbou2NBFQA-1
Received: by mail-wr1-f69.google.com with SMTP id e12so14736144wrp.10
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 04:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6qUNvQUkXdw/sySXAScAycZjE4SmiBEPqohhGFSYUA=;
        b=gDMu8eS6U5C16hPfeXwh2q2DNtvziwADSkZkR/AjHvviHE7HZUCTqJ6+smI6JX/Hqf
         2fLXCM/Teb8WMB/ZGf26J6xgJcMzGfpUE/b82d4W5oBQnPJ2C827sU6G6ZntC8yng+GY
         dF89hC++H88TFJjzzfCHG+IAtzQpebkTTvEBYIZ9OEV27edK0N4BShDXLgklSFUXwYP8
         buYz56EGh1uNawKtrVYhHLElabjsET4WdS4brATEFxTwfjV27PWW9iFwpvRy7DpStv1h
         L0eldhELy/6IyxrEVJSJWwLHdTgerSDxFJvBVtCq1jj6vS5GjbPwafsbE38/ORTmpTk8
         M0sg==
X-Gm-Message-State: AOAM533J43jqB9/Qy5F2h17gg52zjRfSRMF9eoEC3cxLcW5dCx3VBYuv
        C9AfUqlOpmtztAv7ZHDx/4qH0VeQFuEoy1/avgRljNcdxeE1GPgIJZ/jV1zVgNBoJjyJymH3z8f
        VAtYdkxtlnfWg
X-Received: by 2002:a7b:c052:: with SMTP id u18mr3219896wmc.139.1609849517012;
        Tue, 05 Jan 2021 04:25:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2goxvm/vsk8E0XbHSlB3QZqCWkZVDQXKjwx5I6g+NamkUIWMgQNyLV5/lPhj5fdUxvUxiqQ==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr3219882wmc.139.1609849516880;
        Tue, 05 Jan 2021 04:25:16 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
        by smtp.gmail.com with ESMTPSA id o83sm4030933wme.21.2021.01.05.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:25:16 -0800 (PST)
Date:   Tue, 5 Jan 2021 07:25:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com, Jason Wang <jasowang@redhat.com>,
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
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
Subject: Re: [PATCH netdev 0/5] virtio-net support xdp socket zero copy xmit
Message-ID: <20210105072316-mutt-send-email-mst@kernel.org>
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 05, 2021 at 05:11:38PM +0800, Xuan Zhuo wrote:
> The first patch made some adjustments to xsk.
> 
> The second patch itself can be used as an independent patch to solve the problem
> that XDP may fail to load when the number of queues is insufficient.
> 
> The third to last patch implements support for xsk in virtio-net.
> 
> A practical problem with virtio is that tx interrupts are not very reliable.
> There will always be some missing or delayed tx interrupts.

Would appreciate a bit more data on this one. Is this a host bug? Device bug?
Can we limit the work around somehow?

> So I specially added
> a point timer to solve this problem. Of course, considering performance issues,
> The timer only triggers when the ring of the network card is full.
> 
> Regarding the issue of virtio-net supporting xsk's zero copy rx, I am also
> developing it, but I found that the modification may be relatively large, so I
> consider this patch set to be separated from the code related to xsk zero copy
> rx.
> 
> Xuan Zhuo (5):
>   xsk: support get page for drv
>   virtio-net: support XDP_TX when not more queues
>   virtio-net, xsk: distinguish XDP_TX and XSK XMIT ctx
>   xsk, virtio-net: prepare for support xsk
>   virtio-net, xsk: virtio-net support xsk zero copy tx
> 
>  drivers/net/virtio_net.c    | 643 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/netdevice.h   |   1 +
>  include/net/xdp_sock_drv.h  |  10 +
>  include/net/xsk_buff_pool.h |   1 +
>  net/xdp/xsk_buff_pool.c     |  10 +-
>  5 files changed, 597 insertions(+), 68 deletions(-)
> 
> --
> 1.8.3.1

