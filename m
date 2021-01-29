Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89DC30826A
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhA2Adr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhA2Ada (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:33:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0843364E05
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611880369;
        bh=rA8YMr+vI29dSi96qFrotJQk/WjPY16DWYadSFb3tMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y4J77cjNgfF28ouHvcL+7dRYa+WMoup9Ma5ddxRf6dmUkxh5zL2QA2iDhTRmbsa7g
         OS7yT2BGrUSLbFm1Ur6V/UHPbTYVJYwSl7dRHJNZ+ATyhXXq6Tj/VW3k/v2+g9FIYK
         PksvnmFM5g1pFPjVw9NuH7NgAEdsgNizaz0il9ofE/MWKmtpJZkkyyzvYlDjDpeM5e
         ns87/zNA3FJykFionHosygxYXPJs02kOMMMOlaMvP4VGNjf2FD11aTTs2AOEqyeRl2
         df3pvaCkYAQqCHMu/m9iAYUUgr4VDt70+7eM+ZBH4mWDV64n5QXoh69TMM+xH63Orj
         +aGHUZ9Dsuwpg==
Received: by mail-ej1-f53.google.com with SMTP id a10so10474919ejg.10
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:32:48 -0800 (PST)
X-Gm-Message-State: AOAM5324NYL0ZsC+NVU6Oq04yMWXyVRpOtXbMH3kJ8ceOi6lofiCPWdx
        Jzjvuu4XGBpydSaQFO9TC7MCTf2L2VdvfWyK9OjDag==
X-Google-Smtp-Source: ABdhPJy/OrvwH5kIXxxxX2kDj1fH0TNxdxJ9H7Is37wHs6OHT7H5VD+Ej6Fv2JMIs/fil4FtL8c3DUYwr222C0S0aoM=
X-Received: by 2002:a17:906:3f89:: with SMTP id b9mr2021331ejj.204.1611880367359;
 Thu, 28 Jan 2021 16:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com> <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
In-Reply-To: <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 16:32:34 -0800
X-Gmail-Original-Message-ID: <CALCETrWhFHpyew=wjaFwYgczGB9ekATgGJYP6Mzxi++DkafyVQ@mail.gmail.com>
Message-ID: <CALCETrWhFHpyew=wjaFwYgczGB9ekATgGJYP6Mzxi++DkafyVQ@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, Jann Horn <jannh@google.com>,
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

On Thu, Jan 28, 2021 at 4:29 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jan 28, 2021 at 4:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 04:18:24PM -0800, Andy Lutomirski wrote:
> > > On Thu, Jan 28, 2021 at 4:11 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > > > >
> > > > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > > > that means you have to inline a valid implementation.  In particular,
> > > > > you need to check that you're accessing *kernel* memory.  Just like
> > > >
> > > > That check is on the verifier side. It only does it for kernel
> > > > pointers with known types.
> > > > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > > > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > > > points to valid kernel field which is also a pointer.
> > > > What it doesn't check that b != null, so
> > > > that users don't have to write silly code with 'if (p)' after every
> > > > dereference.
> > >
> > > That sounds like a verifier and/or JIT bug.  If you have a pointer p
> > > (doesn't matter whether p is what you call a or a->b) and you have not
> > > confirmed that p points to the kernel range, you may not generate a
> > > load from that pointer.
> >
> > Please read the explanation again. It's an inlined probe_kernel_read.
>
> Can you point me at the uninlined implementation?  Does it still
> exist?  I see get_kernel_nofault(), which is currently buggy, and I
> will fix it.

I spoke too soon.  get_kernel_nofault() is just fine.  You have
inlined something like __get_kernel_nofault(), which is incorrect.
get_kernel_nofault() would have done the right thing.
