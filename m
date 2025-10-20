Return-Path: <bpf+bounces-71440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E85BF33F1
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5B444FC4C7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F427AC31;
	Mon, 20 Oct 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LghXKkMz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454119E99F
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989237; cv=none; b=nr0x1e/ledmHyB0j9xCwVbyx8PaSlb+96Wkq4TxtoUHLCRItKGqS9EMsRjWSxHiCc/C1H50fXctIe8PE6AyMlqDGVIQaxQodbVSbKGWQJhBNH6eWJMu6bSBXcYzGjJEYhaQYtUtO0AW7yeIM+ebRidiYO4HJ/xoTWA3tgPT4ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989237; c=relaxed/simple;
	bh=mNxMi2e3EZP50dgnVQKiVX/stu9CdgVnthu3QTuqFnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tV76AmOtK8/9C+1JfF1MTo2Oo+hQ0vuxBXlGMOMoy8dVn2H/2QvNMUSZBEfkzf0PywUNDX/GtDSCIaty4AgdaBWmnUyiPm0yZHWUg1AC2avn1Ui2khxqdVV7R22bx+PUsoH5cUXz8CgHGZC4rssaV4NCR1z13LmH8xPXP8lAX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LghXKkMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C733CC16AAE
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760989236;
	bh=mNxMi2e3EZP50dgnVQKiVX/stu9CdgVnthu3QTuqFnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LghXKkMzCQAGnQo19DtJEa8AH4EBc4TjTu5supCPuUnt8cNOTzzR2+SUpM3j9Ctna
	 5Q73aXJ9mWVHYBLIWMahjZrY1xH8qXApnWLEoikM6ckCPJAuZjkXy25dUhDczMijdP
	 HwKXyDZj+bfrRZp5OHtmvm8qfEg4Ut0rsdQHyx/RsqKu0lO02TbcIYlr/Hc+Ueeq0K
	 YgWsODptpPViIpMixSIvmAd1NTXHXldeRIvBGGW2Y3Wf13+ArVxo01auXQoPNQiyJ+
	 doXqWZC9NWiTIyFR1zCG9qvXDH/4KbS+/PVJW0wOlkE7jkT9jDaLk8l9WPy/FDAPxp
	 t33q0WGDGSlcg==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78ed682e9d3so65220816d6.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 12:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7sWie5tkTA972ZoYmOvH1EVaebpju0b9ePi9T0/5xUuf2wbygbmph0yPy9ZHcEKD1Oyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vc6POCydkA1Wu86oX2mXB8JNAHXJJgBM/+MtkMbozgQQx1lc
	acd8eDfSK83EwVnhXg0kNJbXKbuqwaLj1wM3TMoUPDhRu+2FxaNcHJ2sTfechQwHdB5bIA93I7v
	YZ2eM49t7jQWcb8Ig/Bi7ZFCeazPDEeY=
X-Google-Smtp-Source: AGHT+IG3NeTBx7Prf/3sXQ6ixXSndWKdVl4o5sV0g2ylxymqwUWvbp+jw339EBlNsmvM/Y8QTxtG0vv2xCwBWR8xDdU=
X-Received: by 2002:ad4:5d61:0:b0:87c:2847:f7c4 with SMTP id
 6a1803df08f44-87c2847f8bamr153330996d6.23.1760989235949; Mon, 20 Oct 2025
 12:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
In-Reply-To: <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Mon, 20 Oct 2025 12:40:23 -0700
X-Gmail-Original-Message-ID: <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
X-Gm-Features: AS18NWCarXtoDKhgef621_pUFzzZSTOA--qmg9kt4Gj0KAYzdZvyF9I7MESdw4o
Message-ID: <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
To: Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, v9fs@lists.linux.dev, 
	Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:40=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
>
> Hi Song,
>
> On 10/20/25 18:40, Song Liu wrote:
> > Hi,
> >
> > I noticed a new error in the upstream kernel when I run bpftrace with
> > vmtest [2]:
> >
> > $ vmtest -k arch/x86/boot/bzImage "bpftrace.real -e
> > 'fexit:cmdline_proc_show {exit();}'"
> > =3D> bzImage
> > =3D=3D=3D> Booting
> > =3D=3D=3D> Setting up VM
> > =3D=3D=3D> Running command
> > [    5.610741] id (178) used greatest stack depth: 11592 bytes left
> > Parse error: Input/output error
> > Command failed with exit code: 2
> > [root@(none) /]#
> >
> > git bisect points to patch 1/3 of this set [1].
> >
> > Any idea what is happening here?
>
> I have attempted to reproduce this but couldn't yet:
>
>         > git log --format=3Dshort -1
>         commit 211ddde0823f1442e4ad052a2f30f050145ccada (HEAD, tag: v6.18=
-rc2, origin/master, origin/HEAD)
>         Author: Linus Torvalds <torvalds@linux-foundation.org>
>
>             Linux 6.18-rc2
>         (0.067s) linux-devbox-2 (mao; ; ?) ~/9pfs
>         > vmtest -k arch/x86/boot/bzImage "bpftrace -e 'fexit:cmdline_pro=
c_show {exit();}'"
>         =3D> bzImage
>         =3D=3D=3D> Booting
>         =3D=3D=3D> Setting up VM
>         =3D=3D=3D> Running command
>         Attached 1 probe
>         ^C=E2=8F=8E
>          (130) (14.421s) linux-devbox-2 (mao; ; ?) ~/9pfs
>         > vmtest -k arch/x86/boot/bzImage "(sleep 2; cat /proc/cmdline) &=
 bpftrace -e 'fexit:cmdline_proc_show {exit();}'"
>         =3D> bzImage
>         =3D=3D=3D> Booting
>         =3D=3D=3D> Setting up VM
>         =3D=3D=3D> Running command
>         Attached 1 probe
>         rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,cache=3Dmmap,msize=3D1=
048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=3Don console=3D0,115=
200 loglevel=3D7 ra...
>
>         (5.29s) linux-devbox-2 (mao; ; ?) ~/9pfs
>         > qemu-system-x86_64 -version
>         QEMU emulator version 10.1.1
>         Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project deve=
lopers
>         (0.011s) linux-devbox-2 (mao; ; ?) ~/9pfs
>         > bpftrace --version
>         bpftrace v0.24.1
>
> I'm happy to take a further look - is there anything special about your
> setup, what version of QEMU / bpftrace are you running?

I am running qemu 9.2.0 and bpftrace v0.24.0. I don't think anything is
very special here.

Thanks,
Song

