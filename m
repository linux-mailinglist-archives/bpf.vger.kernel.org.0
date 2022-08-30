Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685F5A5860
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH3AUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiH3AUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:20:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A858B44
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:20:38 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z72so7988254iof.12
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WkMQApNhh87EUsYFwEOeqG9PqVj2EafdiQr4cnDB/hM=;
        b=iI9OIvA5UFP0KlZczanJbU7T/X7BkpzlD92iv0zIMRHzqEkDfpj/ndnyJzV1fs8GxH
         w7MYk/zbtPl/I91B8QxBSVz277CBa8p7ULBeoy/bM8UMzYrCODyAUhDe83D6N8w/zKUi
         Vyfb74s3SMXVwGcJ6iq6unuNmmOaaToOxitD86S0y0Et2TNeGIr23HMwkp64gt4vp0J0
         cipXfafrT7ADnFEiqDzQG+vN1s0FL2BFB7KIkNfmM+Jlrv8gdWcR8X/dPwoVtRXCCQ9Z
         iqayhSprVdlXywduQCux6S9aLquCBV7ZWnfaialB9eWLAfogqDMvPZJHqPe0c0g/fl8e
         O+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WkMQApNhh87EUsYFwEOeqG9PqVj2EafdiQr4cnDB/hM=;
        b=WIZZMtInUt19QFfX3CEtkITNbhMACOJiT6gsSkSDrbNduwjVZOfK1aAi/g7YWDNeoR
         3/oCZE+QznHMvCLpsS9RySsN/e0zGbcbiYRbkS1eix331HsYa4MTjRd1SB7Y4wIR7V8L
         1E8O+3hIwcAWtmL/7DrqJSTN5yHHY7+kNejrVZuJdn93hYQyFsXee0LfVA8iDSGQ4Xzu
         apPLybGAexK2yzVHAazn6hbX4lLDOVkal8Tv4JBXWBO816jeUCKagvhtOtP7l3vYJk3z
         2JGxA9WNgzHrwygKUwDFVjtWOHmJCZqbEAyUoNSAqCRCBBNDTxR0tQ2AdWLjR00vSD3n
         Z/yA==
X-Gm-Message-State: ACgBeo0dBCo28Rg8tDJVsL8lWGqaTHKIpQZQmTZg0HYLvBTIIbo5ZkSY
        NDROhFowG4sV1rSy/QyC6WU3eFF8bJ4EkluKA2L0I/fX
X-Google-Smtp-Source: AA6agR4nYNFLGGhBKYM/XiqfEjy8d8qKpm7UVyQAxJ3KPFpM0vEAz3vXR2vqjFI1zQoLJ+3rLVkY4+fr77Y8E5mVLTA=
X-Received: by 2002:a6b:2ac4:0:b0:688:3a14:2002 with SMTP id
 q187-20020a6b2ac4000000b006883a142002mr9550458ioq.62.1661818838118; Mon, 29
 Aug 2022 17:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
In-Reply-To: <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 02:20:00 +0200
Message-ID: <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, 30 Aug 2022 at 01:45, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
> >
> > >
> > > It is not very precise, but until those maps are gone it delays
> > > release of the allocator (we can empty all percpu caches to save
> > > memory once bpf_map pinning the allocator is gone, because allocations
> > > are not going to be served). But it allows unit_free to be relatively
> > > less costly as long as those 'candidate' maps are around.
> >
> > Yes, we considered this but it's much easier to get to pathological behaviors, by
> > just loading and unloading programs that can access an allocator in a loop. The
> > freelists being empty help but it's still quite easy to hold a lot of memory for
> > nothing.
> >
> > The pointer walk was proposed to prune most such pathological cases while still being
> > conservative enough to be easy to implement. Only races with the pointer walk can
> > extend the lifetime unnecessarily.
>
> I'm getting lost in this thread.
>
> Here is my understanding so far:
> We don't free kernel kptrs from map in release_uref,
> but we should for local kptrs, since such objs are
> not much different from timers.
> So release_uref will xchg all such kptrs and free them
> into the allocator without touching allocator's refcnt.
> So there is no concurrency issue that Kumar was concerned about.

Haven't really thought through whether this will fix the concurrent
kptr swap problem, but then with this I think you need:
- New helper bpf_local_kptr_xchg(map, map_value, kptr)
- Associating map_uid of map, map_value
- Always doing atomic_inc_not_zero(map->usercnt) for each call to
local_kptr_xchg
1 and 2 because of inner_maps, 3 because of release_uref.
But maybe not a deal breaker?

> We might need two arrays though.
> prog->used_allocators[] and map->used_allocators[]
> The verifier would populate both at load time.
> At prog unload dec refcnt in one array.
> At map free dec refcnt in the other array.
> Map-in-map insert/delete of new map would copy allocators[] from
> outer map.
> As the general suggestion to solve this problem I think
> we really need to avoid run-time refcnt changes at alloc/free
> even when they're per-cpu 'fast'.
