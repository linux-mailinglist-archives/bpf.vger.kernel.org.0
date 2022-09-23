Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23495E8638
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIWXNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIWXNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:13:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E661E12C68A
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:13:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v2so1186187edc.7
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vQpDZ7BF1iPRlh4qDmYykHu6jmw79cegXaRSauAQe8o=;
        b=K+AMYcgYBS5dnszOMRiG5S1DLGErcg7W9rMyg+aYuLAwuob8AZQR7FkT2h9Rt+sqJ+
         OHiNkBiF1hqOQ7UjwE0i42S2nav8Eysq2J6iknI8WMVulyXlRqHLFo36EqymWgN3Lyod
         W7nZqJcx7pKahB60DNzoMraw3axTWJree1+u1Fp5Uth6EwU3JLEUuPdYX7dZW3JDhe5w
         KKwY3Y7aEgX/p5JRDOCZzkxiAKlchGytK8PudKiwyZ2oUI7yPp34JWMWKpiGMEFJGYgQ
         RnkQ8kUZ0li5BNrCAaTJPzAdXkq9+gyPbHuHohxpHQc0qGyrHYHPdH66UKgSZR9mVdFa
         15Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vQpDZ7BF1iPRlh4qDmYykHu6jmw79cegXaRSauAQe8o=;
        b=eYaWjGxNp/lCFxNnwrfhtaCbY796ogdhFxzWVPa6z28/3aXSs56rshUqh76Hha8YAI
         Lx65tn/wGty+DmNeUk1bPipcd2JjUnLtgRc405YAt3H3mUjxjJfye5uwuuFtAsGZkBsv
         RkHY4yIrCQG/wMWUaoWC2gREPQbkXC5rrOz6xxdZZdJyC+uVs3I6gmLn1joIsLpXdygC
         o3jiVgrHh2u8LYV30RcpGsTaDGtaJXJHZdsAiHTxUF7iQj3/J8UG3uKpA/VxFDZUL2l7
         kh/5cfGV3HkytFeZ1YFL/IedjIOpX62GOA7/K3S+jD7pc0jjCh7Bi2YIDdSXsmFN0lX4
         VQWg==
X-Gm-Message-State: ACrzQf1geNhl3yrQDb+rjPWjcvDa33wE1Hue58YuazedKrSAwUBq2wE6
        IsLTFF/lEZ/wfwW7ZQL+XkazrQJ2IZDQ3PrKUyk=
X-Google-Smtp-Source: AMsMyM5dxYXJX3OaaR0oSbWLWc0LITb2c5IROMih8ig3yFIIqokx8H9Cd6ER+XOW8m9mFDVlztQmCvct4vu+iT8f0Y0=
X-Received: by 2002:a05:6402:3603:b0:451:fdda:dddd with SMTP id
 el3-20020a056402360300b00451fddaddddmr10557700edb.81.1663974819480; Fri, 23
 Sep 2022 16:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220923060614.4025371-1-davemarchevsky@fb.com>
 <CAEf4BzY9Ta5aiw6n2AHTYxENpYTAdYbVdN=ZiW8dimdM9QqbyQ@mail.gmail.com> <CAP01T77XsmCz0n+GoO4JX_+pq_g2jcTqT8Oboh5Zs5LT_DezEA@mail.gmail.com>
In-Reply-To: <CAP01T77XsmCz0n+GoO4JX_+pq_g2jcTqT8Oboh5Zs5LT_DezEA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 16:13:28 -0700
Message-ID: <CAEf4BzYs+Wtm38vLvJOjxDLEqY_EptVQBfybya4w7ozRoFPX1Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: Allow ringbuf memory to be used as
 map key
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 3:39 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 24 Sept 2022 at 00:14, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 11:06 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > This patch adds support for the following pattern:
> > >
> > >   struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));
> > >   if (!data)
> > >     return;
> > >   bpf_map_lookup_elem(&another_map, &data->some_field);
> > >   bpf_ringbuf_submit(data);
> > >
> > > Currently the verifier does not consider bpf_ringbuf_reserve's
> > > PTR_TO_MEM | MEM_ALLOC ret type a valid key input to bpf_map_lookup_elem.
> > > Since PTR_TO_MEM is by definition a valid region of memory, it is safe
> > > to use it as a key for lookups.
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > ---
> > > v2->v3: lore.kernel.org/bpf/20220914123600.927632-1-davemarchevsky@fb.com
> > >
> > >   * Add Yonghong ack, rebase
> > >
> > > v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
> > >
> > >   * Move test changes into separate patch - patch 2 in this series.
> > >     (Kumar, Yonghong). That patch's changelog enumerates specific
> > >     changes from v1
> > >   * Remove PTR_TO_MEM addition from this patch - patch 1 (Yonghong)
> > >     * I don't have a usecase for PTR_TO_MEM w/o MEM_ALLOC
> > >   * Add "if (!data)" error check to example pattern in this patch
> > >     (Yonghong)
> > >   * Remove patch 2 from v1's series, which removed map_key_value_types
> > >     as it was more-or-less duplicate of mem_types
> > >     * Now that PTR_TO_MEM isn't added here, more differences between
> > >       map_key_value_types and mem_types, and no usecase for PTR_TO_BUF,
> > >       so drop for now.
> > >
> > >  kernel/bpf/verifier.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6f6d2d511c06..97351ae3e7a7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5641,6 +5641,7 @@ static const struct bpf_reg_types map_key_value_types = {
> > >                 PTR_TO_PACKET_META,
> > >                 PTR_TO_MAP_KEY,
> > >                 PTR_TO_MAP_VALUE,
> > > +               PTR_TO_MEM | MEM_ALLOC,
> >
> > are there any differences between mem_types and map_key_value_types?
> > If not, should we just drop map_key_value_types? mem_types also alloc
> > any PTR_TO_MEM (not just ringbuf's MEM_ALLOC) and PTR_TO_BUF
> > (tracepoint context structs, I think?)
> >
>
> This was discussed here:
> https://lore.kernel.org/bpf/CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com

My bad, I skipped previous revisions and didn't see this suggestion.

>
> I guess we can do it, since it may already be triggered using PTR_TO_MAP_VALUE.
>
> Based on my reading that day, it looked as if passing with offset != 0
> would fail in all other cases, but I might be missing some other
> corner case. I later realised that memcpy does fallback to memmove
> when it detects overlap, so it wouldn't lead to any corruption, just a
> warning at runtime.
>
> > >         },
> > >  };
> > >
> > > --
> > > 2.30.2
> > >
