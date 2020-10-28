Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1211129D927
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 23:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgJ1Woo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389157AbgJ1WmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667ADC0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:42:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p93so1163349edd.7
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt8DJxbLetO1WoXKcxRo5toKKtnSgKB5eVlWB58cOkk=;
        b=OH+AqmBT9Kdmi64IsMGc8MSNykUCembPpixPv4zzBrzrPu4ucwFsORVaHkMGcfPA4r
         8uCQVHV+8Wyli+9AttwM7qpv4f4tNC2hdEunrUWLLkSkWs0PWOUCa+n8YKIabHg6GLd7
         hiwxshPZf7ZvPf+4dweotp+Ny/sGKfx7EeycI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt8DJxbLetO1WoXKcxRo5toKKtnSgKB5eVlWB58cOkk=;
        b=mUoOJcyQqG8Cid2e2bSwf6XK84NWzEzd4sakUN4hbPMcZAUzyGKzTf5YULbuG0jp6j
         +FJ/kxKlo+b5EtqviaxvIw9nQ8Knw0xfO03LfxmgibPYLrm8tp+QKbaGVLxox3FPPn+t
         01JqlN+NhMTtdlWIbtfbOE8LRiqZRKU6zqoMps/EdPyFCZ8mX7gziKzHOtFBetHrf5sN
         +HcKOdH5wIcdJROnChxrGpXNHdpAuNnVSKSSyoxe6FktoRAR4bKkkSB8byhs16h7nJaX
         847oO+9RSXl0+FGtQ3AHF0g5twpWLEY7xmZX2izVayXySnGh4GW3u9zcSeDzg5LMvWTl
         wYpw==
X-Gm-Message-State: AOAM533pkY1lkkNmWsu2UA3MZBvrCyn9rRflmn8xCJ8DPd2W+6LVSUWd
        xHGTzKL8V7d/D/eFA9Wxs+0kBAUtx+GeftZCWcE1KGil9vs3acwm
X-Google-Smtp-Source: ABdhPJwxL/cNreEkGxZEeBkLMJW+nXtxbWJBnh3oGKara0Jkz/gJF9pPGAqnIO/XhWtV5NKiBIa/b6QweHKnigrOa6I=
X-Received: by 2002:a50:fb06:: with SMTP id d6mr6238984edq.312.1603866735356;
 Tue, 27 Oct 2020 23:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
 <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com> <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
 <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com> <CAG48ez2Nb95ae+XwZPYRju1KO-Ps_4R6QxN6ioUhOy2Uok=uAg@mail.gmail.com>
In-Reply-To: <CAG48ez2Nb95ae+XwZPYRju1KO-Ps_4R6QxN6ioUhOy2Uok=uAg@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 27 Oct 2020 23:31:39 -0700
Message-ID: <CAMp4zn_Qt2MYuoLojn5ikRkr-J5yGimirjevoAvorK5wfzrBHg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>
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

On Tue, Oct 27, 2020 at 3:28 AM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Oct 27, 2020 at 7:14 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> > On 10/26/20 4:54 PM, Jann Horn wrote:
> > > I'm a bit on the fence now on whether non-blocking mode should use
> > > ENOTCONN or not... I guess if we returned ENOENT even when there are
> > > no more listeners, you'd have to disambiguate through the poll()
> > > revents, which would be kinda ugly?
> >
> > I must confess, I'm not quite clear on which two cases you
> > are trying to distinguish. Can you elaborate?
>
> Let's say someone writes a program whose responsibilities are just to
> handle seccomp events and to listen on some other fd for commands. And
> this is implemented with an event loop. Then once all the target
> processes are gone (including zombie reaping), we'll start getting
> EPOLLERR.
>
> If NOTIF_RECV starts returning -ENOTCONN at this point, the event loop
> can just call into the seccomp logic without any arguments; it can
> just call NOTIF_RECV one more time, see the -ENOTCONN, and terminate.
> The downside is that there's one more error code userspace has to
> special-case.
> This would be more consistent with what we'd be doing in the blocking case.
>
> If NOTIF_RECV keeps returning -ENOENT, the event loop has to also tell
> the seccomp logic what the revents are.
>
> I guess it probably doesn't really matter much.

So, in practice, if you're emulating a blocking syscall (such as open,
perf_event_open, or any of a number of other syscalls), you probably
have to do it on a separate thread in the supervisor because you want
to continue to be able to receive new notifications if any other process
generates a seccomp notification event that you need to handle.

In addition to that, some of these syscalls are preemptible, so you need
to poll SECCOMP_IOCTL_NOTIF_ID_VALID to make sure that the program
under supervision hasn't left the syscall.

If we're to implement a mechanism that makes the seccomp ioctl receive
non-blocking, it would be valuable to address this problem as well (getting
a notification when the supervisor is processing a syscall and needs to
preempt it). In the best case, this can be a minor inconvenience, and
in the worst case this can result in weird errors where you're keeping
resources open that the container expects to be closed.
