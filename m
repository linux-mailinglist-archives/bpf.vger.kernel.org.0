Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308385A5A17
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH3DfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 23:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH3DfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 23:35:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6A175A0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 20:35:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og21so19562426ejc.2
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9l5IoAtyZkYGoi7ICtP946tH2Tlhnr6kxoIAdQAPzDo=;
        b=B0CevJ8c0mrrKnL3BDNKZtS7f3/Ov+63YOD/vHdUlZcDOJkP/HFwU888GzSfrRemyT
         Xed84SrxoFyP30Arr8HeSLnmSa2DG7wq1L3ucBnYFPMKnksfSllebETMpntlieC0haBa
         dXhE0+IEAB9gRBAOi5Lfd/4C8mvZp5I4cxVmnNmc0hIhOhSynvig/f7Od3jyMv/zlAvO
         r433pVSI7jjggMNZC+BzQZzn5e7JI8AtlGK7XICOSrT8OSrpdI2wOaGpZONnv2Gp597l
         7J6OsQCZR7oL8LBBuYc0/q0I6IjCY361iIeOo3SGy6PkgMvvx5U/1yqTSDIfp06nTXSD
         ddqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9l5IoAtyZkYGoi7ICtP946tH2Tlhnr6kxoIAdQAPzDo=;
        b=vNZ8GODtLOz2S+9saPEWxqWQFJrB+FaqmW2NQ/bFlHQeRrtJVYPeRGZ/80g1Nw8YoQ
         hlesndbG8PR72KafLid4sQmhvw3ikU5N4eX8wSCLPikRmwml7Krns4Zj08U6FxNfns5f
         zq9z1v0VuXVeDue7YpDoBSKNW96DgNbC+o6VX2u1tfAOnKcKCBNy9+O54bXrH5rCQbHk
         cQgHrtXxhWMM5ZAc4OdWkgpYbcnyElBLblVbzRI+xyy5EQzniXaTMkoujcpM2NMJ3FAm
         HA4ApvL2O1Yxxu0yYv/PeQ0aIsZrldzS2tE5Ypjw2wzFrHc4lq1vxYz9YqcT9BOyzpG8
         5cRw==
X-Gm-Message-State: ACgBeo2BfA9I9bCbyuyQVWEJ4uu+guZyky368rrnSzepy+9HU9ZIV/Y7
        r1ALor3f9vnvCfI4edsqZfF4wyeWWH9lcGhiuns=
X-Google-Smtp-Source: AA6agR4b7+JghMLEKuDU7xn0stIqF70L6FHHNvGz+Na5uAj0zIv8NlyPqrZXRy2WxE981ABFl6xxuhcTL2otC84my+8=
X-Received: by 2002:a17:906:ef90:b0:730:9cd8:56d7 with SMTP id
 ze16-20020a170906ef9000b007309cd856d7mr14765349ejb.94.1661830502453; Mon, 29
 Aug 2022 20:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
 <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com> <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
In-Reply-To: <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 20:34:51 -0700
Message-ID: <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "memxor@gmail.com" <memxor@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
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

On Mon, Aug 29, 2022 at 6:40 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Yes, if we populate used_allocators on load and copy them to inner maps, this might
> work. It requires the most conservative approach where loading and unloading a
> program in a loop would add its allocators to the visible pinned maps, accumulating
> allocators we can't release until the map is gone.
>
> However, I thought you wanted to walk the values instead to prevent this abuse. At
> least that's the understanding I was operating under.
>
> If a program has the max number of possible allocators and we just load/unload it in
> a loop, with a visible pinned map, the used_allocators list of that map can easily
> skyrocket.

Right. That will be an issue if we don't trim the list
at prog unload.

> > Sorry I confused myself and others with release_uref.
> > I meant map_poke_untrack-like call.
> > When we drop refs from used maps in __bpf_free_used_maps
> > we walk all elements.
> > Similar idea here.
> > When prog is unloaded it cleans up all objects it allocated
> > and stored into maps before dropping refcnt-s
> > in prog->used_allocators.
>
> For an allocator that's visible from multiple programs (say, it's in a map-of-maps),
> how would we know which values were allocated by which program? Do we forbid shared
> allocators outright?

Hopefully we don't need to forbid shared allocators and
allow map-in-map to contain kptr local.

> Separately, I think I just won't allow allocators as inner maps, that's for another
> day too (though it may work just fine).
>
> Perfect, enemy of the good, something-something.

Right, but if we can allow that with something simple
it would be nice.

After a lot of head scratching realized that
walk-all-elems-and-kptr_xchg approach doesn't work,
because prog_A and prog_B might share a map and when
prog_A is unloaded and trying to do kptr_xchg on all elems
the prog_B might kptr_xchg as well and walk_all loop
will miss kptrs.
prog->used_allocators[] approach is broken too.
Since the prog_B (in the example above) might see
objects that were allocated from prog_A's allocators.
prog->used_allocators at load time is incorrect.

To prevent all of these issues how about we
restrict kptr local to contain a pointer only
from one allocator.
When parsing map's BTF if there is only one kptr local
in the map value the equivalent of map->used_allocators[]
will guarantee to contain only one allocator.
Two kptr locals in the map value -> potentially two allocators.

So here is new proposal:

At load time the verifier walks all kptr_xchg(map_value, obj)
and adds obj's allocator to
map->used_allocators <- {kptr_offset, allocator};
If kptr_offset already exists -> failure to load.
Allocator can probably be a part of struct bpf_map_value_off_desc.

In other words the pairs of {kptr_offset, allocator}
say 'there could be an object from that allocator in
that kptr in some map values'.

Do nothing at prog unload.

At map free time walk all elements and free kptrs.
Finally drop allocator refcnts.

This approach allows sharing of allocators.
kptr local in map-in-map also should be fine.
If not we have a problem with bpf_map_value_off_desc
and map-in-map then.

The prog doesn't need to have a special used_allocator list,
since if bpf prog doesn't do kptr_xchg all allocated
objects will be freed during prog execution.
Instead since allocator is a different type of map it
should go into existing used_maps[] to make sure
we don't free allocator when prog is executing.

Maybe with this approach we won't even need to
hide the allocator pointer into the first 8 bytes.
For all pointers returned from kptr_xchg the verifier
will know which allocator is supposed to be used for freeing.

Thoughts?
