Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288165F579
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAEVCo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 16:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjAEVCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 16:02:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C64A941
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 13:02:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c17so54419194edj.13
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NEznVkJLZKxkLenSC7+sPfFv2heI98TK5kDQB09/KE=;
        b=mZ8fQU/bYSDYA5BQwNL2arUC2KPzak6S0yU/Ww+Vr+LNjXzpnCOi2RNDvUIxO6+s6F
         V4ZHLoXEcY4b4eiKoBUCULI3Voc9Yp2p9BZfFhMKC8W9Y/XPP4Cv7MS04x4NEjHlZA3y
         3FnirOqZYH2KQgpcOj5m+G4SWED9P8TE+SDYX221d5c1cj8u6wU8kpfyGdYBwCQwE8Q0
         QxnjjVWhx+vxJ7+0A13Xj0/W+Ws1ubajqMibqgVJbg9eG7T66cGfBBOeF1h/G6pAOplr
         v+e0ABjRtHeMqXNp2gxPc2qoaxeuku2EU31jG/LiPD/C1gj4j9m64HCSFDWFEGf0byPe
         LzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NEznVkJLZKxkLenSC7+sPfFv2heI98TK5kDQB09/KE=;
        b=5jI4BDFflYUILqUDuAYYcvfNUXXgZB06g8M2W5TLHqBZ4vnaW9ioM4p2UWRNH403Y0
         Vs+MGvGzXSfseKYsL6YpKm4v6H2UNxhyRBbN+9DvTCyeRizOW/I1NuAMZow5SgZaxN6b
         odA4Jf38h7xPr+wNTh6N8ZweUEtX1eYHYLjOGbVnKva8Zz7OFtNJEh7/bNIqPPw7/Tsc
         L5/KWaDTS2iUnkCaZnmaF4/0nXzp9qHV9Wj5uwO5KTBhARZaCuyzTDdlB8fZkTGMrkHa
         RIfG45kXRXJIE90VwbTuzGRJdsRgvl3a56YT1OIuwMjMrWXs7pNYmn47iOi7A8rqhh7O
         xTFw==
X-Gm-Message-State: AFqh2krzic2GaL9LoUZkppTA3huao6dTIoAvBXvSIIzhQ3e51BV+/jvz
        5Lkdhby4OAXwVKP09OIAhoVktqDqMCpuBkx0pyS9X8mk
X-Google-Smtp-Source: AMrXdXs/VQAJd+pB4UE/j1Zmb0ZvovPv/oIJwdP75cAIUEdMFalRIny1V5u/Bzm27z4Zr5ST6ESiKHM1Hk/tHwi6H18=
X-Received: by 2002:a05:6402:5303:b0:486:d1fe:c9e5 with SMTP id
 eo3-20020a056402530300b00486d1fec9e5mr3250665edb.260.1672952553589; Thu, 05
 Jan 2023 13:02:33 -0800 (PST)
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
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Jan 2023 13:02:21 -0800
Message-ID: <CAEf4BzZOP=bAvrw4ATnfWKfkOgqdF2Aa7aXXVJVr3m2PpN73Dw@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Wed, Jan 4, 2023 at 4:13 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
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

This is subjective and there is no point in arguing about that. I find
BPF helper definitions more obvious and more discoverable, for
example. But it doesn't matter what I prefer personally.

Whatever the case might be, this is purely internal implementation
detail that can be improved and unified much more between helpers and
kfuncs, and it's way less important compared to stability and
usability issues brought up in this thread, as it has no bearing on
user's experience.

> behind it. With kfunc, it is a more natural way for other kernel developers to
> expose subsystem features to bpf prog. In time, I believe we will be able to
> make kfunc has a similar experience as EXPORT_SYMBOL_*.

The original goal for kfuncs was to just directly expose kernel
functions as is, but then we ended up adding allowlists, tuning them,
fixing them, reworking them. We are talking about different lists per
different program types, etc. But again, this is internal matters.

There is fundamentally no difference between how kfunc and helpers
can/should be defined, they are both kernel functions with additional
annotations. If we put work into it we can converge the mechanics of
how they are defined.


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
