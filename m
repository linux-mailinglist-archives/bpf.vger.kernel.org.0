Return-Path: <bpf+bounces-45914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF69DF966
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 04:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016EF16141F
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A52EAE4;
	Mon,  2 Dec 2024 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKex6dYq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F22AEF1;
	Mon,  2 Dec 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109051; cv=none; b=K2OQgHq+UmenrOORvlNrKXSnHF+2PE+72MAysJe5uEl6k3C22qVMdxr1Jo/r3oZ0459CSnAuk9ukftokENdklg7ivpe7wSOjkiGQtiWdsoXUvzdOJLIm8Noz+0Mni93UrOx1xlWj1Ef+diWflgxc9uh+vP6Ctw5wXL53JqlVFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109051; c=relaxed/simple;
	bh=4XyFDRbVvmJSF1QRYsOt/gpEGnbXB3GeEqqGoMOpJOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNLyi+2sKwxvd418D+0UcrDOgtJxz2gbCIztqsUukOZGcpDd7oxlw3BcdPL4IynWAX1ab6SAc9U8ayp1H7oUSnfK5PvV/80PJcqyi+RE0EVruPTb90c6/JxSm7gXv6igPx+n3GAPAL7auI1diDhnwfrRLYSXAAWx69he8NBN0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKex6dYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0B3C4CEDB;
	Mon,  2 Dec 2024 03:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733109050;
	bh=4XyFDRbVvmJSF1QRYsOt/gpEGnbXB3GeEqqGoMOpJOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IKex6dYqkpBN7x9zdYhIRTBYJVw24opx92utxZufd5rAfg38vCRx2ZxNVv9LETOet
	 k3DHNfkp7neNILLdHg0ussVzwQ/xYo8nVWHq43N1jo+QlyIQfA0aKiAY5rF5weBvaK
	 9nU5DNpdL5kjQn7d7hMzW8q805ko/iTKbLFFc+aoGvwSMzTe7FEL5eYlGZWrc1W6ZK
	 H7pN9+oKN80ALsGVlWZQburnkG7B9XGiTZkDhu++FSlyJREUk5aeKY7sl9zehLuFYH
	 EjrsxMAAkyg7p1RIaj8ETddLoto1/xJ3QufCoPQJrTub/v/lUUaKPqZGVjCea21Ngl
	 t+yYvL4IvEPDA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa549d9dffdso615327866b.2;
        Sun, 01 Dec 2024 19:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsm7w0TL0DmsWHmtoSZH6Frm0dccsVjL4dLYesLdGy7qPSM42mJ3JUv2d9EcIi/b7kZww=@vger.kernel.org, AJvYcCWjSNxy59P3QtwRY8UdxR7RbeJrpyChvqmaEILbyzUUhzdWJ/k6J3uO8TKtemtHy3+O6446c67XPy4CAGio@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8HHE/C470r263JOiqTgvCoZvuhLGBv2XzhToOGa9Cbqq6ybB
	6/VshuzozIdzvd5IkWA/HIwkrmCDcdjOs4Z+acNqohjRxqfjDkUcN4JvXFg/6bN9TFQRu4Bpntf
	ywbXpt5AQKAt5VVsYzYHBVLrOw5M=
X-Google-Smtp-Source: AGHT+IFjInjkFGajQNtWr0S9onhEuE+lYbF17ih6fnW6hmwyEAtvN4I4W+umi88/W37zb1UVxumfo89hliQ6/ptrW/8=
X-Received: by 2002:a17:906:2192:b0:aa5:2855:7817 with SMTP id
 a640c23a62f3a-aa580f72e6fmr1525197466b.35.1733109049111; Sun, 01 Dec 2024
 19:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128061110.5204-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241128061110.5204-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Dec 2024 11:10:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TZ0n5JKFvisFXwvYRkdTSDzHi=jhvD0fxnn+XKtvG+A@mail.gmail.com>
Message-ID: <CAAhV-H5TZ0n5JKFvisFXwvYRkdTSDzHi=jhvD0fxnn+XKtvG+A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Adjust the parameter of emit_jirl()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Thu, Nov 28, 2024 at 2:11=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The branch instructions beq, bne, blt, bge, bltu, bgeu and jirl belong
> to the format reg2i16, but the sequence of oprand is different for the
> instruction jirl, adjust the parameter of emit_jirl() to make it more
> readable correspond with the Instruction Set Architecture manual.
>
> Here are the instruction formats:
>
>   beq     rj, rd, offs16
>   bne     rj, rd, offs16
>   blt     rj, rd, offs16
>   bge     rj, rd, offs16
>   bltu    rj, rd, offs16
>   bgeu    rj, rd, offs16
>   jirl    rd, rj, offs16
>
> Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-E=
N.html#branch-instructions
> Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> This patch is based on the following commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D73c359d1d356
>
>  arch/loongarch/include/asm/inst.h | 12 +++++++++++-
>  arch/loongarch/kernel/inst.c      |  2 +-
>  arch/loongarch/net/bpf_jit.c      |  6 +++---
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 944482063f14..3089785ca97e 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -683,7 +683,17 @@ DEF_EMIT_REG2I16_FORMAT(blt, blt_op)
>  DEF_EMIT_REG2I16_FORMAT(bge, bge_op)
>  DEF_EMIT_REG2I16_FORMAT(bltu, bltu_op)
>  DEF_EMIT_REG2I16_FORMAT(bgeu, bgeu_op)
> -DEF_EMIT_REG2I16_FORMAT(jirl, jirl_op)
> +
> +static inline void emit_jirl(union loongarch_instruction *insn,
> +                            enum loongarch_gpr rd,
> +                            enum loongarch_gpr rj,
> +                            int offset)
> +{
> +       insn->reg2i16_format.opcode =3D jirl_op;
> +       insn->reg2i16_format.immediate =3D offset;
> +       insn->reg2i16_format.rd =3D rd;
> +       insn->reg2i16_format.rj =3D rj;
> +}
>
>  #define DEF_EMIT_REG2BSTRD_FORMAT(NAME, OP)                            \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 3050329556d1..14d7d700bcb9 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -332,7 +332,7 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum l=
oongarch_gpr rj, int imm)
>                 return INSN_BREAK;
>         }
>
> -       emit_jirl(&insn, rj, rd, imm >> 2);
> +       emit_jirl(&insn, rd, rj, imm >> 2);
>
>         return insn.word;
>  }
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index dd350cba1252..ea357a3edc09 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -181,13 +181,13 @@ static void __build_epilogue(struct jit_ctx *ctx, b=
ool is_tail_call)
>                 /* Set return value */
>                 emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
, 0);
>                 /* Return to the caller */
> -               emit_insn(ctx, jirl, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO=
, 0);
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
>         } else {
>                 /*
>                  * Call the next bpf prog and skip the first instruction
>                  * of TCC initialization.
>                  */
> -               emit_insn(ctx, jirl, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO=
, 1);
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3=
, 1);
>         }
>  }
>
> @@ -904,7 +904,7 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                         return ret;
>
>                 move_addr(ctx, t1, func_addr);
> -               emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
>                 move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
>                 break;
>
> --
> 2.42.0
>

