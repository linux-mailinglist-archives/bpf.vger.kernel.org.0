Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0D5E85F0
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIWWj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIWWj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:39:26 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7212A4BE
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:39:24 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e81so1576077ybb.13
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1c2vmmG6N2A3x0SjGQwXYu822s8uOaFkaWhnvB0RyWM=;
        b=djR8fO5pQ143Xti2OlAgTbpOmBrIj6uvCNaqPK5o9giVAZ57tS/YmBjs0vtLVc6lTj
         k5Sc2C7gGc8p42Q1f91GZl9I4rsEblwLbbVFC/627CmOM4bx8gn0UnHIuZfRP6lLrLfI
         7+S0fN84EFteCI2n1j1DNejget6xigeRPvkqEBXNTi3nDZ4tvnUqEASri9+7mtG6EmBz
         mlWNqR2S5i1A5jtVGJJb36ysHcYqJKclfIDOYdZTF/esdxVKxHe7ynyBeNgoUAfi+o7k
         wSPUVdToq+BccqgLZNTTb04Ap+5kcKvBokZ4LVYGzD363lKy9Pe5jZUCjwRyVMR6kxD1
         owLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1c2vmmG6N2A3x0SjGQwXYu822s8uOaFkaWhnvB0RyWM=;
        b=k9jVFUgtDAJ9zil1QI9idzAZEZ2/Iacsb2rp0oixY5EK8HAlqzuI2gyvSPH/uqIWih
         TMNkHjtNN70sEVbbXVexYVDlHBqrEOxg2WY8gdhoYRx+cvQePINNRLe5rQvguU8zQqJR
         /8FToyfVJg4gqrvyKNvzTkpY46hUVaOcDR0pUggeO0fh6mfk0/nxYfApo44GcHuR1SVy
         GmpoDn+PTJ2vrOwjplXvFt/7RqJFm/f13s5PaazJQrxeBTsPqBBUucmClkdxaoBwgqtZ
         szHgPwuoxuHQo89GZeNmkDETJ3E/0y8jwf1vwCklpgEoKPyGZL/YnaLMBFSLyvzwBFga
         bytg==
X-Gm-Message-State: ACrzQf3/LUlQuFEaiJcKAjxNMjuDw96pqqBrxE6qfqAqzThFS5vtfcfg
        5CxuYqfHZSgDBI4hLI8oLbuGPAmv+VSXdfs8PhA=
X-Google-Smtp-Source: AMsMyM5Ux01j9VwBrQGrFtQ6YzE6UrTl+GshLn4DiWnzX/9r7RTKk5QlPDKQvVUACuv+MZ4dxt1iBaB/J0CQwymh8/Y=
X-Received: by 2002:a05:6902:2d0:b0:694:d257:4c4b with SMTP id
 w16-20020a05690202d000b00694d2574c4bmr11553145ybh.316.1663972763488; Fri, 23
 Sep 2022 15:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220923060614.4025371-1-davemarchevsky@fb.com> <CAEf4BzY9Ta5aiw6n2AHTYxENpYTAdYbVdN=ZiW8dimdM9QqbyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY9Ta5aiw6n2AHTYxENpYTAdYbVdN=ZiW8dimdM9QqbyQ@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 24 Sep 2022 00:38:47 +0200
Message-ID: <CAP01T77XsmCz0n+GoO4JX_+pq_g2jcTqT8Oboh5Zs5LT_DezEA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: Allow ringbuf memory to be used as
 map key
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Sat, 24 Sept 2022 at 00:14, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 22, 2022 at 11:06 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > This patch adds support for the following pattern:
> >
> >   struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));
> >   if (!data)
> >     return;
> >   bpf_map_lookup_elem(&another_map, &data->some_field);
> >   bpf_ringbuf_submit(data);
> >
> > Currently the verifier does not consider bpf_ringbuf_reserve's
> > PTR_TO_MEM | MEM_ALLOC ret type a valid key input to bpf_map_lookup_elem.
> > Since PTR_TO_MEM is by definition a valid region of memory, it is safe
> > to use it as a key for lookups.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> > v2->v3: lore.kernel.org/bpf/20220914123600.927632-1-davemarchevsky@fb.com
> >
> >   * Add Yonghong ack, rebase
> >
> > v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
> >
> >   * Move test changes into separate patch - patch 2 in this series.
> >     (Kumar, Yonghong). That patch's changelog enumerates specific
> >     changes from v1
> >   * Remove PTR_TO_MEM addition from this patch - patch 1 (Yonghong)
> >     * I don't have a usecase for PTR_TO_MEM w/o MEM_ALLOC
> >   * Add "if (!data)" error check to example pattern in this patch
> >     (Yonghong)
> >   * Remove patch 2 from v1's series, which removed map_key_value_types
> >     as it was more-or-less duplicate of mem_types
> >     * Now that PTR_TO_MEM isn't added here, more differences between
> >       map_key_value_types and mem_types, and no usecase for PTR_TO_BUF,
> >       so drop for now.
> >
> >  kernel/bpf/verifier.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6f6d2d511c06..97351ae3e7a7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5641,6 +5641,7 @@ static const struct bpf_reg_types map_key_value_types = {
> >                 PTR_TO_PACKET_META,
> >                 PTR_TO_MAP_KEY,
> >                 PTR_TO_MAP_VALUE,
> > +               PTR_TO_MEM | MEM_ALLOC,
>
> are there any differences between mem_types and map_key_value_types?
> If not, should we just drop map_key_value_types? mem_types also alloc
> any PTR_TO_MEM (not just ringbuf's MEM_ALLOC) and PTR_TO_BUF
> (tracepoint context structs, I think?)
>

This was discussed here:
https://lore.kernel.org/bpf/CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com

I guess we can do it, since it may already be triggered using PTR_TO_MAP_VALUE.

Based on my reading that day, it looked as if passing with offset != 0
would fail in all other cases, but I might be missing some other
corner case. I later realised that memcpy does fallback to memmove
when it detects overlap, so it wouldn't lead to any corruption, just a
warning at runtime.

> >         },
> >  };
> >
> > --
> > 2.30.2
> >
