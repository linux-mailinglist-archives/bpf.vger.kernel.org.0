Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F138F27A
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEXRti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhEXRth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 13:49:37 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C92C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:48:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w1so27904109ybt.1
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUU3oCA/+vTpTbSrdvrtGmVHsH5BlrAxd+q2o5Zh+xM=;
        b=QNe8Nptl4enHOfRK8zGXQDXRoiHPono4x6c6F+gVpk4GXzWDupISvNOXrSp/9aSCWZ
         RD5NdNSBAYy80aeISyaFQRq5LU3dWEpye5ude+v4WQgvOw7Zva2hY9cU2fJOvx5eKayO
         hU4bdCTkvt4fXD3mli1NJsh9rDcT/lUq8l3hATgyHvPJW2q88a/jTMoJYxCNTouE/cvZ
         yZwBItiS6TnBcnyxYNrwLZMY6lNP+PCPG/8iwAZssRu3uhdzqZserqRQvhm4LmfdJ/zY
         SycLMBBz9QZ58PornKQIHcUS+nPSKJa+h7EqeqCSDDt3bS+xtMnnblyd5flTYWEbo6p1
         CrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUU3oCA/+vTpTbSrdvrtGmVHsH5BlrAxd+q2o5Zh+xM=;
        b=NjEpLJ2hEQ8Lm6ZJBdXe+t3foRKMAwzrpdJw/0WTkrDcn3axqLYif03H312gM3V6LF
         B55mC5GwZy3bqMqzr/bal0pSo83hqgH7jaRrpHz3aoiwVMxa1cAmbubn4a/t/Ebmmlm5
         Knn9KkQ6O+PBDT5m24y7Ab05ON3bRLSrjhwUkMY9CXK3pBz8T9s+Vqf2OdIx9oUa9zMI
         KSYkqBiU137LQmuW7Y/AT0rKwU1jQhkya7S2Fc7Mui1OhA4bYjxVvTDjDx2PK1WPT14A
         1m15Kj8TowMYZWvtJRwAmHA0CRR2vaJr9j3tXXWiAvLjruVxTWqulbPZiJXdb1oitYvM
         +oiA==
X-Gm-Message-State: AOAM530E1fj4O6vGqHkn9iAJtustD34Ky2uJ/UQsjHEHS+r/bJS523rQ
        HjtYdBOkvfYHoZhUQGSpfQCdcMoO7SGVUwRxbwUT1cCJ3KQ=
X-Google-Smtp-Source: ABdhPJwCdgRgk5S3HrZxbq6Grb+TN/b2fPw1ZPsN46LWU7FAujO5Np/FZdIZduM9KcLErs37rJraZFDwt73JP24i0d8=
X-Received: by 2002:a25:7507:: with SMTP id q7mr35386597ybc.27.1621878487795;
 Mon, 24 May 2021 10:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
In-Reply-To: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 10:47:56 -0700
Message-ID: <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 24, 2021 at 8:05 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi Andrii,
>
> A user of bpf2go [1] recently ran into the problem of PT_REGS not
> being defined after including bpf_tracing.h. It turns out this is
> because we by default compile for bpfel / bpfeb so the logic in the
> header file doesn't kick in. I originally filed [2] as a quick fix,
> but looking at the issue some more made me wonder how to fit this into
> bpf2go better.
>
> Basically, the convention of bpf2go is that the compiled BPF is
> checked into the source code repository to facilitate distributing BPF
> as part of Go packages (as opposed to libbpf tooling which doesn't
> include generated source). To make this portable, bpf2go by default
> generates both bpfel and bpfeb variants of the C.
>
> However, code using bpf_tracing.h is inherently non-portable since the
> fields of struct pt_regs differ in name between platforms. It seems
> like this forces one to compile to each possible __TARGET_ARCH
> separately. If that is correct, could we extend CO-RE somehow to cover
> this as well?

If there are enums/types/fields that we can use to reliably detect the
platform, then yes, we can have a new set of helpers that would do
this with CO-RE. Someone will need to investigate how to do that for
all the platforms we have. It's all about finding something that's
already in the kernel and can server as a reliably indicator of a
target architecture.

>
> If that isn't possible, I want to avoid compiling and shipping BPF for
> each possible __TARGET_ARCH_xxx by default. Instead I would like to
> achieve:
> * Code that doesn't use bpf_tracing.h is distributed in bpfel and bpfeb variants
> * Code that uses bpf_tracing.h has to explicitly opt into the
> supported platforms via a flag to bpf2go
>
> The latter point is because the go tooling has to know the target arch
> to be able to generate the correct Go wrappers. How would you feel
> about adding something like the following to bpf_tracing.h:

Well, obviously I'm not a fan of even more magic #defines. But I think
we can achieve a similar effect with a more "lazy" approach. I.e., if
user tries to use PT_REGS_xxx macros but doesn't specify the platform
-- only then it gets compilation errors. There is stuff in
bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
#error unconditinally. But we can do something like this:

#else /* !bpf_target_defined */

#define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
user-facing\"")

... and so on for all macros

#endif

Thoughts?


While on the topic, I've noticed that we added BPF_SEQ_PRINTF and
BPF_SNPRINTF into bpf_tracing.h, which seems like not the best fit
(definitely not for BPF_SNPRINTF). Florent, can you please help moving
them into bpf_helpers.h, as it's really more generic functionality
rather than low-level tracing primitives. I think it was put here
because we needed ___bpf_narg macros, but I'd rather copy/paste them
into bpf_helpers.h (they won't change at all) and put
BPF_SNPRINTF/BPF_SEQ_PRINTF into bpf_helpers.h.

>
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -25,6 +25,9 @@
>         #define bpf_target_sparc
>         #define bpf_target_defined
>  #else
> +       #if defined(BPF_REQUIRE_EXPLICIT_TARGET_ARCH)
> +               #error BPF_REQUIRE_EXPLICIT_TARGET_ARCH set and no
> target arch defined
> +       #endif
>         #undef bpf_target_defined
>  #endif
>
> bpf2go would always define BPF_REQUIRE_EXPLICIT_TARGET_ARCH. If the
> user included bpf_tracing.h they get this error. They can then add
> -target amd64, etc. and the tooling then defines __TARGET_ARCH_x86_64
>
> 1: https://pkg.go.dev/github.com/cilium/ebpf/cmd/bpf2go
> 2: https://github.com/cilium/ebpf/issues/305
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
