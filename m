Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F387480F48
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 04:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhL2DcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Dec 2021 22:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhL2DcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Dec 2021 22:32:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50135C061574
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 19:32:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso18735039pjb.1
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 19:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6g7X2vYxdf+HfBXlCVC0e86/EoZHA8kw0mSnEDAKdh4=;
        b=erfmRhcFTqmlpWuWKJJdhWLcmYyr5DTJQfqiokQkwcQ7ukv9N9I0x1vqQTyye87k6H
         jocgKY7lBUPihTKZavqWxOl7cjLXtHg2sX55uO6XOVZX5Ci6pz3VSjA7+A+ayJSx4zO9
         OJ47YZH7MCtyKlnSozVmfVj6y8W8OCDIajX31bG6710sEdnp0PfVp0sLPVejikY4WG/o
         GSFjYEzeU1IJsN1BkB9SDoKmOQbgLIcWsQ5CvVQfkLZvIFdMiXE7yPT8ZdVhe4sNLTgP
         wtCGnnGLP71f3efbNgEKhurl73VFn6oCXQebT1OYSgXuI82DRn2jJ/rG2xpCnoycX58l
         V7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6g7X2vYxdf+HfBXlCVC0e86/EoZHA8kw0mSnEDAKdh4=;
        b=WTuSuDxW6LwW61yM+mrld4p3nIIGddD6n9f2vbBdNInhAYSFJElIt6jLcMeUQrVwtj
         rrxsLQpA+NuBJgnif0weVniPS0Ul7l7spuYqXGkNZ/BGnfxxDSi5+GmmpAAfCYCNlVqx
         Fv5f5gR8njyr43lm5kMnE9YPeL+5JVYDS6ms/PeykLcHqYZAswSf8EBckcQEHfyPoQap
         7RVfeJgnyxqPYNRDjC5xa1cufjCffiUr1TUsKq/f2iVew5MPR1p/EazTJAw0MYnHjWq6
         zyMqSznLFw/kPJcy7CZQOBAAemh+SHE6ymvzCxWdRyFZpO0yhvqpWrQrkW2dLTimWZUQ
         AiAg==
X-Gm-Message-State: AOAM531v8VQKmnkAi6ZxUHM3ZkNmYmpR4P8PZvw8U1EGoo6LsmwgTuss
        6jKhGxhXrXFJN758Krt2B/5VH5grQT/KZ6E5LQs=
X-Google-Smtp-Source: ABdhPJwsNVUgkJ/ac9iCoUSKJj6UmxI30rjHl/XeRJSDUYteDKgC3hTlmZC5sPZLVxM+enUsl4eZgOux11huDw+1vO8=
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr30025660pjy.138.1640748738792;
 Tue, 28 Dec 2021 19:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20211222213924.1869758-1-andrii@kernel.org> <72ef381f2aa0b8bf20a07052b71eb7ad1f426c86.camel@linux.ibm.com>
In-Reply-To: <72ef381f2aa0b8bf20a07052b71eb7ad1f426c86.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Dec 2021 19:32:07 -0800
Message-ID: <CAADnVQ+aeVM7eM-2Roj3v_fyuGn8+YfywMGS0V8T1xe8+w1wrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: normalize PT_REGS_xxx() macro definitions
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 5:26 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-12-22 at 13:39 -0800, Andrii Nakryiko wrote:
> > Refactor PT_REGS macros definitions in  bpf_tracing.h to avoid
> > excessive
> > duplication. We currently have classic PT_REGS_xxx() and CO-RE-
> > enabled
> > PT_REGS_xxx_CORE(). We are about to add also _SYSCALL variants, which
> > would require excessive copying of all the per-architecture
> > definitions.
> >
> > Instead, separate architecture-specific field/register names from the
> > final macro that utilize them. That way for upcoming _SYSCALL
> > variants
> > we'll be able to just define x86_64 exception and otherwise have one
> > common set of _SYSCALL macro definitions common for all
> > architectures.
> >
> > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 377 +++++++++++++++-------------------
> > --
> >  1 file changed, 152 insertions(+), 225 deletions(-)
>
> Works fine on s390, and looks good to me.
> For both patches:
>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied this set and ubuntu kver patch.
Thanks everyone for reviewing and testing.
