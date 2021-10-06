Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3695F4248D1
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhJFVY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 17:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239680AbhJFVYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 17:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1DA1610EA
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633555352;
        bh=HXPGA87ikNQuRSY9vVvChxjosVmuW30IuNRAuuHOyaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lCR5VpIv5PQjJc7ca8Ju6GToIN5lNM6z4O/D5UwHGe2GwFSeunGrlZ4CZeahDs/Jk
         1RvpNMEUMp+Wklsn7HLCfwUQAFSJRhH8otYcPlqPr35ukGNUm7oigTda7RALo2xByb
         Sdy7ltl8kyU+fs7a8Zub8tjAei5T9TQQZT6d7SaDsMtEVT8dkIogZv4cFKUWK9WY2V
         3dAcqNWa8YE5XbTp3uTxCfAJN01ZciyP6nBrn9SjYCqvVH9pyzYytn240ht1GYcRQV
         AUuOq7AQ4wUDDzuqTASAW7kVa2Iy1Qkb1YX16eT1VwTBYKeRe9n1ih25Sx9NOmHJjn
         lYjbHzICVFHEQ==
Received: by mail-lf1-f43.google.com with SMTP id b20so16248294lfv.3
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 14:22:32 -0700 (PDT)
X-Gm-Message-State: AOAM533RJuCj1rWusKpG4oMi65b3VdL9apo6W9m0A6cOdZvSij0XcBKX
        /8QhB2MefmCg2D846B19aq1ChK8WbXJTL3RutOM=
X-Google-Smtp-Source: ABdhPJwq5JkqrrByy9lEygZXdXhK5m+vEhDpkW2B8rl/eW9d9nC6pJ/lob3WOlDVMxE66cQCFFblS3kU2/7+vr2LWZw=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr372465lfi.598.1633555350949;
 Wed, 06 Oct 2021 14:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211006194135.608932-1-jmeng@fb.com>
In-Reply-To: <20211006194135.608932-1-jmeng@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 6 Oct 2021 14:22:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6UZgqao6UbYsZz-bzBd8ZrV5Kbaya2iD4Rxko+LMo4bQ@mail.gmail.com>
Message-ID: <CAPhsuW6UZgqao6UbYsZz-bzBd8ZrV5Kbaya2iD4Rxko+LMo4bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x64: Factor out emission of REX byte in more cases
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 12:43 PM Jie Meng <jmeng@fb.com> wrote:
>
> Introduce a single reg version of maybe_emit_mod() and factor out
> common code in more cases.
>
> Signed-off-by: Jie Meng <jmeng@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/x86/net/bpf_jit_comp.c | 67 +++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5a0edea3cc2e..e474718d152b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -721,6 +721,20 @@ static void maybe_emit_mod(u8 **pprog, u32 dst_reg, u32 src_reg, bool is64)
>         *pprog = prog;
>  }
>
> +/*
> + * Similar version of maybe_emit_mod() for a single register
> + */
> +static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
> +{
> +       u8 *prog = *pprog;
> +
> +       if (is64)
> +               EMIT1(add_1mod(0x48, reg));
> +       else if (is_ereg(reg))
> +               EMIT1(add_1mod(0x40, reg));
> +       *pprog = prog;
> +}
> +
>  /* LDX: dst_reg = *(u8*)(src_reg + off) */
>  static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>  {
> @@ -951,10 +965,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                         /* neg dst */
>                 case BPF_ALU | BPF_NEG:
>                 case BPF_ALU64 | BPF_NEG:
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_ALU64);
>                         EMIT2(0xF7, add_1reg(0xD8, dst_reg));
>                         break;
>
> @@ -968,10 +980,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                 case BPF_ALU64 | BPF_AND | BPF_K:
>                 case BPF_ALU64 | BPF_OR | BPF_K:
>                 case BPF_ALU64 | BPF_XOR | BPF_K:
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_ALU64);
>
>                         /*
>                          * b3 holds 'normal' opcode, b2 short form only valid
> @@ -1059,11 +1069,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                          */
>                         EMIT2(0x31, 0xd2);
>
> -                       if (is64)
> -                               EMIT1(add_1mod(0x48, src_reg));
> -                       else if (is_ereg(src_reg))
> -                               EMIT1(add_1mod(0x40, src_reg));
>                         /* div src_reg */
> +                       maybe_emit_1mod(&prog, src_reg, is64);
>                         EMIT2(0xF7, add_1reg(0xF0, src_reg));
>
>                         if (BPF_OP(insn->code) == BPF_MOD &&
> @@ -1084,10 +1091,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>
>                 case BPF_ALU | BPF_MUL | BPF_K:
>                 case BPF_ALU64 | BPF_MUL | BPF_K:
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_2mod(0x48, dst_reg, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_2mod(0x40, dst_reg, dst_reg));
> +                       maybe_emit_mod(&prog, dst_reg, dst_reg,
> +                                      BPF_CLASS(insn->code) == BPF_ALU64);
>
>                         if (is_imm8(imm32))
>                                 /* imul dst_reg, dst_reg, imm8 */
> @@ -1102,10 +1107,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>
>                 case BPF_ALU | BPF_MUL | BPF_X:
>                 case BPF_ALU64 | BPF_MUL | BPF_X:
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_2mod(0x48, src_reg, dst_reg));
> -                       else if (is_ereg(dst_reg) || is_ereg(src_reg))
> -                               EMIT1(add_2mod(0x40, src_reg, dst_reg));
> +                       maybe_emit_mod(&prog, src_reg, dst_reg,
> +                                      BPF_CLASS(insn->code) == BPF_ALU64);
>
>                         /* imul dst_reg, src_reg */
>                         EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
> @@ -1118,10 +1121,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                 case BPF_ALU64 | BPF_LSH | BPF_K:
>                 case BPF_ALU64 | BPF_RSH | BPF_K:
>                 case BPF_ALU64 | BPF_ARSH | BPF_K:
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_ALU64);
>
>                         b3 = simple_alu_opcodes[BPF_OP(insn->code)];
>                         if (imm32 == 1)
> @@ -1152,10 +1153,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                         }
>
>                         /* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
> -                       if (BPF_CLASS(insn->code) == BPF_ALU64)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_ALU64);
>
>                         b3 = simple_alu_opcodes[BPF_OP(insn->code)];
>                         EMIT2(0xD3, add_1reg(b3, dst_reg));
> @@ -1465,10 +1464,8 @@ st:                      if (is_imm8(insn->off))
>                 case BPF_JMP | BPF_JSET | BPF_K:
>                 case BPF_JMP32 | BPF_JSET | BPF_K:
>                         /* test dst_reg, imm32 */
> -                       if (BPF_CLASS(insn->code) == BPF_JMP)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_JMP);
>                         EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
>                         goto emit_cond_jmp;
>
> @@ -1501,10 +1498,8 @@ st:                      if (is_imm8(insn->off))
>                         }
>
>                         /* cmp dst_reg, imm8/32 */
> -                       if (BPF_CLASS(insn->code) == BPF_JMP)
> -                               EMIT1(add_1mod(0x48, dst_reg));
> -                       else if (is_ereg(dst_reg))
> -                               EMIT1(add_1mod(0x40, dst_reg));
> +                       maybe_emit_1mod(&prog, dst_reg,
> +                                       BPF_CLASS(insn->code) == BPF_JMP);
>
>                         if (is_imm8(imm32))
>                                 EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
> --
> 2.30.2
>
