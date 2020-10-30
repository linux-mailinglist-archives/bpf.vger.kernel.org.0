Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83D2A0E93
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3TWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgJ3TUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 15:20:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748AAC0613D5
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:20:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i6so9304307lfd.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ltXFGIEC1wD1/DcBqIE9Zp9UpD0Eob4weHsly+LU6s=;
        b=NKzAXeWRhEzSsyPxWy8lABW/VB/K7yCL712Wgf/ZLf7MLh2aHZKNViiJYIbi5Z9IUk
         0D2VbKnfwvyD2QdfVIYU+1lfoDbLp2UF9hubMPUnOM8plYKIesS4Jd32XnljUf+5Wr21
         fZ+UR9thk5kKUDBVcXk7E/KewhR4XtulAfljMrcCfiNYGTQrDJ4EF1AvjbDZkzjilzB1
         1k4tGbZ6wS/da8Gqb6S3LJWsxLFX5rCei0jdonnPR7zzIioIklmXmIkKlgBZLR+ERq9I
         TtV6o7qnXxRlP9zqMwKYrd9GYW6Mnx069+xDdw7tkMGQAZ/IdoP9rZYBB5nLy51sfqsR
         3SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ltXFGIEC1wD1/DcBqIE9Zp9UpD0Eob4weHsly+LU6s=;
        b=Sn2Q+EpqXnLCelH1Oq5xeuiue6oP/WOedHjv1HnUT98ZU93lR/XG1CxF6wzeKeOlmj
         muBQTTt9HhPj4yLr1BmIi2fUrz2xDzVTk+gClWNIzSutG/aeJyKIzEJdqwefembAlAdd
         PB4CiQQDgzzpGsVfDrkNw5LT8hPI0If5PTjcLjxlAXvbYzxi8wiKiZUvmi55cOQNY/Li
         krdvC0i1vA7G0YitapyYwOszHVtZ1L1XVYF+ZM7eLAPDhhH4/PmZ7y4h92meJtziFyIt
         LbArHg/F9ZM2Tq0mWLGNFTMREX98IPdnLoP1ABzfaM2v9b0uzLm6isAr6+CQR7ddmKTp
         77CQ==
X-Gm-Message-State: AOAM532Gx2xZ5ZuZYjAScrG8KsNkMJ9xzfB15zyZAM1Z9CuX15u4sxOt
        z0FDifXRkhwNIULSkU4tbTWUbC8O7SsqzJT1pXreTg==
X-Google-Smtp-Source: ABdhPJzPd9Yn3eLEZ6vKKsiFecuFzporMourNqE58Gif0brpSLNfw6y269RW0/w1hGnLsri5OaWqZgnLzVxfJTsympg=
X-Received: by 2002:a19:c357:: with SMTP id t84mr1432560lff.34.1604085650471;
 Fri, 30 Oct 2020 12:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com> <93cfdc79-4c48-bceb-3620-4c63e9f4822e@gmail.com>
In-Reply-To: <93cfdc79-4c48-bceb-3620-4c63e9f4822e@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 20:20:24 +0100
Message-ID: <CAG48ez3nH2Oiz9wMSpvUxxX_TRYTT98d3Nj1vnCuJOj9CCXH8Q@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 8:14 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/29/20 2:42 AM, Jann Horn wrote:
> > As discussed at
> > <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
> > we need to re-check checkNotificationIdIsValid() after reading remote
> > memory but before using the read value in any way. Otherwise, the
> > syscall could in the meantime get interrupted by a signal handler, the
> > signal handler could return, and then the function that performed the
> > syscall could free() allocations or return (thereby freeing buffers on
> > the stack).
> >
> > In essence, this pread() is (unavoidably) a potential use-after-free
> > read; and to make that not have any security impact, we need to check
> > whether UAF read occurred before using the read value. This should
> > probably be called out elsewhere in the manpage, too...
> >
> > Now, of course, **reading** is the easy case. The difficult case is if
> > we have to **write** to the remote process... because then we can't
> > play games like that. If we write data to a freed pointer, we're
> > screwed, that's it. (And for somewhat unrelated bonus fun, consider
> > that /proc/$pid/mem is originally intended for process debugging,
> > including installing breakpoints, and will therefore happily write
> > over "readonly" private mappings, such as typical mappings of
> > executable code.)
> >
> > So, uuuuh... I guess if anyone wants to actually write memory back to
> > the target process, we'd better come up with some dedicated API for
> > that, using an ioctl on the seccomp fd that magically freezes the
> > target process inside the syscall while writing to its memory, or
> > something like that? And until then, the manpage should have a big fat
> > warning that writing to the target's memory is simply not possible
> > (safely).
>
> Thank you for your very clear explanation! It turned out to be
> trivially easy to demonstrate this issue with a slightly modified
> version of my program.
>
> As well as the change to the code example that I already mentioned
> my reply of a few hours ago, I've added the following text to the
> page:
>
>    Caveats regarding the use of /proc/[tid]/mem
>        The discussion above noted the need to use the
>        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) when opening the
>        /proc/[tid]/mem file of the target to avoid the possibility of
>        accessing the memory of the wrong process in the event that the
>        target terminates and its ID is recycled by another (unrelated)
>        thread.  However, the use of this ioctl(2) operation is also
>        necessary in other situations, as explained in the following
>        pargraphs.

(nit: paragraphs)

>        Consider the following scenario, where the supervisor tries to
>        read the pathname argument of a target's blocked mount(2) system
>        call:
[...]
> Seem okay?

Yeah, sounds good.

> By the way, is there any analogous kind of issue concerning
> pidfd_getfd()? I'm thinking not, but I wonder if I've missed
> something.

When it is used by a seccomp supervisor, you mean? I think basically
the same thing applies - when resource identifiers (such as memory
addresses or file descriptors) are passed to a syscall, it generally
has to be assumed that those identifiers may become invalid and be
reused as soon as the syscall has returned.
