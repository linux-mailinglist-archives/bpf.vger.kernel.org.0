Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03476D5D79
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjDDK3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjDDK3V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 06:29:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40451989
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 03:29:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so128617408edo.2
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680604157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xvJX6OzPdeaHy4wK20GTpy5l0iHRjfHg5mh9C9oOE9I=;
        b=CYSIsWBn//M7f3AfOaLBKAAVFwHdJdeDxosOvMmzf+rLEcevbsRhd6IBKmavR4y5sY
         mVmwTCCXIjQxhv6ZKvye1nBMzydoRuddfwo0Ms2bYnFWvHNpdnPcDZJ1XpPy7ECl6qsP
         33NgH5Vx+dOoZd0nn2EZ4hA4sQ6aibceWOcX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvJX6OzPdeaHy4wK20GTpy5l0iHRjfHg5mh9C9oOE9I=;
        b=lUagmdhNasPoA95Xtlbb3GzACyXj2xPb66o7x2yUfsH+qMAVXQ0jv/SJAGD5IjZLB4
         Tvj3sDhw/MhHtDp3GfPwIwkvOrBYZdlHzozHSRfZoHicjQZLhmz6wzotmUADuEIa04Nv
         TMNijq0A1AbeD1tLXR3Ztm0mrGFvKbbwN0ryVHbwomqTs0zJfB+aNKqTHF+7zEz75izj
         ZUY+pQ9wSBDkCdMkX6HcEYB+7Sp4+kPXyda3lczBIAKMIaJE8VqBerLh3dLwox+gJLst
         AQce5xfdBl3XpPJb6BfRWqT4sQhWrLYE7sKJszmosz/X89B1hCzFYsZp5CDgG2VVNNYI
         /c2A==
X-Gm-Message-State: AAQBX9dw50T+DRF8Z9fRinraU7UEu4PkWwaOYT27KGM3Jo2EJ1wcynIV
        DLo1gAIfts8H1hx6ZzNZ7q2AiytaavwxqnKvp0K30g==
X-Google-Smtp-Source: AKy350ZcLXYZc/9zeTneMYSnKAyOHqt2QCJEcTpbmgqL8+BLXHbuJ2Z2YsyyleJ800gVKUEllBi0iQnxGPNoPt/YsHY=
X-Received: by 2002:a50:9ec2:0:b0:502:7551:86c7 with SMTP id
 a60-20020a509ec2000000b00502755186c7mr1105970edf.4.1680604157350; Tue, 04 Apr
 2023 03:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-9-kal.conley@dectris.com> <CAJ8uoz330DWzHabpqd+HaeAxBi2gr+GOTtnS9WJFWrt=6DaeWQ@mail.gmail.com>
 <CAHApi-nfBM=i1WeZ-jtHN87AWPvURo0LygT9yYxF=cUeYthXBQ@mail.gmail.com> <CAJ8uoz0SEkcXQuoqYd94GreJqpCxQuf1QVgm9=Um6Wqk=s8GBw@mail.gmail.com>
In-Reply-To: <CAJ8uoz0SEkcXQuoqYd94GreJqpCxQuf1QVgm9=Um6Wqk=s8GBw@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Tue, 4 Apr 2023 12:33:58 +0200
Message-ID: <CAHApi-=ui3JofMr7y+LvuYkXCU=h7vGiKXsfuV5gog-02u-u+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/10] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > > Is not the max 64K as you test against XDP_UMEM_MAX_CHUNK_SIZE in
> > > xdp_umem_reg()?
> >
> > The absolute max is 64K. In the case of HPAGE_SIZE < 64K, then it
> > would be HPAGE_SIZE.
>
> Is there such a case when HPAGE_SIZE would be less than 64K? If not,
> then just write 64K.

Yes. While most platforms have HPAGE_SIZE defined to a compile-time
constant >= 64K (very often 2M) there are platforms (at least ia64 and
powerpc) where the hugepage size is configured at boot. Specifically,
in the case of Itanium (ia64), the hugepage size may be configured at
boot to any valid page size > PAGE_SIZE (e.g. 8K). See:
https://elixir.bootlin.com/linux/latest/source/arch/ia64/mm/hugetlbpage.c#L159

>
> > > >  static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
> > > >  {
> > > > +#ifdef CONFIG_HUGETLB_PAGE
> > >
> > > Let us try to get rid of most of these #ifdefs sprinkled around the
> > > code. How about hiding this inside xdp_umem_is_hugetlb() and get rid
> > > of these #ifdefs below? Since I believe it is quite uncommon not to
> > > have this config enabled, we could simplify things by always using the
> > > page_size in the pool, for example. And dito for the one in struct
> > > xdp_umem. What do you think?
> >
> > I used #ifdef for `page_size` in the pool for maximum performance when
> > huge pages are disabled. We could also not worry about optimizing this
> > uncommon case though since the performance impact is very small.
> > However, I don't find the #ifdefs excessive either.
>
> Keep them to a minimum please since there are few of them in the
> current code outside of some header files. And let us assume that
> CONFIG_HUGETLB_PAGE is the common case.
>

Would you be OK if I just remove the ones from xsk_buff_pool? I think
the code in xdp_umem.c is quite readable and the #ifdefs are really
only used in xdp_umem_pin_pages.
