Return-Path: <bpf+bounces-71490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86990BF4BD2
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 08:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29283402611
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA3267AF2;
	Tue, 21 Oct 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiUMHWzN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C92609FC
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029376; cv=none; b=a31jtgdAx3SeoXxLwxDH2/h2qF9QpD9n5+LQ0Vvaz4Ir9ql+hQst58LK0vAy6cfqE5L8op2a+uRp/QmFDz4/FZSoUzyzH607dLA0wN6A6vLIGBGMm1/wo58N7K4U3HG3DxH9mMpOMW4KsOY2r1s2CF7ncoY2gMNqnyPFNf3/QdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029376; c=relaxed/simple;
	bh=xcZQIxmt0q7uT+5+6SfYbseOeX41s5MWzi0BsL+y1F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpnLFOzDshOjKvCreQQWb+5PpqtgZA1J52wgFnkuqIQlllBHR4QqzbWDrZdlx59U1EsSqRFOQiK1nSvt88YkS4DB3bBFnnt+c7cmRYMgguiQijb8tboRGzoptGfDtFNv5eaGXWrWezfm8oIY/DjNLhX3NvtsVnHQBRaO9v2kk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiUMHWzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D2BC4CEFD
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761029376;
	bh=xcZQIxmt0q7uT+5+6SfYbseOeX41s5MWzi0BsL+y1F4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IiUMHWzNDo9RDYzli32AYondrfwO7KVoRqvfd5MNVoQfpQlbEcG0aTes41/L4J7S0
	 7CRM7afpGe3h38qqe6qGiPdx1x+MREpHDLiKOri4SU+/68jDoDRVmLEIVpZZ9VASMF
	 zhoxfkzqpJmKUvOwHhjmF0TtN9S70SPXLv4eHGfAE0Y6+djurVkZGIWTOu9bXV9qgK
	 NgPzCAXa+pIQSpQ82gBqUB6uEYX9vrHP93ef2Z2WXXtu0bV9uIYqGBHm51Fn5zHDhO
	 dKXBteK3C/fKsAVuoyX8KOKLTkLo4tCgELGJB5YmDVMQKZP/sYX1dcVKnfxYv2m95Y
	 ys7AW36WwyRtw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87bb66dd224so72374336d6.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 23:49:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdS/XutJeP8DxT6QwDa+C6+0sspbbiTGRQKyC34JUal73sQ9udDTgQFJUpbQgimqOH0lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/MPk5HJaUCvoEH9vZ02yFg1CPEdZWoAt9UcoSeYrvXr8LFVN
	j3vgMVJU6G5BGpGlgUWmKehtYixRYymHqBR+WNnUFa0Sr54THsZZ/OHM1Oh1/wekVqgj/BphA3a
	SrjYLghLfmYllTVUS1OW/6OCAyzwgZ9U=
X-Google-Smtp-Source: AGHT+IHouf+2WkWUQ8MYKie8ND06uJ17b3MbgfSTT/06m4808Xc250GGYaj07sJxEHQJaS2QSGDOdBP0aDfUZ4xx/Z8=
X-Received: by 2002:ad4:5f4a:0:b0:87b:f3c0:1621 with SMTP id
 6a1803df08f44-87c2066cc50mr204832406d6.56.1761029375477; Mon, 20 Oct 2025
 23:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org> <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
 <aPaqZpDtc_Thi6Pz@codewreck.org> <CAHzjS_uEhozUU-g62AkTfSMW58FphVO8udz8qsGzE33jqVpY+g@mail.gmail.com>
 <086bb120-22eb-43ff-a486-14e8eeb7dd80@maowtm.org>
In-Reply-To: <086bb120-22eb-43ff-a486-14e8eeb7dd80@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Mon, 20 Oct 2025 23:49:24 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vrVJrphZqBMxVE4UEfOqgP8XPq6dRuBh9DdWL-SYtO2w@mail.gmail.com>
X-Gm-Features: AS18NWCZ_SQEw16OwgAGDTPBr02aILqIcOiLzCalXTvKe3EeOy4CZT7oiVJiXME
Message-ID: <CAHzjS_vrVJrphZqBMxVE4UEfOqgP8XPq6dRuBh9DdWL-SYtO2w@mail.gmail.com>
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
To: Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tingmao,

On Mon, Oct 20, 2025 at 5:54=E2=80=AFPM Tingmao Wang <m@maowtm.org> wrote:
>
> On 10/20/25 22:52, Song Liu wrote:
> > Hi Dominique,
> >
> > On Mon, Oct 20, 2025 at 2:32=E2=80=AFPM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> >>
> >> Song Liu wrote on Mon, Oct 20, 2025 at 12:40:23PM -0700:
> >>> I am running qemu 9.2.0 and bpftrace v0.24.0. I don't think anything =
is
> >>> very special here.
> >>
> >> I don't reproduce either (qemu 9.2.4 and bpftrace v0.24.1, I even went
> >> and installed vmtest to make sure), trying both my branch and a pristi=
ne
> >> v6.18-rc2 kernel -- what's the exact commit you're testing and could y=
ou
> >> attach your .config ?
> >
> > Attached, please find the config file.
> >
> > I tried to debug this, and found that the issue disappears when I remov=
e
> > v9fs_lookup_revalidate from v9fs_dentry_operations. But I couldn't figu=
re
> > out why d_revalidate() is causing such an issue.
>
> I've compiled qemu 9.2.0 and download the binary build of bpftrace v0.24.=
0
> from GitHub [1], and compiled kernel with your config, but unfortunately =
I
> still can't reproduce it...

Thanks for running these tests.

> I do now get this message sometimes (probably unrelated?):
> bpftrace (148) used greatest stack depth: 11624 bytes left
>
> I don't really know how to proceed right now but I will have it run in a
> loop and see if I can hit it by chance.
>
> If you can reproduce it frequently and can debug exactly what is returnin=
g
> -EIO in v9fs_lookup_revalidate that would probably be very helpful, or if
> you can enable 9p debug outputs and see what's happening around the time
> of error (CONFIG_NET_9P_DEBUG=3Dy and also debug=3D5 mount options - I'm =
not
> sure how to get vmtest to use a custom mount option but if it's
> reproducible in plain QEMU that's also an option) that might also be
> informative I think?  I'm happy to take a deeper look (although I'm of
> course less of an expert than Dominique so hopefully he can also give som=
e
> opinion).
>
> I'm also curious if this can happen with just a usual `stat` or other
> operations (not necessarily caused by dentry revalidation, and thus not
> necessarily to do with my patch)

I used strace to compare the behavior before and after the change.
It appears to me that bpftrace didn't get -EIO in the error case. Instead,
it got 0 bytes for a read that was supposed to return data.

Success case:
...
openat(AT_FDCWD, "/tmp/bpftrace.Rl1Vkg",
O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600) =3D 3
write(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0\0=
"...,
4352) =3D 4352
openat(AT_FDCWD, "/tmp/bpftrace.Rl1Vkg", O_RDONLY|O_CLOEXEC) =3D 4
newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D4352, ...}, AT_EMPTY_P=
ATH) =3D 0
read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0\0"=
...,
8192) =3D 4352
close(4) =3D 0
...

Failure case:
...
openat(AT_FDCWD, "/tmp/bpftrace.LbbDxk",
O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600) =3D 3
write(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0\367\0\1\0\0\0\0\0\0\0\0\0\0\0=
"...,
4352) =3D 4352
openat(AT_FDCWD, "/tmp/bpftrace.LbbDxk", O_RDONLY|O_CLOEXEC) =3D 4
newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D0, ...}, AT_EMPTY_PATH=
) =3D 0
read(4, "", 8192) =3D 0
...

So the failure case is basically:
1) open a file for write, and write something;
2) open the same file for read, and read() returns 0.

I created a small program to reproduce this issue (attached below).

Before [1], the program can read the data on the first read():
[root@(none) ]# ./main xxx
i: 0, read returns 4096
i: 1, read returns 0
i: 2, read returns 0
i: 3, read returns 0
i: 4, read returns 0
i: 5, read returns 0
i: 6, read returns 0
i: 7, read returns 0
i: 8, read returns 0
i: 9, read returns 0

After [1], the program cannot read the data, even after retry:
[root@(none) ]# ./main yyy
i: 0, read returns 0
i: 1, read returns 0
i: 2, read returns 0
i: 3, read returns 0
i: 4, read returns 0
i: 5, read returns 0
i: 6, read returns 0
i: 7, read returns 0
i: 8, read returns 0
i: 9, read returns 0

I am not sure what is the "right" behavior in this case. But this is
clearly a change of behavior.

Thanks,
Song

[1] https://lore.kernel.org/v9fs/cover.1743956147.git.m@maowtm.org/



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D reproducer =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

char buf[4096];

int main(int argc, char *argv[])
{
        int ret, i;
        int fdw, fdr;

        if (argc < 2)
                return 1;

        fdw =3D openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, =
0600);
        if (fdw < 0) {
                fprintf(stderr, "cannot open fdw\n");
                return 1;
        }
        write(fdw, buf, sizeof(buf));

        fdr =3D openat(AT_FDCWD, argv[1], O_RDONLY|O_CLOEXEC);

        if (fdr < 0) {
                fprintf(stderr, "cannot open fdr\n");
                close(fdw);
                return 1;
        }

        for (i =3D 0; i < 10; i++) {
                ret =3D read(fdr, buf, sizeof(buf));
                fprintf(stderr, "i: %d, read returns %d\n", i, ret);
        }

        close(fdr);
        close(fdw);
        unlink(argv[1]);
        return 0;
}

