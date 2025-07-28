Return-Path: <bpf+bounces-64506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB0B13958
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890323B9C71
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D2254876;
	Mon, 28 Jul 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt1A3njm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3824DD18;
	Mon, 28 Jul 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700166; cv=none; b=mx2MEY7d3Ce28eV02kEqquoILc1OewU0snx57XgxdyJ+DlAmB2lui6cM/8+tnnXOC8dUiglPw8TSZvkRcWXqk0QOTLXIwnIJnca7KRwxzyQbrkdHrOcB2LA2r2DTDdhV0QTYFt5U212iXmWhVVj4WZMM6jE8lW7lxFgGX4qTkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700166; c=relaxed/simple;
	bh=YGleY+BTac5R9ZvEJZtBBPaOkPgNhDZgmq3t8OTsKFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUYkZrWZYVRvZ1SdmffdIxediFw9vSaiIyeYX5yvzhvysBd8ALzplU5f9DsQW2rReKUrKky6i+sJfaCDRTWZVX4zJ6nvUXO41G/OH//yHJfGK6f+K6NkJgpwvhy0ib5nHW23bWIWlpBzwlEGSnj58ldTZ+k47wzuqPz2JAcTyLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt1A3njm; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41cd87eff4dso2745888b6e.2;
        Mon, 28 Jul 2025 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753700164; x=1754304964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWL1xu7848dX7PG0tXdUa0Ie1a9/Le0YZIKNkJPCEek=;
        b=Zt1A3njmWGLLFqFhdEM2dgpa5zYUIAL3qu5MJ15L8LJvO2tevlIOzjaZcdYTGHqEhh
         XB5QSCm10v0/nUCInCO7HWjz+VncwPJFLqvvfTZgPOykOHeUAITJmxjgvJoh6V2NXLoZ
         19M22iW1ezKGHz0L/5Hq5qZFg6Tv/J5nzOp6aqimb972FFn//N8Y4fI7/RyHsgIN2d+m
         vONnZjoXT/ycEuz1408Jz1yO3Vigfhe3TWkxfPZONtzWRbJWUhCaOWjseE/pQnzvv5uQ
         kRkJUa3yEetIchuGYRb+P+DrD2wH98xDNX9A+mxdI7U9+53S+k8GBbCbu2f5SdzvcNKU
         Ox6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700164; x=1754304964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWL1xu7848dX7PG0tXdUa0Ie1a9/Le0YZIKNkJPCEek=;
        b=bTwDlA0LPxZaoP2YQCjD5yBYm9kr/v3Cc/cYwCVl1pjFAIQ3KkAmutuwLStneWCC84
         AvWhkyhYMhEIw1sP9anzqRYC7lrBPya2sX2xMVcipZq261V6rKLl/N2K7r6udq+tc4ns
         ULc400yAxR62un0HpO2PeOtJeEMZxDhEu2cD3FhktawabokVSYdT/0VMy0fNNQr1hz/3
         gXtq70ZRs71XOw5Fibwe48Mmwz8QbpGk9PEIr1O4aqTWB095PKNuqbkeg3GZjjft6iZo
         8TLYxqaGmo0InIxFSlx+ZpWFc451SXmRglOINzOC6veH+AsLNKTW/+pm5PmrHtx3lGl7
         eGUg==
X-Forwarded-Encrypted: i=1; AJvYcCV88wSFlk+VdhWu5SIUdyRL1R4LPVEiChIuj8MbdKFExHGR+t0dCnsBah07ST/W4RyyUdw=@vger.kernel.org, AJvYcCXfpVIo76/J6lLkJfBuFCzWd2aMVvSfbK6zp9/CKXJTRetsz63W9fPG5/syCh59XD6+Az1O3zW/J0Fw4LE9@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLWKvwBbFC2YcshL9sD2yL+/LUiGNhiI5myX1O2aG6M/TF+T0
	xZykX0GehyJxGOrcCznPO194iefg2Gl7GyL0xjC4D21AlixY5koA9qYRhHeGVfio340Gplx179i
	ZEv9qnNZmSDeAwROyEKqmfAsTkbhUdU8=
X-Gm-Gg: ASbGnct/VJ+t3IrxD9YLcHEjJAMzIWcgvF7qOOmbukEYKxHeD+G12gnndlb8Zn1oGdU
	QUM43746E5r+vmJ2NlrNB40as7W8RYI688Y6wjkN2JFGEgXT+dGT5hyT53GdVnMMinwsSgw+Xb4
	GqtSgJXNdBL4Skyok5U4npCJpQlMr/XLhrTJlsY71EInlmtRDXB16jWuSodrQiL2NXPYRgOGn4c
	lfI2QY=
X-Google-Smtp-Source: AGHT+IGARqiTWQTPDrhfm8cwnocnmRpP9f+DBFyblxvpuVCcS8LapX/WdvEguEftXmefu5EyqAQ3TzJmMAo2H63z4jI=
X-Received: by 2002:a05:6808:308b:b0:41c:45e4:6c4c with SMTP id
 5614622812f47-42bb9e01655mr6828338b6e.39.1753700163813; Mon, 28 Jul 2025
 03:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn> <20250724141929.691853-6-duanchenghao@kylinos.cn>
In-Reply-To: <20250724141929.691853-6-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 28 Jul 2025 18:55:52 +0800
X-Gm-Features: Ac12FXzP_XUDs2XhXziuxv8yd0WOVmTcIPNArR6GVihQbnffbAuPDxb0KuZCKMA
Message-ID: <CAEyhmHQKBQbidX_SpUF1ZPv7vkkhSR_UuRvxznyb6y5GYQS3qw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] LoongArch: BPF: Add struct ops support for trampoline
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:22=E2=80=AFPM Chenghao Duan <duanchenghao@kylino=
s.cn> wrote:
>
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Use BPF_TRAMP_F_INDIRECT flag to detect struct ops and emit proper
> prologue and epilogue for this case.
>
> With this patch, all of the struct_ops related testcases (except
> struct_ops_multi_pages) passed on LoongArch.
>
> The testcase struct_ops_multi_pages failed is because the actual
> image_pages_cnt is 40 which is bigger than MAX_TRAMP_IMAGE_PAGES.
>
> Before:
>
>   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
>   ...
>   WATCHDOG: test case struct_ops_module/struct_ops_load executes for 10 s=
econds...
>
> After:
>
>   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
>   ...
>   #15      bad_struct_ops:OK
>   ...
>   #399     struct_ops_autocreate:OK
>   ...
>   #400     struct_ops_kptr_return:OK
>   ...
>   #401     struct_ops_maybe_null:OK
>   ...
>   #402     struct_ops_module:OK
>   ...
>   #404     struct_ops_no_cfi:OK
>   ...
>   #405     struct_ops_private_stack:SKIP
>   ...
>   #406     struct_ops_refcounted:OK
>   Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 71 ++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 24 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ac5ce3a28..6a84fb104 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1603,6 +1603,7 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> +       bool is_struct_ops =3D flags & BPF_TRAMP_F_INDIRECT;
>         int ret, save_ret;
>         void *orig_call =3D func_addr;
>         u32 **branches =3D NULL;
> @@ -1678,18 +1679,31 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
>
>         stack_size =3D round_up(stack_size, 16);
>
> -       /* For the trampoline called from function entry */
> -       /* RA and FP for parent function*/
> -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> -       emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> -
> -       /* RA and FP for traced function*/
> -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_=
size);
> -       emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_s=
ize);
> +       if (!is_struct_ops) {
> +               /*
> +                * For the trampoline called from function entry,
> +                * the frame of traced function and the frame of
> +                * trampoline need to be considered.
> +                */
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 -16);
> +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8=
);
> +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0=
);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP,=
 16);
> +
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 -stack_size);
> +               emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, s=
tack_size - 8);
> +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, s=
tack_size - 16);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP,=
 stack_size);
> +       } else {
> +               /*
> +                * For the trampoline called directly, just handle
> +                * the frame of trampoline.
> +                */
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 -stack_size);
> +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, s=
tack_size - 8);
> +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, s=
tack_size - 16);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP,=
 stack_size);
> +       }
>

The diff removes code added in patch 4/5, this should be squashed to
the trampoline patch if possible.

>         /* callee saved register S1 to pass start time */
>         emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> @@ -1779,21 +1793,30 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
>
>         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
>
> -       /* trampoline called from function entry */
> -       emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_s=
ize);
> +       if (!is_struct_ops) {
> +               /* trampoline called from function entry */
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, s=
tack_size - 8);
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, s=
tack_size - 16);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 stack_size);
> +
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8=
);
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0=
);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 16);
>
> -       emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> +               if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +                       /* return to parent function */
> +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARC=
H_GPR_RA, 0);
> +               else
> +                       /* return to traced function */
> +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARC=
H_GPR_T0, 0);
> +       } else {
> +               /* trampoline called directly */
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, s=
tack_size - 8);
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, s=
tack_size - 16);
> +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 stack_size);
>
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> -               /* return to parent function */
>                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
> -       else
> -               /* return to traced function */
> -               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0=
, 0);
> +       }
>
>         ret =3D ctx->idx;
>  out:
> --
> 2.25.1
>

