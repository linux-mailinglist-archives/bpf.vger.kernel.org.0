Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A52A0ED0
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 20:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgJ3TPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgJ3TPG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 15:15:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE619C0613D5
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:15:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 126so9236400lfi.8
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wG/u6QLDIeO3+GPNzepwWscTWygaEgqcNOvOguEOtzE=;
        b=GEScQJl/XRE+Al+2evygNVW34IiBSkoia8s5HzAl8Hv6DEbsHP21Lirga/6tIsjkoR
         6pndjXo3bhKZOW1Dk5Uub2F/QyY+XpBeX+nLyHZxDUaPhBwraxjKmyUU389u1/xqXlL/
         voC7OY6hmd5Fr4gE/vpOFEq+3M/K4uBWKjshMkpddljKtLvb7oEgjUepvGxdHLB+qlRi
         lsXaJFer4KS7uPl33OEqYL9fA3HJYLgu76FbsgqoBkyILSU1vMZhuNLi6w9qOqfkXaAU
         ytPJv1sI1qSIE1x7QKh8O++0G+mtEs+XlsK0dEAC2cz1JpC6LyJR8sRuqTs2bq0q6mTh
         QDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wG/u6QLDIeO3+GPNzepwWscTWygaEgqcNOvOguEOtzE=;
        b=a2JQCYwPiM4jEiiPweBuFWyi5cfTMw+yR9yzAq+QSuUVAs76ZOOaARozLOrcIHvyBq
         9g9Ut8ghBQS6hr5IMaLBAH9suvx+/oVCKrJEy45EgLa8aqgFB17+PCH+5I+KvqCBkQYX
         fRWYRScTEiOtp8Slsh1bh1PeGGuuoN5C919z6Cfjffk5D9J2EXBqbdUMC2EJM58+VA04
         RqI/NN+0X7Ht/6Dc46MqDAHsl9AfX+uh9RjEgQab9XZ24FA0PPajjvxuVTh3XwfgNMDw
         X2DWnC4v0o8BySW5o//MXWLBF564Zplnx9t7sOy1dE2V3eLuLiV6ueOzJTzQpj9p/HUy
         UVWQ==
X-Gm-Message-State: AOAM531OKJOgaEalpvz67DRrtWREL+zgwQCy4pGxmN6Ga32zKY9jHg8T
        3ddSG/gf/ni4f/w2f+SFO+OeOS2qjG23hoV9mc5LOg==
X-Google-Smtp-Source: ABdhPJwWwVpiw9gJ/puN8rWssNkdz8vVGHPzS0mmXDNNvTGXQ5m+dUeuCNcHNeJlQwiyM5w1WvddtFCfbNI2DKeMRtk=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr1626841lfb.576.1604085303713;
 Fri, 30 Oct 2020 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com> <0de41eb1-e1fd-85da-61b7-fac4e3006726@gmail.com>
In-Reply-To: <0de41eb1-e1fd-85da-61b7-fac4e3006726@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 20:14:37 +0100
Message-ID: <CAG48ez3qKg-ReY4R=S_thQ6tOzv2ZHV=xW5qBxpqs0iSjH_oFQ@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 3:19 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/29/20 2:42 AM, Jann Horn wrote:
> > On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >>        static bool
> >>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
> >>                          char *path, size_t len)
> >>        {
> >>            char procMemPath[PATH_MAX];
> >>
> >>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
> >>
> >>            int procMemFd = open(procMemPath, O_RDONLY);
> >>            if (procMemFd == -1)
> >>                errExit("\tS: open");
> >>
> >>            /* Check that the process whose info we are accessing is still alive.
> >>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
> >>               in checkNotificationIdIsValid()) succeeds, we know that the
> >>               /proc/PID/mem file descriptor that we opened corresponds to the
> >>               process for which we received a notification. If that process
> >>               subsequently terminates, then read() on that file descriptor
> >>               will return 0 (EOF). */
> >>
> >>            checkNotificationIdIsValid(notifyFd, req->id);
> >>
> >>            /* Read bytes at the location containing the pathname argument
> >>               (i.e., the first argument) of the mkdir(2) call */
> >>
> >>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
> >>            if (nread == -1)
> >>                errExit("pread");
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
>
> Thanks very much for pointing me at this!
>
> So, I want to conform that the fix to the code is as simple as
> adding a check following the pread() call, something like:
>
> [[
>      ssize_t nread = pread(procMemFd, path, len, req->data.args[argNum]);
>      if (nread == -1)
>         errExit("Supervisor: pread");
>
>      if (nread == 0) {
>         fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>                 "returned 0 (EOF)\n");
>         exit(EXIT_FAILURE);
>      }
>
>      if (close(procMemFd) == -1)
>         errExit("Supervisor: close-/proc/PID/mem");
>
> +    /* Once again check that the notification ID is still valid. The
> +       case we are particularly concerned about here is that just
> +       before we fetched the pathname, the target's blocked system
> +       call was interrupted by a signal handler, and after the handler
> +       returned, the target carried on execution (past the interrupted
> +       system call). In that case, we have no guarantees about what we
> +       are reading, since the target's memory may have been arbitrarily
> +       changed by subsequent operations. */
> +
> +    if (!notificationIdIsValid(notifyFd, req->id, "post-open"))
> +        return false;
> +
>      /* We have no guarantees about what was in the memory of the target
>         process. We therefore treat the buffer returned by pread() as
>         untrusted input. The buffer should be terminated by a null byte;
>         if not, then we will trigger an error for the target process. */
>
>      if (strnlen(path, nread) < nread)
>          return true;
> ]]

Yeah, that should do the job. With the caveat that a cancelled syscall
could've also led to the memory being munmap()ed, so the nread==0 case
could also happen legitimately - so you might want to move this check
up above the nread==0 (mm went away) and nread==-1 (mm still exists,
but read from address failed, errno EIO) checks if the error message
shouldn't appear spuriously.
