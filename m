Return-Path: <bpf+bounces-63407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D3B06CC2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C12F50330F
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515727281D;
	Wed, 16 Jul 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhqpdT7/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB627253356;
	Wed, 16 Jul 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640958; cv=none; b=plZREXGHtv8cVsxEj16WSq5VhusAo936rMc+YrtiUxYhLhyj1U9E7NDdRBbjhKEYi+xPOwOSsY1styzRODHko3hDThCztAEAEXh3Izgc+zRYbCia6/CVlr92AXbsr1BK44VTk/vz6pxIavuC8l5Yq3Uzwk+x4GDkOO0J+xdrWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640958; c=relaxed/simple;
	bh=1pR1E55zun5lglAmSHkjS2gCrBlSJFSmYM9iinOmiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIVREB52Txk2sxZqlooKnGScIq36wccPvDTy0ybJWibUNLBZG86OqXVHoiqX6+oKsXkA9sf1S1LaPPB1jex/O7QjWTeaOjfPGh4XDmvAClIz+IgJkxhmTJDPjm72GUf/sC+sRyWYvg4fI1EGI2chG+AIiX9EqONow27amumKjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhqpdT7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E125C4CEF8;
	Wed, 16 Jul 2025 04:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752640956;
	bh=1pR1E55zun5lglAmSHkjS2gCrBlSJFSmYM9iinOmiZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KhqpdT7/1lFai7hkzu2pPXjxJFklNqeRbrb4j7hZSJ//qpqkf3+a7ZOzSE2nmCLps
	 HLo7C1MOzETP3m1XuwLxK3lObCZ3DBk2dvsBXm6zYme3sbr669oJhC54kOyZVUdfsH
	 GBq/oXA016qD4f52ALgB2re8aQcxugRVR+rycoeVt/YnRb+f+SkH45fKQ35FUQZAh9
	 DxVDrjUcAsbCSwv9z/5XY3ZNQqeMP1lIqASDbXh9tosprmLcHmPU4vtahkh9ed2jJ3
	 26pyOJGSXPHUaGM5nydpMZ663AYasZHxQOCAVcdu7MySL3PkvwHK4hhHwxNgeTryGA
	 iNPJ87KNFw9qw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so1106733a12.1;
        Tue, 15 Jul 2025 21:42:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV95/w2SilB1J1NhV1yn8wszc7IR6W9kzdmfd3Ljhin8L34FlX+N27kEQRolpHpZcCqjOE=@vger.kernel.org, AJvYcCVPd4bJFcMEJlwSiwJ5Vz+dRf4H88lQc4G79LCrzAHVraSI7D7QXYXXfjJjAnADzw0e/LT+4rPiz/w5WITz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kfTQbK80MqYj7exCydHyH6hPwsA/wi6I0tOLok9Wc5eNn39j
	G/LyUGsOe/QTg6TkIK1miRuJaAx8f4HS0htsdhy2eSBTwqpQ0LXPOGKDMJDtS6nuy6Lf9EHE4Ol
	MI44gEVkQZ0vKDmBVYXyPV2/xV7Nxnjk=
X-Google-Smtp-Source: AGHT+IEZNW+n00+K7uVNM+OZwoDDbXDoMNYRzuhptwtAjZOOG063z2K3qGwwJAmw+El0tyGOntyvygHR815Q4+7Y7Us=
X-Received: by 2002:a05:6402:1ed1:b0:601:470b:6d47 with SMTP id
 4fb4d7f45d1cf-61282b2a14amr1535459a12.1.1752640954706; Tue, 15 Jul 2025
 21:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716043915.15034-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250716043915.15034-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 16 Jul 2025 12:42:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5yPPcU03MGenKDH=sUTkmMPnsGj13zkLA1h-uHVMcHOQ@mail.gmail.com>
X-Gm-Features: Ac12FXzj3GhQNWPXapF0gcLr8457R1lphz5A9CDkZWOdOqbXfOy88UTG6EOYEEQ
Message-ID: <CAAhV-H5yPPcU03MGenKDH=sUTkmMPnsGj13zkLA1h-uHVMcHOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] LoongArch: BPF: Add struct ops support for trampoline
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

I hope this patch can be squashed to V4 of chenghao's patchset, as a
co-developer.

Huacai

On Wed, Jul 16, 2025 at 12:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
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
>
> This is a RFC patch, based on 6.16-rc6 and the following series:
>
> [PATCH v3 0/5] Support trampoline for LoongArch
> https://lore.kernel.org/loongarch/20250709055029.723243-1-duanchenghao@ky=
linos.cn/
>
>  arch/loongarch/net/bpf_jit.c | 71 ++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 24 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 6820558afce5..7663b84a4ff1 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1599,6 +1599,7 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> +       bool is_struct_ops =3D flags & BPF_TRAMP_F_INDIRECT;
>         int ret, save_ret;
>         void *orig_call =3D func_addr;
>         u32 **branches =3D NULL;
> @@ -1674,18 +1675,31 @@ static int __arch_prepare_bpf_trampoline(struct j=
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
>         /* callee saved register S1 to pass start time */
>         emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> @@ -1772,21 +1786,30 @@ static int __arch_prepare_bpf_trampoline(struct j=
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
> 2.42.0
>

