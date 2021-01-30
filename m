Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA073091D4
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 05:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhA3EVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 23:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhA3EGh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 23:06:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE264C0617A9
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 18:54:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so6440129plh.3
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 18:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RBOhBUscwEsRMaMkkjOf3rdR0UAEvlw9lZQvs+J1Mzk=;
        b=iP2AWEhWrFs+YqE7gp6WqXWgXfDULLEWK4umVMECL2bJilhCHOwn+biwSRiuKDErqQ
         NgTotcVdZhc0m8NqHUYLEp3BhucLUvLayZtJ2m+eRXrGv7UlcjRej9UXEE1WX7W5hntC
         0i5oN7s2haDW9Xz44VZyk+MaEhEXPlwer0AJ79cfYT1J1jxLSaA7m4U9gIzeBRj1xanj
         ws8/WKwv7CWubNuyEddRV5Rfr/ztKP4D+Mx19GZXGZbt11Mcbg1Shp44cibQ5TDPgqcV
         YOVzrwSOeKf1+M86QaBAZU8JZ2uzVTqLvlhnRhgcJ88pOYdIvAvY13zJREA9dWxyNBJ6
         HD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RBOhBUscwEsRMaMkkjOf3rdR0UAEvlw9lZQvs+J1Mzk=;
        b=qXpXdbioLUQ0Nq5xC811nMxRXZ1nfuNi0eWF6McnJqQfXHLVGpSHabQsQZS3aSW4jA
         OwASzDD6wbH2OB5aYMvl2QtCsSZRqMIMkZf20pYx95fOTYnteqIaxiSZ4HdfI2cjmLVw
         n/z/7MgT1LMI4ELUuaYnROakL4FbULF3VcW8fedrc+yGHbH+rom4/z/9T+D62YXS8xwp
         0v6TzU53MDjWbz8rEYK45fahnfhqhKqGtCkVuUH66KIZrkpn1lQDKyp2+3Z+r9b5RMq4
         Yl2oE5E88YEUOflxQijUqLWdIkDJfncoi1+HeMxPveimVVr9p28A8rDVTZBB8bjLx1uj
         s1mA==
X-Gm-Message-State: AOAM533fHh7te2PNHq5rcH0mcAc4jZNnXvszbUgbNiGeqovBc2oboEQS
        +jvMPDXh8r0JqFvFp4Xu7do=
X-Google-Smtp-Source: ABdhPJylY6hUXMGUtiQrZhg5yfblE7wLUyEh5BPa0NXgI5QKNOLpLkJF/iSFGSAt5CYSim43dY1ArA==
X-Received: by 2002:a17:902:348:b029:df:fa69:1ef0 with SMTP id 66-20020a1709020348b02900dffa691ef0mr7611972pld.41.1611975256438;
        Fri, 29 Jan 2021 18:54:16 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a3a0])
        by smtp.gmail.com with ESMTPSA id w21sm9786606pff.220.2021.01.29.18.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 18:54:15 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:54:13 -0800
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
Message-ID: <20210130025413.sdg3vri3zfovaxtu@ast-mbp.dhcp.thefacebook.com>
References: <YBPToXfWV1ekRo4q@hirez.programming.kicks-ass.net>
 <97EF0157-F068-4234-B826-C08B7324F356@amacapital.net>
 <20210129231155.mqbp5g675avvm5uq@ast-mbp.dhcp.thefacebook.com>
 <CALCETrV4JKDPOKiXQfjSnbr2rHzC7O6tj3APYg0fhgUknVDWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrV4JKDPOKiXQfjSnbr2rHzC7O6tj3APYg0fhgUknVDWjw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 03:30:39PM -0800, Andy Lutomirski wrote:
> On Fri, Jan 29, 2021 at 3:12 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 08:00:57AM -0800, Andy Lutomirski wrote:
> > >
> > > > On Jan 29, 2021, at 1:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > ﻿On Thu, Jan 28, 2021 at 04:32:34PM -0800, Andy Lutomirski wrote:
> > > >
> > > >> I spoke too soon.  get_kernel_nofault() is just fine.  You have
> > > >> inlined something like __get_kernel_nofault(), which is incorrect.
> > > >> get_kernel_nofault() would have done the right thing.
> > > >
> > > > Correct, the pagefault_disable() is critical.
> >
> > What specifically are you referring to?
> > As far as I can see the current->pagefault_disabled is an artifact of the past.
> > It doesn't provide any additional information to the fault handler beyond
> > what extable already does. Consider:
> >
> > current->pagefault_disabled++
> > some C code
> > asm ("load") // with extable annotation
> > some other C code
> > current->pagefault_disabled--
> 
> pagefault_disabled is not about providing information to the fault
> handler.  It's about changing the semantics of a fault when accessing
> a user pointer.  There are two choices of semantics:
> 
> 1. normal (faulthandler_disabled() returns false): accesses to user
> memory can sleep, and accesses to valid VMAs are resolved.  exception
> handlers for valid memory accesses are not called if the fault is
> resolved.
> 
> 2. faulthandler_disabled() returns true: accesses to user memory
> cannot sleep.  If actual processing would be needed to resolve the
> fault, it's an error instead.
> 
> This is used for two purposes: optimistic locking and best-effort
> tracing.  There are code paths that might prefer to access user memory
> with locks held.  They can pagefault_disable(), try the access, and
> take the slow path involving dropping locks if the first try fails.
> And tracing (e.g. perf call stacks) might need to access user memory
> in a context in which they cannot sleep.  They can disable pagefaults
> and try.  If they fail, then the user gets an incomplete call stack.

got it. thanks for the explanation. all makes sense.

> This is specifically about user memory access.  Sure, bpf could do
> pagefault_disable(), but that makes no sense -- bpf is trying to do a
> *kernel* access and is not validating the pointer.  

right.

> On x86, which is a
> poor architecture in this regard, the memory access instructions don't
> adequately distinguish between user and kernel access, and bounds
> checks are necessary.
> 
> >
> > If there is fault in the C code the fault handler will do the wrong thing,
> > since the fault is technically disabled only for asm("load").
> > The handler will go into bad_area_nosemaphore() instead of find_vma().
> >
> > The load instruction is annotated in extable.
> > The fault handler instead of:
> >   if (faulthandler_disabled) search_exception_tables()
> > could do:
> >  search_exception_tables()
> > right away without sacrificing anything.
> 
> This would sacrifice correctness in the vastly more common case of
> get_user() / put_user() / copy_to/from_user(), which wants to sleep,
> not return -FAULT.

got it. agree.

> 
> > If the fault is on one of the special asm("load") the intent of the code
> > is obvious. This is non faulting load that should be fixed up.
> > Of course the search of extable should happen before taking mmap lock.
> >
> > imo pagefault_disabled can be removed.
> >
> > > Also the _allowed() part. The bounds check is required.
> >
> > Up-thread I was saying that JIT is inlining copy_from_kernel_nofault().
> > That's not quite correct. When the code was written it was inlining
> > bpf_probe_read(). Back then _kernel vs _user distinction didn't exist.
> > So the bounds check wasn't there. The verifier side was designed
> > for kernel pointers and NULL from the beginning. No user pointer
> > (aside from NULL) would ever go through this path.
> > Today I agree that the range check is necessary.
> > The question is where to do this check.
> > I see two options:
> > - the JIT can emit it
> > - fault handler can do it, since %rip clearly says that it's JITed asm load.
> 
> The fault handler *can't* emit it correctly because the zero page
> might actually be mapped.

Yes. The zero page can be mapped. The fault won't happen
and bpf load will read garbage from user's page zero.
My understanding that this is extremelly rare. Unpriv users cannot map zero.
So no security concern for tracing prog accidently stumbling there.
You mentioned that "wine" does it? Sure. It won't affect bpf tracing.

> Frankly, inlining this at all is a bit bogus, because some day we're
> going to improve the range check to check whether the pointer points
> to actual memory, and BPF should really do the same thing.  This will
> be too big to inline nicely.

Inlining of bpf_probe_read_kernel is absolutely critical to performance.
Before we added this feature people were reporting that this was the
hottest function in tracing progs. The map lookups and prog body
itself were 2nd and 3rd.
In networking the program has to be fast too. The program authors count
every nanosecond to process millions of packets per second.
Then people do 'perf report' and see that bpf prog consumes 10% of cpu.
The prog is performing firewall or load balancer function.
That's useful cpu burn. It's acceptable cpu usage.
Whereas anything tracing is considered overhead. People deploy
tracing bpf prog and somebody notices 0.5% cpu regression.
They yell and complain. Then folks tune the tracing progs to be as
invisible as possible.

> > The intent of the code is not ambiguous.
> > The intent of the fault is not ambiguous either.
> > More so the mmap lock and find_vma should not be done.
> >
> > I prefer the later approach which can be implemented as:
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index f1f1b5a0956a..7846a95436c1 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1248,6 +1248,12 @@ void do_user_addr_fault(struct pt_regs *regs,
> >         if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
> >                 return;
> >
> > +       if (!address && (e = search_bpf_extables(regs->ip))) {
> 
> That's quite the set of cache lines that ought not to be touched in
> the normal fault path.

There is a small mistake above. It should have been:
if (!(address >> PAGE_SHIFT) && search_bpf_extables...

User space mapping of zero page is rare. The kernel faulting there
is even more rare. I think it's possible if root user process maps
zero page on purpose and then does a syscall with addresses from zero page.
So this check is guaranteed to preserve the speed of normal fault path.
Whereas second lookup search_bpf_extables() guarantees that it's
faulting on a specific load inside bpf prog and not any other
part of the kernel. get_user/put_user won't be here.

Anyway I'll prototype adding !null check to JITed code and benchmark
the difference with and without, so we have concrete numbers to talk about.
