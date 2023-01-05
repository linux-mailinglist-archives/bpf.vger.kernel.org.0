Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849E465F57A
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjAEVEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 16:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEVEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 16:04:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A36360CFC
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 13:04:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so92787247ejc.12
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KnLN5bJklK26mKCAKIJayeUn7YGkJc/gqcU6xHvOyBU=;
        b=RxtEPk3zOpjBWxxTB6idpRERGRVuHC65+JxlFHMPxUGhyZHpnGdHFX1AAgr6Q8FQvn
         Us2hsewcf4cAcyFoSbsOYu0kOEa3crAOlLoyaJkkQ5YTp2T6RnsS4hLuqgYczr8iQSC6
         GEZIusTw6tBHhbksfzdWZbMOKW24Jgj8Rgvx60D4aGjkXg0kDhA5MMgtslaHXX89+rk5
         2qQFpm49sxhT2MFeJYbpg7YcolJ1coU8I39deBlWjugRdAv15gKU9LxNaM7J8drISrfg
         RYu3nASpMt4RRm9Drdsu8601UK9g/V1fLfNsgPKxENiqrCkPI6Rrga3i4YvCNKiGgld0
         BBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnLN5bJklK26mKCAKIJayeUn7YGkJc/gqcU6xHvOyBU=;
        b=zmuWLX5NLWv0JIx3Uc69YBG+pquKHN3HyUQn+4ZIyjwX3d/U0z/usDlpmA4ZoCUcIr
         emxRx6nB8SHeXaXRiYtVGsGNl2LQZ0vZ5yF5l8PkSy6Lk8rwAQN2R+w2cHCfvSsEPisg
         FsjDEoERrx4kv6RitChKgdReMwtAEw9dkbQk5+XMHJiQmJkD3GO3Ubnyi1oF+TXzX7RM
         aTFrRqSGTwb4D3IJp1EyDHmg73CYqakEAYgIpdHE8VqJDyqdK7erTHPYdsC/AVjU6pCs
         79/ssQjUGuPM26Lj+yq4xDW6PbbwZeWtxFRicRYB2hJ7FoboT9HiYIHUi4EjnGqK8ift
         Q7xA==
X-Gm-Message-State: AFqh2kqWllpDsK18dhM/MzSSFNnqAlw2TLs+mX9PNxaw3OFXYpfglSM3
        74qDf78x2jpdd3uLcZE3UC2z58FOY0pBlnVJeZc=
X-Google-Smtp-Source: AMrXdXsa6ocnVn2rWD+Q4QLDNiMCedPOrXeflUPHqMk0rAoAFab0hQpLxQ71P+Ahg4ZQfP0txn/U9FgNSsNFgzDAdhA=
X-Received: by 2002:a17:906:a014:b0:7c1:8450:f964 with SMTP id
 p20-20020a170906a01400b007c18450f964mr5014496ejy.176.1672952641848; Thu, 05
 Jan 2023 13:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net> <20230104193735.ji4fa5imvjvnhrqf@macbook-pro-6.dhcp.thefacebook.com>
 <5cde0738-67d3-ca70-d025-cbd1769b0900@linux.dev> <CACYkzJ4WEZ8J5-3L=e3TV0qGi=Xx9bEiDEYsOnOio4gnz5D_0A@mail.gmail.com>
In-Reply-To: <CACYkzJ4WEZ8J5-3L=e3TV0qGi=Xx9bEiDEYsOnOio4gnz5D_0A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Jan 2023 13:03:49 -0800
Message-ID: <CAEf4Bza=HHoDPgeNTWzVhKtpAK=qTF--VHZxLnRc3uJGEdzVoQ@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     KP Singh <kpsingh@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>
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

On Thu, Jan 5, 2023 at 9:17 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Jan 5, 2023 at 1:14 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 1/4/23 11:37 AM, Alexei Starovoitov wrote:
> > > Would you invest in developing application against unstable syscall API? Absolutely.
> > > People develop all tons of stuff on top of fuse-fs. People develop apps that interact
> > > with tracing bpf progs that are clearly unstable. They do suffer when kernel side
> > > changes and people accept that cost. BPF and tracing in general contributed to that mind change.
> > > In a datacenter quite a few user apps are tied to kernel internals.
> > >
> > >> Imho, it's one of BPF's strengths and
> > >> we should keep the door open, not close it.
> > > The strength of BPF was and still is that it has both stable and unstable interfaces.
> > > Roughly: networking is stable, tracing is unstable.
> > > The point is that to be stable one doesn't need to use helpers.
> > > We can make kfuncs stable too if we focus all our efforts this way and
> > > for that we need to abandon adding helpers though it's a pain short term.
> > >
> > >>>> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> > >>>> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> > >>> "Proper BPF helper" model is broken.
> > >>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> > >>>
> > >>> is a hack that works only when compiler optimizes the code.
> > >>> See gcc's attr(kernel_helper) workaround.
> > >>> This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> > >>> And because it's uapi we cannot even fix this
> > >>> With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> > >>> These tools don't exist yet, but we have a way forward whereas with helpers
> > >>> we are stuck with -O2.
> > >> Better debugging tools are needed either way, independent of -O0 or -O2. I don't
> > >> think -O0 is a requirement or barrier for that. It may open up possibilities for
> > >> new tools, but production is still running with -O2. Proper BPF helper model is
> > >> broken, but everyone relies on it, and will be for a very very long time to come,
> > >> whether we like it or not. There is a larger ecosystem around BPF devs outside of
> > >> kernel, and developers will use the existing means today. There are recommendations /
> > >> guidelines that we can provide but we also don't have control over what developers
> > >> are doing. Yet we should make their life easier, not harder.
> > > Fully fleshed out kfunc infra will make developers job easier. No one is advocating
> > > to make users suffer.
> >
> > It is a long discussion. I am replying on a thread with points that I have also
> > been thinking about kfunc and helper.
> >
> > I think bpf helper is a kernel function but helpers need to be defined in a more
> > tedious form. It requires to define bpf_func_proto and then wrap into
> > BPF_CALL_x. It was not obvious for me to get around to understand the reason
> > behind it. With kfunc, it is a more natural way for other kernel developers to
> > expose subsystem features to bpf prog. In time, I believe we will be able to
> > make kfunc has a similar experience as EXPORT_SYMBOL_*.
> >
> > Thus, for subsystem (hid, fuse, netdev...etc) exposing functions to bpf prog, I
> > think it makes sense to stay with kfunc from now on. The subsystem is not
> > exposing something like syscall as an uapi. bpf prog is part of the kernel in
> > the sense that it extends that subsystem code. I don't think bpf needs to
> > provide extra and more guarantee than the EXPORT_SYMBOL_* in term of api. That
> > said, we should still review kfunc in a way that ensuring it is competent to the
> > best of our knowledge at that point with the limited initial use cases at hand.
> > I won't be surprised some of the existing EXPORT_SYMBOL_* kernel functions will
> > be exposed to the bpf prog as kfunc as-is without any change in the future. For
> > example, a few tcp cc kfuncs such as tcp_slow_start. They are likely stable
> > without much change for a long time. It can be directly exposed as bpf kfunc.
> > kfunc is a way to expose subsystem function without needing the bpf_func_proto
> > and BPF_CALL_x quirks. When the function can be dual compiled later, the kfunc
> > can also be inlined.
> >
> > If kfunc will be used for subsystem, it is very likely the number of kfunc will
> > grow and exceed the bpf helpers soon.  This seems to be a stronger need to work
> > on the user experience problems about kfunc that have mentioned in this thread
> > sooner than later. They have to be solved regardless. May be start with stable
> > kfunc first. If the new helper is guaranteed stable, then why it cannot be kfunc
> > but instead needs to go through the bpf_func_proto and BPF_CALL_x?  In time, I
> > hope the bpf helper support in the verifier can be quieted down (eg.
> > check_helper_call vs check_kfunc_call) and focus energy into kfunc like inlining
> > kfunc...etc.
>
>
> Sorry, I am late to this discussion. The way I read this is that
> kfuncs and helpers are implementation details and the real question is
> about the stability and mutability of the helper methods.
>
> I think there are two kinds of BPF program developers, and I might be
> oversimplifying to convey a point here:
>
> [1] Tracing people: They craft tracing programs and are more
> accustomed to probing deeper into kernel internals, handling variable
> renames and consequently will tolerate a kfunc changing its signature,
> being renamed or disappearing.
>
> [2] Network people: They are not accustomed to mutability the same way
> as the tracing people. If there is mutability here, these users will
> face a change in developer experience.
>
> I see two paths forward here:

As I mentioned in another reply, I took a liberty to add "BPF helpers
freeze" as a topic for next BPF office hours. It's probably going to
be a bit more productive to discuss it there. WDYT?

>
> [a] We want to somewhat preserve the developer experience of [2] and
> we find a way to do somewhat stable APIs. kfuncs have the benefit that
> they are eventually mutable, but a longer stability guarantee for
> helpers used by [2] could ameliorate the pains of mutability. e.g.
> something we could do for certain helpers is a deprecation story, e.g.
> a kfunc won't change for X kernel versions, or when we annotate kfuncs
> as deprecated, libbpf can warn users "this kfunc is going away in
> kernel version Z").
>
> If this would be difficult to guarantee and we do care about developer
> experience, we might need to have some helpers exposed as UAPI.
>
> [b] We accept the fact the user experience will change more for [2]
> and that's a trade-off we accept. IMHO, this is not ideal and while
> tracing folks have found a way to cope, it would be yet another thing
> to worry about for folks who are not used to it.
>
> There are things we can do to make it slightly less burdensome for the
> user by adding a shim in BPF headers (however, it won't solve problems
> for everyone though e.g. inline BPF, other languages but will give
> them a template for their respective "shims").
>
> Another thing to consider if there are use-cases where some users
> disable BTF (for whatever reason, like running BPF in a pacemaker :P
> or in extremely low memory cases).

There are various embedded systems (which usually means stricter
memory requirements and less mainstream architectures) and people are
experimenting with them, trying to run libbpf-tools and such there, or
building their own tracing tools. I keep getting Github issues in
libbpf-bootstrap and libbpf about something not working on some
embedded system and it's absolutely unclear why. I'd rather not have
to debug stuff like this for dynptr or for the loop iterator.
