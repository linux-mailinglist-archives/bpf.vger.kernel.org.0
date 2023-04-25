Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD66EDDB8
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjDYIM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjDYIM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 04:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696649C2
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682410334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t71HgcdOLz2lcyahjqtdGmdShpS9YMcQtrEy3utJDfI=;
        b=LfcYlBBCNzXU72aBCdvqldkn0QieedfFwE7NATIcqP2gXnw1uKSXFCdkR9KQeFX15+d48a
        1iBGWgIukZP7uL7cjY8qTE8Zb3/2N3mXQHYZ4pHZj4DUTAMfNWkKUtNN9q70DsvygQlrhX
        Q1q+JRz3mzempDO0mImKWj+oNjZSzJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-G-ExVk0nM5GhROr2iU49Xg-1; Tue, 25 Apr 2023 04:12:12 -0400
X-MC-Unique: G-ExVk0nM5GhROr2iU49Xg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f195c06507so52009145e9.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 01:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410331; x=1685002331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t71HgcdOLz2lcyahjqtdGmdShpS9YMcQtrEy3utJDfI=;
        b=kak6WZQKw5xvt7Ef+qeGVgOMo4T7z5RKsqIG+3xbEQIdhh7rqMljHVnRZFgEsksTHf
         rjE0CGOVPH4QpA7e/T8nUTkIN/pN/oi1Ne1vXWa6aKAvwfozluzDexbLih0yASaYpr8Z
         f3faxPwHLyvTbB0BgiQvAYyhw8hCbTsBLS+5vOs2m2uWZykkRmoPnBoc3ysKtI9kL1hx
         BjAduSPLrO9ZRmoHC3eUkd/hurxKkL46F30rvZ2pYhXf+KtasTiTo41F4rBWZL5MR30I
         qaD9pP+Y1MbFXhAGRR6cO50KrY6l8j0BVJTROy45GsSfCVpjLTPQwHUx2EdEfTIZClIq
         hRDw==
X-Gm-Message-State: AAQBX9eVgJ7ENKliF8ZUjjKHJXA78DtCiUXOH9tSxQcu3X+3FAp+cDQh
        xuk1hgqmIWpVhwk2y2bIVL5sk6L6m7g7GEdZFvLodtXy7LipiUSCfpHG0BOqlM2FP9YwDz2qYvu
        Dvaa7TOMqG7nV
X-Received: by 2002:a05:6000:c:b0:304:6d34:8fc9 with SMTP id h12-20020a056000000c00b003046d348fc9mr6841505wrx.2.1682410331250;
        Tue, 25 Apr 2023 01:12:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YROM05Vji85jKML5EORZKXj7LBcybOF+TFqDsboJo9RpXcWM26KHTCi4FZ8x7JjzgYf8PVYg==
X-Received: by 2002:a05:6000:c:b0:304:6d34:8fc9 with SMTP id h12-20020a056000000c00b003046d348fc9mr6841476wrx.2.1682410330931;
        Tue, 25 Apr 2023 01:12:10 -0700 (PDT)
Received: from redhat.com ([2.55.17.255])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm12594181wrx.2.2023.04.25.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 01:12:10 -0700 (PDT)
Date:   Tue, 25 Apr 2023 04:12:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <20230425035259-mutt-send-email-mst@kernel.org>
References: <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <20230419094506.2658b73f@kernel.org>
 <ZEDZaitjcX+egzvf@infradead.org>
 <1681981908.9700203-3-xuanzhuo@linux.alibaba.com>
 <ZEFlzdiyu2IAyX7a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEFlzdiyu2IAyX7a@infradead.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 09:18:21AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 20, 2023 at 05:11:48PM +0800, Xuan Zhuo wrote:
> > I know that the current design of DMA API only supports some physical hardware,
> > but can it be modified or expanded?
> 
> I think the important point is that for some cases there is no need
> to dma map at all, and upper layers should be fine by that by just
> doing the dma mapping in helpers called by the driver.
> 
> The virtio drivers then check if platform_access is set, then call the
> generic dma mapping helper, or if not just allocate memory using
> alloc_pages and also skip all the sync calls.

In theory, absolutely. In practice modern virtio devices are ok,
the reason we are stuck supporting old legacy ones is because legacy
devices are needed to run old guests. And then people turn
around and run a new guest on the same device,
for example because they switch back and forth e.g.
for data recovery? Or because whoever is selling the
host wants to opt for maximum compatibility.

Teaching all of linux to sometimes use dma and sometimes not
is a lot of work, and for limited benefit of these legacy systems.
We do it in a limited number of cases but generally
making DMA itself DTRT sounds more attractive.

So special DMA ops for these makes some sense: yes the
firmware described DMA is wrong on these boxes but
buggy firmware is not so unusual, is it?
Given virtio devices actually are on a virtual bus (the virtio bus)
sticking the fake DMA ops on this bus seems to make sense
as a way to express this quirk.

No?

-- 
MST

