Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77E35FCDB
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhDNUwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhDNUwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 16:52:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDAC06175F
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 13:52:11 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k73so17376347ybf.3
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMc1dVoRXovpTYQV/nXgGHQYIIUU1MZrniZIcaPAzYI=;
        b=jZ63PQvS0OSJEWxuC8eQL+mgIeY3zye5GVk1y4o1Jz5FWVvQk/PfIiL7GTYhxNoeq0
         rGznM1hJWUQXA6P+waeuHPSY/DJs03JNq0uVwSWPnPsBzxVjgnn6TMUzGdV111v1vp2Q
         /nX5IfLwP9juprGuNEOuTT07JchH9A7AGMglO6Rb+9+c7hhfVbUxRh2zz0sBnmQacfBf
         EWnX8k44LFD6bjU3kBqM3T1EuffW2JooY05UpEBA0BKMVo1IB4OZNKKbX1gUPW2isFLB
         R4bgmou+/6jqYIgPw+6DqLVgue9r1GJfCIJRUL/HusGRiJ45hR+a3JnPDjJrbBlQveOp
         CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMc1dVoRXovpTYQV/nXgGHQYIIUU1MZrniZIcaPAzYI=;
        b=gZ3wAx0YoiynLvHVZgKG/EJYElg5zXh9VwFflFFhuqDhvvL4DjcFAal/49nueU7qLB
         maj6dL0w+zvxtUwhUM7yLyYzZ86KKaHwioORGqwr61pwksZ/r/VDhPwNDkaVfFJtu/0O
         dQSjVsYmcAeP6xeZqzudk4Xt/amRfkiGDc9V+lbjMLyy9U8dij+M7mMjYkAFaTe+GPCZ
         awLxQwGgIGjCj8T3cOBMFcspWkQWPrMNebjKhyDiUTdKhXdlBUTjZ9kP/rjTZZzLX1K8
         /g9prQKmbAEKzYQCFjCSsg5Ejf+hLHr+qbLOpo4oF558TsseK1dwgK68NnAoLwJAC9KV
         D79w==
X-Gm-Message-State: AOAM531QZ+OcKnl4eMSUh7e0H/ZR4rs7nqe9qt6riXQYGz+JhCKCrspQ
        WokMIoUiKxHvpMbiNGpXpU6fBWaKUHxMrfZcY7oIVQ==
X-Google-Smtp-Source: ABdhPJyqMKv7jKazLHNQr9xfoSHuUWvXv3SH59PCH1Ndn1yE1hoJqvYOK5wZMT0jkn32p4YGeb+4ZAvFlg7cBrY5JE0=
X-Received: by 2002:a25:850b:: with SMTP id w11mr55634403ybk.518.1618433530591;
 Wed, 14 Apr 2021 13:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210409223801.104657-1-mcroce@linux.microsoft.com>
 <20210409223801.104657-3-mcroce@linux.microsoft.com> <20210410154824.GZ2531743@casper.infradead.org>
 <YHHPbQm2pn2ysth0@enceladus> <CALvZod7UUxTavexGCzbKaK41LAW7mkfQrnDhFbjo-KvH9P6KsQ@mail.gmail.com>
 <YHHuE7g73mZNrMV4@enceladus> <20210414214132.74f721dd@carbon> <CALvZod4F8kCQQcK5_3YH=7keqkgY-97g+_OLoDCN7uNJdd61xA@mail.gmail.com>
In-Reply-To: <CALvZod4F8kCQQcK5_3YH=7keqkgY-97g+_OLoDCN7uNJdd61xA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 14 Apr 2021 22:51:59 +0200
Message-ID: <CANn89i+ASy7d+ew0BrnsB5aH8BPb+kr_pazWgfaAB9939o-cmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/5] mm: add a signature in struct page
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 10:09 PM Shakeel Butt <shakeelb@google.com> wrote:

>
> I will let TCP RX zerocopy experts respond to this but from my high
> level code inspection, I didn't see page->private usage.

Indeed, we do not use page->private, since we do not own the page(s).
