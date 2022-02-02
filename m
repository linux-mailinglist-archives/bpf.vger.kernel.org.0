Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608654A7B4A
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiBBWta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 17:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiBBWt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 17:49:29 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277EC061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 14:49:29 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m17so608923ilj.12
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMZh+O+Znnutj2UCDXdXZBgjyz9i+XiLEittzNIlEuE=;
        b=I9DCqMSD8Xx1/jQce5utIiqCV8WatVX7xlt4mP+gJEY7W51+g3VXCb7CmKC3xUKcL1
         AKrVQWQBhpdiRs690zjRPJgYV2XOz+AhUVuJ3GDConej46UY9KHySFiQooJphOAys26S
         MEvB725ULu8cOwnNl9K48YRSRNdOd+3xHhBYSekjK36oaSluSNdbgQB2n744Jr9BwdUI
         RTkI75QfsT0zgbp0qsAIcW6tEbQ1xjDmuO6BUFtYfbo4FQhT4pPQwPZ+f3zIVLOyRO+d
         LbltQiHa588gjAsKncJTkfMVLDi0JuWfhlHBq/i6PD6ElXReRGJ5CEmozjI05eYUMEkd
         J0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMZh+O+Znnutj2UCDXdXZBgjyz9i+XiLEittzNIlEuE=;
        b=YiH6qmDjcVUOJOMxoACsgPUy/R0OQJpM+Ohc40bxtg0mUvGzXZQw/s6zytv4ElNP7T
         6rKrtR3djPyXt4YondWXOk4t4CxFP/lj9ify9VkQswA4Slfoh5hRfJFMdodOdCNe3Gtn
         9/2GOX8aYPXaBpNvN//ZSAnJf2fQb6WD7yNiWePwMWX1+PCCfbhrrAlEZjHfTRpIHpQt
         /3PW4h+uN9i/N2hr4Uu+WKXNDdNFMRKyit8O7LYaS2GO6NIFNkc7NgWnNdKn5skwnZtC
         +Dyw9Nat9Z2oRVh3e5e4PldWnWeXBDZXBHbjqojotu6zrM2qyV0aHMUXxe8Fy42z60t9
         4EAQ==
X-Gm-Message-State: AOAM533oAtoUdebWwqsYVv8Dvzdg6JR5TymNfFj7tFm1KJSqfa+l5y/o
        fXyMq4xoZapQvR4L1olXQ5AzzHDVkB7R+ogQGQSRHWxN
X-Google-Smtp-Source: ABdhPJxo3+0BxxPttB+tcSyK/5kI9fswVi+XwbfOHuRm3cLqHl9Y9LlUJvio9jkI8plnFfAXQmlW63b0YHN/Mt2K0Jk=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr13166935ilv.305.1643842169163;
 Wed, 02 Feb 2022 14:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20220201234200.1836443-1-iii@linux.ibm.com> <20220201234200.1836443-2-iii@linux.ibm.com>
 <YfrmO+pcSqrrbC3E@osiris>
In-Reply-To: <YfrmO+pcSqrrbC3E@osiris>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Feb 2022 14:49:17 -0800
Message-ID: <CAEf4BzYDumk98_casBB=gnvP7r9hymyVsPC35G5z_Eye=b6ufQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 12:14 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
> > user_pt_regs is used by eBPF in order to access userspace registers -
> > see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> > BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
> > syscall argument from eBPF programs, we need to export orig_gpr2.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/ptrace.h      | 2 +-
> >  arch/s390/include/uapi/asm/ptrace.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> > index 4ffa8e7f0ed3..c8698e643904 100644
> > --- a/arch/s390/include/asm/ptrace.h
> > +++ b/arch/s390/include/asm/ptrace.h
> > @@ -83,9 +83,9 @@ struct pt_regs {
> >                       unsigned long args[1];
> >                       psw_t psw;
> >                       unsigned long gprs[NUM_GPRS];
> > +                     unsigned long orig_gpr2;
> >               };
> >       };
> > -     unsigned long orig_gpr2;
> >       union {
> >               struct {
> >                       unsigned int int_code;
> > diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> > index ad64d673b5e6..b3dec603f507 100644
> > --- a/arch/s390/include/uapi/asm/ptrace.h
> > +++ b/arch/s390/include/uapi/asm/ptrace.h
> > @@ -295,6 +295,7 @@ typedef struct {
> >       unsigned long args[1];
> >       psw_t psw;
> >       unsigned long gprs[NUM_GPRS];
> > +     unsigned long orig_gpr2;
> >  } user_pt_regs;
>
> Isn't this broken on nearly all architectures? I just checked powerpc,
> arm64, and riscv. While powerpc seems to mirror pt_regs as user_pt_regs,
> and therefore exports orig_gpr3, the bpf macros still seem to access the
> wrong location to access the first syscall parameter(?).
>
> For arm64 and riscv it seems that orig_x0 or orig_a0 respectively need to
> be added to user_pt_regs too, and the same fix like for s390 needs to be
> applied as well.

We just recently added syscall-specific macros to libbpf and fixed
this issue for x86-64. It would be great if people familiar with other
architectures contribute fixes for other architectures. Thanks!
