Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C694151AE
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhIVUxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhIVUxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 16:53:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB7C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:52:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 194so14198947qkj.11
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETHn+HXqCwt6ObZ3baFoRDqTYDT1IsV5/NEXBYgn6Pg=;
        b=bki5jozc9QqDuD5VQ9wGx8TZ/r6I9FSqD3l2etIATsbrRRxaYdXRuP6EzjEoBasI4z
         k0jVRR8hfiU/OUbm/wdfYvNHKhaF1uhfVVJAhsAg+jWkcOAK5Bo2orlxnd0TraeYkKwG
         2t590KcGc6ydJRvCFBdsfNlW+NTqF0uAXNW9JaA0htRaS+qcbHL/lM2dmlG+Nxgol7FZ
         0IZK2QEQQrMWAwswIyJ6TPw41n13jD26HEnHEMExH0iPcCEq7hoSXltH1EVgGWJYRdsT
         7zeMdAw2rqUB1IljeynIBZGzr2c4rRIPkYr919EbmI/SewvC8WU9yR5uXP+yARGmsxUm
         Frbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETHn+HXqCwt6ObZ3baFoRDqTYDT1IsV5/NEXBYgn6Pg=;
        b=vKOWwq0LqEkuydxSyqtaNhWxe/lSJ9qSUZ96BQNWxin2k5fj3WzojEHZXErxurzKDf
         LbS6jc7pYxPADpDSmr7oDzL/2e4UnTBXTFsOEinReNywSCOfehc5ky3jhAx0iHoXPHuh
         AZpA1Y5uat+S5zxcZEnBmXY53IQmPjuemg8uYUGOzgCeCuyBZcqDm8U23IoR9Kz0krrk
         f4CWDUwZ1QpUjAP2C6qTAJJWgF43mLOUDzQsqlV3zx+zQ51V+k+glitqVfDOjTLbks2o
         hDj928HHSAWil/uSxEknnl4Ge6Sgr07fFsgXOCbwa3jgXPDCFr8wA0jlkc5R+ugAybIr
         wY/g==
X-Gm-Message-State: AOAM532U2ZMOgRSp1F5iraNaQhOV2zqa7zg/uAqKBDD4slwZ2AjPoBDp
        VKpumQZsE195c+z3lvPPSZV4zELZl1ssU8YWghCS65C2/gU=
X-Google-Smtp-Source: ABdhPJyMecANTwcTyyOKJ8TX01U120XBxHexos6tSCJBzZUSNEBbLmcI6adHBmNNEXmThrLJ7lmwCiYvqPH2k4mpURM=
X-Received: by 2002:a25:1884:: with SMTP id 126mr1410620yby.114.1632343943299;
 Wed, 22 Sep 2021 13:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com> <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 13:52:12 -0700
Message-ID: <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Sep 22, 2021 at 12:06:02PM -0700, Joanne Koong wrote:
> >
> > On 9/21/21 4:44 PM, Andrii Nakryiko wrote:
> > > On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
> > > > Bloom filters are a space-efficient probabilistic data structure
> > > > used to quickly test whether an element exists in a set.
> > > > In a bloom filter, false positives are possible whereas false
> > > > negatives should never be.
> > > >
> > > > This patch adds a bloom filter map for bpf programs.
> > > > The bloom filter map supports peek (determining whether an element
> > > > is present in the map) and push (adding an element to the map)
> > > > operations.These operations are exposed to userspace applications
> > > > through the already existing syscalls in the following way:
> > > >
> > > > BPF_MAP_LOOKUP_ELEM -> peek
> > > > BPF_MAP_UPDATE_ELEM -> push
> > > >
> > > > The bloom filter map does not have keys, only values. In light of
> > > > this, the bloom filter map's API matches that of queue stack maps:
> > > > user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> > > > which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> > > > and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> > > > APIs to query or add an element to the bloom filter map. When the
> > > > bloom filter map is created, it must be created with a key_size of 0.
> > > >
> > > > For updates, the user will pass in the element to add to the map
> > > > as the value, with a NULL key. For lookups, the user will pass in the
> > > > element to query in the map as the value. In the verifier layer, this
> > > > requires us to modify the argument type of a bloom filter's
> > > > BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> > > > the syscall layer, we need to copy over the user value so that in
> > > > bpf_map_peek_elem, we know which specific value to query.
> > > >
> > > > A few things to please take note of:
> > > >   * If there are any concurrent lookups + updates, the user is
> > > > responsible for synchronizing this to ensure no false negative lookups
> > > > occur.
> > > >   * The number of hashes to use for the bloom filter is configurable from
> > > > userspace. If no number is specified, the default used will be 5 hash
> > > > functions. The benchmarks later in this patchset can help compare the
> > > > performance of using different number of hashes on different entry
> > > > sizes. In general, using more hashes decreases the speed of a lookup,
> > > > but increases the false positive rate of an element being detected in the
> > > > bloom filter.
> > > >   * Deleting an element in the bloom filter map is not supported.
> > > >   * The bloom filter map may be used as an inner map.
> > > >   * The "max_entries" size that is specified at map creation time is used to
> > > > approximate a reasonable bitmap size for the bloom filter, and is not
> > > > otherwise strictly enforced. If the user wishes to insert more entries into
> > > > the bloom filter than "max_entries", they may do so but they should be
> > > > aware that this may lead to a higher false positive rate.
> > > >
> > > > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > > > ---
> > > >   include/linux/bpf_types.h      |   1 +
> > > >   include/uapi/linux/bpf.h       |   1 +
> > > >   kernel/bpf/Makefile            |   2 +-
> > > >   kernel/bpf/bloom_filter.c      | 185 +++++++++++++++++++++++++++++++++
> > > >   kernel/bpf/syscall.c           |  14 ++-
> > > >   kernel/bpf/verifier.c          |  19 +++-
> > > >   tools/include/uapi/linux/bpf.h |   1 +
> > > >   7 files changed, 217 insertions(+), 6 deletions(-)
> > > >   create mode 100644 kernel/bpf/bloom_filter.c
> > > >
> > > See some stylistic nitpicking below (and not a nitpicking about BTF).
> > >
> > > But I just wanted to say that I'm a bit amazed by how much special
> > > casing this BLOOM_FILTER map requires in syscall.c and verifier.c. I
> > > still believe that starting with a BPF helper for hashing would be a
> > > better approach, but oh well.
> > >
> > > [...]
> > I liked your comment on v1 regarding using a BPF helper and I agree with the
> > benefits you outlined. I'm curious to see what the performance differences between
> > that approach and this one end up being, if any. I plan to test out the BPF helper
> > approach in a few weeks, and if the performance is comparable or better, I am definitely open to
> > reverting this code and just going with the BPF helper approach :)
> Reverting won't be an option and I don't think it is necessary.
>
> Agree that a generic hash helper is in general useful.  It may be
> useful in hashing the skb also.  The bpf prog only implementation could
> have more flexibility in configuring roundup to pow2 or not, how to hash,
> how many hashes, nr of bits ...etc.  In the mean time, the bpf prog and

Exactly. If I know better how many bits I need, I'll have to reverse
engineer kernel's heuristic to provide such max_entries values to
arrive at the desired amount of memory that Bloom filter will be
using.

> user space need to co-ordinate more and worry about more things,
> e.g. how to reuse a bloom filter with different nr_hashes,
> nr_bits, handle synchronization...etc.

Please see my RFC ([0]). I don't think there is much to coordinate. It
could be purely BPF-side code, or BPF + user-space initialization
code, depending on the need. It's a simple and beautiful algorithm,
which BPF is powerful enough to implement customly and easily.

  [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t

>
> It is useful to have a default implementation in the kernel
> for some useful maps like this one that works for most
> common cases and the bpf user can just use it as get-and-go
> like all other common bpf maps do.

I disagree with the premise that Bloom filter is a common and
generally useful data structure, tbh. It has its nice niche
applications, but its semantics isn't applicable generally, which is
why I hesitate to claim that this should live in kernel.

>
> imo, the verifier/syscall change here is quite minimal also and it
> is mostly riding on top of the existing BPF_MAP_TYPE_STACK.

Not exactly true, it adds quite a bit of new custom pieces. But it's
subjective so there is no point in arguing.
