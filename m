Return-Path: <bpf+bounces-57306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1901AA7E0E
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 04:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB23466665
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4D1519BC;
	Sat,  3 May 2025 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZqM7WrW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB667346F;
	Sat,  3 May 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746239777; cv=none; b=dIHS5fFJkF/mPKoheC/0RcfIV2UP//R4BX1iyXI3If3rbjiyV9aZqnE+hHT5EeDIX3To5FLwICYYL/Rdh1M3+0JWHWS9ayfPEbfbAXis7cT6ysj4VeQPWgGw/OdFongoN37V5vFtREyld8VOTIlk7xtq/bwto1RKCvkYdLNmCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746239777; c=relaxed/simple;
	bh=RkRcnAxfe05hsezMqlLNRWMFVfEI9Mc90X9bCvZZaDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+pV150OgM1SacslZltg9Q2KtWbsgAKb8gHwVd8kihKjiiB4U0aFNO94iYmpdd8NKm9tfCZz/FP2bthgowhb8NQqdYYy3t1r/7Zr8YF+4TcqfzniYJ/iQ1qaVpMpmYlgBQPh9ryz7MasKFBgOQtg4DthwFd16TKpsC4i+6CLt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZqM7WrW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1750905f8f.1;
        Fri, 02 May 2025 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746239773; x=1746844573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uITQusArSGEWKQSX8L8AspDQ+A/DDNVWxmFg1rd9/0o=;
        b=QZqM7WrWlLcAohkqAE28FH0oNihX5tOksln9LAAKUPbruTQwC+84/yqLw5tlfz3zwS
         gzYXzYhfVgxaRDkiLtianeMimwz/XyXWfOHy3ny0BbyGykaQfkL1IUhfIxwygSy6iHk5
         KAinvPR284A44pmJn5ANrhK+fxCi3ia7SyLhW4+EaCb1IjhdnEfsc8rQye8MidenfTBz
         UNS9GimA30JD1OH6VbsDAu5b7RmBBfjUvkanDARJJ0VfwFKCki/BOLU4rwRX9wW/ivQS
         QPPBoMNti3zO2Jv669WGdACoYCTABVQllH12V5qCiuhqvVBazGoP7wF4jTkFCoH6u3hV
         GwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746239773; x=1746844573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uITQusArSGEWKQSX8L8AspDQ+A/DDNVWxmFg1rd9/0o=;
        b=MvuX1xoZU/6/7W39oF8SpdILpeOUmWMdmMAyRlRTZ9uWWRPpoMudBaXFj1+7OFPrNf
         NuzMtvSCBBClKVTmu+vYa3vm3lrB+n7aqBl6el68hZlwuk9u2G/avwGGMQyuoVw8/joN
         ItzCrlk2fD1CFZ8DfFOEA7FNMnDwZKy5qgJ1t81nODw2X6Da0CFfY+rAgCgN8J5NOMYO
         9c28xFJXPdxZtHQ26592rnDGr83lGgt5R2r+BKZ78XY+B1fBQlG91ERc+1f0fUxCAIJA
         3tjUjkBGlduHpcLYxv3a6FQ5IloN4LjFw/B3BbTyR6D8d21rpdsGI7pkrw9m2w4bPOHV
         4LxA==
X-Forwarded-Encrypted: i=1; AJvYcCUTlu8jwNYYMoJKbTfJ4Chgc1d6TaGbYNvx6ijtwP7eTnaL8EIO6zpVJlNc6o3qJaHpEn4=@vger.kernel.org, AJvYcCVTQr4RLwJDKQ2/eI18JEi9eEkHSMXrcFyq+0/UmEFTvyzjKOdZBtrldrC+LWmQWbOXtxd8SrQCCtdlgkIO@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcnyIGFfzqeV6+fc4jdNTk4CEn3wjvhJ87TzEgV0lk6dt8OdW
	8Qrf7eHbLL049ERykHKYAaRxs2K7fNVE3qlijzilbito8CxhWuHERDCYJ0KxTpjxvXQz5AxHnev
	SGkZDwbUgCJdkw6nrixYZ6i5jgvA=
X-Gm-Gg: ASbGncvRaPQ9JWUqhL9NNgrycdVqHyRlNcmQdLJODCJjHIJQTmwOYKq1WztRI2PcOR0
	O9xO3V0khO1O7kep0OiI6QcuyW8EoDj/vjhNfzWYknsrhvm3KA7MpIZ1yQzN1PyKVjTSAiZw8Dk
	56Bfj6khAAx5U/DyTZnrlyKSrsujk5lcjymQ70N9PhuMyUK/7xzAWhbEoBRxtN
X-Google-Smtp-Source: AGHT+IFeVJOJzYzfD0pUN6uqr9iT4qlUuTA+Je0m5FPZ1ALp00pYa0aTUBhIKana582lW/ECTgcgq17AcTn5vUNglSY=
X-Received: by 2002:a05:6000:2411:b0:3a0:809f:1c95 with SMTP id
 ffacd0b85a97d-3a099af1c48mr3462883f8f.53.1746239773401; Fri, 02 May 2025
 19:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org> <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
In-Reply-To: <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 19:36:02 -0700
X-Gm-Features: ATxdqUG4i8VEoM1aeFi-QfnWFgvcHzSSr4ybA4j31R74Pj_aFs4ZdNIQrMmOPAk
Message-ID: <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:53=E2=80=AFAM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2025-05-02 11:26, Quentin Monnet wrote:
> > On 02/05/2025 09:57, Holger Hoffst=C3=A4tte wrote:
> >> A gcc-15-based bpf toolchain defaults to C23 and fails to compile vari=
ous
> >> kernel headers due to their use of a custom 'bool' type.
> >> Explicitly using -std=3Dgnu11 works with both clang and bpf-toolchain.
> >>
> >> Signed-off-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> >
> > Thanks! I tested that it still works with clang.
> >
> > Acked-by: Quentin Monnet <qmo@kernel.org>
>
> Thanks!
>
> > I didn't manage to compile with gcc, though. I tried with gcc 15.1.1 bu=
t
> > option '--target=3Dbpf' is apparently unrecognised by the gcc version o=
n
> > my setup.
> >
> > Out of curiosity, how did you build using gcc for the skeleton? Was it
> > enough to run "CLANG=3Dgcc make"? Does it pass the clang-bpf-co-re buil=
d
> > probe successfully?
>
> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
> which is just gcc configured & packaged for the bpf target.
> Our bpftool package can be built with clang (default) or without, in
> which case it depend on the bpf-toolchain. The idea is to gradually
> allow bpf/xdp tooling to build/run without requiring clang.
>
> The --target definition is conditional and removed when not using clang:
> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7=
.5.0.ebuild?id=3Dbf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
>
> The bug for building with the new gcc-15 based toolchain where this
> patch originated is here: https://bugs.gentoo.org/955156

So you're fixing this build error:

bpf-unknown-none-gcc \
        -I. \
        -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.=
0-sources/include/uapi/
\
        -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.=
0-sources/src/bootstrap/libbpf/include
\
        -g -O2 -Wall -fno-stack-protector \
         -c skeleton/profiler.bpf.c -o profiler.bpf.o
In file included from skeleton/profiler.bpf.c:3:
./vmlinux.h:5: warning: ignoring '#pragma clang attribute' [-Wunknown-pragm=
as]
    5 | #pragma clang attribute push
(__attribute__((preserve_access_index)), apply_to =3D record)
./vmlinux.h:9845:9: error: cannot use keyword 'false' as enumeration consta=
nt
 9845 |         false =3D 0,
      |         ^~~~~
./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=3Dc23' onwards
./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
31137 | typedef _Bool bool;
      |               ^~~~

with -std=3Dgnu11 flag and
ignoring an important warning ?

It's a good thing that the build broke.
-std=3Dgnu11 will silence the error, but that warning will still be there
and the generated bpf program will be broken.
End result: partially functional bpftool,
and users will have no idea why some features of bpftool are not working.

pw-bot: cr

