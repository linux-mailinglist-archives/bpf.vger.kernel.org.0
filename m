Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09AA308240
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 01:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA2AMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 19:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA2AMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:12:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A387C061574
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:11:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o16so5427248pgg.5
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 16:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=og7skbxVMwcSYTbQDivsolIrhpGSau5PI7JNKLOrW6k=;
        b=jLetGDSq1XaT6VC2/NY64c3r9GqIH2kUAqq2J6jc8DzY8jMgGbp67Xo4WpH3dgnrPt
         nfL6/wnIEhMHPhuIEFC36dtifwrq0vF/o9HLRjj54t6O+2Szkr6OosmWLdoJjTw9iMZh
         ZZhE3ENq7KtmnCjlACaEnG1t/3V5zMpHcUSTB5e+Bl+tqkFe4LjXZdHezRNKba+k1ChI
         fuM9XBpRmLWqAHRWa82fL0zPpOUAfeP6p5REAKCbrv0pX6wjtG3T+lK3jmfZLIzN5FN3
         6nNTErPoSOlkEm3fH+A5UPlgvV2hfkLYVhuZqnl2aKKnC1E2lIZuo3KNrrf+eS5XYdao
         /WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=og7skbxVMwcSYTbQDivsolIrhpGSau5PI7JNKLOrW6k=;
        b=tJiqQxH2YTObbhyh6Z05/YhPJcsnFsVeAlCn3HY5/uVIZ4avGITmVnodAOcH9azNsN
         yX7CtrwkK4o6SYOKy6FUEVGL/UZmHLthmhh3kHG9dIh4rOiZi8QnHPneXJfoFW1upBTg
         atBALwe2FcS0Ni4wwW/UZOHLpNm3VX9GHdhtuwONsT7AM5EKCF1+t0mgvf5hz3hpbdju
         vGqUbu5EowM/wQiFZ/aUCC+RUeCZZvYu8X9pgisatqrz4NHGzR8yS+PTcTKB23vh82MZ
         sNv782w3NYM0vS1Il2dTmyb3xRujunTyFEJkq2zWpWqrNKJ0HxHNslgMmyd0vdCnwgqA
         DHDA==
X-Gm-Message-State: AOAM530L4MMLwa7m64lz0WqvQQHO7E2y258fgMrgsUf7gyYzu7UDkw4x
        ziroh/pPVY7s1FgpFAXbqXpDrW2Bzmo=
X-Google-Smtp-Source: ABdhPJywkG34QxQFYiiiv6aa8BYm0AkfAHSqAt/Eicu6IpiCcwuEmNcbnd2cG2Rc74VWJHtOSz5wFA==
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id 21-20020a6201150000b02901b4c593acd4mr1781483pfb.2.1611879093721;
        Thu, 28 Jan 2021 16:11:33 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id c5sm5812693pjo.4.2021.01.28.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:11:32 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:11:30 -0800
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
Message-ID: <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> 
> Okay, so I guess you're trying to inline probe_read_kernel().  But
> that means you have to inline a valid implementation.  In particular,
> you need to check that you're accessing *kernel* memory.  Just like

That check is on the verifier side. It only does it for kernel
pointers with known types.
In a sequnce a->b->c the verifier guarantees that 'a' is valid
kernel pointer and it's also !null. Then it guarantees that offsetof(b)
points to valid kernel field which is also a pointer.
What it doesn't check that b != null, so
that users don't have to write silly code with 'if (p)' after every
dereference.

> how get_user() validates that the pointer points into user memory,
> your helper should bounds check the pointer.  On x86, you could check
> the high bit.
> 
> As an extra complication, we should really add logic to
> get_kernel_nofault() to verify that the pointer points into actual
> memory as opposed to MMIO space (or future incoherent MKTME space or
> something like that, sigh).  This will severely complicate inlining
> it.  And we should *really* make the same fix to get_kernel_nofault()
> -- it should validate that the pointer is a kernel pointer.
> 
> Is this really worth inlining instead of having the BPF JIT generate
> an out of line call to a real C function?  That would let us put in a
> sane implementation.

It's out of the question.
JIT cannot generate a helper call for single bpf insn without huge overhead.
All registers are used. It needs full save/restore, stack increase, etc.

Anyhow I bet the bug we're discussing has nothing to do with bpf and jit.
Something got changed and now probe_kernel_read(NULL) warns on !SMAP.
This is something to debug.
