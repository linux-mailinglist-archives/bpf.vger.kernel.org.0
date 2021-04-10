Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580FC35AF91
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJS1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhDJS1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Apr 2021 14:27:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D9C06138C
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 11:27:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd23so4995941ejb.12
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kHhLeejRCafLd1b38lNlB9DRMFKc8tcaJUOcirv3Ooo=;
        b=LirYQ65VsI53h0KeKH0f834XSic/s38SLU/7BywMfLNrhws9tcg6zOhn8mpZDi4lQ7
         Ui7ZUnQX1a9r5eS7sjBSbRZ2uYMoW5O7HqUUhcVkmhBh/aEIaa/0SV33BvMFmUSxX9Rl
         bqQdH0zS2mf1vuVqUqoFqkr66P8uBX3NSmzPwubXK5qTNduMc5b5qTTqYexwEfDYZE8b
         nzUCzqtPIHKFBS9mY9HlIuBjruNelDixyPOH5QQU5oIGfs5FwxjfCSxN4wtfzXXbmCUB
         bPeJr5P7ZkOuSi2xTfPJJwT2bXofjtHW320TWP9ER7ppnpxY6lpS6AfiIwSLGyj3jm+7
         HhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHhLeejRCafLd1b38lNlB9DRMFKc8tcaJUOcirv3Ooo=;
        b=Ve85MpfgD9fzTrjbcTokLgV7Tdl/NrFUfQEFnCGjREbAMUZ+MOfh44vj5yOqZqc9+c
         invCorvIZaNjpFd/MWNk/QXcaWtULODNNB2X1iVOIjF9Pn9Mz6+l//TiDztCd6jBEU2J
         ztq5qEXi9u+uROO63w9oYsn0Z/V1b0p9YTdIALZF+iEntjOvhlMtbR00wVgxmrb4c8br
         ZwMjfdaoOnn+LZ/8g4Y797kYcIVf2nshyP6P28VHlGs51i8E/dd5Bp0gL3oGv3DDpoeQ
         TNy9kboVYiTh4qjukljPE5b6h87bmvQxStpw+NOayCcZfFIzO4Uxi9wQL3pqeIneY07l
         7qdg==
X-Gm-Message-State: AOAM531e0tQrfITak90C6qEvqeyWgqVNm2QF/00LnP5qDfZQZGH/Gr6M
        Xlt9KxE59Ylu//LwHN/0RdGqWw==
X-Google-Smtp-Source: ABdhPJx0V2aCh2XNTn2Q3nZt+vNNiODmlAlAROTAsWvAgu7uGCCaBqDifF+3nlWpkGlVcihCmauAxg==
X-Received: by 2002:a17:906:4c91:: with SMTP id q17mr21299868eju.0.1618079257332;
        Sat, 10 Apr 2021 11:27:37 -0700 (PDT)
Received: from enceladus (ppp-94-65-225-75.home.otenet.gr. [94.65.225.75])
        by smtp.gmail.com with ESMTPSA id y6sm2926830ejw.83.2021.04.10.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 11:27:36 -0700 (PDT)
Date:   Sat, 10 Apr 2021 21:27:31 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/5] mm: add a signature in struct page
Message-ID: <YHHuE7g73mZNrMV4@enceladus>
References: <20210409223801.104657-1-mcroce@linux.microsoft.com>
 <20210409223801.104657-3-mcroce@linux.microsoft.com>
 <20210410154824.GZ2531743@casper.infradead.org>
 <YHHPbQm2pn2ysth0@enceladus>
 <CALvZod7UUxTavexGCzbKaK41LAW7mkfQrnDhFbjo-KvH9P6KsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7UUxTavexGCzbKaK41LAW7mkfQrnDhFbjo-KvH9P6KsQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Shakeel, 

On Sat, Apr 10, 2021 at 10:42:30AM -0700, Shakeel Butt wrote:
> On Sat, Apr 10, 2021 at 9:16 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Matthew
> >
> > On Sat, Apr 10, 2021 at 04:48:24PM +0100, Matthew Wilcox wrote:
> > > On Sat, Apr 10, 2021 at 12:37:58AM +0200, Matteo Croce wrote:
> > > > This is needed by the page_pool to avoid recycling a page not allocated
> > > > via page_pool.
> > >
> > > Is the PageType mechanism more appropriate to your needs?  It wouldn't
> > > be if you use page->_mapcount (ie mapping it to userspace).
> >
> > Interesting!
> > Please keep in mind this was written ~2018 and was stale on my branches for
> > quite some time.  So back then I did try to use PageType, but had not free
> > bits.  Looking at it again though, it's cleaned up.  So yes I think this can
> > be much much cleaner.  Should we go and define a new PG_pagepool?
> >
> >
> 
> Can this page_pool be used for TCP RX zerocopy? If yes then PageType
> can not be used.

Yes it can, since it's going to be used as your default allocator for
payloads, which might end up on an SKB.
So we have to keep the extra added field on struct page for our mark.
Matthew had an intersting idea.  He suggested keeping it, but changing the 
magic number, so it can't be a kernel address, but I'll let him follow 
up on the details.

> 
> There is a recent discussion [1] on memcg accounting of TCP RX
> zerocopy and I am wondering if this work can somehow help in that
> regard. I will take a look at the series.
> 

I'll try having a look on this as well. The idea behind the patchset is to
allow lower speed NICs that use the API already, gain recycling 'easily'.  
Using page_pool for the driver comes with a penalty to begin with.
Allocating pages instead of SKBs has a measurable difference. By enabling them
to recycle they'll get better performance, since you skip the
reallocation/remapping and only care for syncing the buffers correctly.

> [1] https://lore.kernel.org/linux-mm/20210316013003.25271-1-arjunroy.kdev@gmail.com/
