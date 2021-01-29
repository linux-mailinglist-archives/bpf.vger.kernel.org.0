Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6C3090A7
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 00:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhA2Xbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 18:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhA2Xbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 18:31:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C7C0613D6
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 15:30:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kg20so15337635ejc.4
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5gySTRZ//mbzEjOIP1oXBrr0+6EzdoOu3IHa/SmXl6s=;
        b=xCA8DVClD3bQ2uNlVUrS98a/LyerJlFoJFpRHlL3XRFERSk+RUabc5joK/wec9OfmE
         Hu14lwZb+C0wHoWgivDKX9k+t17Rft0+wLyDGJTQ3zTKqYbWzLuG6l3Gnvij1PjBAixN
         5FSrXMJngUeqo04H6E2UiUGzeo0P8moUf909t052ThNPa8kXT5Hwz6P0X0BUYldN7kLr
         JhlWMmugdMl9gMN2xIQstzdQ+IMm3dTIXUVskWaTFFW3CsQ+Fz9MExFmQStr837skCyG
         IJW/HgfY6dvqVVTtQB2O5z4jB21bEFfI8HZwKzcEkbTKJrv0PLfCk5wj/EBh8F7SFuVG
         BycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5gySTRZ//mbzEjOIP1oXBrr0+6EzdoOu3IHa/SmXl6s=;
        b=oOIQj6d8fUKa/DoMMXPGp+XWprdp5qtYElLccWw3l2PDAH8US745oVnuMpKPJjKwS8
         f2i2Fb8IlkBHvo4gRVMrvuQa/JvXtG1fKmdryc2O7F/twedabko7pqAa2wnlFafZFTQc
         WOLtPQW9IKPJlGPjtyr7Q1hKs41zDpyozsq4w8rpE/zWWN4w4VoClFNuR3wQSFcsfy6t
         GS3xANg7o9Rt8/p3KADYZ/83RF0E4PVMGVWLf4chMxIyQRNJYKm5Lx6x4McoKTZoTGgX
         Sq0XS7pW1mTHGBUltgwyS6kEQsUGrg5oRyGopbasc8f9TuLyVjNLNZim6PXo8JJifKgO
         a4zA==
X-Gm-Message-State: AOAM530FjdufMjiqHUrQDWHh0oZ/30jsg7Si1hUSeAZ8jc+NJeLZBx8P
        UGK7M6B59l8o+k4zzvfOPrg70DsuLtAJbo3Y3yhbPQ==
X-Google-Smtp-Source: ABdhPJyToLdDHHI40yDzJfA25a5baS8gk77iPfiSdgvf5aVw8zya19HWomG8xJhbIJRnM2O12e+EdqwSS2bumcJWF50=
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr7006681ejn.214.1611963050156;
 Fri, 29 Jan 2021 15:30:50 -0800 (PST)
MIME-Version: 1.0
References: <YBPToXfWV1ekRo4q@hirez.programming.kicks-ass.net>
 <97EF0157-F068-4234-B826-C08B7324F356@amacapital.net> <20210129231155.mqbp5g675avvm5uq@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129231155.mqbp5g675avvm5uq@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 29 Jan 2021 15:30:39 -0800
Message-ID: <CALCETrV4JKDPOKiXQfjSnbr2rHzC7O6tj3APYg0fhgUknVDWjw@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 3:12 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 08:00:57AM -0800, Andy Lutomirski wrote:
> >
> > > On Jan 29, 2021, at 1:21 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > >
> > > =EF=BB=BFOn Thu, Jan 28, 2021 at 04:32:34PM -0800, Andy Lutomirski wr=
ote:
> > >
> > >> I spoke too soon.  get_kernel_nofault() is just fine.  You have
> > >> inlined something like __get_kernel_nofault(), which is incorrect.
> > >> get_kernel_nofault() would have done the right thing.
> > >
> > > Correct, the pagefault_disable() is critical.
>
> What specifically are you referring to?
> As far as I can see the current->pagefault_disabled is an artifact of the=
 past.
> It doesn't provide any additional information to the fault handler beyond
> what extable already does. Consider:
>
> current->pagefault_disabled++
> some C code
> asm ("load") // with extable annotation
> some other C code
> current->pagefault_disabled--

pagefault_disabled is not about providing information to the fault
handler.  It's about changing the semantics of a fault when accessing
a user pointer.  There are two choices of semantics:

1. normal (faulthandler_disabled() returns false): accesses to user
memory can sleep, and accesses to valid VMAs are resolved.  exception
handlers for valid memory accesses are not called if the fault is
resolved.

2. faulthandler_disabled() returns true: accesses to user memory
cannot sleep.  If actual processing would be needed to resolve the
fault, it's an error instead.

This is used for two purposes: optimistic locking and best-effort
tracing.  There are code paths that might prefer to access user memory
with locks held.  They can pagefault_disable(), try the access, and
take the slow path involving dropping locks if the first try fails.
And tracing (e.g. perf call stacks) might need to access user memory
in a context in which they cannot sleep.  They can disable pagefaults
and try.  If they fail, then the user gets an incomplete call stack.

This is specifically about user memory access.  Sure, bpf could do
pagefault_disable(), but that makes no sense -- bpf is trying to do a
*kernel* access and is not validating the pointer.  On x86, which is a
poor architecture in this regard, the memory access instructions don't
adequately distinguish between user and kernel access, and bounds
checks are necessary.

>
> If there is fault in the C code the fault handler will do the wrong thing=
,
> since the fault is technically disabled only for asm("load").
> The handler will go into bad_area_nosemaphore() instead of find_vma().
>
> The load instruction is annotated in extable.
> The fault handler instead of:
>   if (faulthandler_disabled) search_exception_tables()
> could do:
>  search_exception_tables()
> right away without sacrificing anything.

This would sacrifice correctness in the vastly more common case of
get_user() / put_user() / copy_to/from_user(), which wants to sleep,
not return -FAULT.

> If the fault is on one of the special asm("load") the intent of the code
> is obvious. This is non faulting load that should be fixed up.
> Of course the search of extable should happen before taking mmap lock.
>
> imo pagefault_disabled can be removed.
>
> > Also the _allowed() part. The bounds check is required.
>
> Up-thread I was saying that JIT is inlining copy_from_kernel_nofault().
> That's not quite correct. When the code was written it was inlining
> bpf_probe_read(). Back then _kernel vs _user distinction didn't exist.
> So the bounds check wasn't there. The verifier side was designed
> for kernel pointers and NULL from the beginning. No user pointer
> (aside from NULL) would ever go through this path.
> Today I agree that the range check is necessary.
> The question is where to do this check.
> I see two options:
> - the JIT can emit it
> - fault handler can do it, since %rip clearly says that it's JITed asm lo=
ad.

The fault handler *can't* emit it correctly because the zero page
might actually be mapped.

Frankly, inlining this at all is a bit bogus, because some day we're
going to improve the range check to check whether the pointer points
to actual memory, and BPF should really do the same thing.  This will
be too big to inline nicely.

> The intent of the code is not ambiguous.
> The intent of the fault is not ambiguous either.
> More so the mmap lock and find_vma should not be done.
>
> I prefer the later approach which can be implemented as:
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f1f1b5a0956a..7846a95436c1 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1248,6 +1248,12 @@ void do_user_addr_fault(struct pt_regs *regs,
>         if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
>                 return;
>
> +       if (!address && (e =3D search_bpf_extables(regs->ip))) {

That's quite the set of cache lines that ought not to be touched in
the normal fault path.
