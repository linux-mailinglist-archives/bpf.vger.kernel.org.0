Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB74308293
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhA2Amh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhA2AmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:42:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F43C061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:41:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so5144364pfk.1
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7Q8XafjxZ+MBpLtuX4q8iET/HFTLoiCG7JnP+u1UL8=;
        b=lxFlLVv0g4hi7WEhB3Zj0XxPCpSLAt1OpjRoMcIBEScN8QoCpuZg5BJo+uLV47pPsj
         +MVU0VWER/PwBcy6JCgJMR8QiI3UEWvtlkzkr8EDHacQ7zFN0pgZkTwvKhnioYmMiTaY
         ztTq/ryexotqS/USa1u067Wx+QZYNjStPDI4OiyvyTPTJ7LFHxzkJpMkU2FPCS6aeoNf
         PiDFvMAJXgmfoPe7SZz85GfwLaY6Yj6sYp4eI7L8gDyehiHMDmvLIWfgZWaHreIh5t29
         gy0o/d9eTBMAyR3CeM2Ibv9eFv+nRTCQl0pCOXBZfj/VBm6c7X2m72r8OB4gbXBB5l4r
         t53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7Q8XafjxZ+MBpLtuX4q8iET/HFTLoiCG7JnP+u1UL8=;
        b=N9fQO6oBcjat1frWm3/RSwydW57/Qiq67zoQwEYuLWAjcfbFWF3k8VQNNOLgw2EsMu
         +G8Tg45WUR4ii0ev3hjd5x6NjfTE6wuc2LHr/do1ysMNq0FO/D/NKj2mUUf3zDigWa61
         4KqNj6seEOEin2NHWITAN4BfE1M6bANlljV8gOU2vsQA74GYP3TGM9DPw2cLvoTa2U43
         QXaKIQq+LTgtNbcGN2M24oaLJR9+K3yJieqtAaMAxXLemT90ZbZHAO5gxn1zik5Izac7
         tmgGt4nmE1/+nR23k26i7F40+WYH7GTDxXBprLRO3xa326ctR4o5wIOV++k9ia+FOLvg
         tsgg==
X-Gm-Message-State: AOAM532DSiJk7XDyuuxX0yyYttkXPAfWNe86EQ5JD1vifCFmy28xZqDu
        B/zwuSNVOfouVIlcsGZ51u0=
X-Google-Smtp-Source: ABdhPJzd4dR3g4Ol29S+VfFmICeiCnb7LRpoVuVOJ5EVJOMVi+BwgWxKWx4GW9n+7x6n2hhd7adFRg==
X-Received: by 2002:a62:5e44:0:b029:1a4:daae:e765 with SMTP id s65-20020a625e440000b02901a4daaee765mr1832380pfb.8.1611880894165;
        Thu, 28 Jan 2021 16:41:34 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id 30sm6920724pgl.77.2021.01.28.16.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:41:33 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:41:31 -0800
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
Message-ID: <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 04:29:51PM -0800, Andy Lutomirski wrote:
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
> 
> >
> > > >
> > > > > how get_user() validates that the pointer points into user memory,
> > > > > your helper should bounds check the pointer.  On x86, you could check
> > > > > the high bit.
> > > > >
> > > > > As an extra complication, we should really add logic to
> > > > > get_kernel_nofault() to verify that the pointer points into actual
> > > > > memory as opposed to MMIO space (or future incoherent MKTME space or
> > > > > something like that, sigh).  This will severely complicate inlining
> > > > > it.  And we should *really* make the same fix to get_kernel_nofault()
> > > > > -- it should validate that the pointer is a kernel pointer.
> > > > >
> > > > > Is this really worth inlining instead of having the BPF JIT generate
> > > > > an out of line call to a real C function?  That would let us put in a
> > > > > sane implementation.
> > > >
> > > > It's out of the question.
> > > > JIT cannot generate a helper call for single bpf insn without huge overhead.
> > > > All registers are used. It needs full save/restore, stack increase, etc.
> > > >
> > > > Anyhow I bet the bug we're discussing has nothing to do with bpf and jit.
> > > > Something got changed and now probe_kernel_read(NULL) warns on !SMAP.
> > > > This is something to debug.
> > >
> > > The bug is in bpf.
> >
> > If you don't care to debug please don't provide wrong guesses.
> 
> BPF generated a NULL pointer dereference (where NULL is a user
> pointer) and expected it to recover cleanly. What exactly am I
> supposed to debug?  IMO the only thing wrong with the x86 code is that
> it doesn't complain more loudly.  I will fix that, too.

are you saying that NULL is a _user_ pointer?!
It's NULL. All zeros.
probe_read_kernel(NULL) was returning EFAULT on it and should continue doing so.
