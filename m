Return-Path: <bpf+bounces-57571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE9AAD0E5
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423419808E9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFF218EBA;
	Tue,  6 May 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0jOz5J2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61353217648;
	Tue,  6 May 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570220; cv=none; b=s/sqgWJ3MNhclmueGF8AYzkO6XpuFmvlY3xYoD6Bm2tTeXPTiTp2DiZrsOro+KdAq60Ax7r8QgEtqQDTZPL6Xb+DYXNv+kgSZhxHp46gGH7mMlHa6m1v0oxbbhsCqlYzUnSClsiV9RLFAdryk9LYC/UshzoUS/dDHvwhrGBjWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570220; c=relaxed/simple;
	bh=GaNs7vnpUco858vTIYnuCqZeg86qEZxB0ThDDkrWsyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbN+ny09hB8C+z368LqgH0Q3XjYKPa0RZ5W7B/xq5cn7KrjAKkI8Qdobw3OB4Aq29GEDdNTzPREsSH5U4Rpsjwgqq4GW5B9FMxa/NqPFnHHB6kXGTzox9p48U0p8N2MmGgM0bCEjoXqoMZERUF8XRX8NW1aXNr5UOTFBnk4s9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0jOz5J2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso8107678a91.0;
        Tue, 06 May 2025 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746570217; x=1747175017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UeZnvzKCUtNfhJPsCpdkkywrOiWg8gdlhZ8fG0M0hU=;
        b=E0jOz5J2RB1KvQrd9MpnBaPXd5dBfuiyEvSu8tvEC9LsPoybFhxzlsZuGWY6Cps/EV
         MbPOnj1uCm9v1mHQCkwlzl/7HnzT5OTUF12lf5+VfyVqi7gfIibGun/ofhftg2wyrNNC
         APbonmVVdGVCosJczpxilA3tjMWVQWCn9hPStfoiYjOiWEhbzqdT7mMhFt2qb4bu9bth
         C/A/Ck3ZGhx70dlw4hOFuBsg1F9UhHsOayO3jLDuzHZW4i9t4eQHoWeLqCwVdJEqytEG
         Vzc8dRP2bjyfUWVbps78uBTosgDK6iNiXUDrlB5BuWKiCbBr0fa3NM40Rb7TSywOeUJn
         M9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570217; x=1747175017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UeZnvzKCUtNfhJPsCpdkkywrOiWg8gdlhZ8fG0M0hU=;
        b=mKSae5gDOPO+7Wn50pP0ZlA08RAcvyk0KjX9KzgJEpUiZtRf1q9dhvu5cT0Xs5/LGg
         skgHXZFkautxg86NFe9s/UPa+P8Qfl9VP1oQIUEI8Ut3gjT14/BbrC8akV69tdMlroKw
         jlLeoa3ZaWuMr01VB3SUtb1zZfN4nLkZDVix4QLw37CXBjS1SoZumtvoypu7SJTkx9zW
         QpMnn4WoizLBLn0B+S7DcaLDMdfppGu1AHVojIA1K/LDB/hAn34UBjTXr2Br/Yfg9j3x
         vn6k8/heekM6sttn9zr+d6lnqeq+0dtOPBxhTl3UzQVTlgvP5yEhOFoPHZjiwtc51EDk
         F1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZMmI1ILY0ZmfwTk6As5s4mRofW/kUA+R+CRbC9WvD83VVDIq/YbLxvUNaonbO39zgMrU=@vger.kernel.org, AJvYcCUjd6oyTPoJ9UfsjWxUlOX7XCHNjKgZMdgnfFUR4m3UgwR9k6v33QBL59bxC+eLxAP8enUhhW8pdWQB5OXy@vger.kernel.org
X-Gm-Message-State: AOJu0YwG460NQ4BPi+Bs+kXVtkRrpmcZnNKuaeH2ndBawi2lqeK5Kdas
	YLSpfMCPQOqEHAz+eSme/XtLn2hitz081WFDc5wwssSAAxRtANEm7PWG3/xyu1I9BE3pqEjhQQR
	1DHY5uS2/bP2t9xxT+fLCFOWd3sA=
X-Gm-Gg: ASbGncs42+zYAr3cb/cYB0BeuGdyICWDPMgh43qbTwJZ9XCrUOtQ7oTVYo4aW1RMgEz
	tcxH3LYGCV+mclgnewvNXpMVKJgizkYZzziTDhFj+6R9nqMfLshmNBqoU7Q0WR7/DvzTsMkC5og
	IvLeB9nullsE6GoqlSmbP9Q+q6wW1Mi1/fXOJHBA==
X-Google-Smtp-Source: AGHT+IHCKOT1i+eCtXzEbjp/znp4Ff88cKfm175mmc4ESX4mhpX1KG0fz36nT1x6WyYw/r3Dv4T2o+G8GBbyE9hnlKo=
X-Received: by 2002:a17:90b:1c03:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-30aac1b3f93mr1821540a91.15.1746570217451; Tue, 06 May 2025
 15:23:37 -0700 (PDT)
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
 <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com> <e5122286-68f0-4173-8549-a0705c4ca4b1@linux.dev>
In-Reply-To: <e5122286-68f0-4173-8549-a0705c4ca4b1@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 15:23:23 -0700
X-Gm-Features: ATxdqUFIBGdEnHhdutWoKfeGkYjRqS873aEeUndEvpdz5Lrf-lQlotPT70zWFxM
Message-ID: <CAEf4BzZKKd+0Hwok=BxyBsWMUnBBTUGj-ZfJK-voMXowRKPgNQ@mail.gmail.com>
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

On Tue, May 6, 2025 at 2:41=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 2025-05-06 2:04 p.m., Andrii Nakryiko wrote:
>  > On Sun, May 4, 2025 at 3:24=E2=80=AFAM Holger Hoffst=C3=A4tte
>  > <holger@applied-asynchrony.com> wrote:
>  >>
>  >> On 2025-05-03 04:36, Alexei Starovoitov wrote:
>  >>> On Fri, May 2, 2025 at 2:53=E2=80=AFAM Holger Hoffst=C3=A4tte
>  >>> <holger@applied-asynchrony.com> wrote:
>  >>>>
>  >>>> On 2025-05-02 11:26, Quentin Monnet wrote:
>  >>>>> On 02/05/2025 09:57, Holger Hoffst=C3=A4tte wrote:
>  >>>>>> A gcc-15-based bpf toolchain defaults to C23 and fails to
> compile various
>  >>>>>> kernel headers due to their use of a custom 'bool' type.
>  >>>>>> Explicitly using -std=3Dgnu11 works with both clang and bpf-toolc=
hain.
>  >>>>>>
>  >>>>>> Signed-off-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.=
com>
>  >>>>>
>  >>>>> Thanks! I tested that it still works with clang.
>  >>>>>
>  >>>>> Acked-by: Quentin Monnet <qmo@kernel.org>
>  >>>>
>  >>>> Thanks!
>  >>>>
>  >>>>> I didn't manage to compile with gcc, though. I tried with gcc
> 15.1.1 but
>  >>>>> option '--target=3Dbpf' is apparently unrecognised by the gcc
> version on
>  >>>>> my setup.
>  >>>>>
>  >>>>> Out of curiosity, how did you build using gcc for the skeleton?
> Was it
>  >>>>> enough to run "CLANG=3Dgcc make"? Does it pass the clang-bpf-co-re
> build
>  >>>>> probe successfully?
>  >>>>
>  >>>> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" packa=
ge,
>  >>>> which is just gcc configured & packaged for the bpf target.
>  >>>> Our bpftool package can be built with clang (default) or without, i=
n
>  >>>> which case it depend on the bpf-toolchain. The idea is to gradually
>  >>>> allow bpf/xdp tooling to build/run without requiring clang.
>  >>>>
>  >>>> The --target definition is conditional and removed when not using
> clang:
>  >>>>
> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7=
.5.0.ebuild?id=3Dbf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
>  >>>>
>  >>>> The bug for building with the new gcc-15 based toolchain where this
>  >>>> patch originated is here: https://bugs.gentoo.org/955156
>  >>>
>  >>> So you're fixing this build error:
>  >>>
>  >>> bpf-unknown-none-gcc \
>  >>>           -I. \
>  >>>
> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sour=
ces/include/uapi/
>  >>> \
>  >>>
> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sour=
ces/src/bootstrap/libbpf/include
>  >>> \
>  >>>           -g -O2 -Wall -fno-stack-protector \
>  >>>            -c skeleton/profiler.bpf.c -o profiler.bpf.o
>  >>> In file included from skeleton/profiler.bpf.c:3:
>  >>> ./vmlinux.h:5: warning: ignoring '#pragma clang attribute'
> [-Wunknown-pragmas]
>  >>>       5 | #pragma clang attribute push
>  >>> (__attribute__((preserve_access_index)), apply_to =3D record)
>  >>> ./vmlinux.h:9845:9: error: cannot use keyword 'false' as
> enumeration constant
>  >>>    9845 |         false =3D 0,
>  >>>         |         ^~~~~
>  >>> ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=3Dc23' onw=
ards
>  >>> ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
>  >>> 31137 | typedef _Bool bool;
>  >>>         |               ^~~~
>  >>>
>  >>> with -std=3Dgnu11 flag and
>  >>
>  >> Yes, correct. This is the same as all over the kernel or the bpf test=
s
>  >> for handling C23. I fully understand that this particular patch is on=
ly
>  >> one piece of the puzzle.
>  >>
>  >
>  > What's the best way to detect (at compile time) whether bool, false,
>  > and true are treated as reserved keywords? To solve this properly
>  > vmlinux.h would have to be adjusted by vmlinux.h to avoid emitting
>  > bool/false/true *iff* compiler version/mode doesn't like that
> I ran into this when adding GCC BPF to CI [1].
>
> One can do something like:
>
>       #if __STDC_VERSION__ < 202311L
>       enum {
>           false =3D 0,
>           true =3D 1,
>       };
>       #endif
>
> But in case of vmlinux.h this would require hacking bpftool, and so for
> selftests/bpf we decided to pass -std=3Dgnu11 [2].

We can adjust btf_dump_is_blacklisted() to ignore bool typedef
(unconditionally), and we'll need to ignore anon enum with false/true
(which is annoying), and then bpftool will unconditionally add the
above block plus typedef _Bool bool.

Would that work?

>
> [1]
> https://lore.kernel.org/bpf/CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi=
8WFcvQ@mail.gmail.com/
> [2]
> https://lore.kernel.org/bpf/20250107235813.2964472-1-ihor.solodrai@pm.me/
>
>  >
>  >>> ignoring an important warning ?
>  >>
>  >> Nobody is (or was) ignoring the warning - it was under discussion whe=
n
>  >> I posted the patch. After reaching out to Oracle to verify, we have n=
ow
>  >> added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with
> gcc-bpf;
>  >> this resolves the warning, just like in the bpf self-tests.
>  >>
>  >> You are right that such an addition to the in-kernel bpftool build is
>  >> still missing. If you have a suggestion on how best to do that via th=
e
>  >> existing Makefile I'm all ears.
>  >>
>  >> As for the remaining warnings - we are also very aware of the ongoing
>  >> upstream work to support btf_type_tag:
>  >> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.
>  >>
>  >>> End result: partially functional bpftool,
>  >>> and users will have no idea why some features of bpftool are not
> working.
>  >>
>  >> First of all this is never shipped to any users; using gcc-bpf requir=
es
>  >> active opt-in by developers or users, and now also warns that such a
> setup
>  >> may result in unexpected bugs due to ongoing work in both Linux and
> bpftool.
>  >> Like I said before, by default everyone builds with clang and that
> is also
>  >> true for our distributed binaries.
>  >>
>  >> If you think adding the -std=3Dgnu11 bit is inappropriate at this tim=
e
> then
>  >> just ignore this patch for now. Sooner or later the bpftool build
> will have
>  >> to be adapted with BPF_CFLAGS (liek in the selftests) and hopefuilly =
an
>  >> abstracted BPF_CC so that we no longer have to pretend to be clang wh=
en
>  >> using gcc.
>  >>
>  >> cheers
>  >> Holger

