Return-Path: <bpf+bounces-64009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31883B0D661
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D93F7A90B9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22828D840;
	Tue, 22 Jul 2025 09:56:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96ED2557A
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178177; cv=none; b=de9+XN+bTuiTymGl4LxluDdjAERCiqtWHgXF5L2E9axG4hO1oxfE8IgvvglDslr37IDX6hs6H4cWkNs4fXBqD6Xuqwb+QfjeDpgy/VEoAihiqBmgRWaa8LZz5jZfYoJswZe6lgBNgSgKvJmc0eA6oJml7BR8TEZWmIX0A6EPBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178177; c=relaxed/simple;
	bh=8acYdWSy8IwiLJ8qNR4vQIJxvCDC6B+3b4BTNe7r+UE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PULVvumc4xCcC8IP9SYWLMQGdcrVDQ7EInmq/etbf0SbPVp25zWWpkN9k2gYX+bWvJxRILV2PLl5/LDNZ1k++dDSzyF9xxzdm2pESlrSJw8Jrs36ZejUEkDwX38AqmmDdeLMwfsthjfBDRMHusjYKMXRruB4o0JMuR6P3CSdpt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 16cf197a66e211f0b29709d653e92f7d-20250722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3c84ddd1-8059-41fd-971e-f95099eabcbd,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-INFO: VERSION:1.1.45,REQID:3c84ddd1-8059-41fd-971e-f95099eabcbd,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:302a8bc955d86b4e8a03b7e70e1855a6,BulkI
	D:250722175611VU6VV3PW,BulkQuantity:0,Recheck:0,SF:10|24|44|64|66|78|80|81
	|82|83|102|841,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 16cf197a66e211f0b29709d653e92f7d-20250722
X-User: jianghaoran@kylinos.cn
Received: from [192.168.31.67] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1141057818; Tue, 22 Jul 2025 17:56:07 +0800
Message-ID: <3c024e7868bd0b80afcac1e56ce3589e1306711b.camel@kylinos.cn>
Subject: =?gb2312?Q?re=A3=BA=5BPATCH?= v2 2/2] LoongArch: BPF: Fix tailcall
 hierarchy
From: jianghaoran <jianghaoran@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
 chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com,  sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com,  yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev,  andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
Date: Tue, 22 Jul 2025 17:56:03 +0800
In-Reply-To: <CAEyhmHTSw-DKj+TLOwfKuSvvTq2cXRackaRCZDiK7ymh-jvpog@mail.gmail.com>
References: <20250708071840.556686-1-jianghaoran@kylinos.cn>
	 <20250708071840.556686-3-jianghaoran@kylinos.cn>
	 <CAEyhmHTSw-DKj+TLOwfKuSvvTq2cXRackaRCZDiK7ymh-jvpog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit





在 2025-07-16星期三的 10:28 +0800，Hengqi Chen写道：
> On Tue, Jul 8, 2025 at 3:19 PM Haoran Jiang <
> jianghaoran@kylinos.cn
> > wrote:
> > In specific use cases combining tailcalls and BPF-to-BPF calls，
> > MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> > back-propagation from callee to caller。This patch fixes this
> > tailcall issue caused by abusing the tailcall in bpf2bpf
> > feature
> > on LoongArch like the way of "bpf, x64: Fix tailcall
> > hierarchy".
> > 
> > push tail_call_cnt_ptr and tail_call_cnt into the stack,
> > tail_call_cnt_ptr is passed between tailcall and bpf2bpf,
> > uses tail_call_cnt_ptr to increment tail_call_cnt.
> > 
> > Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf
> > and tailcalls")
> > Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > Signed-off-by: Haoran Jiang <
> > jianghaoran@kylinos.cn
> > >
> > ---
> >  arch/loongarch/net/bpf_jit.c | 112 +++++++++++++++++++++----
> > ----------
> >  1 file changed, 68 insertions(+), 44 deletions(-)
> > 
> > diff --git a/arch/loongarch/net/bpf_jit.c
> > b/arch/loongarch/net/bpf_jit.c
> > index 5061bfc978f2..45f804b7c556 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -7,10 +7,9 @@
> >  #include "bpf_jit.h"
> > 
> >  #define REG_TCC                LOONGARCH_GPR_A6
> > -#define TCC_SAVED      LOONGARCH_GPR_S5
> > 
> > -#define SAVE_RA                BIT(0)
> > -#define SAVE_TCC       BIT(1)
> > +#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)
> > (round_up(stack, 16) - 80)
> > +
> > 
> >  static const int regmap[] = {
> >         /* return value from in-kernel function, and exit value
> > for eBPF program */
> > @@ -32,32 +31,37 @@ static const int regmap[] = {
> >         [BPF_REG_AX] = LOONGARCH_GPR_T0,
> >  };
> > 
> > -static void mark_call(struct jit_ctx *ctx)
> > +static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int
> > *store_offset)
> 
> Consider adding more comments(e.g. pseudocode) for
> prepare_bpf_tail_call_cnt().
> Assembly is hard to read. (At least for me :))
> 

I will improve the comment information in the next version.
> 
> >  {
> > -       ctx->flags |= SAVE_RA;
> > -}
> > +       const struct bpf_prog *prog = ctx->prog;
> > +       const bool is_main_prog = !bpf_is_subprog(prog);
> > 
> > -static void mark_tail_call(struct jit_ctx *ctx)
> > -{
> > -       ctx->flags |= SAVE_TCC;
> > -}
> > +       if (is_main_prog) {
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> > +               *store_offset -= sizeof(long);
> > 
> > -static bool seen_call(struct jit_ctx *ctx)
> > -{
> > -       return (ctx->flags & SAVE_RA);
> > -}
> > +               emit_tailcall_jmp(ctx, BPF_JGT, REG_TCC, LOONGARCH_GPR_T3, 4);
> 
> Why emit_tailcall_jmp() here ? Shouldn't this be emit_cond_jmp() ?

It's more appropriate to use emit_cond_jmp here.
> 
> > 
> > -static bool seen_tail_call(struct jit_ctx *ctx)
> > -{
> > -       return (ctx->flags & SAVE_TCC);
> > -}
> > +               /* If REG_TCC < MAX_TAIL_CALL_CNT, push REG_TCC into stack */
> > +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > 
> > -static u8 tail_call_reg(struct jit_ctx *ctx)
> > -{
> > -       if (seen_call(ctx))
> > -               return TCC_SAVED;
> > +               /* Calculate the pointer to REG_TCC in the stack and assign it to REG_TCC */
> > +               emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > +
> > +               emit_uncond_jmp(ctx, 2);
> > +
> > +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > 
> > -       return REG_TCC;
> > +               *store_offset -= sizeof(long);
> > +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > +
> > +       } else {
> > +               *store_offset -= sizeof(long);
> > +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > +
> > +               *store_offset -= sizeof(long);
> > +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
> > +       }
> >  }
> > 
> >  /*
> > @@ -80,6 +84,10 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> >   *                            |           $s4           |
> >   *                            +-------------------------+
> >   *                            |           $s5           |
> > + *                            +-------------------------+
> > + *                            |          reg_tcc        |
> > + *                            +-------------------------+
> > + *                            |          reg_tcc_ptr    |
> >   *                            +-------------------------+ <--BPF_REG_FP
> >   *                            |  prog->aux->stack_depth |
> >   *                            |        (optional)       |
> > @@ -89,21 +97,24 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
> >  static void build_prologue(struct jit_ctx *ctx)
> >  {
> >         int stack_adjust = 0, store_offset, bpf_stack_adjust;
> > +       const struct bpf_prog *prog = ctx->prog;
> > +       const bool is_main_prog = !bpf_is_subprog(prog);
> > 
> >         bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> > 
> > -       /* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
> > -       stack_adjust += sizeof(long) * 8;
> > +       /* To store ra, fp, s0, s1, s2, s3, s4, s5, reg_tcc and reg_tcc_ptr */
> > +       stack_adjust += sizeof(long) * 10;
> > 
> >         stack_adjust = round_up(stack_adjust, 16);
> >         stack_adjust += bpf_stack_adjust;
> > 
> >         /*
> > -        * First instruction initializes the tail call count (TCC).
> > -        * On tail call we skip this instruction, and the TCC is
> > +        * First instruction initializes the tail call count (TCC) register
> > +        * to zero. On tail call we skip this instruction, and the TCC is
> >          * passed in REG_TCC from the caller.
> >          */
> > -       emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> > +       if (is_main_prog)
> > +               emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
> > 
> >         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
> > 
> > @@ -131,20 +142,13 @@ static void build_prologue(struct jit_ctx *ctx)
> >         store_offset -= sizeof(long);
> >         emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
> > 
> > +       prepare_bpf_tail_call_cnt(ctx, &store_offset);
> > +
> >         emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
> > 
> >         if (bpf_stack_adjust)
> >                 emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
> > 
> > -       /*
> > -        * Program contains calls and tail calls, so REG_TCC need
> > -        * to be saved across calls.
> > -        */
> > -       if (seen_tail_call(ctx) && seen_call(ctx))
> > -               move_reg(ctx, TCC_SAVED, REG_TCC);
> > -       else
> > -               emit_insn(ctx, nop);
> > -
> >         ctx->stack_size = stack_adjust;
> >  }
> > 
> > @@ -177,6 +181,17 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
> >         load_offset -= sizeof(long);
> >         emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
> > 
> > +       /*
> > +        *  When push into the stack, follow the order of tcc then tcc_ptr.
> > +        *  When pop from the stack, first pop tcc_ptr followed by tcc
> > +        */
> > +       load_offset -= 2*sizeof(long);
> > +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> > +
> > +       /* pop tcc_ptr to REG_TCC */
> > +       load_offset += sizeof(long);
> > +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> > +
> >         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
> > 
> >         if (!is_tail_call) {
> > @@ -211,7 +226,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
> >  static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
> >  {
> >         int off;
> > -       u8 tcc = tail_call_reg(ctx);
> > +       int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> >         u8 a1 = LOONGARCH_GPR_A1;
> >         u8 a2 = LOONGARCH_GPR_A2;
> >         u8 t1 = LOONGARCH_GPR_T1;
> > @@ -240,11 +255,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
> >                 goto toofar;
> > 
> >         /*
> > -        * if (--TCC < 0)
> > -        *       goto out;
> > +        * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
> > +        *      goto out;
> >          */
> > -       emit_insn(ctx, addid, REG_TCC, tcc, -1);
> > -       if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> > +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
> > +       emit_insn(ctx, ldd, t3, REG_TCC, 0);
> > +       emit_insn(ctx, addid, t3, t3, 1);
> > +       emit_insn(ctx, std, t3, REG_TCC, 0);
> > +       emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> > +       if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
> >                 goto toofar;
> > 
> >         /*
> > @@ -465,6 +484,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
> >         const s16 off = insn->off;
> >         const s32 imm = insn->imm;
> >         const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
> > +       int tcc_ptr_off;
> > 
> >         switch (code) {
> >         /* dst = src */
> > @@ -891,12 +911,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
> > 
> >         /* function call */
> >         case BPF_JMP | BPF_CALL:
> > -               mark_call(ctx);
> >                 ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
> >                                             &func_addr, &func_addr_fixed);
> >                 if (ret < 0)
> >                         return ret;
> > 
> > +               if (insn->src_reg == BPF_PSEUDO_CALL) {
> > +                       tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> > +                       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
> > +               }
> > +
> > +
> >                 move_addr(ctx, t1, func_addr);
> >                 emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
> > 
> > @@ -907,7 +932,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
> > 
> >         /* tail call */
> >         case BPF_JMP | BPF_TAIL_CALL:
> > -               mark_tail_call(ctx);
> >                 if (emit_bpf_tail_call(ctx, i) < 0)
> >                         return -EINVAL;
> >                 break;
> > --
> > 2.43.0
> > 


