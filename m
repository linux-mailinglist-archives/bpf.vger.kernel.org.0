Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2624298A06
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768334AbgJZJvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 05:51:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44440 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1737068AbgJZJve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 05:51:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id a5so9036398ljj.11
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvHwOhMOSComXSdb9JzaD65zvZyc8ZwqG/MT8SEmCr8=;
        b=XQtZGUAHkXcAtHyAFMQ1vUo2SRdyz1VTbCBYc3OxQqPVEDxUROYbSDuXYTV+wPwvOs
         bo6Whtw0w3Gch8zWAmLP2t9kbJxBFNr6Mi5f+xVH3J1ZAVGWhx0VWR2avbCuyOshfRO0
         DWEXO8kzycOpjVtgfOBpaH+M5qb1mNKM5AJxU5TnoJPyU4x6nZfHSebAOZd3yCQV6g+8
         oUjYGls24BaLCdidNGO5roRQAtdFSRSSyxhFr4rA8QHpe/nTUDkeMHDT527K8vAMYO/w
         D3HWTTv7P6xwQKqO0U0SMYcZ/IboJdZHtFdbG8SQYIsx+ANP0tj6ZvjWn9VO557znNi2
         x6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvHwOhMOSComXSdb9JzaD65zvZyc8ZwqG/MT8SEmCr8=;
        b=dv+PFbuOVUAd5NK2iCDMv8XrBX6SY9JMcoY6hQpfJqIcEF5IBoYtl375411PbH0mfx
         x8+MX8kjaTdnukLXtS9PlrRcnaU35lv8J2aXjiPJQrpI0RsggBerHGozZdTahF4zqO7S
         /2XCEopUaRz250ONaEooreCJO30W3EapTs/VVgio/X324mB20l7dY6lD3V20/rqBrwVL
         QdU9XXVcq3uCU0fpcYxLicqgEqnHVQbGNVzqBXlULUZfCTEVPfMjK9SL+8LLS4n4hwig
         2sPlozdtapWo9nByn+7KdrrPOriHihyse6+6bCdfhOAobu7pQPZbkDgLhTwMEUJYOMFh
         Qiyw==
X-Gm-Message-State: AOAM5300UkqhAzMoTKL5LICkrDd+LJvF54IfUSzzgFqvfyxxsz6VTO/R
        AgXfadiNS8In5S5D1/fgNmb8TGBJ0u6Z87c4arFEaQ==
X-Google-Smtp-Source: ABdhPJy3fjEBGpGIryQc4Y6LVPm/reRxy/Wkv+7lUQ8mQvLHz9l8MltT/z36Blg+feaWzbgimjmcpy0nt4YNvjefuK0=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr5255189ljk.160.1603705889194;
 Mon, 26 Oct 2020 02:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook>
In-Reply-To: <202010251725.2BD96926E3@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 26 Oct 2020 10:51:02 +0100
Message-ID: <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 1:32 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Oct 01, 2020 at 03:52:02AM +0200, Jann Horn wrote:
> > On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrote=
:
> > > On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> > > > On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> w=
rote:
> > > > > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pa=
ges) wrote:
> > > > > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (ma=
n-pages) wrote:
> > > > > > >>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > > > > > >>        =E2=94=82FIXME                                       =
         =E2=94=82
> > > > > > >>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > > > > > >>        =E2=94=82From my experiments,  it  appears  that  if =
 a  SEC=E2=80=90 =E2=94=82
> > > > > > >>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  the=
  target =E2=94=82
> > > > > > >>        =E2=94=82process terminates, then the ioctl()  simply=
  blocks =E2=94=82
> > > > > > >>        =E2=94=82(rather than returning an error to indicate =
that the =E2=94=82
> > > > > > >>        =E2=94=82target process no longer exists).           =
         =E2=94=82
> > > > > > >
> > > > > > > Yeah, I think Christian wanted to fix this at some point,
> > > > > >
> > > > > > Do you have a pointer that discussion? I could not find it with=
 a
> > > > > > quick search.
> > > > > >
> > > > > > > but it's a
> > > > > > > bit sticky to do.
> > > > > >
> > > > > > Can you say a few words about the nature of the problem?
> > > > >
> > > > > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("sec=
comp:
> > > > > notify about unused filter"). So maybe there's a bug here?
> > > >
> > > > That thing only notifies on ->poll, it doesn't unblock ioctls; and
> > > > Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So tha=
t
> > > > commit doesn't have any effect on this kind of usage.
> > >
> > > Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
> > > we don't have a count of all of them, unfortunately.
> > >
> > > We could maybe look inside the wait_list, but that will probably make
> > > people angry :)
> >
> > The easiest way would probably be to open-code the semaphore-ish part,
> > and let the semaphore and poll share the waitqueue. The current code
> > kind of mirrors the semaphore's waitqueue in the wqh - open-coding the
> > entire semaphore would IMO be cleaner than that. And it's not like
> > semaphore semantics are even a good fit for this code anyway.
> >
> > Let's see... if we didn't have the existing UAPI to worry about, I'd
> > do it as follows (*completely* untested). That way, the ioctl would
> > block exactly until either there actually is a request to deliver or
> > there are no more users of the filter. The problem is that if we just
> > apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
> > an event loop and don't set O_NONBLOCK will be screwed. So we'd
>
> Wait, why? Do you mean a ioctl calling loop (rather than a poll event
> loop)?

No, I'm talking about poll event loops.

> I think poll would be fine, but a "try calling RECV and expect to
> return ENOENT" loop would change. But I don't think anyone would do this
> exactly because it _currently_ acts like O_NONBLOCK, yes?
>
> > probably also have to add some stupid counter in place of the
> > semaphore's counter that we can use to preserve the old behavior of
> > returning -ENOENT once for each cancelled request. :(
>
> I only see this in Debian Code Search:
> https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/seccomp_notif=
y.c/?hl=3D166#L166
> which is using epoll_wait():
> https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/container.c/?=
hl=3D1326#L1326
>
> I expect LXC is using it. :)

The problem is the scenario where a process is interrupted while it's
waiting for the supervisor to reply.

Consider the following scenario (with supervisor "S" and target "T"; S
wants to wait for events on two file descriptors seccomp_fd and
other_fd):

S: starts poll() to wait for events on seccomp_fd and other_fd
T: performs a syscall that's filtered with RET_USER_NOTIF
S: poll() returns and signals readiness of seccomp_fd
T: receives signal SIGUSR1
T: syscall aborts, enters signal handler
T: signal handler blocks on unfiltered syscall (e.g. write())
S: starts SECCOMP_IOCTL_NOTIF_RECV
S: blocks because no syscalls are pending

Depending on what other_fd is, this could in a worst case even lead to
a deadlock (if e.g. the signal handler wants to write to stdout, but
the stdout fd is hooked up to other_fd in the supervisor, but the
supervisor can't consume the data written because it's stuck in
seccomp handling).

So we have to ensure that when existing code (like that crun code you
linked to) triggers this case, SECCOMP_IOCTL_NOTIF_RECV returns
immediately instead of blocking.

(Oh, but by the way, that crun code looks broken anyway, because
AFAICS it treats all error returns from SECCOMP_IOCTL_NOTIF_RECV
equally by bailing out; and it kinda looks like that bailout path then
nukes the container, or something? So that needs to be fixed either
way.)
