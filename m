Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A58298973
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422405AbgJZJcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 05:32:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45888 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422402AbgJZJcc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 05:32:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id r127so10814343lff.12
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=StRkGUih/x/ZPb5WlhQHkdi1r1gUGmh5+DpBU/QI0b8=;
        b=bxArDnwnKKVb47+2JvvYUq8R/IEKsf7ylVrQGNciSnSoYPwE7dnVtR5YwfMO5uBNZw
         fHEDR8Tr/1TRXyiJJq95vuLudMRzpJqxxDTnXOTuZKU6/Z3xjWXSTs4P9xyBhGIaB0Mj
         dEj7BC/L/+TXKWqGb0DXEmgMH0eBzD3NgBeP5L0Bz4eQGAdM3hCz+SHgxO9GytIKoU4w
         JiHeltxTxG2TscaaBmkbuFitP3camZYG1gpykQPwS9aCxt/gwIFltkyjA/3cOBDh9NN8
         32EcuS/qkGiTUBRiM6AmttqPELBPELkKaBF1xwD7TWGHSMVEVSqBV892aAqbMi/3zsVw
         Y4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=StRkGUih/x/ZPb5WlhQHkdi1r1gUGmh5+DpBU/QI0b8=;
        b=iWzKRNOb4oqpLfWg9BzvOb7yhcJ24Nz0UiUTlnUlJOZtyoWlBV69fhFgs1g5Kk4ycf
         TKEEoarnp81pjHUarjn+766AYnsU8E/F4aYCUgktWSH81Oso34KkuzjCrsjGIU0WAzmY
         tUhJa99WRHGfsw43A5ZgCL4PiEAwVdnRDFBunICpFKLJp7G7dWJoyxtHDLw4pu++561h
         osLF4usHScIh3Kxmv4NGGxS6Hj8gcgxbk5ocnwfRV/jLyFZgO+5CMdOVEAYC2vyQIlKD
         DhaQF+b2+b7Nl4JxVhK3vqbmU6lvB0MAPVJvmpSdgSSjdIZbADNViW9pKIOLppWpKjpO
         DzDA==
X-Gm-Message-State: AOAM53197sNtG1utCmJG3+lL7+BgSXrdgORJS/E8NQ+kbfpYBSpfIyap
        Js7tcaO7agAj48GkTvo2qfDXytlqn9bDcqioXi7Ocg==
X-Google-Smtp-Source: ABdhPJzBH+MPjCV8ct7DvlWTvTVhdnKL880/VXAqc2B1yNSMODbYCXhKALP0wqXMPnA3SOp/W9yOCEL7k8bIsiJOPMI=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr4425834lfr.198.1603704749529;
 Mon, 26 Oct 2020 02:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com> <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
 <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com> <CAG48ez1e-xKoJ_1v0DGMZ62WQCG7o7AUw+89DYEVbDpHWrdweA@mail.gmail.com>
 <887d5a29-edaa-2761-1512-370c1f5c3a6f@gmail.com>
In-Reply-To: <887d5a29-edaa-2761-1512-370c1f5c3a6f@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 26 Oct 2020 10:32:03 +0100
Message-ID: <CAG48ez2TcWb6SQ86XRJDdN-Ab_gO9-sXgpFnJODMXH60mCkBJQ@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 24, 2020 at 2:53 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/17/20 2:25 AM, Jann Horn wrote:
> > On Fri, Oct 16, 2020 at 8:29 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
[...]
> >> I'm not sure if I should write anything about this small UAPI
> >> breakage in BUGS, or not. Your thoughts?
> >
> > Thinking about it a bit more: Any code that relies on pause() or
> > epoll_wait() not restarting is buggy anyway, right? Because a signal
> > could also arrive directly before entering the syscall, while
> > userspace code is still executing? So one could argue that we're just
> > enlarging a preexisting race. (Unless the signal handler checks the
> > interrupted register state to figure out whether we already entered
> > syscall handling?)
>
> Yes, that all makes sense.
>
> > If userspace relies on non-restarting behavior, it should be using
> > something like epoll_pwait(). And that stuff only unblocks signals
> > after we've already past the seccomp checks on entry.
>
> Thanks for elaborating that detail, since as soon as you talked
> about "enlarging a preexisting race" above, I immediately wondered
> sigsuspend(), pselect(), etc.
>
> (Mind you, I still wonder about the effect on system calls that
> are normally nonrestartable because they have timeouts. My
> understanding is that the kernel doesn't restart those system
> calls because it's impossible for the kernel to restart the call
> with the right timeout value. I wonder what happens when those
> system calls are restarted in the scenario we're discussing.)

Ah, that's an interesting edge case...

> Anyway, returning to your point... So, to be clear (and to
> quickly remind myself in case I one day reread this thread),
> there is not a problem with sigsuspend(), pselect(), ppoll(),
> and epoll_pwait() since:
>
> * Before the syscall, signals are blocked in the target.
> * Inside the syscall, signals are still blocked at the time
>   the check is made for seccomp filters.
> * If a seccomp user-space notification  event kicks, the target
>   is put to sleep with the signals still blocked.
> * The signal will only get delivered after the supervisor either
>   triggers a spoofed success/failure return in the target or the
>   supervisor sends a CONTINUE response to the kernel telling it
>   to execute the target's system call. Either way, there won't be
>   any restarting of the target's system call (and the supervisor
>   thus won't see multiple notifications).
>
> (Right?)

Yeah.

[...]
> > So we should probably document the restarting behavior as something
> > the supervisor has to deal with in the manpage; but for the
> > "non-restarting syscalls can restart from the target's perspective"
> > aspect, it might be enough to document this as quirky behavior that
> > can't actually break correct code? (Or not document it at all. Dunno.)
>
> So, I've added the following to the page:
>
>    Interaction with SA_RESTART signal handlers
>        Consider the following scenario:
>
>        =C2=B7 The target process has used sigaction(2)  to  install  a  s=
ignal
>          handler with the SA_RESTART flag.
>
>        =C2=B7 The target has made a system call that triggered a seccomp =
user-
>          space notification and the target is currently blocked until the
>          supervisor sends a notification response.
>
>        =C2=B7 A  signal  is  delivered to the target and the signal handl=
er is
>          executed.
>
>        =C2=B7 When  (if)  the  supervisor  attempts  to  send  a  notific=
ation
>          response,  the SECCOMP_IOCTL_NOTIF_SEND ioctl(2)) operation will
>          fail with the ENOENT error.
>
>        In this scenario, the kernel  will  restart  the  target's  system
>        call.   Consequently,  the  supervisor  will receive another user-
>        space notification.  Thus, depending on how many times the blocked
>        system call is interrupted by a signal handler, the supervisor may
>        receive multiple notifications for the same  system  call  in  the
>        target.
>
>        One  oddity  is  that  system call restarting as described in this
>        scenario will occur even for the blocking system calls  listed  in
>        signal(7) that would never normally be restarted by the SA_RESTART
>        flag.
>
> Does that seem okay?

Sounds good to me.

> In addition, I've queued a cross-reference in signal(7):
>
>        In certain circumstances, the seccomp(2) user-space notifi=E2=80=
=90
>        cation  feature can lead to restarting of system calls that
>        would otherwise  never  be  restarted  by  SA_RESTART;  for
>        details, see seccomp_user_notif(2).
