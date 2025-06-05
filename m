Return-Path: <bpf+bounces-59762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F0ACF3C2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F6816A810
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC11E1DE2;
	Thu,  5 Jun 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G69HpqSs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930786347
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139739; cv=none; b=qLmiQXe1XVDznmpXVnDLVqrJZAV5SYwjSmQjYwScbQvte5OGqn5ym6/oTBhT9asUsUUQBkjLo+XkbF3hpwRZ7fKhI06oA/aPYRC2gjghhhjPovYeq5oSeS7JDsa2yqiW+069bKEB7LB7oEnwe/uNU26SK84/me0ZJsVx+u1C4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139739; c=relaxed/simple;
	bh=spYJIpXa1NqDDTQoy4h/XXUWLaPmBwqMXM+n+0MdYuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcKZzgRmE4VnWyaLgxjWVrIlKl853uBsqWfn4WVw84u0km+Dt59OucGn+Z8BtuNopz5afjPs5lIwlHWqfA8iiGYQllAEFxqYG1GKSvac1m6jMOrlp0DgHYhQHQx93dICNyHj0VFAq1wzeAieCx12ZX4KTczdFrlbNdGnb6bbTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G69HpqSs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606bbe60c01so2016346a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749139736; x=1749744536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm9JIzpetDVbEWe3gNMtBsTFwCb3uAf0cHL049JxRW8=;
        b=G69HpqSsJWKp9ono4d4rk/QyOA//nr5NPPl2N5U5rkFmMFydJsclqeT7TKF23IGpCK
         ctekz+97LXpVxPP6AlLQrG60Cd26Y2T74S68GvBMV9HPi/haP56ccIm/2b/AuyxCCkcJ
         BkEidruo6Peuxn2Z9bcANNJ2GjQ7JAImmMr9bUwyGQrb3Inn6dH+/9zNU4lgoGfkpaZ0
         e90bMb0gfuVnNjNCh9MwNUsz0HhWJUd5m2Ti9hfdRrZehgJ8Qp27IRTgASGm6qqswigO
         N9JnXv9sLTgGi0iJ/VJwJODyQYVlVqoGJzBQ6skjBlLflhZIwLweRx9D6/BHxcfU8HJ/
         qLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139736; x=1749744536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm9JIzpetDVbEWe3gNMtBsTFwCb3uAf0cHL049JxRW8=;
        b=RVkX99BwQEiMxQhQB2yxUyKCChAT0eEqrU0jdYzO7v95A2ur2nkTuYK2ejH4wE9yFq
         WETg3MNnZe0Pf018DkYn97klYeJDiu7nkXg5YWpVQ4inmHXLhieaBPFB4ato17xghLVP
         neKerciA+jMOpogrXNZQcV2rCJKD/aXDxFZchJjm0gQpJlnu+FcWZrSJONlsGQYvxfSa
         4hVODeFTwOgLZX2NHeV1orYXNybhem0vvrMOLkmfx7rxYEzNb43ZVVCZBXgdIQ50D/Mc
         f0tE/0XdePeGaOMN/smlqZpnKbto13CGeYuc+1/EBLITju15pJcosVXN5KNQST6ilfr1
         dVpA==
X-Forwarded-Encrypted: i=1; AJvYcCWeJiEMPCD6pbTHV9Ul7V03pc+PLF+C4PNtA1ST89UL8i4vb1GuvhpCPzqo2hbEpSKnvYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWO4F+gAzZhshLqbvNR0XzCYK158Z4nAS5/6+QUrEYCxjIKTKp
	WLBUpjzhalI9c51DMy/1n+zkU8e4euEd9O1pAmS6FWueqSaim0vbyfVa2hujdA/l4KmmdhuNFY3
	5UrqtJxD2oOFcDJ079avTIs01uPUKppxBOJv3
X-Gm-Gg: ASbGncsA6Kr4JYvg4UPsPgLYCj8tphuiD93H29xSX6mcYS3fk4iJh+SY0KmSVsWUpiH
	puQ8EWmKXyzdm+oMzzMWAB2/H6IqbuyTBe0ZdS10k1NVZZxnzmg0d2w+2aYGgK5oAyNm+Z7SwM2
	Pni+2BkWE3LEy762pcsZeKYoIOxOoGsGKrJphJV7ii3b4Rf7z+YV3Rgl23FdQ=
X-Google-Smtp-Source: AGHT+IHFQn5kuMF4vw8Su7pnPy7CipLl+j07QltZ6usU82e8HvhZ6PbH7GgCa60026sckLCuUo7eVIZnrHoMIJgdPaw=
X-Received: by 2002:a05:600c:34c2:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-451f0b0c75emr82841545e9.17.1749139725761; Thu, 05 Jun 2025
 09:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-2-isolodrai@meta.com>
 <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com> <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev>
In-Reply-To: <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 09:08:33 -0700
X-Gm-Features: AX0GCFukhbVI03gXpaXt5jpAF-W2WV63cn1d-_P9R0Ht7j52_5g-dm6juIdgNdI
Message-ID: <CAADnVQKcSi2fgJky4vOm9Xidar2QQWgmUoZZg0xauXjshDs1Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add cmp_map_pointer_with_const
 test
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:04=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/4/25 3:41 PM, Alexei Starovoitov wrote:
> > On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.co=
m> wrote:
> >>
> >> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
> >> BPF program with this code must not pass verification in unpriv.
> >>
> >> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> >> ---
> >>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++=
++
> >>   1 file changed, 17 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/too=
ls/testing/selftests/bpf/progs/verifier_unpriv.c
> >> index 28200f068ce5..c4a48b57e167 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >> @@ -634,6 +634,23 @@ l0_%=3D:     r0 =3D 0;                           =
              \
> >>          : __clobber_all);
> >>   }
> >>
> >> +SEC("socket")
> >> +__description("unpriv: cmp map pointer with const")
> >> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohib=
ited")
> >> +__retval(0)
> >> +__naked void cmp_map_pointer_with_const(void)
> >> +{
> >> +       asm volatile ("                                 \
> >> +       r1 =3D 0;                                         \
> >> +       r1 =3D %[map_hash_8b] ll;                         \
> >> +       if r1 =3D=3D 0xdeadbeef goto l0_%=3D;         \
> >
> > I bet this doesn't fit into imm32 either.
> > It should fit into _signed_ imm32.
>
> Apparently it's fine both for gcc and clang:
> https://github.com/kernel-patches/bpf/actions/runs/15454151804

Both compilers are buggy then.

> I guess the value from inline asm is just put into IMM bytes as
> is. llvm-objdump is exactly the same, although the value is pretty
> printed as negative:
>
> 0000000000000320 <cmp_map_pointer_with_const>:
>       100:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
>       101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0=
x0 ll
>       103:       15 01 00 00 ef be ad de if r1 =3D=3D -0x21524111 goto +0=
x0

It's 64-bit 0xFFFFffffdeadbeef
Not the same as 0xdeadbeef

