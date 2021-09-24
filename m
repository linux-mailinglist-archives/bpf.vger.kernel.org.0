Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A054169FB
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbhIXCZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhIXCZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 22:25:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2AC061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:23:35 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z5so2526396ybj.2
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rHuxa/LB6xmq0CDQxqCz/OTr7mYnTBucgzfZnO/O+I=;
        b=IIJooInHzKP/pDfBT4xUyEQt/BRctm8lW/xQueMmwC3PQaKQCRyRCqR9lMnZS8y5Qx
         94whgaFxQwD+CkhQZy1PluUp9imX3fYNAh2o3zHFhqmmqeFfqPHSFDi/KHcSss7ZzH7O
         SuwF24uAa/jhJWVwCr5lc6uPqv760S6+rgOTpbMgXgXkphqm6kSbmWRL7Whr27VFNrdA
         SB9jz+Wxb31Z5xovFd/pH6DU+PDELiApSBZnCuoqLg7AzrlaiD+4Ibn3j7o4gEjVBUfK
         1B3zHqXpGzDhE0rddHVh9jqnXqvcqKEwmxbGhQTyUQ6hV0S9rbckcK1cUl2Z0zBamev8
         YT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rHuxa/LB6xmq0CDQxqCz/OTr7mYnTBucgzfZnO/O+I=;
        b=ej0FG8II1pnJfD8ZErOfr1t+skZBbnZo+ncHd6mQNZdKq1RXIbNKLpORUNpuH75Pzv
         Lz8cbKQ2vtsqW8jkgTWi/kVpck20Mvd0UEFELc8bnq7224d09LHwrvx/JvWBnIdiRGIT
         0ZdCTGZOIAhICNuQcFDveJ0yfnZShW3VuJydThHadHpoJQ+83DUxJFkbH0Xf0obxNQ6F
         4h4hMXUOmzgE2OoFcc3jvxJr6z1XWAi/jbfIVo6cjle6/o1z0vR24j0F9qaHxbh3lpnE
         Jns4RlciztFADKG0xreCZpe7D406xb+vQEkmIi/Wfdj050WY38z+hz7J+g7mrbRRRlA7
         uFJQ==
X-Gm-Message-State: AOAM531Dfp2iQ9N9NSSZZXl1YOOI+ayPscq8iTYK0TEGtO2dz5TPStdF
        5MonLNmyHXBqv4pOky+uZpC434YSKiy/+Z+oKDk=
X-Google-Smtp-Source: ABdhPJxTVT0X6QuwYCJOePFkXtQWfKuB7j1CsNhJjbW5wlnf2y1h+YEl9FRVmRhy3ix2N93Rckf8f7fhISUKtVlimLs=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr9705862ybb.267.1632450214100;
 Thu, 23 Sep 2021 19:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-2-joannekoong@fb.com> <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com> <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp> <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com> <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
In-Reply-To: <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Sep 2021 19:23:23 -0700
Message-ID: <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 3:28 PM Joanne Koong <joannekoong@fb.com> wrote:
>
>
> On 9/23/21 2:12 PM, Andrii Nakryiko wrote:
> > On Thu, Sep 23, 2021 at 1:30 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Thu, Sep 23, 2021 at 12:42:33PM -0700, Martin KaFai Lau wrote:
> >>> How to move it forward from here?  Is it a must to keep the
> >>> bloomfilter-like map in pure bpf only and we should stop
> >>> the current work?
> >>>
> >>> or it is useful to have the kernel bloom filter that provides
> >>> a get-and-go usage and a consistent experience for user in
> >>> map-in-map which is the primary use case here.  I don't think
> >>> this is necessarily blocking the custom bpf map effort also.
> >> I think map based and helper based bloom filter implementations
> >> are far from equivalent. There are pros and cons to both.
> >> For example the helper style doesn't have a good way
> >> of query/populate from the user space. If it's a single element
> > I thought about the use from user-space. I'd consider two ways of
> > doing that. One more complicated but with better performance, another
> > simpler but less performant (but in this case less performant is
> > equivalent to in-kernel implementation performance, or still better):
> >
> > 1. Have identical hash function implementation in user-space. In this
> > case Jenkins hash. Then memory-map contents and use exactly the same
> > bloom filter code to set the bits (as I said, once you have hash, it's
> > just a glorified bitset). This has the downside that if there is even
> > a single bit difference between hash produced by kernel and
> > user-space, you are screwed. But can't beat the performance because no
> > syscall overhead.
> >
> > 2. Use BPF_PROG_RUN command to execute custom program that would set
> > one or multiple provided values in the hashset. Just like we argued
> > for BPF timers, BPF program can be a custom "API" that would avoid
> > having separate user-space logic. Pass one or many values through a
> > global variable/array, BPF_PROG_RUN program that would iterate values,
> > calculate hashes, set bits. It actually should be faster than doing
> > BPF_MAP_UPDATE_ELEM syscall for each value. Next proposal will be to
> > add batched update support, of course, so I won't claim victory for
> > the performance argument here. :)
> >
> > But yes, it needs a bit more (but simple) code, than if the kernel
> > just provided a Bloom filter map out of the box.
> >
> >> array the user space would be forced to allocate huge buffers
> >> just to read/write single huge value_size.
> >> With multi element array it's sort-of easier.
> >> mmap-ing the array could help too,
> >> but in either case the user space would need to copy-paste jhash,
> >> which is GPL, and that might be more than just inconvenience.
> >  From include/linux/jhash.h: "You can use this free for any purpose.
> > It's in the public domain".
> >
> >> We can try siphash in the bpf helper and give it a flag to choose
> > I did bpf_jhash_mem() just to demonstrate the approach quickly. I
> > think in practice I'd go for a more generic implementation where one
> > of the parameters is enum that specifies which supported hash
> > algorithm is used. It's easier to extend that:
> >
> > u64 bpf_hash_mem(const void *data, u32 sz, u32 seed, enum bpf_hash_algo algo);
> >
> > enum bpf_hash_algo {
> >     XOR = 0,
> >     JENKINS = 1,
> >     MURMUR3 = 2,
> >     ...
> > }
> >
> > Note the XOR case. If we specify it as "xor u64 values, where the last
> > <8 bytes are zero extended", it will come useful below for your
> > proposal.
> >
> >
> >> between hash implementations. That helps, but doesn't completely
> >> makes them equivalent.
> > I don't claim that implementing and using a custom Bloom filter will
> > be easier to use in all situations. I think the best we can strive for
> > is making it not much harder, and I think in this case it is. Of
> > course we can come up with a bunch of situations where doing it with
> > pure BPF isn't possible to do equivalently (like map-in-map with
> > dynamically sized bit size, well, sorry, BPF verifier can't validate
> > stuff like that). Dedicated BPF map or helper (as a general case, not
> > just this one) will pretty much always going to be easier to use just
> > because it's a dedicated and tailored API.
> >
> To me, it seems like we get the best of both worlds by using both of these
> two ideas for the bloom filter. For developers who would like
> to use a general bloom filter without having to do any extra
> implementation work
> or having to understand how bloom filters are implemented, they could use
> the custom bloom filter map with minimal effort. For developers who
> would like to customize their bloom filter to something more specific or
> fine-tuned, they could use craft their own bloom filter in an ebpf program.
> To me, these two directions don't seem mutually exclusive.

They are not mutually exclusive, of course, but adding stuff to the
kernel has its maintenance costs.

>
> >> As far as map based bloom filter I think it can combine bitset
> >> and bloomfilter features into one. delete_elem from user space
> >> can be mapped into pop() to clear bits.
> >> Some special value of nr_hashes could mean that no hashing
> >> is applied and 4 or 8 byte key gets modulo of max_entries
> >> and treated as a bit index. Both bpf prog and user space will
> >> have uniform access into such bitset. With nr_hashes >= 1
> >> it will become a bloom filter.
> >> In that sense may be max_entries should be specified in bits
> >> and the map is called bitset. With nr_hashes >= 1 the kernel
> >> would accept key_size > 8 and convert it to bloom filter
> >> peek/pop/push. In other words
> >> nr_hash == 0 bit_idx == key for set/read/clear
> >> nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
> >> If we could teach the verifier to inline the bit lookup
> >> we potentially can get rid of bloomfilter loop inside the peek().
> >> Then the map would be true bitset without bloomfilter quirks.
> >> Even in such case it's not equivalent to bpf_hash(mem_ptr, size, flags) helper.
> >> Thoughts?
> This is an interesting suggestion; to me, it seems like the APIs and
> code would be
> more straightforward if the bitset and the bloom filter were separate maps.
> With having max_entries be specified in bits, I think this also relies
> on the
> user to make an educated call on the optimal number of bits to use for
> their bloom
> filter, instead of passing in the number of entries they expect to have
> and having the
> bit size automatically calculated according to a mathematically
> optimized equation.
> I am open to this idea though.

We can provide a macro that will calculate mathematically optimized
value based on desired number of unique entries and hash functions.
E.g.:

#define BPF_BLOOM_FILTER_BYTE_SZ(nr_uniq_entries, nr_hash_funcs)
(nr_uniq_entires * nr_hash_funcs / 5 * 7 / 8)

Kernel code can round up to closest power-of-two internally to make
this simpler. So if users don't care or don't know, they'll use
BPF_BPLOOM_FILTER_BYTE_SZ() macro, but if they know better, they'll
just specify desired amount of bytes.

>
> > Sounds a bit complicated from end-user's perspective, tbh, but bitset
> > map (with generalization for bloom filter) sounds a bit more widely
> > useful. See above for the bpf_hash_algo proposal. If we allow to
> > specify nr_hashes and hash algorithm, then with XOR as defined above
> > and nr_hash = 1, you'll get just bitset behavior with not extra
> > restrictions on key size: you could have 1, 2, 4, 8 and more bytes
> > (where with more bytes it's some suboptimal bloom filter with one hash
> > function, not sure why you'd do that).
> >
> > The biggest quirk is defining that XOR hashes in chunks of 8 bytes
> > (with zero-extending anything that is not a multiple of 8 bytes
> > length). We can do special "only 1, 2, 4, and 8 bytes are supported",
> > of course, but it will be special-cased internally. Not sure which one
> > is cleaner.
> >
> > While writing this, another thought was to have a "NOOP" (or
> > "IDENTITY") hash, where we say that we treat bytes as one huge number.
> > Obviously then we truncate to the actual bitmap size, which just
> > basically means "use up to lower 8 bytes as a number". But it sucks
> > for big-endian, because to make it sane we'd need to take last "up to
> > 8 bytes", which obviously sounds convoluted. So I don't know, just a
> > thought.
> >
> > If we do the map, though, regardless if it's bitset or bloom
> > specifically. Maybe we should consider modeling as actual
> > bpf_map_lookup_elem(), where the key is a pointer to whatever we are
> > hashing and looking up? It makes much more sense, that's how people
> > model sets based on maps: key is the element you are looking up, value
> > is either true/false or meaningless (at least for me it felt much more
> > natural that you are looking up by key, not by value). In this case,
> > what if on successful lookup we return a pointer to some fixed
> > u8/u32/u64 location in the kernel, some dedicated static variable
> > shared between all maps. So NULL means "element is not in a set",
> > non-NULL means it is in the set.
> I think this would then also require that the bpf_map_update_elem() API from
> the userspace side would have to pass in a valid memory address for the
> "value".
> I understand what you're saying though about it feeling more natural
> that the "key" is the element here; I agree but there doesn't seem to be
> a clean way
> of doing this - I think maybe one viable approach would be allowing
> map_update_elem
> to pass in a NULL value in the kernel if the map is a non-associative
> map, and refactoring the
> push_elem/peek_elem API so that the element can represent either the key
> or the value.

Yeah, we can allow value to be NULL (and key non-NULL). But why
push/peek if we are talking about using standard
lookup_elem/update_elem (and maybe even delete_elem which will reset
bits to 0)?

> >   Ideally we'd prevent such element to
> > be written to, but it might be too hard to do that as just one
> > exception here, don't know.

BTW, that nr_hash_funcs field in UAPI and in libbpf was still
bothering me. I'd feel better if we generalize this to future map
needs and make it generic. How about adding "u32 map_extra;" field to
UAPI (as a new field, so it's available for all maps, including
map-in-maps). The meaning of that field would be per-map-type extra
flags/values/etc. In this case we can define that map_extra for
BLOOM_FILTER it would encode number of hash functions. If we ok adding
hash function enum that I proposed for bpf_hash_mem() helper, we can
also include that into map_extra. We can reserve lower N bits for
number of hash functions and then next few bits would be reserved for
hash algo enum.

So then you'd define map (in libbpf syntax) pretty naturally as:

struct {
    __uint(type, BPF_MAP_TYPE_BLOOM_FILTER); /* or BITSET, don't know
which way this is going */
    ....
    __uint(map_extra, BPF_HASH_SHA256 | 3); /* 3 x SHA256 hash functions */
} my_bloom_filter SEC(".maps");

BPF_HASH_SHA256 would be defined as something like 0x{1,2,4,etc}0,
leaving lower 4 bits for nr_hash_funcs.

And then I'd have no problem supporting map_extra field for any map
definition, with bpf_map__map_extra() and bpf_map__set_map_extra()
getter/setter.

map_flags is different in that it's partially shared by all map types
(e.g., BPF_F_RDONLY_PROG, BPF_F_INNER_MAP, BPF_F_NUMA_NODE can be
specified for lots of different types).

Naming is obviously up for discussion.
