Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8D2A25DC
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 09:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKBIIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 03:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgKBIIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 03:08:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7AC0617A6
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 00:08:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id za3so17619855ejb.5
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVZ44lAakVATpaZn6AFMxLNo91zcFdfPA6KergmIid0=;
        b=soliju8DduPmBCZLNq75kh9Cjsyu3/wq1kAN37XH8goV0Up7F182Vp9DHzuuUBhMF7
         jqBgZ7ZzKJqc5CIdq82G7mDGVnFLoK8BiHObC4pnK1LH45Vz7jnV8eeV3IgQTVuPFg12
         WZebtk8+oMrxX+jk59A8UgduGtdfL57NKzi4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVZ44lAakVATpaZn6AFMxLNo91zcFdfPA6KergmIid0=;
        b=TODniLI44rXG+bae4nJaw7XERsTqfiCKipJl0GxkrvglOiMNprNDE/j3tGLo9MGs4H
         VRQDXqABQ096j5aAuXUfFCTOPmNwqcQZls98cvrVYpWp1VdthV9qZZLUSgjNyKxLze8k
         qaN+TuXypNsGYmjxF8z/uh3hwuZKAWz6uuXytkBbP8jEl2ZsHrdecCNz7Fp4PW0pr9+t
         awGgexJ18Lm3l1f/Oo0W97hyIQawnTtpj5Z8aAs5GQx1zlfpT8jkM5KXNpUOsGyBKRMr
         CCB6bHy6eaIpuuNJPqJBwcwFlQkf8weyPf+g/qr953vglCkG0My76rR5phCkolstVR8h
         lBKA==
X-Gm-Message-State: AOAM530phyX7c3Ya1saiwsnA5EDwpQ1p6mUnUKAHHBP/eHk1NU9irNkj
        Fc+qbiexG4R93cndqL/wdDgBIi3Uea6f6ETpPqFrHQ==
X-Google-Smtp-Source: ABdhPJyJ0vM7BjDtdEvFrChTYmDsUK3Y0Vog1NSqXCYj/o5upyCHDtPrccnZ5JayxBS8Fg5dur90nO5Uh2xWbLdvISA=
X-Received: by 2002:a17:907:1008:: with SMTP id ox8mr8177911ejb.189.1604304490618;
 Mon, 02 Nov 2020 00:08:10 -0800 (PST)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029085312.GC29881@ircssh-2.c.rugged-nimbus-611.internal>
 <48e5937b-80f5-c48b-1c67-e8c9db263ca5@gmail.com> <20201030202720.GA4088@ircssh-2.c.rugged-nimbus-611.internal>
 <606199d6-b48c-fee2-6e79-1e52bd7f429f@gmail.com>
In-Reply-To: <606199d6-b48c-fee2-6e79-1e52bd7f429f@gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 2 Nov 2020 00:07:34 -0800
Message-ID: <CAMp4zn9AaQ46EyG6QFrF33efpUHnK_TyMYkTicr=iwY5hcKrBg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 31, 2020 at 9:27 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Sargun,
>
> Thanks for your reply.
>
> On 10/30/20 9:27 PM, Sargun Dhillon wrote:
> > On Thu, Oct 29, 2020 at 09:37:21PM +0100, Michael Kerrisk (man-pages)
> > wrote:
>
> [...]
>
> >>> I think I commented in another thread somewhere that the
> >>> supervisor is not notified if the syscall is preempted. Therefore
> >>> if it is performing a preemptible, long-running syscall, you need
> >>> to poll SECCOMP_IOCTL_NOTIF_ID_VALID in the background, otherwise
> >>> you can end up in a bad situation -- like leaking resources, or
> >>> holding on to file descriptors after the program under
> >>> supervision has intended to release them.
> >>
> >> It's been a long day, and I'm not sure I reallu understand this.
> >> Could you outline the scnario in more detail?
> >>
> > S: Sets up filter + interception for accept T: socket(AF_INET,
> > SOCK_STREAM, 0) = 7 T: bind(7, {127.0.0.1, 4444}, ..) T: listen(7,
> > 10) T: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
>
> Presumably, the preceding line should have been:
>
> S: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
> (s/T:/S:/)
>
> right?

Right.
>
>
> > T: accept(7, ...) S: Intercepts accept S: Does accept in background
> > T: Receives signal, and accept(...) responds in EINTR T: close(7) S:
> > Still running accept(7, ....), holding port 4444, so if now T
> > retries to bind to port 4444, things fail.
>
> Okay -- I understand. Presumably the solution here is not to
> block in accept(), but rather to use poll() to monitor both the
> notification FD and the listening socket FD?
>
You need to have some kind of mechanism to periodically check
if the notification is still alive, and preempt the accept. It doesn't
matter how exactly you "background" the accept (threads, or
O_NONBLOCK + epoll).

The thing is you need to make sure that when the process
cancels a syscall, you need to release the resources you
may have acquired on its behalf or bad things can happen.

> >>> A very specific example is if you're performing an accept on
> >>> behalf of the program generating the notification, and the
> >>> program intends to reuse the port. You can get into all sorts of
> >>> awkward situations there.
> >>
> >> [...]
> >>
> > See above
>
> [...]
>
> >>> In addition, if it is a socket, it inherits the cgroup v1 classid
> >>> and netprioidx of the receiving process.
> >>>
> >>> The argument of this is as follows:
> >>>
> >>> struct seccomp_notif_addfd { __u64 id; __u32 flags; __u32 srcfd;
> >>> __u32 newfd; __u32 newfd_flags; };
> >>>
> >>> id This is the cookie value that was obtained using
> >>> SECCOMP_IOCTL_NOTIF_RECV.
> >>>
> >>> flags A bitmask that includes zero or more of the
> >>> SECCOMP_ADDFD_FLAG_* bits set
> >>>
> >>> SECCOMP_ADDFD_FLAG_SETFD - Use dup2 (or dup3?) like semantics
> >>> when copying the file descriptor.
> >>>
> >>> srcfd The file descriptor number to copy in the supervisor
> >>> process.
> >>>
> >>> newfd If the SECCOMP_ADDFD_FLAG_SETFD flag is specified this will
> >>> be the file descriptor that is used in the dup2 semantics. If
> >>> this file descriptor exists in the receiving process, it is
> >>> closed and replaced by this file descriptor in an atomic fashion.
> >>> If the copy process fails due to a MAC failure, or if srcfd is
> >>> invalid, the newfd will not be closed in the receiving process.
> >>
> >> Great description!
> >>
> >>> If SECCOMP_ADDFD_FLAG_SETFD it not set, then this value must be
> >>> 0.
> >>>
> >>> newfd_flags The file descriptor flags to set on the file
> >>> descriptor after it has been received by the process. The only
> >>> flag that can currently be specified is O_CLOEXEC.
> >>>
> >>> On success, this operation returns the file descriptor number in
> >>> the receiving process. On failure, -1 is returned.
> >>>
> >>> It can fail with the following error codes:
> >>>
> >>> EINPROGRESS The cookie number specified hasn't been received by
> >>> the listener
> >>
> >> I don't understand this. Can you say more about the scenario?
> >>
> >
> > This should not really happen. But if you do a ADDFD(...), on a
> > notification *before* you've received it, you will get this error. So
> > for example,
> > --> epoll(....) -> returns
> > --> RECV(...) cookie id is 777
> > --> epoll(...) -> returns
> > <-- ioctl(ADDFD, id = 778) # Notice how we haven't done a receive yet
> > where we've received a notification for 778.
>
> Got it. Looking also at the source code, I came up with the
> following:
>
>               EINPROGRESS
>                      The user-space notification specified in the id
>                      field exists but has not yet been fetched (by a
>                      SECCOMP_IOCTL_NOTIF_RECV) or has already been
>                      responded to (by a SECCOMP_IOCTL_NOTIF_SEND).
>
> Does that seem okay?
>
Looks good to me.

> >>> ENOENT The cookie number is not valid. This can happen if a
> >>> response has already been sent, or if the syscall was
> >>> interrupted
> >>>
> >>> EBADF If the file descriptor specified in srcfd is invalid, or if
> >>> the fd is out of range of the destination program.
> >>
> >> The piece "or if the fd is out of range of the destination program"
> >> is not clear to me. Can you say some more please.
> >>
> >
> > IIRC the maximum fd range is specific in proc by some sysctl named
> > nr_open. It's also evaluated against RLIMITs, and nr_max.
> >
> > If nr-open (maximum fds open per process, iiirc) is 1000, even if 10
> > FDs are open, it wont work if newfd is 1001.
>
> Actually, the relevant limit seems to be just the RLIMIT_NOFILE
> resource limit at least in my reading of fs/file.c::replace_fd().
> So I made the text
>
>               EBADF  Allocating the file descriptor in the target would
>                      cause the target's RLIMIT_NOFILE limit to be
>                      exceeded (see getrlimit(2)).
>
>

If you're above RLIMIT_NOFILE, you get EBADF.

When we do __receive_fd with a specific fd (newfd specified):
https://elixir.bootlin.com/linux/latest/source/fs/file.c#L1086

it calls replace_fd, which calls expand_files. expand_files
can fail with EMFILE.

> >>> EINVAL If flags or new_flags were unrecognized, or if newfd is
> >>> non-zero, and SECCOMP_ADDFD_FLAG_SETFD has not been set.
> >>>
> >>> EMFILE Too many files are open by the destination process.
>
> I'm not sure that the error can really occur. That's the error
> that in most other places occurs when RLIMIT_NOFILE is exceeded.
> But I may have missed something. More precisely, when do you think
> EMFILE can occur?
>
It can happen if the user specifies a newfd which is too large.

> [...]
>
> Thanks,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
