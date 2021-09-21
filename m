Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932AF413E1C
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhIUXq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIUXqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 19:46:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4BC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:44:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 194so3089190qkj.11
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rKmMnhzLVZdRJORMZQ2T5V4l6omJWm5bkGrzaykABw=;
        b=DSpvt0oYoR95w0BCub+hw64SHfPHKswUywVpidlR3pqOSQ9BDWUdeSsXtCQYEQNshH
         TXGXRoLmhFrl51pqDSr0+PZUU7oI8+6HnRLiiG6umCBKWWvI1XNKACxAZZjIsVxDx5BA
         myrges+KSX4Vgnx4SGI+6dq+ZJo95YR6nq/0v6V0/gFzaKo012p2VPbmowTDMuTiQ4o1
         /Ta8G8U32NtPIYeC+aXjXSzjn2bIc/4W8evcyCnZiWFAp2MWKgI6p7niSMq5ZBGr6az8
         JWzxv7lI83hTGeBQqV+CwpUGyrdxyMNxCc4yc5i/5JQPSzxQCnQjLPFSsbXdC96GMcGC
         7dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rKmMnhzLVZdRJORMZQ2T5V4l6omJWm5bkGrzaykABw=;
        b=3dW98nJjRGRqQdj0+dJdGXt34iY3/cfPRcDPmPvqFfXZ0+G1aqaPobncNeirNVKhMA
         tJ9egAHiGjadKmXrEQSRNy5J9B8k25TW1Ny0rko4HBNFUiFZdGHo/Z4Fo7anHs48mWsi
         MTg5BbKfIdYqMTc5BpD04PDSt3znvgt/I/riHJzRxhcGbsHBhKCEaMqTzqjGS4yOCVZs
         EMXhacGWfZ6/hGXnJJLm0kuD+XnWQa+G1q1ToZ7CkHQMkEWi/v8zMeO4XHQeQqCtQQAN
         RMoZi4csZhZgIRPXYWg3OH3Oo4B/nIlfKJJqhVRWh+nh4jTTMP9SsqszutFxsqc6p5nt
         aICQ==
X-Gm-Message-State: AOAM531tcB9E8c0WbWyzz6Ep3x+YTv57PU1u3PRrg71cZnVyDP2qoB6Z
        SbgWFV0bHjfmLEJ6INpoW+V3ASsafcM1lFwz5GNEM5OC
X-Google-Smtp-Source: ABdhPJx7W/01sk+neMA4gCEZB10ke4rYBl5pRMWWOKAddIT6dwAg7nf3fdMjoP/vw/ak6tpassyjlIzWOj6dPoWbank=
X-Received: by 2002:a25:83c6:: with SMTP id v6mr10346677ybm.2.1632267895835;
 Tue, 21 Sep 2021 16:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-2-joannekoong@fb.com>
In-Reply-To: <20210921210225.4095056-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 16:44:44 -0700
Message-ID: <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 2:30 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> Bloom filters are a space-efficient probabilistic data structure
> used to quickly test whether an element exists in a set.
> In a bloom filter, false positives are possible whereas false
> negatives should never be.
>
> This patch adds a bloom filter map for bpf programs.
> The bloom filter map supports peek (determining whether an element
> is present in the map) and push (adding an element to the map)
> operations.These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
>
> BPF_MAP_LOOKUP_ELEM -> peek
> BPF_MAP_UPDATE_ELEM -> push
>
> The bloom filter map does not have keys, only values. In light of
> this, the bloom filter map's API matches that of queue stack maps:
> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> APIs to query or add an element to the bloom filter map. When the
> bloom filter map is created, it must be created with a key_size of 0.
>
> For updates, the user will pass in the element to add to the map
> as the value, with a NULL key. For lookups, the user will pass in the
> element to query in the map as the value. In the verifier layer, this
> requires us to modify the argument type of a bloom filter's
> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> the syscall layer, we need to copy over the user value so that in
> bpf_map_peek_elem, we know which specific value to query.
>
> A few things to please take note of:
>  * If there are any concurrent lookups + updates, the user is
> responsible for synchronizing this to ensure no false negative lookups
> occur.
>  * The number of hashes to use for the bloom filter is configurable from
> userspace. If no number is specified, the default used will be 5 hash
> functions. The benchmarks later in this patchset can help compare the
> performance of using different number of hashes on different entry
> sizes. In general, using more hashes decreases the speed of a lookup,
> but increases the false positive rate of an element being detected in the
> bloom filter.
>  * Deleting an element in the bloom filter map is not supported.
>  * The bloom filter map may be used as an inner map.
>  * The "max_entries" size that is specified at map creation time is used to
> approximate a reasonable bitmap size for the bloom filter, and is not
> otherwise strictly enforced. If the user wishes to insert more entries into
> the bloom filter than "max_entries", they may do so but they should be
> aware that this may lead to a higher false positive rate.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/linux/bpf_types.h      |   1 +
>  include/uapi/linux/bpf.h       |   1 +
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/bloom_filter.c      | 185 +++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  14 ++-
>  kernel/bpf/verifier.c          |  19 +++-
>  tools/include/uapi/linux/bpf.h |   1 +
>  7 files changed, 217 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/bloom_filter.c
>

See some stylistic nitpicking below (and not a nitpicking about BTF).

But I just wanted to say that I'm a bit amazed by how much special
casing this BLOOM_FILTER map requires in syscall.c and verifier.c. I
still believe that starting with a BPF helper for hashing would be a
better approach, but oh well.

[...]

> +
> +static inline u32 hash(struct bpf_bloom_filter *bloom_filter, void *value,
> +                      u64 value_size, u32 index)
> +{
> +       if (bloom_filter->aligned_u32_count)
> +               return jhash2(value, bloom_filter->aligned_u32_count,
> +                             bloom_filter->hash_seed + index) &
> +                       bloom_filter->bit_array_mask;
> +
> +       return jhash(value, value_size, bloom_filter->hash_seed + index) &
> +               bloom_filter->bit_array_mask;

stylistic nit, but this feels way to dense text-wise, this seems
easier to follow

u32 h;

if (bloom_filter->aligned_u32_count)
    h = jhash2(...);
else
    h = jhash(...);
return h & bloom_filter->bit_array_mask;

WDYT?

> +}
> +
> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
> +{
> +       struct bpf_bloom_filter *bloom_filter =
> +               container_of(map, struct bpf_bloom_filter, map);
> +       u32 i;
> +
> +       for (i = 0; i < bloom_filter->nr_hash_funcs; i++) {
> +               if (!test_bit(hash(bloom_filter, value, map->value_size, i),
> +                             bloom_filter->bit_array))
> +                       return -ENOENT;

same here, I think the hash calculation deserves a separate statement
and a local variable

> +       }
> +
> +       return 0;
> +}
> +

[...]

> +static void bloom_filter_map_free(struct bpf_map *map)
> +{
> +       struct bpf_bloom_filter *bloom_filter =
> +               container_of(map, struct bpf_bloom_filter, map);
> +
> +       bpf_map_area_free(bloom_filter);
> +}
> +
> +static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
> +                                     u64 flags)
> +{
> +       struct bpf_bloom_filter *bloom_filter =
> +               container_of(map, struct bpf_bloom_filter, map);
> +       u32 i;
> +
> +       if (flags != BPF_ANY)
> +               return -EINVAL;
> +
> +       for (i = 0; i < bloom_filter->nr_hash_funcs; i++)
> +               set_bit(hash(bloom_filter, value, map->value_size, i),
> +                       bloom_filter->bit_array);

same as above about hash() call on separate line

> +
> +       return 0;
> +}
> +
> +static void *bloom_filter_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +       /* The eBPF program should use map_peek_elem instead */
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static int bloom_filter_map_update_elem(struct bpf_map *map, void *key,
> +                                       void *value, u64 flags)
> +{
> +       /* The eBPF program should use map_push_elem instead */
> +       return -EINVAL;
> +}
> +
> +static int bloom_filter_map_delete_elem(struct bpf_map *map, void *key)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int bloom_filter_map_get_next_key(struct bpf_map *map, void *key,
> +                                        void *next_key)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int bloom_filter_map_btf_id;
> +const struct bpf_map_ops bloom_filter_map_ops = {
> +       .map_meta_equal = bpf_map_meta_equal,
> +       .map_alloc = bloom_filter_map_alloc,
> +       .map_free = bloom_filter_map_free,
> +       .map_push_elem = bloom_filter_map_push_elem,
> +       .map_peek_elem = bloom_filter_map_peek_elem,
> +       .map_lookup_elem = bloom_filter_map_lookup_elem,
> +       .map_update_elem = bloom_filter_map_update_elem,
> +       .map_delete_elem = bloom_filter_map_delete_elem,
> +       .map_get_next_key = bloom_filter_map_get_next_key,
> +       .map_check_btf = map_check_no_btf,

can you please implement basically a no-op callback here to allow
specifying btf_value_id, there is no good reason to restrict this new
map to not allow BTF type being specified for its value

> +       .map_btf_name = "bpf_bloom_filter",
> +       .map_btf_id = &bloom_filter_map_btf_id,
> +};

[...]
