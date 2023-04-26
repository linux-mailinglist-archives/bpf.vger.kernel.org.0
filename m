Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703766EF4C6
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 14:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjDZM5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDZM5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 08:57:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B62684
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 05:57:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so12250363a12.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1682513847; x=1685105847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1QsbQyF3TR/hoFInEXmDClrMvJnRmuE6Ofnl/uFp38=;
        b=JmiY6YfBuybCRpi0/YDE8hX7+l6vTaPtTJ79KCJCouinYq1bCpGXoFcc26Bo/pDCfy
         o4Nn4EiaaS5OOUNhKEbnkQxC3OhyMnr1F/Po4sE+yRvRLT49zfFp0dLSd5DlRpwblCL+
         uto0euo/3QfNZtfjgrpwBJWVIkme+wT+ak18Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682513847; x=1685105847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1QsbQyF3TR/hoFInEXmDClrMvJnRmuE6Ofnl/uFp38=;
        b=KMDaiinZgWxlHdu/p1dKDLD/jGGX/tD/lQ75FnEX/d8ziLjPeMA6AMgodLmZu1THE7
         QKhEtmZByEu/oo7Pc58FYXCSwETRXZ/4OOD2TTxS8OPogBV/XtL6V5HU3mkaL22fTApn
         K24xb3q5+MuxPMcSmTuARVrBU+HDGr5WU3HkIi6BCoyTWz7O1lwwfZ25xWENMSwAbfMW
         yKekNEkb6RTKm+oXiNDMA2L9Q43SEu5HHieWCyY5AVT3pnD71+kKtSPpOcaFqtDHH8bY
         F5Tm3c2vbLNGryBfiKAv+Qpzf189jo3yPryz3srJu3yra06Djf6ZPZrN/r3hwS8GJVPa
         Y3gA==
X-Gm-Message-State: AAQBX9c8dRbQt8O17pQ3u1Q7EVA/ql5sIKZ9IFs5O08oAC/EvTLgyiEb
        lFXvqjq/VydmFTm01JN9syfpqkFMgrHxR1XmamN2jw==
X-Google-Smtp-Source: AKy350ZGTmt/6Xm8J8Z+YJRO5ZAF5Cg9M4AsqmY4MImaN2aS8xw7FbSFm0eUoRt/8GYZH6ApMntLSdSXB3B6vwQeM54=
X-Received: by 2002:aa7:c74e:0:b0:502:1cae:8b11 with SMTP id
 c14-20020aa7c74e000000b005021cae8b11mr19006448eds.23.1682513847171; Wed, 26
 Apr 2023 05:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230423075335.92597-1-kal.conley@dectris.com>
 <6446d34f9568_338f220872@john.notmuch> <CAHApi-=Vr4VARgoDNB1T906gfDNB5L5_U24zE=ZHQi+qd__e8w@mail.gmail.com>
 <644837cec75d1_8f94b20880@john.notmuch>
In-Reply-To: <644837cec75d1_8f94b20880@john.notmuch>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 26 Apr 2023 15:02:17 +0200
Message-ID: <CAHApi-kzaJxQTRgZqYmMSWYa6CW6b0U6x9Sdpk_Kt=fd2hPCjA@mail.gmail.com>
Subject: Re: [PATCH] xsk: Use pool->dma_pages to check for DMA
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > > Was it noticable in some sort of performance test?
> >
> > This patch is part of the patchset found at
> > https://lore.kernel.org/all/20230412162114.19389-3-kal.conley@dectris.com/
> > which is being actively discussed and needs to be resubmitted anyway
> > because of a conflict. While the discussion continues, I am submitting
> > this patch by itself because I think it's an improvement on its own
> > (regardless of what happens with the rest of the linked patchset). On
> > one system, I measured a performance regression of 2-3% with xdpsock
> > and the linked changes without the current patch. With the current
> > patch, the performance regression was no longer observed.
>
> Would be nice to have in commit message so reader has an idea the
> perf numbers are in fact better.

When I measured this patch by itself (on bpf-next), I didn't measure
any statistically significant performance gains. However, it did allow
me to avoid a regression when combined with the other linked patch (as
mentioned). I don't know if it makes sense to mention that other
change which is not even applied to any tree. I was mainly submitting
this patch from the perspective of the code being better not
contingent on any provable performance gains.

>
> >
> > > > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > > > index d318c769b445..a8d7b8a3688a 100644
> > > > --- a/include/net/xsk_buff_pool.h
> > > > +++ b/include/net/xsk_buff_pool.h
> > > > @@ -180,7 +180,7 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
> > > >       if (likely(!cross_pg))
> > > >               return false;
> > > >
> > > > -     return pool->dma_pages_cnt &&
> > > > +     return pool->dma_pages &&
> > > >              !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
> > > >  }
> >
> > I would consider the above code part of the "fast path". It may be
> > executed approximately once per frame in unaligned mode.
>
> In the unlikely case though is my reading. So really shouldn't
> be called for every packet or we have other perf issues by that
> likely() there.
>
> I assume the above is where the perf is being gained because below
> two things are in setup/tear down. But then we are benchmarking
> an unlikely() path?

I was testing with large chunk sizes in unaligned mode (4000-4096
bytes) with ZC. For chunk sizes nearly as large as PAGE_SIZE the
unlikely path is actually the main path.

> >
> > > This seems to be used in the setup/tear-down paths so your optimizing
> > > a control side. Is there a fast path with this code? I walked the
> > > ice driver. If its just setup code we should do whatever is more
> > > readable.
> >
> > It is not only used in setup/tear-down paths (see above).
> > Additionally, I believe the code is also _more_ readable with this
> > patch applied. In particular, this patch reduces cognitive complexity
> > since people (and compilers) reading the code don't need to
> > additionally think about pool->dma_pages_cnt.
> >
> > > Both the _alloc_ cases read neighboring free_heads_cnt so your saving a load I guess?
> > > This is so deep into micro-optimizing I'm curious if you could measure it?
> >
> > It is saving a load which also reduces code size. This will affect
> > other decisions such as what to inline. Also in the linked patchset,
> > dma_pages and dma_pages_cnt do not share a cache line (on x86_64).
>
> But again buried in an unlikely path. Sure but removing the conditional
> altogether would be even better.

Yeah, I think that is another improvement to consider.

> So my understanding is ZC is preferred and default mode and copy modes
> are primarily fall back modes. So we are punishing the good case here
> for a fallback to copy mode. I think overall refactoring the code to
> avoid burdoning the fast case with a fallback slow case would be ideal
> solution.

I agree that ZC is preferred and this patch is aimed at improving the
ZC path. The performance gain I observed was for ZC.

> However, I agree just on readability the patch is fine and good. No
> objection on my side. But I think if we are making performance
> arguments for 2-3% here the better thing to do is remove the check
> and unlikely() and we would see better benchmarks when using the
> ZC mode which as I understand it is what performance aware folks should
> be doing.

I totally agree that other better improvements exist but I don't think
they make this patch any less desirable. This change is only meant as
a small incremental improvement.
