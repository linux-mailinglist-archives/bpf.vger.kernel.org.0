Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDEA429BD6
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhJLDTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDTt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:19:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487CFC061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:17:48 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id d131so43542497ybd.5
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RBk23ij5AVzmMpFqPM3b8WHu01WexSRJcFMEd4U2rcA=;
        b=FyO4xieYGo2P6VjByrQIIl3J3lSYBmps2udq4thGf84ryCDNPggyvLbi36DmHe0T4a
         vStysyiQy2qnmPmlrC2htzbjW5a6qc6bB+59TlATHkLWuYHR1Smq8XID+3HF7Zozzizo
         nKVYr08OlTE5ILE3vqY37tEf/mR3CzC5y35P42FNVlycTaNP01nqk3ZtjI/jBmE1D3em
         7Za5fNQGV87ZV6RYtExqUC36g4Y6DyROalsrrbYL+t3BD8d1BJ1VBO7vkUfKAmbtaxVK
         CZbzVYCtiwg21fez2/Urper5LV6kMUb2gktxYasNRT9kJ9j8dh1kOuuxwpdXBNpvp+v8
         VIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RBk23ij5AVzmMpFqPM3b8WHu01WexSRJcFMEd4U2rcA=;
        b=66AyQzLoD4bOmJB6eyTZVW7cj3gcVwfRYMc3UNuzNm5hKm7JboWTjlM0kslmnZO7Nx
         7+JI9iNkKLGTF7u6IZMdXgnab1icfvF0OkmvCDI4siEQLWUwcX8I7+FoKqg5h8oiRH3u
         W9LQFFOGeHGSfd8itQjc1upVCUn+7IFc5Fx1D0s4IWh6gtuItm+aFb+/jmmjjDKnlfs6
         AkwwKuu4AvwYrBYvHu1nGSDX1MayEgC4tfsLQnpGdPVF3gjExbPdvtSnIoQa4u/sMZvr
         TkJwB9NYtqGF8m/d8vwWJ6JWn1kwjrpfgPx/xhDcvlP2usdJAA4Z47dRWnO1eJyBvzq2
         6AxA==
X-Gm-Message-State: AOAM532Aw4E8UIYKjWkoiCQWSW5O5ohr5Ho5LPoAFHk8RCXEUn2biDFr
        /2r2A++nHEslUll/VPTURqFGLXrTrcWrtGdC6A4=
X-Google-Smtp-Source: ABdhPJzGa0yJYV9NAJM8Jj3nSkd1Fq0sK5ZJDgTxOPRcJOKkK5riGcKItg8c0/jr8CyVuLlVei1ngQMMThHTLgZzqLs=
X-Received: by 2002:a25:5606:: with SMTP id k6mr25399666ybb.51.1634008667335;
 Mon, 11 Oct 2021 20:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
 <87k0ioncgz.fsf@toke.dk> <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
 <87o87zji2a.fsf@toke.dk> <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
In-Reply-To: <87czoejqcv.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:17:36 +0200
Message-ID: <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 9, 2021 at 3:10 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Oct 8, 2021 at 2:58 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Joanne Koong <joannekoong@fb.com> writes:
> >>
> >> > On 10/7/21 7:20 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >
> >> >> Joanne Koong <joannekoong@fb.com> writes:
> >> >>
> >> >>> This patch adds the kernel-side changes for the implementation of
> >> >>> a bitset map with bloom filter capabilities.
> >> >>>
> >> >>> The bitset map does not have keys, only values since it is a
> >> >>> non-associative data type. When the bitset map is created, it must
> >> >>> be created with a key_size of 0, and the max_entries value should =
be the
> >> >>> desired size of the bitset, in number of bits.
> >> >>>
> >> >>> The bitset map supports peek (determining whether a bit is set in =
the
> >> >>> map), push (setting a bit in the map), and pop (clearing a bit in =
the
> >> >>> map) operations. These operations are exposed to userspace applica=
tions
> >> >>> through the already existing syscalls in the following way:
> >> >>>
> >> >>> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> >> >>> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> >> >>> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
> >> >>>
> >> >>> For updates, the user will pass in a NULL key and the index of the
> >> >>> bit to set in the bitmap as the value. For lookups, the user will =
pass
> >> >>> in the index of the bit to check as the value. If the bit is set, =
0
> >> >>> will be returned, else -ENOENT. For clearing the bit, the user wil=
l pass
> >> >>> in the index of the bit to clear as the value.
> >> >> This is interesting, and I can see other uses of such a data struct=
ure.
> >> >> However, a couple of questions (talking mostly about the 'raw' bitm=
ap
> >> >> without the bloom filter enabled):
> >> >>
> >> >> - How are you envisioning synchronisation to work? The code is usin=
g the
> >> >>    atomic set_bit() operation, but there's no test_and_{set,clear}_=
bit().
> >> >>    Any thoughts on how users would do this?
> >> > I was thinking for users who are doing concurrent lookups + updates,
> >> > they are responsible for synchronizing the operations through mutexe=
s.
> >> > Do you think this makes sense / is reasonable?
> >>
> >> Right, that is an option, of course, but it's a bit heavyweight. Atomi=
c
> >> bitops are a nice light-weight synchronisation primitive.
> >>
> >> Hmm, looking at your code again, you're already using
> >> test_and_clear_bit() in pop_elem(). So why not just mirror that to
> >> test_and_set_bit() in push_elem(), and change the returns to EEXIST an=
d
> >> ENOENT if trying to set or clear a bit that is already set or cleared
> >> (respectively)?
> >>
> >> >> - It would be useful to expose the "find first set (ffs)" operation=
 of
> >> >>    the bitmap as well. This can be added later, but thinking about =
the
> >> >>    API from the start would be good to avoid having to add a whole
> >> >>    separate helper for this. My immediate thought is to reserve pee=
k(-1)
> >> >>    for this use - WDYT?
> >> > I think using peek(-1) for "find first set" sounds like a great idea=
!
> >>
> >> Awesome!
> >
> > What's the intended use case for such an operation?
>
> The 'find first set' operation is a single instruction on common
> architectures, so it's an efficient way of finding the first non-empty
> bucket if you index them in a bitmap; sch_qfq uses this, for instance.

There is also extremely useful popcnt() instruction, would be great to
have that as well. There is also fls() (find largest set bit), it is
used extensively throughout the kernel. If we'd like to take this ad
absurdum, there are a lot of useful operations defined in
include/linux/bitops.h and include/linux/bitmap.h, I'm pretty sure one
can come up with a use case for every one of those.

The question is whether we should bloat the kernel with such helpers/operat=
ions?

I still think that we don't need a dedicated BITSET map. I'm not
talking about Bloom filters here, mind you. With the Bloom filter I
can't (in principle) beat the performance aspect, so I stopped trying
to argue against that. But for BITSET map, there is next to zero
reason (in my view) to have it as a dedicated map vs just implementing
it as an ARRAY map. Or even, for cases where it's feasible, as a
global variable array (avoiding BPF helper calls completely). Any
bitset operation is literally one bpf_map_lookup_elem() helper call
and one logical and/or/xor operation. And you can choose whether it
has to be atomic or not. And you don't even have to do power-of-2
sizing, if you don't want to (but your life will be a bit harder to
prove stuff to the BPF verifier).

Further, if one implements BITSET as just an ARRAY of u64s (for
example), you get all the power of bpf_for_each_map_elem() and you can
implement finding first unset bit, last unset bit, and anything in
between. All using already existing primitives. Yes, there is a
callback overhead, but with your custom ARRAY, you can optimize
further by using something bigger than u64 as a "building block" of
your ARRAY. E.g., you can have u64[8], and reduce the number of
necessary callbacks by 8. But we are getting way too far ahead. My
claim is that ARRAY is better than BITSET map and doesn't lose in
performance (still one BPF helper call for basic operations).

I'd love to hear specific arguments in favor of dedicated BITSET, though.

>
> > But also searching just a first set bit is non completely generic, I'd
> > imagine that in practice (at least judging from bit operations done on
> > u64s I've seen in the wild) you'd most likely need "first set bit
> > after bit N", so peek(-N)?..
>
> You're right as far as generality goes, but for my use case "after bit
> N" is not so important (you enqueue into different buckets and always
> need to find the lowest one. But there could be other use cases for
> "find first set after N", of course. If using -N the parameter would
> have to change to explicitly signed, of course, but that's fine by me :)
>
> > I think it's an overkill to provide something like this, but even if
> > we do, wouldn't BPF_MAP_GET_NEXT_KEY (except we now say it's a
> > "value", not a "key", but that's nitpicking) be a sort of natural
> > extension to provide this? Though it might be only available to
> > user-space right?
>
> Yeah, thought about get_next_key() but as you say that doesn't work from
> BPF. It would make sense to *also* expose this to userspace through
> get_next_key(), though.
>
> > Oh, and it won't work in Bloom filter "mode", right?
>
> I expect not? But we could just return -EINVAL in that case?
>
> -Toke
>
