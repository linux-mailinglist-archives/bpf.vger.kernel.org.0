Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7430824F
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA2ATT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhA2ATS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:19:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A61664E00
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 00:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611879517;
        bh=2bv0rVdXm911iH5Y2+RAtIrm8Gso69Jx7jiXUt5z7BM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSGPcSA4llSrSEVrdcbNwcspi/7qHOLmW8lcCtqjM61SkpUMTOcdwtP1hqRP0GBO9
         P0nul1ScVKQcQwmXwjeMgYtRbgjs1Klp3z+p2ZEofRnmg3j2Jtq/HN+VYNw1If3TmS
         /SzyqWsswIr8iM9fZHXpxnh4HvH8sJC6YeymsRWibrisnKcKbD769FxlayqzBJYd1p
         1u/wv4FZqq4OARqj41q6u5U0l1sE4/CUGWlh6kBDWFhQ7oWGUbadADf9a+CK/5DEIF
         gPoyDIY7bWvZYKXl3IoKsyq7lmwZJ2DiRIj8yKlceyxeDNMyb04OaKkSAHuDfe4y/d
         y8J996ipvthzg==
Received: by mail-ed1-f44.google.com with SMTP id s11so8677296edd.5
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:18:37 -0800 (PST)
X-Gm-Message-State: AOAM531gU0Sz8dwxTiSCTNoXj4/RxWFVssprsl4ClWKqwQK2fP7Z6V4x
        pKvOGv0ll7lYBh4CH0FO6tQ6jsTdDrTDg099S7J1fg==
X-Google-Smtp-Source: ABdhPJwgyn55KeHWnyFfxq0BdiOeGULhXu6V4CPx6tSDVl4CoTdsyaayRuHHPRoQrq8EbMqwMjYKCfQHOj8CgeiYZOk=
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr2344894edq.263.1611879515661;
 Thu, 28 Jan 2021 16:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 16:18:24 -0800
X-Gmail-Original-Message-ID: <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
Message-ID: <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
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

On Thu, Jan 28, 2021 at 4:11 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> >
> > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > that means you have to inline a valid implementation.  In particular,
> > you need to check that you're accessing *kernel* memory.  Just like
>
> That check is on the verifier side. It only does it for kernel
> pointers with known types.
> In a sequnce a->b->c the verifier guarantees that 'a' is valid
> kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> points to valid kernel field which is also a pointer.
> What it doesn't check that b != null, so
> that users don't have to write silly code with 'if (p)' after every
> dereference.

That sounds like a verifier and/or JIT bug.  If you have a pointer p
(doesn't matter whether p is what you call a or a->b) and you have not
confirmed that p points to the kernel range, you may not generate a
load from that pointer.

>
> > how get_user() validates that the pointer points into user memory,
> > your helper should bounds check the pointer.  On x86, you could check
> > the high bit.
> >
> > As an extra complication, we should really add logic to
> > get_kernel_nofault() to verify that the pointer points into actual
> > memory as opposed to MMIO space (or future incoherent MKTME space or
> > something like that, sigh).  This will severely complicate inlining
> > it.  And we should *really* make the same fix to get_kernel_nofault()
> > -- it should validate that the pointer is a kernel pointer.
> >
> > Is this really worth inlining instead of having the BPF JIT generate
> > an out of line call to a real C function?  That would let us put in a
> > sane implementation.
>
> It's out of the question.
> JIT cannot generate a helper call for single bpf insn without huge overhead.
> All registers are used. It needs full save/restore, stack increase, etc.
>
> Anyhow I bet the bug we're discussing has nothing to do with bpf and jit.
> Something got changed and now probe_kernel_read(NULL) warns on !SMAP.
> This is something to debug.

The bug is in bpf.
