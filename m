Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FFC309E8B
	for <lists+bpf@lfdr.de>; Sun, 31 Jan 2021 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhAaUF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 15:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhAaUBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 15:01:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F27AC64E50
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612114374;
        bh=iRqfNlooEtnaXzWqJGgOyC16V3yHp1mqUzOpPJuG3rQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ax2KUE64aygUzmVYpqmK5dEZILh4pOWVu92Ad7nTYhsi6sa/xjSf1UdBRpkMRWf2H
         HNKm2CvkExurMmvhj9zgY/qRpWYBi6fq1fWUsWy7FgYeQDIALl3lthWcVtgkJ2zw6D
         bERmdwBvYIQgG8mQUTbvYBwtE3ZVjBtHX62vcaH/2T2ck/cL4mUfjPdBhbKhAQ9/be
         HRjQQ7vUarvU7SFlOi6SqIt1XjOuWzIkQ7XlXkQymZwKW2DZEjpXXpNK+E/5Lcl4XX
         GKajkfrKdeaKTS4kIuOb/s6WXnQeEW2OxfyHcOsHTzEewsWm1ojRbUayVv8qRF7065
         2ERCk34rF1zKQ==
Received: by mail-ej1-f49.google.com with SMTP id rv9so20647408ejb.13
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 09:32:53 -0800 (PST)
X-Gm-Message-State: AOAM533CZ5fz4YXuPXH9AZrfE21v/xe6iTf1glb/Kh7bAA2bZVHGvrO6
        qaC6lhpjcP940gBegBh+0vQ1H4Btd1rc1t1V9JDTNQ==
X-Google-Smtp-Source: ABdhPJzkngO3dlypbKaXykOKcYfaWIfth2D2u9Ke9oaJvn1TQUxFywtOwFoboR6fupMktrkjkbBfB3dmKNMat2mlXRc=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr13971892ejq.101.1612114372370;
 Sun, 31 Jan 2021 09:32:52 -0800 (PST)
MIME-Version: 1.0
References: <YBPToXfWV1ekRo4q@hirez.programming.kicks-ass.net>
 <97EF0157-F068-4234-B826-C08B7324F356@amacapital.net> <20210129231155.mqbp5g675avvm5uq@ast-mbp.dhcp.thefacebook.com>
 <CALCETrV4JKDPOKiXQfjSnbr2rHzC7O6tj3APYg0fhgUknVDWjw@mail.gmail.com> <20210130025413.sdg3vri3zfovaxtu@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210130025413.sdg3vri3zfovaxtu@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Jan 2021 09:32:40 -0800
X-Gmail-Original-Message-ID: <CALCETrWY=xR9cWWoXji6o2OZak81F-GJjLEdFDJrTbAYJ8xtmg@mail.gmail.com>
Message-ID: <CALCETrWY=xR9cWWoXji6o2OZak81F-GJjLEdFDJrTbAYJ8xtmg@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 6:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 03:30:39PM -0800, Andy Lutomirski wrote:
> > On Fri, Jan 29, 2021 at 3:12 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 08:00:57AM -0800, Andy Lutomirski wrote:
> > > >
> > > > > On Jan 29, 2021, at 1:21 AM, Peter Zijlstra <peterz@infradead.org=
> wrote:
> > > > >
> > > > > =EF=BB=BFOn Thu, Jan 28, 2021 at 04:32:34PM -0800, Andy Lutomirsk=
i wrote:
> > > > >
> > > > >> I spoke too soon.  get_kernel_nofault() is just fine.  You have
> > > > >> inlined something like __get_kernel_nofault(), which is incorrec=
t.
> > > > >> get_kernel_nofault() would have done the right thing.
> > > > >
> > > > > Correct, the pagefault_disable() is critical.
> > >
> > > What specifically are you referring to?
> > > As far as I can see the current->pagefault_disabled is an artifact of=
 the past.
> > > It doesn't provide any additional information to the fault handler be=
yond
> > > what extable already does. Consider:
> > >
> > > current->pagefault_disabled++
> > > some C code
> > > asm ("load") // with extable annotation
> > > some other C code
> > > current->pagefault_disabled--
> >
> > pagefault_disabled is not about providing information to the fault
> > handler.  It's about changing the semantics of a fault when accessing
> > a user pointer.  There are two choices of semantics:
> >
> > 1. normal (faulthandler_disabled() returns false): accesses to user
> > memory can sleep, and accesses to valid VMAs are resolved.  exception
> > handlers for valid memory accesses are not called if the fault is
> > resolved.
> >
> > 2. faulthandler_disabled() returns true: accesses to user memory
> > cannot sleep.  If actual processing would be needed to resolve the
> > fault, it's an error instead.
> >
> > This is used for two purposes: optimistic locking and best-effort
> > tracing.  There are code paths that might prefer to access user memory
> > with locks held.  They can pagefault_disable(), try the access, and
> > take the slow path involving dropping locks if the first try fails.
> > And tracing (e.g. perf call stacks) might need to access user memory
> > in a context in which they cannot sleep.  They can disable pagefaults
> > and try.  If they fail, then the user gets an incomplete call stack.
>
> got it. thanks for the explanation. all makes sense.
>
> > This is specifically about user memory access.  Sure, bpf could do
> > pagefault_disable(), but that makes no sense -- bpf is trying to do a
> > *kernel* access and is not validating the pointer.
>
> right.
>
> > On x86, which is a
> > poor architecture in this regard, the memory access instructions don't
> > adequately distinguish between user and kernel access, and bounds
> > checks are necessary.
> >
> > >
> > > If there is fault in the C code the fault handler will do the wrong t=
hing,
> > > since the fault is technically disabled only for asm("load").
> > > The handler will go into bad_area_nosemaphore() instead of find_vma()=
.
> > >
> > > The load instruction is annotated in extable.
> > > The fault handler instead of:
> > >   if (faulthandler_disabled) search_exception_tables()
> > > could do:
> > >  search_exception_tables()
> > > right away without sacrificing anything.
> >
> > This would sacrifice correctness in the vastly more common case of
> > get_user() / put_user() / copy_to/from_user(), which wants to sleep,
> > not return -FAULT.
>
> got it. agree.
>
> >
> > > If the fault is on one of the special asm("load") the intent of the c=
ode
> > > is obvious. This is non faulting load that should be fixed up.
> > > Of course the search of extable should happen before taking mmap lock=
.
> > >
> > > imo pagefault_disabled can be removed.
> > >
> > > > Also the _allowed() part. The bounds check is required.
> > >
> > > Up-thread I was saying that JIT is inlining copy_from_kernel_nofault(=
).
> > > That's not quite correct. When the code was written it was inlining
> > > bpf_probe_read(). Back then _kernel vs _user distinction didn't exist=
.
> > > So the bounds check wasn't there. The verifier side was designed
> > > for kernel pointers and NULL from the beginning. No user pointer
> > > (aside from NULL) would ever go through this path.
> > > Today I agree that the range check is necessary.
> > > The question is where to do this check.
> > > I see two options:
> > > - the JIT can emit it
> > > - fault handler can do it, since %rip clearly says that it's JITed as=
m load.
> >
> > The fault handler *can't* emit it correctly because the zero page
> > might actually be mapped.
>
> Yes. The zero page can be mapped. The fault won't happen
> and bpf load will read garbage from user's page zero.
> My understanding that this is extremelly rare. Unpriv users cannot map ze=
ro.
> So no security concern for tracing prog accidently stumbling there.
> You mentioned that "wine" does it? Sure. It won't affect bpf tracing.
>
> > Frankly, inlining this at all is a bit bogus, because some day we're
> > going to improve the range check to check whether the pointer points
> > to actual memory, and BPF should really do the same thing.  This will
> > be too big to inline nicely.
>
> Inlining of bpf_probe_read_kernel is absolutely critical to performance.
> Before we added this feature people were reporting that this was the
> hottest function in tracing progs. The map lookups and prog body
> itself were 2nd and 3rd.
> In networking the program has to be fast too. The program authors count
> every nanosecond to process millions of packets per second.

Does the networking case have appropriate locking to make sure you
don't follow a wild pointer?

For that matter, even for tracing, you should probably make sure that
you do real validation
of any pointers you follow as opposed to just checking for being too
close to zero.  If a BPF tracing
program racily follows a wild pointer, it could hit actual mapped user
memory with complex semantics
(e.g. userfaultfd, something backed by FUSE, or something backed by a
filesystem that you are
busily tracing), and the system will deadlock or worse.

--Andy
