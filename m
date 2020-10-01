Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7028031D
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgJAPsW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 11:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbgJAPsW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 11:48:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA2C0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 08:48:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so8778993ejb.8
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8IFUkJPw/kRc69ZxpOZH7IdKr2uNB4GcMACMPjhB0mM=;
        b=sY7GNFIvYaNfMnuHljMi/SlQZ6n4BcGZhCTAkvb73jwrTAP++F0FA96srmG4n+saym
         LPs0Qo1rf+Gc/KbMjrfFVvv0dVBlQo5xErKWSXr8vfIbgudw/fJB81Prkbi9Pii7XtRh
         bwufKgriflGSXWbjmbN1+qvivFzU+VKLk390fTxTMNBo7z+CsZ1XFTp/HjN3R699Gw+C
         vfciTTmpKgNNA11LmOMtAz8ZR9nakBZvoaMyZp8Hz1UVlkM5vLsghRNGZtT0pDQ9PVkF
         +xdKQnhRbsvPbhl29QQtDseBMWcFAJ8tpq31IZJtch0aWdpaPLCLP06UMF/rwp7udtiZ
         WVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8IFUkJPw/kRc69ZxpOZH7IdKr2uNB4GcMACMPjhB0mM=;
        b=nZARQwjRUenmvxzhW7hsJvZ/xN9xB/UBbNpio0dVx8+zVD9z2hl5c43IoZuszzruC2
         sO+MBiLBv30jXcGgBhpf2xS1jHIZ2jt0ISaEfP3+vGgeQbU1WK0UXVPLRhyGMsBIHxU0
         wCCUIJ/6xyEeiQ6zR2TQKB2QJufNeTP3w+REyLXssrW+0mL3t6Ef0TH6qTpDxMAjV5XI
         DUuxxPe3ZNauGU0dNo7lQ4te2JqwFYsB+lJVtF4jer/arAUR1UMY7zDPF7kkj00SjnGF
         kqcAbDNIDqqb+Rj9cqbzpaUrxx+4z338WYipWiYPd7FrFLyAR78urOsGP3O7CtSCaduW
         66cw==
X-Gm-Message-State: AOAM530Lrwd/7VAzYkf+23jZXpX00h8xrQDrH0YTtoQlGkZaCEcQ3P+q
        j6VaGx8P9unPrzQmU10Hk9d6did7v/T+ZotIMW1Yiw==
X-Google-Smtp-Source: ABdhPJzN5UXlteDmV4gmQvsi+vrDa7wXLtdd0FT669/Cj8yL3OSvmpnW8FNcV9j4cLbSCSgCO88bO4oWC48rzvXf8wo=
X-Received: by 2002:a17:906:1f94:: with SMTP id t20mr8931066ejr.493.1601567300584;
 Thu, 01 Oct 2020 08:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com> <20201001125043.dj6taeieatpw3a4w@gmail.com>
In-Reply-To: <20201001125043.dj6taeieatpw3a4w@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 17:47:54 +0200
Message-ID: <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
<christian.brauner@canonical.com> wrote:
> On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wrote:
> > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > > NOTES
> > >        The file descriptor returned when seccomp(2) is employed with =
the
> > >        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  us=
ing
> > >        poll(2), epoll(7), and select(2).  When a notification  is  pe=
nd=E2=80=90
> > >        ing,  these interfaces indicate that the file descriptor is re=
ad=E2=80=90
> > >        able.
> >
> > We should probably also point out somewhere that, as
> > include/uapi/linux/seccomp.h says:
> >
> >  * Similar precautions should be applied when stacking SECCOMP_RET_USER=
_NOTIF
> >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on t=
he
> >  * same syscall, the most recently added filter takes precedence. This =
means
> >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing =
all
> >  * such filtered syscalls to be executed by sending the response
> >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can eq=
ually
> >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> >
> > In other words, from a security perspective, you must assume that the
> > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > calling seccomp(). This should also be noted over in the main
> > seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
>
> So I was actually wondering about this when I skimmed this and a while
> ago but forgot about this again... Afaict, you can only ever load a
> single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
> already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER property
> in the tasks filter hierarchy then the kernel will refuse to load a new
> one?
>
> static struct file *init_listener(struct seccomp_filter *filter)
> {
>         struct file *ret =3D ERR_PTR(-EBUSY);
>         struct seccomp_filter *cur;
>
>         for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
>                 if (cur->notif)
>                         goto out;
>         }
>
> shouldn't that be sufficient to guarantee that USER_NOTIF filters can't
> override each other for the same task simply because there can only ever
> be a single one?

Good point. Exceeeept that that check seems ineffective because this
happens before we take the locks that guard against TSYNC, and also
before we decide to which existing filter we want to chain the new
filter. So if two threads race with TSYNC, I think they'll be able to
chain two filters with listeners together.

I don't know whether we want to eternalize this "only one listener
across all the filters" restriction in the manpage though, or whether
the man page should just say that the kernel currently doesn't support
it but that security-wise you should assume that it might at some
point.

[...]
> > >            if (procMemFd =3D=3D -1)
> > >                errExit("Supervisor: open");
> > >
> > >            /* Check that the process whose info we are accessing is s=
till alive.
> > >               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performe=
d
> > >               in checkNotificationIdIsValid()) succeeds, we know that=
 the
> > >               /proc/PID/mem file descriptor that we opened correspond=
s to the
> > >               process for which we received a notification. If that p=
rocess
> > >               subsequently terminates, then read() on that file descr=
iptor
> > >               will return 0 (EOF). */
> > >
> > >            checkNotificationIdIsValid(notifyFd, req->id);
> > >
> > >            /* Seek to the location containing the pathname argument (=
i.e., the
> > >               first argument) of the mkdir(2) call and read that path=
name */
> > >
> > >            if (lseek(procMemFd, req->data.args[0], SEEK_SET) =3D=3D -=
1)
> > >                errExit("Supervisor: lseek");
> > >
> > >            ssize_t s =3D read(procMemFd, path, PATH_MAX);
> > >            if (s =3D=3D -1)
> > >                errExit("read");
> >
> > Why not pread() instead of lseek()+read()?
>
> With multiple arguments to be read process_vm_readv() should also be
> considered.

process_vm_readv() can end up doing each read against a different
process, which is sort of weird semantically. You would end up taking
page faults at random addresses in unrelated processes, blocking on
their mmap locks, potentially triggering their userfaultfd notifiers,
and so on.

Whereas if you first open /proc/$tid/mem, then re-check
SECCOMP_IOCTL_NOTIF_ID_VALID, and then do the read, you know that
you're only taking page faults on the process where you intended to do
it.

So until there is a variant of process_vm_readv() that operates on
pidfds, I would not recommend using that here.
