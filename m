Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEF41BB34
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhI1X5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 19:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbhI1X4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435CC061765
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 16:55:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id m70so1376921ybm.5
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKX8F3ME7P97FYdfpqbJ1MsaxD5VPrIv517KL0gGDuc=;
        b=BiVebunEfXmViIILWDq3nFY4sC9aMP36tvqm7JkL/FbufeIA92MnktHfxiwahOVW/V
         qRyAPV+21iQ6R1Y98ieEm6WJi27DcrCJ/Pg79QuvZ1C04Vfw4usccPtP/jOkpYyi8ekN
         +xtv2P8+BvJG+bmuhxqhllvnl+dTEWXxAgzCXfiORE7CIVex7qpxy0ByeJ7zbOJsnnxX
         zaD+DcoqabwY03sQ3eIgvfrQqwNd4+r+2bKCzaQbyplCrCfo7Wf+GypOVNswXtQFRL6j
         oR3ebM+0GZvBYhCZu5N90L9VVLLDDt2XO7OzVrQhzNDRCy43alcu/2sqGweS/pma57wq
         ORwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKX8F3ME7P97FYdfpqbJ1MsaxD5VPrIv517KL0gGDuc=;
        b=qKTD5YD5d0J5mNbbUJc8VN9Y36Kpl3YVWK2gfHGJLw1OMlOYgwznuW1A3/+rz2wTtu
         HLxqVT5N3VS0XTdfLmRxOzD5JyVbeksR1/S2WTILitHDj6bKOEBUUAmFYdNLnM1bR+Gm
         C7UBr9KcEiBUHh9y1kdooYFWZ/b+DyYPHFPESJbgP5umJZh+lJ4gRjIq7xPiG+y7yNfd
         8Pzz6yarTrs3cGx+LYvLYYfldDX/pRbXRpjHtMQxK6ZnUne2fKFgtFh1fqJJnnAJ1R6B
         RU84yA5FVL0ZAsH+9ngwFye+knu1J0VLBvXRlmOe6+wXPqIiBJ+C0XPexF9ZYLQi58IU
         LzQg==
X-Gm-Message-State: AOAM530uVSVhny/UfcmeeMwbe5zUMOPCnqnHbqfIQCMRkkpGDErhMKoU
        F6TsC3uaZB6HyYF8YITiY9V11HD3eoa27Zg9Ltk=
X-Google-Smtp-Source: ABdhPJw+DlXL6hH+tQTfgWj/pOAS4UHURO8y9uxuYez6fFvHMTc4cJg+KEEr5q9PI35BE94um1GSw0VwYfHpvVV14vk=
X-Received: by 2002:a25:1dc4:: with SMTP id d187mr8075514ybd.455.1632873301463;
 Tue, 28 Sep 2021 16:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210923203046.a3fsogdl37mw56kp@ast-mbp> <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com> <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com> <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
 <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com> <aa967ed2-a958-f995-3a09-bbd6b6e775d4@fb.com>
In-Reply-To: <aa967ed2-a958-f995-3a09-bbd6b6e775d4@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 16:54:50 -0700
Message-ID: <CAEf4BzY08boSQdzC8RKkhoTyMXrSmz=Ugcb3EJwGyfj05stO1A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 1:56 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 9/28/21 9:21 AM, Alexei Starovoitov wrote:
>
> > On Mon, Sep 27, 2021 at 05:36:00PM -0700, Andrii Nakryiko wrote:
> >> On Mon, Sep 27, 2021 at 4:51 PM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>> On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
> >>>> On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
> >>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>> On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> >>>>>> That's not what I proposed. So let's say somewhere in the kernel we
> >>>>>> have this variable:
> >>>>>>
> >>>>>> static int bpf_bloom_exists = 1;
> >>>>>>
> >>>>>> Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> >>>>>> all its hashed bits are set in Bloom filter (it "exists"), we return
> >>>>>> &bpf_bloom_exists. So it's not a NULL pointer.
> >>>>> imo that's too much of a hack.
> >>>> too bad, because this feels pretty natural in BPF code:
> >>>>
> >>>> int my_key = 1234;
> >>>>
> >>>> if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
> >>>>      /* handle "maybe exists" */
> >>>> } else {
> >>>>      /* handle "definitely doesn't exist" */
> >>>> }
>
> To summarize this, Andrii it seems like you are proposing two possibilities
> for passing the ptr to the data as the key:
>
> 1. Have the value be NULL (value_size = 0)

Yeah, this was my biggest hope (except value is non-NULL, it's just
zero-sized so not readable/writable), but that's academic at this
point, see below.

>
> 2. Have the value be value_size = 1 byte or value_size = 4 bytes in a
> worst-case scenario
>
>
> For #1 where the value_size is 0 and we return something like
> &bpf_bloom_exists
> for bpf_map_lookup_elem() where the key is found, this would still
> require us to do
> the following in the syscall layer elsewhere:
>
> a) In the syscall layer in map_lookup_elem, add code that will allow
> value_sizes of
> 0. This would require another change in bpf_map_copy_value where we have to
> also check that if the value_size is 0, then we shouldn't copy the
> resulting ptr
> of the bpf_map_lookup_elem call to the value ptr (the value ptr isn't
> allocated since
> value_size is 0).
>
> b) In map_update_elem, add code that allows the user to pass in a NULL /
> zero-size
> value. Currently, there exists only support for passing in a
> NULL/zero-size key
> (which was added for stack/queue maps that pass in NULL keys); we'd have
> to add
> in the equivalent for NULL/zero-size values. We'd also have to modify
> the verifier
> to allow bpf_map_update_elem for NULL values (ARG_PTR_TO_UNINIT_MAP_KEY).

This "UNINIT_MAP_KEY" part is confusing me because we are talking
about *NULL value* (so neither uninitialized nor a key), so I must be
missing something important here. I thought it would be
ARG_PTR_TO_MAP_VALUE_OR_NULL, but it does suck that other map types
would then be allowed NULL where they don't expect to get NULL, I
agree.

>
>
> For #2, from the user-side for bpf_map_update_elem, this now means
> the user would have to always pass in some dummy 1-byte or 4-byte value
> since the value_size is no longer 0. This seems like a hacky API
>
> Repurposing peek/push/pop (in the scenario where value_size = 0) would
> avoid the
> bpf_map_copy_value change in #1a altogether, which was the primary
> reason for
> suggesting it.
>
> The approach taken in this patchset (where we have the key as NULL, and
> the value
> as the ptr to the data) avoids the need to add that infrastructure
> outlined above
> for allowing NULL values, since it just rides on top of the changes that
> were added to the
> stack/queue map that allows NULL keys.

So overall, I agree that all the above will be an unnecessary
complication for relatively little gain. Just go with peek/pop/push.

>
> >>> I don't think it fits bitset map.
> >>> In the bitset the value is zero or one. It always exist.
> >>> If bloomfilter is not a special map and instead implemented on top of
> >>> generic bitset with a plain loop in a bpf program then
> >>> push -> bit_set
> >>> pop -> bit_clear
> >>> peek -> bit_test
> >>> would be a better fit for bitset map.
> >>>
> >>> bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
> >>> In most cases that would be a blocker,
> >>> but in this case we can add:
> >>> .arg3_type      = ARG_ANYTHING
> >>> and ignore it in case of stack/queue.
> >>> While bitset could use the flags as an additional seed into the hash.
> >>> So to do a bloomfilter the bpf prog would do:
> >>> for (i = 0; i < 5; i++)
> >>>     if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))
> >> I think I'm getting lost in the whole unified bitset + bloom filter
> >> design, tbh. In this case, why would you pass the seed to peek()? And
> >> what is value here? Is that the value (N bytes) or the bit index (4
> >> bytes?)?
> In that example where seed is passed to peek(), the context is the
> hypothetical scenario where  the bloom filter is implemented on top
> of a generic bitset.

But then why does *bitset* do the hashing on behalf of the user,
that's the confusing bit. But I'll reply to Alexei's email in just a
sec.

> > The full N byte value, of course.
> > The pure index has the same downsides as hashing helper:
> > - hard to make kernel and user space produce the same hash in all cases
> > - inability to dynamically change max_entries in a clean way
> >
> >> I assumed that once we have a hashing helper and a bitset
> >> map, you'd use that and seed to calculate bit index. But now I'm
> >> confused about what this peek operation is doing. I'm sorry if I'm
> >> just slow.
> >>
> >> Overall, I think I agree with Joanne that a separate dedicated Bloom
> >> filter map will have simpler and better usability. This bitset + bloom
> >> filter generalization seems to just create unnecessary confusion. I
> >> don't feel the need for bitset map even more than I didn't feel the
> >> need for Bloom filter, given it's even simpler data structure and is
> >> totally implementable on either global var array or
> >> BPF_MAP_TYPE_ARRAY, if map-in-map and dynamic sizing in mandatory.
> > Not really. For two reasons:
> > - inner array with N 8-byte elements is a slow workaround.
> > map_lookup is not inlined for inner arrays because max_entries will
> > be different.
> > - doing the same hash in user space and the kernel is hard.
> > For example, iproute2 is using socket(AF_ALG) to compute the same hash
> > (program tag) as the kernel.
> > Copy-paste of kernel jhash.h is not possible due to GPL,
> > but, as you pointed out, it's public domain, so user space would
> > need to search a public domain, reimplement jhash and then
> > make sure that it produces the same hash as the kernel.
> > All these trade offs point out the need for dedicated map type
> > (either generalized bitset or true bloomfilter) that does the hashing
> > and can change its size.
>
>
> To ensure we are all aligned on this conversation, here is in more
> detail what I am intending for the v4 map changes:
> * A bitset map that also internally functions as a bloom filter if
> nr_hashes > 0 (where nr_hashes is denoted through the map_extra flags).
> max_entries will be the requested size of the bitset. Key_size should always
> be 0.

ok, makes sense. max_entries is the number of bytes or bits? Not sure
which is better (bytes is more consistent with other uses and allows
for bigger bitset/filter, but bits might be more natural for bitset),
just bringing this up as it's unclear.


> * Add the convenience helpers
> bool bpf_bitset_clear(map, value);
> bool bpf_bitset_set(map, value);
> bool bpf_bitset_test(map, value);
>

It maps one to one to bpf_map_pop_elem(), bpf_map_push_elem(), and
bpf_map_peek_elem(), right? The signatures for pop and peek are
*identical* (map + value), while push has also extra flags (not a big
deal, we have 0 flags in a lot of helpers). So I don't see much value
for this (and it actually will be more confusing when bitset is really
a bloom filter :) ).

>
> In the case where nr_hashes == 0 (straight bitset):
> * For simplicity, value_size for the bitmap should always be a u32. This
> denotes which index of the bitmap to set/check/clear

SGTM.

>
> In the case where nr_hashes > 0 (bloom filter):
> * The value size can be whatever
> * Clear/delete is not supported
>

Sounds good as well.
