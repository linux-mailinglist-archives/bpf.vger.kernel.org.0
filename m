Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336865DF60
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 22:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjADV5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 16:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbjADV5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 16:57:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE934741
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 13:57:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so85880030ejm.8
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IXIQ5EZidnsDKRb1e70VHwZObXiiLQTv7QOCJ8AKqm0=;
        b=FzojvtIVvzyYWgGZUE8WYyZf8yttiCdCGNNWRL6LeMqsyPCzRBDySoDNYF/gEtqy8E
         eo/0uV7EGV//A9oLCUQyhx1thxsSejCTOhPeLbE156cDCTxTbVozmwHyh/KbrLaocCxm
         ONXS1t4YFZoUzSkGIEEvE8UDtBLBrE9JheUz6vtEN0pDj8OF9BUljMynC9c/KwqnGK4x
         Iesm6W8cyYd+SnExat5eMjF6HtR5kdqlzawsm9FKm6nQrLU5crl3qGpDWE70sFY24NYE
         vFY/f7YravuVxuTO95iz4j0pf3ozZg5lAF+vOlTxxUrak2pewURFl8jooZtwC+7UUTtZ
         JFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXIQ5EZidnsDKRb1e70VHwZObXiiLQTv7QOCJ8AKqm0=;
        b=3hmRSshNAD2AztrFGiLaiLfTv21LSp7xPBnfuOnNkmVl4RhCfNa3G109g9dtic3dIc
         teIEoTpOGASvwrWPXNADLesJ93MHPHsma7moEfNBnIRF9O03QpvnvqomT4Jzti/CllsX
         aad5iSLGp757H8rUpyJjPsfMdD4x7VG5aBBUAdaJ6f1o/cSEHadR+2twoH57f5YL736+
         7CH4eCepK69+jD7QlHdS8aAgmG1XbyjKPKoeYd15hNm8LKNFF4emMeFWYEpw3o7pxjjk
         L6SgiGvw23C763H6Phj9NYK5z5BGTwydWqfulw49Ye8Gcgm8ucatM9jajxa4V83ZLqdw
         gE/g==
X-Gm-Message-State: AFqh2ko34nWQ2hXaXUk5N7n8fI3muT4ph8ReXkwKwYhrfYIQta24npsB
        i65Al58Z+1ksOHLZGVdtA13ZvXBGkl5zQWHwPcA=
X-Google-Smtp-Source: AMrXdXvF8SmcElLif+YnVsle7Afv0WKcYd7j11fGR95psquAU7z6KkK5Vm79w1FlZQscSyqDXfRz69TDrLc2WCW5HMI=
X-Received: by 2002:a17:906:f209:b0:7fd:f0b1:c8ec with SMTP id
 gt9-20020a170906f20900b007fdf0b1c8ecmr3176153ejb.114.1672869419863; Wed, 04
 Jan 2023 13:56:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com>
 <20230104195138.q43ioskabs4c32py@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230104195138.q43ioskabs4c32py@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 13:56:47 -0800
Message-ID: <CAEf4Bzas8USa0k2Qcfc0p8dWjRUAdoD6ogeM=Mbp7eLdpL29jw@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Jan 4, 2023 at 11:51 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 10:43:52AM -0800, Andrii Nakryiko wrote:
> >
> > struct bpf_dynptr dptr = ...;
> > bool is_null = false;
> >
> > if (bpf_core_value_exists(enum bpf_func_id, BPF_FUNC_dynptr_is_null)) {
> >     is_null = bpf_dynptr_is_null(&dptr);
> > } else {
> >     struct bpf_dynptr_kern *kdptr = (void*)&dptr;
> >     is_null = !!BPF_CORE_READ(kdptr, data);
> > }
> >
> > How do you detect the existence of kfunc today? Preferably without
> > doing extra work in user-space.
> >
> > Now, let's say kfunc changes its signature. Show me a short example on
> > how you deal with that in BPF C code?
>
> Didn't we add bpf_core_type_matches for func protos specifically
> to deal with function signature changes in the kernel after tracepoint
> args got swapped?
> I'm assuming the same mechanism will work for kfuncs.
> If not we can come up with a new one.

It would be good if someone actually try that and see if it works, and
if it doesn't, to come up with an approach that does. Right now I just
see hand-wavy arguments that BPF helpers and BPF kfuncs are equivalent
in this regard. Which currently I'm afraid they are not.

>
> >
> > Think about sched_ext. Right now it's so bleeding edge that you have
> > to assume the very latest and freshest kernel code. So you know all
> > the kfuncs that you need should exist otherwise sched_ext doesn't work
> > at all. Ok, happy place.
> >
> > Now a year or two passes by. Some kfuncs are added, some are changed.
> > We still believe that BPF CO-RE (compile once - run everywhere) is
> > good and we don't want to compile and distribute multiple versions of
> > BPF application, right? You'll want to do some extra (or more
> > performant) stuff if kernel is recent and has some new kfunc, but
> > fallback to some default suboptimal behavior otherwise. How do you do
> > that in a simple and straightforward way?
>
> with a help of CORE, of course.
> If it doesn't exist today we can add it.
>
> > But even worse is what if
> > some critical kfunc is changed between kernel versions and you do

How about this one? I'm honestly curious to see someone try and figure
out what works and what doesn't.

> > *need* to support both versions. Think about those aspects, because
> > sched_ext will run into them almost inevitably soon after its
> > inclusion into kernel.
> >
> >
> > One way or another there are some technical solution of various
> > degrees of creativity. And I'm actually not sure if I have a solution
> > for kfunc signature change at all. Without BTF we could use two
> > separate .c files and statically link them together, which would work
> > because extern is untyped in pure C. But with BPF static linking we do
> > have BTF information for each extern, and those BTF types will be
> > incompatible for the same extern func.
> >
> > We can probably come up with some hacks and conventions, as usual, but
> > better start thinking about them now.
> >
> > But hopefully you can empathize a bit more with poor end users that
> > have to do hack like this and why having bpf_dynptr API defined as
> > stable BPF helpers, with no extra dependencies on BTF in kernel,
>
> BTF is a reasonable dependency.
> You've just used it to detect whether helper exists or not.
> So it's fine to use the same to check whether kfunc exists or not.

BTFGen doesn't require kernel to be built with BTF, and yet I get BPF
CO-RE stuff. But you are jumbling everything together. I don't need
BPF CO-RE to build a useful BPF application that needs to use
ringbuf+dynptr (think uprobe'ing of some app, USDTs, etc), yet we will
require BTF for no reason.

Just as you are afraid of not getting UAPI right because we can't
anticipate possible changes, let's be just as much afraid of
unnecessary dependencies, which can be a blocker or pain for some
users in some situations. Isn't that fair?

>
> >
> > Depends on perspective. If I was some humble dev trying to build
> > BPF-based tool that should work on x86, arm64, s390x, and riscv (or
> > whatever other architecture), and dynptr API is only based on kfuncs,
> > I'm screwed. I can't sponsor or do kfunc support for my favorite
> > architecture, I'm stuck waiting for this to be done by someone some
> > time, if ever.
>
> If kfuncs and bpf trampoline don't work on a particular architecture
> that developer is likely screwed anyway. Dynptr is the last thing they
> would worry about.

uprobe+dynptr+ringbuf is all I need for useful apps. Likely or not can
be argued to the end of times.
