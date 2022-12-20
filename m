Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF4652719
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 20:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLTTdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiLTTck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 14:32:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69A1CFEC
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 11:31:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jo4so22737597ejb.7
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=frjbExM8Lxu2C+XeXgLxErcQZd+Lx3qNWFFtq+n6im4=;
        b=QqOClJ5BdVTtUvspt05mx240/aXVsNicGWUoQlevq9s5IpN00v8rvqWZY2J2TP/NR8
         YmuWCOzY8kBBnm1rrDzhJfXYv0Jao/gecuYM2aMav+lWXbBJKv1qGp1M8uZwiJTr8E0p
         mQNQ7iVFpcIxrc5V2Uauvv0dAdUViTnbxhlzbLEAmvf6u8FTOegFM6pdJG2ahgh1vPdD
         peovk7KSXUj4StnXJy0DIcFMcRI6Wvyd/1p1SQv+0CI5KmD3FcOiROyC6bj+MxI+Iwy6
         pgdxsf8E6kDQ5lfi7O97Nvtxn6jpY7REVmd2HFz8xTGgWvia8Q0k7JyuyVMUAWUNlr3C
         MMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frjbExM8Lxu2C+XeXgLxErcQZd+Lx3qNWFFtq+n6im4=;
        b=fM7NnE1obbOzg+C80kCYQT35bCDVfYDcTzodkmk59AWNzUQ/qBUSWek2FkFofbQuwk
         x6+K8oRaNLG377jsbQSYHB7R9lPz+eLi1+Laegtvevy+y626yA30DtDnteQ0yhWbYR1j
         lfSdg/qJC9c5UUnJeZR+nYKCPNNoEFs7HZE0e6DKu0A+7QJ8jrNuT5l9kLlM+6bZGue3
         WWPdedGKJDEjVoqVna7iJ0N6fHwBjPuWoWrv5ZHzJo+i37tgOwmkF2nAjNFd5uNwB2Q/
         WNDBOZfwMPliOLrq+GlfWrQAMjYIhSzdzlDHHr90ffx21A6Kup/LOM9Vg5+XmwsEPuip
         ofQA==
X-Gm-Message-State: ANoB5plPj9VRkE99UuleXH0lbnDnTRNnGQJLE5g50IFrjW0J8Um24Zxq
        kuIPjhcv4RhQhMHWl3jNcHUav6WcVB3v16FaalI=
X-Google-Smtp-Source: AA0mqf5fxdgQDzyfyR9yD9O4+NxbifGLIqdIs82X8J8DVKW8YFasvaeXkhWJHzzNkQ1t284gHxlfBBxkcfKnXziN9Es=
X-Received: by 2002:a17:906:7116:b0:7c1:8450:f964 with SMTP id
 x22-20020a170906711600b007c18450f964mr3204273ejj.176.1671564696994; Tue, 20
 Dec 2022 11:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com> <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
In-Reply-To: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 11:31:25 -0800
Message-ID: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> >
> > There is no clean way to ever move from unstable kfunc to a stable helper.
>
> No clean way? Yet in the other email you proposed a way.
> Not pretty, but workable.
> I'm sure if ever there will be a need to stabilize the kfunc we will
> find a clean way to do it.

You can't have stable and unstable helper definition in the same .c
file, so work around would include having two separate .c files and
statically linking them together just to be able to call one or the
other within the same program.

It's possible, but in no way it's clean or straightforward. And that
was my point.

> Strongly arguing right now that this is an issue without doing the home work
> is not productive.

Not sure what kind of extra homework I should do to be able to point
out that what I said above and in previous emails is a real pain for
users.

>
> > BPF helpers also have the advantage of working on all architectures,
> > whether that architecture supports kfuncs or not, whether it supports
> > JIT or not.
>
> Correct, but applying the same argument we should argue that
> all features must work in the interpreter as well, because
> not all architectures support JIT.
> This way struct-ops and bpf based TCP-CC would never be possible.
> Some JITs don't support tail calls with subprogs.
> freplace (bpf prog replacement) works when JITed only.
> bpf trampoline works on x86-64 only.
> while kfuncs work on more than one arch.

Where did I claim that *everything* should work everywhere?

And yes, if we can make some feature work across JIT and interpreter
*with no extra work*, then yes, we should strive to do it.

>
> Now comapre the amount of .text that kernel has to contain
> to support hundreds of helpers vs same amount of kfuncs.

The amount of code is about the same for helpers vs kfuncs assuming
they are used, though, right? so it comes down to being able to remove
stuff, as you mention below.

> In the former it's a whole bunch of code that is there in the kernel
> in case bpf prog will call that helper. With 200+ helpers and half
> of them already deprecated we have quite a bit of dead code in the kernel
> that we cannot delete.

So "half of them already deprecated" is news to me and a pretty strong
statement. I went just scrolling through helpers and lots of them
seems as useful as they were when they were added. Completely ignoring
networking helpers (which I don't use much at all, but that doesn't
mean they are useless and deprecated, right?), I counted about 40 at
least that I've used personally, and there is more helpers that are
used in practice across various apps I've helped over time.

> While with kfunc approach there is no extra code that deals with
> conversion of the registers from bpf psABI to arch psABI.
> With kfuncs we generate this code on demand.

First time I'm hearing this .text size concern due to conversion of
the registers from bpf psABI to arch psABI. Can you elaborate, please?
I went spot checking, looked at a few helpers like
bpf_map_lookup_elem, bpf_csum_diff, bpf_skb_store_bytes, etc. I
couldn't guess what bloat you are talking about? And how many bytes
are we talking about here?

>
> > BPF helpers are also nicely self-discoverable and documented in
> > include/uapi/linux/bpf.h, in one place where other BPF helpers are.
> > This is a big deal, especially for non-expert BPF users (a vast
> > majority of BPF users).
>
> Good point. In general the kfuncs are not up to the level of
> documentation of helpers and we should work on improving that,
> but some of kfuncs are better documented than helpers.
> So it's not black and white.

I was not comparing the quality of documentation. I was saying all the
helpers are nicely listed (with their doc comments, yes) in one place
in UAPI, making it simple for users to discover.

Documentation itself can and should be improved for both helpers and
kfuncs as much as possible, of course.

>
> Discoverability we discussed in the past.
> The task to automatically emit kfuncs into vmlinux.h is still not complete.
> Time to prioritize it higher.
>

Yep.

> >
> > > non-gpl and consistency don't even come close.
> > > We've been doing everything new as kfuncs and dynptr is not special.
> >
> > I think dynptr is quite special. It's a very generic and fundamental
> > concept, part of core BPF experience. It's a more dynamic counterpart
> > to an inflexible statically sized `void * + size` pair of arguments
> > sent to helpers for input or output memory regions. Dynptr has no
> > inherent dependencies on BTF, kfuncs, trampolines, JIT, nothing.
>
> imo dynptr and kptr are more or less equivalent in terms of being core
> building blocks.
> kptrs are done via kfuncs, so dynptr can do just as well.

bpf_kptr_xchg() is a BPF helper, so kptr is not 100% done via kfuncs.
(But I'm guessing you'll say it was a mistake and bpf_kptr_xchg()
should have been a kfunc, but it's too late to change that, and it's
just a counter example that proves the rule).

But regardless, dynptr is modeled as black box with hidden state, and
its API surface area is bigger (offset, size, is null or not,
manipulations over those aspects; then there is skb/xdp abstraction to
be taken care of for generic read/write). It has a wider *generic* API
surface to be useful and effectively used.

Kptr is a single pointer that can be NULL or not and you can check for
that directly. The rest is BPF verifier magic that keeps track of
types and "trustedness", and then you can use specific interfacing
kfuncs to work with kernel objects (which as I said before, makes
sense to keep unstable).

Yes, both are fundamental. But they are not apples to apples.

>
> > By requiring kfunc-based helpers we are significantly raising the
> > obstacles towards adopting dynptr across a wide range of BPF
> > applications.
>
> Sorry, but I have to disagree. kptr and dynptr are left and right hand.
> Both will work just fine as kfuncs.
>

Ok, let's agree to disagree.

> > And the only advantage in return is that we get a hypothetical chance
> > to change something in the future. But let's see if that will ever be
> > necessary for the helpers Joanne is adding:
> >
> > 1. Generic accessors to check validity of *any* dynptr, and it's
> > inherent properties like offset, available size, read-only property
> > (just as useful somethings as bpf_ringbuf_query() is for ringbufs,
> > both for debugging and for various heuristics in production).
> >
> > bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> > long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
> > long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> > bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> >
> > There is nothing to add or remove here. No flags, no change in semantics.
>
> Disagree, since there is an obvious counter example.

I'm talking about *specific* dynptr helpers under discussion, and you
are bringing up some other helpers as "counter examples". What kind of
discussion is this? We'll keep branching out with more and more (at
best) tangentially related arguments until I'm exhausted and just give
up?

> See all of bpf_get_current_task*().
> Some of them are still used, but
> bpf_get_current_task vs bpf_get_current_task_btf is our acknowledgement
> of the fact that we suck in inventing uapi.

All *two* of them, bpf_get_current_task() and
bpf_get_current_task_btf(), right? They are 2 years apart.
bpf_get_current_task() was added before BTF era. It is still actively
used today and there is nothing wrong with it. It works on older
kernels just fine, even with BPF CO-RE (as backporting a few simple
patches to generate BTF is simple and easy; not so much with BPF
verifier changes to add native BTF support). I don't see much problem
having both, they are not maintenance burden.

> It's the lesson that we've learned the hard way.
> Not going to repeat that mistake again.

I'm not dismissing the burden of backwards compat and UAPI stability,
you don't have to explain that to me. But I don't see it as a reason
to suddenly make everything unstable, even concepts that are core
parts of the BPF framework.

>
> To be completely honest I expect that dynptr may get obsolete
> as the whole concept several years from now.
> We still don't have a single actual user of it.
> Just like kptr. Could be deprecated eventually just as well.
>

One can say similar things about any technology or API. It doesn't
mean that it was a mistake to implement them in the first place (just
like your example with bpf_get_current_task() -- it served and still
serves its purpose).

For dynptr, time will tell, but we are still missing important parts
for wider adoption. Skb/xdp stuff will be great for networking.
Ringbuf/local (and malloc one, when we get to it) dynptrs will be used
by generic tracing apps, but it will have to be deployed more widely
across all supported kernels to make sense (thinking about our
fleet-wide profiler adoption, for example). And in general, adoption
of new concepts takes time.


> > 3. This one is the only one I feel less strongly about, but mostly
> > because I can implement the same (even though less ergonomically, of
> > course) with bpf_loop() and bpf_dynptr_{clone,advance}.
> >
> > long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> > void *callback_ctx, u64 flags)
>
> Speaking of your upcoming inline iterators.
> Please make sure that you're adding them as kfuncs.
> We've made a mistake with bpf_loop. It's a stable helper,
> but inline iterators will immediately deprecate most uses of bpf_loop.
> If bpf_loop was a kfunc we would have deleted it.

I'm afraid we'll have to have a similar discussion with iterators. For
a generic fundamental number range iterator, which is a generalization
of bounded loops and bpf_loop, I believe it should be in stable UAPI
as well. For stuff like iterators over kernel objects (tasks, cgroups,
etc) -- kfuncs make sense to me.

But let's cross that bridge when we get there.

>
> > Let's also note that verifier knows specific flavor of dynptr and thus
> > can enforce additional restrictions based on specifically SKB/XDP
> > flavor vs LOCAL/RINGBUF. So just because there is no perfect way to
> > handle all the SKB/XDP physical non-contiguity, doesn't mean that the
> > dynptr concept itself is flawed or not well thought out. It's just
>
> I think that's exactly what it means. dynptr concept is flawed.
> It's ok to add this flawed feature to the kernel right now,
> because we don't see a better way today, but that might change
> in the future and we gotta be able to fix our mistakes.

"flawed", "mistakes", "deprecated", etc. You keep using this strongly
negatively connotated language for things that were and are perfectly
valid and working (and, most importantly, used and useful in
practice), but somehow fell out of your favor. Is it really necessary
to denigrate everything like that? It just distracts from the essence
of the discussion.
