Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9F41FD71
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhJBRbU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:31:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF9C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:29:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i84so27605259ybc.12
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO8XaEuEsuzD/lSiO++PJ3Sm+hMnmRBCleVyzbaHGi0=;
        b=22+n8wT2iA/PwAePyFvHHjtJhNCZMlNtzQb90jo2fNbjDEvtE6+CmvgGXC8GM30Jzy
         l4K/Q1v0Xrnr0uY5Y+pVm/t/xLTcaiizokyTnPH431nsJ1ax1owlh2r4SBGzo+rQskCV
         N6kyXO9ZvmzwMxGSFIzWSzCaJcY8ym16Rmj79RUcDk1z6Uy909NpD0nM72tMv6uhT/Lf
         +98cWjlQw5JDBH9nctyGmnpwM4cmPH52COQqYxvB+u1fAf7VcgfIi6gd97G4q9FYDrB8
         C7XtpuwrqlIQEnruhGQb/CN5nyXbvIZQXQs4Ulh0MbGzuDnVPbSVl/Dn1pymsBlSmO/V
         giEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO8XaEuEsuzD/lSiO++PJ3Sm+hMnmRBCleVyzbaHGi0=;
        b=pO3vnz/PthU7fjCArQeW5c455ec3Ig5impXoZvKMIthzmoTKd+igYom5PdSRVwDPGK
         JYPzeHbHnomPxj7Xt7WuSZt39exzvuvnRHp5bG+JN2X46oX5nFYvGsfCTgAw1l/96XLH
         KPraOhyiLUhEIBp/1bOrkAHpmdX/IV7OowRK7ho86kUBEGZoVReV02PZ1YAGdZWYPEEV
         K5RosySKIYvC7HGq34wvlKfQ6frNoeYu31CPZ8lLemE1oouyWBFUwU5byC0y0KZC0jLs
         mRPdE37xa/ojo+8fBfORKou2p+tUBVdNnC4iInNFHGA2+YY2uYYoJD8RX8j/96HcA77s
         4PiQ==
X-Gm-Message-State: AOAM5319Bh/B3jmLLi8meHrF6j+0Dk4rUda/2mLu+QfGf2JHUaxAaZeE
        hE/b27XT7N2kMWn6quIvHWxg38VO6ZjXhObtnbY4sg==
X-Google-Smtp-Source: ABdhPJzJI9LHvjsV5TxM5cGJFSJg0xsPva57qWfzeyjHua7BBVEWpMvk3wVjQD+CUR+MNi7DnTRws0tCESSmaH/P4n8=
X-Received: by 2002:a25:bb08:: with SMTP id z8mr5063830ybg.306.1633195772549;
 Sat, 02 Oct 2021 10:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <d4a44c52712468b805cbf5c244b3c9ba0f802ab8.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <d4a44c52712468b805cbf5c244b3c9ba0f802ab8.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:29:21 +0200
Message-ID: <CAM1=_QSGQSuN-g4ri42u852cm2GwN_80a2XxUBi=30xnCKtA=g@mail.gmail.com>
Subject: Re: [PATCH 2/9] powerpc/bpf: Validate branch ranges
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 11:15 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Add checks to ensure that we never emit branch instructions with
> truncated branch offsets.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

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
