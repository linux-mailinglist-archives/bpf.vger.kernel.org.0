Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45BB6EE072
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjDYKiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjDYKiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 06:38:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEE513E
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 03:38:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so41836548a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1682419081; x=1685011081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RQbVV5oFtqD8s7pQD8RC1iJUAO1cx6YB2hV383hEmHM=;
        b=X4A8yPy4O2ZWaGepFwmkfkj1x8IgV6AClLH9YT3M08LijBuX1Wju1dKF5BSj7Y+JbW
         p7m1SeiLUhcFtnvDxUdGMc3DHlcN2LpXwQjYjgK/7HkhMRHS8gjrTn0II4P3qUDt/h7S
         TaByY7OWxSVqunYKKUmdIp55FUSn7ppwFn0ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682419081; x=1685011081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQbVV5oFtqD8s7pQD8RC1iJUAO1cx6YB2hV383hEmHM=;
        b=GTDyJp7pA0DXqbtZOgwn4Nk8OpFAU/4B72LZLJk9TYUieUaz+3xIcucjbr12B7jymi
         Aoz3FBwGtGNGgQVsP+GVFqOSFSgy9L40NB7MBzr16VVedBQoM7x+nhMu/K1o1lDqlbAR
         EvfVexIKqXy9QI5ChVuSFBv1MYlQQ4H74S0kHvFejkGTRJFmbY5+VhHp/460Jd1NP+J7
         bXQy5/vF/rgnAB5pf/cQ7ohL8zpOgnhf5QOqHEW3B1LCMEwuzSf9nA9lUw3SbkkdtWYf
         PhqJNjmW8WcR4c+DIxoV6YLF/Vhikqek7e1AKUz3MkCRMjj2ufaKuli1L493zYKWmWeL
         HQIA==
X-Gm-Message-State: AAQBX9eDJdc09M3gAugF0wBtsXFOWN8Es5ApCOLJKvhV4V+t2JicPAbX
        H/9J3qEepjXbf6u7s+cigHcDXaqnfYCvkqXGQbwbTA==
X-Google-Smtp-Source: AKy350aPsjzcRn4vSkaG2WH8TE6JDcGXVHn8SZwlybVEftI+43TQ5g6f833EvwiDoqOVYfFfbZUAma51h4+L+P//bUM=
X-Received: by 2002:a17:906:9399:b0:94e:ec0f:5f70 with SMTP id
 l25-20020a170906939900b0094eec0f5f70mr12147954ejx.10.1682419080863; Tue, 25
 Apr 2023 03:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230423075335.92597-1-kal.conley@dectris.com>
 <6446d34f9568_338f220872@john.notmuch> <CAHApi-=Vr4VARgoDNB1T906gfDNB5L5_U24zE=ZHQi+qd__e8w@mail.gmail.com>
 <ZEej6ZJVAgzRueyA@boxer>
In-Reply-To: <ZEej6ZJVAgzRueyA@boxer>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Tue, 25 Apr 2023 12:37:49 +0200
Message-ID: <CAHApi-mt18_RZeikzK-LXjybdc9Y2ZzPcWHmHQEREC-BKcb+8g@mail.gmail.com>
Subject: Re: [PATCH] xsk: Use pool->dma_pages to check for DMA
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
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

> Okay, 2-3% but with what settings? rxdrop for unaligned mode? what chunk
> size etc? We need this kind of info, "compiles to more efficient code"
> from original commit message is too generic and speculative to me. 2-3% of
> perf diff against specific xdpsock setup is real improvement and is a
> strong argument for getting this patch as-is, by its own.

I don't have the exact numbers anymore. I measured a performance
difference (up to 2-3%) with different settings including rxdrop and
unaligned mode. The exact settings you have in the commit message from
the linked patch. I didn't go into details in the commit message
because I thought this change would be a slam dunk. I don't think
there is any reason to believe the code is slower with this patch. If
anything, it should generally be faster. At the very least it will
lead to more efficient code in terms of size since dma_pages_cnt is no
longer read. Also I think the code is more readable with this patch.

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
>
> John was referring to xp_dma_unmap() with the comment above which indeed
> is a teardown path, so probably this doesn't matter from performance
> perspective and you could avoid this chunk from your patch.

The setup/tear-down lines were also changed to keep the code
consistent. It doesn't make sense to sometimes check dma_pages_cnt and
other times dma_pages.

>
> >
> > > Both the _alloc_ cases read neighboring free_heads_cnt so your saving a load I guess?
> > > This is so deep into micro-optimizing I'm curious if you could measure it?
> >
> > It is saving a load which also reduces code size. This will affect
> > other decisions such as what to inline. Also in the linked patchset,
> > dma_pages and dma_pages_cnt do not share a cache line (on x86_64).
>
> Yes I believe that the with your patch on unaligned mode by touching the
> dma_pages you're warming the relevant cache line for your setup.

dma_pages is touched anyway right after. That is the point of this
patch: since dma_pages already needs to be loaded into a register,
just check that instead of loading an additional field possibly from a
different cache line.
