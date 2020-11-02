Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADF2A2CA2
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 15:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKBOOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 09:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgKBOOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 09:14:03 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F10C061A47
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 06:14:00 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m16so15146708ljo.6
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWSN6pUmUHVvmlI9O9ME30to/SMhrDIMong6ljJZfek=;
        b=mH8M9jpsGa3f9fcWJHPca/931KX2U+XkxbOX64TG8Zhi5C/ZcESSCqI25qknkzRBLO
         noKBzIlTe+kkzgJhAG7wFIWJHKb+7Biel9RAR2wvFwoQ8awGXak5DIOL/gSrErk8V9Le
         vlO7D9AMDRl3i5YY711AIk6T0Y/LyvuwzQGcNyl4w01onM/Gmvo0d0ZnirRD4P47OtY2
         tzxcRqUU+MRRVpIAht7p86HHVpCbRPuFXM6Wp6qrioc/0YN/b7/4RkUf4BGA22vRsC28
         ayKlOnSmhsPnPgbQkfW35DjULd5kYMYQ9XAPr8m5Wvyv0vFY8DY7k6OmPeCE5GBKo4Wr
         ts3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWSN6pUmUHVvmlI9O9ME30to/SMhrDIMong6ljJZfek=;
        b=n2i7KPEolEIFG/CYDOWbnEYb8coy2XrTIiZqkQZk7gC0PyjJyOCgj+541zKRcoNN6m
         +uuhhW4EI23cW9B1MCfEM6YNlIxMe+f53gQcTim5DklBDaqn/w4zcQvv4gScHydpJUPi
         Z1ZMREoREma+1EeWfeq/qzJTP8zCrSvO0Nz6cF8kbqc+GDUi10NWm+a7G9S3UdswzXk4
         IHAPRRkYC/aELhYZFsmfcmGmvLqmLY52W7ML+ktZIvU9JyEtlfWyPaK96mOlj1RXNyKU
         A7ZnDGUtn2+7KSfXmylXjH5ocpRBba8DiPo0sbrBjA6QObqJdXtbRFjSUSrbMSq6dYx6
         y4Bg==
X-Gm-Message-State: AOAM531Olcvu+l/LTJchX/XU3qCn6nJdK2/3QBf7xyQJEcQhKZDC9xxR
        vaTY9KXdovyk0364SeJX4yR+a+Vs7Y8Proy19Frs+w==
X-Google-Smtp-Source: ABdhPJybPO8qgl/H4+fZNekPwvUlTXpeBbE0gJrFEKhorJDspmNB/asdWQ1rEsPeRWv77CUoxL2pOk6JOxoYlGfUPn4=
X-Received: by 2002:a2e:b888:: with SMTP id r8mr6414174ljp.138.1604326439180;
 Mon, 02 Nov 2020 06:13:59 -0800 (PST)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
 <93cfdc79-4c48-bceb-3620-4c63e9f4822e@gmail.com> <CAG48ez3nH2Oiz9wMSpvUxxX_TRYTT98d3Nj1vnCuJOj9CCXH8Q@mail.gmail.com>
 <b43b50a2-fa5c-419d-ad24-3fd40bc26dba@gmail.com>
In-Reply-To: <b43b50a2-fa5c-419d-ad24-3fd40bc26dba@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Nov 2020 15:13:31 +0100
Message-ID: <CAG48ez000V-5KEpdHd3mNZrqvYYydJcdjZvZxeVph7AFgcxfHA@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 31, 2020 at 9:51 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/30/20 8:20 PM, Jann Horn wrote:
> > On Thu, Oct 29, 2020 at 8:14 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >> On 10/29/20 2:42 AM, Jann Horn wrote:
> >>> As discussed at
> >>> <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
> >>> we need to re-check checkNotificationIdIsValid() after reading remote
> >>> memory but before using the read value in any way. Otherwise, the
> >>> syscall could in the meantime get interrupted by a signal handler, the
> >>> signal handler could return, and then the function that performed the
> >>> syscall could free() allocations or return (thereby freeing buffers on
> >>> the stack).
> >>>
> >>> In essence, this pread() is (unavoidably) a potential use-after-free
> >>> read; and to make that not have any security impact, we need to check
> >>> whether UAF read occurred before using the read value. This should
> >>> probably be called out elsewhere in the manpage, too...
> >>>
> >>> Now, of course, **reading** is the easy case. The difficult case is if
> >>> we have to **write** to the remote process... because then we can't
> >>> play games like that. If we write data to a freed pointer, we're
> >>> screwed, that's it. (And for somewhat unrelated bonus fun, consider
> >>> that /proc/$pid/mem is originally intended for process debugging,
> >>> including installing breakpoints, and will therefore happily write
> >>> over "readonly" private mappings, such as typical mappings of
> >>> executable code.)
> >>>
> >>> So, uuuuh... I guess if anyone wants to actually write memory back to
> >>> the target process, we'd better come up with some dedicated API for
> >>> that, using an ioctl on the seccomp fd that magically freezes the
> >>> target process inside the syscall while writing to its memory, or
> >>> something like that? And until then, the manpage should have a big fat
> >>> warning that writing to the target's memory is simply not possible
> >>> (safely).
> >>
> >> Thank you for your very clear explanation! It turned out to be
> >> trivially easy to demonstrate this issue with a slightly modified
> >> version of my program.
> >>
> >> As well as the change to the code example that I already mentioned
> >> my reply of a few hours ago, I've added the following text to the
> >> page:
> >>
> >>    Caveats regarding the use of /proc/[tid]/mem
> >>        The discussion above noted the need to use the
> >>        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) when opening the
> >>        /proc/[tid]/mem file of the target to avoid the possibility of
> >>        accessing the memory of the wrong process in the event that the
> >>        target terminates and its ID is recycled by another (unrelated)
> >>        thread.  However, the use of this ioctl(2) operation is also
> >>        necessary in other situations, as explained in the following
> >>        pargraphs.
> >
> > (nit: paragraphs)
>
> I spotted that one also already. But thanks for reading carefully!
>
> >>        Consider the following scenario, where the supervisor tries to
> >>        read the pathname argument of a target's blocked mount(2) system
> >>        call:
> > [...]
> >> Seem okay?
> >
> > Yeah, sounds good.
> >
> >> By the way, is there any analogous kind of issue concerning
> >> pidfd_getfd()? I'm thinking not, but I wonder if I've missed
> >> something.
> >
> > When it is used by a seccomp supervisor, you mean? I think basically
> > the same thing applies - when resource identifiers (such as memory
> > addresses or file descriptors) are passed to a syscall, it generally
> > has to be assumed that those identifiers may become invalid and be
> > reused as soon as the syscall has returned.
>
> I probably needed to be more explicit. Would the following (i.e., a
> single cookie check) not be sufficient to handle the above scenario.
> Here, the target is making a syscall a system call that employs the
> file descriptor 'tfd':
>
> T: makes syscall that triggers notification
> S: Get notification
> S: pidfd = pidfd_open(T, 0);
> S: sfd = pifd_getfd(pidfd, tfd, 0)
> S: check that the cookie is still valid
> S: do operation with sfd [*]
>
> By contrast, I can see that we might want to do multiple cookie
> checks in the /proc/PID/mem case, since the supervisor might do
> multiple reads.

Aaah, okay. I didn't really understand the question at first.

> Or, do you mean: there really needs to be another cookie check after
> the point [*], since, if the the target's syscall was interrupted
> and 'tfd' was closed/resused, then the supervisor would be operating
> with a file descriptor that refers to an open file description
> (a "struct file") that is no longer meaningful in the target?
> (Thinking about it, I think this probably is what you mean, but
> I want to confirm.)

I wasn't thinking about your actual question when I wrote that. :P

I think you could argue that leaving out the first cookie check does
not make this incorrect if it was correct before; but you could also
argue that it's hazardous either way (because programs might rely on
synchronous actions that happen when closing an fd that they assume is
the only one associated with a file description, e.g. assuming that
close() will synchronously release an flock() lock). And if we do two
checks, we can at least limit such potentially hazardous interference
to processes that performed syscalls subject to interception, instead
of risking triggering them all over the place.
