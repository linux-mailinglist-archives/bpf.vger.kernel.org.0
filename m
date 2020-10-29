Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22729E0B4
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 02:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgJ2B1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgJ2B0D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 21:26:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89957C0613D1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 18:26:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d24so1285714ljg.10
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENdMKmrqyXsv1/gvLj91K20WZXwFdpBVsOP+30aC+9A=;
        b=n+NDm9uRHARMU/e6YLntF4bh7Ic1db7mSFvWo17ThyF1eYKn1L85739nSonOGKrqnC
         kZ0nlFbNvlIR/Q/2JRF3dO6W6ujHxM96SnAuNllGwpL9m6A+7kEFmy4RAWQS+jUmTxjn
         9ul9cuqR7ho/eeQJthrON4IxQxk3p2YDClTnPzxAtgdgwrTvyZ27DjwyBaGl4BqIG4V7
         0puw9K+PQT7gNCkfzLeKhBnYXnZGde9EZifRfkMemy25mZarKMIyUp2s0gdY++jrwXvQ
         clYZysyxsTB7gC158N4MZLmHi519zTHkui8tiQKb99V1Puz5rk62zUFAGSyC+HqFyQbA
         1hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENdMKmrqyXsv1/gvLj91K20WZXwFdpBVsOP+30aC+9A=;
        b=FK8oQxXsLTHZd+nXCaCsi61/kgVSsaqM+arJC0BWJ8xTaIUZR+1sZgY23rwF452712
         315SedoOHBDLU/y4J/dEmGEcZ5zAlRGb1yW5MuE3qeZ0sXar8WXAS5KXDxfvdWzthydt
         8F31560mEXWiTejwFJf8EUvQLdjgB+1FnRHn0vJGtjjIYj44g3Gsnfsvnrpk5LjgDKwr
         7DIxrvbCJgLn65cJL+0/alYB01WOBsK273id2fSOEFFJZ8aOdr1BBlL/3sRtOvbI5UCj
         VDc/aExVWtwDBurvOfDBdUXSJovczRdXq0GxGb5tgJqN8AuVbaCDL/IbTzn6BCD5lxpN
         bD4g==
X-Gm-Message-State: AOAM531LWLPhVKPa94sYBsIR5L1NXZF3XYr7CEu8dF7/721WA0CHYLuw
        /yX+qZhOkW1LgcpNuFoEWn7WlB+al1C0mV31amJ0yg==
X-Google-Smtp-Source: ABdhPJwSBXVg5r4lXf0UPgteTHOtKkgMMc0ONYCVefyPwWvqtqwkzI7TdHZDQ1HSs7qs5ycatnjoZtDgdYx9397f/pM=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr723367ljo.74.1603934760698;
 Wed, 28 Oct 2020 18:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook> <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
 <202010281548.CCA92731F@keescook>
In-Reply-To: <202010281548.CCA92731F@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:25:34 +0100
Message-ID: <CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Kees Cook <keescook@chromium.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
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

On Wed, Oct 28, 2020 at 11:53 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 26, 2020 at 10:51:02AM +0100, Jann Horn wrote:
> > The problem is the scenario where a process is interrupted while it's
> > waiting for the supervisor to reply.
> >
> > Consider the following scenario (with supervisor "S" and target "T"; S
> > wants to wait for events on two file descriptors seccomp_fd and
> > other_fd):
> >
> > S: starts poll() to wait for events on seccomp_fd and other_fd
> > T: performs a syscall that's filtered with RET_USER_NOTIF
> > S: poll() returns and signals readiness of seccomp_fd
> > T: receives signal SIGUSR1
> > T: syscall aborts, enters signal handler
> > T: signal handler blocks on unfiltered syscall (e.g. write())
> > S: starts SECCOMP_IOCTL_NOTIF_RECV
> > S: blocks because no syscalls are pending
>
> Oooh, yes, ew. Thanks for the illustration.
>
> Thinking about this from userspace's least-surprise view, I would expect
> the "recv" to stay "queued", in the sense we'd see this:
>
> S: starts poll() to wait for events on seccomp_fd and other_fd
> T: performs a syscall that's filtered with RET_USER_NOTIF
> S: poll() returns and signals readiness of seccomp_fd
> T: receives signal SIGUSR1
> T: syscall aborts, enters signal handler
> T: signal handler blocks on unfiltered syscall (e.g. write())
> S: starts SECCOMP_IOCTL_NOTIF_RECV
> S: gets (stale) seccomp_notif from seccomp_fd
> S: sends seccomp_notif_resp, receives ENOENT (or some better errno?)
>
> This is not at all how things are designed internally right now, but
> that behavior would work, yes?

It would be really ugly, but it could theoretically be made to work,
to some degree.


The first bit of trouble is that currently the notification lives on
the stack of the target process. If we want to be able to show
userspace the stale notification, we'd have to store it elsewhere. And
since we really don't want to start randomly throwing -ENOMEM in any
of this stuff, we'd basically have to store it in pre-allocated memory
inside the filter.


The second bit of trouble is that if the supervisor is so oblivious
that it doesn't realize that syscalls can be interrupted, it'll run
into other problems. Let's say the target process does something like
this:

int func(void) {
  char pathbuf[4096];
  sprintf(pathbuf, "/tmp/blah.%d", some_number);
  mount("foo", pathbuf, ...);
}

and mount() is handled with a notification. If the supervisor just
reads the path string and immediately passes it into the real mount()
syscall, something like this can happen:

target: starts mount()
target: receives signal, aborts mount()
target: runs signal handler, returns from signal handler
target: returns out of func()
supervisor: receives notification
supervisor: reads path from remote buffer
supervisor: calls mount()

but because the stack allocation has already been freed by the time
the supervisor reads it, the supervisor just reads random garbage, and
beautiful fireworks ensue.

So the supervisor *fundamentally* has to be written to expect that at
*any* time, the target can abandon a syscall. And every read of remote
memory has to be separated from uses of that remote memory by a
notification ID recheck.

And at that point, I think it's reasonable to expect the supervisor to
also be able to handle that a syscall can be aborted before the
notification is delivered.
