Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CED49AD18
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 08:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442292AbiAYHHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 02:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377258AbiAYHCc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 02:02:32 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E92C055A9D
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 21:41:30 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r144so384710iod.9
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 21:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jWYhG86Oug5qxnHcxifDNisxCAyweVVw+OL0FH0aphc=;
        b=EOJkPVIzkvl0U+4Rr8/QAOBJPqNYCPmQo07Mu+HCK7//g4G5auU3Ac1+xgdgEfs38E
         hGqmrcEcu1sGEgcvOOsjF2B6uXjhRenfY1ds17OW2ssc4flbgcu+HNnN6TUWW7u0LKFB
         sc7/lZnNe5R/u6PwqxIIiycuKnZqXEIMLDcFf0APTPMyqVhji1PmqXtMqqmqta3Wy0K+
         PLndYQjykN/QkMn7rlRVsnB6reYd+fD0IR+Q5tZxaLlAKLlxNuC2jYUgIZACJpneeCy6
         x+StxMiWK7CUHBoZlK3jJf7pJCvyp9Jx0uZlKQ9PMiWMMQ3La901NkcOHhP3EaUAf7cf
         /lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jWYhG86Oug5qxnHcxifDNisxCAyweVVw+OL0FH0aphc=;
        b=3YPdu028pzuwvXIAwte+wzfvolgJTfhUC+vdTZx2nmZxk5cTkofFgrlpdQMVKnWaw4
         pVtV/MZcE+sFp5PWzGeP08iIN0inXLO292m5C87/boDOSQ3Aum/lhSK6JtE7zKKkzMWE
         wHxGXVQz5wM4Nhx/CQV5XzwYhyulzdDF/IdZQGIM93sa7iBzLoAA31fnP0tvnCQZJS3R
         3vZvmIKfDr/e4oMmc2jp17bZq+YArKAoqXPQFdSeJZnt5JsfX2PAaUYltpc0mhKcHoAG
         NLpzM7AI95kx7ArI48fJ2Jq8FuM6h4gJQClQozgeABqw/SYXrKqTdyQQrCaUJezC50Ud
         y5eg==
X-Gm-Message-State: AOAM5336Z+TO3ppQxpfe9KQWHjNKmkGSkfLqqDgXHjNg2lGRHs1lCnfM
        zJRNdsqvzWGbSXUrDLQGPaM0zUACUx0KSOtLylI=
X-Google-Smtp-Source: ABdhPJwB6eJ8dksJ4G9laU8JvXgbfqqV+YmRAycDzBJBMjKweR+LZA3iVSn4VskmUxbcNJdjsrd+5DNTLPL+yu4A+8w=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr9791372ion.154.1643089289364;
 Mon, 24 Jan 2022 21:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20220120060529.1890907-1-andrii@kernel.org> <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk> <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk> <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <ce6308e4-fb23-5cbb-f9b4-bed0bb5a4691@gmail.com>
In-Reply-To: <ce6308e4-fb23-5cbb-f9b4-bed0bb5a4691@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 21:41:18 -0800
Message-ID: <CAEf4Bzby1P1fgrL3q3WD9xGXXTU0jfckQWKTvhossA0C5D-90Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
To:     David Ahern <dsahern@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 4:27 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 1/24/22 9:15 AM, Andrii Nakryiko wrote:
> > On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >>> On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >>>>
> >>>> Andrii Nakryiko <andrii@kernel.org> writes:
> >>>>
> >>>>> Enact deprecation of legacy BPF map definition in SEC("maps") ([0])=
. For
> >>>>> the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS =
flag
> >>>>> for libbpf strict mode. If it is set, error out on any struct
> >>>>> bpf_map_def-based map definition. If not set, libbpf will print out
> >>>>> a warning for each legacy BPF map to raise awareness that it goes
> >>>>> away.
> >>>>
> >>>> We've touched upon this subject before, but I (still) don't think it=
's a
> >>>> good idea to remove this support entirely: It makes it impossible to
> >>>> write a loader that can handle both new and old BPF objects.
> >>>>
> >>>> So discourage the use of the old map definitions, sure, but please d=
on't
> >>>> make it completely impossible to load such objects.
> >>>
> >>> BTF-defined maps have been around for quite a long time now and only
> >>> have benefits on top of the bpf_map_def way. The source code
> >>> translation is also very straightforward. If someone didn't get aroun=
d
> >>> to update their BPF program in 2 years, I don't think we can do much
> >>> about that.
> >>>
> >>> Maybe instead of trying to please everyone (especially those that
> >>> refuse to do anything to their BPF programs), let's work together to
> >>> nudge laggards to actually modernize their source code a little bit
> >>> and gain some benefits from that along the way?
> >>
> >> I'm completely fine with nudging people towards the newer features, an=
d
> >> I think the compile-time deprecation warning when someone is using the
> >> old-style map definitions in their BPF programs is an excellent way to
> >> do that.
> >>
> >> I'm also fine with libbpf *by default* refusing to load programs that
> >> use the old-style map definitions, but if the code is removed complete=
ly
> >> it becomes impossible to write general-purpose loaders that can handle
> >> both old and new programs. The obvious example of such a loader is
> >> iproute2, the loader in xdp-tools is another.
> >
> > This is because you want to deviate from underlying BPF loader's
> > behavior and feature set and dictate your own extended feature set in
> > xdp-tools/iproute2/etc. You can technically do that, but with a lot of
> > added complexity and headaches. But demanding libbpf to maintain
> > deprecated and discouraged features/APIs/practices for 10+ years and
> > accumulate all the internal cruft and maintenance burden isn't a great
> > solution either.
> >
> > As of right now, recent 0.x libbpf versions do support "old and new
> > programs", so there is always that option.
> >
> >>
> >>> It's the same thinking with stricter section names, and all the other
> >>> backwards incompatible changes that libbpf 1.0 will do.
> >>
> >> If the plan is to refuse entirely to load programs that use the older
> >> section names, then I obviously have the same objection to that idea :=
)
> >
> > I understand, but I disagree about keeping them in libbpf
> > indefinitely. That's why we have a major version bump at which point
> > backwards compatibility isn't guaranteed. And we did a lot to make
> > this transition smoother (all the libbpf_set_strict_mode()
> > shenanigans) and prepare to it (it's been almost a year now (!), and
> > we still have few more months).
> >
> >>
> >>> If you absolutely cannot afford to drop support for all the
> >>> to-be-removed things from libbpf, you'll have to stick to 0.x libbpf
> >>> version. I assume (it will be up to disto maintainers, I suppose)
> >>> you'll have that option.
> >>
> >> As in, you expect distributions to package up the old libbpf in a
> >> separate package? Really?
> >
> > NixOS indicated that they are planning to do just that ([0]). Is it a
> > problem to keep packaging libbpf.so.0 and libbpf.so.1 together?
> >
> >   [0] https://github.com/libbpf/libbpf/issues/440#issuecomment-10160840=
88
> >
> >>
> >> But either way, that doesn't really help; it just makes it a choice
> >> between supporting new or old programs. Can't very well link to two
> >> versions of the same library...
> >
> > Oh, you probably can with dynamic shared library loading, but yeah,
> > big PITA for sure. But again, v0.x libbpf supports "new programs" for
> > current definition of new, if you absolutely insist on supporting
> > deprecated BPF object file features. I'd be happy if you could instead
> > nudge your users to modernize their BPF game and prepare for libbpf
> > 1.0 early, though. They can do that easily do to the extra work that
> > we did for libbpf 1.0 transition period.
> >
> >>
> >> I really don't get why you're so insistent on removing that code eithe=
r;
> >> it's not like it's code that has a lot of churn (by definition), nor i=
s
> >> it very much code in the first place. But if it's a question of
> >
> > There is enough and it is a maintenance burden. And will be forever if
> > we don't take this chance to shed it and move everyone to better
> > designed approaches (BTF-based maps), which, BTW, were around for
> > about 2 years now. Hardly a novelty.
> >
>
> And it does not work everywhere.

It does, see below.

>
> When support for libbpf was added to iproute2, my biggest concern was
> the stability of the library -- that exported APIs and supported
> features would be arbitrarily changed and that is exactly what you are
> doing with this push to v1.0. iproute2 cares about forward and backward
> compatibility. If a tc program loads and runs on kernel version X with
> iproute2 version Y, it should continue to work with kernel version X+M
> and iproute2 version Y+N. No change should be required to the program at
> all.
>
> In this specific example, you are not removing support for old map
> definitions for security reasons or bug reasons; you want to remove it
> because there is a new definition and removing support for the older
> definition forces people to move to the new style. You are trying to
> force people to use a feature they may not care about at all or even need=
.

It is a maintenance burden. Its implementation is also more
error-prone due to blind interpretation of bytes (there is still a
TODO comment from *2016-11-15* mentioning the need to detect an array
of maps and report error; guess what, it never got implemented). Don't
know if you'd like to classify it as either security or bug related.
Doesn't really matter.

Also, it's confusing for new BPF users to have two ways of defining
maps when one is strictly better and is more future-proof.

>
> Ubuntu 18.04 is an LTS and will be around for a long time. ebpf programs
> build and work just fine but the OS does not support BTF. Deprecating

Good for Ubuntu 18.04, but kernel support and knowledge of BTF (I
assume that's what you meant by "OS support") has absolutely nothing
to do with BTF-defined maps. BTF in BTF-defined maps is used by libbpf
itself to parse the definition of the map. If the kernel supports BTF
and map definition provides types of keys and values, then yes, that
BTF will be *optionally* provided to the kernel as well to assist
tooling like bpftool. Libbpf goes to great length to do this very
seamlessly and painlessly for end users.

> support for older maps means people using say 18.04 and 22.04 can not
> use the same object files on both servers which means code bases have to
> deal with differences in definitions and build rules. Not user friendly
> at all.

Not true, which I hopefully explained clearly above.

>
> glibc manages to retain support for old system calls even as new
> variants are added. That is part of the burden a library takes on for
> its users. Your forced deprecation in short time windows (and 2 years is
> a very short time window for OS'es) is just going to cause headaches -
> like splits where code bases have to jump through hoops to stay on pre-1.=
0.

Let's agree to disagree about 2 years being a very short time window.
Also libbpf is not an OS. Also not sure which hoops you mean to stay
on libbpf.so.0, if necessary. I'm not even mentioning how much simpler
and user-friendlier it is to use statically linked libbpf, having full
control over which exact version and features are available to
iproute2 and its users. I doubt we'll ever see eye to eye on this one.
