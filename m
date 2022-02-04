Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474154A9398
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 06:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiBDF26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 00:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiBDF26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 00:28:58 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52CC061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:28:57 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y17so3994142ilm.1
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 21:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2vl++5ocEVVoZofAFviwHbdNlNthAaSTT+xALeyJ2Y=;
        b=Geg7yuXj4MCGZ9cZ9MbEb6Kk9rascYPYDww69zvxOHwdlZ0I3y02FfD5RJv5gtbznG
         Tubt+YJDstup21WR9LHqTG5j1QVPkADhFTfn/u0u5xIzoYYxVSjr25mU6ir38IP53Jsy
         +WUHr8shMcO4VQL/+AxVU2ARFg0TZSKn/a3XHtQtHhTxyi/ZaW0DCG4XQ30ES28nTSWx
         +kQNx0qEt6NFbOo1uv1RAMtKHvEzkBz13tHgDgUlfTOLHme1lhUSIv2nqpqlAMNtoJN1
         6YioXyhDofGbxkSGSZwZlQ+C8P1Yb3Asw/fkxM6ynaLEa6YLDQFkY0TEPg12muHmpz0u
         GHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2vl++5ocEVVoZofAFviwHbdNlNthAaSTT+xALeyJ2Y=;
        b=MFRkPhrv+5Hg02T+EOvtfjvP3cn00hOiBItm/WeQrjlhFP+6tuhU8lNnrIYZAhhtfe
         +ejfC9T3jFBgQvA1HqBioV65K3SfCVW0RKnjxdEiNAJE7ZIYR3AMknzeqBJ6blqN2c4x
         wUxCH/SDIRgJo71FIpRVUKjMSlboL0rygKdRn1jXimGEzqWmBj6lumGsIy3mz7KjMFi9
         zpBBmLmtQY+yM/YMTVZJ38x8NRie9A/c5ZTUodROeyyGrbQVtUrVVlQXMYEnjEwEF3tv
         gJ97/dH1xADH4FL4nDoZKqksbCrVz32NFbhf1O+KCYS57R6IfIbIkrN4RdRjVBde1pHA
         f8Dw==
X-Gm-Message-State: AOAM533stb+eTgUogrH2DrhkNMyNLyNtkV4OlrcrI1YwsydugC2sv2Oc
        yBr4yYoC0v3Huh+RuGWA7QSfafi/tVgnqOUKAWQ=
X-Google-Smtp-Source: ABdhPJzjEIaF2Q9emJVJqlHSZF9eQz3JxVIc5XEEfFJfeWVzcQGrb9HBsP+hWobv+JARoMs4PmqqrV1wD/3O0RxhMP0=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr721695ili.239.1643952537285;
 Thu, 03 Feb 2022 21:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com>
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Feb 2022 21:28:46 -0800
Message-ID: <CAEf4BzbCBND=RMXdxY5MEvrTnn288hahkhkPwrQR1KxgBn+CVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/10] libbpf: Fix accessing syscall arguments
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> libbpf now has macros to access syscall arguments in an
> architecture-agnostic manner, but unfortunately they have a number of
> issues on non-Intel arches, that this series aims to fix.
>
> v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
> v1 -> v2:
> * Put orig_gpr2 in place of args[1] on s390 (Vasily).
> * Fix arm64, powerpc and riscv (Heiko).
>
> The arm64 fix is similar to the s390 one.
>
> powerpc and riscv are different in that they unpack arguments to
> registers before invoking syscall handlers - libbpf needs to know about
> this difference, so I've decided to introduce PT_REGS_SYSCALL macro for
> this (see bpf_syscall_macro test for usage example).
>
> Tested in QEMU.
>
> @Catalin, @Michael, @Paul: could you please review the arm64, powerpc
> and riscv parts?

I think it's worth waiting for these fixes before cutting libbpf v0.7
release, thanks for working on them! Please see my other comments on
respective patches.

>
> Ilya Leoshkevich (10):
>   arm64/bpf: Add orig_x0 to user_pt_regs
>   s390/bpf: Add orig_gpr2 to user_pt_regs
>   selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
>   libbpf: Add __PT_PARM1_REG_SYSCALL macro
>   libbpf: Add PT_REGS_SYSCALL macro
>   selftests/bpf: Use PT_REGS_SYSCALL in bpf_syscall_macro
>   libbpf: Fix accessing the first syscall argument on arm64
>   libbpf: Fix accessing syscall arguments on powerpc
>   libbpf: Fix accessing syscall arguments on riscv
>   libbpf: Fix accessing the first syscall argument on s390
>
>  arch/arm64/include/asm/ptrace.h               |  2 +-
>  arch/arm64/include/uapi/asm/ptrace.h          |  1 +
>  arch/s390/include/asm/ptrace.h                |  3 +--
>  arch/s390/include/uapi/asm/ptrace.h           |  2 +-
>  tools/lib/bpf/bpf_tracing.h                   | 23 ++++++++++++++++++-
>  .../selftests/bpf/progs/bpf_syscall_macro.c   |  7 ++++--
>  6 files changed, 31 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
