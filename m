Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29584100E3
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhIQVty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhIQVty (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:49:54 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3142C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:48:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y144so21911448qkb.6
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXTwMnoha1Slql/gAGdTtazistW9muTQPCYsBoTEugo=;
        b=U6g0aR9IX17GA6J8HkyWnTiAeihZGS/3u3DOy2dhmzaP2uTukjMhs2oNYbRYWMZP9v
         ycKgdibFTCwa0snhpjYhqA2Me9z6aDUEG6xKgo23YcOHQkC8DAElTLSaGxe9ceEHTAMR
         Lv1wFzL/4mmrHm+3UUV52rizONMNtCPJ2xphpvZ8SuD6dLwOSpzeaWnb5EhfE6QJOjfc
         QpxtLV/F9x+8gzJysJZ9li1e+IalrJWnR25iOKhx39Drz/umGV/QfCoTOCgt4mKq3K8W
         g2qy3xxbQbeFjJWKvz7F9G35XJhk7AlznltnMzszO5oG2CAiGA63GPcki/3+wnOPEr/J
         3z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXTwMnoha1Slql/gAGdTtazistW9muTQPCYsBoTEugo=;
        b=zSfDrrT8yNp2YG8w2u1bsZudOGSoWuWQlyGiq3ajKA0qzjJruC2bt40EJ/3pnGSf82
         +2jV8hj1oHhMwUz/dbuwocn58oTH3fZFhQYiZTZlas/+AnfakXqWsa3lUX36d9BjYdYt
         zxSbsAJw2pK/HqZnplcMuFr4QdY01wN3DfrbD+9rUgeAqMldKz5N+4OVowJdnJcP+9Mc
         qus/XCM/iEXcKXS9JWLb9EGvtZYNR93NYHE7XP+Qf3Zzw1Nh7wryUn0xIAvPKGKkJv+2
         M16sk7owuNeMPIL5qBa+nbcbRRyXUJ4frQKPgOdXhfA3DVnAwxiY8zkjX+4LuScvVSwT
         cuAA==
X-Gm-Message-State: AOAM533AEgJBje499KBBMLwroeuJ9AlPtNeC+e43OL3v1pBPXOQwYg3A
        ABUBbKatyuLvPWpeCm/faC26m+MyJ0gQzr6xN4nVr+clCCc=
X-Google-Smtp-Source: ABdhPJyfmLk44jxLtJHzUu8VjbZQLCg0fh5uao47lYhdXFZCu+G4c2S8f0Le3GCxfbP8pJVZKrrkK3EsKq2RRQp3JeQ=
X-Received: by 2002:a25:840d:: with SMTP id u13mr2402213ybk.455.1631915310842;
 Fri, 17 Sep 2021 14:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210914040433.3184308-1-joannekoong@fb.com> <20210914040433.3184308-2-joannekoong@fb.com>
In-Reply-To: <20210914040433.3184308-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 14:48:19 -0700
Message-ID: <CAEf4BzbOhZRbyj_291jgAG45is4jzBrm--ru_VSUD5U3Zodidg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 9:09 PM Joanne Koong <joannekoong@fb.com> wrote:
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
>  include/uapi/linux/bpf.h       |  10 ++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/bloom_filter.c      | 205 +++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  14 ++-
>  kernel/bpf/verifier.c          |  19 ++-
>  tools/include/uapi/linux/bpf.h |  10 ++
>  7 files changed, 255 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/bloom_filter.c
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 9c81724e4b98..c4424ac2fa02 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>  #endif
>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 791f31dd0abe..1d82860fd98e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -906,6 +906,7 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_RINGBUF,
>         BPF_MAP_TYPE_INODE_STORAGE,
>         BPF_MAP_TYPE_TASK_STORAGE,
> +       BPF_MAP_TYPE_BLOOM_FILTER,
>  };
>
>  /* Note that tracing related programs such as
> @@ -1210,6 +1211,15 @@ enum {
>
>  /* Create a map that is suitable to be an inner map with dynamic max entries */
>         BPF_F_INNER_MAP         = (1U << 12),
> +
> +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
> + * The maximum number of hash functions supported is 15. If this is not set,
> + * the default number of hash functions used will be 5.
> + */
> +       BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
> +       BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
> +       BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
> +       BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),

I didn't realize all those map_flags are sequentially numbered, but I
guess we are not yet running out of space, so this might be ok. But to
be usable from BPF program nicely, I would be better to define this as
offset of a first hash bit and number of bits:

BPF_F_BLOOM_NR_HASH_OFF = 13,
BPF_F_BLOOM_NR_HASH_CNT = 4,

So that in BPF map definiton in BPF program we could do

struct {
    __uint(type, BPF_MAP_TYPE_BLOOM_FILTER),
    ...
    __uint(map_flags, 5 << BPF_F_BLOOM_NR_HASH_OFF),
};

It's still quite ugly, but given it's unlikely to be used very
frequently, might be ok.


[...]

> +
> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
> +{
> +       struct bpf_bloom_filter *bloom_filter =
> +               container_of(map, struct bpf_bloom_filter, map);
> +       u32 hash;
> +       u8 i;
> +
> +       for (i = 0; i < bloom_filter->nr_hashes; i++) {
> +               if (bloom_filter->aligned_u32_count)
> +                       hash = jhash2(value, bloom_filter->aligned_u32_count,
> +                                     bloom_filter->hash_seed + i) &
> +                               bloom_filter->bit_array_mask;
> +               else
> +                       hash = jhash(value, map->value_size,
> +                                    bloom_filter->hash_seed + i) &
> +                               bloom_filter->bit_array_mask;

this looks like a good candidate for helper function used in at least two places

> +
> +               if (!test_bit(hash, bloom_filter->bit_array))
> +                       return -ENOENT;
> +       }
> +
> +       return 0;
> +}
> +

[...]
