Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD365C7A0
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjACTis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 14:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjACTia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 14:38:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF313F8A;
        Tue,  3 Jan 2023 11:38:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so76634500ejb.6;
        Tue, 03 Jan 2023 11:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uz0z6glvR6UTm9zIA9gGqEZh5IwSDdS2kpGh3fCJmBQ=;
        b=eU3X0ITvyRxl1EqO2mDe9c2uMd6T094prAz1zPve5YB91Q1TsfRZPIX/fwnFyTjPLX
         Xa89qt3djHl6S4ne0ZoJfi6Ar0Oczcg/bfFTtn0yaXe+RJfDtxZ79pDG7Mk634qhJjRo
         7h4gRiqPMe0gZrr57QmKfup+uLt0+ygvojKzbtMjHcycOmnazAeKQrqbjBt+dfwqCYOR
         R+NpZk2W81FZyN3eWT7sazgzzD03QvRXwVH2LnHvYt3FC6TNOL56cvF0TUTX3uLWinUY
         HwdTRa2fVXg7l/NBvr04FChqFMvrMj1ceDbVMym302+cgbsRKZxVqJ9+8NO44ZSPrrBQ
         UVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz0z6glvR6UTm9zIA9gGqEZh5IwSDdS2kpGh3fCJmBQ=;
        b=Z5u1A6QCPR+K8PmIq25Df/Dtc9ZmI9JH5q9VBIsKP9mvjZT6/WKtlyXw9yofb8uygZ
         Ss2TpOrJ+wAwGkHXpILzEE1ub1I0Bv5v3tiADBwGki6poNlygyzN7Fln8IcCe2/uRS/L
         6yOkdP0q9HWoeZqZU9AiEcSIAmL3tpnuRd2NxgKVFIpJ1aqvjll1t9dI0C/ezIT22Iyk
         I0YGh+N2wO9DPkUQBAoFmuYiLSBWr6VYGyVTDic6q6jilPruTC98DDoz5Y7jFSKc6CTP
         7LVhHifS25ttS7t8yTdby2GK34FeORVCJAPR24RXELKNAC6E+neveWli7FQBtHSzsSdT
         Jhpw==
X-Gm-Message-State: AFqh2krQsASicEmciK5oSVvtL4WAAcMoN/Mism4iwbTzUyajSattDAiu
        8HCfmUWlK+sTFVZ8G7QbXCmSivuy5DK2eJy53zw=
X-Google-Smtp-Source: AMrXdXvq+a9qcP7tn1hp8z3zpiaeSBFQ0UGor0fKnc7utm+qIjLj/+ZB2EGjw6cg5TNwBHrodjRAHKRsT7nRDs/IHXU=
X-Received: by 2002:a17:906:2818:b0:836:e897:648a with SMTP id
 r24-20020a170906281800b00836e897648amr2293613ejc.94.1672774707576; Tue, 03
 Jan 2023 11:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com> <2f875cf9-88ac-1406-4ad0-f7647fb92883@huaweicloud.com>
In-Reply-To: <2f875cf9-88ac-1406-4ad0-f7647fb92883@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 3 Jan 2023 11:38:16 -0800
Message-ID: <CAADnVQ+z-Y6Yv2i-icAUy=Uyh9yiN4S1AOrLd=K8mu32TXORkw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
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

On Tue, Jan 3, 2023 at 5:40 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 1/1/2023 9:26 AM, Alexei Starovoitov wrote:
> > On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> >>
> >> The patchset tries to fix the problems found when checking how htab map
> >> handles element reuse in bpf memory allocator. The immediate reuse of
> >> freed elements may lead to two problems in htab map:
> >>
> >> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
> >>     htab map value and it may corrupt lookup procedure with BFP_F_LOCK
> >>     flag which acquires bpf-spin-lock during value copying. The
> >>     corruption of bpf-spin-lock may result in hard lock-up.
> >> (2) lookup procedure may get incorrect map value if the found element is
> >>     freed and then reused.
> >>
> >> Because the type of htab map elements are the same, so problem #1 can be
> >> fixed by supporting ctor in bpf memory allocator. The ctor initializes
> >> these special fields in map element only when the map element is newly
> >> allocated. If it is just a reused element, there will be no
> >> reinitialization.
> > Instead of adding the overhead of ctor callback let's just
> > add __GFP_ZERO to flags in __alloc().
> > That will address the issue 1 and will make bpf_mem_alloc behave just
> > like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> > will behave the same way.
> Use __GPF_ZERO will be simpler, but the overhead of memset() for every allocated
> object may be bigger than ctor callback when the size of allocated object is
> large. And it also introduces unnecessary memory zeroing if there is no special
> field in the map value.

Small memset is often faster than an indirect call.
I doubt that adding GFP_ZERO will have a measurable perf difference
in map_perf_test and other benchmarks.

> >> Problem #2 exists for both non-preallocated and preallocated htab map.
> >> By adding seq in htab element, doing reuse check and retrying the
> >> lookup procedure may be a feasible solution, but it will make the
> >> lookup API being hard to use, because the user needs to check whether
> >> the found element is reused or not and repeat the lookup procedure if it
> >> is reused. A simpler solution would be just disabling freed elements
> >> reuse and freeing these elements after lookup procedure ends.
> > You've proposed this 'solution' twice already in qptrie thread and both
> > times the answer was 'no, we cannot do this' with reasons explained.
> > The 3rd time the answer is still the same.
> This time a workable demo which calls call_rcu_task_trace() in batch is provided
> :) Also because I can not find a better solution for the reuse problem. But you
> are right, although don't reuse the freed element will make the implementation
> of map simpler, the potential OOM problem is hard to solve specially when RCU
> tasks trace grace period is slow. Hope Paul can provide some insight about the
> problem.

OOM is exactly the reason why we cannot do this delaying logic
in the general case. We don't control what progs do and rcu tasks trace
may take a long time.

> > This 'issue 2' existed in hashmap since very beginning for many years.
> > It's a known quirk. There is nothing to fix really.
> Do we need to document the unexpected behavior somewhere, because I really don't
> know nothing about the quirk ?

Yeah. It's not documented in Documentation/bpf/map_hash.rst.
Please send a patch to add it.

> >
> > The graph apis (aka new gen data structs) with link list and rbtree are
> > in active development. Soon bpf progs will be able to implement their own
> > hash maps with explicit bpf_rcu_read_lock. At that time the progs will
> > be making the trade off between performance and lookup/delete race.
> It seems these new gen data struct also need to solve the reuse problem because
> a global bpf memory allocator is used.

Currently the graph api is single owner and kptr_xchg is used to allow
single cpu at a time to observe the object.
In the future we will add bpf_refcount and multi owner.
Then multiple cpus will be able to access the same object concurrently.
They will race to read/write the fields and it will be prog decision
to arbitrate the access.
In other words the bpf prog needs to have mechanisms to deal with reuse.
