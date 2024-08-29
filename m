Return-Path: <bpf+bounces-38424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0481964CBA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8724AB21EB7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF11B4C3F;
	Thu, 29 Aug 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz98aj9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193E146A96
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952469; cv=none; b=uSt4ZZgIwFvI4a1QyTcXENIoKLqVLscoX53+2z7I0WUYQpct9ydy7Ve9eT5DBNdl+4hZKRibZOUiD0MtTiU6QicpDbLWLsbw0OQQ3ViUujvMkxKm6wiRHRxyg5HJYzXdh6V3i3irl8/1HChT2ChM2xmQVnm9P0g+44FEOD+47Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952469; c=relaxed/simple;
	bh=BKytvb1j8IL1Mldj+LG3tR/GdyXgX06YKPXlyziJ2yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgItvM/vLkFSuHSS8IcESWll6uDL98x3tWv9Q0sW0Ek77sQrxCGgWQirxALhkfAeWoo3Tj5gL9kCa5cQvgEOFrTGB7xc5hSbVzOKgSFTSpzqi1Ln/iOhDZDmpvgnOec7+xO/RNg/akrmyKnR75eiDaegv6K3GlPMsmHxsWIjR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz98aj9k; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so541403a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724952467; x=1725557267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtG0gCm0PBdh6rtWfUeSyaPx8Kmo5C2EDfe5C4mi5h0=;
        b=Bz98aj9k07yyBq3Uz56+c8TDkVWQMtApWZUGxXW+TWdDMlxHob8Mu3tM6sjrsT1ds4
         XfT/TeKz0dmOnnTeghLZ3LOcdxspCVuAR1DECxL9PMfgj/4m+UsagrJVGyJTBRltcMX9
         6otOonVeeueYyGHFLmMP53oBsEMefZqU1wO3319k2oSp9Vhd3NG2oICUkquGKIXllgNI
         /JeGKTvzwDnQyrCOMSdmt0SvSB0l/5iQbhzwJU4nvAQBtbx/VpSk2StynW/N7aIhtrcM
         vw391nWLSDoZcwYD+kt1qxq6oQP481RIxZ+ombpRwa4vtMauY0rARyAcj4byahiX3Qse
         xZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952467; x=1725557267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtG0gCm0PBdh6rtWfUeSyaPx8Kmo5C2EDfe5C4mi5h0=;
        b=cwhTGBOoadfamd/HbNgHGhYVdNlDnuKy6ravyqzKW893TiWlzG9FoXF6RsMCTbagMo
         joOOjbDm/qub23819pDszduo5LH+lUG3RdUZ98i3CjR1IU6buIiMJiDHmCWlxX62jdcz
         XapU8o2ViOJIQ0O7woJVlAt1u0g5dxONKiYbfi1vtKBnRclC/eblcoQqcHlOJKEveN/C
         qts81YfW6LsHmX4ORDmIjzqbZl3bAPx9dsIIrOktO617YqZJ1ovUl1vyxCg0xUVrE0wF
         lEKyCFlts2dZQ7J5GrdA9CzAoWDbQxJLTQCuobWwMCbCsAVCm/6tB1fyhNPxOcRvxynq
         ER9A==
X-Gm-Message-State: AOJu0YzjHxy+1Xj92zqt1uUzcTLNLcjzcRd/jTFwcZPuKPuX0UfD4J5l
	wrLd2wgoWCN5N7ba6315x3X6v4qGVs30eFFr271wsyBlX6uRaMfDkC/jkR9JGLic/rCMmKJu9L4
	9agYhTZEm9bTIGOJk6f748eJ5n/4peQ==
X-Google-Smtp-Source: AGHT+IFCacgp1GQy4zZ4jU3Y4kzN+th6zy25l5xlHOJ6I1oftxor78AQsxwOshFV9lU+jJbIhLLjfvkNV+RTckr6TOE=
X-Received: by 2002:a17:90b:20c:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2d8564cb343mr3467883a91.31.1724952466668; Thu, 29 Aug 2024
 10:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAEf4BzbCZ3daW_yo14E1fG_x=ciMggAuAMBSHs5E6iq9zE8NAQ@mail.gmail.com> <0ad6d232-5385-40e4-b138-1b9ec383884a@linux.dev>
In-Reply-To: <0ad6d232-5385-40e4-b138-1b9ec383884a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Aug 2024 10:27:34 -0700
Message-ID: <CAEf4BzaarnU2g9LVP1qfRLDia+owzyQdonkkKcRpb9m4bcr37A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:50=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 8/27/24 4:44 PM, Andrii Nakryiko wrote:
> > On Sun, Aug 25, 2024 at 1:04=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Daniel Hodges reported a jit error when playing with a sched-ext
> >> program. The error message is:
> >>    unexpected jmp_cond padding: -4 bytes
> >>
> >> But further investigation shows the error is actual due to failed
> >> convergence. The following are some analysis:
> >>
> >>    ...
> >>    pass4, final_proglen=3D4391:
> >>      ...
> >>      20e:    48 85 ff                test   rdi,rdi
> >>      211:    74 7d                   je     0x290
> >>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >>      ...
> >>      289:    48 85 ff                test   rdi,rdi
> >>      28c:    74 17                   je     0x2a5
> >>      28e:    e9 7f ff ff ff          jmp    0x212
> >>      293:    bf 03 00 00 00          mov    edi,0x3
> >>
> >> Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125=
)
> >> and insn at 0x28e is 5-byte jmp insn with offset -129.
> >>
> >>    pass5, final_proglen=3D4392:
> >>      ...
> >>      20e:    48 85 ff                test   rdi,rdi
> >>      211:    0f 84 80 00 00 00       je     0x297
> >>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >>      ...
> >>      28d:    48 85 ff                test   rdi,rdi
> >>      290:    74 1a                   je     0x2ac
> >>      292:    eb 84                   jmp    0x218
> >>      294:    bf 03 00 00 00          mov    edi,0x3
> >>
> >> Note that insn at 0x211 is 5-byte cond jump insn now since its offset
> >> becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
> >> At the same time, insn at 0x292 is a 2-byte insn since its offset is
> >> -124.
> >>
> >> pass6 will repeat the same code as in pass4. pass7 will repeat the sam=
e
> >> code as in pass5, and so on. This will prevent eventual convergence.
> >>
> >> Passes 1-14 are with padding =3D 0. At pass15, padding is 1 and relate=
d
> >> insn looks like:
> >>
> >>      211:    0f 84 80 00 00 00       je     0x297
> >>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >>      ...
> >>      24d:    48 85 d2                test   rdx,rdx
> >>
> >> The similar code in pass14:
> >>      211:    74 7d                   je     0x290
> >>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >>      ...
> >>      249:    48 85 d2                test   rdx,rdx
> >>      24c:    74 21                   je     0x26f
> >>      24e:    48 01 f7                add    rdi,rsi
> >>      ...
> >>
> >> Before generating the following insn,
> >>    250:    74 21                   je     0x273
> >> "padding =3D 1" enables some checking to ensure nops is either 0 or 4
> >> where
> >>    #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >>    nops =3D INSN_SZ_DIFF - 2
> >>
> >> In this specific case,
> >>    addrs[i] =3D 0x24e // from pass14
> >>    addrs[i-1] =3D 0x24d // from pass15
> >>    prog - temp =3D 3 // from 'test rdx,rdx' in pass15
> >> so
> >>    nops =3D -4
> >> and this triggers the failure.
> >> Making jit prog convergable can fix the above error.
> >>
> >> Reported-by: Daniel Hodges <hodgesd@meta.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c | 47 +++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 46 insertions(+), 1 deletion(-)
> >>
> > Probably a stupid question. But instead of hacking things like this to
> > help convergence in some particular cases, why not just add a
> > condition that we should stop jitting as soon as jitted length stops
> > shrinking (and correct the comment that claims "JITed image shrinks
> > with every pass" because that's not true).
> >
> > We have `if (proglen =3D=3D oldproglen)` condition right now. What will
> > happen if we just change it to `if (proglen >=3D oldproglen)`? That
> > might be sup-optimal for these rare non-convergent cases, but that
> > seems fine. We can of course do one extra pass to hopefully get back
> > the second-to-last shorter image if proglen > oldproglen, but that
> > seems excessive to me.
>
> We need convergence. Looks at some comments below:
>
> + * pass5, final_proglen=3D4392:
> + *   ...
> + *   20e:    48 85 ff                test   rdi,rdi
> + *   211:    0f 84 80 00 00 00       je     0x297
> + *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> + *   ...
> + *   28d:    48 85 ff                test   rdi,rdi
> + *   290:    74 1a                   je     0x2ac
> + *   292:    eb 84                   jmp    0x218
> + *   294:    bf 03 00 00 00          mov    edi,0x3
>
> Without convergence, you can see je/jmp target may not be correct.
>

I see, thanks. As I said, probably was a stupid question, I didn't
realize that do_jit() can generate invalid image.

This whole guessing of acceptable range of relative offset still seems
like a fragile game (what if you have few instructions that expand and
then 124 bound isn't conservative enough anymore). I was wondering if
there is some more generic solution where we can mark jump
instructions that went from shorter to longer, and if that happened,
on subsequent passes don't try to shorten them.

Again, I have no clue how actual code in JIT works and what are all
the nuances, so feel free to ignore me completely, I won't be offended
:)

> >
> >
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 074b41fafbe3..ec541aae5d9b 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -64,6 +64,51 @@ static bool is_imm8(int value)
> >>          return value <=3D 127 && value >=3D -128;
> >>   }
> >>
> >> +/*
> >> + * Let us limit the positive offset to be <=3D 124.
> >> + * This is to ensure eventual jit convergence For the following patte=
rns:
> >> + * ...
> >> + * pass4, final_proglen=3D4391:
> >> + *   ...
> >> + *   20e:    48 85 ff                test   rdi,rdi
> >> + *   211:    74 7d                   je     0x290
> >> + *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >> + *   ...
> >> + *   289:    48 85 ff                test   rdi,rdi
> >> + *   28c:    74 17                   je     0x2a5
> >> + *   28e:    e9 7f ff ff ff          jmp    0x212
> >> + *   293:    bf 03 00 00 00          mov    edi,0x3
> >> + * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (=
-125)
> >> + * and insn at 0x28e is 5-byte jmp insn with offset -129.
> >> + *
> >> + * pass5, final_proglen=3D4392:
> >> + *   ...
> >> + *   20e:    48 85 ff                test   rdi,rdi
> >> + *   211:    0f 84 80 00 00 00       je     0x297
> >> + *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> >> + *   ...
> >> + *   28d:    48 85 ff                test   rdi,rdi
> >> + *   290:    74 1a                   je     0x2ac
> >> + *   292:    eb 84                   jmp    0x218
> >> + *   294:    bf 03 00 00 00          mov    edi,0x3
> >> + * Note that insn at 0x211 is 5-byte cond jump insn now since its off=
set
> >> + * becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
> >> + * At the same time, insn at 0x292 is a 2-byte insn since its offset =
is
> >> + * -124.
> >> + *
> >> + * pass6 will repeat the same code as in pass4 and this will prevent
> >> + * eventual convergence.
> >> + *
> >> + * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 =
bytes)
> >> + * cycle in the above. Let us limit the positive offset for 8bit cond=
 jump
> >> + * insn to mamximum 124 (0x7c). This way, the jmp insn will be always=
 2-bytes,
> >> + * and the jit pass can eventually converge.
> >> + */
> >> +static bool is_imm8_cond_offset(int value)
> >> +{
> >> +       return value <=3D 124 && value >=3D -128;
> >> +}
> >> +
> >>   static bool is_simm32(s64 value)
> >>   {
> >>          return value =3D=3D (s64)(s32)value;
> >> @@ -2231,7 +2276,7 @@ st:                       if (is_imm8(insn->off)=
)
> >>                                  return -EFAULT;
> >>                          }
> >>                          jmp_offset =3D addrs[i + insn->off] - addrs[i=
];
> >> -                       if (is_imm8(jmp_offset)) {
> >> +                       if (is_imm8_cond_offset(jmp_offset)) {
> >>                                  if (jmp_padding) {
> >>                                          /* To keep the jmp_offset val=
id, the extra bytes are
> >>                                           * padded before the jump ins=
n, so we subtract the
> >> --
> >> 2.43.5
> >>

