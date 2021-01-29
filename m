Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E27309078
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 00:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhA2XNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 18:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2XNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 18:13:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE722C061573
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 15:11:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h15so6169260pli.8
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4wRX6VIirl6dq5DrLqMuQZCMSqdwBWCq9QxSFiKqCwE=;
        b=C5OxH0Wo+HsLfvNjkXyFjcF+oqsSwpQlDABKbYcMBEVoJvGFkloEz98DUvrNtBJHQP
         v2ncEr7y1GY+FzRBwv+TU1i1FeJYcq+mrgTmPzYmVW6HOtz8J8sTSTd7uzX/78HI+Xmh
         39X+gxomig9wCgljDZDvhpI4+szQCrYmThZgzNBUb+/CMAyVax5XwDnAa5Gtd9gRsLjf
         o+4ORftpjAKFUbz/9c1n2vqOzNhJtTPbQn/IEfWGHMFmXzeJHGi0ClnlRHDODVkh8ul8
         Fj+69YKXX2wgfkNBBfREwB9ZcsqxEDvvcCVjA6JJDsv87nFSMKopn3NOJQ5sFmR5s28z
         xhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4wRX6VIirl6dq5DrLqMuQZCMSqdwBWCq9QxSFiKqCwE=;
        b=M6S7KB5eS4T1zeAf8bTniArzxXdkVPFja16FbjJ+TH7Ummal2ZJRzUuPSr3zQCVO8S
         mgPQXsZEtBvi/mLfCSIorqswwVRKn14j4upTckr9fy/Ft/Mk3p0Qhok4pBTFW0qEh8xK
         +KfY2FUnF+B+/W5k5D4qbV1xG7/k5++4P9Vs5zL9TzBH3wtrUM4Bs0g26QBUq3FiBowW
         PPL7Z4QMoHxNcCOgmsgiPCz3O/Cu+zVvLhxbRUtT4XIRIMAy4ldggPrBsyHl5bAZpT1S
         mV9UJwLjhmr894MvijxqfI2H8/Gd+UFh4BkXJUvXnQfZmkJlznISDhezsGkGt4rxArlD
         ugEA==
X-Gm-Message-State: AOAM533F9RCH9kozky/H/bAqthwQ8A6v3TwaLNLUPgM1JpGGxv9LOoH1
        RnHk7NdpmjxTMmMAVEqHwDA=
X-Google-Smtp-Source: ABdhPJy5XktNAEgIF1INFKU+6FWK/KyZ7DjZ0r8yZcFdLowSIDa4sSKxcdP2kXkHxRotp7YkuaxwfQ==
X-Received: by 2002:a17:902:7088:b029:e0:612:b092 with SMTP id z8-20020a1709027088b02900e00612b092mr6508878plk.41.1611961919453;
        Fri, 29 Jan 2021 15:11:59 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:57a4])
        by smtp.gmail.com with ESMTPSA id q126sm10121904pfb.111.2021.01.29.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:11:58 -0800 (PST)
Date:   Fri, 29 Jan 2021 15:11:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129231155.mqbp5g675avvm5uq@ast-mbp.dhcp.thefacebook.com>
References: <YBPToXfWV1ekRo4q@hirez.programming.kicks-ass.net>
 <97EF0157-F068-4234-B826-C08B7324F356@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97EF0157-F068-4234-B826-C08B7324F356@amacapital.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 08:00:57AM -0800, Andy Lutomirski wrote:
> 
> > On Jan 29, 2021, at 1:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Thu, Jan 28, 2021 at 04:32:34PM -0800, Andy Lutomirski wrote:
> > 
> >> I spoke too soon.  get_kernel_nofault() is just fine.  You have
> >> inlined something like __get_kernel_nofault(), which is incorrect.
> >> get_kernel_nofault() would have done the right thing.
> > 
> > Correct, the pagefault_disable() is critical.

What specifically are you referring to?
As far as I can see the current->pagefault_disabled is an artifact of the past.
It doesn't provide any additional information to the fault handler beyond
what extable already does. Consider:

current->pagefault_disabled++
some C code
asm ("load") // with extable annotation
some other C code
current->pagefault_disabled--

If there is fault in the C code the fault handler will do the wrong thing,
since the fault is technically disabled only for asm("load").
The handler will go into bad_area_nosemaphore() instead of find_vma().

The load instruction is annotated in extable.
The fault handler instead of:
  if (faulthandler_disabled) search_exception_tables()
could do:
 search_exception_tables()
right away without sacrificing anything.
If the fault is on one of the special asm("load") the intent of the code
is obvious. This is non faulting load that should be fixed up.
Of course the search of extable should happen before taking mmap lock.

imo pagefault_disabled can be removed.

> Also the _allowed() part. The bounds check is required.

Up-thread I was saying that JIT is inlining copy_from_kernel_nofault().
That's not quite correct. When the code was written it was inlining
bpf_probe_read(). Back then _kernel vs _user distinction didn't exist.
So the bounds check wasn't there. The verifier side was designed
for kernel pointers and NULL from the beginning. No user pointer
(aside from NULL) would ever go through this path.
Today I agree that the range check is necessary.
The question is where to do this check.
I see two options:
- the JIT can emit it
- fault handler can do it, since %rip clearly says that it's JITed asm load.
The intent of the code is not ambiguous.
The intent of the fault is not ambiguous either.
More so the mmap lock and find_vma should not be done.

I prefer the later approach which can be implemented as:
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..7846a95436c1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1248,6 +1248,12 @@ void do_user_addr_fault(struct pt_regs *regs,
        if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
                return;

+       if (!address && (e = search_bpf_extables(regs->ip))) {
+               handler = ex_fixup_handler(e);
+               handler(e, regs, trapnr, error_code, fault_addr);
+               return;
+       }
+

Comparing to former option it saves bpf prog cycles.

Consider that users do not write a->b->c just to walk NULL pointers.
The bpf program authors are not writing junk programs.
If the program is walking the pointers it expects to read useful data.
If one of those pointers can be NULL the program author will
add if (!ptr) check there. The author will use blind a->b->c
only for cases where these pointers are most likely will be !NULL.
"Most likely" means that in 99.9% of the situations there will be no faults.
When people write bpf tracing progs they care about the perf overhead.
Obviously if prog is causing faults somebody will notice and will
slap that bpf author for causing a performance regression.
So faulting on NULL is very rare in practice.
There is a selftests/bpf for faulting on NULL, but it's a test only.
If the NULL check is added by JIT it will not be hit 99.9% of the time.
It will be a pure overhead for program execution.
Hence my preference for the latter approach.
