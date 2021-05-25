Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB338F6E1
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhEYAOn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEYAOn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 20:14:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBDAC061756
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 17:13:14 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i4so40533385ybe.2
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxoF/OhyCblSv7rZJvfxMi33wUcTOJ7L8QU38DiTK8A=;
        b=NXo/z2VqQhMcEXrsuHEl0iblol2nPDw+Hea/qMVnySh45fua/xsByooRnHO/xdsrYb
         TQIit3wxO3ua1w08M5XLq7OTVCGxLxZz9t5lC7hULbyhuQUCyv+AISVuNhtOWmfHOA9S
         2+hHZ//oMicTIs0zLpuyqciDH5E6U7Inuo0Uzkf2dt6iqonuQlc1ipNzTLYE9e1KFePN
         WiLvkORSam0hNC/+atauA6od5BHyA1e2aEWEwzl+KiNK7q8SrUjK3ycpBF7vttlm1mJC
         jb84E4eYmMdNK46NdGotr0C74QgyWoRzsHrvBzfC5yaAiQNh1KVbHvbwJmjRP4y/mNfc
         ZmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxoF/OhyCblSv7rZJvfxMi33wUcTOJ7L8QU38DiTK8A=;
        b=ikjqos+ztPAS07d5XRE//5/8z4OFh0YKHSyJYoiS6++FEMrMEX5YOdHqZAEisFaaWp
         4iXp/681vHrOhJwxB91J6/lUkAg5VLcSE4PtNixUpuYx2kVLDDzlrIpKkfrvyfRoxPl1
         vAKsY/6K2Bp91M4eGkfmMVgx4tq5lYRG0oZEyNhb+JNzehFFafR8XEv9Gx4v4c3e4jIl
         RLUMxLkX03CSclolulHa9LDlwlsXDzHYWyRtirmMWIxsio9lwybR+AVVYleWGyqhFdNv
         QqZmFPi7w0y0wxbeEy2gkUqjRLpbZnx10DRkNHU8YOvR7HUapz5/IEXbO20U9kf0owOo
         9NRg==
X-Gm-Message-State: AOAM530PJeCiGLhj+HI3hPG0QF1f6kqv4cTy4so+htJ7GOmNWuwPyydF
        qiwT3tP3yFyv1YB4i9Vj3wXBT+4Hh8bS3UHwkhA=
X-Google-Smtp-Source: ABdhPJy9XST7UW5ecghS+rfm4Gk36kzrUMACQKTRZPltGcFnI+X83yMbexQueGnl7ST8z/ZltSnaFUs2YO35xqKk1DU=
X-Received: by 2002:a5b:286:: with SMTP id x6mr40564727ybl.347.1621901592421;
 Mon, 24 May 2021 17:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com> <60abfeef59a6c_135f6208b8@john-XPS-13-9370.notmuch>
In-Reply-To: <60abfeef59a6c_135f6208b8@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 17:13:01 -0700
Message-ID: <CAEf4BzaQCooimgM+ytuw+zscnDqbV-2f4ij7+nAitPdB08k0Yg@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 24, 2021 at 12:31 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Mon, May 24, 2021 at 8:05 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > >
> > > Hi Andrii,
> > >
> > > A user of bpf2go [1] recently ran into the problem of PT_REGS not
> > > being defined after including bpf_tracing.h. It turns out this is
> > > because we by default compile for bpfel / bpfeb so the logic in the
> > > header file doesn't kick in. I originally filed [2] as a quick fix,
> > > but looking at the issue some more made me wonder how to fit this into
> > > bpf2go better.
> > >
> > > Basically, the convention of bpf2go is that the compiled BPF is
> > > checked into the source code repository to facilitate distributing BPF
> > > as part of Go packages (as opposed to libbpf tooling which doesn't
> > > include generated source). To make this portable, bpf2go by default
> > > generates both bpfel and bpfeb variants of the C.
> > >
> > > However, code using bpf_tracing.h is inherently non-portable since the
> > > fields of struct pt_regs differ in name between platforms. It seems
> > > like this forces one to compile to each possible __TARGET_ARCH
> > > separately. If that is correct, could we extend CO-RE somehow to cover
> > > this as well?
> >
> > If there are enums/types/fields that we can use to reliably detect the
> > platform, then yes, we can have a new set of helpers that would do
> > this with CO-RE. Someone will need to investigate how to do that for
> > all the platforms we have. It's all about finding something that's
> > already in the kernel and can server as a reliably indicator of a
> > target architecture.
> >
> > >
> > > If that isn't possible, I want to avoid compiling and shipping BPF for
> > > each possible __TARGET_ARCH_xxx by default. Instead I would like to
> > > achieve:
> > > * Code that doesn't use bpf_tracing.h is distributed in bpfel and bpfeb variants
> > > * Code that uses bpf_tracing.h has to explicitly opt into the
> > > supported platforms via a flag to bpf2go
> > >
> > > The latter point is because the go tooling has to know the target arch
> > > to be able to generate the correct Go wrappers. How would you feel
> > > about adding something like the following to bpf_tracing.h:
> >
> > Well, obviously I'm not a fan of even more magic #defines. But I think
> > we can achieve a similar effect with a more "lazy" approach. I.e., if
> > user tries to use PT_REGS_xxx macros but doesn't specify the platform
> > -- only then it gets compilation errors. There is stuff in
> > bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
> > #error unconditinally. But we can do something like this:
> >
> > #else /* !bpf_target_defined */
> >
> > #define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
> > user-facing\"")
> >
> > ... and so on for all macros
> >
> > #endif
> >
> > Thoughts?
>
> I don't use bpf_tracing.h, but...
>
> Can we do this similar to feature discovery and simply have the
> user space tell us the platform? I at least do this fairly
> frequently so have infra in place on my side for user space to
> push down feature flags/fields. One of those could be platform then
> we just need helpers,
>
>   get_pt_regs_parm() {
>     if (bpf_target_defined == is_x86)
>      ...
>     else if (bpf_target_defined == is_foo)
>      ...
>     else {
>       hard_load_error()
>     }
>   }
>
> I think we are suggesting the same thing? Then user would need to
> have bpf_target_Defined set but that should be OK and the other
> conditions should all look like dead code.

It's almost what I propose, except I suggest to get rid of the need
for a user to specify the arch they expect/need, and use CO-RE to
detect this. What you propose would work, but it's usability is worse
than the CO-RE-based variant and it requires to hard-code struct
pt_regs exact definitions for each platform in bpf_tracing.h, which
sucks. And it would be like a third way to achieve the same thing
(with a different set of tradeoffs).

>
> >
> >
> > While on the topic, I've noticed that we added BPF_SEQ_PRINTF and
> > BPF_SNPRINTF into bpf_tracing.h, which seems like not the best fit
> > (definitely not for BPF_SNPRINTF). Florent, can you please help moving
> > them into bpf_helpers.h, as it's really more generic functionality
> > rather than low-level tracing primitives. I think it was put here
> > because we needed ___bpf_narg macros, but I'd rather copy/paste them
> > into bpf_helpers.h (they won't change at all) and put
> > BPF_SNPRINTF/BPF_SEQ_PRINTF into bpf_helpers.h.
> >
> > >
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -25,6 +25,9 @@
> > >         #define bpf_target_sparc
> > >         #define bpf_target_defined
> > >  #else
> > > +       #if defined(BPF_REQUIRE_EXPLICIT_TARGET_ARCH)
> > > +               #error BPF_REQUIRE_EXPLICIT_TARGET_ARCH set and no
> > > target arch defined
> > > +       #endif
> > >         #undef bpf_target_defined
> > >  #endif
> > >
> > > bpf2go would always define BPF_REQUIRE_EXPLICIT_TARGET_ARCH. If the
> > > user included bpf_tracing.h they get this error. They can then add
> > > -target amd64, etc. and the tooling then defines __TARGET_ARCH_x86_64
> > >
> > > 1: https://pkg.go.dev/github.com/cilium/ebpf/cmd/bpf2go
> > > 2: https://github.com/cilium/ebpf/issues/305
> > >
> > > --
> > > Lorenz Bauer  |  Systems Engineer
> > > 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> > >
> > > www.cloudflare.com
>
>
