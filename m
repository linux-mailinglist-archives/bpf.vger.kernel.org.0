Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6A573CD4
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiGMS5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiGMS5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:57:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DEE18B20
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:57:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so10990310pfv.13
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkFQmGsbru9Qyqju1M+AezJ1aqo7yqN8f9bCsjdvsVs=;
        b=T7VQuRck9r0coxYfTzGoKSIsIaLRbm4MJ8uhbvy9ZC3Cv70mkMXNZJAGC9rjoRgR6b
         WgehuMgXrydhQbc+DhAxWT+U1/Nyb6Xv/VuWEFTnbs47TT+QOTAeIxJk/+Nd6ySdEDzK
         NFJgBp/PNLdRwwou52dhozGuMNSWbEl4QsWlrRNLPCY+K3IuKVU6lEbp/nS7CgUP8SBR
         b3oxnUo6sYf/WTipHAVxyy19spmJQHteDSsZ8By7cHPgc6c+ruZ6ws4uFC1R4C6nf7nS
         v7k/vZ3JSm0P2xa/BjCe57zICiK7rmj7GnckOKDuJ2LIk0WGcJizj1hsbtpIPLAJZhEW
         xmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkFQmGsbru9Qyqju1M+AezJ1aqo7yqN8f9bCsjdvsVs=;
        b=JlflY70JGohitwRYKiYCPuwxMm/5zn1QKOzXhm6UC6ebV37qPTZv2dI5sDSmfhhLXV
         4azn/dcCaFMIsxtkK18GC6S2TmbE9UAmx9vE3TPjOTKnFUmF1QqnPZA7hVdZgXThNQXa
         4t5s6edrBDDdoO0GFM8jD0h5qn+f5mj93laSmuBM50Z5zFnxKxCLJ0SWC8+W+wy0tFxt
         dVaGUTx+8LsmZcwBz5KHgRWkT4I4/HUy1mFIJcQ3z9nch4jTbEtLIajqT7O7nhEslnPs
         HDmcI934gICaAynrM8wKwzKlG9MJsgD30WeyyQCtl5IerLPYBTCs961LnUB0UGeUlFhS
         MVhw==
X-Gm-Message-State: AJIora+Oa1Br1Q5RlYaprFyUnN3blCN//XwMI7qsulA3h31CTAT++7vP
        fvoxyC7qWiBY14640yVD0IroltE5CgRMnsG1gFyZQ7gU81w=
X-Google-Smtp-Source: AGRyM1s36Q4f+8rEfRGBFjvsBqk+A3j1h4UbEcOCQKDkzeZAZEBl6LcaPCx2M11DaM3V+kHGCX9GLI6ugGopHT1nyI4=
X-Received: by 2002:a62:6d05:0:b0:528:99a2:b10 with SMTP id
 i5-20020a626d05000000b0052899a20b10mr4478543pfc.72.1657738661101; Wed, 13 Jul
 2022 11:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-6-andrii@kernel.org>
 <Ys7y5vCoSgiMW/p8@google.com> <CAEf4BzZsEcz+NroDFh+sEu_4wrgsJYPMjhuZS8FBuzkXC77jcg@mail.gmail.com>
In-Reply-To: <CAEf4BzZsEcz+NroDFh+sEu_4wrgsJYPMjhuZS8FBuzkXC77jcg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 11:57:30 -0700
Message-ID: <CAKH8qBvu1OEKkyt2joBO+DQDf0d=y-C8exa=Z3rbfQN2vymoGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 10:57 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 9:29 AM <sdf@google.com> wrote:
> >
> > On 07/12, Andrii Nakryiko wrote:
> > > Convert few selftest that used plain SEC("kprobe") with arch-specific
> > > syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> > > BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
> > > simplification.
> >
> > That looks super nice! I'm assuming the goal is probably
>
> Thanks!
>
> > to get rid of that SYS_PREFIX everywhere eventually? And have a simple
> > test that exercises fentry/etc parsing?
>
> All the other uses of SYS_PREFIX in selftests right now are
> fentry/fexit. If the consensus is that this sort of higher-level
> wrapper around fentry/fexit specifically for syscalls is useful, it's
> not a lot of work to add something like SEC("fsyscall") and
> SEC("fretsyscall") with the same approach.
>
> One possible argument against this (and I need to double check my
> assumptions first), is that with SYSCALL_WRAPPER used (which is true
> for "major" platforms like x86_64), fentry doesn't provide much
> benefit because __<arch>_sys_<syscall>() function will have only one
> typed argument - struct pt_regs, and so we'll have to use
> BPF_CORE_READ() to fetch actual arguments, at which point BPF verifier
> will lose track of type information. So it's just a slightly more
> performant (in terms of invocation overhead) kprobe at that point, but
> with no added benefit of BTF types for input arguments.
>
> But curious to hear what others think about this.

What would be nice (but not sure if possible, I haven't looked
closely), if these same ksyscall sections would pick the best
underlying implementation: if fentry is available -> attach to fentry,
if not -> fallback to kprobe (and do all this __<prefix>_sys vs __sys
dance behind the scenes). Any reasons the users should care if it's
really a kprobe or an fentry?



> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >   .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
> > >   .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
> > >   .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
> > >   3 files changed, 16 insertions(+), 32 deletions(-)
> >
>
> [...]
