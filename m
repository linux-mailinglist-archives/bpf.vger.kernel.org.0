Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74641BBA5
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 02:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhI2AQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 20:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhI2AQr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 20:16:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D1C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 17:15:07 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id w19so1482607ybs.3
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmQksg1+2ZQLj9JsoFVpCSXsa+kHVALTXamAtoM49rk=;
        b=NqpuY+SzH25Rd8wpQi+6232WWpAhuZmAgmbiDyVeuYDM6A6LwOrRo/31UYMeT1EEoo
         m9fwfRTmqwLNfK2zUrG39BI9WQe3KzuwXnAQL1E3FQBOdyX3XKlOVkraWifZClw1WYGK
         pLJMxpP7OLe8gnDwG9cCND+WgglW6x3ryqrqfZN+1rPy3oUNhLJZxezR4/7Vblmwo3ke
         3jhOsOzdb09nshCRfUHeE70kOEghvhPL2LCCzefeAMSPQEyICZ2EwKweMZxPBFQg4sQ2
         x/Rh4FueZ7l3PbYqawD5X9MPf9yIGDe/62j359Nqbzq+OZP9fxVRwuszWchZaIiNXdcp
         0arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmQksg1+2ZQLj9JsoFVpCSXsa+kHVALTXamAtoM49rk=;
        b=lFLLb+ag9JaWgUcuUnZUH1IxDpAzhutz5E+JRhzcavAy3+IWNxX9WkI4zPeQ/RteFx
         lvL3Hs4N9bdsB0ioWDioHco4DLhGOXzphqjyI17YdkC1jAeWqXcQe5oXUWlpOVP9JqFn
         h5AzgXUPUcSZlFkTEVPem+Wthx7eq1tlGJx25D7P1YTvgQ9IXxsVS2hvorHXQ1iVDfG2
         FnsfbvbalgkKKD2MjpucGoIQS62j8dotVRHpd0jb2KvNZq0ufSQvQHfe1MXK8ABGyI08
         rrr7QBRTLURWunb4C7BVbaXpsPWZezAN8QF8bpwYpj/nlRpDgjR23bUyVBIRnYC9djHQ
         XEmA==
X-Gm-Message-State: AOAM5315b8AbskhC8rp3vNsj7Mmod1eFyBYeYfMJt/p8PGn+CtLPzLE7
        y1wkjP7pXA6JLWpyjMMRb3S3uHsFGnplkVySkGReS595
X-Google-Smtp-Source: ABdhPJzb1NcumecuUWfmSkrPmdaQC5i86NbnFVJH7Sh8rmF4t+BY6vHyyn0SIkiP/mtCCUXUBWYQTNTzpu7o+71CNfU=
X-Received: by 2002:a25:1dc4:: with SMTP id d187mr8159389ybd.455.1632874506605;
 Tue, 28 Sep 2021 17:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210923203046.a3fsogdl37mw56kp@ast-mbp> <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com> <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com> <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com> <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 17:14:55 -0700
Message-ID: <CAEf4BzbH8v2m4tJEz2hFU+PGxMxP6QrFXcRmD3ESiQi_jqBbtw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 9:21 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 05:36:00PM -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 27, 2021 at 4:51 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> > > > > >
> > > > > > That's not what I proposed. So let's say somewhere in the kernel we
> > > > > > have this variable:
> > > > > >
> > > > > > static int bpf_bloom_exists = 1;
> > > > > >
> > > > > > Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> > > > > > all its hashed bits are set in Bloom filter (it "exists"), we return
> > > > > > &bpf_bloom_exists. So it's not a NULL pointer.
> > > > >
> > > > > imo that's too much of a hack.
> > > >
> > > > too bad, because this feels pretty natural in BPF code:
> > > >
> > > > int my_key = 1234;
> > > >
> > > > if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
> > > >     /* handle "maybe exists" */
> > > > } else {
> > > >     /* handle "definitely doesn't exist" */
> > > > }
> > >
> > > I don't think it fits bitset map.
> > > In the bitset the value is zero or one. It always exist.
> > > If bloomfilter is not a special map and instead implemented on top of
> > > generic bitset with a plain loop in a bpf program then
> > > push -> bit_set
> > > pop -> bit_clear
> > > peek -> bit_test
> > > would be a better fit for bitset map.
> > >
> > > bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
> > > In most cases that would be a blocker,
> > > but in this case we can add:
> > > .arg3_type      = ARG_ANYTHING
> > > and ignore it in case of stack/queue.
> > > While bitset could use the flags as an additional seed into the hash.
> > > So to do a bloomfilter the bpf prog would do:
> > > for (i = 0; i < 5; i++)
> > >    if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))
> >
> > I think I'm getting lost in the whole unified bitset + bloom filter
> > design, tbh. In this case, why would you pass the seed to peek()? And
> > what is value here? Is that the value (N bytes) or the bit index (4
> > bytes?)?
>
> The full N byte value, of course.
> The pure index has the same downsides as hashing helper:
> - hard to make kernel and user space produce the same hash in all cases
> - inability to dynamically change max_entries in a clean way

Here's the confusing part. If the map is performing hashing, then why
would we do explicit 5 iteration instead of the map (bloom filter)
just doing it internally in one go (faster and simpler). But if it is
a bitset (and so we have to do 5 iterations to implement Bloom filter
logic), then it is quite unconventional for the bitset data structure
to perform the hashing of a value. The only upside of this hybrid
one-bit-at-a-time-but-with-hashing-included approach would be more
freedom in choosing the hashing seed for each individual bit. But that
hasn't come up as a limitation in the discussion at all, which made me
wonder what we are optimizing here for.

>
> > I assumed that once we have a hashing helper and a bitset
> > map, you'd use that and seed to calculate bit index. But now I'm
> > confused about what this peek operation is doing. I'm sorry if I'm
> > just slow.
> >
> > Overall, I think I agree with Joanne that a separate dedicated Bloom
> > filter map will have simpler and better usability. This bitset + bloom
> > filter generalization seems to just create unnecessary confusion. I
> > don't feel the need for bitset map even more than I didn't feel the
> > need for Bloom filter, given it's even simpler data structure and is
> > totally implementable on either global var array or
> > BPF_MAP_TYPE_ARRAY, if map-in-map and dynamic sizing in mandatory.
>
> Not really. For two reasons:
> - inner array with N 8-byte elements is a slow workaround.
> map_lookup is not inlined for inner arrays because max_entries will
> be different.

If we are talking about bit set data structure (not Bloom filter),
then elementary operation is setting/resetting *one bit*. For that,
looking up an 8-byte element and setting a bit in it is just as
efficient as having a dedicated bpf_map_push_elem(). Keep in mind, I'm
talking about pure bitset logic here. Once you add N hashes (and thus
we start talking about Bloom filter, not a bit set), then you get N
helper calls vs just 1 for bloom filter logic.

So for Bloom filter you get performance advantage from a dedicated map
(due to having just 1 helper call to do N hashing operations). For
pure bitset, there seems to be little benefit at all because it is
basically ARRAY. For pure bitset of a fixed size, doing it on a global
var array is faster (no helper overhead). For map-in-map case with
known or unknown size, ARRAY is equivalent to BITSET map (one helper
call + setting 1 bit through returned pointer).

But the nr_hashes == 0 special casing for pure bitset works fine as well.

> - doing the same hash in user space and the kernel is hard.
> For example, iproute2 is using socket(AF_ALG) to compute the same hash
> (program tag) as the kernel.
> Copy-paste of kernel jhash.h is not possible due to GPL,

I haven't found SPDX header or any mention of GPL in
include/linux/jhash.h, so I assumed someone can just copy paste the
code (given the references to public domain). Seems like that's not
the case? Just curious about implications, license-wise, if there is
no SPDX? Is it still considered GPL?

> but, as you pointed out, it's public domain, so user space would
> need to search a public domain, reimplement jhash and then
> make sure that it produces the same hash as the kernel.
> All these trade offs point out the need for dedicated map type
> (either generalized bitset or true bloomfilter) that does the hashing
> and can change its size.

Sure, we've converged on that already. I was confused by the above
example of an explicit loop + bpf_map_peek_elem with hashing.
