Return-Path: <bpf+bounces-10800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211697AE174
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C41D8281554
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669125110;
	Mon, 25 Sep 2023 22:01:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB09241E0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52529C433D9
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695679307;
	bh=0O3ido7rmEDfjvxG6mGGFFX0uMKRMEpik2wUpr5u2Ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S5jQCjz6JIH5dpnsWPoJOkAl4iTXN29HXQPBZB46gEMqi/26/S2jVbiCq4hFJDyhX
	 yB1J/6HSuBf60kHuY68Wov8a1wyDUy6/yaWQ0z/OuCkXJxG+2z/52U1w07mixkkAS4
	 kB0Fe6XVdX7aPwg6aBlZbwRfw1RDLn3HSpn5yA5N2lBnMe7VvAhS0z3Rnqr3RVMP2O
	 qe2vYUxSeBdCW2HDT7iNr+lqvQDDlYpL+nutuwUKdT2R8vDNw0roimbhuWZcl+S0hB
	 iK8s6C+eaMegHwZmZwlkw1QQt54JhEOcvOiudeEChLIXdlI3vOE/vUB6S8hSE/ectv
	 2RzvrLvG1tRrg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50433d8385cso11047540e87.0
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:01:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1iB26NsCuSSEX2JBZYndiVCGy1CGmRQyag/XxG0E7YX5dxS1s
	C+3FFy7SXRcsD9j9M+7nsdjLywyVpkfMAhhPLj0=
X-Google-Smtp-Source: AGHT+IEoEAd4772idTInduhoEVpKsLU/aLFuXH7IRnbihgbD7VLg2gD1QnQHi/xJRcjTPo84BMarj4q4DZubWkwrP7U=
X-Received: by 2002:a05:6512:308f:b0:503:985:92c4 with SMTP id
 z15-20020a056512308f00b00503098592c4mr7488707lfd.52.1695679305436; Mon, 25
 Sep 2023 15:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908132740.718103-1-hbathini@linux.ibm.com> <20230908132740.718103-2-hbathini@linux.ibm.com>
In-Reply-To: <20230908132740.718103-2-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Mon, 25 Sep 2023 15:01:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6J6vK_X1bROKs0pskuogTbZ052hEfUiZH7Q1USdZwV=Q@mail.gmail.com>
Message-ID: <CAPhsuW6J6vK_X1bROKs0pskuogTbZ052hEfUiZH7Q1USdZwV=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] powerpc/bpf: implement bpf_arch_text_copy
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 6:28=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.com=
> wrote:
>
> bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
> multiple BPF programs to share the same page. Use patch_instruction()
> to implement it.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 41 ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 37043dfc1add..4f896222c579 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -13,9 +13,12 @@
>  #include <linux/netdevice.h>
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
> -#include <asm/kprobes.h>
> +#include <linux/memory.h>
>  #include <linux/bpf.h>
>
> +#include <asm/kprobes.h>
> +#include <asm/code-patching.h>
> +
>  #include "bpf_jit.h"
>
>  static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> @@ -23,6 +26,28 @@ static void bpf_jit_fill_ill_insns(void *area, unsigne=
d int size)
>         memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
>  }
>
> +/*
> + * Patch 'len' bytes of instructions from opcode to addr, one instructio=
n
> + * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
> + */
> +static void *bpf_patch_instructions(void *addr, void *opcode, size_t len=
, bool fill_insn)
> +{
> +       while (len > 0) {
> +               ppc_inst_t insn =3D ppc_inst_read(opcode);
> +               int ilen =3D ppc_inst_len(insn);
> +
> +               if (patch_instruction(addr, insn))
> +                       return ERR_PTR(-EINVAL);

Is there any reason we have to do this one instruction at a time? I believe
Christophe Leroy pointed out the same in an earlier version?

Thanks,
Song

> +
> +               len -=3D ilen;
> +               addr =3D addr + ilen;
> +               if (!fill_insn)
> +                       opcode =3D opcode + ilen;
> +       }
> +
> +       return addr;
> +}
> +
>  int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int =
tmp_reg, long exit_addr)
>  {
>         if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx=
 * 4))) {
> @@ -274,3 +299,17 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *=
image, int pass, struct code
>         ctx->exentry_idx++;
>         return 0;
>  }
> +
> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> +{
> +       void *ret;
> +
> +       if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
> +               return ERR_PTR(-EINVAL);
> +
> +       mutex_lock(&text_mutex);
> +       ret =3D bpf_patch_instructions(dst, src, len, false);
> +       mutex_unlock(&text_mutex);
> +
> +       return ret;
> +}

