Return-Path: <bpf+bounces-64963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700FB19431
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B083A3B5337
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5C1A0BFD;
	Sun,  3 Aug 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr99pSbg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22D155CBD;
	Sun,  3 Aug 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230687; cv=none; b=VfZlP0TWCSKytK8L2Ychf3NMUEUnCzgUy+JVZ/NsyXWyiGHSE2djpbUKGaX+xW7LYkJ/1ier4KhF96yLnXlQX34pDy/VKo3nuxot0jiERdo3oG21zXikdzQT17+b8AGI+FQXp3fnXORj65yaY5H4hmqdJe71cSvqn77KY6YIqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230687; c=relaxed/simple;
	bh=0fwcr0UyMex0YFtoiaDH2RdRy/lyga1cXriDXLASi2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqO10IRYUnbZIXwr35rp0Da2na1xipUODmSj+jfc8hifcB1C8JuqQZq+lJc8CzFFBoZhnPFRomkY3njUW9jdvw1HL41EK1UU91GTbirKmb+g56e4xOVXTt8J8XQMuCPfNyIFb8behi2mPSkma2ouWd8waZfJ4tv9/xuUf8TED4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr99pSbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B3AC4AF0B;
	Sun,  3 Aug 2025 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754230686;
	bh=0fwcr0UyMex0YFtoiaDH2RdRy/lyga1cXriDXLASi2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mr99pSbgaf3t3iUfdiMSlyb7cI7rrjX65rKvEgVw61Y+ieK0xuNd4fAwHBC19/mSQ
	 v7V82eXovfpxMSxjyDLg+w4cl7GPY2XTc/aog9WzUxb/ltt3pZwXTSREwnzxCjeQxX
	 h++epGZ+u8f4dH+OyIxw6Tf/eflhGEoqPRyoJkx2iHzOFRCOMD3BxHlq4NTT6HtXKS
	 Ox6UfrDBoEhu97N9icxjvkrCxFJS2L5hCamyHi2eKdrwvDqmeKrSVXq078MosgrZKM
	 umcgzlcCQh4CVQBOrwSZS1TwBw05YpSwypVa+ESwySz+F4NUZSoi8unrAUGy4EGdfY
	 MQVSLigwqIrcw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso7548977a12.2;
        Sun, 03 Aug 2025 07:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe5cuigy5ORjG3OaRm+Tt3Fc3rnx/3mUQ91lwcU691QlYKj4xuMwCuDx/K1sgOVXIzokheV0RfCnTTwAOB@vger.kernel.org, AJvYcCXmADoWTX3VKhbBV2MVSHPXpLR9SpUZnIbr4Mxy1aAOVKadbKmfztU54ifbiAeHXpt78aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKc7XL5DUAoaMs76bzTgUc/aUODhCQhtja+XJ0SRO3GcCj8hTe
	Io62i7q2sD/cTEx7lSPkYp6fk+/3/pFaJ7S2F0GlwNOThKyGgUMPXR9TiNYq93rbY2kZak+6bzP
	AoiAfI6iNuoMEHQ8sMTAOHx6HUg+KzJ8=
X-Google-Smtp-Source: AGHT+IFtsfwxz0AQyKgOMtyUe67tevfoeJYkV4Ath7ERhT5EEvc7L8RIHYzd04Ni5cdIKUjqBj6+4J7Fh9oI4EXhs1w=
X-Received: by 2002:a05:6402:518e:b0:612:a77e:1816 with SMTP id
 4fb4d7f45d1cf-615e6ce26f0mr4934451a12.0.1754230684887; Sun, 03 Aug 2025
 07:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn> <20250730131257.124153-5-duanchenghao@kylinos.cn>
In-Reply-To: <20250730131257.124153-5-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 3 Aug 2025 22:17:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5DV_fOFPBQBKUHdQ_40s584Xwaw-vLb3ehvOecLQmXKg@mail.gmail.com>
X-Gm-Features: Ac12FXxJOYfImlKo_kgHvMkk2iZa1iZn5-4bC9vZ8E3WafsclSRDRbKxoii801g
Message-ID: <CAAhV-H5DV_fOFPBQBKUHdQ_40s584Xwaw-vLb3ehvOecLQmXKg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] LoongArch: BPF: Add bpf trampoline support for Loongarch
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> BPF trampoline is the critical infrastructure of the BPF subsystem, actin=
g
> as a mediator between kernel functions and BPF programs. Numerous importa=
nt
> features, such as using BPF program for zero overhead kernel introspectio=
n,
> rely on this key component.
>
> The related tests have passed, Including the following technical points:
> 1. fentry
> 2. fmod_ret
> 3. fexit
>
> The following related testcases passed on LoongArch:
> sudo ./test_progs -a fentry_test/fentry
> sudo ./test_progs -a fexit_test/fexit
> sudo ./test_progs -a fentry_fexit
> sudo ./test_progs -a modify_return
> sudo ./test_progs -a fexit_sleep
> sudo ./test_progs -a test_overhead
> sudo ./test_progs -a trampoline_count
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507100034.wXofj6VX-lkp@i=
ntel.com/
> Reported-by: Geliang Tang <geliang@kernel.org>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 390 +++++++++++++++++++++++++++++++++++
>  arch/loongarch/net/bpf_jit.h |   6 +
>  2 files changed, 396 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 5e6ae7e0e..eddf582e4 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -7,9 +7,15 @@
>  #include <linux/memory.h>
>  #include "bpf_jit.h"
>
> +#define LOONGARCH_MAX_REG_ARGS 8
> +
>  #define LOONGARCH_LONG_JUMP_NINSNS 5
>  #define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
>
> +#define LOONGARCH_FENTRY_NINSNS 2
> +#define LOONGARCH_FENTRY_NBYTES (LOONGARCH_FENTRY_NINSNS * 4)
> +#define LOONGARCH_BPF_FENTRY_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> +
>  #define REG_TCC                LOONGARCH_GPR_A6
>  #define TCC_SAVED      LOONGARCH_GPR_S5
>
> @@ -1407,6 +1413,11 @@ static int gen_jump_or_nops(void *target, void *ip=
, u32 *insns, bool is_call)
>                                   (unsigned long)target);
>  }
>
> +static int emit_call(struct jit_ctx *ctx, u64 addr)
> +{
> +       return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, addr);
> +}
> +
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>                        void *old_addr, void *new_addr)
>  {
> @@ -1471,3 +1482,382 @@ void *bpf_arch_text_copy(void *dst, void *src, si=
ze_t len)
>
>         return dst;
>  }
> +
> +static void store_args(struct jit_ctx *ctx, int nargs, int args_off)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nargs; i++) {
> +               emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_F=
P, -args_off);
> +               args_off -=3D 8;
> +       }
> +}
> +
> +static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nargs; i++) {
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_F=
P, -args_off);
> +               args_off -=3D 8;
> +       }
> +}
> +
> +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l=
,
> +                          int args_off, int retval_off,
> +                          int run_ctx_off, bool save_ret)
> +{
> +       int ret;
> +       u32 *branch;
> +       struct bpf_prog *p =3D l->link.prog;
> +       int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie)=
;
> +
> +       if (l->cookie) {
> +               move_imm(ctx, LOONGARCH_GPR_T1, l->cookie, false);
> +               emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
run_ctx_off + cookie_off);
> +       } else {
> +               emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP,
> +                         -run_ctx_off + cookie_off);
> +       }
> +
> +       /* arg1: prog */
> +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> +       /* arg2: &run_ctx */
> +       emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ct=
x_off);
> +       ret =3D emit_call(ctx, (const u64)bpf_trampoline_enter(p));
> +       if (ret)
> +               return ret;
> +
> +       /* store prog start time */
> +       move_reg(ctx, LOONGARCH_GPR_S1, LOONGARCH_GPR_A0);
> +
> +       /* if (__bpf_prog_enter(prog) =3D=3D 0)
> +        *      goto skip_exec_of_prog;
> +        *
> +        */
> +       branch =3D (u32 *)ctx->image + ctx->idx;
> +       /* nop reserved for conditional jump */
> +       emit_insn(ctx, nop);
> +
> +       /* arg1: &args_off */
> +       emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_o=
ff);
> +       if (!p->jited)
> +               move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, fal=
se);
> +       ret =3D emit_call(ctx, (const u64)p->bpf_func);
> +       if (ret)
> +               return ret;
> +
> +       if (save_ret) {
> +               emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> +               emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> +       }
> +
> +       /* update branch with beqz */
> +       if (ctx->image) {
> +               int offset =3D (void *)(&ctx->image[ctx->idx]) - (void *)=
branch;
> +               *branch =3D larch_insn_gen_beq(LOONGARCH_GPR_A0, LOONGARC=
H_GPR_ZERO, offset);
> +       }
> +
> +       /* arg1: prog */
> +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> +       /* arg2: prog start time */
> +       move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
> +       /* arg3: &run_ctx */
> +       emit_insn(ctx, addid, LOONGARCH_GPR_A2, LOONGARCH_GPR_FP, -run_ct=
x_off);
> +       ret =3D emit_call(ctx, (const u64)bpf_trampoline_exit(p));
> +
> +       return ret;
> +}
> +
> +static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_lin=
ks *tl,
> +                              int args_off, int retval_off, int run_ctx_=
off, u32 **branches)
> +{
> +       int i;
> +
> +       emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval=
_off);
> +       for (i =3D 0; i < tl->nr_links; i++) {
> +               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
> +                               run_ctx_off, true);
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
retval_off);
> +               branches[i] =3D (u32 *)ctx->image + ctx->idx;
> +               emit_insn(ctx, nop);
> +       }
> +}
> +
> +u64 bpf_jit_alloc_exec_limit(void)
> +{
> +       return VMALLOC_END - VMALLOC_START;
> +}
I think this function should be removed, because we alloc bpf in the
module region.

Huacai

> +
> +void *arch_alloc_bpf_trampoline(unsigned int size)
> +{
> +       return bpf_prog_pack_alloc(size, jit_fill_hole);
> +}
> +
> +void arch_free_bpf_trampoline(void *image, unsigned int size)
> +{
> +       bpf_prog_pack_free(image, size);
> +}
> +
> +static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf=
_tramp_image *im,
> +                                        const struct btf_func_model *m,
> +                                        struct bpf_tramp_links *tlinks,
> +                                        void *func_addr, u32 flags)
> +{
> +       int i;
> +       int stack_size =3D 0, nargs =3D 0;
> +       int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_of=
f;
> +       struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> +       struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> +       struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> +       int ret, save_ret;
> +       void *orig_call =3D func_addr;
> +       u32 **branches =3D NULL;
> +
> +       if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)=
)
> +               return -ENOTSUPP;
> +
> +       /*
> +        * FP + 8       [ RA to parent func ] return address to parent
> +        *                    function
> +        * FP + 0       [ FP of parent func ] frame pointer of parent
> +        *                    function
> +        * FP - 8       [ T0 to traced func ] return address of traced
> +        *                    function
> +        * FP - 16      [ FP of traced func ] frame pointer of traced
> +        *                    function
> +        *
> +        * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG o=
r
> +        *                    BPF_TRAMP_F_RET_FENTRY_RET
> +        *                  [ argN              ]
> +        *                  [ ...               ]
> +        * FP - args_off    [ arg1              ]
> +        *
> +        * FP - nargs_off   [ regs count        ]
> +        *
> +        * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
> +        *
> +        * FP - run_ctx_off [ bpf_tramp_run_ctx ]
> +        *
> +        * FP - sreg_off    [ callee saved reg  ]
> +        *
> +        */
> +
> +       if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
> +               return -ENOTSUPP;
> +
> +       if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)=
)
> +               return -ENOTSUPP;
> +
> +       stack_size =3D 0;
> +
> +       /* room of trampoline frame to store return address and frame poi=
nter */
> +       stack_size +=3D 16;
> +
> +       save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FEN=
TRY_RET);
> +       if (save_ret) {
> +               /* Save BPF R0 and A0 */
> +               stack_size +=3D 16;
> +               retval_off =3D stack_size;
> +       }
> +
> +       /* room of trampoline frame to store args */
> +       nargs =3D m->nr_args;
> +       stack_size +=3D nargs * 8;
> +       args_off =3D stack_size;
> +
> +       /* room of trampoline frame to store args number */
> +       stack_size +=3D 8;
> +       nargs_off =3D stack_size;
> +
> +       /* room of trampoline frame to store ip address */
> +       if (flags & BPF_TRAMP_F_IP_ARG) {
> +               stack_size +=3D 8;
> +               ip_off =3D stack_size;
> +       }
> +
> +       /* room of trampoline frame to store struct bpf_tramp_run_ctx */
> +       stack_size +=3D round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> +       run_ctx_off =3D stack_size;
> +
> +       stack_size +=3D 8;
> +       sreg_off =3D stack_size;
> +
> +       stack_size =3D round_up(stack_size, 16);
> +
> +       /* For the trampoline called from function entry */
> +       /* RA and FP for parent function*/
> +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> +       emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> +       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> +       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> +
> +       /* RA and FP for traced function*/
> +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_=
size);
> +       emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> +       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> +       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_s=
ize);
> +
> +       /* callee saved register S1 to pass start time */
> +       emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> +
> +       /* store ip address of the traced function */
> +       if (flags & BPF_TRAMP_F_IP_ARG) {
> +               move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, fal=
se);
> +               emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
ip_off);
> +       }
> +
> +       /* store nargs number*/
> +       move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
> +       emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_of=
f);
> +
> +       store_args(ctx, nargs, args_off);
> +
> +       /* To traced function */
> +       /* Ftrace jump skips 2 NOP instructions */
> +       if (is_kernel_text((unsigned long)orig_call))
> +               orig_call +=3D LOONGARCH_FENTRY_NBYTES;
> +       /* Direct jump skips 5 NOP instructions */
> +       else if (is_bpf_text_address((unsigned long)orig_call))
> +               orig_call +=3D LOONGARCH_BPF_FENTRY_NBYTES;
> +
> +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +               move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> +               ret =3D emit_call(ctx, (const u64)__bpf_tramp_enter);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       for (i =3D 0; i < fentry->nr_links; i++) {
> +               ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_off, =
retval_off,
> +                                     run_ctx_off, flags & BPF_TRAMP_F_RE=
T_FENTRY_RET);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (fmod_ret->nr_links) {
> +               branches  =3D kcalloc(fmod_ret->nr_links, sizeof(u32 *), =
GFP_KERNEL);
> +               if (!branches)
> +                       return -ENOMEM;
> +
> +               invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
> +                                  run_ctx_off, branches);
> +       }
> +
> +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +               restore_args(ctx, m->nr_args, args_off);
> +               ret =3D emit_call(ctx, (const u64)orig_call);
> +               if (ret)
> +                       goto out;
> +               emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> +               emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> +               im->ip_after_call =3D ctx->ro_image + ctx->idx;
> +               /* Reserve space for the move_imm + jirl instruction */
> +               for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> +                       emit_insn(ctx, nop);
> +       }
> +
> +       for (i =3D 0; ctx->image && i < fmod_ret->nr_links; i++) {
> +               int offset =3D (void *)(&ctx->image[ctx->idx]) - (void *)=
branches[i];
> +               *branches[i] =3D larch_insn_gen_bne(LOONGARCH_GPR_T1, LOO=
NGARCH_GPR_ZERO, offset);
> +       }
> +
> +       for (i =3D 0; i < fexit->nr_links; i++) {
> +               ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_off, r=
etval_off,
> +                                     run_ctx_off, false);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +               im->ip_epilogue =3D ctx->ro_image + ctx->idx;
> +               move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> +               ret =3D emit_call(ctx, (const u64)__bpf_tramp_exit);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       if (flags & BPF_TRAMP_F_RESTORE_REGS)
> +               restore_args(ctx, m->nr_args, args_off);
> +
> +       if (save_ret) {
> +               emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> +               emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> +       }
> +
> +       emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> +
> +       /* trampoline called from function entry */
> +       emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> +       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_s=
ize);
> +
> +       emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> +       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> +
> +       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +               /* return to parent function */
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
> +       else
> +               /* return to traced function */
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0=
, 0);
> +
> +       ret =3D ctx->idx;
> +out:
> +       kfree(branches);
> +
> +       return ret;
> +}
> +
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_ima=
ge,
> +                               void *ro_image_end, const struct btf_func=
_model *m,
> +                               u32 flags, struct bpf_tramp_links *tlinks=
,
> +                               void *func_addr)
> +{
> +       int ret;
> +       void *image, *tmp;
> +       struct jit_ctx ctx;
> +       u32 size =3D ro_image_end - ro_image;
> +
> +       image =3D kvmalloc(size, GFP_KERNEL);
> +       if (!image)
> +               return -ENOMEM;
> +
> +       ctx.image =3D (union loongarch_instruction *)image;
> +       ctx.ro_image =3D (union loongarch_instruction *)ro_image;
> +       ctx.idx =3D 0;
> +
> +       jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
> +       ret =3D __arch_prepare_bpf_trampoline(&ctx, im, m, tlinks, func_a=
ddr, flags);
> +       if (ret > 0 && validate_code(&ctx) < 0) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       tmp =3D bpf_arch_text_copy(ro_image, image, size);
> +       if (IS_ERR(tmp)) {
> +               ret =3D PTR_ERR(tmp);
> +               goto out;
> +       }
> +
> +       bpf_flush_icache(ro_image, ro_image_end);
> +out:
> +       kvfree(image);
> +       return ret < 0 ? ret : size;
> +}
> +
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +                            struct bpf_tramp_links *tlinks, void *func_a=
ddr)
> +{
> +       struct bpf_tramp_image im;
> +       struct jit_ctx ctx;
> +       int ret;
> +
> +       ctx.image =3D NULL;
> +       ctx.idx =3D 0;
> +
> +       ret =3D __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, func_=
addr, flags);
> +
> +       /* Page align */
> +       return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE_S=
IZE);
> +}
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index f9c569f53..5697158fd 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -18,6 +18,7 @@ struct jit_ctx {
>         u32 *offset;
>         int num_exentries;
>         union loongarch_instruction *image;
> +       union loongarch_instruction *ro_image;
>         u32 stack_size;
>  };
>
> @@ -308,3 +309,8 @@ static inline int emit_tailcall_jmp(struct jit_ctx *c=
tx, u8 cond, enum loongarch
>
>         return -EINVAL;
>  }
> +
> +static inline void bpf_flush_icache(void *start, void *end)
> +{
> +       flush_icache_range((unsigned long)start, (unsigned long)end);
> +}
> --
> 2.25.1
>
>

