Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443B029DC66
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgJ1Wdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbgJ1Wda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF618C0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:33:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id l2so877863lfk.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFQ11nKNwZI/oGFeZxcljdz8x6kEb8+uWHBsNPCDUO0=;
        b=HFAjXWqAbYshDr2yDxrNzRjLAazYy3NYleGOwhPwLv1pzOgTqSzUGl4QAew8/0Ue0Z
         UoM2bHGRSrCMkFFIE/eRm1e9A6GSJQQnBj0G0icXRTO3f42Z/TOgD2ZwXEDyH4EQzhtk
         ywG5wEF7+x5kI5uzusYn+VP7eFH2BvWpSYX2QaSH7NVhnOuxIXe879Y+CazILhKsmJD6
         IL/m69v/0hvM8YmGddWOL1C5qP87stMvRtBRmf4MLpcBB3WPUywYeyXiWwll/+B6xjhd
         0IHI4V6rTlKalnDT1Hs7tkfxy9/KFXAims9NH7Xvmh8xuaLNrqF4bCuC4UhMykb0uAU1
         +C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFQ11nKNwZI/oGFeZxcljdz8x6kEb8+uWHBsNPCDUO0=;
        b=h25fZ7Tylv4aPrYDBAOGBhQUfKwBbZpwKsWTCdvfjyYKuz12X79xWHK+BYU2uVc4Rl
         ATYvshArLBowI5BDt2EDiO5nwhKU4NCktzSFOjYntAW0F6a2kpIVYsAyMdRy9idcHCUA
         ozVZatcqY3wzbut+rOvVPE8cMfnbERHlZZIz+fNfMG7y1pBUxX5tv8EEVfEG0CjuNCn3
         SUELwWYhDCMCE1qeTDMa7lo7NMYGjB6areiyc9VfFTUxhhkVPI+5GRrTM6b/fWHA+ZWr
         0VapKc5mfmgueQp0MAIrbhuw1c3fN8G6HLlNkKaKSQlAmSCwaLSVrsSw+m3zsvKC34YI
         Uz2A==
X-Gm-Message-State: AOAM533UqbmHBXBCxl871qCtXj70B7Id87ux0i16Q8TxeN6pMhVgoXec
        gk84aOT1aZmAGWxiDWEC+JyLJKqZJ4vUDuxrO2eSxTLekKk=
X-Google-Smtp-Source: ABdhPJwVRGG3pvmn4VHogbgp0mRkC+3Vo3abv5ijmC6QlpCo8lhtrVsa4JWD3BkVHYUkQR8qg4e+R3v66NEu2I+If+A=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr2561887lfb.576.1603878221599;
 Wed, 28 Oct 2020 02:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
 <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com> <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
 <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com> <CAG48ez2Nb95ae+XwZPYRju1KO-Ps_4R6QxN6ioUhOy2Uok=uAg@mail.gmail.com>
 <CAMp4zn_Qt2MYuoLojn5ikRkr-J5yGimirjevoAvorK5wfzrBHg@mail.gmail.com>
In-Reply-To: <CAMp4zn_Qt2MYuoLojn5ikRkr-J5yGimirjevoAvorK5wfzrBHg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 10:43:14 +0100
Message-ID: <CAG48ez1drOxgcpuKHiJc+khwmLvqoXfK4yBt9_KHPGQipDf6NQ@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>,
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
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 7:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> On Tue, Oct 27, 2020 at 3:28 AM Jann Horn <jannh@google.com> wrote:
> > On Tue, Oct 27, 2020 at 7:14 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > > On 10/26/20 4:54 PM, Jann Horn wrote:
> > > > I'm a bit on the fence now on whether non-blocking mode should use
> > > > ENOTCONN or not... I guess if we returned ENOENT even when there are
> > > > no more listeners, you'd have to disambiguate through the poll()
> > > > revents, which would be kinda ugly?
> > >
> > > I must confess, I'm not quite clear on which two cases you
> > > are trying to distinguish. Can you elaborate?
> >
> > Let's say someone writes a program whose responsibilities are just to
> > handle seccomp events and to listen on some other fd for commands. And
> > this is implemented with an event loop. Then once all the target
> > processes are gone (including zombie reaping), we'll start getting
> > EPOLLERR.
> >
> > If NOTIF_RECV starts returning -ENOTCONN at this point, the event loop
> > can just call into the seccomp logic without any arguments; it can
> > just call NOTIF_RECV one more time, see the -ENOTCONN, and terminate.
> > The downside is that there's one more error code userspace has to
> > special-case.
> > This would be more consistent with what we'd be doing in the blocking case.
> >
> > If NOTIF_RECV keeps returning -ENOENT, the event loop has to also tell
> > the seccomp logic what the revents are.
> >
> > I guess it probably doesn't really matter much.
>
> So, in practice, if you're emulating a blocking syscall (such as open,
> perf_event_open, or any of a number of other syscalls), you probably
> have to do it on a separate thread in the supervisor because you want
> to continue to be able to receive new notifications if any other process
> generates a seccomp notification event that you need to handle.
>
> In addition to that, some of these syscalls are preemptible, so you need
> to poll SECCOMP_IOCTL_NOTIF_ID_VALID to make sure that the program
> under supervision hasn't left the syscall.
>
> If we're to implement a mechanism that makes the seccomp ioctl receive
> non-blocking, it would be valuable to address this problem as well (getting
> a notification when the supervisor is processing a syscall and needs to
> preempt it). In the best case, this can be a minor inconvenience, and
> in the worst case this can result in weird errors where you're keeping
> resources open that the container expects to be closed.

Does "a notification" mean signals? Or would you want to have a second
thread in userspace that poll()s for cancellation events on the
seccomp fd and then somehow takes care of interrupting the first
thread, or something like that?

Either way, I think your proposal goes beyond the scope of patching
the existing weirdness, and should be a separate patch.
