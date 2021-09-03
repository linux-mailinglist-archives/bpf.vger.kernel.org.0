Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13A3400402
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhICRVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhICRVH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 13:21:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0EC061575
        for <bpf@vger.kernel.org>; Fri,  3 Sep 2021 10:20:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c11so6064490ybn.5
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVaDs7KGxDvkTiaWyI/gWw9XVe/ELV2AX+xyAdkRdxA=;
        b=ZBRAoy8/WZ2hwmbOgmLhoyMJDfEY2jjF8aE3cQo7jihH4CK+BcxgPXaPmqPedFJJHV
         LSV0e6xOxQAP3zLQkbBV05XWLG6AsxetlGuwfeVpRZ7BLx0+xz1yrO5bwqKq/MLFq/oT
         HjQiynQhW6GDewQd2EbR0vtWskPe+sZCJvZPF+2lBKGIh5GPQ8s9kfiesbnwzUPOxQgX
         u9Nq0HyiRDC7lvFdLohvKOnV73gQV+7zc0zwH+DwJBWtEnu+3n7+Nf04ZIvYY82BBeNB
         EbY+MXLEO1ncM2gV4zyZP+5p85Pj0ADhUHXUd3ijpeaVza3WnhREIfKeoe8mPER+SiX9
         TURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVaDs7KGxDvkTiaWyI/gWw9XVe/ELV2AX+xyAdkRdxA=;
        b=NgTQ1IvJTahR+jpPCTMEET3Zupm1W9MxBWnswP67S5KVeDN6gFkPbh0QycwlEUYVco
         99RYWW6Jr7jq7/cjOtbX7Oz9+Zq8Xy067bL5bsDitlYFiAmkZ+mx7UnbqMu/oJ21XZSX
         M+tSC4yAXBW61up4nV/zZ+4hCsixalUr17ovQPo7W87L7jQOorVREiyT3K9+6qdEKViw
         ShBuKUYPb2wTSsuu2PNyOtr7aFmmEwtxZ0Nlhp1VnLDhZ9smI6hAv5xDEegqz+LpKFm0
         pHkFRmDcbL3828H4cV0yN+e/U/o+FamBcMJG1JhY+v/++DB70qyXsKH418liDQRFbtn+
         A9sA==
X-Gm-Message-State: AOAM531Fkcp3YsjqbavBEAx9NDyK8kVOz1eqrcXkE2D9rGNMakzrek8d
        t6r6QJaUSPdsDrLsQ3xRln6tx8bIzO8+Gs0wFOA=
X-Google-Smtp-Source: ABdhPJy9rwse1xXG1y1s2yeRJM7dW6ioYjmlkeKP/el63/VPEW0q+em74USuThucw3uxymh5AskLQK4oFq5vi47MFDw=
X-Received: by 2002:a25:ef46:: with SMTP id w6mr159290ybm.546.1630689606343;
 Fri, 03 Sep 2021 10:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225005.2762202-1-joannekoong@fb.com> <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch> <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
 <20210903005611.pnkvybwsc5uxddyx@kafai-mbp.dhcp.thefacebook.com> <0beca6da-7444-fdf3-8dc4-c9126b7779de@fb.com>
In-Reply-To: <0beca6da-7444-fdf3-8dc4-c9126b7779de@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Sep 2021 10:19:55 -0700
Message-ID: <CAEf4BzZ1PeuF1Uy2R=c9zmU+Zs=iP8_g5P=xZg+b_5qLbm41iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 3, 2021 at 12:13 AM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 9/2/21 5:56 PM, Martin KaFai Lau wrote:
>
> > On Thu, Sep 02, 2021 at 03:07:56PM -0700, Joanne Koong wrote:
> > [ ... ]
> >>>> But one high-level point I wanted to discuss was that bloom filter
> >>>> logic is actually simple enough to be implementable by pure BPF
> >>>> program logic. The only problematic part is generic hashing of a piece
> >>>> of memory. Regardless of implementing bloom filter as kernel-provided
> >>>> BPF map or implementing it with custom BPF program logic, having BPF
> >>>> helper for hashing a piece of memory seems extremely useful and very
> >>>> generic. I can't recall if we ever discussed adding such helpers, but
> >>>> maybe we should?
> >>> Aha started typing the same thing :)
> >>>
> >>> Adding generic hash helper has been on my todo list and close to the top
> >>> now. The use case is hashing data from skb payloads and such from kprobe
> >>> and sockmap side. I'm happy to work on it as soon as possible if no one
> >>> else picks it up.
> >>>
> After thinking through this some more, I'm curious to hear your thoughts,
> Andrii and John, on how the bitmap would be allocated. From what I
> understand, we do not currently support dynamic memory allocations
> in bpf programs. Assuming the optimal number of bits the user wants
> to use for their bitmap follows something like
> num_entries * num_hash_functions / ln(2), I think the bitmap would
> have to be dynamically allocated in the bpf program since it'd be too
> large to store on the stack, unless there's some other way I'm not seeing?

You can either use BPF_MAP_TYPE_ARRAY and size it at runtime. Or one
can use compile-time fixed-sized array in BPF program:


u64 bits[HOWEVER_MANY_U64S_WE_NEED];

/* then in BPF program itself */

h = hash(...);
bits[h / 64] |= (1 << (h % 64));

As an example. The latter case avoid map lookups completely, except
you'd need to prove to the verifier that you are not going out of
bounds for bits, which is simple to do if HOWEVER_MANY_U64S_WE_NEED is
power-of-2. Then you can do:

h = hash(...);
bits[(h / 64) & (HOWEVER_MANY_U64S_WE_NEED - 1)] |= (1 << (h % 64));

> >>>> It would be a really interesting experiment to implement the same
> >>>> logic in pure BPF logic and run it as another benchmark, along the
> >>>> Bloom filter map. BPF has both spinlock and atomic operation, so we
> >>>> can compare and contrast. We only miss hashing BPF helper.
> >>> The one issue I've found writing a hash logic is its a bit tricky
> >>> to get the verifier to consume it. Especially when the hash is nested
> >>> inside a for loop and sometimes a couple for loops so you end up with
> >>> things like,
> >>>
> >>>   for (i = 0; i < someTlvs; i++) {
> >>>    for (j = 0; j < someKeys; i++) {
> >>>      ...
> >>>      bpf_hash(someValue)
> >>>      ...
> >>>   }
> >>>
> >>> I've find small seemingly unrelated changes cause the complexity limit
> >>> to explode. Usually we can work around it with code to get pruning

btw, global BPF functions (sub-programs) should limit this complexity
explosion, even if you implement your own hashing function purely in
BPF.

> >>> points and such, but its a bit ugly. Perhaps this means we need
> >>> to dive into details of why the complexity explodes, but I've not
> >>> got to it yet. The todo list is long.
> Out of curiosity, why would this helper have trouble in the verifier?
>  From a quick glance, it seems like the implementation for it would
> be pretty similar to how bpf_get_prandom_u32() is implemented
> (except where the arguments for the hash helper would take in a
> void* data (ARG_PTR_TO_MEM), the size of the data buffer, and
> the seed)? I'm a bit new to bpf, so there's a good chance I might be
> completely overlooking something here :)

Curious as well. I imagine we'd define new helper with this signature:

u64 bpf_hash_mem(void *data, u64 sz, enum bpf_hash_func hash_fn, u64 flags);

Where enum bpf_hash_func { JHASH, MURMUR, CRC32, etc }, whatever is
available in the kernel (or will be added later).

John, would this still cause problems for the verifier?

>
> >>>> Being able to do this in pure BPF code has a bunch of advantages.
> >>>> Depending on specific application, users can decide to:
> >>>>     - speed up the operation by ditching spinlock or atomic operation,
> >>>> if the logic allows to lose some bit updates;
> >>>>     - decide on optimal size, which might not be a power of 2, depending
> >>>> on memory vs CPU trade of in any particular case;
> >>>>     - it's also possible to implement a more general Counting Bloom
> >>>> filter, all without modifying the kernel.
> >>> Also it means no call and if you build it on top of an array
> >>> map of size 1 its just a load. Could this be a performance win for
> >>> example a Bloom filter in XDP for DDOS? Maybe. Not sure if the program
> >>> would be complex enough a call might be in the noise. I don't know.
> >>>
> >>>> We could go further, and start implementing other simple data
> >>>> structures relying on hashing, like HyperLogLog. And all with no
> >>>> kernel modifications. Map-in-map is no issue as well, because there is
> >>>> a choice of using either fixed global data arrays for maximum
> >>>> performance, or using BPF_MAP_TYPE_ARRAY maps that can go inside
> >>>> map-in-map.
> >>> We've been doing most of our array maps as single entry arrays
> >>> at this point and just calculating offsets directly in BPF. Same
> >>> for some simple hashing algorithms.
> >>>
> >>>> Basically, regardless of having this map in the kernel or not, let's
> >>>> have a "universal" hashing function as a BPF helper as well.
> >>>> Thoughts?
> >>> I like it, but not the bloom filter expert here.
> >> Ooh, I like your idea of comparing the performance of the bloom filter with
> >> a kernel-provided BPF map vs. custom BPF program logic using a
> >> hash helper, especially if a BPF hash helper is something useful that
> >> we want to add to the codebase in and of itself!
> > I think a hash helper will be useful in general but could it be a
> > separate experiment to try using it to implement some bpf maps (probably
> > a mix of an easy one and a little harder one) ?
>
> I agree, I think the hash helper implementation should be its own separate
> patchset orthogonal to this one.
>

Sure, I don't feel strongly against having Bloom filter as BPF map.
