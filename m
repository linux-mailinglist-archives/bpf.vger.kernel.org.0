Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9983D41F726
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355246AbhJAV5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhJAV5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 17:57:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC2A61AA4
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633125322;
        bh=ODG7ko63+SeECP/R2xot0/o7Pf68iTfpmoQ4ddkvvgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iiw74Wn/1qAdyp3/vk8gjsuvBVZIygv5q1zuzjSn4D4tCnEev57i+EMOZVYEe3U/g
         iotUV0w/ZUi6Cpc8CnBmjvdge8QV2/Ps+gtyYqCA0V0FOuwitXkO0WZr03n0ovs4XE
         1O3osnW0z5Dul05Kc9zOwq4GvqdvcLSV7fNVBL+vfbu9+pCLlgCp0N0fUWKkbCMrEo
         8FtsOlsKOyIFEuvzhS924EwvdfvDLG/mXwKdLKNyEUq6Y7mEU/nvs6/DyI1y/8J3wS
         b3nMYcLkP0TffghVvxvSaeCnSTPfa7ox4+29Ck5ESx6X/wePah+75U8uIM2Q37jlE8
         OAsXGZ4bGrLAg==
Received: by mail-lf1-f48.google.com with SMTP id y23so8898540lfj.7
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 14:55:22 -0700 (PDT)
X-Gm-Message-State: AOAM5327rCmc591LLJfEcaSg83scCGFLi7ZaBpwE95n4jmyrCgXhYQqS
        62uJrbGY3qPmGA6H1/lFAS+zg+5PtrNhvN0880Q=
X-Google-Smtp-Source: ABdhPJzGYq5GxYt6ytpFJTagQnEr9jIH1Wb78oxJDJGQ8DSz0UeN6RZaKubShhWP9nH2ItnN7YkmX3h0DhKPor6qElI=
X-Received: by 2002:ac2:5182:: with SMTP id u2mr388299lfi.676.1633125321042;
 Fri, 01 Oct 2021 14:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <8cb6a1725cf3c38ca90ed7f195f78a5b5a83bb25.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <8cb6a1725cf3c38ca90ed7f195f78a5b5a83bb25.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Oct 2021 14:55:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6uHz=c_devNF3Rpub8bt6EPT-98Y1mifJUhW0U3gZLcg@mail.gmail.com>
Message-ID: <CAPhsuW6uHz=c_devNF3Rpub8bt6EPT-98Y1mifJUhW0U3gZLcg@mail.gmail.com>
Subject: Re: [PATCH 5/9] powerpc/bpf: Fix BPF_MOD when imm == 1
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
> Only ignore the operation if dividing by 1.
>
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 3351a866ef6207..ffb7a2877a8469 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -391,8 +391,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                 case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
>                         if (imm == 0)
>                                 return -EINVAL;
> -                       else if (imm == 1)
> -                               goto bpf_alu32_trunc;
> +                       if (imm == 1) {
> +                               if (BPF_OP(code) == BPF_DIV) {
> +                                       goto bpf_alu32_trunc;
> +                               } else {
> +                                       EMIT(PPC_RAW_LI(dst_reg, 0));
> +                                       break;
> +                               }
> +                       }
>
>                         PPC_LI32(b2p[TMP_REG_1], imm);
>                         switch (BPF_CLASS(code)) {
> --
> 2.33.0
>
