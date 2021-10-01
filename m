Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1241F710
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhJAVrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355619AbhJAVrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 17:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 427046134F
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633124747;
        bh=7onSYh7Y9u7RoaI4r7A6UxmurYeD4ux7Bju/vMwWqQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aWXch4+WH2rsez1pIPxDTx7JRTxauxqhGaslN86veLljBIKA5iepWFge7Q6Pwl5Qy
         J9Swo2VCKThVVmX2JyusEp62iXDos9gNAT4MgPQIXCxW4mTq/b0mht5vD+Y1QY5SFj
         xCv4zFfKBsYrSUzZ6DaAEO4yQUVbGQJSLLLBYm2xvXhlHB0TalZnS/YaviaS7jGYFm
         YSmGrWS2MtS3o1Oh/RT9+70FH10KzT/u9tJauMlYkKim7oBiCh184zWg6b3CnD08xc
         IgehowavAaOeOgw6DUT8YcXwwsQ2b0HQwOmLC3Mw5mXAHG+ldvLjq7NjkC28wjO4Vb
         00Y3+hLt1qKVg==
Received: by mail-lf1-f50.google.com with SMTP id x27so43364054lfa.9
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 14:45:47 -0700 (PDT)
X-Gm-Message-State: AOAM5313I+cvppltwIItLiu8Hx79lZMeiJ+oYVx5RMvVN124jZAbeSRd
        B8UjVX7qVgyCmBJBjMhPAsPqPLtXpEsaYqTh3Qg=
X-Google-Smtp-Source: ABdhPJwZFLIlOFIkEXwhWuoTZbHnjxI5Gy5Y1K0G/oVx4QaBmANYIrC7kfQ4YFSHRG/aBoEPlbV7q8hCZ9yfTBqM7c8=
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr351617lfb.650.1633124745556;
 Fri, 01 Oct 2021 14:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <d4a44c52712468b805cbf5c244b3c9ba0f802ab8.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <d4a44c52712468b805cbf5c244b3c9ba0f802ab8.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Oct 2021 14:45:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7PfZTR0x4hBwaXF9hZ=yCWj=NTnyBi7=oAXmVCy3mANA@mail.gmail.com>
Message-ID: <CAPhsuW7PfZTR0x4hBwaXF9hZ=yCWj=NTnyBi7=oAXmVCy3mANA@mail.gmail.com>
Subject: Re: [PATCH 2/9] powerpc/bpf: Validate branch ranges
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

On Fri, Oct 1, 2021 at 2:16 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Add checks to ensure that we never emit branch instructions with
> truncated branch offsets.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/powerpc/net/bpf_jit.h        | 26 ++++++++++++++++++++------
>  arch/powerpc/net/bpf_jit_comp.c   |  6 +++++-
>  arch/powerpc/net/bpf_jit_comp32.c |  8 ++++++--
>  arch/powerpc/net/bpf_jit_comp64.c |  8 ++++++--
>  4 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 935ea95b66359e..7e9b978b768ed9 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -24,16 +24,30 @@
>  #define EMIT(instr)            PLANT_INSTR(image, ctx->idx, instr)
>
>  /* Long jump; (unconditional 'branch') */
> -#define PPC_JMP(dest)          EMIT(PPC_INST_BRANCH |                        \
> -                                    (((dest) - (ctx->idx * 4)) & 0x03fffffc))
> +#define PPC_JMP(dest)                                                        \
> +       do {                                                                  \
> +               long offset = (long)(dest) - (ctx->idx * 4);                  \
> +               if (!is_offset_in_branch_range(offset)) {                     \
> +                       pr_err_ratelimited("Branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);                       \
> +                       return -ERANGE;                                       \
> +               }                                                             \
> +               EMIT(PPC_INST_BRANCH | (offset & 0x03fffffc));                \
> +       } while (0)
> +
>  /* blr; (unconditional 'branch' with link) to absolute address */
>  #define PPC_BL_ABS(dest)       EMIT(PPC_INST_BL |                            \
>                                      (((dest) - (unsigned long)(image + ctx->idx)) & 0x03fffffc))
>  /* "cond" here covers BO:BI fields. */
> -#define PPC_BCC_SHORT(cond, dest)      EMIT(PPC_INST_BRANCH_COND |           \
> -                                            (((cond) & 0x3ff) << 16) |       \
> -                                            (((dest) - (ctx->idx * 4)) &     \
> -                                             0xfffc))
> +#define PPC_BCC_SHORT(cond, dest)                                            \
> +       do {                                                                  \
> +               long offset = (long)(dest) - (ctx->idx * 4);                  \
> +               if (!is_offset_in_cond_branch_range(offset)) {                \
> +                       pr_err_ratelimited("Conditional branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);           \
> +                       return -ERANGE;                                       \
> +               }                                                             \
> +               EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));                                      \
> +       } while (0)
> +
>  /* Sign-extended 32-bit immediate load */
>  #define PPC_LI32(d, i)         do {                                          \
>                 if ((int)(uintptr_t)(i) >= -32768 &&                          \
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 53aefee3fe70be..fcbf7a917c566e 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -210,7 +210,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>                 /* Now build the prologue, body code & epilogue for real. */
>                 cgctx.idx = 0;
>                 bpf_jit_build_prologue(code_base, &cgctx);
> -               bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
> +               if (bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass)) {
> +                       bpf_jit_binary_free(bpf_hdr);
> +                       fp = org_fp;
> +                       goto out_addrs;
> +               }
>                 bpf_jit_build_epilogue(code_base, &cgctx);
>
>                 if (bpf_jit_enable > 1)
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index beb12cbc8c2994..a74d52204f8da2 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -200,7 +200,7 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>         }
>  }
>
> -static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> +static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
>  {
>         /*
>          * By now, the eBPF program has already setup parameters in r3-r6
> @@ -261,7 +261,9 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>         bpf_jit_emit_common_epilogue(image, ctx);
>
>         EMIT(PPC_RAW_BCTR());
> +
>         /* out: */
> +       return 0;
>  }
>
>  /* Assemble the body code between the prologue & epilogue */
> @@ -1090,7 +1092,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                  */
>                 case BPF_JMP | BPF_TAIL_CALL:
>                         ctx->seen |= SEEN_TAILCALL;
> -                       bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +                       ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +                       if (ret < 0)
> +                               return ret;
>                         break;
>
>                 default:
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index b87a63dba9c8fb..f06c62089b1457 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -206,7 +206,7 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>         EMIT(PPC_RAW_BCTRL());
>  }
>
> -static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> +static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
>  {
>         /*
>          * By now, the eBPF program has already setup parameters in r3, r4 and r5
> @@ -267,7 +267,9 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>         bpf_jit_emit_common_epilogue(image, ctx);
>
>         EMIT(PPC_RAW_BCTR());
> +
>         /* out: */
> +       return 0;
>  }
>
>  /* Assemble the body code between the prologue & epilogue */
> @@ -993,7 +995,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                  */
>                 case BPF_JMP | BPF_TAIL_CALL:
>                         ctx->seen |= SEEN_TAILCALL;
> -                       bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +                       ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +                       if (ret < 0)
> +                               return ret;
>                         break;
>
>                 default:
> --
> 2.33.0
>
