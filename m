Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40565F31D
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAERsh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjAERX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 12:23:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50269521
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 09:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64743B819C1
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 17:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D57BC433F1
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672939036;
        bh=CRoT2a99GRhh3fpktEOzQz4vLaferYuk4IPytTP0pOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i0ocL4roCTLvA2W3rvOSHk4p0uoUnx2ih7/vd3kV0RcDPAxuF6OqJ87cffsMwsM14
         a/bXI98SWWNSbceQAb3LDHTNzjS6QFm8Aq/bD1TbzDtzTpgr/hfWp5f/oJDFKzvoh7
         y8SRYBf1IP85RffFVfwGpBuzxl9tILyTlmK4hKles7X6FNkviqrjAngEOVWv0PS6Bx
         K+4tYMJJbbkkTQX6JFhgBl/S0Yk2IDwQT7ArqbfoNK8nlBa2OjRM6FuG3A1QUe5nxX
         DbpZu6En+ajjdgP4MKhN1te70qVgzN3RqIGHVUdvPrVL7BCB18YpkNrNO79qWdkRcI
         otp1anqtsSa3g==
Received: by mail-ed1-f52.google.com with SMTP id i15so53762523edf.2
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 09:17:16 -0800 (PST)
X-Gm-Message-State: AFqh2kpF+YH/f77MTeQSyZZWGV6SCpWwiWCchUCw6HYVSG5rQ4LyLcBi
        Ixf+W6hEHZ8JaRnGwcpqsMbOfd/9sGe3BSLTZd7nmA==
X-Google-Smtp-Source: AMrXdXuj1F1wYCjPM4ZygLyIdwpvtP5vo3DBTW71CZq8y+Em1VQVHhqwW50vIZktvQineqX7pyw4oJvBplNIfsa+ZF4=
X-Received: by 2002:a05:6402:2710:b0:481:6616:bff3 with SMTP id
 y16-20020a056402271000b004816616bff3mr4049672edd.162.1672939034378; Thu, 05
 Jan 2023 09:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net> <20230104193735.ji4fa5imvjvnhrqf@macbook-pro-6.dhcp.thefacebook.com>
 <5cde0738-67d3-ca70-d025-cbd1769b0900@linux.dev>
In-Reply-To: <5cde0738-67d3-ca70-d025-cbd1769b0900@linux.dev>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 5 Jan 2023 18:17:03 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4WEZ8J5-3L=e3TV0qGi=Xx9bEiDEYsOnOio4gnz5D_0A@mail.gmail.com>
Message-ID: <CACYkzJ4WEZ8J5-3L=e3TV0qGi=Xx9bEiDEYsOnOio4gnz5D_0A@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 5, 2023 at 1:14 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/4/23 11:37 AM, Alexei Starovoitov wrote:
> > Would you invest in developing application against unstable syscall API? Absolutely.
> > People develop all tons of stuff on top of fuse-fs. People develop apps that interact
> > with tracing bpf progs that are clearly unstable. They do suffer when kernel side
> > changes and people accept that cost. BPF and tracing in general contributed to that mind change.
> > In a datacenter quite a few user apps are tied to kernel internals.
> >
> >> Imho, it's one of BPF's strengths and
> >> we should keep the door open, not close it.
> > The strength of BPF was and still is that it has both stable and unstable interfaces.
> > Roughly: networking is stable, tracing is unstable.
> > The point is that to be stable one doesn't need to use helpers.
> > We can make kfuncs stable too if we focus all our efforts this way and
> > for that we need to abandon adding helpers though it's a pain short term.
> >
> >>>> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> >>>> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> >>> "Proper BPF helper" model is broken.
> >>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> >>>
> >>> is a hack that works only when compiler optimizes the code.
> >>> See gcc's attr(kernel_helper) workaround.
> >>> This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> >>> And because it's uapi we cannot even fix this
> >>> With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> >>> These tools don't exist yet, but we have a way forward whereas with helpers
> >>> we are stuck with -O2.
> >> Better debugging tools are needed either way, independent of -O0 or -O2. I don't
> >> think -O0 is a requirement or barrier for that. It may open up possibilities for
> >> new tools, but production is still running with -O2. Proper BPF helper model is
> >> broken, but everyone relies on it, and will be for a very very long time to come,
> >> whether we like it or not. There is a larger ecosystem around BPF devs outside of
> >> kernel, and developers will use the existing means today. There are recommendations /
> >> guidelines that we can provide but we also don't have control over what developers
> >> are doing. Yet we should make their life easier, not harder.
> > Fully fleshed out kfunc infra will make developers job easier. No one is advocating
> > to make users suffer.
>
> It is a long discussion. I am replying on a thread with points that I have also
> been thinking about kfunc and helper.
>
> I think bpf helper is a kernel function but helpers need to be defined in a more
> tedious form. It requires to define bpf_func_proto and then wrap into
> BPF_CALL_x. It was not obvious for me to get around to understand the reason
> behind it. With kfunc, it is a more natural way for other kernel developers to
> expose subsystem features to bpf prog. In time, I believe we will be able to
> make kfunc has a similar experience as EXPORT_SYMBOL_*.
>
> Thus, for subsystem (hid, fuse, netdev...etc) exposing functions to bpf prog, I
> think it makes sense to stay with kfunc from now on. The subsystem is not
> exposing something like syscall as an uapi. bpf prog is part of the kernel in
> the sense that it extends that subsystem code. I don't think bpf needs to
> provide extra and more guarantee than the EXPORT_SYMBOL_* in term of api. That
> said, we should still review kfunc in a way that ensuring it is competent to the
> best of our knowledge at that point with the limited initial use cases at hand.
> I won't be surprised some of the existing EXPORT_SYMBOL_* kernel functions will
> be exposed to the bpf prog as kfunc as-is without any change in the future. For
> example, a few tcp cc kfuncs such as tcp_slow_start. They are likely stable
> without much change for a long time. It can be directly exposed as bpf kfunc.
> kfunc is a way to expose subsystem function without needing the bpf_func_proto
> and BPF_CALL_x quirks. When the function can be dual compiled later, the kfunc
> can also be inlined.
>
> If kfunc will be used for subsystem, it is very likely the number of kfunc will
> grow and exceed the bpf helpers soon.  This seems to be a stronger need to work
> on the user experience problems about kfunc that have mentioned in this thread
> sooner than later. They have to be solved regardless. May be start with stable
> kfunc first. If the new helper is guaranteed stable, then why it cannot be kfunc
> but instead needs to go through the bpf_func_proto and BPF_CALL_x?  In time, I
> hope the bpf helper support in the verifier can be quieted down (eg.
> check_helper_call vs check_kfunc_call) and focus energy into kfunc like inlining
> kfunc...etc.


Sorry, I am late to this discussion. The way I read this is that
kfuncs and helpers are implementation details and the real question is
about the stability and mutability of the helper methods.

I think there are two kinds of BPF program developers, and I might be
oversimplifying to convey a point here:

[1] Tracing people: They craft tracing programs and are more
accustomed to probing deeper into kernel internals, handling variable
renames and consequently will tolerate a kfunc changing its signature,
being renamed or disappearing.

[2] Network people: They are not accustomed to mutability the same way
as the tracing people. If there is mutability here, these users will
face a change in developer experience.

I see two paths forward here:

[a] We want to somewhat preserve the developer experience of [2] and
we find a way to do somewhat stable APIs. kfuncs have the benefit that
they are eventually mutable, but a longer stability guarantee for
helpers used by [2] could ameliorate the pains of mutability. e.g.
something we could do for certain helpers is a deprecation story, e.g.
a kfunc won't change for X kernel versions, or when we annotate kfuncs
as deprecated, libbpf can warn users "this kfunc is going away in
kernel version Z").

If this would be difficult to guarantee and we do care about developer
experience, we might need to have some helpers exposed as UAPI.

[b] We accept the fact the user experience will change more for [2]
and that's a trade-off we accept. IMHO, this is not ideal and while
tracing folks have found a way to cope, it would be yet another thing
to worry about for folks who are not used to it.

There are things we can do to make it slightly less burdensome for the
user by adding a shim in BPF headers (however, it won't solve problems
for everyone though e.g. inline BPF, other languages but will give
them a template for their respective "shims").

Another thing to consider if there are use-cases where some users
disable BTF (for whatever reason, like running BPF in a pacemaker :P
or in extremely low memory cases).
