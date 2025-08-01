Return-Path: <bpf+bounces-64869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF6B17DFE
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 10:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F657A9866
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BC20ADD6;
	Fri,  1 Aug 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBbxvAQW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BA8615A;
	Fri,  1 Aug 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035505; cv=none; b=pZRDp5sf3lbMeFts43eGrag969SdS+x7w1VeO+khUCgUQuGNPZsFoTb1MMaIj6GaF6Z2hxo8UEd06o4BkiyNgm2TH0Ky8g+hKHNtevt66VsLRpQZX2MJo1gjMx2YS3jvssQMdSc8DMzZv8KXAMxlY0qxOSIGuOqK7688uhEfob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035505; c=relaxed/simple;
	bh=HMRfVs1ayVbIU+Vo6apsq5PV8RO0d8tjujJWhntX+5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH6KlS/oY5+CzfBjsBnQnA+4yrDusH3NfsfLvOCIt0IkoQBgpffrMeXNznoikfQPK0+THEMuPHZsjW+NLPwqzGp1Y19j/6BFODWFPYJe+vJvSrengePLYmarLzEk3KsvSlhazANOxY0n5K9q8Z8A3uaaCA49k/t6XwSKxC90DVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBbxvAQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5EC4CEFC;
	Fri,  1 Aug 2025 08:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035505;
	bh=HMRfVs1ayVbIU+Vo6apsq5PV8RO0d8tjujJWhntX+5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nBbxvAQWNELxZRePouEOiAqH99aG6rxob/SFu/VsIMd4d9edEpXnJ6H6rq3mvQH1O
	 7AYDJxXzDLuRgRKF7FWc3qoEW08WvA52fJ6fCUC6K5J6SdD+bB5+HitbXOcoVtty+k
	 bqmBAQi5yvSCH5uR5ZkX7LDeg3aXYHh05B57f4o23Tlbb6DkVaq1Sd6Ro/6K2mkBtK
	 oYEsFI8hB2LJ+OgCBdnyyjk9fvHif3mAketgH+1FaT0YCEAKPdOXFY9Q08d2XWWgpj
	 IeuApdWQjtsRQ5nNMwfxg3rtaEcYZnH1FlqZ8fwjgdLgY4N70+Uo4+kChkrUqa8Xol
	 vlIMoCkGrfKGA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so2379882a12.2;
        Fri, 01 Aug 2025 01:05:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr3k/EwunFEWuA2pEubQ70GVIksg4AY6RG5xEcVfQi4p+ktwcPV3dbU8qwn5yKH7i/ecE=@vger.kernel.org, AJvYcCUsCd5NROqlQEk4KwBtqjxc6k9USDslobTszU4VsUku2YPaGT9uQRNYeNpKyk7jco6yPaT2Y65jQ5Jcaspw@vger.kernel.org
X-Gm-Message-State: AOJu0YwSt8ycGyZJwch7msqRvod78kHclyi2CVpOUFwc/xWCVO3BMnf2
	p9c6RkvptqTUrSGq4x67cqCh/Y9ykgXG392AxPyt6z0QnGYAjbFyBhIzMeBN2Tu8ek8O+O0LlGs
	TfWOGnJ3qJFCErK6G9wu0/uv0kSDIL6Q=
X-Google-Smtp-Source: AGHT+IHnk/0MbGxse4gNf/Qg0G+fBkPFwESTqQO8lCyM10+PgQbzWKRqUxgygyPNjfxYWXEj7YvASXWsxSVd/UYEfpc=
X-Received: by 2002:a05:6402:2687:b0:615:97fe:54c7 with SMTP id
 4fb4d7f45d1cf-61597fe5985mr8603619a12.14.1754035503577; Fri, 01 Aug 2025
 01:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
 <20250730131257.124153-5-duanchenghao@kylinos.cn> <20250731021759.GA132359@chenghao-pc>
In-Reply-To: <20250731021759.GA132359@chenghao-pc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 1 Aug 2025 16:04:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-_-dyLzKKWbxxMmT2xP6-0r52FJOdsDYfELOTcPbfmw@mail.gmail.com>
X-Gm-Features: Ac12FXwatV9q1nHbEKY1L9KnjeeZmSU_HFyapRoeI8fjJJO-bZjfGyljJoapvw0
Message-ID: <CAAhV-H5-_-dyLzKKWbxxMmT2xP6-0r52FJOdsDYfELOTcPbfmw@mail.gmail.com>
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

On Thu, Jul 31, 2025 at 10:18=E2=80=AFAM Chenghao Duan <duanchenghao@kylino=
s.cn> wrote:
>
> On Wed, Jul 30, 2025 at 09:12:56PM +0800, Chenghao Duan wrote:
> > BPF trampoline is the critical infrastructure of the BPF subsystem, act=
ing
> > as a mediator between kernel functions and BPF programs. Numerous impor=
tant
> > features, such as using BPF program for zero overhead kernel introspect=
ion,
> > rely on this key component.
> >
> > The related tests have passed, Including the following technical points=
:
> > 1. fentry
> > 2. fmod_ret
> > 3. fexit
> >
> > The following related testcases passed on LoongArch:
> > sudo ./test_progs -a fentry_test/fentry
> > sudo ./test_progs -a fexit_test/fexit
> > sudo ./test_progs -a fentry_fexit
> > sudo ./test_progs -a modify_return
> > sudo ./test_progs -a fexit_sleep
> > sudo ./test_progs -a test_overhead
> > sudo ./test_progs -a trampoline_count
>
> Hi Teacher Huacai,
>
> If no code modifications are needed, please help add the following
> commit log proposed by Teacher Geliang. If code modifications are
> required, I will add it in the next version.

It probably need a new version since Vincent Li has reported a bug. Sadly.

Huacai

>
> '''
> This issue was first reported by Geliang Tang in June 2024 while
> debugging MPTCP BPF selftests on a LoongArch machine (see commit
> eef0532e900c "selftests/bpf: Null checks for links in bpf_tcp_ca").
> Geliang, Huachui, and Tiezhu then worked together to drive the
> implementation of this feature, encouraging broader collaboration among
> Chinese kernel engineers.
> '''
>
> This log was proposed at:
> https://lore.kernel.org/all/828dd09de3b86f81c8f25130ae209d0d12b0fd9f.came=
l@kernel.org/
>
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202507100034.wXofj6VX-lkp=
@intel.com/
> > Reported-by: Geliang Tang <geliang@kernel.org>
> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 390 +++++++++++++++++++++++++++++++++++
> >  arch/loongarch/net/bpf_jit.h |   6 +
> >  2 files changed, 396 insertions(+)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 5e6ae7e0e..eddf582e4 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -7,9 +7,15 @@
> >  #include <linux/memory.h>
> >  #include "bpf_jit.h"
> >
> > +#define LOONGARCH_MAX_REG_ARGS 8
> > +
> >  #define LOONGARCH_LONG_JUMP_NINSNS 5
> >  #define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> >
> > +#define LOONGARCH_FENTRY_NINSNS 2
> > +#define LOONGARCH_FENTRY_NBYTES (LOONGARCH_FENTRY_NINSNS * 4)
> > +#define LOONGARCH_BPF_FENTRY_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
> > +
> >  #define REG_TCC              LOONGARCH_GPR_A6
> >  #define TCC_SAVED    LOONGARCH_GPR_S5
> >
> > @@ -1407,6 +1413,11 @@ static int gen_jump_or_nops(void *target, void *=
ip, u32 *insns, bool is_call)
> >                                 (unsigned long)target);
> >  }
> >
> > +static int emit_call(struct jit_ctx *ctx, u64 addr)
> > +{
> > +     return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, addr);
> > +}
> > +
> >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> >                      void *old_addr, void *new_addr)
> >  {
> > @@ -1471,3 +1482,382 @@ void *bpf_arch_text_copy(void *dst, void *src, =
size_t len)
> >
> >       return dst;
> >  }
> > +
> > +static void store_args(struct jit_ctx *ctx, int nargs, int args_off)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nargs; i++) {
> > +             emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_F=
P, -args_off);
> > +             args_off -=3D 8;
> > +     }
> > +}
> > +
> > +static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nargs; i++) {
> > +             emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_F=
P, -args_off);
> > +             args_off -=3D 8;
> > +     }
> > +}
> > +
> > +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link =
*l,
> > +                        int args_off, int retval_off,
> > +                        int run_ctx_off, bool save_ret)
> > +{
> > +     int ret;
> > +     u32 *branch;
> > +     struct bpf_prog *p =3D l->link.prog;
> > +     int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie)=
;
> > +
> > +     if (l->cookie) {
> > +             move_imm(ctx, LOONGARCH_GPR_T1, l->cookie, false);
> > +             emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
run_ctx_off + cookie_off);
> > +     } else {
> > +             emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP,
> > +                       -run_ctx_off + cookie_off);
> > +     }
> > +
> > +     /* arg1: prog */
> > +     move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> > +     /* arg2: &run_ctx */
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ct=
x_off);
> > +     ret =3D emit_call(ctx, (const u64)bpf_trampoline_enter(p));
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* store prog start time */
> > +     move_reg(ctx, LOONGARCH_GPR_S1, LOONGARCH_GPR_A0);
> > +
> > +     /* if (__bpf_prog_enter(prog) =3D=3D 0)
> > +      *      goto skip_exec_of_prog;
> > +      *
> > +      */
> > +     branch =3D (u32 *)ctx->image + ctx->idx;
> > +     /* nop reserved for conditional jump */
> > +     emit_insn(ctx, nop);
> > +
> > +     /* arg1: &args_off */
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_o=
ff);
> > +     if (!p->jited)
> > +             move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, fal=
se);
> > +     ret =3D emit_call(ctx, (const u64)p->bpf_func);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (save_ret) {
> > +             emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> > +             emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> > +     }
> > +
> > +     /* update branch with beqz */
> > +     if (ctx->image) {
> > +             int offset =3D (void *)(&ctx->image[ctx->idx]) - (void *)=
branch;
> > +             *branch =3D larch_insn_gen_beq(LOONGARCH_GPR_A0, LOONGARC=
H_GPR_ZERO, offset);
> > +     }
> > +
> > +     /* arg1: prog */
> > +     move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> > +     /* arg2: prog start time */
> > +     move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
> > +     /* arg3: &run_ctx */
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_A2, LOONGARCH_GPR_FP, -run_ct=
x_off);
> > +     ret =3D emit_call(ctx, (const u64)bpf_trampoline_exit(p));
> > +
> > +     return ret;
> > +}
> > +
> > +static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_l=
inks *tl,
> > +                            int args_off, int retval_off, int run_ctx_=
off, u32 **branches)
> > +{
> > +     int i;
> > +
> > +     emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval=
_off);
> > +     for (i =3D 0; i < tl->nr_links; i++) {
> > +             invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
> > +                             run_ctx_off, true);
> > +             emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
retval_off);
> > +             branches[i] =3D (u32 *)ctx->image + ctx->idx;
> > +             emit_insn(ctx, nop);
> > +     }
> > +}
> > +
> > +u64 bpf_jit_alloc_exec_limit(void)
> > +{
> > +     return VMALLOC_END - VMALLOC_START;
> > +}
> > +
> > +void *arch_alloc_bpf_trampoline(unsigned int size)
> > +{
> > +     return bpf_prog_pack_alloc(size, jit_fill_hole);
> > +}
> > +
> > +void arch_free_bpf_trampoline(void *image, unsigned int size)
> > +{
> > +     bpf_prog_pack_free(image, size);
> > +}
> > +
> > +static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct b=
pf_tramp_image *im,
> > +                                      const struct btf_func_model *m,
> > +                                      struct bpf_tramp_links *tlinks,
> > +                                      void *func_addr, u32 flags)
> > +{
> > +     int i;
> > +     int stack_size =3D 0, nargs =3D 0;
> > +     int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_of=
f;
> > +     struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > +     struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> > +     struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
> > +     int ret, save_ret;
> > +     void *orig_call =3D func_addr;
> > +     u32 **branches =3D NULL;
> > +
> > +     if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)=
)
> > +             return -ENOTSUPP;
> > +
> > +     /*
> > +      * FP + 8       [ RA to parent func ] return address to parent
> > +      *                    function
> > +      * FP + 0       [ FP of parent func ] frame pointer of parent
> > +      *                    function
> > +      * FP - 8       [ T0 to traced func ] return address of traced
> > +      *                    function
> > +      * FP - 16      [ FP of traced func ] frame pointer of traced
> > +      *                    function
> > +      *
> > +      * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG o=
r
> > +      *                    BPF_TRAMP_F_RET_FENTRY_RET
> > +      *                  [ argN              ]
> > +      *                  [ ...               ]
> > +      * FP - args_off    [ arg1              ]
> > +      *
> > +      * FP - nargs_off   [ regs count        ]
> > +      *
> > +      * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
> > +      *
> > +      * FP - run_ctx_off [ bpf_tramp_run_ctx ]
> > +      *
> > +      * FP - sreg_off    [ callee saved reg  ]
> > +      *
> > +      */
> > +
> > +     if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
> > +             return -ENOTSUPP;
> > +
> > +     if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)=
)
> > +             return -ENOTSUPP;
> > +
> > +     stack_size =3D 0;
> > +
> > +     /* room of trampoline frame to store return address and frame poi=
nter */
> > +     stack_size +=3D 16;
> > +
> > +     save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FEN=
TRY_RET);
> > +     if (save_ret) {
> > +             /* Save BPF R0 and A0 */
> > +             stack_size +=3D 16;
> > +             retval_off =3D stack_size;
> > +     }
> > +
> > +     /* room of trampoline frame to store args */
> > +     nargs =3D m->nr_args;
> > +     stack_size +=3D nargs * 8;
> > +     args_off =3D stack_size;
> > +
> > +     /* room of trampoline frame to store args number */
> > +     stack_size +=3D 8;
> > +     nargs_off =3D stack_size;
> > +
> > +     /* room of trampoline frame to store ip address */
> > +     if (flags & BPF_TRAMP_F_IP_ARG) {
> > +             stack_size +=3D 8;
> > +             ip_off =3D stack_size;
> > +     }
> > +
> > +     /* room of trampoline frame to store struct bpf_tramp_run_ctx */
> > +     stack_size +=3D round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> > +     run_ctx_off =3D stack_size;
> > +
> > +     stack_size +=3D 8;
> > +     sreg_off =3D stack_size;
> > +
> > +     stack_size =3D round_up(stack_size, 16);
> > +
> > +     /* For the trampoline called from function entry */
> > +     /* RA and FP for parent function*/
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> > +     emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +     emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> > +
> > +     /* RA and FP for traced function*/
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_=
size);
> > +     emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> > +     emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_s=
ize);
> > +
> > +     /* callee saved register S1 to pass start time */
> > +     emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> > +
> > +     /* store ip address of the traced function */
> > +     if (flags & BPF_TRAMP_F_IP_ARG) {
> > +             move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, fal=
se);
> > +             emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -=
ip_off);
> > +     }
> > +
> > +     /* store nargs number*/
> > +     move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
> > +     emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_of=
f);
> > +
> > +     store_args(ctx, nargs, args_off);
> > +
> > +     /* To traced function */
> > +     /* Ftrace jump skips 2 NOP instructions */
> > +     if (is_kernel_text((unsigned long)orig_call))
> > +             orig_call +=3D LOONGARCH_FENTRY_NBYTES;
> > +     /* Direct jump skips 5 NOP instructions */
> > +     else if (is_bpf_text_address((unsigned long)orig_call))
> > +             orig_call +=3D LOONGARCH_BPF_FENTRY_NBYTES;
> > +
> > +     if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +             move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> > +             ret =3D emit_call(ctx, (const u64)__bpf_tramp_enter);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < fentry->nr_links; i++) {
> > +             ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_off, =
retval_off,
> > +                                   run_ctx_off, flags & BPF_TRAMP_F_RE=
T_FENTRY_RET);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     if (fmod_ret->nr_links) {
> > +             branches  =3D kcalloc(fmod_ret->nr_links, sizeof(u32 *), =
GFP_KERNEL);
> > +             if (!branches)
> > +                     return -ENOMEM;
> > +
> > +             invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
> > +                                run_ctx_off, branches);
> > +     }
> > +
> > +     if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +             restore_args(ctx, m->nr_args, args_off);
> > +             ret =3D emit_call(ctx, (const u64)orig_call);
> > +             if (ret)
> > +                     goto out;
> > +             emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> > +             emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> > +             im->ip_after_call =3D ctx->ro_image + ctx->idx;
> > +             /* Reserve space for the move_imm + jirl instruction */
> > +             for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> > +                     emit_insn(ctx, nop);
> > +     }
> > +
> > +     for (i =3D 0; ctx->image && i < fmod_ret->nr_links; i++) {
> > +             int offset =3D (void *)(&ctx->image[ctx->idx]) - (void *)=
branches[i];
> > +             *branches[i] =3D larch_insn_gen_bne(LOONGARCH_GPR_T1, LOO=
NGARCH_GPR_ZERO, offset);
> > +     }
> > +
> > +     for (i =3D 0; i < fexit->nr_links; i++) {
> > +             ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_off, r=
etval_off,
> > +                                   run_ctx_off, false);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> > +     if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +             im->ip_epilogue =3D ctx->ro_image + ctx->idx;
> > +             move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> > +             ret =3D emit_call(ctx, (const u64)__bpf_tramp_exit);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> > +     if (flags & BPF_TRAMP_F_RESTORE_REGS)
> > +             restore_args(ctx, m->nr_args, args_off);
> > +
> > +     if (save_ret) {
> > +             emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> > +             emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> > +     }
> > +
> > +     emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
> > +
> > +     /* trampoline called from function entry */
> > +     emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_siz=
e - 8);
> > +     emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_siz=
e - 16);
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_s=
ize);
> > +
> > +     emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +     emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +     emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> > +
> > +     if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +             /* return to parent function */
> > +             emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA=
, 0);
> > +     else
> > +             /* return to traced function */
> > +             emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0=
, 0);
> > +
> > +     ret =3D ctx->idx;
> > +out:
> > +     kfree(branches);
> > +
> > +     return ret;
> > +}
> > +
> > +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_i=
mage,
> > +                             void *ro_image_end, const struct btf_func=
_model *m,
> > +                             u32 flags, struct bpf_tramp_links *tlinks=
,
> > +                             void *func_addr)
> > +{
> > +     int ret;
> > +     void *image, *tmp;
> > +     struct jit_ctx ctx;
> > +     u32 size =3D ro_image_end - ro_image;
> > +
> > +     image =3D kvmalloc(size, GFP_KERNEL);
> > +     if (!image)
> > +             return -ENOMEM;
> > +
> > +     ctx.image =3D (union loongarch_instruction *)image;
> > +     ctx.ro_image =3D (union loongarch_instruction *)ro_image;
> > +     ctx.idx =3D 0;
> > +
> > +     jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
> > +     ret =3D __arch_prepare_bpf_trampoline(&ctx, im, m, tlinks, func_a=
ddr, flags);
> > +     if (ret > 0 && validate_code(&ctx) < 0) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     tmp =3D bpf_arch_text_copy(ro_image, image, size);
> > +     if (IS_ERR(tmp)) {
> > +             ret =3D PTR_ERR(tmp);
> > +             goto out;
> > +     }
> > +
> > +     bpf_flush_icache(ro_image, ro_image_end);
> > +out:
> > +     kvfree(image);
> > +     return ret < 0 ? ret : size;
> > +}
> > +
> > +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags=
,
> > +                          struct bpf_tramp_links *tlinks, void *func_a=
ddr)
> > +{
> > +     struct bpf_tramp_image im;
> > +     struct jit_ctx ctx;
> > +     int ret;
> > +
> > +     ctx.image =3D NULL;
> > +     ctx.idx =3D 0;
> > +
> > +     ret =3D __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, func_=
addr, flags);
> > +
> > +     /* Page align */
> > +     return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE_S=
IZE);
> > +}
> > diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.=
h
> > index f9c569f53..5697158fd 100644
> > --- a/arch/loongarch/net/bpf_jit.h
> > +++ b/arch/loongarch/net/bpf_jit.h
> > @@ -18,6 +18,7 @@ struct jit_ctx {
> >       u32 *offset;
> >       int num_exentries;
> >       union loongarch_instruction *image;
> > +     union loongarch_instruction *ro_image;
> >       u32 stack_size;
> >  };
> >
> > @@ -308,3 +309,8 @@ static inline int emit_tailcall_jmp(struct jit_ctx =
*ctx, u8 cond, enum loongarch
> >
> >       return -EINVAL;
> >  }
> > +
> > +static inline void bpf_flush_icache(void *start, void *end)
> > +{
> > +     flush_icache_range((unsigned long)start, (unsigned long)end);
> > +}
> > --
> > 2.25.1
> >
>

