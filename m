Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34C666A4E
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 05:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjALE3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 23:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbjALE2X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 23:28:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DA5275A
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 20:24:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy8so41752460ejc.13
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 20:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+hZH6WG0gRLUDgHjb9mbmBa5HsD8qGEjjMfPdC+Jow=;
        b=Ve2EIWvLNDrqsIjsXMeeN3RB+l0zF1v8MfqZ1C3OuKmaQBUIx7/6IVVSeFDsHy/rQa
         upAUU/7tzbkG/VsI0nbZ5dn0rzqAdf5KLBfAT13byHo9w+zArX6NvIr1ZEv6GM3usG6o
         suLomJLpk6unBfDBYdHSpq8fiVHgB1aVT2+dE+XUB4H5YOXV4mIMW8b2VCux8nTlRF4D
         rWWY//k9RwfxXx2UqrJJkSqJYNFgTM0ihyw2Ux69uWaBBuehYvNB1GvqzmXEkSfXi9e5
         www15+ggwmetvCxG+dtT9KjTtU3NFEY3bG3eIALiQJm0zOgwZDFDMyE7xQz+SUuzlGi3
         ep0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+hZH6WG0gRLUDgHjb9mbmBa5HsD8qGEjjMfPdC+Jow=;
        b=UCiQoXKsO+pfcv2CMeDsV+Ljg7s8M/6INGzVr3FcSJpU7tWd88DTLJ1BGxRIjJ8bCn
         AAGepolUD8Dp+z0GnRLbWQnSjlauWhlR1i8Hc/DsAk7MgKgHhCCPm68hI9c/Yhjl23lI
         GrvOqXMT8BihBd3nPR9IVXf1HUb+hNRRtdrs8mWMpzdmu5Jlil8/Q+AxVbYPxBn4fRdj
         CUXpBNqUS07XZLRHAUxvX4BhTwKDKxsmB+7EQ0fH492N/XSGI8Ff7kCt1MMRSai5IcXU
         7ha34EpJkNNqtJkq6bD+nA2bRUowIyJMddt+UnJ/kmsQeY6QsbtwQYApJkOYyjGIRQ/t
         HgLQ==
X-Gm-Message-State: AFqh2kqpZ346233udO0mED569lpqBMsCAzakgwTM2u08+LQu3Ia/mPWJ
        KmjpuiccfoupRIV7IgHij5vtHCrEFvxicN6WLvA=
X-Google-Smtp-Source: AMrXdXuB6bwXZ2okMc0kDTyf9VZntbbCschkYHsY5QfTazmsOFs8okdhZnjzGYMjDxn8N15z/X2Xs7ZnHIyBpxAfp00=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr5188844ejy.327.1673497447181; Wed, 11
 Jan 2023 20:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
 <Y7YQHC4FgYuLWmab@maniforge.lan> <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
 <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local> <CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com>
 <CAPhsuW4ix_Q_nBSMnOzQr3GJAozN0PUcgh2K=4mcYpUXQDTYYg@mail.gmail.com>
In-Reply-To: <CAPhsuW4ix_Q_nBSMnOzQr3GJAozN0PUcgh2K=4mcYpUXQDTYYg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 Jan 2023 20:23:55 -0800
Message-ID: <CAADnVQJOrxwMJMrb8EmvsVbhwWF3HGAxR95BUi1WjoTxbrGOHg@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Song Liu <song@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
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

On Wed, Jan 11, 2023 at 1:29 PM Song Liu <song@kernel.org> wrote:
>
>  ()
>
> On Mon, Jan 9, 2023 at 9:47 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 5, 2023 at 6:54 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 05, 2023 at 01:01:56PM -0800, Andrii Nakryiko wrote:
> > > > Didn't find the best place to put this, so it will be here. I think it
> > > > would be beneficial to discuss BPF helpers freeze in BPF office hours.
> > > > So I took the liberty to put it up for next BPF office hours, 9am, Jan
> > > > 12th 2022. I hope that some more people that have exposure to
> > > > real-world BPF application and pains associated with all that could
> > > > join the discussion, but obviously anyone is welcome as well, no
> > > > matter which way they are leaning.
> > > >
> > > > Please consider joining, see details on Zoom meeting at [0]
> > > >
> > > > For the rest, please see below. I'll be out for a few days and won't
> > > > be able to reply, my apologies.
> > > >
> > > >   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=0
> > >
> > > Thanks for adding it to the agenda.
> > > Hopefully we'll be able to converge faster on a call.
> >
> > Yep, hopefully. Looking forward to BPF office hours this week.
> >
> > >
> > > There are several things to discuss:
> > > 1. whether or not to freeze helpers.
> > > 2. whether dynptr accessors should be helpers or kfuncs.
> > > 3. whether your future inline iterators should be helpers or kfuncs.
> > > 4. whether cilium's bpf_sock_destroy should be helper or kfunc.
>
> I think these are all big questions. Maybe we can start with some
> smaller questions? Here is a list of questions I have:
>
> 1. Do we want stable kfuncs (as stable as helpers)? Do we want
>    almost stable kfuncs?

Yes. We've touched on some of that earlier.
We can talk about a range:
unstable, deprecated, starting to deprecate, stable
plus orthogonal versioning scheme.

> Will most users of stable APIs be as happy
>    with almost stable alternatives?

kfuncs are very much analogous to EXPORT_SYMBOL_GPL.
There is no versioning scheme, nor deprecation scheme for that.
Yet in-kernel and out-of-tree users have been dealing with it.
There are kABI things that make things stable to various degrees.
So 'happy' is relative.
Using that analogy...
In-kernel bpf progs won't care. unstable or not they will get
carried along automatically when kfuncs change.
Out of tree bpf progs can be divided to kernel dependent
and kernel independent. The former are similar to in-tree
with extra pain that can be mitigated with kfunc detection.
The latter will always use stable with understandable deprecation path.
Yet it's all in theory.
In practice networking folks are using conntrack kfuncs and
xfrm kfuncs assuming we will make it all work somehow,
though right now we're saying kfuncs are unstable only.

So 'happy' and 'pain' are relative depending on the usefulness
of kfunc. If bpf prog needs a feature it will use it.
If it's a shiny new feature, the prog authors might wait
until kfunc stabilizes.
Which is exactly the point.
We can wish for something to be useful, but we won't know
until we actually use it for real and not in some selftest.

And it becomes chicken and egg. If it's a cool new feature
the bpf prog wants it to be stable to rely on it later,
but because it's so new it's not clear whether it's actually useful,
so we shouldn't be declaring it stable and cause kernel pains.

> 2. Do we decide the stability of a kfunc when it is first added? Or
>     do we plan to promote (maybe also demote?) stability later?

Claiming that something is stable on day one
is a subjective opinion of the developer who's adding that feature.
There could even be a giant user space project next to it
attempting to use that feature, but we've seen that with other
uapi-s in the past.

> 3. Besides stability, what are the concerns with kfuncs? How hard
>     is it to resolve them?
>     AFAICT, the concerns are: require BTF, require trampoline.

Only the former. kfuncs do not require bpf trampoline.

$ git grep bpf_jit_supports_kfunc_call
arch/arm64/net/bpf_jit_comp.c:bool bpf_jit_supports_kfunc_call(void)
arch/loongarch/net/bpf_jit.c:bool bpf_jit_supports_kfunc_call(void)
arch/x86/net/bpf_jit_comp.c:bool bpf_jit_supports_kfunc_call(void)
arch/x86/net/bpf_jit_comp32.c:bool bpf_jit_supports_kfunc_call(void)

iirc I've seen the patches for risc-v and arm32.

>     Anything else? I guess we will never remove BTF dependency.
>     Trampoline dependency is hard to resolve, but still possible?
>
> 4. We have feature-rich BPF with Linux-x86_64. Do we need some
>    bare-minimal BPF, say for Linux-MIPS, or Windows-ARM, or
>    even nvme-something? I guess this is also related to the BPF
>    standard?

It's not related to ISA standardization.
We're not even talking about BTF standardization.
Nor about psABI (calling convention and such).
It's going to happen much much later.
