Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B066F31C368
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 22:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhBOVJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 16:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBOVJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 16:09:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11DCD64DFD
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613423357;
        bh=MqJxdtaNsJl39ux1UsHOHgo95lxO+csHstIbY2XTmWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D3eZIugFvvP9zJa5+ubuCsmANuCuuNa/jdO7vooohLN3o5/s+nLcgKQGw2SBGL1YY
         txQC1mS9XmCA7hJpy7JjOmyIDU0CyQuLDwsc+8HP/5WDG2hjmWfh0HOERMgqr3DJo2
         1WIHb8RiD+x8JlYKmVf8YRVhNKGFyhg1RAekW2cTuyZDqVqrATDFlacEEaBt6Me8mW
         PyTdItzF75pFyQp3rX4HvQ7SEpVcumtxK1TCWouqRBYBt7/aYday25BLS5yXam6xxJ
         Gj7r8752GeGsKoyONutCcbbq4PGBDVvXAm0uPRW1TZO4le4pceegKsc+zD3MfKrz57
         nj7NzmUMt4N/Q==
Received: by mail-lj1-f178.google.com with SMTP id j6so9517514ljo.5
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 13:09:16 -0800 (PST)
X-Gm-Message-State: AOAM530mRo+SnaofZc5V6al9YBv2/QQWZ7T0icuqGeX2cA7TdlJxpD5O
        3NvBRnIKUBhWf/TtbpJrOKux+SiVxCw5Oh0z2aHy9g==
X-Google-Smtp-Source: ABdhPJz/JARuSuYXyZS0RQ2BhLACJz1hme9oOEwnsPTUYicVEqPxiKrHeBLBKCEW5wbrGN6AUy6KZtP75Na8DzeT2Nc=
X-Received: by 2002:a2e:585c:: with SMTP id x28mr10238464ljd.468.1613423355303;
 Mon, 15 Feb 2021 13:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20210215160044.1108652-1-jackmanb@google.com>
In-Reply-To: <20210215160044.1108652-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 15 Feb 2021 22:09:04 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6fwJNv6r3CvY7uO5xjZsXDVuuFrkMieLzOKsqQZ_0Jzw@mail.gmail.com>
Message-ID: <CACYkzJ6fwJNv6r3CvY7uO5xjZsXDVuuFrkMieLzOKsqQZ_0Jzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor with
 r0 as src
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 15, 2021 at 5:00 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> This code generates a CMPXCHG loop in order to implement atomic_fetch
> bitwise operations. Because CMPXCHG is hard-coded to use rax (which
> holds the BPF r0 value), it saves the _real_ r0 value into the
> internal "ax" temporary register and restores it once the loop is
> complete.
>
> In the middle of the loop, the actual bitwise operation is performed
> using src_reg. The bug occurs when src_reg is r0: as described above,
> r0 has been clobbered and the real r0 value is in the ax register.
>
> Therefore, perform this operation on the ax register instead, when
> src_reg is r0.
>
> Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c                   |  7 +++---
>  .../selftests/bpf/verifier/atomic_and.c       | 23 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 79e7a0ec1da5..0c9edfe42340 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1349,6 +1349,7 @@ st:                       if (is_imm8(insn->off))
>                             insn->imm == (BPF_XOR | BPF_FETCH)) {
>                                 u8 *branch_target;
>                                 bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +                               u32 real_src_reg = src_reg == BPF_REG_0 ? BPF_REG_AX : src_reg;

I think it would be more readable as:

 u32 real_src_reg =  src_reg;

/* Add a comment here why this is needed */
if (src_reg == BPF_REG_0)
  real_src_reg = BPF_REG_AX;

>
>                                 /*
>                                  * Can't be implemented with a single x86 insn.
> @@ -1366,9 +1367,9 @@ st:                       if (is_imm8(insn->off))
>                                  * put the result in the AUX_REG.
>                                  */
>                                 emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> -                               maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
> +                               maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
>                                 EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> -                                     add_2reg(0xC0, AUX_REG, src_reg));
> +                                     add_2reg(0xC0, AUX_REG, real_src_reg));
>                                 /* Attempt to swap in new value */
>                                 err = emit_atomic(&prog, BPF_CMPXCHG,
>                                                   dst_reg, AUX_REG, insn->off,
> @@ -1381,7 +1382,7 @@ st:                       if (is_imm8(insn->off))
>                                  */
>                                 EMIT2(X86_JNE, -(prog - branch_target) - 2);
>                                 /* Return the pre-modification value */
> -                               emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
> +                               emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
>                                 /* Restore R0 after clobbering RAX */
>                                 emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);

[...]

>
> base-commit: 5e1d40b75ed85ecd76347273da17e5da195c3e96
> --
> 2.30.0.478.g8a0d178c01-goog
>
