Return-Path: <bpf+bounces-60512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA3AD7B01
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15F53B17BE
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7772D1F72;
	Thu, 12 Jun 2025 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZTuh+WL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9B45948
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755928; cv=none; b=qdgRacnKZvY7Ab8TuDwps1aN3VzbhP4sbnvuDMBV6CPHOU3iNmX0IKVORJhJtSxcYAIDmLOLCjkin2SNOl95xfrBZ+2OJApb6lv5VxDEA051nqCwWvrCwNabNDlIe4Bnz1YrCMo1k5qK3sqcMOzJpM/+Iage60mC2Tg2VpyK1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755928; c=relaxed/simple;
	bh=/bxOl+94ga5Hgsp03YzlY69CA9LZgr+srxIAiQmJynI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNEACKjurljHuKmzjOb7zOf17EZdKT6qIopFyyem74vadHTHsTb0HCy/P625WAWUlzgtn02vY8E564H3t8cmhQIQgVHhldD/Go1oxgXYgkbKuMZGAm4h+5RX3Qnl5EvCvW83sueK4DbjObv1FnxuP/bkSCMmxvhHmWknTzFND7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZTuh+WL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a51481a598so843449f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749755925; x=1750360725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RUku+kZ6TinuBogaA0cvtdSNT4PO54CUmOJer5/1y8=;
        b=UZTuh+WLyHieZe4uERSCHvwRz9bzv3/HE8kcNOvzwV0PL8GfXyDeChCEPjSWzojq0u
         L9yo05++SjkhYY1GgAOuK06FLkag4XsumBmPs4DgtMq+5iVDNqSaw4swW4kvgGWOBXtZ
         An2Qqw3cUJ4xFVC1pMQe9zuLrMkR9vRTxPc5zhodkghQBKQe09QI4BNJnyh+XnFXbteO
         5Pz5Fb60tyBXeQp9y2oHdt4rOEAIp9aK/wuF/pbmR7lsemgd6bLS0VV1td1jqMOuEoN4
         H2sO9wz2gjBNk6sC+mmUK/DsNd6L0lckZh9jMmpbhKdiyrhwixF0tiG/hfJ/1PyfeCUQ
         KToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749755925; x=1750360725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RUku+kZ6TinuBogaA0cvtdSNT4PO54CUmOJer5/1y8=;
        b=GParpqRtySo2tJr8lLshg3GagkQ2MLzVSQ9KuFtpJXlu77LzMC4utuhaqfwaEvStao
         Ue/vuVIz2SjqPLhD+UWzkXYgNWXIM18uQ5WTNK05JpJxocuWwurrU4E0139X2BpyO89y
         lRek84ONjIAw1iOsXKlL3lVglSbn1OQlCvu/1xIk1Xylz+ZNubsdW0TkHnpT99Ce2njA
         had7ZfLhIOFA+IUSzofIcvS189pjovaV0UMU4jzZCIzTGCg7qQ4CdHdiYBqqgJm0zo1R
         eTAvVnPlcxAQBI9zfqSfnU8H/4LdPLGbxuanvelFafhmAGK+ftn2wvd9p7l9eUL9Xuxz
         2sYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG50PpiPu7zqY/KOBJdZSW/6zyHUYOeHQR/UFD42LNhz0WNT2edbzK+nqvQF9lDOvnHH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiExNR0jfJri9X5fP8SQ5A+9r1q0esp4vMIC5onVeimvebSc+
	S5pNyzPwGEWypeKr496KZ6qqBVovuKqRv7YmcN0hC3OdNwQ/ZXz1bh57qHyD60VsFun6J/4Hj5k
	hDqDHEPlXIjPmC15dfnJNZiCOPr4+6qU=
X-Gm-Gg: ASbGncvqBMHwTpCAu30elXvJLtv9LYl3oIQb7VXf3y1tczqLaQXtTh27ii+WHWzRbFs
	ZL2ta5XIS/lPYEwkspE8M06XpRUKSpU1oVGMLsbdvh/RqIGR5J35NniXhgx993h7eQGwvo/3MFu
	Fck/r/QdwGXNrFv9wVbJAOMnQ2HQXsdtTRVAhWqf+WIYwEs6DFZrMdDUmbQbEjD+mMNfta4jQuA
	oYCe85sQAc=
X-Google-Smtp-Source: AGHT+IGQFXoj0U4PKobAO3v0cYl/RatQ5IDBYRg1AmCVexudeBmdxyk6PujfldvOxdF2mWyeS2+MW5P4/QBmhusaPgA=
X-Received: by 2002:a05:6000:188d:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3a5686fdd99mr397776f8f.16.1749755924865; Thu, 12 Jun 2025
 12:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612171938.2373564-1-yonghong.song@linux.dev> <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
In-Reply-To: <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 12:18:32 -0700
X-Gm-Features: AX0GCFu08SW3SZeuxvD9uCaN2xVL-_I2kd1to2SaxJhCJKfTcjzG1UGAXDAfixM
Message-ID: <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm codes
To: Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-06-12 at 10:19 -0700, Yonghong Song wrote:
> > In one of upstream thread ([1]), there is a discussion about
> > the below inline asm code:
> >
> >   if r1 =3D=3D 0xdeadbeef goto +2;
> >   ...
> >
> > In actual llvm backend, the above 0xdeadbeef will actually do
> > sign extension to 64bit value and then compare to register r1.
> >
> > But the code itself does not imply the above semantics. It looks
> > like the comparision is between r1 and 0xdeadbeef. For example,
> > let us at a simple C code:
> >   $ cat t1.c
> >   int foo(long a) { return a =3D=3D 0xdeadbeef ? 2 : 3; }
> >   $ clang --target=3Dbpf -O2 -c t1.c && llvm-objdump -d t1.o
> >     ...
> >     w0 =3D 0x2
> >     r2 =3D 0xdeadbeef ll
> >     if r1 =3D=3D r2 goto +0x1
> >     w0 =3D 0x3
> >     exit
> > It does try to compare r1 and 0xdeadbeef.
> >
> > To address the above confusing inline asm issue, llvm backend ([2])
> > added some range checking for such insns and beyond. For the above
> > insn asm, the warning like below
> >   warning: immediate out of range, shall fit in int range
> > will be issued. If -Werror is in the compilation flags, the
> > error will be issued.
> >
> > To avoid the above warning/error, the afore-mentioned inline asm
> > should be rewritten to
> >
> >   if r1 =3D=3D -559038737 goto +2;
> >   ...
> >
> > Fix a few selftest cases like the above based on insn range checking
> > requirement in [2].
> >
> >   [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@=
linux.dev/
> >   [2] https://github.com/llvm/llvm-project/pull/142989
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
>
> Changes like 0xffffffff -> -1 and 0xfffffffe -> -2 look fine,
> but changes like 0xffff1234 -> -60876 are an unnecessary obfuscation,
> maybe we need to reconsider.

I have to agree.
I didn't expect there to be so many warnings.
I thought it would be good to warn for
r3 =3D 0xdeadbeef

since r3 will have 0xffffFFFFdeadbeef value after assignment,
but warn on
r0 &=3D 0xFFFF1234
and replacement with -60876 is taking the warning too far.

Also considering Jose's point.

Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
llvm should probably accept 0xffffFFFFdeadbeef as imm32.
But that is a separate discussion.

