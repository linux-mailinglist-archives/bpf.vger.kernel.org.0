Return-Path: <bpf+bounces-38224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA1961AC0
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540691C22130
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC801D47A8;
	Tue, 27 Aug 2024 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY9b7rGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747519A281
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802285; cv=none; b=Rtlaa3DZEvzsFZz9qn3GqUf5EYqHPAVM6XREg4A7GGYgT3uodTWf6thki0/Q1wogMFBpN5fTOn5FmJSJgZmDsJTRqARxAPkuPKBcynrpkAhdZRLrvtrElRxVm2bhowFvAz2/fYhoQdOW2PjIau2Gs0IfOCNiJU6jov8CJBlAoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802285; c=relaxed/simple;
	bh=DqHhRwti1lycao6iS65kuaRNQXSDgunvQVFH/Xzq4Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADPPEi39+A3yBkLi+6KI/nko8KZWwcColGo50rRxIfppDEACLG7MxBujJAGRqKu2bTXtqdSGs+FThVsR4iuAH0pyxmVVdhaFjml4GQIN/wkKlhjdLNcCShPMZbzuWFdRiT/4HCnsWumd5JcdZ9w6H78td0WtA5VvFWQsV6VDfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY9b7rGw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso4719610a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724802283; x=1725407083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzdAzi3/Jmw6Gr7BweUgSZNvRXlZTq1wiFuwsF2gfNs=;
        b=OY9b7rGw/enGcI2sR4dEariV5m9OXETmOaEmNAMiFzf00vxCOJNglry7UL3ooYdl3C
         kR8k86suksZG9+aOtq8hwVpNfKiybKzJ26uGmNYYKbq0Zaqy9sBzsb41T89+j5ibvpca
         4XW7TxX7GiF+En7DpThy/C0G9ORre9qLmteFStkLGjIuGsGFfZXVubFfWHijm6q5cfHn
         GIj7FqUkJ9/au5inuuuWp3sVQ4JV+exG3OInSfjg9+8xVjvmTlNqMuB8EQ1LZG51r+Du
         Y7Mc33gsEFjHDvYv1QI+f0Zcd3sumLpz2Ucj25n2/HRw2UwS2bJ9WKY/DQTgTwNmYE4X
         IcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802283; x=1725407083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzdAzi3/Jmw6Gr7BweUgSZNvRXlZTq1wiFuwsF2gfNs=;
        b=Jh219DC0X6s+nDV61WM6068A2h6EJRO9ivyBKrkzMhxckjn36/X1OxvlY9YV52/6tS
         3D1GJXHVPaLExGCi4AkNw331QvJ/6gyrhvPBhuZpdwIObyp24kt1goH36xGRWRnX7Kzc
         mJ3i6yCL592tc0L8X+eXCHUycrJ2jSBtmX5D6rSUAwoATLVJ1jZ84VTIhDmcpi3KRQ/1
         UxhtmhFHzhSpaIm9FO3DR2sj2zWXnFZ73oK/QVLl6mFaHbHZYtSVYtznGqXnJQdL845T
         UHDlE5VLpI4uGX0ELWblltg9TyeOep2rVjaUzexSsSuZ0mT3gbT1fEuEPtYcFOtcZ08e
         Lqyg==
X-Gm-Message-State: AOJu0YyN1nq5iOoaTUEFhH2K+WCh/rFMk4R7PerUshj8QiheWLqYAx4p
	UB8gg0yZQb0KfsjeIpSACdcpcarpu3S+vVjFX82F/4Tx7G88cwg25n37COGW7QDxDSZokrCj0Zi
	LE5SK3JsnfWft0CopDd0c/RN9eD4=
X-Google-Smtp-Source: AGHT+IERpU7hLzafijVmuu9rEwKAje8qtyKt1FqjYMc2OrRa7/7omxDUdf7IhJ1du9Cy8lbaDUHmrGn0xeEpH0VMLrQ=
X-Received: by 2002:a17:90b:390e:b0:2ca:5ec8:576c with SMTP id
 98e67ed59e1d1-2d646bcd7c5mr15662786a91.5.1724802283204; Tue, 27 Aug 2024
 16:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
In-Reply-To: <20240825200406.1874982-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 16:44:31 -0700
Message-ID: <CAEf4BzbCZ3daW_yo14E1fG_x=ciMggAuAMBSHs5E6iq9zE8NAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
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

Probably a stupid question. But instead of hacking things like this to
help convergence in some particular cases, why not just add a
condition that we should stop jitting as soon as jitted length stops
shrinking (and correct the comment that claims "JITed image shrinks
with every pass" because that's not true).

We have `if (proglen =3D=3D oldproglen)` condition right now. What will
happen if we just change it to `if (proglen >=3D oldproglen)`? That
might be sup-optimal for these rare non-convergent cases, but that
seems fine. We can of course do one extra pass to hopefully get back
the second-to-last shorter image if proglen > oldproglen, but that
seems excessive to me.


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
> +static bool is_imm8_cond_offset(int value)
> +{
> +       return value <=3D 124 && value >=3D -128;
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

