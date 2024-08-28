Return-Path: <bpf+bounces-38231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B976961C16
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF2284DAD
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE664131BDD;
	Wed, 28 Aug 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7sB7T3O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AD13B2AF
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811882; cv=none; b=t8Ek6G2Tv4QAvlJKxOOI9PxsHgh6X0/YxzSM825DC2Kzr/tZlTJjZStyW7CYj7cIHMfZRBciXNjIlriZmEEoI0+E/Lr33YEzTFBbhn+imgpS5ETAkby0bFhSF76519m5ENW3lGIBoHm0o0R7PM39RNwewd3NjkuVuXVfA17B9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811882; c=relaxed/simple;
	bh=GJX4/7ngL698+q6W0LDU4PFY9kmi8KKCyy/I/APbYAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd00cQLZcnGbvfc2wULKTLUC8EMrfg7hOiYLT5ZSQzwpP4OE/r/C1HdHgmQJoMM6m4q24bAemfdE606+g93SLS5TvBLa+7f5ZuFbMSniDbyXxZR91S6r6MzMpYsyA/H3QT1F/0pDitUwTQYw7tQJtcqVigXrBhXci+yTV/J+Mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7sB7T3O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371aa511609so3075149f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724811879; x=1725416679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo8ON+Ge2UdtbQ+IQPTCj3PMqC/izvDBVlgYfUGXYMY=;
        b=e7sB7T3OtAk20W3VmSTe00GbJfWH2Au1yNn7pFZJBX86+TjS8uXZAmoL+WTxtmGu22
         YZaIiR0SmYqRW61v6wFKDLvP5YNhpssReuwsX1dR922sYsZaa2gJYhRlesdujGRsw5wD
         o2KpLEMQ9jnIn0MM6qnK6TGCllZZLr7XIbLNHyYY2MPlK91KZIE9gjNIc3lbhUOt/8SV
         KySft9tdkVPBVLr778vYw+52iiPDHzgxV0HB7sk/JqFG+6BxtTPkzL1ltKy2g7N8/NVf
         qOqeAywW4oFaMMwf9uzwucgf/o+2e73H3YiMQRLFNR1jXCJwJW8zJTkTKyxIp7fRZZzK
         +bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811879; x=1725416679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo8ON+Ge2UdtbQ+IQPTCj3PMqC/izvDBVlgYfUGXYMY=;
        b=m94KHXkko4NhY0pflEx5kdb6tfdpXVHlyNcrL9ex8g7H2AAtmRleFAzPGLCzrSR7sI
         AWtLeNL5Qjp0FUQHYnyAlMLY2UW5HnT7KXOGHEPaMC+h2zToDQPKSoqCbnFqe2jBBCUV
         tKARQ3478IbgVH+ZAIbRe2JBuXgKLEHITfbuhygjB1mLSw3vEk1cihy+hAJFHOrQeImU
         Cur6F1NqjMjSITbp2cEUZCsqLclYo3tbvlRUg15Qe3eUkYqScsA9q7j4hifNASqymefo
         nm2kSq3Yl5tXF/Wu24eg5P0/Hq6gn2cQnWqTYMh/YR4c8MWsbHU2GocjJ7DPp3nCeMdS
         MSww==
X-Gm-Message-State: AOJu0YzY76+l89Cvvqxt2ovXulN9dVYPQWWK5CnbHZLFbjEQDyoWVsRu
	278gTHMrrg5DN5oLtSgL2+FQWoNro6lQUjOwGGdfqTjlY1QFYHGZrS312wOIhgJtpFBxuAm22e2
	d8os3pLHNCBwzFfb+1cslX8d3is4=
X-Google-Smtp-Source: AGHT+IGPC6paeE/FgSeGvg2i5aFlsJDKWZZLUFq55J7Qdx2wEKVJnVkq7TrleWySJ9CGXsQdGV2yRaBUt0q5DWoKu+c=
X-Received: by 2002:adf:ffc9:0:b0:368:37d7:523f with SMTP id
 ffacd0b85a97d-3749680da36mr256848f8f.13.1724811878395; Tue, 27 Aug 2024
 19:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
In-Reply-To: <20240825200406.1874982-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Aug 2024 19:24:26 -0700
Message-ID: <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 1:04=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Daniel Hodges reported a jit error when playing with a sched-ext
> program. The error message is:
>   unexpected jmp_cond padding: -4 bytes
>
> But further investigation shows the error is actual due to failed
> convergence. The following are some analysis:
>
>   ...
>   pass4, final_proglen=3D4391:
>     ...
>     20e:    48 85 ff                test   rdi,rdi
>     211:    74 7d                   je     0x290
>     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     289:    48 85 ff                test   rdi,rdi
>     28c:    74 17                   je     0x2a5
>     28e:    e9 7f ff ff ff          jmp    0x212
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
> and insn at 0x28e is 5-byte jmp insn with offset -129.
>
>   pass5, final_proglen=3D4392:
>     ...
>     20e:    48 85 ff                test   rdi,rdi
>     211:    0f 84 80 00 00 00       je     0x297
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     28d:    48 85 ff                test   rdi,rdi
>     290:    74 1a                   je     0x2ac
>     292:    eb 84                   jmp    0x218
>     294:    bf 03 00 00 00          mov    edi,0x3
>
> Note that insn at 0x211 is 5-byte cond jump insn now since its offset
> becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
> At the same time, insn at 0x292 is a 2-byte insn since its offset is
> -124.
>
> pass6 will repeat the same code as in pass4. pass7 will repeat the same
> code as in pass5, and so on. This will prevent eventual convergence.
>
> Passes 1-14 are with padding =3D 0. At pass15, padding is 1 and related
> insn looks like:
>
>     211:    0f 84 80 00 00 00       je     0x297
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     24d:    48 85 d2                test   rdx,rdx
>
> The similar code in pass14:
>     211:    74 7d                   je     0x290
>     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     249:    48 85 d2                test   rdx,rdx
>     24c:    74 21                   je     0x26f
>     24e:    48 01 f7                add    rdi,rsi
>     ...
>
> Before generating the following insn,
>   250:    74 21                   je     0x273
> "padding =3D 1" enables some checking to ensure nops is either 0 or 4
> where
>   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>   nops =3D INSN_SZ_DIFF - 2
>
> In this specific case,
>   addrs[i] =3D 0x24e // from pass14
>   addrs[i-1] =3D 0x24d // from pass15
>   prog - temp =3D 3 // from 'test rdx,rdx' in pass15
> so
>   nops =3D -4
> and this triggers the failure.
> Making jit prog convergable can fix the above error.
>
> Reported-by: Daniel Hodges <hodgesd@meta.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 47 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 074b41fafbe3..ec541aae5d9b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -64,6 +64,51 @@ static bool is_imm8(int value)
>         return value <=3D 127 && value >=3D -128;
>  }
>
> +/*
> + * Let us limit the positive offset to be <=3D 124.
> + * This is to ensure eventual jit convergence For the following patterns=
:
> + * ...
> + * pass4, final_proglen=3D4391:
> + *   ...
> + *   20e:    48 85 ff                test   rdi,rdi
> + *   211:    74 7d                   je     0x290
> + *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
> + *   ...
> + *   289:    48 85 ff                test   rdi,rdi
> + *   28c:    74 17                   je     0x2a5
> + *   28e:    e9 7f ff ff ff          jmp    0x212
> + *   293:    bf 03 00 00 00          mov    edi,0x3
> + * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-12=
5)
> + * and insn at 0x28e is 5-byte jmp insn with offset -129.
> + *
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
> + * Note that insn at 0x211 is 5-byte cond jump insn now since its offset
> + * becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
> + * At the same time, insn at 0x292 is a 2-byte insn since its offset is
> + * -124.
> + *
> + * pass6 will repeat the same code as in pass4 and this will prevent
> + * eventual convergence.
> + *
> + * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 byt=
es)
> + * cycle in the above. Let us limit the positive offset for 8bit cond ju=
mp
> + * insn to mamximum 124 (0x7c). This way, the jmp insn will be always 2-=
bytes,
> + * and the jit pass can eventually converge.
> + */

je<->jmp

It can be je/je too, no?

so 128 - 4 instead of 128 - 3 ?

> +static bool is_imm8_cond_offset(int value)
> +{
> +       return value <=3D 124 && value >=3D -128;

the other side needs the same treatment, no ?

> +}
> +
>  static bool is_simm32(s64 value)
>  {
>         return value =3D=3D (s64)(s32)value;
> @@ -2231,7 +2276,7 @@ st:                       if (is_imm8(insn->off))
>                                 return -EFAULT;
>                         }
>                         jmp_offset =3D addrs[i + insn->off] - addrs[i];
> -                       if (is_imm8(jmp_offset)) {
> +                       if (is_imm8_cond_offset(jmp_offset)) {
>                                 if (jmp_padding) {
>                                         /* To keep the jmp_offset valid, =
the extra bytes are
>                                          * padded before the jump insn, s=
o we subtract the
> --
> 2.43.5
>

