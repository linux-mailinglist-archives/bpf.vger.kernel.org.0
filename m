Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668C71D9C54
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgESQTB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbgESQTA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:19:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6FC08C5C0;
        Tue, 19 May 2020 09:19:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k5so319842lji.11;
        Tue, 19 May 2020 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IQNUs+IAOZ3M6C3xt5mSR7fGyKGPn6STreh82uXHT8=;
        b=OBERDcfRI8FAFHIgb+2RoDrLZ3RqSjIUx0f17FmsGP3PnedGDy1EE/faD8/Q/Xjtmr
         bz7Cu390LDkbNt39m5XgYLjZ2sXLvIlvQzVkVJaJE3rxuIVRMvaQQ+3ryfjsTYnAAAqG
         eKu8QRRxpIvWhkjeW3zpASKQF/1ud3IxTxAoIYWUkVB8nbdjsMGxstdJSPHeOQzGm4mS
         dRlOQ1vEiDuVydc1weLVCUzC02B5x2CmUQtpSgcygIrLsPoOzG7U683uM9nREVr3IuU3
         TMd5xw3quIjF5Re6R9JTKyscUpSJEuVOveTVHcuyfjxj5rcokNE4vrNyu7/3QHZoaqIO
         pcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IQNUs+IAOZ3M6C3xt5mSR7fGyKGPn6STreh82uXHT8=;
        b=oAOXC/Ir/Poebnev80To0VeUa3I+0nFloW8eYFpfbbbl+Oox71i/iVtUpi7LSzF8Qa
         y8i8Hi2nXbKDjjIvsqpLjJX0rvkThJ0knIvKS08HD6AUI6vjo4NxAUVJpsmzVZVtfW3G
         KOerBoL90oufWLUO3u8dAuGciT2RXkhB9dsDcSRw63o/C4LpvVA3CCceODlvYxPYbEo4
         XCQKNL8weB1w7gFByuuPlVn4hzDLYyBMsloxC3n9VjgTI7u7PtV9aH6s+G1a17NlgPiq
         Zz5BMYIC7MCJyFmPpYPhUDp31rpCnmjArnTCZklPPnHYF1HSWvERQOTO77Ez+o1Tc/7i
         0T4Q==
X-Gm-Message-State: AOAM533ocOXamiYP+foYkjA4XsZwPtFRzztcFpT8HCh1aAqs1ant1IYI
        wcVGyltH9WX8mq55pkyO7cI+CzVo6IOz1STlim0=
X-Google-Smtp-Source: ABdhPJy+SObPy/MuIJoN2GIhV98nJVkMSX5lkK+Jhx7jjXaN5+FRo3IhpCUTNk+LWTbkdR6MUQW7OkZIiGW+YZY79Ic=
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr142261ljp.138.1589905138796;
 Tue, 19 May 2020 09:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <202005181120.971232B7B@keescook> <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
In-Reply-To: <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 May 2020 09:18:47 -0700
Message-ID: <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
Subject: Re: seccomp feature development
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 18, 2020 at 7:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-05-19, Jann Horn <jannh@google.com> wrote:
> > On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> > > ## deep argument inspection
> > >
> > > Background: seccomp users would like to write filters that traverse
> > > the user pointers passed into many syscalls, but seccomp can't do this
> > > dereference for a variety of reasons (mostly involving race conditions and
> > > rearchitecting the entire kernel syscall and copy_from_user() code flows).
> >
> > Also, other than for syscall entry, it might be worth thinking about
> > whether we want to have a special hook into seccomp for io_uring.
> > io_uring is growing support for more and more syscalls, including
> > things like openat2, connect, sendmsg, splice and so on, and that list
> > is probably just going to grow in the future. If people start wanting
> > to use io_uring in software with seccomp filters, it might be
> > necessary to come up with some mechanism to prevent io_uring from
> > permitting access to almost everything else...
> >
> > Probably not a big priority for now, but something to keep in mind for
> > the future.
>
> Indeed. Quite a few people have raised concerns about io_uring and its
> debug-ability, but I agree that another less-commonly-mentioned concern
> should be how you restrict io_uring(2) from doing operations you've
> disallowed through seccomp. Though obviously user_notif shouldn't be
> allowed. :D
>
> > > The argument caching bit is, I think, rather mechanical in nature since
> > > it's all "just" internal to the kernel: seccomp can likely adjust how it
> > > allocates seccomp_data (maybe going so far as to have it split across two
> > > pages with the syscall argument struct always starting on the 2nd page
> > > boundary), and copying the EA struct into that page, which will be both
> > > used by the filter and by the syscall.
> >
> > We could also do the same kind of thing the eBPF verifier does in
> > convert_ctx_accesses(), and rewrite the context accesses to actually
> > go through two different pointers depending on the (constant) offset
> > into seccomp_data.
>
> My main worry with this is that we'll need to figure out what kind of
> offset mathematics are necessary to deal with pointers inside the
> extensible struct. As a very ugly proposal, you could make it so that
> you multiply the offset by PAGE_SIZE each time you want to dereference
> the pointer at that offset (unless we want to add new opcodes to cBPF to
> allow us to represent this).

Please don't. cbpf is frozen.

>
> This might even be needed for seccomp user_notif -- given one of the
> recent proposals was basically to just add two (extensible) struct
> pointers inside the main user_notif struct.
>
> > > I imagine state tracking ("is
> > > there a cached EA?", "what is the address of seccomp_data?", "what is
> > > the address of the EA?") can be associated with the thread struct.
> >
> > You probably mean the task struct?
> >
> > > The growing size of the EA struct will need some API design. For filters
> > > to operate on the contiguous seccomp_data+EA struct, the filter will
> > > need to know how large seccomp_data is (more on this later), and how
> > > large the EA struct is. When the filter is written in userspace, it can
> > > do the math, point into the expected offsets, and get what it needs. For
> > > this to work correctly in the kernel, though, the seccomp BPF verifier
> > > needs to know the size of the EA struct as well, so it can correctly
> > > perform the offset checking (as it currently does for just the
> > > seccomp_data struct size).
> > >
> > > Since there is not really any caller-based "seccomp state" associated
> > > across seccomp(2) calls, I don't think we can add a new command to tell
> > > the kernel "I'm expecting the EA struct size to be $foo bytes", since
> > > the kernel doesn't track who "I" is besides just being "current", which
> > > doesn't take into account the thread lifetime -- if a process launcher
> > > knows about one size and the child knows about another, things will get
> > > confused. The sizes really are just associated with individual filters,
> > > based on the syscalls they're examining. So, I have thoughts on possible
> > > solutions:
> > >
> > > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
> > >   EA style so we can pass in more than a filter and include also an
> > >   array of syscall to size mappings. (I don't like this...)
> > > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which changes
> > >   the meaning of the uarg from "filter" to a EA-style structure with
> > >   sizes and pointers to the filter and an array of syscall to size
> > >   mappings. (I like this slightly better, but I still don't like it.)
> > > - leverage the EA design and just accept anything <= PAGE_SIZE, record
> > >   the "max offset" value seen during filter verification, and zero-fill
> > >   the EA struct with zeros to that size when constructing the
> > >   seccomp_data + EA struct that the filter will examine. Then the seccomp
> > >   filter doesn't care what any of the sizes are, and userspace doesn't
> > >   care what any of the sizes are. (I like this as it makes the problems
> > >   to solve contained entirely by the seccomp infrastructure and does not
> > >   touch user API, but I worry I'm missing some gotcha I haven't
> > >   considered.)
> >
> > We don't need to actually zero-fill memory for this beyond what the
> > kernel supports - AFAIK the existing APIs already say that passing a
> > short length is equivalent to passing zeroes, so we can just replace
> > all out-of-bounds loads with zeroing registers in the filter.
> > The tricky case is what should happen if the userspace program passes
> > in fields that the filter doesn't know about. The filter can see the
> > length field passed in by userspace, and then just reject anything
> > where the length field is bigger than the structure size the filter
> > knows about. But maybe it'd be slightly nicer if there was an
> > operation for "tell me whether everything starting at offset X is
> > zeroes", so that if someone compiles with newer kernel headers where
> > the struct is bigger, and leaves the new fields zeroed, the syscalls
> > still go through an outdated filter properly.
>
> I think the best way of handling this (without breaking programs
> senselessly) is to have filters essentially emulate
> copy_struct_from_user() semantics -- which is along the lines of what
> you've suggested.

and cpbf load instruction will become copy_from_user() underneath?
I don't see how that can work.
Have you considered implications to jits, register usage, etc ?

ebpf will become sleepable soon. It will be able to do copy_from_user()
and examine any level of user pointer dereference.
toctou is still going to be a concern though,
but such ebpf+copy_from_user analysis and syscall sandboxing
will not need to change kernel code base around syscalls at all.
No need to invent E-syscalls and all the rest I've seen in this thread.
