Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0B308260
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhA2Aau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA2Aaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:30:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA87B64E00
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611880205;
        bh=aBXp7fUi0mP/lOwYSgxQfnwZIdAi+qTwFZ9sD8DPkZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZSvGhU2qmqR5rcYwMjhCWmrx9x0bh+/3kmVqpKUouofYqbFVQc+/vfW6aQ5gVUBms
         LsQsyGckky3kOlblLHeM7/Oqm8S6m8pM+UnVkJkAWKF0PMy7Abmdt7wdKXkg+2d98I
         XumZG5hXFZ+Zh1/4g9N67MoEgbWDsDAbqzdZOOmaNB9FiyEMYoTsLjH6mTD9kno8cG
         NB0bP3s2TydGHVsLV4UkwlGQywzkq0Q2yEUnx0F9wTB3Tnc3AXUI1fDirsB6x3RFdj
         vhdXzExT+6c58Pu3fD8/9X52qYNh5gpNXIyB2pRCtE5KzcQqxSxJLbsFunQhaXiSk4
         1jX1twFf79z8Q==
Received: by mail-ed1-f42.google.com with SMTP id dj23so8657196edb.13
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:30:04 -0800 (PST)
X-Gm-Message-State: AOAM530dgRLZtba356AYEQTKlP2754iF+5MDipEaxE8UDoiZ0+uykI9d
        NVltraIzTVkjUEQJyE66otS4K2DszNmy5I++esoEPw==
X-Google-Smtp-Source: ABdhPJyfC3sVT7oBXmgvWAWL5VhzqEIOytcNcqprnrF2rj6z8PaELLs6NX4m7cuO1nRC0AeDWvzLM8npXLrAKLcEaqk=
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr2524076edr.238.1611880203159;
 Thu, 28 Jan 2021 16:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com> <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 16:29:51 -0800
X-Gmail-Original-Message-ID: <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
Message-ID: <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 4:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 04:18:24PM -0800, Andy Lutomirski wrote:
> > On Thu, Jan 28, 2021 at 4:11 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > > >
> > > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > > that means you have to inline a valid implementation.  In particular,
> > > > you need to check that you're accessing *kernel* memory.  Just like
> > >
> > > That check is on the verifier side. It only does it for kernel
> > > pointers with known types.
> > > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > > points to valid kernel field which is also a pointer.
> > > What it doesn't check that b != null, so
> > > that users don't have to write silly code with 'if (p)' after every
> > > dereference.
> >
> > That sounds like a verifier and/or JIT bug.  If you have a pointer p
> > (doesn't matter whether p is what you call a or a->b) and you have not
> > confirmed that p points to the kernel range, you may not generate a
> > load from that pointer.
>
> Please read the explanation again. It's an inlined probe_kernel_read.

Can you point me at the uninlined implementation?  Does it still
exist?  I see get_kernel_nofault(), which is currently buggy, and I
will fix it.

>
> > >
> > > > how get_user() validates that the pointer points into user memory,
> > > > your helper should bounds check the pointer.  On x86, you could check
> > > > the high bit.
> > > >
> > > > As an extra complication, we should really add logic to
> > > > get_kernel_nofault() to verify that the pointer points into actual
> > > > memory as opposed to MMIO space (or future incoherent MKTME space or
> > > > something like that, sigh).  This will severely complicate inlining
> > > > it.  And we should *really* make the same fix to get_kernel_nofault()
> > > > -- it should validate that the pointer is a kernel pointer.
> > > >
> > > > Is this really worth inlining instead of having the BPF JIT generate
> > > > an out of line call to a real C function?  That would let us put in a
> > > > sane implementation.
> > >
> > > It's out of the question.
> > > JIT cannot generate a helper call for single bpf insn without huge overhead.
> > > All registers are used. It needs full save/restore, stack increase, etc.
> > >
> > > Anyhow I bet the bug we're discussing has nothing to do with bpf and jit.
> > > Something got changed and now probe_kernel_read(NULL) warns on !SMAP.
> > > This is something to debug.
> >
> > The bug is in bpf.
>
> If you don't care to debug please don't provide wrong guesses.

BPF generated a NULL pointer dereference (where NULL is a user
pointer) and expected it to recover cleanly. What exactly am I
supposed to debug?  IMO the only thing wrong with the x86 code is that
it doesn't complain more loudly.  I will fix that, too.

--Andy
