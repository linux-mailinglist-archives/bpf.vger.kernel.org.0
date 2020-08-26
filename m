Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0D253002
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgHZNdm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgHZNcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 09:32:52 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C4C061574
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 06:32:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o8so1463818otp.9
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5F+2w87Sbp2VsotmXV5vUFXgjfrQVUBvp+rVCM8n0VY=;
        b=eFKX8T9RJmmHhdTKTHsiI68LcCMStS/JbEHbLgoQ8EtrtTLva6mj1tliPNOeL2+q+L
         jAo54hMXV4LGJ5kY89yUB4Nyj4T/6PLYhB0t8/vwlUJbx3yR9MAEe/EktD0z1iy1sAia
         VJG1eR6uu5E80SNKPyV+RvrUAm+pV3IegNvvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5F+2w87Sbp2VsotmXV5vUFXgjfrQVUBvp+rVCM8n0VY=;
        b=hi20f97lb/asGI5sCrRK9y4sGCqqH6FoYEvKVqlHBXJTxepcCtTKs05bYO86SQOzdt
         fac/lvDDX/khEKzfKDYTO6UfdJ3e9qoZdPHnpSq213NtPtn0HxFC7qljM1MUi/cxnHhg
         5qqrIyc/ZmTPr5edCapfrOeqibxXR7xD+W9VKV0GF2qed5AaHtIcIff1rprmKzFKDV6t
         rgNkY9YPrQM6a9vE3RcJLr88lU5VEq6pfKwW8ErgoorFKhlbBHmHQENPfUds1aeGO2JV
         XosAZX3yzstpseGsr59ktvSDYEWNPw8SwOdB16cGcBFRR6OTfDc9L3Z3wzzuEjwEtTeB
         1x6A==
X-Gm-Message-State: AOAM533pL+7diBAnxu/qoX7anmn+P23pfx6wkdykvDGs0FnW5nnmC/SB
        xq4gOjXThOBCotj11RW0ChanIXm+UtqcEWonPUOxKcM07ZM=
X-Google-Smtp-Source: ABdhPJyP/b3gl3fiBZNoHqTqUg1sxxrZo1UN6xgaZ06i5/+u4SVbhnQgig0NEIFCnmleLkN114qOfd1OVz/fJcNXA/0=
X-Received: by 2002:a9d:618d:: with SMTP id g13mr289776otk.147.1598448769879;
 Wed, 26 Aug 2020 06:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
 <CAADnVQLji8CMCVoefHPqc457Fz1xZ+yEnogHXpghhx6=GPYTbg@mail.gmail.com>
 <CACAyw988=DLoXJ6dC4qkTCWgQu2M19fVTAhjnF5Hg2Oe=mkmOw@mail.gmail.com> <87zh6hwyl2.fsf@toke.dk>
In-Reply-To: <87zh6hwyl2.fsf@toke.dk>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Aug 2020 14:32:38 +0100
Message-ID: <CACAyw99j3cEQPvg29U7o0CaQvgBJxcet9NcC3JMjZoXABLUOZw@mail.gmail.com>
Subject: Re: Advisory file locking behaviour of bpf_link (and others?)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 Aug 2020 at 10:22, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>
> Lorenz Bauer <lmb@cloudflare.com> writes:
>
> > On Tue, 25 Aug 2020 at 19:06, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Aug 25, 2020 at 6:39 AM Lorenz Bauer <lmb@cloudflare.com> wrot=
e:
> >> >
> >> > Hi,
> >> >
> >> > I was playing around a bit, and noticed that trying to acquire an
> >> > exclusive POSIX record lock on a bpf_link fd fails. I've traced this
> >> > to the call to anon_inode_getfile from bpf_link_prime which
> >> > effectively specifies O_RDONLY on the bpf_link struct file. This mak=
es
> >> > check_fmode_for_setlk return EBADF.
> >> >
> >> > This means the following:
> >> > * flock(link, LOCK_EX): works
> >> > * fcntl(link, SETLK, F_RDLCK): works
> >> > * fcntl(link, SETLK, F_WRLCK): doesn't work
> >> >
> >> > Especially the discrepancy between flock(EX) and fcntl(WRLCK) has me
> >> > puzzled. Should fcntl(WRLCK) work on a link?
> >> >
> >> > program fds are always O_RDWR as far as I can tell (so all locks
> >> > work), while maps depend on map_flags.
> >>
> >> Because for links fd/file flags are reserved for the future use.
> >> progs are rdwr for historical reasons while maps can have three combin=
ations:
> >> /* Flags for accessing BPF object from syscall side. */
> >>         BPF_F_RDONLY            =3D (1U << 3),
> >>         BPF_F_WRONLY            =3D (1U << 4),
> >> by default they are rdwr.
> >> What is your use case to use flock on bpf_link fd?
> >
> > The idea is to prevent concurrent access / modification of pinned maps
> > + pinned link from a command line tool. I could just as well lock one
> > of the maps for this, but conceptually the link is the thing that
> > actually controls what maps are used via the attached BPF program.
> > FWIW I'm using flock(EX) on the link for now, which is fine for my use
> > case. I just thought I'd raise this in case it was an oversight :)
>
> FWIW I'm doing something similar in libxdp, except I'm using flock(EX)
> on the parent directory (i.e., /sys/fs/bpf/xdp) since I need to protect
> multiple modifications inside it:

Thank you for the suggestion, that is indeed much nicer! Now why did I
bother with fcntl in the first place? :)

Best

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
