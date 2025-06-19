Return-Path: <bpf+bounces-61088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E8AE0A2A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC54E3A8DBC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E133085DB;
	Thu, 19 Jun 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3uM+RO9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A052E628;
	Thu, 19 Jun 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346100; cv=none; b=uVtpNBT52pSKfYauW/4r+Z7c7bpKW79fc/Y2BiPSuJFzKSzUvgPq2J2Cadn2SaVerB7VlOJ//httixkqoNZWl9D2m72lpnALJUK8YJOXfXbBWLcJPQetB8ybY3ri0x8G2N/l/Zm8nbgs4UnOBL3Lnzg3W7UkWLrsYOY5vzuWBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346100; c=relaxed/simple;
	bh=IBdeGa1U8TuUchxzsvRO7qA6eHVSDVNim0wcrdeNMfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTY0yQAASMFJHovOoUjPgKZpX4CTe7FOfh8eXAh6s06/qKxTVGdDsQ6C7DA11DAVvcoA7cWhU7Rr13su1hNntA73LIf/Cn4GNjeSlKkpinxUQdVH6A29wIRejbRDsEgd+oYYKCcLT7+e+VIZ9csmJhkn16Dg6vJ8cNrgFIJh040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3uM+RO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4AAC4CEF2;
	Thu, 19 Jun 2025 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346100;
	bh=IBdeGa1U8TuUchxzsvRO7qA6eHVSDVNim0wcrdeNMfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3uM+RO9Qiajcj3cbxslNvw4+0eGRAaBQR5FdHFXZQlXvv59wTC776tPD6UIo8WPh
	 lovvrOZZRF8NJ11fKOYmAH4jANnFypedF1P+O50p/bxOlnNOW1iQq8KTx4ZFLgmtQf
	 008Upasmgx4/mobLkaWmw56oP4J+Jo0KK9XjTJ0kk4OL1GFeXGvr2fZzXHf0X3YsNh
	 66xX5HJa3WLkugC1hSMVIwtWTfRnNnzkXeHVOuBrzXnre6EgbYcN1J0tLThV318tJi
	 5ib0u/nICthgQoBgOvVWO2DPFr2Mac2zwpOgb0j6ir9VDPF+1iAJjnAq4tSPBf7gmb
	 QLJ6BP64fnFQw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so1753126a12.3;
        Thu, 19 Jun 2025 08:14:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN6z7utUxyBtna1JmLPP61ZeJ/LcnAcF5Yq0Y4jzJNiMlDLF2UugDHBysez/cSf5/Ujck=@vger.kernel.org, AJvYcCXB9htmHIuVRrRM9WhOA3sJVShVrntrdKvwX8hR8NcXazDsRp5LON9CYZiN6cByUKS2OEJl2PiUOegHxnN0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFv8VraV57dvsbLJzqVLMrbiYbUZePO+62nWa8qTbNe5owTEpK
	DgF9MhSj8RJhXdygUCHgOHI8r9+WK/vALEbgL1jwklktKYSMIxPCjDwDtIdr2TB1VfVnaD9LYVe
	tmIHE2Xgkk6SwGd8ykSA9O6RztXv52KM=
X-Google-Smtp-Source: AGHT+IGNuewH/yn7Y6NsMIUk7rodKyLo9wuc+RDEaO77sr8hKurxZDoSPM8QxKQQYvi/GTNuqTayViX+Hq8SdzEozuw=
X-Received: by 2002:a05:6402:1d4d:b0:607:ea0c:6590 with SMTP id
 4fb4d7f45d1cf-608d09e303cmr18529770a12.24.1750346098356; Thu, 19 Jun 2025
 08:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618105048.1510560-1-duanchenghao@kylinos.cn> <20250618105048.1510560-3-duanchenghao@kylinos.cn>
In-Reply-To: <20250618105048.1510560-3-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 23:14:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42ofJ_z1Pj4OVwpROzOODqdBMg+ChJ9ULguVkOfLQkkg@mail.gmail.com>
X-Gm-Features: AX0GCFvCWmaDlT5i9aUgfnYqdGQK1YqVU2zM6ddnVh_qCXLgwqPBxd73dFXlSFc
Message-ID: <CAAhV-H42ofJ_z1Pj4OVwpROzOODqdBMg+ChJ9ULguVkOfLQkkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] LoongArch: BPF: Add bpf_arch_text_poke support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

On Wed, Jun 18, 2025 at 6:51=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Implement the bpf_arch_text_poke function for the LoongArch
> architecture. On LoongArch, since symbol addresses in the direct mapping
> region cannot be reached via relative jump instructions from the paged
> mapping region, we use the move_imm+jirl instruction pair as absolute
> jump instructions. These require 2-5 instructions, so we reserve 5 NOP
> instructions in the program as placeholders for function jumps.
I think this patch is a preparation for the 3rd one, then I think
bpf_arch_text_copy and bpf_arch_text_invalidate should also be moved
here because they are the same class as bpf_arch_text_poke.


Huacai

>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4a..24332c596 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2022 Loongson Technology Corporation Limited
>   */
> +#include <linux/memory.h>
>  #include "bpf_jit.h"
>
>  #define REG_TCC                LOONGARCH_GPR_A6
> @@ -1359,3 +1360,64 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>         return true;
>  }
> +
> +static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ip, u64 ta=
rget)
> +{
> +       s64 offset =3D (s64)(target - ip);
> +
> +       if (offset && (offset >=3D -SZ_128M && offset < SZ_128M)) {
> +               emit_insn(ctx, bl, offset >> 2);
> +       } else {
> +               move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> +               emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_=
call)
> +{
> +       struct jit_ctx ctx;
> +
> +       ctx.idx =3D 0;
> +       ctx.image =3D (union loongarch_instruction *)insns;
> +
> +       if (!target) {
> +               emit_insn((&ctx), nop);
> +               emit_insn((&ctx), nop);
> +               return 0;
> +       }
> +
> +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOON=
GARCH_GPR_ZERO,
> +                                 (unsigned long)ip, (unsigned long)targe=
t);
> +}
> +
> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> +                      void *old_addr, void *new_addr)
> +{
> +       u32 old_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
> +       u32 new_insns[5] =3D {[0 ... 4] =3D INSN_NOP};
> +       bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> +       int ret;
> +
> +       if (!is_kernel_text((unsigned long)ip) &&
> +               !is_bpf_text_address((unsigned long)ip))
> +               return -ENOTSUPP;
> +
> +       ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call);
> +       if (ret)
> +               return ret;
> +
> +       if (memcmp(ip, old_insns, 5 * 4))
> +               return -EFAULT;
> +
> +       ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&text_mutex);
> +       if (memcmp(ip, new_insns, 5 * 4))
> +               ret =3D larch_insn_text_copy(ip, new_insns, 5 * 4);
> +       mutex_unlock(&text_mutex);
> +       return ret;
> +}
> --
> 2.43.0
>
>

