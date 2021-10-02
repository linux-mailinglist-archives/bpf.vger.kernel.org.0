Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7738341FD77
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhJBRfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJBRfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:35:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F200C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:33:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w10so5152667ybt.4
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9BJpIWouO0yCw7uAhSt5OLkYTMRmYmAJz8CzPOSV9Q=;
        b=ewzQmIrDgEB1ElAXy3A/VnyV6jIwxvN/gSwOlLeWJT2AwhyNt5LsR9X7QvtOE9VfX9
         m18KxsGUPbMfUgZ7ZwtJKyU54npWAmc0LSvlIKf0y3w6JXadBP5pnWTZDr654f2pkx+8
         RXWL4Bw6gHoWy6YpvnMTD+DQiWQjj+ZOqAv93za5lOm37jLqaaJZkS6UFhl2G4lYfEnm
         Vd+QylQEBF/aeCJ5p3mY8zmU1sQ6GKuCPcqQ92yRe3c0M/BcxcLg9RwWaO57H1PnKGlJ
         VKvEKkX22l4K6DNYNmqODMSsKXlJ+hrdpyzpFWmITaSyc7iB29vjTiI+O+4L5akr36Uj
         SDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9BJpIWouO0yCw7uAhSt5OLkYTMRmYmAJz8CzPOSV9Q=;
        b=1h0juK6mmspuoHB434xcGRSKet3lAAgGRkv8TiqZE4BH7dbq39i9so85sxHMJxzEKd
         Z3NLsDeixP0Ek8uOjgdi2kvWqjkWXzcmq7036Igs/BEdST3+R+xQ6GRfKVgOmuiBNTNJ
         eQ+bobaot45CZdWTXJ8bk+YyrRLqtNkcFkKfirMxwg/qmcULPJIl6R7IEvsv7OdN48sR
         ay7SYA+XGJbuP8Ux6zObdjnyReWBCfi0TPYA4qY+NWG409XZTZVQJPbqCEE6oYeAlR2+
         bvbnoK7QMfQL8gaipYoTNhM9TUjTjRK0lYgdvV3nIhsm5TR3dSOuepaevEHZm9acTDW8
         Fybg==
X-Gm-Message-State: AOAM531fluNSFh3kA6uGhfyk3T+nn7u61HxDDc9diBQvI6dn1pfYln6I
        8BOA9hQ2umib+T0uHfUoeIGUCx+0eF94Ee+yHMAQa1cbKVYUr6Tb
X-Google-Smtp-Source: ABdhPJw2Pr/3UbJ0Qj3xDJOORHdKysGfw0VFAcBEL20/GxvheGKU9xyKmXdxhpk8PC17qieHaQIxoe3nnCKaZ5ZyShU=
X-Received: by 2002:a25:c006:: with SMTP id c6mr4853635ybf.480.1633196032390;
 Sat, 02 Oct 2021 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:33:41 +0200
Message-ID: <CAM1=_QQfJsFimv6kVs-g8YPj71KR9vPhHh=NRbZQNty+toU0aw@mail.gmail.com>
Subject: Re: [PATCH 6/9] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
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
> We aren't handling subtraction involving an immediate value of
> 0x80000000 properly. Fix the same.
>
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

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
