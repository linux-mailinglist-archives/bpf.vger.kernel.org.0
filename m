Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66221427409
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbhJHXN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:13:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97FC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 16:12:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id u32so24264043ybd.9
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iI7BP73Z2bkWhuODKZBQsKMreIFQbsAb8sf0l4EyPgM=;
        b=U77kXFwXGDuPu7aleFSFlMphNOPphPYRUYAuYCj27ajEcN3GTzhC+NfqNjwDyo0Tkh
         PlXpYn5EGDxBEa+cC5TCgr8X6xMT3LLZDMzbvNzNul8oO4Q2dQ6O8FFast7W/M/9LiXh
         H75EGm9dpCvTmpCubTKxRthpEFrpeB9fK63mbMa3uCWk4rKq9oZKEzVkBpVtxpNP8F+m
         fbs5+EQrNgdznV0V8Atgk98I0XAx//4oC81MnkBZLHCqoz5dVToQM5xHdxCgz+j0sinc
         EeWaOawn3bNAtt7T7hTfgllthqLoY0nZOO9cmamWdTAABZA3RI+A1Q0Lec+OobHWGDCo
         fEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iI7BP73Z2bkWhuODKZBQsKMreIFQbsAb8sf0l4EyPgM=;
        b=K8aXB/Mh5LSFQ8vlIQQhKp2tWQ43pjaj8YFvoguV89NYOFuTWngICvx2T8s7OBTL0S
         oq0KTs5vAP4+TRmQ1K4dgxMhgIeIMW/lERc1r7buyu+lixI9GKtCX7cemsRWQRvdNl0s
         cyAKhsX3ljSUy0MRjljM3/o72rOJew443muCTLOTgjPbsceSkrvO6Radv/Qn0MQNdF/h
         AUEFn8Jvkv52iQgYYwsT2rUBYeLVY6Wp55/aiWusWUqdWm4iEREHWjw8xbVydmm7oOOj
         aOcE8ceEfq9RTuLHfBdV9I27YzCiHtWCaO16ejci/uFS5huv3uruoY8v+yIW5A68mNDl
         nfOQ==
X-Gm-Message-State: AOAM531XUx4K40/aCslrMErsJjrTrdNa4lL5/C1BNGf7MQak3eVMH7rL
        JXlKXhBccRTxVtIXs1rNTYnY57MkaNhgcoZcBS4=
X-Google-Smtp-Source: ABdhPJwTgGNyfXp+AKDp+l62YIoopw89I5nQ+70pO+9Iy4wAasfG7bJklFaJ6YeCrtU9QZpcfdgYIT7ZbN8nwabJc0Q=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr6417380ybh.267.1633734720569;
 Fri, 08 Oct 2021 16:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
 <87k0ioncgz.fsf@toke.dk> <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
In-Reply-To: <87o87zji2a.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 16:11:49 -0700
Message-ID: <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 2:58 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Joanne Koong <joannekoong@fb.com> writes:
>
> > On 10/7/21 7:20 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >
> >> Joanne Koong <joannekoong@fb.com> writes:
> >>
> >>> This patch adds the kernel-side changes for the implementation of
> >>> a bitset map with bloom filter capabilities.
> >>>
> >>> The bitset map does not have keys, only values since it is a
> >>> non-associative data type. When the bitset map is created, it must
> >>> be created with a key_size of 0, and the max_entries value should be =
the
> >>> desired size of the bitset, in number of bits.
> >>>
> >>> The bitset map supports peek (determining whether a bit is set in the
> >>> map), push (setting a bit in the map), and pop (clearing a bit in the
> >>> map) operations. These operations are exposed to userspace applicatio=
ns
> >>> through the already existing syscalls in the following way:
> >>>
> >>> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> >>> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> >>> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
> >>>
> >>> For updates, the user will pass in a NULL key and the index of the
> >>> bit to set in the bitmap as the value. For lookups, the user will pas=
s
> >>> in the index of the bit to check as the value. If the bit is set, 0
> >>> will be returned, else -ENOENT. For clearing the bit, the user will p=
ass
> >>> in the index of the bit to clear as the value.
> >> This is interesting, and I can see other uses of such a data structure=
.
> >> However, a couple of questions (talking mostly about the 'raw' bitmap
> >> without the bloom filter enabled):
> >>
> >> - How are you envisioning synchronisation to work? The code is using t=
he
> >>    atomic set_bit() operation, but there's no test_and_{set,clear}_bit=
().
> >>    Any thoughts on how users would do this?
> > I was thinking for users who are doing concurrent lookups + updates,
> > they are responsible for synchronizing the operations through mutexes.
> > Do you think this makes sense / is reasonable?
>
> Right, that is an option, of course, but it's a bit heavyweight. Atomic
> bitops are a nice light-weight synchronisation primitive.
>
> Hmm, looking at your code again, you're already using
> test_and_clear_bit() in pop_elem(). So why not just mirror that to
> test_and_set_bit() in push_elem(), and change the returns to EEXIST and
> ENOENT if trying to set or clear a bit that is already set or cleared
> (respectively)?
>
> >> - It would be useful to expose the "find first set (ffs)" operation of
> >>    the bitmap as well. This can be added later, but thinking about the
> >>    API from the start would be good to avoid having to add a whole
> >>    separate helper for this. My immediate thought is to reserve peek(-=
1)
> >>    for this use - WDYT?
> > I think using peek(-1) for "find first set" sounds like a great idea!
>
> Awesome!

What's the intended use case for such an operation? But also searching
just a first set bit is non completely generic, I'd imagine that in
practice (at least judging from bit operations done on u64s I've seen
in the wild) you'd most likely need "first set bit after bit N", so
peek(-N)?..

I think it's an overkill to provide something like this, but even if
we do, wouldn't BPF_MAP_GET_NEXT_KEY (except we now say it's a
"value", not a "key", but that's nitpicking) be a sort of natural
extension to provide this? Though it might be only available to
user-space right? Oh, and it won't work in Bloom filter "mode", right?

>
> >> - Any thoughts on inlining the lookups? This should at least be feasib=
le
> >>    for the non-bloom-filter type, but I'm not quite sure if the use of
> >>    map_extra allows the verifier to distinguish between the map types
> >>    (I'm a little fuzzy on how the inlining actually works)? And can
> >>    peek()/push()/pop() be inlined at all?
> >
> > I am not too familiar with how bpf instructions and inlining works, but
> > from a first glance, this looks doable for both the non-bloom filter
> > and bloom filter cases. From my cursory understanding of how it works,
> > it seems like we could have something like "bitset_map_gen_lookup" wher=
e
> > we parse the bpf_map->map_extra to see if the bloom filter is enabled;
> > if it is, we could call the hash function directly to compute which bit
> > to look up,
> > and then use the same insn logic for looking up the bit in both cases
> > (the bitmap w/ and w/out the bloom filter).
> >
> > I don't think there is support yet in the verifier for inlining
> > peek()/push()/pop(), but it seems like this should be doable as well.
> >
> > I think these changes would maybe warrant a separate patchset
> > on top of this one. What are your thoughts?
>
> Ah yes, I think you're right, this should be possible to add later. I'm
> fine with deferring that to a separate series, then :)
>
> -Toke
>
