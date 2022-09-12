Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BB5B5C4D
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiILOfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiILOfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 10:35:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93892ED5F
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 07:35:35 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y15so4627112ilq.4
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZRKuEBMaA1eSSajEaEOT7ahuAxdrA86F8kz2Fv7A4bA=;
        b=mSnuZ4i5VyRCI4Pop2EXzUaTdQbRik8VBCo15o4Cor8jdisxSOHIZMR0gKRWfsOA4u
         swWz8LAvUzMdmnqOXngVwCtm+mm26Go9DlbAI2bNdvmoTbPTzApuuvF6q66rOJFJbWh9
         ashiCPYOlSOUpNcEa+bmGrC/AUrGwx/fZxU2G9yg4L/JP1WRJ0f666QxWQ2dSWYhmirX
         k1RJoFulZ4z6O2f3jndBAIhcpn7bbE7g9N0mTHCCNtB+qpD2h0XWKnWhfHRfun4+0xw1
         EFgEkYCtu9MFJZCHa96DJFo+OvCZzP5PocSOAOQ04RZKkHJCPd4k9pX352xLiSN1gWW6
         l1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZRKuEBMaA1eSSajEaEOT7ahuAxdrA86F8kz2Fv7A4bA=;
        b=iZbATlqkJzG3wE3QhKJz2HjqPXzi9MxISYOOQVKMsL4dIBfBq3yuyC2arYr2Um3D+p
         Xz+5/t4inSW6Doi9ubJZasPsnq//J/iignIxkIbSPVi4HIvzJVJYnfV+lyj5iIlvWho1
         yMEbrYMjAAdX1jsc6EbWDvTEq/EM6nPI04Y13S2XSvHGV2GtSVNshsjGUTareXjW9PI1
         7AZ/yIUzI0OhQQBrVuvQsubH3EZ8hkiUO4COCkNhtUhJIEQYwpzzfZlnrvb9xXfOE0x0
         ugwb3EUo8+yRzxKAIr4H4kr1MVzjvO1KFXCb7ZvhgOb7eqy9rswzxmxYDbcF+ouoJP/7
         6BQQ==
X-Gm-Message-State: ACgBeo3tLspz7hvZthXzvJXMM2D9I0G/GafHVcCSkN0ee/sbSkfPBcKq
        tCQmnmxxuyOyIAViRbbT/0JSoywd5+Q0uSGn0Ik=
X-Google-Smtp-Source: AA6agR6mJkEwGaPlciNC1Ls2y6BDD6FHbPpsnamiU8CLBhIQYXUsO8EZ33vt9QdhCPUeKvKjK6qIs8WjWYpkiQSUC+U=
X-Received: by 2002:a92:cbcf:0:b0:2f3:b515:92d with SMTP id
 s15-20020a92cbcf000000b002f3b515092dmr4249687ilq.91.1662993334646; Mon, 12
 Sep 2022 07:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220912101106.2765921-1-davemarchevsky@fb.com>
 <20220912101106.2765921-2-davemarchevsky@fb.com> <CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com>
In-Reply-To: <CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 12 Sep 2022 16:34:55 +0200
Message-ID: <CAP01T75Ldqze_sgiDCpvwLN262pEDRJpM2zs46FBW68yxiVBTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Consider all mem_types compatible for
 map_{key,value} args
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 12 Sept 2022 at 16:34, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 12 Sept 2022 at 12:24, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > After the previous patch, which added PTR_TO_MEM types to
> > map_key_value_types, the only difference between map_key_value_types and
> > mem_types sets is PTR_TO_BUF, which is in the latter set but not the
> > former.
> >
> > Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
> > already effectively expect a valid blob of arbitrary memory that isn't
> > necessarily explicitly associated with a map. When validating a
> > PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
> > already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
> > logic like that in process_timer_func or process_kptr_func.
> >
> > So let's get rid of map_key_value_types and just use mem_types for those
> > args.
> >
> > This has the effect of adding PTR_TO_BUF to the set of compatible types
> > for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
>
> I'm wondering how it is safe when PTR_TO_BUF aliases map_value we are updating.
>
> User can now do e.g. in array map:
> map_iter(ctx)
>   bpf_map_update_elem(map, ctx->key, ctx->value, 0);
>
> Technically such overlapping memcpy is UB.

Hit send too early.
To be fair they can already do this using PTR_TO_MAP_VALUE, so it's
not a new problem.

>
> Looks like for this particular case, overlap will always be exact.
> Such aliasing pointers always have fixed size memory.
> If offset was added for partial overlap, it would not satisfy
> value_size requirement and users won't be able to pass the pointer.
> dynptr_from_mem may be a problem, but even there you need to obtain a
> data slice of at least value_size, if an offset is added
> slice will always be < value_size.
>
> So it seems we only need to care about dst == src, and should be using
> memmove when dst == src?
>
> PS: Also it would be better to split verifier and selftest changes in
> patch 1 into separate patches.
