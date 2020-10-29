Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB30929E3F8
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 08:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgJ2HYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgJ2HYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C7C0613AB
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 21:44:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t13so1626215ljk.12
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vJY7X+2qf9mk4yjNjSimkTKUqnRW4h3rIif/0iLOrE=;
        b=gZ8H/p46CECRx9wDoVffbN/h0TJ0bUslUCW4zEC9UGCLKm/cXqu5uiZC1A8cryr+E8
         e0dLqac5CrQ0wZy68hcC5mDMEnQW3ZBUwc7+nrlVGLwjzOWHmxGB84B6A7tq9XDnv19s
         M7QjYPJ1Rgm+8fE1FFuZrcNgCnJkq5XlKbHAN6QN93QfeuU4o+r0DZj/rSPyFxLyR9HX
         goLYDldHw4PKN4C16oNQfIjUL+sxQTmKcTIGcQlhOv8tjXF8krfMfUE47zD8S0ABnIzk
         C8yOWDT4K5Mx4UbUn4ZaqYyEFrICmzbt6zNb1oXbkYLIFdMceLLg+ASw3I9w2T4L15rH
         1NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vJY7X+2qf9mk4yjNjSimkTKUqnRW4h3rIif/0iLOrE=;
        b=cnm+RxQU8myCDiZHZ4kk32lGZ0Rjq4WkctBlHGYxHdaTSl9qRjWAubCW/Q0a0T93DQ
         7dBVU/LumBivJBULgCJLsii2PT1xMfHLufWQNvY0y9tBTg8S7wxgJP1CK5sncBBtQ0On
         H4WsnjxIZ5LoSvEV4ttuJ2S9UbwQ7w3yJYBdkT+eXDVJ8a0y1ax7pMWAjgkTrYmWp3J6
         GN6VOg0E+Lt1iCs0+TIFU6p0WeO8EJq/j5ZNDgB1xypDofWXyqSJcONA4YHWDtwOGiGu
         Fb/mwMPFf61WEFGDohReamF+TObeIZbpDb/F3Tdr5F5X89H5Knb92mstaMu8fkuem64Y
         zDCA==
X-Gm-Message-State: AOAM5317FGmST7KEB4/p5uD8XfnDVwdXZqwvD2gbgbVp5dp4Nmz6FBqO
        iYxIXWbor7ZdclORaR1/f6h/ih57glGpYv4ka0o59A==
X-Google-Smtp-Source: ABdhPJw/sZxb5qRToKpsO6Tov3q5O2h9QxUZH9e9awkjhLv1ZkCLPaqe/eslUoWDbcpwUPRAcE7vE1CzAPHEQGncXAA=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr981272lji.326.1603946642027;
 Wed, 28 Oct 2020 21:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com> <20201029020438.GA25673@cisco>
In-Reply-To: <20201029020438.GA25673@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 05:43:35 +0100
Message-ID: <CAG48ez1Jz5YqqEMFYoFhgSroHwMeiNqUU9i=QqLN2uLibKthDQ@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Tycho Andersen <tycho@tycho.pizza>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Thu, Oct 29, 2020 at 3:04 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> On Thu, Oct 29, 2020 at 02:42:58AM +0100, Jann Horn wrote:
> > On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > >        static bool
> > >        getTargetPathname(struct seccomp_notif *req, int notifyFd,
> > >                          char *path, size_t len)
> > >        {
> > >            char procMemPath[PATH_MAX];
> > >
> > >            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
> > >
> > >            int procMemFd = open(procMemPath, O_RDONLY);
> > >            if (procMemFd == -1)
> > >                errExit("\tS: open");
> > >
> > >            /* Check that the process whose info we are accessing is still alive.
> > >               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
> > >               in checkNotificationIdIsValid()) succeeds, we know that the
> > >               /proc/PID/mem file descriptor that we opened corresponds to the
> > >               process for which we received a notification. If that process
> > >               subsequently terminates, then read() on that file descriptor
> > >               will return 0 (EOF). */
> > >
> > >            checkNotificationIdIsValid(notifyFd, req->id);
> > >
> > >            /* Read bytes at the location containing the pathname argument
> > >               (i.e., the first argument) of the mkdir(2) call */
> > >
> > >            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
> > >            if (nread == -1)
> > >                errExit("pread");
> >
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
>
> By freeze here you mean a killable wait instead of an interruptible
> wait, right?

Nope, nonkillable.

Consider the case of vfork(), where a target process does something like this:

void spawn_executable(char **argv, char **envv) {
  pid_t child = vfork();
  if (child == 0) {
    char path[1000];
    sprintf(path, ...);
    execve(path, argv, envv);
  }
}

and the seccomp notifier wants to look at the execve() path (as a
somewhat silly example). The child process is just borrowing the
parent's stack, and as soon as the child either gets far enough into
execve() or dies, the parent continues using that stack. So keeping
the child in killable sleep would not be enough to prevent reuse of
the child's stack.


But conceptually that's not really a big problem - we already have a
way to force the target task to stay inside the seccomp code no matter
if it gets SIGKILLed or whatever, and that is to take the notify_lock.
When the target task wakes up and wants to continue executing, it has
to first get through mutex_lock(&match->notify_lock) - and that will
always block until the lock is free. So we could e.g. do something
like:

 - Grab references to the source pages in the supervisor's address
space with get_user_pages_fast().
 - Take mmap_sem on the target.
 - Grab references to pages in the relevant range with pin_user_pages_remote().
 - Drop the mmap_sem.
 - Take the notify_lock.
 - Recheck whether the notification with the right ID is still there.
 - Copy data from the pinned source pages to the pinned target pages.
 - Drop the notify_lock.
 - Drop the page references.

and this way we would still guarantee that the target process would
only be blocked in noninterruptible sleep for a small amount of time
(and would not be indirectly blocked on sleeping operations through
the mutex). It'd be pretty straightforward, I think. But as long as we
don't actually need it, it might be easier to just note in the manpage
that this is not currently supported.
