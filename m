Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02441F731
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbhJAWDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 18:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239895AbhJAWDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 18:03:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B508A61AAD
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633125680;
        bh=ct1RiOV8SWaRMqtQR6mhN6Gfe8wqvu8A1heHzzQy0aA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dh0IirtB/+Wi6dD9XGhx3U0CM4Oqjbg1yjyxzVfH79jTBKvh67zSVLLW+yb9xlWaA
         iY9tLaBjzHZpfIB2GpqbpkcDS6T6/Y1xevE5IQ7KIXD+9a5qEVTbYTO3I+JxnV+Ob5
         xW6XDm16GdohmiopCX3PbYc0x0JbgwHsEU6UJzMfY41rIUSf27SU4j1TgGqBX82ESK
         nTDiyhLCNh6Mz7oEVi8fip84lbAtjeJuznUzQ2R7+RtNTPgCdHSrxKteZawZWRhDex
         uTrmXo9xrBRHHEkgqRAnZDr8JWekmqKCIMR1JQcHiFqIHVFWU0dBhk9Glevfeh1ipo
         YRyFb5YhvWgKg==
Received: by mail-lf1-f53.google.com with SMTP id i25so43844251lfg.6
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 15:01:20 -0700 (PDT)
X-Gm-Message-State: AOAM5320tJiAar+b1cee9z2EJjLwDKMKD6UYeHJtwHkaG7yWHY51k+s8
        72FAIpBTVfuZR14JvqchVmLlaqALZNAZhOgKSxs=
X-Google-Smtp-Source: ABdhPJy5gI/gJV0ZaWKuso9c92vVQLkAnF7492oeobgBYUYyFao+kcaa4K1NVJr55w5x99OKO58aQHYNS5/rz3MJwAw=
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr410642lfb.650.1633125679001;
 Fri, 01 Oct 2021 15:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Oct 2021 15:01:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5NraEPybLVcKWzHva4ksTa05msv-2PBdFXPt_J+=xTyw@mail.gmail.com>
Message-ID: <CAPhsuW5NraEPybLVcKWzHva4ksTa05msv-2PBdFXPt_J+=xTyw@mail.gmail.com>
Subject: Re: [PATCH 6/9] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
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
> We aren't handling subtraction involving an immediate value of
> 0x80000000 properly. Fix the same.
>
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index ffb7a2877a8469..4641a50e82d50d 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -333,15 +333,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                 case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
>                 case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
>                 case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
> -                       if (BPF_OP(code) == BPF_SUB)
> -                               imm = -imm;
> -                       if (imm) {
> -                               if (imm >= -32768 && imm < 32768)
> -                                       EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
> -                               else {
> -                                       PPC_LI32(b2p[TMP_REG_1], imm);
> +                       if (imm > -32768 && imm < 32768) {
> +                               EMIT(PPC_RAW_ADDI(dst_reg, dst_reg,
> +                                       BPF_OP(code) == BPF_SUB ? IMM_L(-imm) : IMM_L(imm)));
> +                       } else {
> +                               PPC_LI32(b2p[TMP_REG_1], imm);
> +                               if (BPF_OP(code) == BPF_SUB)
> +                                       EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
> +                               else
>                                         EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
> -                               }
>                         }
>                         goto bpf_alu32_trunc;
>                 case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
> --
> 2.33.0
>
