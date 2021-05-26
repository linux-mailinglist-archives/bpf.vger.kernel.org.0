Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C99391F32
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEZSfs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEZSfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 14:35:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EAC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 11:34:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so3432679ybo.6
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxW+6T17RqZ/CFrr4FSx5L7JgbZC/z+ednR8UOTP/Ak=;
        b=eZUhK6xcPr78Fr/nGcYxWcARskfTu0Z/Q8zawXoiJ4g1bgna7exeNftolkNIf61Ro7
         L7v37L5r6ExUukImQ1iOG5FbprsIe1ra4i6Tgt2LuXd9cZ5G4h8SROE1RJUyF31Uf9/F
         f85ISR/OLQr8Di4BYmKDsXqLfAz0TGT3MZig7EtVKSK2jPtJu6OeVv+rIna/S8/e0i7Y
         kcBBqWWeiX+g6zf51eE1TuD8LoVa0k96MZyZxyjqJzG1V9Gs2K7TJwTp96VPvl/WRkag
         C/zYCbvREOSNVHLVdh9TVzACYC+EMGKIAOjPEOZRY4RgE+cLN86GHxqXleKcESzkzgRg
         +R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxW+6T17RqZ/CFrr4FSx5L7JgbZC/z+ednR8UOTP/Ak=;
        b=O7l7PZozeXieImM3whv+X/qp69xBF5kb8WbutwjoBcUcDAwzD23zh+U6+cxq6y8V24
         Fr1LWzvr22jonG/AP5QITweLdGKZ4O4+MkAMJ5b3v5R8133McMcHgsVS8qc+VSXBo6sH
         UzdlzwIMILfwdP7547W2jnFxtqurgwunHIyZOyvXBjRKsBV+D5FarWtG5niey8Ogm8Gc
         X/ewB42xYgbB663F0vjEC2z5JV1eZfVl8Lz1/RwgcMIc8hXOL/xbfwHH1qtwJXxIwVc7
         +lLnBBUUDvy68pT0QH2L+DwNOZN/+1k3e51x2VXgChtvAXL1iY3PelOpWd9iIUSF9lCy
         ukXA==
X-Gm-Message-State: AOAM5304lqbQ+fuyXE75wsMMIMEQMdgJwSRiReRuQPkl7adg9EtfmcRc
        +sgjJQq13avdTDSUMFIZ/5C6KZdBdpeEYk2FjeZltXO/j6M=
X-Google-Smtp-Source: ABdhPJzP58xz4LkdLwWnTTl8W+noAX177HeKQLi1qQPV2s7ElgD15xUePVwgod0JqfCGzdrmzX8iru7r/ftml0T0UyQ=
X-Received: by 2002:a25:9942:: with SMTP id n2mr54181508ybo.230.1622054055914;
 Wed, 26 May 2021 11:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com> <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
In-Reply-To: <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 11:34:04 -0700
Message-ID: <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 2:13 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Mon, 24 May 2021 at 18:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > If there are enums/types/fields that we can use to reliably detect the
> > platform, then yes, we can have a new set of helpers that would do
> > this with CO-RE. Someone will need to investigate how to do that for
> > all the platforms we have. It's all about finding something that's
> > already in the kernel and can server as a reliably indicator of a
> > target architecture.
>
> Can you explain a bit more how this would work? Seems like leg work I could do.
>

So I did a bit of investigation and gathered struct pt_regs
definitions from all the "supported" architectures in bpf_tracing.h.
I'll leave it here for further reference.

i386
====

struct pt_regs {
        unsigned long bx;
        unsigned long cx;
        unsigned long dx;
        unsigned long si;
        unsigned long di;
        unsigned long bp;
        unsigned long ax;
        unsigned short ds;
        unsigned short __dsh;
        unsigned short es;
        unsigned short __esh;
        unsigned short fs;
        unsigned short __fsh;
        unsigned short gs;
        unsigned short __gsh;
        unsigned long orig_ax;
        unsigned long ip;
        unsigned short cs;
        unsigned short __csh;
        unsigned long flags;
        unsigned long sp;
        unsigned short ss;
        unsigned short __ssh;
};

x86-64
======

struct pt_regs {
        unsigned long r15;
        unsigned long r14;
        unsigned long r13;
        unsigned long r12;
        unsigned long bp;
        unsigned long bx;
        unsigned long r11;
        unsigned long r10;
        unsigned long r9;
        unsigned long r8;
        unsigned long ax;
        unsigned long cx;
        unsigned long dx;
        unsigned long si;
        unsigned long di;
        unsigned long orig_ax;
        unsigned long ip;
        unsigned long cs;
        unsigned long flags;
        unsigned long sp;
        unsigned long ss;
};

s390
====

struct pt_regs
{
        union {
                user_pt_regs user_regs;
                struct {
                        unsigned long args[1];
                        psw_t psw;
                        unsigned long gprs[NUM_GPRS];
                };
        };
        unsigned long orig_gpr2;
        unsigned int int_code;
        unsigned int int_parm;
        unsigned long int_parm_long;
        unsigned long flags;
        unsigned long cr1;
};

arm
===

struct pt_regs {
        unsigned long uregs[18];
};

arm64
=====

struct pt_regs {
        union {
                struct user_pt_regs user_regs;
                struct {
                        u64 regs[31];
                        u64 sp;
                        u64 pc;
                        u64 pstate;
                };
        };
        u64 orig_x0;
#ifdef __AARCH64EB__
        u32 unused2;
        s32 syscallno;
#else
        s32 syscallno;
        u32 unused2;
#endif
        u64 sdei_ttbr1;
        u64 pmr_save;
        u64 stackframe[2];
        u64 lockdep_hardirqs;
        u64 exit_rcu;
};

mips
====

struct pt_regs {
#ifdef CONFIG_32BIT
        unsigned long pad0[8];
#endif
        unsigned long regs[32];
        unsigned long cp0_status;
        unsigned long hi;
        unsigned long lo;
#ifdef CONFIG_CPU_HAS_SMARTMIPS
        unsigned long acx;
#endif
        unsigned long cp0_badvaddr;
        unsigned long cp0_cause;
        unsigned long cp0_epc;
#ifdef CONFIG_CPU_CAVIUM_OCTEON
        unsigned long long mpl[6];        /* MTM{0-5} */
        unsigned long long mtp[6];        /* MTP{0-5} */
#endif
        unsigned long __last[0];
} __aligned(8);


powerpc
=======

struct pt_regs
{
        union {
                struct user_pt_regs user_regs;
                struct {
                        unsigned long gpr[32];
                        unsigned long nip;
                        unsigned long msr;
                        unsigned long orig_gpr3;
                        unsigned long ctr;
                        unsigned long link;
                        unsigned long xer;
                        unsigned long ccr;
#ifdef CONFIG_PPC64
                        unsigned long softe;
#else
                        unsigned long mq;
#endif
                        unsigned long trap;
                        unsigned long dar;
                        unsigned long dsisr;
                        unsigned long result;
                };
        };
        union {
                struct {
#ifdef CONFIG_PPC64
                        unsigned long ppr;
#endif
                        union {
#ifdef CONFIG_PPC_KUAP
                                unsigned long kuap;
#endif
#ifdef CONFIG_PPC_PKEY
                                unsigned long amr;
#endif
                        };
#ifdef CONFIG_PPC_PKEY
                        unsigned long iamr;
#endif
                };
                unsigned long __pad[4]; /* Maintain 16 byte interrupt
stack alignment */
        };
};


sparc
=====

struct pt_regs {
        unsigned long u_regs[16]; /* globals and ins */
        unsigned long tstate;
        unsigned long tpc;
        unsigned long tnpc;
        unsigned int y;

        /* We encode a magic number, PT_REGS_MAGIC, along
         * with the %tt (trap type) register value at trap
         * entry time.  The magic number allows us to identify
         * accurately a trap stack frame in the stack
         * unwinder, and the %tt value allows us to test
         * things like "in a system call" etc. for an arbitray
         * process.
         *
         * The PT_REGS_MAGIC is chosen such that it can be
         * loaded completely using just a sethi instruction.
         */
        unsigned int magic;
};


Now, note how each architecture has some uniquely named fields.
Assuming we pick something that is not going to get renamed easily, we
should be able to do something like this:

struct pt_regs___x86 {
    unsigned long di;
} __attribute__((preserve_access_index));

struct pt_regs___s390 {
    unsigned long gprs[NUM_GPRS];
} __attribute__((preserve_access_index));

struct pt_regs___powerpc {
    unsigned long gpr[32]
} __attribute__((preserve_access_index));

/* and so on for all arches */

Then PT_REGS_PARM1 CO-RE equivalent would be implemented like this:

#define ___arch_is_x86 (bpf_core_field_exists(((struct pt_regs___x86 *)0)->di))
#define ___arch_is_s390 (bpf_core_field_exists(((struct pt_regs___s390
*)0)->gprs))
#define ___arch_is_powerpc (bpf_core_field_exists(((struct
pt_regs___powerpc *)0)->gpr))

static unsigned long bpf_pt_regs_parm1(const void *regs)
{
    if (___arch_is_x86)
        return ((struct pt_regs___x86 *)regs)->di;
    else if (___arch_is_s390)
        return ((struct pt_regs___s390 *)regs)->gprs[2];
    else if (___arch_is_powerpc)
        return ((struct pt_regs___powerpc *)regs)->gpr[3];
    else
        while(1); /* need some better way to force BPF verification failure */
}

And so on for other architectures and other helpers, you should get
the idea from the above.

As a shameless plug, if you'd like to see some more examples of using
CO-RE for detecting kernel features, see [0]

  [0] https://nakryiko.com/posts/bpf-tips-printk/

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
> That would work for me, but it would change the behaviour for current
> users of the header, no? That's why I added the magic define in the
> first place.

How so? If someone is using PT_REGS_PARM1 without setting target arch
they should get compilation error about undefined macro. Here it will
be the same thing, only if someone tries to use PT_REGS_PARM1() will
they reach that _Pragma.

Or am I missing something?

>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
