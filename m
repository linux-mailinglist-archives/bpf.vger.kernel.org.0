Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCE6AE5D2
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjCGQEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 11:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCGQDu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 11:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E99B2E7
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678204796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0FHpHDfgMNKIF0PugEg3oYZEslsm/Wba3C2OVAQmj8=;
        b=FMPY491LINJnLCwbzZoBO1VXKcbaV/sFyqobeFvZEuqaDgY5N5Ug5Oafga/fpZQaXapDRN
        3nBqLFzeTi2eU5b7+V+OdsTOnjiYO3Hxwr3ob/h2n64K2mcI3UF3X+dZpHbtT52n3Rrh7g
        8HXhswlD/HUuLRHt/sv9pRdshEChfFE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-8y4V3GTUPLOAIpglGlIY0Q-1; Tue, 07 Mar 2023 10:59:54 -0500
X-MC-Unique: 8y4V3GTUPLOAIpglGlIY0Q-1
Received: by mail-wr1-f70.google.com with SMTP id t19-20020a0560001a5300b002ce013276b8so2314286wry.1
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 07:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0FHpHDfgMNKIF0PugEg3oYZEslsm/Wba3C2OVAQmj8=;
        b=BpojqDtdoHY6xnEv0SPRicwC6tDenAYMJky7Vp5HmMABS8XIrrxFEN3YWlM5UqzRyV
         /hD2Qf1ie04896Y8YpvbbHlS+/7zJh4XVXUu3KEbNyV68Jh9nRac4fIGRcRKUU2LftM8
         F9gwfb9XHAiwvQ/GdnkbJZEB7qYjCgcp8gAm/jbEmAVMC2F+GcxzXfFrZyVhGuC7TYm1
         YCOrveecd/Gx6PB9TQztMV0gi8LtBeNG65Zq0PooCruno0ZhxaQmPwgR8YfLVdGeUgNO
         YM8o8ur668ieMNKm4stodfs8OyNWYJ0veuCu6siHsbkzm9DReV5NcCYb/+W3Dxl69gUx
         d4qw==
X-Gm-Message-State: AO0yUKXlHjeU6S9jCvoxvCoMF6V60k7S1m6MsSD8CoE9gTxWoygl75iS
        lH0UloSdTwyTkqQP/PUD3olPuW7T+McOYHYY81MafEMTfZBzteO/E/nai4BQC0DkQzXjtyWY5Oo
        2HN0aBaIxPcsp
X-Received: by 2002:a05:600c:4708:b0:3ea:e7e7:95d9 with SMTP id v8-20020a05600c470800b003eae7e795d9mr13611732wmo.32.1678204792805;
        Tue, 07 Mar 2023 07:59:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9ob27rJ5Fb3HgQd1GlfrWD/oV9eHzxuYT1BLvurc5s6TprDFYyhGudmqSQfuT1fPyQzYHBIQ==
X-Received: by 2002:a05:600c:4708:b0:3ea:e7e7:95d9 with SMTP id v8-20020a05600c470800b003eae7e795d9mr13611707wmo.32.1678204792450;
        Tue, 07 Mar 2023 07:59:52 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003e2052bad94sm19010162wms.33.2023.03.07.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:59:51 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:59:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
Message-ID: <20230307105848-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306125742-mutt-send-email-mst@kernel.org>
 <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
 <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 07, 2023 at 10:53:41AM +0100, Paolo Abeni wrote:
> Hi,
> On Tue, 2023-03-07 at 09:49 +0800, Xuan Zhuo wrote:
> > On Mon, 6 Mar 2023 12:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> > > > If the queue of xdp xmit is not an independent queue, then when the xdp
> > > > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > > > the following error.
> > > > 
> > > > net ens4: Unexpected TXQ (0) queue failure: -28
> > > > 
> > > > This patch adds a check whether sq is full in XDP Xmit.
> > > > 
> > > > Thanks.
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > needed for stable?
> > 
> > Yes i think.
> 
> Could you please re-post including a suitable 'Fixes' tag? That would
> address stable, too. Additionally you could rename check_sq_full() in
> patch 1, perhaps 'check_disable_sq_full()' would do.

Not that's even more confusing it sounds like it's checking that
it's checking that sq is disabled unless one looks closely.

I think check_sq_full_and_disable() is better.

> You can retain the already collected tags.
> 
> Thanks!
> 
> Paolo

