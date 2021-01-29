Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28430825B
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhA2A12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA2A11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:27:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1EC061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:26:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b21so5439131pgk.7
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+HhHjgRA8nz/s0em+dP40KiGNntmv0omoJUyPucZuY=;
        b=bz41jjmQeU3igVYG76g8oN5Cium2Arts/LGB9TFy3wvd/KBj/N0GMXcrm20OWsUs0Q
         gK01fA5esYw33QJ2yMIwcrWVgrUhfrGJ7dvaOda5f54WLV+oeNSazeVV+VuL3NK+hfIX
         4JhEJ8ByKL9a2I+9mveNu9wumWxgCM1J34Eqfu+h5sz2+cN3mIdbjvI5awnDyRECZGlS
         NFbiObawIIv9kZhKjkDFFwJf78lZ8UhuGZSGexwqV1jYu9WwZRhhLeoX/llzTS8s6EE4
         SVwNFjoZt6b4PpdXKkK7Tl+pQaRGtA9hwMrn8iCo30HzspqoiASyra5nBsBxoRH5ES6/
         pmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+HhHjgRA8nz/s0em+dP40KiGNntmv0omoJUyPucZuY=;
        b=n8sa7jUI+J4RXw/BdrDTQnBdDx/6FX13Ixt386bPtGLr2+7/YFkE72cEKDZUHX/31P
         PQiQT9nEATlCzw3Bshclw81qGLGlcVZWBa5MuruhfvO572H5VF/NGd0ILtXhPE6IFc2p
         yoTNupXu8YE46cXRJUgs/LJVsA+2xuc7Z1KcN7P/tx/0spBPmabV62J8TyPpRD1D5BE9
         3k5nTszcASr8/Nbb3tv9CycaxZWKsJZnq/llBvXEAiWs/3q6aR+0s9SX8z3fVavcL3z2
         u7GQR13nH259a1Est8B0zXRlimY/gM4sEuboJOfaA3RaQPZevzJkh8S0dUseiEgYZvQm
         ctZg==
X-Gm-Message-State: AOAM532E1A2m7l0F9kp5I555K1r/vCg6G0DDiyeGCZt2kCF/DOMlhygI
        stfj2/orcBuLxP9O7NY3KKo=
X-Google-Smtp-Source: ABdhPJz1FwH/OEaD0gI5NCQ2k4g6DubBQGCCxzemg0ExgYeF/9IC+LRBYZoOcKn/JiUw8m2BY9yI+g==
X-Received: by 2002:a63:f60e:: with SMTP id m14mr1896562pgh.413.1611880005801;
        Thu, 28 Jan 2021 16:26:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id gd9sm6031767pjb.10.2021.01.28.16.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:26:45 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:26:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 04:18:24PM -0800, Andy Lutomirski wrote:
> On Thu, Jan 28, 2021 at 4:11 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > >
> > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > that means you have to inline a valid implementation.  In particular,
> > > you need to check that you're accessing *kernel* memory.  Just like
> >
> > That check is on the verifier side. It only does it for kernel
> > pointers with known types.
> > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > points to valid kernel field which is also a pointer.
> > What it doesn't check that b != null, so
> > that users don't have to write silly code with 'if (p)' after every
> > dereference.
> 
> That sounds like a verifier and/or JIT bug.  If you have a pointer p
> (doesn't matter whether p is what you call a or a->b) and you have not
> confirmed that p points to the kernel range, you may not generate a
> load from that pointer.

Please read the explanation again. It's an inlined probe_kernel_read.

> >
> > > how get_user() validates that the pointer points into user memory,
> > > your helper should bounds check the pointer.  On x86, you could check
> > > the high bit.
> > >
> > > As an extra complication, we should really add logic to
> > > get_kernel_nofault() to verify that the pointer points into actual
> > > memory as opposed to MMIO space (or future incoherent MKTME space or
> > > something like that, sigh).  This will severely complicate inlining
> > > it.  And we should *really* make the same fix to get_kernel_nofault()
> > > -- it should validate that the pointer is a kernel pointer.
> > >
> > > Is this really worth inlining instead of having the BPF JIT generate
> > > an out of line call to a real C function?  That would let us put in a
> > > sane implementation.
> >
> > It's out of the question.
> > JIT cannot generate a helper call for single bpf insn without huge overhead.
> > All registers are used. It needs full save/restore, stack increase, etc.
> >
> > Anyhow I bet the bug we're discussing has nothing to do with bpf and jit.
> > Something got changed and now probe_kernel_read(NULL) warns on !SMAP.
> > This is something to debug.
> 
> The bug is in bpf.

If you don't care to debug please don't provide wrong guesses.
