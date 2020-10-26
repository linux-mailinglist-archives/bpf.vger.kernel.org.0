Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52013298A6E
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769869AbgJZKbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 06:31:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33289 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769866AbgJZKbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 06:31:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id l2so11073634lfk.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7HAHmiYh1s6lN4nRq33Z2NFlYANdAjAZHYUwYnpGrSI=;
        b=BuyO+kGChRJ1csFxxBKVeQTgKNwDgqEmjnFCPSmQkVEKWO5lnvrAtD+BM9uHThSSf5
         0iS0M8haTyprzZvG7XUTucFA4nVHpMccNoeEcZJpSpV2JJmJcTwymneHjwpiMLyG8Ws/
         Tt97XdiulcW7Cb8DwTerKvp6XjmjhBqa7N56WUgdiGgMDJvxN16I1sUYFElVLKphHpRo
         NW8wFJ9Jbw/vB853kGWH2sRX/mxDBCl763HERqniTYJv+n71/gwT6uTgNL8ywBx+CxW4
         G+zSWJc7ZL/02SRLfGa/JyMtSzYgMnhmoktVV0pS/Z7uoggnXtAPh0hqywYKbO7NtI//
         QOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7HAHmiYh1s6lN4nRq33Z2NFlYANdAjAZHYUwYnpGrSI=;
        b=RCKn+V81l0+8eLPx5UgIyrygaI97PqNHjyQDxOWvKHgjnaMq2oexFyijbBFU0sZ27C
         OdmDjVac+1VK4RzsVCcsuixgCff5hfLXVG/h6Zg8pBIEJUzA1w6Di1iRQ6SiKdIbYGCj
         uDlmQXGSk4NW/evzIw1vnaXSQRakyF3MfJ1JANsqdjdaE7hGAns/UotDhbI2TtVrCewm
         HhTuahxoGNxlWWuDyM6oVoG4XPjsoS3gh/YKw1xOTN6ncspsrcRDKuGeQId8vyj99qyx
         kT5I/F1KRXpsXfZRgzQ5NH735hT0sC0yhaLrdXgKCOBJSTOCz9d0pnhrqYvM/4s3Q4DT
         dfIg==
X-Gm-Message-State: AOAM532zMEbBMgXPuaUPGHj2nXYoxoiUrX9mlx37FwFcu4JUY+hCWBiU
        ub7JzOoph6vba8oDAyj0nsEW5zMSBxJDSReNGOig9w==
X-Google-Smtp-Source: ABdhPJwhyMQilM9FU2cG9Ph4E9v0bbJUqbwFPAqmd1uHa041X8EAhpAghLBydXtVyyYA4w/+ZDVI4zl2X89K8o2czrw=
X-Received: by 2002:a05:6512:52f:: with SMTP id o15mr4371434lfc.381.1603708288674;
 Mon, 26 Oct 2020 03:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook> <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
In-Reply-To: <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 26 Oct 2020 11:31:01 +0100
Message-ID: <CAG48ez2OWhpH3HHUJSrAmokJ8=SVwKrmQMSw0gEbTJmKE4myCw@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 10:51 AM Jann Horn <jannh@google.com> wrote:
> On Mon, Oct 26, 2020 at 1:32 AM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Oct 01, 2020 at 03:52:02AM +0200, Jann Horn wrote:
> > > On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wro=
te:
> > > > On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> > > > > On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza>=
 wrote:
> > > > > > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-=
pages) wrote:
> > > > > > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > > > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (=
man-pages) wrote:
> > > > > > > >>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > > > > > > >>        =E2=94=82FIXME                                     =
           =E2=94=82
> > > > > > > >>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > > > > > > >>        =E2=94=82From my experiments,  it  appears  that  i=
f  a  SEC=E2=80=90 =E2=94=82
> > > > > > > >>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  t=
he  target =E2=94=82
> > > > > > > >>        =E2=94=82process terminates, then the ioctl()  simp=
ly  blocks =E2=94=82
> > > > > > > >>        =E2=94=82(rather than returning an error to indicat=
e that the =E2=94=82
> > > > > > > >>        =E2=94=82target process no longer exists).         =
           =E2=94=82
> > > > > > > >
> > > > > > > > Yeah, I think Christian wanted to fix this at some point,
> > > > > > >
> > > > > > > Do you have a pointer that discussion? I could not find it wi=
th a
> > > > > > > quick search.
> > > > > > >
> > > > > > > > but it's a
> > > > > > > > bit sticky to do.
> > > > > > >
> > > > > > > Can you say a few words about the nature of the problem?
> > > > > >
> > > > > > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("s=
eccomp:
> > > > > > notify about unused filter"). So maybe there's a bug here?
> > > > >
> > > > > That thing only notifies on ->poll, it doesn't unblock ioctls; an=
d
> > > > > Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So t=
hat
> > > > > commit doesn't have any effect on this kind of usage.
> > > >
> > > > Yes, thanks. And the ones stuck in RECV are waiting on a semaphore =
so
> > > > we don't have a count of all of them, unfortunately.
> > > >
> > > > We could maybe look inside the wait_list, but that will probably ma=
ke
> > > > people angry :)
> > >
> > > The easiest way would probably be to open-code the semaphore-ish part=
,
> > > and let the semaphore and poll share the waitqueue. The current code
> > > kind of mirrors the semaphore's waitqueue in the wqh - open-coding th=
e
> > > entire semaphore would IMO be cleaner than that. And it's not like
> > > semaphore semantics are even a good fit for this code anyway.
> > >
> > > Let's see... if we didn't have the existing UAPI to worry about, I'd
> > > do it as follows (*completely* untested). That way, the ioctl would
> > > block exactly until either there actually is a request to deliver or
> > > there are no more users of the filter. The problem is that if we just
> > > apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
> > > an event loop and don't set O_NONBLOCK will be screwed. So we'd
> >
> > Wait, why? Do you mean a ioctl calling loop (rather than a poll event
> > loop)?
>
> No, I'm talking about poll event loops.
>
> > I think poll would be fine, but a "try calling RECV and expect to
> > return ENOENT" loop would change. But I don't think anyone would do thi=
s
> > exactly because it _currently_ acts like O_NONBLOCK, yes?
> >
> > > probably also have to add some stupid counter in place of the
> > > semaphore's counter that we can use to preserve the old behavior of
> > > returning -ENOENT once for each cancelled request. :(
> >
> > I only see this in Debian Code Search:
> > https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/seccomp_not=
ify.c/?hl=3D166#L166
> > which is using epoll_wait():
> > https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/container.c=
/?hl=3D1326#L1326
> >
> > I expect LXC is using it. :)
>
> The problem is the scenario where a process is interrupted while it's
> waiting for the supervisor to reply.
>
> Consider the following scenario (with supervisor "S" and target "T"; S
> wants to wait for events on two file descriptors seccomp_fd and
> other_fd):
>
> S: starts poll() to wait for events on seccomp_fd and other_fd
> T: performs a syscall that's filtered with RET_USER_NOTIF
> S: poll() returns and signals readiness of seccomp_fd
> T: receives signal SIGUSR1
> T: syscall aborts, enters signal handler
> T: signal handler blocks on unfiltered syscall (e.g. write())
> S: starts SECCOMP_IOCTL_NOTIF_RECV
> S: blocks because no syscalls are pending
>
> Depending on what other_fd is, this could in a worst case even lead to
> a deadlock (if e.g. the signal handler wants to write to stdout, but
> the stdout fd is hooked up to other_fd in the supervisor, but the
> supervisor can't consume the data written because it's stuck in
> seccomp handling).
>
> So we have to ensure that when existing code (like that crun code you
> linked to) triggers this case, SECCOMP_IOCTL_NOTIF_RECV returns
> immediately instead of blocking.

Or I guess we could also just set O_NONBLOCK on the fd by default?
Since the one existing user is eventloop-based...
