Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB744153BE
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 01:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhIVXJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 19:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVXJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 19:09:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DFC061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:08:05 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f130so15590022qke.6
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=erxNUHSU73KrhpxBpDTpLqnk0SZyQ2Z1pb/7tsgx6pY=;
        b=RQ/3R6pXQXfWzFPTW91z0SOwksFIu0N55l1mK0UPId8EOdtLM8ExpRnmUTLJqOt+wo
         aW6NdrAyD+jbvC2hVzFDPD/iRbFrgTut9aCuY8XuH7eHqS8qva3k6TXYRmCKQlgOj7/z
         vSjTqSO0XnAWqpDQaheWRIgxBnUSjzT39YPpbv0qOB+7mTDlgducTp3ErcOzEO03CwNq
         vZCfJwYbBoxVjLAd0OPlKSf8ue2Fj/Xw1F4y79McXwh6Gq+KhZVCKi1Q5jK21xiV6qdr
         sipjdo+9UwKj6+q9Sd1l+WSkDYLHxTDvZFPeTIGhVwWiF8KKQ2EBa1m6lE2cnTZLOBpN
         g/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=erxNUHSU73KrhpxBpDTpLqnk0SZyQ2Z1pb/7tsgx6pY=;
        b=6H8D2VEXwuGB2xbwqMV3ZBc0TmvDN5CtEiNToC56GJUed3c06ioBd1pLE6We1rlxmM
         gV0ocW+F5Icn8wiqC8I+7WOI6K8d7mn/WiE0ndoYK6ldOdKq6HuzcP7h1nJB34ah/Umw
         Jx2uvOg5Wej6NOFWSaAGyusfryBSQ0vkFO6dyC0DTokKyATJSHJUxoff7sL7rS6yNElF
         DHMAqu3lmAYua1bsNLW9nAyW3S66lO9RmWFLRZ9T3x6cGyj01hHq06pugGBg6OAqr82Q
         tH5ubb6YjSOEpivMLGscPPXF2PvmDJE/r29rq9qDQwLzqwvEb2zKt5dMJNwvMp2Aj1w3
         4HIg==
X-Gm-Message-State: AOAM531PA+3AyLFtXxwuDcuTDZGXxyXVIqBu2BGY29Lle3AGn4Sx50Pw
        uCaYICqvHpvRuye66J6/qB8jupdl0orvJurmiX3EQMoJK8g=
X-Google-Smtp-Source: ABdhPJwNFe3CSC4ZVk6yGeRF3wKeYc/vLDp5yviUA6YJlZqNRPWSAqnW/oCP61KdLSj9dV2LCeQv3RgEA1VloxjlfXw=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr1827630ybt.433.1632352084000;
 Wed, 22 Sep 2021 16:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com> <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com> <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 16:07:52 -0700
Message-ID: <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 3:08 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Sep 22, 2021 at 01:52:12PM -0700, Andrii Nakryiko wrote:
> > > Agree that a generic hash helper is in general useful.  It may be
> > > useful in hashing the skb also.  The bpf prog only implementation cou=
ld
> > > have more flexibility in configuring roundup to pow2 or not, how to h=
ash,
> > > how many hashes, nr of bits ...etc.  In the mean time, the bpf prog a=
nd
> >
> > Exactly. If I know better how many bits I need, I'll have to reverse
> > engineer kernel's heuristic to provide such max_entries values to
> > arrive at the desired amount of memory that Bloom filter will be
> > using.
> Good point. I don't think it needs to guess.  The formula is stable
> and publicly known also.  The formula comment from kernel/bpf/bloom_filte=
r.c
> should be moved to the include/uapi/linux/bpf.h.

By guessing I mean you'd need to invert the formula to calculate the
necessary max_entries you'd need just to size bloom filter to the
desired size. At which point max_entries won't really mean much.

Also the whole "let's choose 5 as number of hash functions" approach
seems pretty arbitrary and not explained. How was this chosen? Based
on one very particular benchmark? How can we tell it's good for most
use cases? How did we arrive at 5 and not 3 or 4?

Looking at [0], there are many ways to go about sizing Bloom filter. 5
hash functions, assuming the wikipedia formula we are using (N * K *
ln(2)), and according to "This means that for a given false positive
probability =CE=B5, the length of a Bloom filter m is proportionate to the
number of elements being filtered n and the required number of hash
functions only depends on the target false positive probability =CE=B5."
(from [1]) and corresponding formula, gives a false positive
probability or around 3%, if my math is right. Did we state those 3%
anywhere and how we arrived at them?

But there are multiple parameters involved in this decision, they are
interconnected, and different subsets of them might be driving user's
choice:
  - number of expected unique elements;
  - number of bits allocated;
  - acceptable false positive rate;
  - number of hash functions.

What if I want a false positive probability of 1%, or maybe 10%, or
0.1%, but not 3%? What if I'm concerned about memory usage and rather
save some memory at the expense of more false positives? Or calling
too many hash functions is prohibitive, but I can allocate more memory
to reduce the chance of hash collisions. There are many ways to slice
this cat. Kernel implementation makes *some* assumptions with little
justification and explanation. It's opinionated in one place (M * N *
ln(2)), but leaves it up to the user to make sense of what number of
functions it needs (K =3D -log2(eps)). Feels quite unusual and
underspecified for the kernel data structure. It would be probably
good to provide a bit of guidance in map description, I suppose.

Anyways, I've spent way too much time on this. It was fun, but I'll
shut up and go do something else.

  [0] https://en.wikipedia.org/wiki/Bloom_filter
  [1] https://en.wikipedia.org/wiki/Bloom_filter#Optimal_number_of_hash_fun=
ctions

>
> > > user space need to co-ordinate more and worry about more things,
> > > e.g. how to reuse a bloom filter with different nr_hashes,
> > > nr_bits, handle synchronization...etc.
> >
> > Please see my RFC ([0]). I don't think there is much to coordinate. It
> > could be purely BPF-side code, or BPF + user-space initialization
> > code, depending on the need. It's a simple and beautiful algorithm,
> > which BPF is powerful enough to implement customly and easily.
> >
> >   [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel=
.org/T/#t
> In practice, the bloom filter will be populated only once by the userspac=
e.
>
> The future update will be done by map-in-map to replace the whole bloom f=
ilter.
> May be with more max_entries with more nr_hashes.  May be fewer
> max_entries with fewer nr_hashes.
>
> Currently, the continuous running bpf prog using this bloom filter does
> not need to worry about any change in the newer bloom filter
> configure/setup.
>
> I wonder how that may look like in the custom bpf bloom filter in the
> bench prog for the map-in-map usage.

You'd have to use BPF_MAP_TYPE_ARRAY for the map-in-map use case.

>
> >
> > >
> > > It is useful to have a default implementation in the kernel
> > > for some useful maps like this one that works for most
> > > common cases and the bpf user can just use it as get-and-go
> > > like all other common bpf maps do.
> >
> > I disagree with the premise that Bloom filter is a common and
> > generally useful data structure, tbh. It has its nice niche
> > applications, but its semantics isn't applicable generally, which is
> > why I hesitate to claim that this should live in kernel.
> I don't agree the application is nice niche.  I have encountered this
> many times when bumping into networking usecase discussion and not
> necessary limited to security usage also.  Yes, it is not a link-list
> like data structure but its usage is very common.
