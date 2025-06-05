Return-Path: <bpf+bounces-59780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B66ACF645
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA447AB8DA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA992798F3;
	Thu,  5 Jun 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjNzUO+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0627B500
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147082; cv=none; b=dsCAHObiqJ0XqPdmP34jt7JKv43k2lbQJcqpgVAbo39IhaheMz1GDLi/Aepe6TgSWGXV4s91yYJOEdVQycxbk+bXukhyy87mpPUE7EMZocGi83yrxIPaai71Owd3DBfM7Z8Fh10YjTYf0GVJmJD/LawJjNaTALfJ7sm4fPYhEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147082; c=relaxed/simple;
	bh=Xh3FqnYKwbUrS77P7qXu2jKMgTNR0/XyY4hy6xMMdDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/HoZ9Pjmr5WliNAaqZPgAqSFOkxbK1WGMICUSGA1QO6bK+I8eR4pmYWcAeEs9uSqqgxLkbEKtAERRN8z1VFyjgUWLyC3eIlR6DtpRzw5M4QZGP9NVHNm4wxt2/UewbgOss+CP9tAe9AGImYGsoQemEezPrJEZ3tlqD09ZSHzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjNzUO+9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4508287895dso16099435e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147078; x=1749751878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOIyl7VMpQ94VPKgFkNQqNdFXJOXebr9NRnvLJUWWLY=;
        b=YjNzUO+9wX4inSyxJpvom0qUmvklQ0WBCUsiPKJWiGAhu9PTixad2h44MW8YXGqVRK
         cX2iofE0YMyayC6EvbaNcI8XP3++5PaKVu9+gb+FgcyVmFth7c8sWPAFSRKizoMfASU/
         ABllMGaUAPLer2AQoyei7WRwrvB+hjI7TUH4mc69LvTuZrZNBrBRCIFFCulqB/VMvo4f
         +eZFpugiewTfxInRCq6nLfZLUF2bZyg5cObx4qrleFf4I+n5AjdZXRdfcW2ucA/7LfgU
         kAspE9zhGZMgyujlCIp34TJh0tdW73nrWtt7Yfo7AGr3M6OY6S0KIZzX/KJXyhtVhiTH
         UycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147078; x=1749751878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOIyl7VMpQ94VPKgFkNQqNdFXJOXebr9NRnvLJUWWLY=;
        b=nnkf4zdMRkjYmiMbpwuK7yg0mBuAzKyWymmro7HxwdjAPABNQdSSq6DqrQJli+8s/m
         ek4h8ITwciVSKkfVKjLe47fDfmvpgu02MajlFoEaZ0aawuQvaKQ56gQLM3G/DOzlnry3
         cLvaEiMbBCqYi1xCpdCm1xS2O/+pDGEjDOYtgr/DdXroLPhqoEomGjI/z1yL8dCzzyUl
         HsSmTWWyRg+P4u1iHvBwWZa/yGEPd6pijKLaEqZ5MTCWTtSPW1MdJslDVo5BexXXrmJR
         1ArHoksnIPYhrlVkorM9SBLZ//0bBQFidWvzN7dOdEQ3NORir2hX8J8HhgZxQlKko6aM
         KWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBjxeO+5XwiaYlam5zQ3CWs69DOWgT7FFZe269vCZTTJoJ6lhJ05klo5vZBlZiMi2Y2lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlOmDuVZN7S5ynGyyXQ1d+hMpPbTSn/iRkWMJ9pu4p3oDCHif
	ySGirblQW5XU/Glmmrgq6+jW98S/zdCNQ3+NFQazgmUKxvDyayQSN5RPKurv52+eeJjevwa03uG
	eQPbzQm41B2GnhbBD7sQC3uuRqoXXsYE=
X-Gm-Gg: ASbGncuSu4mVm47jsTrRH3qESLBoZE8GognWbIGWzGe0onWmbJw9VYg7nk+0NDA95mX
	H60CEPrUupJiQzaDwsgSueJeZ0nGdUtJgdO14c6G7Gn2wwnbeOmnes/yXdAiIVdC404jCglVDjz
	4iKbwhXGDDTqMtoANvaVbMC/rnF7KqpUB/wzL2YTkzq8fAKOFl
X-Google-Smtp-Source: AGHT+IGcjHxCYo6qF2r9VD5qsb9msNA6sHKzkWY3LytoKcEgXhJuofzqjB3SSG31sQXsYJiN+wZ5+7XT2REBSZjq9F0=
X-Received: by 2002:a05:6000:4313:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a5313154aamr222639f8f.1.1749147078347; Thu, 05 Jun 2025
 11:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-2-isolodrai@meta.com>
 <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
 <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev> <CAADnVQKcSi2fgJky4vOm9Xidar2QQWgmUoZZg0xauXjshDs1Nw@mail.gmail.com>
 <adc7ee88-7b35-4977-8320-3dc852ba48f8@linux.dev> <9b6c75b2-5f33-47cc-ba23-6233a5c93938@linux.dev>
In-Reply-To: <9b6c75b2-5f33-47cc-ba23-6233a5c93938@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 11:11:06 -0700
X-Gm-Features: AX0GCFuWq15SC_FGEvvtNVukKrXVJ1LIwvKG8e6wJOU94dylxAPqV-tY1y0LMKU
Message-ID: <CAADnVQJneX_rzcr-L0-yUwy38ffwwDqVq4E8byC+wpTMYTrT4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add cmp_map_pointer_with_const
 test
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 10:42=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 6/5/25 10:17 AM, Ihor Solodrai wrote:
> > On 6/5/25 9:08 AM, Alexei Starovoitov wrote:
> >> On Wed, Jun 4, 2025 at 8:04=E2=80=AFPM Ihor Solodrai
> >> <ihor.solodrai@linux.dev> wrote:
> >>>
> >>> On 6/4/25 3:41 PM, Alexei Starovoitov wrote:
> >>>> On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta=
.com>
> >>>> wrote:
> >>>>>
> >>>>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
> >>>>> BPF program with this code must not pass verification in unpriv.
> >>>>>
> >>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> >>>>> ---
> >>>>>    .../selftests/bpf/progs/verifier_unpriv.c       | 17
> >>>>> +++++++++++++++++
> >>>>>    1 file changed, 17 insertions(+)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >>>>> b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >>>>> index 28200f068ce5..c4a48b57e167 100644
> >>>>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> >>>>> @@ -634,6 +634,23 @@ l0_%=3D:     r0 =3D
> >>>>> 0;                                         \
> >>>>>           : __clobber_all);
> >>>>>    }
> >>>>>
> >>>>> +SEC("socket")
> >>>>> +__description("unpriv: cmp map pointer with const")
> >>>>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison
> >>>>> prohibited")
> >>>>> +__retval(0)
> >>>>> +__naked void cmp_map_pointer_with_const(void)
> >>>>> +{
> >>>>> +       asm volatile ("                                 \
> >>>>> +       r1 =3D 0;                                         \
> >>>>> +       r1 =3D %[map_hash_8b] ll;                         \
> >>>>> +       if r1 =3D=3D 0xdeadbeef goto l0_%=3D;         \
> >>>>
> >>>> I bet this doesn't fit into imm32 either.
> >>>> It should fit into _signed_ imm32.
> >>>
> >>> Apparently it's fine both for gcc and clang:
> >>> https://github.com/kernel-patches/bpf/actions/runs/15454151804
> >>
> >> Both compilers are buggy then.
> >>
> >>> I guess the value from inline asm is just put into IMM bytes as
> >>> is. llvm-objdump is exactly the same, although the value is pretty
> >>> printed as negative:
> >>>
> >>> 0000000000000320 <cmp_map_pointer_with_const>:
> >>>        100:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
> >>>        101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1
> >>> =3D 0x0 ll
> >>>        103:       15 01 00 00 ef be ad de if r1 =3D=3D -0x21524111 go=
to
> >>> +0x0
> >>
> >> It's 64-bit 0xFFFFffffdeadbeef
> >> Not the same as 0xdeadbeef
> >
> > I am not sure what the issue is, would appreciate an explanation.
> >
> > Inline asm contains a 32bit literal (without a sign). Compiler takes
> > this literal as is and puts it into imm field of the instruction,
> > which is also 32bit. The instruction is valid and this value _means_
> > signed integer, in particular for the verifier.

Not quite. It's signed imm32 in _runtime_.

> >
> > Are you saying that compiler should check the sign of the literal and
> > verify it's in signed 32bit range? In other words if you want
> > 0xdeadbeef bytes in the imm, you must write -0x21524111 in the asm?
> >
> > AFAIU it'd be different from C then, because you can write:
> >
> >    int k =3D 0xdeadbeef;
> >    printf("%d\n", k); // prints -559038737
> >
> > and it's fine.
> >
> > Looking at Yonghong's llvm pr [1], it will not error for 0xdeadbeef
> > because it's less than UINT_MAX:
> >
> >     if (MO.isImm()) {
> >         int64_t Imm =3D MO.getImm();
> >         if (MI.getOpcode() !=3D BPF::LD_imm64 && (Imm < INT_MIN || Imm =
>
> > UINT_MAX))
> >           Ctx.reportError(MI.getLoc(),
> >                           "immediate out of range, shall fit in 32
> > bits");
> >         return static_cast<unsigned>(Imm);
> >       }
> >
> > [1] https://github.com/llvm/llvm-project/pull/142989
> >
> >
> If we have C code like
>    if (var =3D=3D 0xdeadbeef) { ... }
>
> The compiler will actually convert 'var =3D=3D imm' to 'rX =3D=3D rY' and
> rY will have content of 0xdeadbeef. This will happen during IR lowering
> from middle end to machine instructions.

... and the compiler will use ld_imm64 insn to store 0xdeadbeef in rY.

>
> The tricky thing is inline asm. I am debating myself whether we
> should align with GCC or not to allow 'rX =3D=3D 0xdeadbeef' in inline as=
m.
> in llvm the inline asm code is processed at MC level (after all
> optimizations).
> Ultimately I aligned with GCC for compatibility. My first response to thi=
s
> thread is to only allow in range or INT_MIN and INT_MAX.
>
> So the question is that we treat inline asm as the pure encoding
> or it should have other semantics.

I think both compilers should error (or warn) when imm32 doesn't fit
into int_min/max, because the asm code for
if r1 =3D=3D 0xdeadbeef goto l0_%=3D;
will not do what the author expects.

