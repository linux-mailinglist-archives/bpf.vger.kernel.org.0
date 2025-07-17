Return-Path: <bpf+bounces-63587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F7B08992
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A72F1892D94
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB428C009;
	Thu, 17 Jul 2025 09:44:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E328BA84;
	Thu, 17 Jul 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745441; cv=none; b=BQ5IBzwFMKDwop41n4atgy4KwHQZ0wh6fG1q+DGrL/dQ6MlIqheiSHGbtgYFfPxhGdMX/BN2T4rjRvSjrmrrAd8ViEkY6+O8ro2E5bFrCkRBYaFaCuWDRq/FcI6/plelic2g+hEQ/sLwmn6hkx/R0tWnZ0tWRWBmvFqEb0oIwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745441; c=relaxed/simple;
	bh=uh8TcQNgbZbRlKCsstlHygju/8v942inCywjGs7o8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iakgtiEXJ9yw/AXmv7qEuttEUHn4mh7cmE57zYYqCSL0GyDsOzvZc4JfsAfCAvRCJXBEse/Kv04vjC+ab5PtPjOYubBP3XcqlbURx0mpKf9eUVS2n0/QIsri761TfUNA9eV28Xiq5pAEDAYGBd/2NEkytca6KBoRDUyZWLU18Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c25268662f211f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:05f8d111-f810-48a0-82b0-afc740906c77,IP:0,U
	RL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:6493067,CLOUDID:503207e8ce5b0700ffa267c2de431fdd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c25268662f211f0b29709d653e92f7d-20250717
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1182854698; Thu, 17 Jul 2025 17:43:52 +0800
Date: Thu, 17 Jul 2025 17:43:48 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: Re: [PATCH v3 5/5] LoongArch: BPF: Add bpf trampoline support for
 Loongarch
Message-ID: <20250717094348.GB993901@chenghao-pc>
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
 <20250709055029.723243-6-duanchenghao@kylinos.cn>
 <CAEyhmHQOo4ZC8tS549zChU3ozvsh0WAJ9SnQOeG=9mX8g2Gt5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHQOo4ZC8tS549zChU3ozvsh0WAJ9SnQOeG=9mX8g2Gt5w@mail.gmail.com>

On Wed, Jul 16, 2025 at 08:32:54PM +0800, Hengqi Chen wrote:
> On Wed, Jul 9, 2025 at 1:51 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > BPF trampoline is the critical infrastructure of the BPF subsystem, acting
> > as a mediator between kernel functions and BPF programs. Numerous important
> > features, such as using BPF program for zero overhead kernel introspection,
> > rely on this key component.
> >
> > The related tests have passed, Including the following technical points:
> > 1. fentry
> > 2. fmod_ret
> > 3. fexit
> >
> > Co-developed-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 391 +++++++++++++++++++++++++++++++++++
> >  arch/loongarch/net/bpf_jit.h |   6 +
> >  2 files changed, 397 insertions(+)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index 9cb01f0b0..6820558af 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -7,6 +7,10 @@
> >  #include <linux/memory.h>
> >  #include "bpf_jit.h"
> >
> > +#define LOONGARCH_MAX_REG_ARGS 8
> > +#define LOONGARCH_FENTRY_NINSNS 2
> > +#define LOONGARCH_FENTRY_NBYTES (LOONGARCH_FENTRY_NINSNS * 4)
> > +
> >  #define REG_TCC                LOONGARCH_GPR_A6
> >  #define TCC_SAVED      LOONGARCH_GPR_S5
> >
> > @@ -1400,6 +1404,16 @@ static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
> >                                   (unsigned long)ip, (unsigned long)target);
> >  }
> >
> > +static int emit_call(struct jit_ctx *ctx, u64 addr)
> > +{
> > +       u64 ip;
> > +
> > +       if (addr && ctx->image && ctx->ro_image)
> > +               ip = (u64)(ctx->image + ctx->idx);
> > +
> > +       return emit_jump_and_link(ctx, LOONGARCH_GPR_RA, ip, addr);
> > +}
> > +
> >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> >                        void *old_addr, void *new_addr)
> >  {
> > @@ -1457,3 +1471,380 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> >
> >         return dst;
> >  }
> > +
> > +static void store_args(struct jit_ctx *ctx, int nargs, int args_off)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < nargs; i++) {
> > +               emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
> > +               args_off -= 8;
> > +       }
> > +}
> > +
> > +static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < nargs; i++) {
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
> > +               args_off -= 8;
> > +       }
> > +}
> > +
> > +static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
> > +                          int args_off, int retval_off,
> > +                          int run_ctx_off, bool save_ret)
> > +{
> > +       int ret;
> > +       u32 *branch;
> > +       struct bpf_prog *p = l->link.prog;
> > +       int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> > +
> > +       if (l->cookie) {
> > +               move_imm(ctx, LOONGARCH_GPR_T1, l->cookie, false);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
> > +       } else {
> > +               emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP,
> > +                         -run_ctx_off + cookie_off);
> > +       }
> > +
> > +       /* arg1: prog */
> > +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> > +       /* arg2: &run_ctx */
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ctx_off);
> > +       ret = emit_call(ctx, (const u64)bpf_trampoline_enter(p));
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* store prog start time */
> > +       move_reg(ctx, LOONGARCH_GPR_S1, LOONGARCH_GPR_A0);
> > +
> > +       /* if (__bpf_prog_enter(prog) == 0)
> > +        *      goto skip_exec_of_prog;
> > +        *
> > +        */
> > +       branch = (u32 *)ctx->image + ctx->idx;
> > +       /* nop reserved for conditional jump */
> > +       emit_insn(ctx, nop);
> > +
> > +       /* arg1: &args_off */
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_off);
> > +       if (!p->jited)
> > +               move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, false);
> > +       ret = emit_call(ctx, (const u64)p->bpf_func);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (save_ret) {
> > +               emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
> > +               emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
> > +       }
> > +
> > +       /* update branch with beqz */
> > +       if (ctx->image) {
> > +               int offset = (void *)(&ctx->image[ctx->idx]) - (void *)branch;
> > +               *branch = larch_insn_gen_beq(LOONGARCH_GPR_A0, LOONGARCH_GPR_ZERO, offset);
> > +       }
> > +
> > +       /* arg1: prog */
> > +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> > +       /* arg2: prog start time */
> > +       move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
> > +       /* arg3: &run_ctx */
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_A2, LOONGARCH_GPR_FP, -run_ctx_off);
> > +       ret = emit_call(ctx, (const u64)bpf_trampoline_exit(p));
> > +
> > +       return ret;
> > +}
> > +
> > +static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
> > +                              int args_off, int retval_off, int run_ctx_off, u32 **branches)
> > +{
> > +       int i;
> > +
> > +       emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval_off);
> > +       for (i = 0; i < tl->nr_links; i++) {
> > +               invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
> > +                               run_ctx_off, true);
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -retval_off);
> > +               branches[i] = (u32 *)ctx->image + ctx->idx;
> > +               emit_insn(ctx, nop);
> > +       }
> > +}
> > +
> > +u64 bpf_jit_alloc_exec_limit(void)
> > +{
> > +       return VMALLOC_END - VMALLOC_START;
> > +}
> > +
> > +void *arch_alloc_bpf_trampoline(unsigned int size)
> > +{
> > +       return bpf_prog_pack_alloc(size, jit_fill_hole);
> > +}
> > +
> > +void arch_free_bpf_trampoline(void *image, unsigned int size)
> > +{
> > +       bpf_prog_pack_free(image, size);
> > +}
> > +
> > +static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
> > +                                        const struct btf_func_model *m,
> > +                                        struct bpf_tramp_links *tlinks,
> > +                                        void *func_addr, u32 flags)
> > +{
> > +       int i;
> > +       int stack_size = 0, nargs = 0;
> > +       int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off;
> > +       struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> > +       struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> > +       struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > +       int ret, save_ret;
> > +       void *orig_call = func_addr;
> > +       u32 **branches = NULL;
> > +
> > +       if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
> > +               return -ENOTSUPP;
> > +
> > +       /*
> > +        * FP + 8       [ RA to parent func ] return address to parent
> > +        *                    function
> > +        * FP + 0       [ FP of parent func ] frame pointer of parent
> > +        *                    function
> > +        * FP - 8       [ T0 to traced func ] return address of traced
> > +        *                    function
> > +        * FP - 16      [ FP of traced func ] frame pointer of traced
> > +        *                    function
> > +        *
> > +        * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
> > +        *                    BPF_TRAMP_F_RET_FENTRY_RET
> > +        *                  [ argN              ]
> > +        *                  [ ...               ]
> > +        * FP - args_off    [ arg1              ]
> > +        *
> > +        * FP - nargs_off   [ regs count        ]
> > +        *
> > +        * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
> > +        *
> > +        * FP - run_ctx_off [ bpf_tramp_run_ctx ]
> > +        *
> > +        * FP - sreg_off    [ callee saved reg  ]
> > +        *
> > +        */
> > +
> > +       if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
> > +               return -ENOTSUPP;
> > +
> > +       if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
> > +               return -ENOTSUPP;
> > +
> > +       stack_size = 0;
> > +
> > +       /* room of trampoline frame to store return address and frame pointer */
> > +       stack_size += 16;
> > +
> > +       save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> > +       if (save_ret) {
> > +               /* Save BPF R0 and A0 */
> > +               stack_size += 16;
> > +               retval_off = stack_size;
> > +       }
> > +
> > +       /* room of trampoline frame to store args */
> > +       nargs = m->nr_args;
> > +       stack_size += nargs * 8;
> > +       args_off = stack_size;
> > +
> > +       /* room of trampoline frame to store args number */
> > +       stack_size += 8;
> > +       nargs_off = stack_size;
> > +
> > +       /* room of trampoline frame to store ip address */
> > +       if (flags & BPF_TRAMP_F_IP_ARG) {
> > +               stack_size += 8;
> > +               ip_off = stack_size;
> > +       }
> > +
> > +       /* room of trampoline frame to store struct bpf_tramp_run_ctx */
> > +       stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> > +       run_ctx_off = stack_size;
> > +
> > +       stack_size += 8;
> > +       sreg_off = stack_size;
> > +
> > +       stack_size = round_up(stack_size, 16);
> > +
> > +       /* For the trampoline called from function entry */
> > +       /* RA and FP for parent function*/
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> > +       emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> > +
> > +       /* RA and FP for traced function*/
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
> > +       emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > +       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
> > +
> > +       /* callee saved register S1 to pass start time */
> > +       emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
> > +
> > +       /* store ip address of the traced function */
> > +       if (flags & BPF_TRAMP_F_IP_ARG) {
> > +               move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, false);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
> > +       }
> > +
> > +       /* store nargs number*/
> > +       move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
> > +       emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
> > +
> > +       store_args(ctx, nargs, args_off);
> > +
> > +       /* To traced function */
> > +       orig_call += LOONGARCH_FENTRY_NBYTES;
> > +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +               move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> > +               ret = emit_call(ctx, (const u64)__bpf_tramp_enter);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       for (i = 0; i < fentry->nr_links; i++) {
> > +               ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
> > +                                     run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +       if (fmod_ret->nr_links) {
> > +               branches  = kcalloc(fmod_ret->nr_links, sizeof(u32 *), GFP_KERNEL);
> > +               if (!branches)
> > +                       return -ENOMEM;
> > +
> > +               invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
> > +                                  run_ctx_off, branches);
> > +       }
> > +
> > +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +               restore_args(ctx, m->nr_args, args_off);
> > +               ret = emit_call(ctx, (const u64)orig_call);
> > +               if (ret)
> > +                       goto out;
> > +               emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
> > +               emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
> > +               im->ip_after_call = ctx->ro_image + ctx->idx;
> > +               /* Reserve space for the move_imm + jirl instruction */
> > +               emit_insn(ctx, nop);
> > +               emit_insn(ctx, nop);
> > +               emit_insn(ctx, nop);
> > +               emit_insn(ctx, nop);
> > +               emit_insn(ctx, nop);
> > +       }
> > +
> > +       for (i = 0; ctx->image && i < fmod_ret->nr_links; i++) {
> > +               int offset = (void *)(&ctx->image[ctx->idx]) - (void *)branches[i];
> > +               *branches[i] = larch_insn_gen_bne(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, offset);
> > +       }
> > +
> > +       for (i = 0; i < fexit->nr_links; i++) {
> > +               ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
> > +                                     run_ctx_off, false);
> > +               if (ret)
> > +                       goto out;
> > +       }
> > +
> > +       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +               im->ip_epilogue = ctx->ro_image + ctx->idx;
> > +               move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
> > +               ret = emit_call(ctx, (const u64)__bpf_tramp_exit);
> > +               if (ret)
> > +                       goto out;
> > +       }
> > +
> > +       if (flags & BPF_TRAMP_F_RESTORE_REGS)
> > +               restore_args(ctx, m->nr_args, args_off);
> > +
> > +       if (save_ret) {
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
> > +               emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
> > +       }
> > +
> > +       emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
> > +
> > +       /* trampoline called from function entry */
> > +       emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > +       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
> > +
> > +       emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> > +
> > +       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +               /* return to parent function */
> > +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
> > +       else
> > +               /* return to traced function */
> > +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
> > +
> > +       ret = ctx->idx;
> > +out:
> > +       kfree(branches);
> > +
> > +       return ret;
> > +}
> > +
> > +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
> > +                               void *ro_image_end, const struct btf_func_model *m,
> > +                               u32 flags, struct bpf_tramp_links *tlinks,
> > +                               void *func_addr)
> > +{
> > +       int ret;
> > +       void *image, *tmp;
> > +       u32 size = ro_image_end - ro_image;
> > +
> > +       image = kvmalloc(size, GFP_KERNEL);
> > +       if (!image)
> > +               return -ENOMEM;
> > +
> > +       struct jit_ctx ctx = {
> > +               .image = (union loongarch_instruction *)image,
> > +               .ro_image = (union loongarch_instruction *)ro_image,
> > +               .idx = 0,
> > +       };
> > +
> 
> Declare ctx at function entry ?

Yes, since the image is allocated first, it appears as it does now.
Do you think there's anything wrong with doing it this way?

> 
> > +       jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
> > +       ret = __arch_prepare_bpf_trampoline(&ctx, im, m, tlinks, func_addr, flags);
> > +       if (ret > 0 && validate_code(&ctx) < 0) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       tmp = bpf_arch_text_copy(ro_image, image, size);
> > +       if (IS_ERR(tmp)) {
> > +               ret = PTR_ERR(tmp);
> > +               goto out;
> > +       }
> > +
> > +       bpf_flush_icache(ro_image, ro_image_end);
> > +out:
> > +       kvfree(image);
> > +       return ret < 0 ? ret : size;
> > +}
> > +
> > +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> > +                            struct bpf_tramp_links *tlinks, void *func_addr)
> > +{
> > +       struct bpf_tramp_image im;
> > +       struct jit_ctx ctx;
> > +       int ret;
> > +
> > +       ctx.image = NULL;
> > +       ctx.idx = 0;
> > +
> > +       ret = __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, func_addr, flags);
> > +
> > +       /* Page align */
> > +       return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE_SIZE);
> > +}
> > diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> > index f9c569f53..5697158fd 100644
> > --- a/arch/loongarch/net/bpf_jit.h
> > +++ b/arch/loongarch/net/bpf_jit.h
> > @@ -18,6 +18,7 @@ struct jit_ctx {
> >         u32 *offset;
> >         int num_exentries;
> >         union loongarch_instruction *image;
> > +       union loongarch_instruction *ro_image;
> >         u32 stack_size;
> >  };
> >
> > @@ -308,3 +309,8 @@ static inline int emit_tailcall_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch
> >
> >         return -EINVAL;
> >  }
> > +
> > +static inline void bpf_flush_icache(void *start, void *end)
> > +{
> > +       flush_icache_range((unsigned long)start, (unsigned long)end);
> > +}
> > --
> > 2.43.0
> >

