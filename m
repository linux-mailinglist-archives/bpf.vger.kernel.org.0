Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565E23FE8A9
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhIBFM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 01:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIBFM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 01:12:26 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8AC061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 22:11:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m11so922761ioo.6
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LBwWRPQ4C0hGprjtRzGgHQH6oQjM90TXh3VUMZUu47g=;
        b=TNzFshL/obDJlzHI8wTP7301VCopYeHRx4efyuQCh37zBggg+6n5UOMNQoYopbUlKk
         05Ue6a2qOi0bGlIo9T4mYPzu6otY23kyGYE/zO7DBDPDIwAbWZnFBfdJ8/fH/kkZuqf6
         bhJgf6ggQaXH9sRs94S8StJOdeh20/Ti6Ah8AibFAe6JBA0Jl4/wgoiezJpzxJHOMKsp
         pxEUtbX665i2CLA21LwgN1XZQM2zvP2Odgs1o7h0NAvJEWN0JUnW5jiLK+2RkEFga96s
         pQevevygyyPrHc0M4VIB1Wy/gcho8UqwmPoexkzvVK5TjSnYujP7i7lGgSPQ1azdSr/X
         rR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LBwWRPQ4C0hGprjtRzGgHQH6oQjM90TXh3VUMZUu47g=;
        b=kUxyrfBeB1GwFSydquoEIpKD6IxR4VM8DgcuIZzvXu24Nk/m1XOYEd+S26776rqx5a
         VcdE0ab88wd2QFSNrO3m7wHbfpWDJe2spS/q1cQaPncQNLhMtYswm1D6YQXEq85dsN53
         dWXwrMJamaEZphj7YuHLq3qFEtNn9PaKdEXCpzKUe5ULdBYGKIhAy8dk33ONxndDKbUH
         PCFay+bkP1L62br5dlDkjuN71pHi6pJJx0TL/4YT9m6nA1mqUPXfk/8CoqPglytvsqg4
         BYSSXUgRphY9vmJfNkJsEJ1R+eFOSeR+MXKzkAige0B0TqfiTAzuew+tNGDa9WfHCi7/
         WOjQ==
X-Gm-Message-State: AOAM533ltG1QrY9FMgkmqR2/71RouoR0DxV78DOsQVYEGhsanaYR+BMJ
        FirfkwHdLREbfM9p51sTA30=
X-Google-Smtp-Source: ABdhPJzHxswfhT+mi+CA8d3NiSyLMzcTy8p5nkzBzSIxeUSlUFUOzDQLY2j/EOOboO9sykxcDG314g==
X-Received: by 2002:a02:b605:: with SMTP id h5mr1288934jam.119.1630559487455;
        Wed, 01 Sep 2021 22:11:27 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id g12sm433894iok.32.2021.09.01.22.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 22:11:27 -0700 (PDT)
Date:   Wed, 01 Sep 2021 22:11:20 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Message-ID: <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Tue, Aug 31, 2021 at 3:51 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
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
> >
> > The number of hashes to use for the bloom filter is configurable from
> > userspace. The benchmarks later in this patchset can help compare the
> > performances of different number of hashes on different entry
> > sizes. In general, using more hashes decreases the speed of a lookup,
> > but increases the false positive rate of an element being detected in the
> > bloom filter.
> >
> > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > ---
> 
> This looks nice and simple. I left a few comments below.
> 
> But one high-level point I wanted to discuss was that bloom filter
> logic is actually simple enough to be implementable by pure BPF
> program logic. The only problematic part is generic hashing of a piece
> of memory. Regardless of implementing bloom filter as kernel-provided
> BPF map or implementing it with custom BPF program logic, having BPF
> helper for hashing a piece of memory seems extremely useful and very
> generic. I can't recall if we ever discussed adding such helpers, but
> maybe we should?

Aha started typing the same thing :)

Adding generic hash helper has been on my todo list and close to the top
now. The use case is hashing data from skb payloads and such from kprobe
and sockmap side. I'm happy to work on it as soon as possible if no one
else picks it up.

> 
> It would be a really interesting experiment to implement the same
> logic in pure BPF logic and run it as another benchmark, along the
> Bloom filter map. BPF has both spinlock and atomic operation, so we
> can compare and contrast. We only miss hashing BPF helper.

The one issue I've found writing a hash logic is its a bit tricky
to get the verifier to consume it. Especially when the hash is nested
inside a for loop and sometimes a couple for loops so you end up with
things like,

 for (i = 0; i < someTlvs; i++) {
  for (j = 0; j < someKeys; i++) {
    ...
    bpf_hash(someValue)
    ...
 }

I've find small seemingly unrelated changes cause the complexity limit
to explode. Usually we can work around it with code to get pruning
points and such, but its a bit ugly. Perhaps this means we need
to dive into details of why the complexity explodes, but I've not
got to it yet. The todo list is long.

> 
> Being able to do this in pure BPF code has a bunch of advantages.
> Depending on specific application, users can decide to:
>   - speed up the operation by ditching spinlock or atomic operation,
> if the logic allows to lose some bit updates;
>   - decide on optimal size, which might not be a power of 2, depending
> on memory vs CPU trade of in any particular case;
>   - it's also possible to implement a more general Counting Bloom
> filter, all without modifying the kernel.

Also it means no call and if you build it on top of an array
map of size 1 its just a load. Could this be a performance win for
example a Bloom filter in XDP for DDOS? Maybe. Not sure if the program
would be complex enough a call might be in the noise. I don't know.

> 
> We could go further, and start implementing other simple data
> structures relying on hashing, like HyperLogLog. And all with no
> kernel modifications. Map-in-map is no issue as well, because there is
> a choice of using either fixed global data arrays for maximum
> performance, or using BPF_MAP_TYPE_ARRAY maps that can go inside
> map-in-map.

We've been doing most of our array maps as single entry arrays
at this point and just calculating offsets directly in BPF. Same
for some simple hashing algorithms.

> 
> Basically, regardless of having this map in the kernel or not, let's
> have a "universal" hashing function as a BPF helper as well.

Yes please!

> 
> Thoughts?

I like it, but not the bloom filter expert here.

> 
> >  include/linux/bpf.h            |   3 +-
> >  include/linux/bpf_types.h      |   1 +
> >  include/uapi/linux/bpf.h       |   3 +
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/bloom_filter.c      | 171 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/syscall.c           |  20 +++-
> >  kernel/bpf/verifier.c          |  19 +++-
> >  tools/include/uapi/linux/bpf.h |   3 +
> >  8 files changed, 214 insertions(+), 8 deletions(-)
> >  create mode 100644 kernel/bpf/bloom_filter.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f4c16f19f83e..2abaa1052096 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -181,7 +181,8 @@ struct bpf_map {
> >         u32 btf_vmlinux_value_type_id;
> >         bool bypass_spec_v1;
> >         bool frozen; /* write-once; write-protected by freeze_mutex */
> > -       /* 22 bytes hole */
> > +       u32 nr_hashes; /* used for bloom filter maps */
> > +       /* 18 bytes hole */
> >
> >         /* The 3rd and 4th cacheline with misc members to avoid false sharing
> >          * particularly with refcounting.
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index 9c81724e4b98..c4424ac2fa02 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
> >  #endif
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
> >
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 791f31dd0abe..c2acb0a510fe 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -906,6 +906,7 @@ enum bpf_map_type {
> >         BPF_MAP_TYPE_RINGBUF,
> >         BPF_MAP_TYPE_INODE_STORAGE,
> >         BPF_MAP_TYPE_TASK_STORAGE,
> > +       BPF_MAP_TYPE_BLOOM_FILTER,
> >  };
> >
> >  /* Note that tracing related programs such as
> > @@ -1274,6 +1275,7 @@ union bpf_attr {
> >                                                    * struct stored as the
> >                                                    * map value
> >                                                    */
> > +               __u32   nr_hashes;      /* used for configuring bloom filter maps */
> 
> This feels like a bit too one-off property that won't be ever reused
> by any other type of map. Also consider that we should probably limit
> nr_hashes to some pretty small sane value (<16? <64?) to prevent easy
> DOS from inside BPF programs (e.g., set nr_hash to 2bln, each
> operation is now extremely slow and CPU intensive). So with that,
> maybe let's provide number of hashes as part of map_flags? And as
> Alexei proposed, zero would mean some recommended value (2 or 3,
> right?). This would also mean that libbpf won't need to know about
> one-off map property in parsing BTF map definitions.
> 
> >         };
> >
> >         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> > @@ -5594,6 +5596,7 @@ struct bpf_map_info {
> >         __u32 btf_id;
> >         __u32 btf_key_type_id;
> >         __u32 btf_value_type_id;
> > +       __u32 nr_hashes; /* used for bloom filter maps */
> >  } __attribute__((aligned(8)));
> >
> >  struct bpf_btf_info {
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 7f33098ca63f..cf6ca339f3cd 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -7,7 +7,7 @@ endif
> >  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
> >
> >  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> > -obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
> > +obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> >  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> >  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> >  obj-${CONFIG_BPF_LSM}    += bpf_inode_storage.o
> > diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> > new file mode 100644
> > index 000000000000..3ae799ab3747
> > --- /dev/null
> > +++ b/kernel/bpf/bloom_filter.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2021 Facebook */
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/bpf.h>
> > +#include <linux/err.h>
> > +#include <linux/jhash.h>
> > +#include <linux/random.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define BLOOM_FILTER_CREATE_FLAG_MASK \
> > +       (BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
> > +
> > +struct bpf_bloom_filter {
> > +       struct bpf_map map;
> > +       u32 bit_array_mask;
> > +       u32 hash_seed;
> > +       /* Used for synchronizing parallel writes to the bit array */
> > +       spinlock_t spinlock;
> > +       unsigned long bit_array[];
> > +};
> > +
> > +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
> > +{
> > +       struct bpf_bloom_filter *bloom_filter =
> > +               container_of(map, struct bpf_bloom_filter, map);
> > +       u32 i, hash;
> > +
> > +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
> > +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
> > +                       bloom_filter->bit_array_mask;
> > +               if (!test_bit(hash, bloom_filter->bit_array))
> > +                       return -ENOENT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
> > +{
> > +       int numa_node = bpf_map_attr_numa_node(attr);
> > +       u32 nr_bits, bit_array_bytes, bit_array_mask;
> > +       struct bpf_bloom_filter *bloom_filter;
> > +
> > +       if (!bpf_capable())
> > +               return ERR_PTR(-EPERM);
> > +
> > +       if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
> > +           attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
> > +           !bpf_map_flags_access_ok(attr->map_flags))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       /* For the bloom filter, the optimal bit array size that minimizes the
> > +        * false positive probability is n * k / ln(2) where n is the number of
> > +        * expected entries in the bloom filter and k is the number of hash
> > +        * functions. We use 7 / 5 to approximate 1 / ln(2).
> > +        *
> > +        * We round this up to the nearest power of two to enable more efficient
> > +        * hashing using bitmasks. The bitmask will be the bit array size - 1.
> > +        *
> > +        * If this overflows a u32, the bit array size will have 2^32 (4
> > +        * GB) bits.

Would it be better to return E2BIG or EINVAL here? Speculating a bit, but if I was
a user I might want to know that the number of bits I pushed down is not the actual
number?

Another thought, would it be simpler to let user do this calculation and just let
max_elements be number of bits they want? Then we could have examples with the
above comment. Just a thought...

> > +        */
> > +       if (unlikely(check_mul_overflow(attr->max_entries, attr->nr_hashes, &nr_bits)) ||
> > +           unlikely(check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits)) ||
> > +           unlikely(nr_bits > (1UL << 31))) {
> 
> nit: map_alloc is not performance-critical (because it's infrequent),
> so unlikely() are probably unnecessary?
> 
> > +               /* The bit array size is 2^32 bits but to avoid overflowing the
> > +                * u32, we use BITS_TO_BYTES(U32_MAX), which will round up to the
> > +                * equivalent number of bytes
> > +                */
> > +               bit_array_bytes = BITS_TO_BYTES(U32_MAX);
> > +               bit_array_mask = U32_MAX;
> > +       } else {
> > +               if (nr_bits <= BITS_PER_LONG)
> > +                       nr_bits = BITS_PER_LONG;
> > +               else
> > +                       nr_bits = roundup_pow_of_two(nr_bits);
> > +               bit_array_bytes = BITS_TO_BYTES(nr_bits);
> > +               bit_array_mask = nr_bits - 1;
> > +       }
> > +
> > +       bit_array_bytes = roundup(bit_array_bytes, sizeof(unsigned long));
> > +       bloom_filter = bpf_map_area_alloc(sizeof(*bloom_filter) + bit_array_bytes,
> > +                                         numa_node);
> > +
> > +       if (!bloom_filter)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       bpf_map_init_from_attr(&bloom_filter->map, attr);
> > +       bloom_filter->map.nr_hashes = attr->nr_hashes;
> > +
> > +       bloom_filter->bit_array_mask = bit_array_mask;
> > +       spin_lock_init(&bloom_filter->spinlock);
> > +
> > +       if (!(attr->map_flags & BPF_F_ZERO_SEED))
> > +               bloom_filter->hash_seed = get_random_int();
> > +
> > +       return &bloom_filter->map;
> > +}
> > +
> > +static void bloom_filter_map_free(struct bpf_map *map)
> > +{
> > +       struct bpf_bloom_filter *bloom_filter =
> > +               container_of(map, struct bpf_bloom_filter, map);
> > +
> > +       bpf_map_area_free(bloom_filter);
> > +}
> > +
> > +static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
> > +                                     u64 flags)
> > +{
> > +       struct bpf_bloom_filter *bloom_filter =
> > +               container_of(map, struct bpf_bloom_filter, map);
> > +       unsigned long spinlock_flags;
> > +       u32 i, hash;
> > +
> > +       if (flags != BPF_ANY)
> > +               return -EINVAL;
> > +
> > +       spin_lock_irqsave(&bloom_filter->spinlock, spinlock_flags);
> > +
> 
> If value_size is pretty big, hashing might take a noticeable amount of
> CPU, during which we'll be keeping spinlock. With what I said above
> about sane number of hashes, if we bound it to small reasonable number
> (e.g., 16), we can have a local 16-element array with hashes
> calculated before we take lock. That way spinlock will be held only
> for few bit flips.

+1. Anyways we are inside a RCU section here and the map shouldn't
disapper without a grace period so we can READ_ONCE the seed right?
Or are we thinking about sleepable programs here?

> Also, I wonder if ditching spinlock in favor of atomic bit set
> operation would improve performance in typical scenarios. Seems like
> set_bit() is an atomic operation, so it should be easy to test. Do you
> mind running benchmarks with spinlock and with set_bit()?

With the jhash pulled out of lock, I think it might be noticable. Curious
to see.

>
> > +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
> > +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
> > +                       bloom_filter->bit_array_mask;
> > +               bitmap_set(bloom_filter->bit_array, hash, 1);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
> > +
> > +       return 0;
> > +}
> > +
> 
> [...]


