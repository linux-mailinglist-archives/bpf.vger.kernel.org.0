Return-Path: <bpf+bounces-54891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D64A7592A
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D301888A14
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BB175D53;
	Sun, 30 Mar 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5EsSbjL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516801714AC
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327539; cv=none; b=txXUu+4i8wQin2psAX0dGrtt61EHwfeTD0GZE3UStD71zTl5q4/KmZwCMq9qE/KPj5CkNoAvkQpJ9P4XHMD0v/uZHVKoikyc4SoLqLX0O/sI5s+X3gqlwXWV7vJwLbXZxHoqOGQSRQWvmrr+tB7h/OxDqffLyePvtPM4isnIu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327539; c=relaxed/simple;
	bh=YiHNtfz0tq2wuQOuRP5C5M+9WMXZgb+359E3DHp0Tzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYRxaVf0g9WZfDKgoSHfvECQe8CJ6w8QG8hEvS043d/Y960GlQ6IuewrRw/40GDRJlhe3c3dVAiG++8jjcTNJWK/j1v1RmwDynhLFxVA2lrhEJYoaqB4QFfpuVQf3p14GkjaCKorDI4yclZDdCtwBzgEdGghaA+CSA0mVNEQJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5EsSbjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D27C4CEEE
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743327538;
	bh=YiHNtfz0tq2wuQOuRP5C5M+9WMXZgb+359E3DHp0Tzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n5EsSbjLkH5OIMoN5SS0SSgpzfSNXQpkXEIV00XjI9P5By+qCftCqGBYBtPoip/F/
	 MJ5N3SuIbGe5j8kuXS9Muu0uirqMSzoN06Q6mJt3rbPu71zOvwtxyuGpaYM7qRntJS
	 nqFuVlAKNO9LFkxLdiQy+gmPfbz44jxunIOjEnJMhdBpdjIof5/CaecbZgOlVBKBbT
	 mTGoH0kV+43LKbQUmnn384fDibWbigudxLjCyDIIwuM9hwaB/XAMpbGvAxzmAGWbSz
	 ApVk1chVQ6bcLm82TYr82vK6tYZSpsBvxYpkSa/ueyrbfunYXDRW9Egl9yK+FMgLDr
	 RCRjsX0vthvaw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so642967566b.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 02:38:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRl8dtoR3KnrlYrmb35WLhI2aCckmWO1KO7MX/s37cgt25c1hUlFkW+UiU3mHKYpaBXNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHuIPyoXOggrIOoNlPadro+hAOeMPgkqnhQ9wSWUu3tZJIBh8
	EtTAqXW3uRXrqmeNBd8qSvvIeu6WL8hw1I5oZzBeOaDJT9f9sx8Sp/Mul0RcaEq+oPotgFsSLmT
	qWzWGrUo3H0nuY+9WLLtnAfZpDTM=
X-Google-Smtp-Source: AGHT+IESIcekoCRsxAVSswSRDsHykLeiuXZzWYETBwqeAWCbtTzrXXuzbjfzbeCoJNecUysmsIdfrQ5Msqm7Cn9v27U=
X-Received: by 2002:a17:907:7e82:b0:ac2:b086:88d5 with SMTP id
 a640c23a62f3a-ac738a668e8mr566588366b.18.1743327537433; Sun, 30 Mar 2025
 02:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315080320.4193821-1-hengqi.chen@gmail.com>
In-Reply-To: <20250315080320.4193821-1-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Mar 2025 17:38:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64upy2ebqBZzY6LUD3crH+6PvKTDSq_K73zXc4u+fe6Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoVLmHAKN8k0vtQddR4iDAtz0Z5JfkEv4z-gHNzZ-YkzAh57hDrRxJVFMs
Message-ID: <CAAhV-H64upy2ebqBZzY6LUD3crH+6PvKTDSq_K73zXc4u+fe6Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix off by one error in build_prologue()
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, yangtiezhu@loongson.cn, 
	Vincent Li <vincent.mc.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sat, Mar 15, 2025 at 4:03=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Vincent reported that running BPF progs with tailcalls on LoongArch
> causes kernel hard lockup. Debugging the issues shows that the JITed
> image missing a jirl instruction at the end of the epilogue.
>
> There are two passes in JIT compile, the first pass set the flags and
> the second pass generates JIT code based on those flags. With BPF progs
> mixing bpf2bpf and tailcalls, build_prologue() generates N insns in the
> first pass and then generates N+1 insns in the second pass. This makes
> epilogue_offset off by one and we will jump to some unexpected insn and
> cause lockup. Fix this by inserting a nop insn.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcall=
s")
> Reported-by: Vincent Li <vincent.mc.li@gmail.com>
> Closes: https://lore.kernel.org/loongarch/CAK3+h2w6WESdBN3UCr3WKHByD7D6Q_=
Ve1EDAjotVrnx6Or_c8g@mail.gmail.com/
> Closes: https://lore.kernel.org/bpf/CAK3+h2woEjG_N=3D-XzqEGaAeCmgu2eTCUc7=
p6bP4u8Q+DFHm-7g@mail.gmail.com/
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/include/asm/inst.h | 5 +++++
>  arch/loongarch/net/bpf_jit.c      | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 3089785ca97e..d61b356170fe 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -695,6 +695,11 @@ static inline void emit_jirl(union loongarch_instruc=
tion *insn,
>         insn->reg2i16_format.rj =3D rj;
>  }
>
> +static inline void emit_nop(union loongarch_instruction *insn)
> +{
> +       insn->word =3D INSN_NOP;
> +}
> +
>  #define DEF_EMIT_REG2BSTRD_FORMAT(NAME, OP)                            \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
>                                enum loongarch_gpr rd,                   \
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ea357a3edc09..2346c0b55043 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -142,6 +142,8 @@ static void build_prologue(struct jit_ctx *ctx)
>          */
>         if (seen_tail_call(ctx) && seen_call(ctx))
>                 move_reg(ctx, TCC_SAVED, REG_TCC);
> +       else
> +               emit_insn(ctx, nop);
>
>         ctx->stack_size =3D stack_adjust;
>  }
> --
> 2.43.5
>
>

