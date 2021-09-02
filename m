Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39EA3FE7FA
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhIBD3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhIBD3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 23:29:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8975C061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 20:28:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f4so1086969ybr.5
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLOQcox/rN/aGUpC0FZtMxGQe1nOikn+nZGSNGBgZUw=;
        b=h2jIXv3lp/vnIe6g0Wq3NowtKO6D/pc+iqqNw8NLBfAGgsTqWNYfkbzXG6vYST5GwF
         oPYPoG3nIL0MWh+KqyHTFlzIpuFms3J6ZhYi5/ZSCSRif2br8E4qcAQhhKw4jshmO5ZA
         NUgyh40AdZQak99hHVRFSpiIOQeqYNfrBXsT3tsMVWatmy0te6uHCX29Tij1HVV++iko
         MI7oZXGZMQM+hPO22xESNfuXubLOGxFX/ImHadPNvNHb9feJKRsQEBSBIXz11snI+4Es
         HzjV1iC69JTdcXKMt0Olp0KI3S9t5rcFa+v5fCScNaf2vrDMZdHX7H5jgXe891k6f5q+
         S0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLOQcox/rN/aGUpC0FZtMxGQe1nOikn+nZGSNGBgZUw=;
        b=n73Me4c+ZQWCXffwlwOvQ+Z3lxRyDkBpH6pzzGRZYr4gT/XAJnkhjMYSA6jzEwvTLG
         9ypM0/jitDvtQL8tRWc77mHUDCLBdmzC4j6SHBKNp+Lv9c0X83N2mDQEXT7UlmeAzahL
         qDkLFuU+LMxFQHFXmUBcA6SA4AiqUGu480OvOQVoxa+o+4oLMm0p4vTQUG8JG/qenEcW
         GfpPjkSPsRcE54JhEU1ONYgGXGtgO+m44LOPHBjmGNlCwMMSSmI5s099+RDaxY17NRD/
         nwNhL1ve5RqUvjatbqsnAKycVBHHGCLFc/sc5LY8EbiqSKuU7DRJc5A4RmOpYyPgJt1B
         Vhbg==
X-Gm-Message-State: AOAM530pO9cytTajSlFjLWIO5GCGzf1Y9AAStnjRgTsFaAE66mueMYPr
        N77fh/HoCkdE952GFdSpPwIyR6myuK9mcaJD4ZY=
X-Google-Smtp-Source: ABdhPJzQ0IaHZa1VmXFQpp444CcUG9aHuJ8l1BAoRca6FWgM5+2biPWNMnKGSL3NnyczowtPnwgpYEqIzInKvLfe7zo=
X-Received: by 2002:a25:4941:: with SMTP id w62mr1680628yba.230.1630553301969;
 Wed, 01 Sep 2021 20:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225005.2762202-1-joannekoong@fb.com> <20210831225005.2762202-2-joannekoong@fb.com>
 <61304218227e8_1aed208dd@john-XPS-13-9370.notmuch>
In-Reply-To: <61304218227e8_1aed208dd@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Sep 2021 20:28:10 -0700
Message-ID: <CAEf4BzZFExb-EQcmvPV2KCc-ey8k6S-9YziY2e2MEE+NOQ9DAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 1, 2021 at 8:18 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Joanne Koong wrote:
> > Bloom filters are a space-efficient probabilistic data structure
> > used to quickly test whether an element exists in a set.
> > In a bloom filter, false positives are possible whereas false
> > negatives are not.
> >
> > This patch adds a bloom filter map for bpf programs.
> > The bloom filter map supports peek (determining whether an element
> > is present in the map) and push (adding an element to the map)
> > operations.These operations are exposed to userspace applications
> > through the already existing syscalls in the following way:
> >
> > BPF_MAP_LOOKUP_ELEM -> peek
> > BPF_MAP_UPDATE_ELEM -> push
> >
> > The bloom filter map does not have keys, only values. In light of
> > this, the bloom filter map's API matches that of queue stack maps:
> > user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> > which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> > and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> > APIs to query or add an element to the bloom filter map. When the
> > bloom filter map is created, it must be created with a key_size of 0.
> >
> > For updates, the user will pass in the element to add to the map
> > as the value, wih a NULL key. For lookups, the user will pass in the
> > element to query in the map as the value. In the verifier layer, this
> > requires us to modify the argument type of a bloom filter's
> > BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> > the syscall layer, we need to copy over the user value so that in
> > bpf_map_peek_elem, we know which specific value to query.
> >
> > The maximum number of entries in the bloom filter is not enforced; if
> > the user wishes to insert more entries into the bloom filter than they
> > specified as the max entries size of the bloom filter, that is permitted
> > but the performance of their bloom filter will have a higher false
> > positive rate.
>
> hmm I'm wondering if this means the memory footprint can grow without
> bounds? Typically maps have an upper bound on memory established at
> alloc time.

It's a bit unfortunate wording, but no, the amount of used memory is
fixed. Bloom filter is a probabilistic data structure in which each
"value" has few designated bits, determined by hash functions on that
value. The number of bits is fixed, though. If all designated bits are
set to 1, then we declare "value" to be present in the Bloom filter.
If at least one is 0, then we definitely didn't see "value" yet
(that's what guarantees no false negatives; this also answers Alexei's
worry about possible false negative due to unsynchronized update and
lookup, it can't happen by the nature of the data structure design,
regardless of synchronization). We can, of course, have all such bits
set to 1 even if the actual value was never "added" into the Bloom
filter, just by the nature of hash collisions with other elements'
hash functions (that's where the false positive comes from). It might
be useful to just leave a link to Wikipedia for description of Bloom
filter data structure ([0]).

  [0] https://en.wikipedia.org/wiki/Bloom_filter

>
> In queue_stack_map_alloc() we have,
>
>  queue_size = sizeof(*qs) + size * attr->value_size);
>  bpf_map_area_alloc(queue_size, numa_node)
>
> In hashmap (not preallocated)  we have, alloc_htab_elem() that will
> give us an upper bound.
>
> Is there a practical value in allowing these to grow endlessly? And
> should we be charging the value memory against something? In
> bpf_map_kmalloc_node we set_active_memcg() for example.
>
> I'll review code as well, but think above is worth some thought.
>
> >
> > The number of hashes to use for the bloom filter is configurable from
> > userspace. The benchmarks later in this patchset can help compare the
> > performances of different number of hashes on different entry
> > sizes. In general, using more hashes decreases the speed of a lookup,
> > but increases the false positive rate of an element being detected in the
> > bloom filter.
> >
> > Signed-off-by: Joanne Koong <joannekoong@fb.com>
