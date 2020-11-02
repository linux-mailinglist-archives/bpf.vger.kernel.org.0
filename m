Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD52A34A8
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 20:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKBTup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 14:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgKBTuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 14:50:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC0C061A04
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 11:50:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id cw8so6959934ejb.8
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuAgLv2f6mFqdHacE9+5wTCMHHa9X4NzDVL7fw+zZwo=;
        b=1CwnQ2f2VpeHLpKzHV6y13UxaJS6DsrM9BmSxbwWWiCY2R4Bn56zP2Je+YuQTuHhCx
         K+npFD47oL/qcGReOKuY/0hKvIFUYB42b0Rb7hG/CcSU0AyKN0pBTrchaqOmJg1bsO5s
         J7+87OOdeZOYyDeRa7sKWuoFODr40ivuhsDjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuAgLv2f6mFqdHacE9+5wTCMHHa9X4NzDVL7fw+zZwo=;
        b=GQedub9ORlNfrPz+nuD9Va0/OrlWbu93BMwbkC8TWukfg92jXWTPs6zmc2lEIDyPVT
         r2eePnbD3KGexyjBsDPhPf6Y3DlFFMW+kR4PNTF7C9LbJasuVotgiIQub41tMwLqFRQs
         Psv8QT+sofQT+NTypoUTeAy/3h2VncaAyr2ZWnkFxBTcF/AZQk8ino7/MJyUqRNr0DOh
         auTmD/vj5LyuGiuFIOPPPVNa1pTH3Jj2gIXf3uUCFwVj692gRLzu1hpQyvj9KwLixrHM
         +WsOoaJadyjN2WO3xf4UkCKAE4RUDG6Jdnq3Shl2GUaxkUGbD5lOrJO6IJn6XQoakUJD
         nhsg==
X-Gm-Message-State: AOAM533jgef1ptby8PK+Xl1QyaS0Sy77Ack4suhPIPBaKMg0icLYz/rJ
        9sJawEbZDNxq7iiw4htI/VeAVi0BSwUjf9z/oaQU6A==
X-Google-Smtp-Source: ABdhPJx3i3Y4942aBw8j5M3vnGT4TDeHkozBpQ+1RfSIVU3Tw1PsRvtTvkdbeHiGNDVZ+Kyy6g+eGdtrKD6wRwV6FWU=
X-Received: by 2002:a17:907:1008:: with SMTP id ox8mr10758032ejb.189.1604346616249;
 Mon, 02 Nov 2020 11:50:16 -0800 (PST)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029085312.GC29881@ircssh-2.c.rugged-nimbus-611.internal>
 <48e5937b-80f5-c48b-1c67-e8c9db263ca5@gmail.com> <20201030202720.GA4088@ircssh-2.c.rugged-nimbus-611.internal>
 <606199d6-b48c-fee2-6e79-1e52bd7f429f@gmail.com> <CAMp4zn9AaQ46EyG6QFrF33efpUHnK_TyMYkTicr=iwY5hcKrBg@mail.gmail.com>
 <964c2191-db78-ff4d-5664-1d80dc382df4@gmail.com>
In-Reply-To: <964c2191-db78-ff4d-5664-1d80dc382df4@gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 2 Nov 2020 11:49:40 -0800
Message-ID: <CAMp4zn9Eaq7UQqL4Gk7Cs2O3dj1Gfp8L_YDpWxhvru_kVEBVfw@mail.gmail.com>
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

On Mon, Nov 2, 2020 at 11:45 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Sargun,
>
> Thanks for your reply!
>
> On 11/2/20 9:07 AM, Sargun Dhillon wrote:
> > On Sat, Oct 31, 2020 at 9:27 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >>
> >> Hello Sargun,
> >>
> >> Thanks for your reply.
> >>
> >> On 10/30/20 9:27 PM, Sargun Dhillon wrote:
> >>> On Thu, Oct 29, 2020 at 09:37:21PM +0100, Michael Kerrisk (man-pages)
> >>> wrote:
> >>
> >> [...]
> >>
> >>>>> I think I commented in another thread somewhere that the
> >>>>> supervisor is not notified if the syscall is preempted. Therefore
> >>>>> if it is performing a preemptible, long-running syscall, you need
> >>>>> to poll SECCOMP_IOCTL_NOTIF_ID_VALID in the background, otherwise
> >>>>> you can end up in a bad situation -- like leaking resources, or
> >>>>> holding on to file descriptors after the program under
> >>>>> supervision has intended to release them.
> >>>>
> >>>> It's been a long day, and I'm not sure I reallu understand this.
> >>>> Could you outline the scnario in more detail?
> >>>>
> >>> S: Sets up filter + interception for accept T: socket(AF_INET,
> >>> SOCK_STREAM, 0) = 7 T: bind(7, {127.0.0.1, 4444}, ..) T: listen(7,
> >>> 10) T: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
> >>
> >> Presumably, the preceding line should have been:
> >>
> >> S: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
> >> (s/T:/S:/)
> >>
> >> right?
> >
> > Right.
> >>
> >>
> >>> T: accept(7, ...) S: Intercepts accept S: Does accept in background
> >>> T: Receives signal, and accept(...) responds in EINTR T: close(7) S:
> >>> Still running accept(7, ....), holding port 4444, so if now T
> >>> retries to bind to port 4444, things fail.
> >>
> >> Okay -- I understand. Presumably the solution here is not to
> >> block in accept(), but rather to use poll() to monitor both the
> >> notification FD and the listening socket FD?
> >>
> > You need to have some kind of mechanism to periodically check
> > if the notification is still alive, and preempt the accept. It doesn't
> > matter how exactly you "background" the accept (threads, or
> > O_NONBLOCK + epoll).
> >
> > The thing is you need to make sure that when the process
> > cancels a syscall, you need to release the resources you
> > may have acquired on its behalf or bad things can happen.
> >
>
> Got it. I added the following text:
>
>    Caveats regarding blocking system calls
>        Suppose that the target performs a blocking system call (e.g.,
>        accept(2)) that the supervisor should handle.  The supervisor
>        might then in turn execute the same blocking system call.
>
>        In this scenario, it is important to note that if the target's
>        system call is now interrupted by a signal, the supervisor is not
>        informed of this.  If the supervisor does not take suitable steps
>        to actively discover that the target's system call has been
>        canceled, various difficulties can occur.  Taking the example of
>        accept(2), the supervisor might remain blocked in its accept(2)
>        holding a port number that the target (which, after the
>        interruption by the signal handler, perhaps closed  its listening
>        socket) might expect to be able to reuse in a bind(2) call.
>
>        Therefore, when the supervisor wishes to emulate a blocking system
>        call, it must do so in such a way that it gets informed if the
>        target's system call is interrupted by a signal handler.  For
>        example, if the supervisor itself executes the same blocking
>        system call, then it could employ a separate thread that uses the
>        SECCOMP_IOCTL_NOTIF_ID_VALID operation to check if the target is
>        still blocked in its system call.  Alternatively, in the accept(2)
>        example, the supervisor might use poll(2) to monitor both the
>        notification file descriptor (so as as to discover when the
>        target's accept(2) call has been interrupted) and the listening
>        file descriptor (so as to know when a connection is available).
>
>        If the target's system call is interrupted, the supervisor must
>        take care to release resources (e.g., file descriptors) that it
>        acquired on behalf of the target.
>
> Does that seem okay?
>
This is far clearer than my explanation. The one thing is that *just*
poll is not good enough, you would poll, with some timeout, and when
that timeout is hit, check if all the current notifications are valid,
as poll isn't woken up when an in progress notification goes off
AFAIK.

> >>>>> ENOENT The cookie number is not valid. This can happen if a
> >>>>> response has already been sent, or if the syscall was
> >>>>> interrupted
> >>>>>
> >>>>> EBADF If the file descriptor specified in srcfd is invalid, or if
> >>>>> the fd is out of range of the destination program.
> >>>>
> >>>> The piece "or if the fd is out of range of the destination program"
> >>>> is not clear to me. Can you say some more please.
> >>>>
> >>>
> >>> IIRC the maximum fd range is specific in proc by some sysctl named
> >>> nr_open. It's also evaluated against RLIMITs, and nr_max.
> >>>
> >>> If nr-open (maximum fds open per process, iiirc) is 1000, even if 10
> >>> FDs are open, it wont work if newfd is 1001.
> >>
> >> Actually, the relevant limit seems to be just the RLIMIT_NOFILE
> >> resource limit at least in my reading of fs/file.c::replace_fd().
> >> So I made the text
> >>
> >>               EBADF  Allocating the file descriptor in the target would
> >>                      cause the target's RLIMIT_NOFILE limit to be
> >>                      exceeded (see getrlimit(2)).
> >>
> >>
> >
> > If you're above RLIMIT_NOFILE, you get EBADF.
> >
> > When we do __receive_fd with a specific fd (newfd specified):
> > https://elixir.bootlin.com/linux/latest/source/fs/file.c#L1086
> >
> > it calls replace_fd, which calls expand_files. expand_files
> > can fail with EMFILE.
> >
> >>>>> EINVAL If flags or new_flags were unrecognized, or if newfd is
> >>>>> non-zero, and SECCOMP_ADDFD_FLAG_SETFD has not been set.
> >>>>>
> >>>>> EMFILE Too many files are open by the destination process.
> >>
> >> I'm not sure that the error can really occur. That's the error
> >> that in most other places occurs when RLIMIT_NOFILE is exceeded.
> >> But I may have missed something. More precisely, when do you think
> >> EMFILE can occur?
> >>
> > It can happen if the user specifies a newfd which is too large.
>
> Got it. Thanks! I made the error text:
>
>         EMFILE The file descriptor number specified in newfd  exceeds  the
>               limit specified in /proc/sys/fs/nr_open.
>
Sure. I don't think there are any other limits here, nor do I think there
are any systems which use something other than unsigned int for
their file descriptors [table].

> Thanks,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
