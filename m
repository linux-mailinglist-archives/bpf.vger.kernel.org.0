Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B46ACBCD
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCFSAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 13:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFSAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 13:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792265C46
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678125510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sha45Z6kxUfGCsHlDwTHYO9Fd2D72roLvFwFgZw/FPE=;
        b=DQ92DTpVxa/8p85mI/0qv7RQF6ESJFUd/L6P0hQnFL/jRh+wZorLFEMVbtxuEkO7Uq0Xvu
        OnUGrwghFG6PFKP1hPNouv5ffa8NwCBYVZq/QNbN7ybDatz39S8nx4VgBy4QMqJU9UM6jO
        C/bN7yDBYtvQoZ+9vRDo2b1HRZI8RFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-qhdydkvCPV2e0vMPFufvqg-1; Mon, 06 Mar 2023 12:58:28 -0500
X-MC-Unique: qhdydkvCPV2e0vMPFufvqg-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so3864514wms.5
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 09:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sha45Z6kxUfGCsHlDwTHYO9Fd2D72roLvFwFgZw/FPE=;
        b=k1iKsotEDw53RzkyoGFXojCTYuJDgVA8wnmI0L/uN6P76wgRvRzRCKP0QxLp8davxL
         V05u6uQGkjUrtHNsLG0zstniEDBxVEKmCGIz+mpJy4qVPvkiUPcxsa9AchMNy0wWZOK6
         iOQIDNMXpnqPiPeYROIrRGUtWyeGsvFbm93b7L56a+Znkb6fsLpsbhirkmLQ/j9nmF/t
         HB/tpxkwDfa4rmhNPB93ghAYcGlrUG/PoyHfDjF3wQMof/DyEWqI/l64gg6oXlxwWqHU
         RUxzU96peaR3YAoSTP2YCMgqtWg2qms23T3rlfwzvAUSoiYe1XLAuP2CUjr12fiFNaVQ
         0byA==
X-Gm-Message-State: AO0yUKUPk4cjnFR5wpvDZMfFrIfm1jT5rO8qZ3mbHklo1wA9TEKc+5BW
        yrIzJK5OgnfLw4KGGiDFPrJ6LaQCKyDxaQj/SP1BohSmrukwxoxqHr0vFj0UvSE49NX75ZZNEJQ
        ADwdZRv38SCwC
X-Received: by 2002:a5d:4c4b:0:b0:2c9:3955:3948 with SMTP id n11-20020a5d4c4b000000b002c939553948mr7190641wrt.70.1678125507608;
        Mon, 06 Mar 2023 09:58:27 -0800 (PST)
X-Google-Smtp-Source: AK7set/ZqnKJ/0nA9TbgFwZk42oznbVt+r2kcV8jDYft1m0CV33kw5zk5T7j0SazRpSbiKjkf+BORw==
X-Received: by 2002:a5d:4c4b:0:b0:2c9:3955:3948 with SMTP id n11-20020a5d4c4b000000b002c939553948mr7190630wrt.70.1678125507339;
        Mon, 06 Mar 2023 09:58:27 -0800 (PST)
Received: from redhat.com ([2.52.23.160])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002ce72cff2ecsm849606wrr.72.2023.03.06.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:58:26 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:58:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
Message-ID: <20230306125742-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> If the queue of xdp xmit is not an independent queue, then when the xdp
> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> the following error.
> 
> net ens4: Unexpected TXQ (0) queue failure: -28
> 
> This patch adds a check whether sq is full in XDP Xmit.
> 
> Thanks.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

needed for stable?

> Xuan Zhuo (2):
>   virtio_net: separate the logic of checking whether sq is full
>   virtio_net: add checking sq is full inside xdp xmit
> 
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

