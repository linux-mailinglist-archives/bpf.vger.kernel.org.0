Return-Path: <bpf+bounces-57584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC631AAD193
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205134A67EF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B6021D3E7;
	Tue,  6 May 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk7XGa8u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354741946DF;
	Tue,  6 May 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574480; cv=none; b=AgVGOTrbcHrugIPbajxZwsrVI960juAmCfDNVKxofshDDzjBn5zwNYA5uRLRWDboGELvBFsNt9mG+3CNoP28hEdGBIokK3QgtK4+69EIF4pXrIN4XQ7/W6ww14N6SFfd7c1LkvsJ2Bnza85IeIkMtNR4YmXpDBJ7gpNV6jRmedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574480; c=relaxed/simple;
	bh=GGmVt1CLprCb2AZDjyCAN5LGo1FJMEqEPaNPygJxkIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSB5hTLpCbUd+P1CcP/oa1Ltz1ueLlF7ZX2im6xf8ghFAlkt2zEX0Zb+kDl8P42rGm+NYsxZXM5z4BuAkJwhyi8p4kcpynFwFIBcakK4/2a1Tq+CXFNzKETXWWGyGtU5Uc2+Zg1b5fqL4SZCUQUzaoxDXAn6Dc65zEYDhZJ2864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk7XGa8u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376e311086so8969848b3a.3;
        Tue, 06 May 2025 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746574478; x=1747179278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQGl7LTWkW9xFOc4zrwAGJMKjKDpAjOQ8R5f+gxCFh8=;
        b=Mk7XGa8u4d1GBKDr8BKgJG2/DoHE3/t8vf8xDY+qmIOvsJIl1FS4AVXUPgHLX6SmgG
         6BmYYzN470QE7F2NKiF6yB2WEt76gZtz0hePXhLazBTh81wcHEtNNsCtpGd8qXeUUGhG
         sXN0cuNMKacPFxDBPUvM1a6C6o9cBCWSb9wvSyt3tboLyg+nUixrDvaQ4E19JBPMAMxN
         4B12Xm7ZGiKveiWSHIED9SkqiVOtG7DHfkVRAEZjJFGjYTUYbpVPaTCU685UVlx+551h
         N8dQsBFCzYSx9oCBZbnsZlAgTMmTQ5scy922gvo+RjldVD/eTsK7gIiC6K6KqRRCj3nf
         NuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746574478; x=1747179278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQGl7LTWkW9xFOc4zrwAGJMKjKDpAjOQ8R5f+gxCFh8=;
        b=wLWLoIZCsNy4KFsaSOE2U1qFYy8TPSjpYL19SdteeOFvS0sqlBSkYFeZzsAJ1wA6ev
         vAgky2Yl4WzDuIriDPyH140MXa2nlFL+bR6A8ZTmp68EpA4o8BaVIQ3+mhqgjc9epJ8Q
         SE2Ya0hhvY6/AE8s9Arm+Q9UyXiu4LPh3I1mifGfYWNN3sTm6ZIoXF4rJn0XRQUBrgcp
         i3VoghQamrPpbjSTe5Hb/fQWWGnG5qGHSsfhPXWxqRQWf6NCgmZfWVsQpTVVUnzV/7Yx
         rJCDuiZLWSIorcaL8MIOda7wH/gX2NwxP8NCWuxytbWSV10fJHOM5JoJsKDVkr+laLUH
         kHhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzK+1ylZX2hcFqwFj5O+t7zwi7D/muNq7t4tVw7TY7/qhPrispbfWhlMK6R4FPBCslAXbpgb3UZ8EbZSXR@vger.kernel.org, AJvYcCXSYVmsQ06xNhmq93mypDtWTdSC7TJYY/P5Q5M1h8Qj+8WyMrjEp7lDnM4ZxRS8lXUvLqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoY0rB0F+yBLOas2nq5W9XlSP0/EbTcGOF2MldCxxH47osQxb
	wEWtUVy7H5fQ7jsw1vib4zqY6Vt3HKxmRjf69s8k9R/wN3qdQaJRwiW1OmXWUzfjkh8ZTreYoRF
	4qsUOz2mQuJeWMxZEWMOtqFBpmb0=
X-Gm-Gg: ASbGncsMJIF1LlibFUTKss9lx0JLVPyyeKIO6/cbd2rk6qssYbtrvOgFMCuDd6tFIud
	E2gsirVfRhsHBVJmafp46i1d25kbqoGGn2lgrJDlnxj7/YbYy6dHhpooeje+voe1GMXnPwK2xS2
	NGYpApZd61BcfMeduObUwpDsjVGsiFm7jseXqN4g==
X-Google-Smtp-Source: AGHT+IGBuh6mc/4Y2pOciBPtoqroqMC1XIOfpVxxqMnICiMNt5ObXBuDECjQOQIDNNV4wpEvD2GY8EaH5MIQDxHA8hQ=
X-Received: by 2002:a05:6a00:aa0d:b0:740:6f80:f855 with SMTP id
 d2e1a72fcca58-7409cf4da96mr1385638b3a.9.1746574478362; Tue, 06 May 2025
 16:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org> <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
 <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
 <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
 <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com>
 <e5122286-68f0-4173-8549-a0705c4ca4b1@linux.dev> <CAEf4BzZKKd+0Hwok=BxyBsWMUnBBTUGj-ZfJK-voMXowRKPgNQ@mail.gmail.com>
 <f5084334-d3d4-4e4c-94aa-30afc9e87a11@linux.dev>
In-Reply-To: <f5084334-d3d4-4e4c-94aa-30afc9e87a11@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 16:34:25 -0700
X-Gm-Features: ATxdqUESDY9GT3VTBf0JR0XTVnubSquwI7srhyzuSjKjfdJJvQ4m17qj985tsJ4
Message-ID: <CAEf4Bzb+KhWDkJEmCK_RW0UYc4C_CbmAWFYvoAqhBHBTarpeHw@mail.gmail.com>
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:34=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 2025-05-06 3:23 p.m., Andrii Nakryiko wrote:
> > On Tue, May 6, 2025 at 2:41=E2=80=AFPM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >>
> >> On 2025-05-06 2:04 p.m., Andrii Nakryiko wrote:
> >>   > On Sun, May 4, 2025 at 3:24=E2=80=AFAM Holger Hoffst=C3=A4tte
> >>   > <holger@applied-asynchrony.com> wrote:
> >>   >>
> >>   >> On 2025-05-03 04:36, Alexei Starovoitov wrote:
> >>   >>> On Fri, May 2, 2025 at 2:53=E2=80=AFAM Holger Hoffst=C3=A4tte
> >>   >>> <holger@applied-asynchrony.com> wrote:
> >>   >>>>
> >>   >>>> On 2025-05-02 11:26, Quentin Monnet wrote:
> >>   >>>>> On 02/05/2025 09:57, Holger Hoffst=C3=A4tte wrote:
> >>   >>>>>> A gcc-15-based bpf toolchain defaults to C23 and fails to
> >> compile various
> >>   >>>>>> kernel headers due to their use of a custom 'bool' type.
> >>   >>>>>> Explicitly using -std=3Dgnu11 works with both clang and bpf-t=
oolchain.
> >>   >>>>>>
> >>   >>>>>> Signed-off-by: Holger Hoffst=C3=A4tte <holger@applied-asynchr=
ony.com>
> >>   >>>>>
> >>   >>>>> Thanks! I tested that it still works with clang.
> >>   >>>>>
> >>   >>>>> Acked-by: Quentin Monnet <qmo@kernel.org>
> >>   >>>>
> >>   >>>> Thanks!
> >>   >>>>
> >>   >>>>> I didn't manage to compile with gcc, though. I tried with gcc
> >> 15.1.1 but
> >>   >>>>> option '--target=3Dbpf' is apparently unrecognised by the gcc
> >> version on
> >>   >>>>> my setup.
> >>   >>>>>
> >>   >>>>> Out of curiosity, how did you build using gcc for the skeleton=
?
> >> Was it
> >>   >>>>> enough to run "CLANG=3Dgcc make"? Does it pass the clang-bpf-c=
o-re
> >> build
> >>   >>>>> probe successfully?
> >>   >>>>
> >>   >>>> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" p=
ackage,
> >>   >>>> which is just gcc configured & packaged for the bpf target.
> >>   >>>> Our bpftool package can be built with clang (default) or withou=
t, in
> >>   >>>> which case it depend on the bpf-toolchain. The idea is to gradu=
ally
> >>   >>>> allow bpf/xdp tooling to build/run without requiring clang.
> >>   >>>>
> >>   >>>> The --target definition is conditional and removed when not usi=
ng
> >> clang:
> >>   >>>>
> >> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftoo=
l-7.5.0.ebuild?id=3Dbf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
> >>   >>>>
> >>   >>>> The bug for building with the new gcc-15 based toolchain where =
this
> >>   >>>> patch originated is here: https://bugs.gentoo.org/955156
> >>   >>>
> >>   >>> So you're fixing this build error:
> >>   >>>
> >>   >>> bpf-unknown-none-gcc \
> >>   >>>           -I. \
> >>   >>>
> >> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-s=
ources/include/uapi/
> >>   >>> \
> >>   >>>
> >> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-s=
ources/src/bootstrap/libbpf/include
> >>   >>> \
> >>   >>>           -g -O2 -Wall -fno-stack-protector \
> >>   >>>            -c skeleton/profiler.bpf.c -o profiler.bpf.o
> >>   >>> In file included from skeleton/profiler.bpf.c:3:
> >>   >>> ./vmlinux.h:5: warning: ignoring '#pragma clang attribute'
> >> [-Wunknown-pragmas]
> >>   >>>       5 | #pragma clang attribute push
> >>   >>> (__attribute__((preserve_access_index)), apply_to =3D record)
> >>   >>> ./vmlinux.h:9845:9: error: cannot use keyword 'false' as
> >> enumeration constant
> >>   >>>    9845 |         false =3D 0,
> >>   >>>         |         ^~~~~
> >>   >>> ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=3Dc23'=
 onwards
> >>   >>> ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typed=
ef'
> >>   >>> 31137 | typedef _Bool bool;
> >>   >>>         |               ^~~~
> >>   >>>
> >>   >>> with -std=3Dgnu11 flag and
> >>   >>
> >>   >> Yes, correct. This is the same as all over the kernel or the bpf =
tests
> >>   >> for handling C23. I fully understand that this particular patch i=
s only
> >>   >> one piece of the puzzle.
> >>   >>
> >>   >
> >>   > What's the best way to detect (at compile time) whether bool, fals=
e,
> >>   > and true are treated as reserved keywords? To solve this properly
> >>   > vmlinux.h would have to be adjusted by vmlinux.h to avoid emitting
> >>   > bool/false/true *iff* compiler version/mode doesn't like that
> >>
> >> I ran into this when adding GCC BPF to CI [1].
> >>
> >> One can do something like:
> >>
> >>        #if __STDC_VERSION__ < 202311L
> >>        enum {
> >>            false =3D 0,
> >>            true =3D 1,
> >>        };
> >>        #endif
> >>
> >> But in case of vmlinux.h this would require hacking bpftool, and so fo=
r
> >> selftests/bpf we decided to pass -std=3Dgnu11 [2].
> >
> > We can adjust btf_dump_is_blacklisted() to ignore bool typedef
> > (unconditionally), and we'll need to ignore anon enum with false/true
> > (which is annoying), and then bpftool will unconditionally add the
> > above block plus typedef _Bool bool.
> >
> > Would that work?
>
> I think yes, but then the question is why do all this work in bpftool
> instead of passing -std=3Dgnu11 to the compiler? Especially given that

because -std=3Dgnu11 is a mitigation, not a solution (at least for this
issue). The issue is that vmlinux.h (as it is right now) is not
compatible with C23 standard, which artificially limits what BPF users
can use with their .bpf.c code *just because of vmlinux.h*. Why? We
should find a solution to not depend on -std=3Dgnu11 workarounds.

So this is not about bpftool and BPF selftests specifically, it's
about anyone using vmlinux.h.

> kernel is built with such flags:
>
> $ grep -r --include=3D"[Mm]akefile" 'std=3Dgnu'
>

[...]

> >
> >>
> >> [1]
> >> https://lore.kernel.org/bpf/CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3r=
Tmi8WFcvQ@mail.gmail.com/
> >> [2]
> >> https://lore.kernel.org/bpf/20250107235813.2964472-1-ihor.solodrai@pm.=
me/
> >>
> >>   >
> >>   >>> ignoring an important warning ?
> >>   >>
> >>   >> Nobody is (or was) ignoring the warning - it was under discussion=
 when
> >>   >> I posted the patch. After reaching out to Oracle to verify, we ha=
ve now
> >>   >> added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with
> >> gcc-bpf;
> >>   >> this resolves the warning, just like in the bpf self-tests.
> >>   >>
> >>   >> You are right that such an addition to the in-kernel bpftool buil=
d is
> >>   >> still missing. If you have a suggestion on how best to do that vi=
a the
> >>   >> existing Makefile I'm all ears.
> >>   >>
> >>   >> As for the remaining warnings - we are also very aware of the ong=
oing
> >>   >> upstream work to support btf_type_tag:
> >>   >> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.
> >>   >>
> >>   >>> End result: partially functional bpftool,
> >>   >>> and users will have no idea why some features of bpftool are not
> >> working.
> >>   >>
> >>   >> First of all this is never shipped to any users; using gcc-bpf re=
quires
> >>   >> active opt-in by developers or users, and now also warns that suc=
h a
> >> setup
> >>   >> may result in unexpected bugs due to ongoing work in both Linux a=
nd
> >> bpftool.
> >>   >> Like I said before, by default everyone builds with clang and tha=
t
> >> is also
> >>   >> true for our distributed binaries.
> >>   >>
> >>   >> If you think adding the -std=3Dgnu11 bit is inappropriate at this=
 time
> >> then
> >>   >> just ignore this patch for now. Sooner or later the bpftool build
> >> will have
> >>   >> to be adapted with BPF_CFLAGS (liek in the selftests) and hopefui=
lly an
> >>   >> abstracted BPF_CC so that we no longer have to pretend to be clan=
g when
> >>   >> using gcc.
> >>   >>
> >>   >> cheers
> >>   >> Holger
>

