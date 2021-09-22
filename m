Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0441518F
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbhIVUqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 16:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhIVUqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 16:46:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040DC061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:44:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 138so14065252qko.10
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odiZ4TGZ51oc/Z5KxMEuh+3bD+Eap+cpLjwQ2kkD440=;
        b=DmAiSgdx6IjRnpATCr5WfSiZg4H/9wz81nNPzmRbEQLLFwpFCp8SfGZ/AqO3ZkPRZE
         Djf9d6NV50U1bMTH93e/JBtr8B4Q3sXqIa+E/CRClPQsKQ2p9R4rdnRb3J9tFYE5nif5
         4FPkk/KtltQvlsy95r6ljibHMUw4yVSHvqatZHXcTwzRPmXIZkxTN6+g16M1I4YcAtw2
         o4GMOIh2XixsQ9o99nTu4EkEW1nqWfV68zvvKz6LRCcZ/fTQewazSh143PLJX+orEYQl
         I8njqb3tZ1KiTLHU2Cj/cX2zWpxWN8lpfSRoIlmLDDkvBBC4Rk2cGRpsqY+pDqDCFYHu
         t+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odiZ4TGZ51oc/Z5KxMEuh+3bD+Eap+cpLjwQ2kkD440=;
        b=UD+oR79XXd1np9X9c/w0Ll3tb0BJUFgF/OrEUlXFmROUZG9w4upLTpEthfiJGwe1ZD
         YqRtyi3XCw4Vj/IU/ytz/7qapK/HSnuKS4L6yAxDrjRbrQLzfVKMWs4DVnNujh/I5TeM
         YokcFXNS3p6Uk7IXB6cchyWk10aufJcjMWNli1fsIAA4diEC4yVApL2O5+pdL3duY+cP
         BvsGIf0V6ebE3aa72wb6yn0awQEA/XWVFfuPuHrcPIvgE0NgjBiOP5/SsQ6CBC0qaNVN
         BukYzK8FozYZoO6iriXxuBnmkTiLfvxUUJN+QCegESJqlrZDN9OpJFRmncNAqMOl3iXB
         /rTw==
X-Gm-Message-State: AOAM5305KK03BgU2JK+aXvfQJoEUmeIgfPhCSCyRIEaw3bcWKk5p7hyE
        uuKIGCMOo8cDjE/tj69aIOqa5NRvRhawi/wFC+jdrwiQBfo=
X-Google-Smtp-Source: ABdhPJwGgYJdq4hN+OvgO96a6ZsUWUgII9a3jMd+gFOEoDpZ1DEfzEsbk4oET34GdSBcfvjOtvC8NLEacQJ8xUbG0C4=
X-Received: by 2002:a25:840d:: with SMTP id u13mr1259136ybk.455.1632343481212;
 Wed, 22 Sep 2021 13:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com> <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
In-Reply-To: <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 13:44:30 -0700
Message-ID: <CAEf4BzYpMx6YLs3LJWuNxV2FW_jWQjji8o04jcrK+Pv3SbQz6g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 12:06 PM Joanne Koong <joannekoong@fb.com> wrote:
>
>
> On 9/21/21 4:44 PM, Andrii Nakryiko wrote:
> > On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
> >> Bloom filters are a space-efficient probabilistic data structure
> >> used to quickly test whether an element exists in a set.
> >> In a bloom filter, false positives are possible whereas false
> >> negatives should never be.
> >>
> >> This patch adds a bloom filter map for bpf programs.
> >> The bloom filter map supports peek (determining whether an element
> >> is present in the map) and push (adding an element to the map)
> >> operations.These operations are exposed to userspace applications
> >> through the already existing syscalls in the following way:
> >>
> >> BPF_MAP_LOOKUP_ELEM -> peek
> >> BPF_MAP_UPDATE_ELEM -> push
> >>
> >> The bloom filter map does not have keys, only values. In light of
> >> this, the bloom filter map's API matches that of queue stack maps:
> >> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> >> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> >> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> >> APIs to query or add an element to the bloom filter map. When the
> >> bloom filter map is created, it must be created with a key_size of 0.
> >>
> >> For updates, the user will pass in the element to add to the map
> >> as the value, with a NULL key. For lookups, the user will pass in the
> >> element to query in the map as the value. In the verifier layer, this
> >> requires us to modify the argument type of a bloom filter's
> >> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> >> the syscall layer, we need to copy over the user value so that in
> >> bpf_map_peek_elem, we know which specific value to query.
> >>
> >> A few things to please take note of:
> >>   * If there are any concurrent lookups + updates, the user is
> >> responsible for synchronizing this to ensure no false negative lookups
> >> occur.
> >>   * The number of hashes to use for the bloom filter is configurable from
> >> userspace. If no number is specified, the default used will be 5 hash
> >> functions. The benchmarks later in this patchset can help compare the
> >> performance of using different number of hashes on different entry
> >> sizes. In general, using more hashes decreases the speed of a lookup,
> >> but increases the false positive rate of an element being detected in the
> >> bloom filter.
> >>   * Deleting an element in the bloom filter map is not supported.
> >>   * The bloom filter map may be used as an inner map.
> >>   * The "max_entries" size that is specified at map creation time is used to
> >> approximate a reasonable bitmap size for the bloom filter, and is not
> >> otherwise strictly enforced. If the user wishes to insert more entries into
> >> the bloom filter than "max_entries", they may do so but they should be
> >> aware that this may lead to a higher false positive rate.
> >>
> >> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> >> ---
> >>   include/linux/bpf_types.h      |   1 +
> >>   include/uapi/linux/bpf.h       |   1 +
> >>   kernel/bpf/Makefile            |   2 +-
> >>   kernel/bpf/bloom_filter.c      | 185 +++++++++++++++++++++++++++++++++
> >>   kernel/bpf/syscall.c           |  14 ++-
> >>   kernel/bpf/verifier.c          |  19 +++-
> >>   tools/include/uapi/linux/bpf.h |   1 +
> >>   7 files changed, 217 insertions(+), 6 deletions(-)
> >>   create mode 100644 kernel/bpf/bloom_filter.c
> >>
> > See some stylistic nitpicking below (and not a nitpicking about BTF).
> >
> > But I just wanted to say that I'm a bit amazed by how much special
> > casing this BLOOM_FILTER map requires in syscall.c and verifier.c. I
> > still believe that starting with a BPF helper for hashing would be a
> > better approach, but oh well.
> >
> > [...]
> I liked your comment on v1 regarding using a BPF helper and I agree with
> the benefits
> you outlined. I'm curious to see what the performance differences
> between that approach
> and this one end up being, if any. I plan to test out the BPF helper
> approach in a few weeks,
> and if the performance is comparable or better, I am definitely open to
> reverting this code
> and just going with the BPF helper approach :)

I got curious myself yesterday and spent the evening trying this out.
There is slight performance regression in pure bloom filter querying
performance. More confusingly, with such a small difference in bloom
filter performance, there is a much more noticeable difference in the
hybrid bloom+hashmap benchmark. I don't know how to explain the
difference. It might be just the multiplying effect of small perf
differences due to subsequent hashmap lookup. TBH, we are talking
about millions of operations per second, and I don't think in practice
it will matter much. It's like XDP microbenchmarks, where as soon as
you start doing something useful that overhead trumps whatever small
overhead BPF/XDP/bloom filter causes. But I'm not going to argue about
that here :)

I just sent and RFC patch set to demonstrate the approach and compare
with your results. They are not in Patchworks yet, but they are on
lore for those following along ([0]).

While doing that I found a problem with the way you implemented
benchmark measuring. I've also optimized few stats collecting parts.
Please take a look at the RFC. If anything, it would be good to
incorporate those fixes.

It would also be good to add benchmark that test keys bigger than 8
bytes, as mentioned before. I haven't found that in your benchmark.
Also, they way benchmark is implemented right now, it spends lots of
(measured) time doing stuff like generating random values on the fly.
There is also no control over the ratio of hits and misses. It feels
like the benchmark is over-optimizing for happy case of bloom filter
having a true negative and thus proceeding very fast. There are barely
any hits at all (they don't even register in the benchmark).

It also turned out that you don't benchmark updating Bloom filter from
BPF program side. Was that intentional or you anticipate that in
practice that won't be necessary? I was curious to compare those
results because the rely on BPF atomics, but I didn't go all the way
to add them.


  [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t

> >> +
> >> +static inline u32 hash(struct bpf_bloom_filter *bloom_filter, void *value,
> >> +                      u64 value_size, u32 index)
> >> +{
> >> +       if (bloom_filter->aligned_u32_count)
> >> +               return jhash2(value, bloom_filter->aligned_u32_count,
> >> +                             bloom_filter->hash_seed + index) &
> >> +                       bloom_filter->bit_array_mask;
> >> +
> >> +       return jhash(value, value_size, bloom_filter->hash_seed + index) &
> >> +               bloom_filter->bit_array_mask;
> > stylistic nit, but this feels way to dense text-wise, this seems
> > easier to follow
> >
> > u32 h;
> >
> > if (bloom_filter->aligned_u32_count)
> >      h = jhash2(...);
> > else
> >      h = jhash(...);
> > return h & bloom_filter->bit_array_mask;
> >
> > WDYT?
> I think this sounds great! I will make these changes for v4.

great

> >> +}
> >> +

[...]

> >> +
> >> +static int bloom_filter_map_btf_id;
> >> +const struct bpf_map_ops bloom_filter_map_ops = {
> >> +       .map_meta_equal = bpf_map_meta_equal,
> >> +       .map_alloc = bloom_filter_map_alloc,
> >> +       .map_free = bloom_filter_map_free,
> >> +       .map_push_elem = bloom_filter_map_push_elem,
> >> +       .map_peek_elem = bloom_filter_map_peek_elem,
> >> +       .map_lookup_elem = bloom_filter_map_lookup_elem,
> >> +       .map_update_elem = bloom_filter_map_update_elem,
> >> +       .map_delete_elem = bloom_filter_map_delete_elem,
> >> +       .map_get_next_key = bloom_filter_map_get_next_key,
> >> +       .map_check_btf = map_check_no_btf,
> > can you please implement basically a no-op callback here to allow
> > specifying btf_value_id, there is no good reason to restrict this new
> > map to not allow BTF type being specified for its value
> Sounds great, will add this in v4.

cool, we should try to support BTF for all new maps


> >> +       .map_btf_name = "bpf_bloom_filter",
> >> +       .map_btf_id = &bloom_filter_map_btf_id,
> >> +};
> > [...]
