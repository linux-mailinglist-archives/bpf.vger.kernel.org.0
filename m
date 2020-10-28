Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1962029DE90
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 01:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgJ2Axo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbgJ1WTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3451C0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:19:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z5so1114551ejw.7
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mJKft8XKv9esuODa0HybPLYtMlIcMD5oOcu7Q4PSJI=;
        b=iU06lpirPLmYBtyihfia3PCIDHgD4Hv1VmfiHd3ZlYfgicQdUWU5wyYCJi/7DoyRjC
         W//HSHhrNMnE1lr/mNTNyraHjIIQYzW8sKsk6wAMdexpSxRhsMc3CVN4k6RnmsIHoXnq
         stre3jFgIUrZa93sIOqSvErbnGWUasoLfvwyoNYHJlJu1HNNpJhI87yVbqyoKQxkVSUE
         JBD5d/Smb0YbFLdPwmNBvvIrh2xXXM2lOhdIBJY2CwKSjWMt+c06mjNFGvzSxFTJP4G2
         kfM9Wncbywwwe2Q4mVy32TLg3RXou2nRohbsi+cNd6u7r7UPP8lOj7WyyCZRMKe7qHcP
         oC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mJKft8XKv9esuODa0HybPLYtMlIcMD5oOcu7Q4PSJI=;
        b=qiCSeC55p2YbA0cFXtchqS9wWnELq1GmevZt8fbBUgGBgdvRVZs39r7qRHhRIspml1
         XiNEI/4ePwU6WVSBi9MoR0UyEi5ZuFvT66hTNt25WpFq8qJmrrTmpabZIeweDEBKdtnj
         vwK8y9dA3r1rRI5dKCVdPtwAq3CfcZcTI4a8G6oV57lNk+G0fzjf2xmInLeMBtFA+Ppe
         ojH7+YrBG+oQfs/xZvqTaC+rI8il8F+2pZ4ikJO9ff/ug3hg4zNo7L3EnUDtrnANfcfy
         HlH2y8I8x64fzIa2QBnlf9PyRGdXyRIkbS7xgeG1KZWV8/w9VkG1fhZImNzGxRbtPt/s
         p5hg==
X-Gm-Message-State: AOAM530LGK5r/HrOWb7S956bEoitJf4AhqZ6rfBcHXyraFMF+8AU71Ye
        H/sSPlXnYLlY16SJLSjXidrxOwd/zbDhaPWLUqrR92PEa9M=
X-Google-Smtp-Source: ABdhPJycpuLv9jd69NzqFaV2J/BjwQIR6ohzxT/PB3zAMX1GH8YrulFXzAg3UA5hwI3lSCqavgsZvm9lH8ns4sbpleU=
X-Received: by 2002:a19:c357:: with SMTP id t84mr148491lff.34.1603909281937;
 Wed, 28 Oct 2020 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
 <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com> <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
 <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com> <CAG48ez2Nb95ae+XwZPYRju1KO-Ps_4R6QxN6ioUhOy2Uok=uAg@mail.gmail.com>
 <CAMp4zn_Qt2MYuoLojn5ikRkr-J5yGimirjevoAvorK5wfzrBHg@mail.gmail.com>
 <CAG48ez1drOxgcpuKHiJc+khwmLvqoXfK4yBt9_KHPGQipDf6NQ@mail.gmail.com> <CAMp4zn9O-a3_wzO1RLr8uujdS+fGYTC0+b=MRQK9TihLToU--w@mail.gmail.com>
In-Reply-To: <CAMp4zn9O-a3_wzO1RLr8uujdS+fGYTC0+b=MRQK9TihLToU--w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 19:20:55 +0100
Message-ID: <CAG48ez1O2H5HDikPO-_o-toXTheU8GnZot9woGDsNRNJqSWesA@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 6:44 PM Sargun Dhillon <sargun@sargun.me> wrote:
> On Wed, Oct 28, 2020 at 2:43 AM Jann Horn <jannh@google.com> wrote:
> > On Wed, Oct 28, 2020 at 7:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > On Tue, Oct 27, 2020 at 3:28 AM Jann Horn <jannh@google.com> wrote:
> > > > On Tue, Oct 27, 2020 at 7:14 AM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > > > On 10/26/20 4:54 PM, Jann Horn wrote:
> > > > > > I'm a bit on the fence now on whether non-blocking mode should use
> > > > > > ENOTCONN or not... I guess if we returned ENOENT even when there are
> > > > > > no more listeners, you'd have to disambiguate through the poll()
> > > > > > revents, which would be kinda ugly?
> > > > >
> > > > > I must confess, I'm not quite clear on which two cases you
> > > > > are trying to distinguish. Can you elaborate?
> > > >
> > > > Let's say someone writes a program whose responsibilities are just to
> > > > handle seccomp events and to listen on some other fd for commands. And
> > > > this is implemented with an event loop. Then once all the target
> > > > processes are gone (including zombie reaping), we'll start getting
> > > > EPOLLERR.
> > > >
> > > > If NOTIF_RECV starts returning -ENOTCONN at this point, the event loop
> > > > can just call into the seccomp logic without any arguments; it can
> > > > just call NOTIF_RECV one more time, see the -ENOTCONN, and terminate.
> > > > The downside is that there's one more error code userspace has to
> > > > special-case.
> > > > This would be more consistent with what we'd be doing in the blocking case.
> > > >
> > > > If NOTIF_RECV keeps returning -ENOENT, the event loop has to also tell
> > > > the seccomp logic what the revents are.
> > > >
> > > > I guess it probably doesn't really matter much.
> > >
> > > So, in practice, if you're emulating a blocking syscall (such as open,
> > > perf_event_open, or any of a number of other syscalls), you probably
> > > have to do it on a separate thread in the supervisor because you want
> > > to continue to be able to receive new notifications if any other process
> > > generates a seccomp notification event that you need to handle.
> > >
> > > In addition to that, some of these syscalls are preemptible, so you need
> > > to poll SECCOMP_IOCTL_NOTIF_ID_VALID to make sure that the program
> > > under supervision hasn't left the syscall.
> > >
> > > If we're to implement a mechanism that makes the seccomp ioctl receive
> > > non-blocking, it would be valuable to address this problem as well (getting
> > > a notification when the supervisor is processing a syscall and needs to
> > > preempt it). In the best case, this can be a minor inconvenience, and
> > > in the worst case this can result in weird errors where you're keeping
> > > resources open that the container expects to be closed.
> >
> > Does "a notification" mean signals? Or would you want to have a second
> > thread in userspace that poll()s for cancellation events on the
> > seccomp fd and then somehow takes care of interrupting the first
> > thread, or something like that?
>
> I would be reluctant to be prescriptive in that it be a signal. Right
> now, it's implemented
> as a second thread in userspace that does a ioctl(...) and checks if
> the notification
> is valid / alive, and does what's required if the notification has
> died (interrupting
> the first thread).
>
> >
> > Either way, I think your proposal goes beyond the scope of patching
> > the existing weirdness, and should be a separate patch.
>
> I agree it should be a separate patch, but I think that it'd be nice if there
> was a way to do something like:
> * opt-in to getting another message after receiving the notification
>   that indicates the program has left the syscall

I guess to do that cleanly, we'd want something like an array
associated with the seccomp filter that has a size N that's determined
when the filter is set up... and then when a received but unanswered
notification is cancelled, we'd insert its identifier into that array.
And if we enforce that the supervisor can never have more than N
pending messages (by just not delivering new ones if there are N old
ones pending), we'll know that any possible cancellation will always
fit, and we don't need to worry about dynamic memory allocation.

And we could raise EPOLLPRI on the file descriptor when the array is
non-empty, so that if userspace doesn't currently want to handle new
notifications (because it's already dealing with a bunch of them),
userspace can do that, too.

> * when you do the RECV, you can specify a flag or some such asking
>   that you get signaled / notified about the program leaving the syscall

I think filter setup time is easier to deal with than RECV time.

> * a multiplexed receive that can say if an existing notification in progress
>   has left the valid state.

Or alternatively a separate ioctl for receiving cancellation messages,
which you'd only call on EPOLLPRI.
