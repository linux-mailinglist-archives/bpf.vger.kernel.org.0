Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456FC41FD74
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhJBRdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:33:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE33C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:31:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g6so10562563ybb.3
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtNb15EBSm5GLCHJbLEIbXiYxWw7c7a4Lz2HIYHR7bk=;
        b=Ucih5GCCGNT4KyrokC2WqwwQi7TehV7TpgQQpP6maygayIaBdpsvhEAXexiKtJbKag
         eW3UrIijWeJTgd1ZfVT1rfI7jEsgN76Ubt2DxvROw2Xu/clLNDcoDHBkxEhWiAb8O0Ba
         wt/IszAeqI5fyDeVBn/7bSRVvnlyU/Zwh7CfjuTEhW+wfKioYiPpyQmFWKsmLksnOzQ2
         yLuFO2BR+qLFd1Lxm8rOZVzi/TPbsS49GHK2kPUDYeKm7ZCdsnlQiXhvY9EziWZcKbbC
         /sorj1kvlSYj5v+ufX55hXD7epaJaTPdqXwuaTNiHHM/gNS5BkEmwAeIrKWf8ZWJcBnh
         frZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtNb15EBSm5GLCHJbLEIbXiYxWw7c7a4Lz2HIYHR7bk=;
        b=GxABI/RX7yYYkSxtofnEtCxptXv5Z0TRAwnz/OPTMCwgohxZbVX5doXdSFroONgal7
         4fUuLF5/SZt2HVhx8ObeCSlZz4/cy4NkGKtdyGwMD+/kwqfAn2pL+ElUZNG2tfGlcdDa
         q4Wi7CbzIdLIsQvY7kAMj5bxO/e4QzAWjh6h8qoo7UnKoaNXoj+4AfnZajkpAllCvHqf
         Tn6iEhJ2SAlYNGnnV8NYUY+jaz90Cq+sqGidR87KYfajLIS6aruketi5lOkAW3o4SsF4
         EPthJ+KPub70Gs6rCxQs0PyMQfZJFTV9KPsp2ZQMYMdHFTLGd3Ak0hlWeSQWwzRDeWsg
         M7dg==
X-Gm-Message-State: AOAM5314Qr7JgatoBMOiRjn31seWaKMCCEyYIl48xo4F2/ZPDxkdxtsw
        k9Me1WXX0z4QQ2LgLjT09xSiwkBLI6QUJF3EjzxkeA==
X-Google-Smtp-Source: ABdhPJyw15NCSRpzMaubFrNh86498c6Q3ymUZIfDCRDS3BBgqbBV6w5W3VubibTRl/5ggiVRfJLfjbUBle+OI3v0wlw=
X-Received: by 2002:a25:bb08:: with SMTP id z8mr5073646ybg.306.1633195905423;
 Sat, 02 Oct 2021 10:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <ebc0317ce465cb4f8d6fe485ab468ac5bda7c48f.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <ebc0317ce465cb4f8d6fe485ab468ac5bda7c48f.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:31:34 +0200
Message-ID: <CAM1=_QT60DW=aWbSZr_-et5zn4L39kwd8HsRM4C3C3wXNVnAfA@mail.gmail.com>
Subject: Re: [PATCH 4/9] powerpc/bpf: Handle large branch ranges with BPF_EXIT
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
> In some scenarios, it is possible that the program epilogue is outside
> the branch range for a BPF_EXIT instruction. Instead of rejecting such
> programs, emit an indirect branch. We track the size of the bpf program
> emitted after the initial run and do a second pass since BPF_EXIT can
> end up emitting different number of instructions depending on the
> program size.
>
> Suggested-by: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

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
