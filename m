Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4D416738
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbhIWVOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbhIWVOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 17:14:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE66C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 14:13:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i84so1213772ybc.12
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Df8pA8kia5cmEeGGzGVHzmcQwrV22YA13uKW5lgmms=;
        b=MUuncAaXCA2QDAReaz2vCG9GJqxBhuvYroXcx3jc0snybcVlYXJ/68V6rtcE6Zm+Hw
         Q+dqIz97PqPuU/yPRY/rBzHF0J/yl27IAXeqMe8eLq/DoxjmuV6yiWH0BdvngDGozNdS
         N9MZsI49hiiMnNFoSb6R2zhC3m4DNe2UAG5z03oJ5Of5TLE8JfThj3jIS/tWHQejUsMY
         yb7KGxzG5PfEhnhdFgeohaouyGBvBk+SYAkt1fpmi8ONgkZGVqbPmPOFf1J0PgRTWMpt
         PvYPZW53BMGClG94KdXxfQyViSy2D/RNV8Ua7T+9z9q92EBmGTg3Kro1O1s38R61zEiJ
         geCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Df8pA8kia5cmEeGGzGVHzmcQwrV22YA13uKW5lgmms=;
        b=H8nhbW8HDEcH/ySdgOMThUAptQDiIBhtS7vJyFttz89Cpvw/uWhbWbqiblLpXcJQEQ
         vffPXMTZsn4268GpAO1CtJ4i/Wa5iJ7sV569OBD1Qld3msxGhy6cjro9p2LvApSKL/Pi
         VTHWEdXZQLRKvZV2lYuC2FT8jyYj8gKqfrD3hOjGsuPsKOTwjrec+OpWTDIbxXxBnugx
         qUk3G2HnP2elThCy3L4J4rvsMGB9GX3jJrmbqJGJbvwOfB3htPa19aaawOyFDSD5W3/l
         +1gRalYhc4HIpmZf0xYr1Y6feL0q4MQ/+u5KsMczjwAyYid6g8uqzzzGiDhN9F8k3yeN
         T0ug==
X-Gm-Message-State: AOAM533dRuVv3jaJcnV1HU0ry/B/yP6rZNA/gCUFJmqvqWhl9E0Bt573
        gxANXLlSF6JKpyhqXMggZPK7R+UaTsbcQko29eDFD7onGH4=
X-Google-Smtp-Source: ABdhPJyaBgo7mMQEaVUW9rlPxUvpHTFZ2OK9YR4nZPgfF4UQye5ZeXD+RP2e0yGcjSPFfG3jaM4R6zdb97PnJxpC7G4=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr8747453yba.225.1632431580038;
 Thu, 23 Sep 2021 14:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-2-joannekoong@fb.com> <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com> <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp> <20210923203046.a3fsogdl37mw56kp@ast-mbp>
In-Reply-To: <20210923203046.a3fsogdl37mw56kp@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Sep 2021 14:12:48 -0700
Message-ID: <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Joanne Koong <joannekoong@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 1:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 12:42:33PM -0700, Martin KaFai Lau wrote:
> >
> > How to move it forward from here?  Is it a must to keep the
> > bloomfilter-like map in pure bpf only and we should stop
> > the current work?
> >
> > or it is useful to have the kernel bloom filter that provides
> > a get-and-go usage and a consistent experience for user in
> > map-in-map which is the primary use case here.  I don't think
> > this is necessarily blocking the custom bpf map effort also.
>
> I think map based and helper based bloom filter implementations
> are far from equivalent. There are pros and cons to both.
> For example the helper style doesn't have a good way
> of query/populate from the user space. If it's a single element

I thought about the use from user-space. I'd consider two ways of
doing that. One more complicated but with better performance, another
simpler but less performant (but in this case less performant is
equivalent to in-kernel implementation performance, or still better):

1. Have identical hash function implementation in user-space. In this
case Jenkins hash. Then memory-map contents and use exactly the same
bloom filter code to set the bits (as I said, once you have hash, it's
just a glorified bitset). This has the downside that if there is even
a single bit difference between hash produced by kernel and
user-space, you are screwed. But can't beat the performance because no
syscall overhead.

2. Use BPF_PROG_RUN command to execute custom program that would set
one or multiple provided values in the hashset. Just like we argued
for BPF timers, BPF program can be a custom "API" that would avoid
having separate user-space logic. Pass one or many values through a
global variable/array, BPF_PROG_RUN program that would iterate values,
calculate hashes, set bits. It actually should be faster than doing
BPF_MAP_UPDATE_ELEM syscall for each value. Next proposal will be to
add batched update support, of course, so I won't claim victory for
the performance argument here. :)

But yes, it needs a bit more (but simple) code, than if the kernel
just provided a Bloom filter map out of the box.

> array the user space would be forced to allocate huge buffers
> just to read/write single huge value_size.
> With multi element array it's sort-of easier.
> mmap-ing the array could help too,
> but in either case the user space would need to copy-paste jhash,
> which is GPL, and that might be more than just inconvenience.

From include/linux/jhash.h: "You can use this free for any purpose.
It's in the public domain".

> We can try siphash in the bpf helper and give it a flag to choose

I did bpf_jhash_mem() just to demonstrate the approach quickly. I
think in practice I'd go for a more generic implementation where one
of the parameters is enum that specifies which supported hash
algorithm is used. It's easier to extend that:

u64 bpf_hash_mem(const void *data, u32 sz, u32 seed, enum bpf_hash_algo algo);

enum bpf_hash_algo {
   XOR = 0,
   JENKINS = 1,
   MURMUR3 = 2,
   ...
}

Note the XOR case. If we specify it as "xor u64 values, where the last
<8 bytes are zero extended", it will come useful below for your
proposal.


> between hash implementations. That helps, but doesn't completely
> makes them equivalent.

I don't claim that implementing and using a custom Bloom filter will
be easier to use in all situations. I think the best we can strive for
is making it not much harder, and I think in this case it is. Of
course we can come up with a bunch of situations where doing it with
pure BPF isn't possible to do equivalently (like map-in-map with
dynamically sized bit size, well, sorry, BPF verifier can't validate
stuff like that). Dedicated BPF map or helper (as a general case, not
just this one) will pretty much always going to be easier to use just
because it's a dedicated and tailored API.


>
> As far as map based bloom filter I think it can combine bitset
> and bloomfilter features into one. delete_elem from user space
> can be mapped into pop() to clear bits.
> Some special value of nr_hashes could mean that no hashing
> is applied and 4 or 8 byte key gets modulo of max_entries
> and treated as a bit index. Both bpf prog and user space will
> have uniform access into such bitset. With nr_hashes >= 1
> it will become a bloom filter.
> In that sense may be max_entries should be specified in bits
> and the map is called bitset. With nr_hashes >= 1 the kernel
> would accept key_size > 8 and convert it to bloom filter
> peek/pop/push. In other words
> nr_hash == 0 bit_idx == key for set/read/clear
> nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
> If we could teach the verifier to inline the bit lookup
> we potentially can get rid of bloomfilter loop inside the peek().
> Then the map would be true bitset without bloomfilter quirks.
> Even in such case it's not equivalent to bpf_hash(mem_ptr, size, flags) helper.
> Thoughts?

Sounds a bit complicated from end-user's perspective, tbh, but bitset
map (with generalization for bloom filter) sounds a bit more widely
useful. See above for the bpf_hash_algo proposal. If we allow to
specify nr_hashes and hash algorithm, then with XOR as defined above
and nr_hash = 1, you'll get just bitset behavior with not extra
restrictions on key size: you could have 1, 2, 4, 8 and more bytes
(where with more bytes it's some suboptimal bloom filter with one hash
function, not sure why you'd do that).

The biggest quirk is defining that XOR hashes in chunks of 8 bytes
(with zero-extending anything that is not a multiple of 8 bytes
length). We can do special "only 1, 2, 4, and 8 bytes are supported",
of course, but it will be special-cased internally. Not sure which one
is cleaner.

While writing this, another thought was to have a "NOOP" (or
"IDENTITY") hash, where we say that we treat bytes as one huge number.
Obviously then we truncate to the actual bitmap size, which just
basically means "use up to lower 8 bytes as a number". But it sucks
for big-endian, because to make it sane we'd need to take last "up to
8 bytes", which obviously sounds convoluted. So I don't know, just a
thought.

If we do the map, though, regardless if it's bitset or bloom
specifically. Maybe we should consider modeling as actual
bpf_map_lookup_elem(), where the key is a pointer to whatever we are
hashing and looking up? It makes much more sense, that's how people
model sets based on maps: key is the element you are looking up, value
is either true/false or meaningless (at least for me it felt much more
natural that you are looking up by key, not by value). In this case,
what if on successful lookup we return a pointer to some fixed
u8/u32/u64 location in the kernel, some dedicated static variable
shared between all maps. So NULL means "element is not in a set",
non-NULL means it is in the set. Ideally we'd prevent such element to
be written to, but it might be too hard to do that as just one
exception here, don't know.
