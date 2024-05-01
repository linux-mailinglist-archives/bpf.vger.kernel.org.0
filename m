Return-Path: <bpf+bounces-28374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5E8B8E5A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3A2812AB
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43BDDAB;
	Wed,  1 May 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM1BnQVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE6D52F;
	Wed,  1 May 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581596; cv=none; b=Psahx+cvlOJTP6ilvmz/jfY9lUrSEETDCqYoh3JhscusSoqF++ehGed+gU4aAFwgru7A8jZMT7EvGTFWY5/cplBh/HKsQQ/YyIyBHptB6ITGwq3foxnMDPsF9nPzGIzpzE4FfP1TRtew8kNeVttQ4keZR0q3nFvPMioqahMTNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581596; c=relaxed/simple;
	bh=ZYdw7J+75stn6+70oRojpwEq9vNtS8PPF98TkRRX+GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZ9pwLKrobLHHRW1IMNfwrDV5owAtBOtwA/6PuUuLvM4DEPpyBDR2PvBnnEBbriX6DCDIsi5FhWjiWhlF7RZWc3ou7AHJc+uZSxTKh70r05Cp+rqOwrCgvWh9JEB+eh82+ILVTrvV8RQjbqRRI1YPPhRVR16rbw02OeCB3LchMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM1BnQVT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so5523347a12.3;
        Wed, 01 May 2024 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714581594; x=1715186394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atYkm9Bv1WMdbMlr9D036H2OQplmZ+kaXzy56fOOTJk=;
        b=fM1BnQVTw0yF7Ej1tlPf1Q0hlEwGceAd356U+ynYaG55OAVPmOIBKrunHlgePwunaM
         UDtbl9jlDNf2gTNSw+NzPt3MQef04XVX4bZu72pNdrkZ80u8THejIz1VFS+yGU+tMqfr
         QuOPrrXRxpjUbTtzw2I6Yl3dBGM+GXYcMSVP2k4KKpgMAYgJJkMpaNGGsCmlU3IP0pRY
         YFjvLBYBI1VMon8cT4m5bdBrnCYN6LrWkt9jUp4sFuqnJpgmkQxwj3KUkQatw2eFIzeV
         9lgu5cC7Y7TjxymGUhKVmqMD8nofor3QuICZv1JGQQgRCrMavT6O7g2KW/z3CKXRoim5
         +Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581594; x=1715186394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atYkm9Bv1WMdbMlr9D036H2OQplmZ+kaXzy56fOOTJk=;
        b=oLqyPhiz2TIzmbtUEu/3s2043smr5+sF4OAx/ILlvyqlDUEh2tYG6h2uWdFlfnXWA5
         2MndXdM8sBL6H1sNKqwNg/0mNBBUQ7ywpxHLBHLGRD0Et0I8eqKDOB1VQWYAldLyBt2L
         5MJ6Va4meEe7PEpAN7qRQ16E9KF067S0ojNdm1YqcNdzDhGczq+h6nHFCdo+BibBZ+Mh
         i2329MA/PnOzgGGWpp+GXXPkGW5jy4rSLeh6Rm2Kb6fb6njOV8QFgdtVEt9SMS+FKPJN
         GCf7+A2zsdddANnMpJATtQS49BVQ6/Sn6gcb5gNdAYlo8pQD1mCagng/S0opTuGPRur3
         vlcw==
X-Forwarded-Encrypted: i=1; AJvYcCXcgag4V+o8k0xxgpGueTjUdH3wckUFQscdtgizkXGVCF5uyiAmDtLhGmpM/oTKm0OMqmccPjoIX6Om1GPfhya3XgU9W7QjJmuCWGBsHCo6gvPJViHfKACqj4rqhUamtQv3
X-Gm-Message-State: AOJu0YwWH0wW7teQVKfjKE3oU+VVLqZZTggZcm7kHEzYwPBSwal06YJc
	grh8v6Iw2tgA1p+HMzq2rKp/Lx1z7K9DA+lAJvorAlRcy8/2Qe8SL9yROt2dfP6aZdMC1Tld6QT
	Hd07OOuyjfYv5O3p31ISkvbl2kH0=
X-Google-Smtp-Source: AGHT+IH9qVt/8p/ZzN/bKmmQQSZrFPfCdVcRg2/ZJQ47K9yCmaJysyJJWGSuxK+4eLs3XYg++rCaK5WXpND3Jm9u4Iw=
X-Received: by 2002:a17:90a:af8f:b0:2b2:7e94:c5e0 with SMTP id
 w15-20020a17090aaf8f00b002b27e94c5e0mr3030873pjq.20.1714581594182; Wed, 01
 May 2024 09:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430175834.33152-1-puranjay@kernel.org> <20240430175834.33152-2-puranjay@kernel.org>
In-Reply-To: <20240430175834.33152-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 09:39:42 -0700
Message-ID: <CAEf4Bzb2NY+wuK159Xb8F9Nu4CuVoYJ6WWR3_0LeTAi+zONewQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] riscv, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:58=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> RISC-V uses generic per-cpu implementation where the offsets for CPUs
> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
> the address of the task_struct in TP register. The first element in
> task_struct is struct thread_info, and we can get the cpu number by
> reading from the TP register + offsetof(struct thread_info, cpu).
>
> Once we have the cpu number in a register we read the offset for that
> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
> offset to the destination register.
>
> To measure the improvement from this change, the benchmark in [1] was
> used on Qemu:
>
> Before:
> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
> arr-inc        :    1.121 =C2=B1 0.004M/s
> hash-inc       :    0.681 =C2=B1 0.052M/s
>
> After:
> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
> arr-inc        :    1.366 =C2=B1 0.006M/s
> hash-inc       :    0.676 =C2=B1 0.001M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 15e482f2c657..99d7006f1420 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -12,6 +12,7 @@
>  #include <linux/stop_machine.h>
>  #include <asm/patch.h>
>  #include <asm/cfi.h>
> +#include <asm/percpu.h>
>  #include "bpf_jit.h"
>
>  #define RV_FENTRY_NINSNS 2
> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>                         emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>                         emit_mv(rd, RV_REG_T1, ctx);
>                         break;
> +               } else if (insn_is_mov_percpu_addr(insn)) {
> +                       if (rd !=3D rs)
> +                               emit_mv(rd, rs, ctx);
> +#ifdef CONFIG_SMP
> +                               /* Load current CPU number in T1 */
> +                               emit_ld(RV_REG_T1, offsetof(struct thread=
_info, cpu),
> +                                       RV_REG_TP, ctx);
> +                               /* << 3 because offsets are 8 bytes */
> +                               emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
> +                               /* Load address of __per_cpu_offset array=
 in T2 */
> +                               emit_addr(RV_REG_T2, (u64)&__per_cpu_offs=
et, extra_pass, ctx);
> +                               /* Add offset of current CPU to  __per_cp=
u_offset */
> +                               emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1,=
 ctx);
> +                               /* Load __per_cpu_offset[cpu] in T1 */
> +                               emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
> +                               /* Add the offset to Rd */
> +                               emit_add(rd, rd, RV_REG_T1, ctx);

is this the right level of code indentation?

> +#endif
>                 }
>                 if (imm =3D=3D 1) {
>                         /* Special mov32 for zext */
> @@ -2038,3 +2057,8 @@ bool bpf_jit_supports_arena(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +       return true;
> +}
> --
> 2.40.1
>

