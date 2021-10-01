Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81341F722
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355615AbhJAVz4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhJAVz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 17:55:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60C4A61A56
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633125251;
        bh=0cgV+bBUB1D1h7/glXo2UCToS4npGsoVZly7fP015AI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rsu0KM93+nYq1JSYI00dcjtRrhbdPVCArIF5I7F117bbDO4t932lu7AHOdV2gSj51
         37QuxH9T81ILvzuNcphvppYenYpZV8wNKGI/kLsqlf4crqXac31U5tfDFjMZ0Zy8ra
         fMkH4xDeJPJLjaVtQmOQkF2O/ck/hcM93FycsngksdHploZSSfqUevcu8vz6hW06oS
         3AcZpA1dPx/9ieiK1ZVpmpCANFFnJcugsjsod6ZfBxrX1e7QlZtI2AgI9WYdO/29yz
         EcbjvXkzvVjG4tCzZXOkX1UTcrHYDWpLAUbKVsoqdLjUUuIsW2voxWWcAcIRCECFbF
         qdsf1693oddtg==
Received: by mail-lf1-f48.google.com with SMTP id y23so4567638lfb.0
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 14:54:11 -0700 (PDT)
X-Gm-Message-State: AOAM531L2Z5Y5DUqHA3B9DeY+FEfH4qA/0/FLLWhHzac4y6wSwT2fxSy
        L+WVX0+2+vzPByyU5Fzjj3ZUleMS8VRIW+NlBdM=
X-Google-Smtp-Source: ABdhPJzud8lxYLqZitAUpvzFYiYz2OtpqTQYhxcmHpu1NfyIHLeO5Nlr3hR2sNQKR82Lb43OMQW2L9hSsXR+fhhs2aE=
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr431859lfu.14.1633125249648;
 Fri, 01 Oct 2021 14:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <ebc0317ce465cb4f8d6fe485ab468ac5bda7c48f.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <ebc0317ce465cb4f8d6fe485ab468ac5bda7c48f.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Oct 2021 14:53:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LFNExttL196qa9w0fZVhbj5yZjcRhosE-+gt9hxLbzg@mail.gmail.com>
Message-ID: <CAPhsuW5LFNExttL196qa9w0fZVhbj5yZjcRhosE-+gt9hxLbzg@mail.gmail.com>
Subject: Re: [PATCH 4/9] powerpc/bpf: Handle large branch ranges with BPF_EXIT
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 2:17 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> In some scenarios, it is possible that the program epilogue is outside
> the branch range for a BPF_EXIT instruction. Instead of rejecting such
> programs, emit an indirect branch. We track the size of the bpf program
> emitted after the initial run and do a second pass since BPF_EXIT can
> end up emitting different number of instructions depending on the
> program size.
>
> Suggested-by: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/powerpc/net/bpf_jit.h        |  3 +++
>  arch/powerpc/net/bpf_jit_comp.c   | 22 +++++++++++++++++++++-
>  arch/powerpc/net/bpf_jit_comp32.c |  2 +-
>  arch/powerpc/net/bpf_jit_comp64.c |  2 +-
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 89bd744c2bffd4..4023de1698b9f5 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -126,6 +126,7 @@
>
>  #define SEEN_FUNC      0x20000000 /* might call external helpers */
>  #define SEEN_TAILCALL  0x40000000 /* uses tail calls */
> +#define SEEN_BIG_PROG  0x80000000 /* large prog, >32MB */
>
>  #define SEEN_VREG_MASK 0x1ff80000 /* Volatile registers r3-r12 */
>  #define SEEN_NVREG_MASK        0x0003ffff /* Non volatile registers r14-r31 */
> @@ -179,6 +180,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
>  void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
> +int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx,
> +                                       int tmp_reg, unsigned long exit_addr);
>
>  #endif
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index fcbf7a917c566e..3204872fbf2738 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -72,6 +72,21 @@ static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
>         return 0;
>  }
>
> +int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx,
> +                                       int tmp_reg, unsigned long exit_addr)
> +{
> +       if (!(ctx->seen & SEEN_BIG_PROG) && is_offset_in_branch_range(exit_addr)) {
> +               PPC_JMP(exit_addr);
> +       } else {
> +               ctx->seen |= SEEN_BIG_PROG;
> +               PPC_FUNC_ADDR(tmp_reg, (unsigned long)image + exit_addr);
> +               EMIT(PPC_RAW_MTCTR(tmp_reg));
> +               EMIT(PPC_RAW_BCTR());
> +       }
> +
> +       return 0;
> +}
> +
>  struct powerpc64_jit_data {
>         struct bpf_binary_header *header;
>         u32 *addrs;
> @@ -155,12 +170,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>                 goto out_addrs;
>         }
>
> +       if (!is_offset_in_branch_range((long)cgctx.idx * 4))
> +               cgctx.seen |= SEEN_BIG_PROG;
> +
>         /*
>          * If we have seen a tail call, we need a second pass.
>          * This is because bpf_jit_emit_common_epilogue() is called
>          * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
> +        * We also need a second pass if we ended up with too large
> +        * a program so as to fix branches.
>          */
> -       if (cgctx.seen & SEEN_TAILCALL) {
> +       if (cgctx.seen & (SEEN_TAILCALL | SEEN_BIG_PROG)) {
>                 cgctx.idx = 0;
>                 if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
>                         fp = org_fp;
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index a74d52204f8da2..d2a67574a23066 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -852,7 +852,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                          * we'll just fall through to the epilogue.
>                          */
>                         if (i != flen - 1)
> -                               PPC_JMP(exit_addr);
> +                               bpf_jit_emit_exit_insn(image, ctx, tmp_reg, exit_addr);
>                         /* else fall through to the epilogue */
>                         break;
>
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index f06c62089b1457..3351a866ef6207 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -761,7 +761,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                          * we'll just fall through to the epilogue.
>                          */
>                         if (i != flen - 1)
> -                               PPC_JMP(exit_addr);
> +                               bpf_jit_emit_exit_insn(image, ctx, b2p[TMP_REG_1], exit_addr);
>                         /* else fall through to the epilogue */
>                         break;
>
> --
> 2.33.0
>
