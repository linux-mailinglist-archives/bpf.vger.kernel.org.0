Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B80666A8B
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 05:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjALEtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 23:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjALEs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 23:48:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A04F125
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 20:48:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so30092166ejc.10
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 20:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7NLyIH6Fx8/OyLsR/ZRMVfEyLhJg6nAnqvGDG/PDzU=;
        b=GNBC8tK4OfQzO0svuIjt3qLTuz3h3qFYm6k8srVJ31AdPKgO5LvCHdZ4fYZGy/H/Ey
         cGNM+FTnd7QNg5Xmil7/KzONU5Ie9D7U3mws/M4gnMbrQFJdXPbudUf5JIklFVYy0JmI
         8La15LNvD0vuk6hX5nNJn7Ynsak9wxfXR6FVEGH/eC/maVtihewhfZzM+Vp+u+9vQzI5
         5F7akTPXd9zBm9uH07TMsDy3WsUNv3lGJ9fCzwXt7nFGNyzgNqPQGTAYDGHjBxfpaXoF
         xtjewr2rPESxLSFjax7+cjtGlBdZpq+n/2L2uckGXeddzRXMW4XTZ5WqO0KcmGRpYItv
         BpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7NLyIH6Fx8/OyLsR/ZRMVfEyLhJg6nAnqvGDG/PDzU=;
        b=kHVSE2euLggHHPPEg67qlNkntsz0iOTI2OtY428EwTSnyEAOE/niURLC85Gluy4iSl
         Go0pChgSuoynuYFVsPNzbRN8ctoy8gBR91kood9t43NEHEXBtQFHsdEfLkWezKK9TMq/
         t2zV1cmjdqPcRb/wgytgleAfVC5oNOkXg+y1M4FuACoWHPN7NAY8LQNzqZGO+g1fH88T
         9+p2JpEUEUq7629SBb+s6CMEvUznvY8Igl0HA90UhybJf98bL5tUc4HB58ZNmrHQy59X
         qhbMW7dI8kbtKn4nLyR3c2IGlgMFITLGrqPjbHYOFyKET3g4PprY45l+tUse5vdpKqLv
         dZAQ==
X-Gm-Message-State: AFqh2kpB1Sm9Bc9kZeBiQdBeZzOiM7t3Ruq9yqRlByrb+mqVfpsOzCBW
        vRHkRRsVPA6+cuGjUVoMYE31OisYursducCU4Hg=
X-Google-Smtp-Source: AMrXdXtsMvmGp11RfF8XZj+qhX7aTcKwjcj20rm0HK26lFRH2hmxK8Vi3mCS591velenQzcZenKESPFg6xvlJKXxdvg=
X-Received: by 2002:a17:906:dcf:b0:7c1:6781:9c97 with SMTP id
 p15-20020a1709060dcf00b007c167819c97mr5457001eji.676.1673498901232; Wed, 11
 Jan 2023 20:48:21 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <Y78+iIqqpyufjWOv@mail.gmail.com>
In-Reply-To: <Y78+iIqqpyufjWOv@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 Jan 2023 20:48:09 -0800
Message-ID: <CAADnVQ+b+XBukob0VAvxraUvXAf9zv8pa2R4QhRvjyULm9=zKA@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>
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

On Wed, Jan 11, 2023 at 2:57 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>
> On Tue, Jan 03, 2023 at 03:51:07PM -0800, Alexei Starovoitov wrote:
> > On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
> > > Discoverability plus being able to know semantics from a user PoV to figure out when
> > > workarounds for older/newer kernels are required to be able to support both kernels.
> >
> > Sounds like your concern is that there could be a kfunc that changed it semantics,
> > but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
> > such patches from landing. It's up to us to define sane and user friendly deprecation of kfuncs.
>
> I would advocate for adding versioning to BPF API (be it helpers or
> "stable" kfuncs). Right now we have two extremes: helpers that can't be
> changed/fixed/deprecated ever, and kfuncs that can be changed at any
> time, so the end users can't be sure new kernel won't break their stuff.
> Detecting and fixing the breakage can also be tricky: end users have to
> write different probes on a case-by-case basis, and sometimes it's not
> just a matter of checking the number of function parameters or presence
> of some definition (such difficulties happen when backporting drivers to
> older kernels, so I assume it may be an issue for BPF programs as well).
>
> Let's say we add a version number to the kernel, and the BPF program
> also has an API version number it's compiled for. Whenever something
> changes in the stable API on the kernel side, the version number is
> increased. At the same time, compatibility on the kernel side is
> preserved for some reasonable period of time (2 years, 5 years,
> whatever), which means that if the kernel loads a BPF program with an
> older version number, and that version is within the supported period of
> time, the kernel will behave in the old way, i.e. verify the old
> signature of a function, preserve the old behavior, etc.

Right. I think somebody proposed a version scheme for kfuncs already.
There were so many replies I've lost track.
But yes it's definitely on the table and
we should consider it.
Something like libbpf.map
We can declare which stable features are supported in which "version".

> This approach has the following upsides:
>
> 1. End users can stop worrying that some function changes unexpectedly,
> and they can have a smoother migration plan.
>
> 2. Clear deprecation schedule.
>
> 3. Easy way to probe for needed functionality, it's just a matter of
> comparing numbers: the BPF program loader checks that the kernel is new
> enough, and the kernel checks that the BPF program's API is not too old.
>
> 4. Kernel maintainers will have a deprecation strategy.

+1

> Cons:
>
> 1. Arguably a maintainance burden to preserve compatibility on the
> kernel side, but I would say it's a balance between helpers (which are
> maintainance burden forever) and kfuncs (which can be changed in every
> kernel version without keeping any compatibility). "Kfunc that changed
> its semantics is bad, we should prevent such patches" are just words,
> but if the developer needs to keep both versions for a while, it will
> serve as a calm-down mechanism to prevent changes that aren't really
> necessary. At the same time, the dead code will stop accumulating,
> because it can be removed according to the schedule.

That sounds like 'pro' instead of 'con' to me :)

> 2. Having a single version number complicates backporting features to
> older kernels, it would require backporting all previous features
> chronologically, even if there is no direct dependency. Having multiple
> version numbers (per feature) is cumbersome for the BPF program to
> declare. However, this issue is not new, it's already the case for BPF
> helpers (you can't backport new helpers skipping some other, because the
> numbers in the list must match).

yeah. I recall amazon linux or something else backported
helpers out of order and that screwed up bpf progs.
That was the reason we added numbers to the FN macro in uapi/bpf.h
That will hopefully prevent such mistakes.

But practically speaking...
The distro that does out-of-order backporting and skips
certain helpers is saying: I'm defining my own kABI equivalent
for bpf progs.
In that sense there is zero difference between helpers and kfuncs
from distro point of view and from point of view of their customers.
Both helpers and kfuncs are neither stable nor unstable.

This discussion is only about pros and cons of the upstream kernel
and bpf progs that consume upstream kernel.

If we include hyperscalers in the discussion then all
helpers and all kfuncs immediately become stable from
point of view of their engineers.
Big datacenters can maintain kernels with whatever helpers
and kfuncs they need.

>
> The above description intentionally doesn't specify whether it should be
> applied to helpers or kfuncs, because it's a universal concept, about
> which I would like to hear opinions about versioning without bias to
> helpers or kfuncs.
>
> Regarding freezing helpers, I think there should be a solution for
> deprecating obsolete stuff. There are historical examples of removing
> things from UAPI: removing i386 support, ipchains, devfs, IrDA
> subsystem, even a few architectures [1]. If we apply the versioning
> approach to helpers, we can make long-waiting incompatible changes in
> v1, keeping the current set of helpers as v0, used for programs that
> don't declare a version. Eventually (in 5 years, in 10 years, whatever
> sounds reasonable) we can drop v0 and remove the support for unversioned
> BPF programs altogether, similar to how other big things were removed
> from the kernel. Does it sound feasible?

Not to me. Breaking uapi in whichever way with whatever excuse
is not on the table.
We've documented our rules long ago:

Q: Does BPF have a stable ABI?
------------------------------
A: YES. BPF instructions, arguments to BPF programs, set of helper
functions and their arguments, recognized return codes are all part
of ABI.

> > "Proper BPF helper" model is broken.
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> >
> > is a hack that works only when compiler optimizes the code.
>
> What if we replace codegen for helpers, so that it becomes something
> like this?
>
> static inline void *bpf_map_lookup_elem(void *map, const void *key)
> {
>         // pseudocode alert!
>         asm("call 1" : : "r1"(map), "r2"(key));
> }
>
> I.e. can we just throw in some inline BPF assembly that prepares
> registers and invokes a call instruction with the helper number? That
> should be portable across clang and gcc, allowing to stop relying on
> optimizations.

Great idea!
It needs "=r" to capture R0 into the 'ret' variable and then it should work.
clang may have issues with such asm, but should be fixable.
gcc is less clear.
iirc they had their own incompatible inline asm :(
It's a bigger issue.
