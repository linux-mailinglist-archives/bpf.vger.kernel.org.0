Return-Path: <bpf+bounces-57562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D8AACF2A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC473AF146
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F521578D;
	Tue,  6 May 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE/utUxq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A41487F4;
	Tue,  6 May 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565512; cv=none; b=h6pBl7qcN9Z/OMvLtlGd/BD6w0yWZLZXWBX/ian/HyRTyIKvCVKzi4viBjsImx4g33nMKT0gifNdC17Yzw7reLU9wt63rrD9oS/sD6vvU7EqEFtrdGrQgqlfxh8m4YGK5KWOw48inoxyrAjscIFnwvWbibEHrHaQexi7URaQBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565512; c=relaxed/simple;
	bh=e1qHEgJ4EBKnE6gLzmeR5RPFCj9U6szUNm8w/lrJ8Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7ITFeRrb/SVIWlAYYxMRGVU3emQ+rmD9Yv7OOdd9ulvvCecv5+rkqwE/PevXYPKm8QpcS1PXNvpM8KgesOz9BACAUJ5is6toWUrj7dedMryfZHXBaG/gnfgs8AAxObt8Tq8ReL8rdn/tYIVpEp5xZ11KvbiM3E4eLF5cPIPQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE/utUxq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7370a2d1981so5165553b3a.2;
        Tue, 06 May 2025 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746565510; x=1747170310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSEhCjYjnsEXr9UG7zTvIDQr3+9PxPuO34pFmbrJ5vc=;
        b=bE/utUxqObzSZk8Cyp9UsX6MHQDXn0IV4Um4VWz5SOdDc4bhWDEaJjFpvkJO40/oLg
         IIseRxPqoVm5w3wFaSEQ52d+j5/Nm+Zl0t4SYVelZ1tZscPLwu5mHSbDGzTHvIZdjkSD
         AX/xaSkru8w9w2ITHco9Iz90lkwW/k0Go5AzREW9+kNP0v99KiR6lTBHhpKzxKyzMfNq
         cPZLSFvvrU65kH0YtYUABhmNKL3lxu98cpkjruq25yxbK6HpLnc7nQS3eo3yIeD6jBXA
         QSlwcvHbuJR7biPqICfXgdBWYBmtXV73sBMReZrPgV+IDkTgPQ60870T+iOZEr9gQfWS
         c6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565510; x=1747170310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSEhCjYjnsEXr9UG7zTvIDQr3+9PxPuO34pFmbrJ5vc=;
        b=RNO4DNteVhtoGVoXHtTvQscBk3NIsVTbECT6oUp0+CVaPPjK/18B6A8nmvbabZFTwO
         HsfDSwNhFCdOxEBvDNzsyz92RfRQy597nX6NdI2vMZoWMkFYgtgTvvuVaWvlaRFG+CoH
         d85i9wPoQGxxhYy74PPiD10S2RHYu1UZdqCuW2vxlhaLnfDqAUmkBvhC7OAVHeS5AIhw
         Q6VIjhmXcgsElvbk5N11/2j2L9/UBVZD/N87wSYU9IBeIEP+a5qDCyQHL4i369XyDXAW
         VvGrx/ScTnTPoifAfej2PLpp/w1f8csc/oVM+irb9RWRd8Ki+ffGdWVo/EefxZ0RAzL3
         SJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyF0/uL1T8FQSFVtZizHFSnu4IqvpLYSIB3RcIrQZIlN8EzwhXAmnJbnhtA+TT8SscQwR9jyJ3GepXZ9F5@vger.kernel.org, AJvYcCVpAhqq85wzxOMfCnBRO6Zlwe1ou43tzjCcMd8bZWVYg3NeYCOA1w4cfaD2i3sLHdEceuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWo5HmDzFXgYLUPLWZLpHVGKuO5wE1xKPJtZPE3HFxoZvzfCm
	b5SbXqie1Q9CZyRYayzmBB/vONjuTi4Pw6L+83gaNvyq/51B+bWcr9zdDpOfm8jpZBtU9jNVw/7
	MqkT5OJM+ffUqzOq4eqbGgVa89UEFV87G
X-Gm-Gg: ASbGncshwXoT3UgEpOFYjEFhwK5dGtEE7zsw8gXK8+L0AgPPbI36ye9gE2WZFXPZX4d
	J3GA8yHcOePAy1Fn4rZ+uEiKoOzTxtQ44BVK4xDTNCMLCl2jbz7rTBonqhGpldtr5zifPdGEfN4
	5UQEAR0dSzDUQ8WrcD59BAka4xw/tSvzXD9EXitg==
X-Google-Smtp-Source: AGHT+IEGbzaclPrSNLbpwY1OjJoztl6kRb0Wac9OKLNnw72VNagCJqiXskWxYP1WEfrIg74zt+O0FI62KRgHtD8He0Y=
X-Received: by 2002:a05:6a00:2a08:b0:73e:96f:d4c1 with SMTP id
 d2e1a72fcca58-7409cf15e7fmr865953b3a.13.1746565510404; Tue, 06 May 2025
 14:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org> <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
 <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com> <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
In-Reply-To: <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:04:58 -0700
X-Gm-Features: ATxdqUECGu980ouGjP2nCihP-TZ97sK48XyTR3etD-Bc401zNqeE7OzjIFc_omc
Message-ID: <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com>
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 3:24=E2=80=AFAM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2025-05-03 04:36, Alexei Starovoitov wrote:
> > On Fri, May 2, 2025 at 2:53=E2=80=AFAM Holger Hoffst=C3=A4tte
> > <holger@applied-asynchrony.com> wrote:
> >>
> >> On 2025-05-02 11:26, Quentin Monnet wrote:
> >>> On 02/05/2025 09:57, Holger Hoffst=C3=A4tte wrote:
> >>>> A gcc-15-based bpf toolchain defaults to C23 and fails to compile va=
rious
> >>>> kernel headers due to their use of a custom 'bool' type.
> >>>> Explicitly using -std=3Dgnu11 works with both clang and bpf-toolchai=
n.
> >>>>
> >>>> Signed-off-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com=
>
> >>>
> >>> Thanks! I tested that it still works with clang.
> >>>
> >>> Acked-by: Quentin Monnet <qmo@kernel.org>
> >>
> >> Thanks!
> >>
> >>> I didn't manage to compile with gcc, though. I tried with gcc 15.1.1 =
but
> >>> option '--target=3Dbpf' is apparently unrecognised by the gcc version=
 on
> >>> my setup.
> >>>
> >>> Out of curiosity, how did you build using gcc for the skeleton? Was i=
t
> >>> enough to run "CLANG=3Dgcc make"? Does it pass the clang-bpf-co-re bu=
ild
> >>> probe successfully?
> >>
> >> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
> >> which is just gcc configured & packaged for the bpf target.
> >> Our bpftool package can be built with clang (default) or without, in
> >> which case it depend on the bpf-toolchain. The idea is to gradually
> >> allow bpf/xdp tooling to build/run without requiring clang.
> >>
> >> The --target definition is conditional and removed when not using clan=
g:
> >> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftoo=
l-7.5.0.ebuild?id=3Dbf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
> >>
> >> The bug for building with the new gcc-15 based toolchain where this
> >> patch originated is here: https://bugs.gentoo.org/955156
> >
> > So you're fixing this build error:
> >
> > bpf-unknown-none-gcc \
> >          -I. \
> >          -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-=
v7.5.0-sources/include/uapi/
> > \
> >          -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-=
v7.5.0-sources/src/bootstrap/libbpf/include
> > \
> >          -g -O2 -Wall -fno-stack-protector \
> >           -c skeleton/profiler.bpf.c -o profiler.bpf.o
> > In file included from skeleton/profiler.bpf.c:3:
> > ./vmlinux.h:5: warning: ignoring '#pragma clang attribute' [-Wunknown-p=
ragmas]
> >      5 | #pragma clang attribute push
> > (__attribute__((preserve_access_index)), apply_to =3D record)
> > ./vmlinux.h:9845:9: error: cannot use keyword 'false' as enumeration co=
nstant
> >   9845 |         false =3D 0,
> >        |         ^~~~~
> > ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=3Dc23' onward=
s
> > ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
> > 31137 | typedef _Bool bool;
> >        |               ^~~~
> >
> > with -std=3Dgnu11 flag and
>
> Yes, correct. This is the same as all over the kernel or the bpf tests
> for handling C23. I fully understand that this particular patch is only
> one piece of the puzzle.
>

What's the best way to detect (at compile time) whether bool, false,
and true are treated as reserved keywords? To solve this properly
vmlinux.h would have to be adjusted by vmlinux.h to avoid emitting
bool/false/true *iff* compiler version/mode doesn't like that

> > ignoring an important warning ?
>
> Nobody is (or was) ignoring the warning - it was under discussion when
> I posted the patch. After reaching out to Oracle to verify, we have now
> added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with gcc-bpf;
> this resolves the warning, just like in the bpf self-tests.
>
> You are right that such an addition to the in-kernel bpftool build is
> still missing. If you have a suggestion on how best to do that via the
> existing Makefile I'm all ears.
>
> As for the remaining warnings - we are also very aware of the ongoing
> upstream work to support btf_type_tag:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.
>
> > End result: partially functional bpftool,
> > and users will have no idea why some features of bpftool are not workin=
g.
>
> First of all this is never shipped to any users; using gcc-bpf requires
> active opt-in by developers or users, and now also warns that such a setu=
p
> may result in unexpected bugs due to ongoing work in both Linux and bpfto=
ol.
> Like I said before, by default everyone builds with clang and that is als=
o
> true for our distributed binaries.
>
> If you think adding the -std=3Dgnu11 bit is inappropriate at this time th=
en
> just ignore this patch for now. Sooner or later the bpftool build will ha=
ve
> to be adapted with BPF_CFLAGS (liek in the selftests) and hopefuilly an
> abstracted BPF_CC so that we no longer have to pretend to be clang when
> using gcc.
>
> cheers
> Holger

