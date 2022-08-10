Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304C158F422
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 00:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiHJWGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiHJWGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 18:06:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC8C792D7
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 15:06:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w3so20874639edc.2
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nl/21CfRvndxR4j75F2fp9zb1VQlnuzsxGv/rT+SBt8=;
        b=RQsC0E6K/2IlbzMBVEtCQyx/KDSaTgMHmXDP+xfkXosBOpWvjSmAeB9ec49JRfCM2W
         /mkt1GplgaOv6LFukhXnFyVO4eH4LPS9FeQT+xSg99Kk/sGa/hGQsKcDNasSiThePueM
         gpcXbfFYcQT1SDMvrAoWiFvL3MaOhIo+HP7X5REkUGKIO9olUXUSaz9gDj7q1y+nEvKU
         bXmTXuNViwNypAPh+nnGiG4tVvQc6hTEc1s5gYApqNXhHhfVQHQAqL47WaxY3UvWarwi
         iY7Aoo1YlnWRm/xk9VYLjnsEJbSxRl3s2L10MWOKf8Ymb17WWJ+aK9nQrS+T7qJVW0Dw
         Bh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nl/21CfRvndxR4j75F2fp9zb1VQlnuzsxGv/rT+SBt8=;
        b=BoRSybaMj1hFa7AuWHziJtgyz5rwoXH3dAo48jfpBRiR3zAMzrEc4TZ0mlLIi/WsMM
         xnVeQWfZJ0jb4oWDDJ3/0WPJnek+E0/JgiVNLcbE2ohPNtMYn8mLOGtygTc8bmGoNoot
         TQjMl45xBOcTgBJ64kS/2IpufRXsasbXVVRrAIaTbmJm5sEblA/4ArsM/rz77M/VO5/O
         UI0xDxo5k/moZRtSLvsAft9rVtToEUS0A19tSdOdBimDNgwtOkkh9IIkpYCyjfo5JT1O
         3g1lf98NVzrbUAzlHJ636zxJKL/3/4IZ0eUcgHDwIzEotu5gpFSutOTUamTG2SJkR4xW
         frlQ==
X-Gm-Message-State: ACgBeo2QNJbHnPyl9aGm5K5qe0hrAwzhl6ZTcI6kRE0Ms9Btwxq++R3g
        lWmH3EMieg8jxinfqAjCJwCUEJNJ9TLR0ApRpe4=
X-Google-Smtp-Source: AA6agR7CN+57deNXSOt79LX8TBeAoB8/JRAHs978wBxEmqRsQNP8Dh10KNIwX/roG4NRRSxE4aDoLu0SMbjdfxs4Iac=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr28817152edb.333.1660169186794; Wed, 10
 Aug 2022 15:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com> <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
 <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com>
In-Reply-To: <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Aug 2022 15:06:15 -0700
Message-ID: <CAADnVQ+1SE8EVMEuM=6fbjkA63Lv-OqzMCrgAkg5dS_mb5g6bg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
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

On Wed, Aug 10, 2022 at 2:47 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Just to continue brainstorming: Comments on this?
>
> Instead of a rbtree map, you have a struct bpf_rbtree global variable
> which works like a rbtree. To associate a lock with multiple
> bpf_rbtree, you do clang style thread safety annotation in the bpf
> program:
>
> #define __guarded_by(lock) __attribute__((btf_type_tag("guarded_by:" #lock))
>
> struct bpf_spin_lock shared_lock;
> struct bpf_rbtree rbtree1 __guarded_by(shared_lock);
> struct bpf_rbtree rbtree2 __guarded_by(shared_lock);
>
> guarded_by tag is mandatory for the rbtree. Verifier ensures
> shared_lock spin lock is held whenever rbtree1 or rbtree2 is being
> accessed, and whitelists add/remove helpers inside the critical
> section.

We've been discussing exactly btf_type_tag annotation
to associate rbtree with a lock :)
Thanks for bringing it up as well.
Great that we're aligned.

> I don't think associating locks to rbtree dynamically is a hard
> requirement for your use case? But if you need that, you may probably
> also allocate sets of rbtree that are part of the same lock "class"
> dynamically using bpf_kptr_alloc, and do similar annotation for the
> struct being allocated.
> struct rbtree_set {
>   struct bpf_spin_lock lock;
>   struct bpf_rbtree rbtree1 __guarded_by(lock);
>   struct bpf_rbtree rbtree2 __guarded_by(lock);
> };
> struct rbtree_set *s = bpf_kptr_alloc(sizeof(*s), btf_local_type_id(*s));
> // Just stash the pointer somewhere with kptr_xchg
> On bpf_kptr_free, the verifier knows this is not a "trivial" struct,
> so inserts destructor calls for bpf_rbtree fields during program
> fixup.
>
> The main insight is that lock and rbtree are part of the same
> allocation (map value for global case, ptr_to_btf_id for dynamic case)
> so the locked state can be bound to the reg state in the verifier.

It works nicely in the static case, but ffwd a bit.
We might need an rbtree of rbtrees.
Pretty much like map-in-map that we have today for hash tables.

And the rbtree_node might be a part of an rbtree while
being chained into a separate link list.

We need a lock to protect operations on both rbtree and link list.
Then we might need to create an rbtree dynamically for each cgroup.
And store a pointer to rb_root in cgroup local storage.
Maybe allocating a lock + rb_root + linklist_head as one
allocation will not be too restrictive.

> Then we can also make this new rbtree API use kfuncs instead of UAPI
> helpers, to get some field experience before baking it in.

+1 to that.

> Any opinions? Any brainos or deficiencies in the scheme above?

It would be great if we can do the lock checks statically.
Dynamic locks means that rbtree_add/erase and in the future
link list insert/remove might fail which is horrible from
programmer perspective.
We've been thinking about the "abort" concept for such cases.
When helpers detect an unsafe condition like correct lock is not
taken, they can abort execution of itself, the bpf program
and prevent the program from executing in the future.
Conceptually it sounds great and will solve all kinds of ugliness,
but it's not clear yet how to implement such abort mechanism
which would mean stack unwind and calling of destructors for kptr-s,
refcnt decrements for acquired objects like sockets, etc.
