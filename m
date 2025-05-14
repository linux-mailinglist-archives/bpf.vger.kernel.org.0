Return-Path: <bpf+bounces-58233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31143AB75D9
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EE3B810A
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617628D8D2;
	Wed, 14 May 2025 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGuRB6YG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7441DB363
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250722; cv=none; b=hm9ulaSjCuq1p0PZf4yyQrZgNlbIZ6k1fq6OdOz0mYgSu5Ej9j3YYseL4fibo1W3HEOdfr4X7XDMcplPyYkmUQ1wZfaPJA8undlb35ua7+r2eGXRCxo7s64ij5bYBEPxZdQxNrhvjbtZWYaBaKPjtzratIx7yuQ5CQiucjqyHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250722; c=relaxed/simple;
	bh=SofASvq5DlyWDsL4LmFrnECp9G0MVxxayP/ubHy1TuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1iUYsaBmeeifoeVezAlkQ1Bwh43m3ReOIiDs7Xdj8efrSpzV8ufQK6I3MO7Pm7D1ebUWXn1rsnBgI49P/5Digu3iDk6lYovfY2TOL9LZ4t0DA8hIrPOOdRHuHSzzQYkIJPidgSMMoPf/Bi9+EgXPh0QXRMx2+gPrT3Z97uGC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGuRB6YG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so1849125e9.3
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747250719; x=1747855519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvuVdYpt6RVLqlvYI3R39KELBizHVpZiUrJcz1Dx5JI=;
        b=fGuRB6YGvcmMGjQTqyFtd1peJBLhPwuJvodxQEwRiAYC3Ghcb013Q2xpoeNz7kW9Sv
         iWbZlpRtmJJH+mqgycTna345weZRafsAbdn40iX8vojh9YfJyBuKQd8Y1MIvjg2g3tBh
         HxBIn7OFoRqc0559wiQoJukfTuNRNkARdwzmYlb3MJmEJT3HRjEeLQVH0zaFaq3FLkQ8
         hNkdVSxeH2baH+iXHZmveMDs6JcQJRju8rZ2WnmbbzlO8vpFXJWCwRxSAoJdXUrLT/p2
         A31qIElvAzHPor/+kw6PCA/BBlttos1F7hPPdrhN2Pw3cpoovN6mLM4Nz45+Jmo/B20I
         IRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747250719; x=1747855519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvuVdYpt6RVLqlvYI3R39KELBizHVpZiUrJcz1Dx5JI=;
        b=cJZaCdgwMMS2OzsuN3cwdB6P35kBCU/Mfbf1iBkEPc0mZOkf9gAj0RWKPmnP4ZU/Dz
         25/KPMVlfLcdx9wavDEOzzORJ/5e7PepNUYfWmz1h9Ulq1pySw2ZEMrCWdX45THajA2L
         7UyQSWs8ubbIC3TkhkOA4x3NLoiLiRrf6McdQpxzRdQvtpvH7OAR6/TZMEmH7GUGAAIb
         gA+PbaqVCbQIPrr9DiuW4U40S0EWRxCkdd56qnWCzFCEX4XpVqFh/k3BBB2qIos55Dyt
         KboZ5DL2M07KoTnkeOeaMQkUc1eoOx+wVXLNgdzLz6HLfsMAR15eP9zCqZVinJYQrfdD
         WnXw==
X-Gm-Message-State: AOJu0YzFpTAN5mIKGtfQTihh3+C1pMnT/uhM2kYHB0e5hkl5U1I7xRHy
	7g9GeEut0CoYujUZxTL4sGXKfnyWX6FkZx5DVsJMMFFgEzNsZQuBndlU8DYHRJmsu14jZ7kmGBh
	5zKd/zp9bnj4LLCgezTHCPCuVPN14m21u
X-Gm-Gg: ASbGncvbed7IeZrOxnOUVGsO9SpLsLA3RVLCkysbfKgL2jS3W1pYF3RTJWbWMHVg1gO
	Zw4Ugbg0WUTIAJqor7RrIADp+wywMH99cHftsQK2u/mBa5xE2bOoib5IwThBwYfJ4uggzutRSpA
	8axIxOqR0OaU3Fs5wMNW0+jlGZCeXFZ6vvTC2uUvdRN7xFdVZLD4Mw1O0uRgaysA==
X-Google-Smtp-Source: AGHT+IF6vExrBBNdcLy5V5NOTsMf01AJhf+fH754i3GdZii0whddNXmGhaHwHqx+AT6LHwHMFdg20Zzt3GX4wb75ojg=
X-Received: by 2002:a5d:526e:0:b0:3a1:f6fd:da50 with SMTP id
 ffacd0b85a97d-3a34991f240mr3352971f8f.46.1747250718499; Wed, 14 May 2025
 12:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514175415.2045783-1-memxor@gmail.com>
In-Reply-To: <20250514175415.2045783-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 May 2025 12:25:06 -0700
X-Gm-Features: AX0GCFtSv628FEkSdqjBQIPbkZbYR-dEqBBH3z7SDKun08sQl4eHH-H4EjiTv9g
Message-ID: <CAADnVQLtAEJrp5TRg0QpA8nZBn=kT17C0E64AHhm4+fYi8Xm5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, x86: Add support for signed arena loads
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 10:54=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>  static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int=
 off)
>  {
> @@ -2010,13 +2037,19 @@ st:                     if (is_imm8(insn->off))
>                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>                 case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
>                 case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
>                 case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
>                 case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
>                         start_of_ldx =3D prog;
>                         if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> -                               emit_ldx_r12(&prog, BPF_SIZE(insn->code),=
 dst_reg, src_reg, insn->off);
> +                               if (BPF_MODE(insn->code) =3D=3D BPF_PROBE=
_MEM32SX)
> +                                       emit_ldsx_r12(&prog, BPF_SIZE(ins=
n->code), dst_reg, src_reg, insn->off);
> +                               else
> +                                       emit_ldx_r12(&prog, BPF_SIZE(insn=
->code), dst_reg, src_reg, insn->off);
>                         else
>                                 emit_stx_r12(&prog, BPF_SIZE(insn->code),=
 dst_reg, src_reg, insn->off);
>  populate_extable:

Luckily I didn't trust CI and decided to test it manually:

./test_progs-cpuv4 -t arena_spin
[   68.977751] mem32 extable bug
[   68.984388] mem32 extable bug
[   69.182864] mem32 extable bug
[   69.190027] mem32 extable bug
[   69.408629] mem32 extable bug
[   69.415651] mem32 extable bug
libbpf: prog 'prog': BPF program load failed: -EINVAL
libbpf: prog 'prog': -- BEGIN PROG LOAD LOG --
Func#1 ('arena_spin_lock_slowpath') is safe for any args that match
its prototype
calling kernel functions are not allowed in non-JITed programs
processed 408 insns (limit 1000000) max_states_per_insn 1 total_states
42 peak_states 42 mark_read 7
-- END PROG LOAD LOG --

The verifier error is wrong.
The prog failed to JIT, but jit_subprog didn't return EFAULT
and the verifier tried to guess the error with:
        if (has_kfunc_call) {
                verbose(env, "calling kernel functions are not allowed
in non-JITed programs\n");
                return -EINVAL;
        }

and guessed it wrong,
but that is a separate issue.

The patch needs this fix:

index 70152200cc8c..a66c288dd812 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21188,6 +21188,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
                        if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
                            (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
                             BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32 ||
+                            BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32SX =
||
                             BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX))
                                num_exentries++;
                        if ((BPF_CLASS(insn->code) =3D=3D BPF_STX ||


Before I tested it I thought we can apply this patch without
a new selftest, but that would have been a mistake.
We would have landed a half working sign extending loads :(

Please respin with the selftest.

pw-bot: cr

