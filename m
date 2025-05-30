Return-Path: <bpf+bounces-59340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39C4AC85FA
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE324A619F
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750661547D2;
	Fri, 30 May 2025 01:22:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C078F59;
	Fri, 30 May 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568133; cv=none; b=GvcoEKWzIkdnVmwAPUcYw3/ioxJQEnGi3ppzvLf/DXY24V3WA1R3vhbG37DSCFor7dGDGwoza9Y55HjHt1TYGUMBCqpvwA+co4XouocNlriTvBL7Av/uf+XhWGdRHycsgPZO/1vUmYdXKxRrpc7n4bB+RYp33XrudMywnTEKc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568133; c=relaxed/simple;
	bh=cPZgUdjIWra0PdLQpoq1G4ikubdy55BGyBeN7H0ghQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGgcm+Y/UsTtcoj0zO+tDRD8PDK3hGT51wfgeT9CBNrF+orZf6rWJjIQG7d9y80g94Us0XbGjjE5I4pO0Arrq8d6Cyp+soi4z6s+gqMEJCncPyEDOZi9MihQWqRtkXxBkL4khyrK3ckCFlzq+CoSLpgFzOdLh3Tk1nnJMjxaQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7aeb099a3cf411f0b29709d653e92f7d-20250530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:61bc4a82-4730-41a2-ae0f-7d2ed25cec8c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:61bc4a82-4730-41a2-ae0f-7d2ed25cec8c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:7101c88277929fe5165bb6c834cba4f3,BulkI
	D:250529133829GCJDP53I,BulkQuantity:1,Recheck:0,SF:17|19|24|43|64|66|74|78
	|80|81|82|83|100|101|102|841,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:99|1,Fil
	e:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DK
	R:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 7aeb099a3cf411f0b29709d653e92f7d-20250530
X-User: jianghaoran@kylinos.cn
Received: from [192.168.31.67] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1991867234; Fri, 30 May 2025 09:21:58 +0800
Message-ID: <68ec5a7f3cc63dc19397b3ce0649716e0fac8d49.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH=5D?= LoongArch: BPF: Optimize
 the calculation method of jmp_offset in the emit_bpf_tail_call function
From: jianghaoran <jianghaoran@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@xen0n.name, chenhuacai@kernel.org, 
 yangtiezhu@loongson.cn, haoluo@google.com, jolsa@kernel.org,
 sdf@fomichev.me,  kpsingh@kernel.org, john.fastabend@gmail.com,
 yonghong.song@linux.dev,  song@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, andrii@kernel.org,  daniel@iogearbox.net
Date: Fri, 30 May 2025 09:21:54 +0800
In-Reply-To: <CAEyhmHTg3xNMBrSxXQj96pvfD83t6_RHRT_GGtbBzOpAKztDpw@mail.gmail.com>
References: <20250528104032.1237415-1-jianghaoran@kylinos.cn>
	 <CAEyhmHTg3xNMBrSxXQj96pvfD83t6_RHRT_GGtbBzOpAKztDpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit





在 2025-05-29星期四的 10:02 +0800，Hengqi Chen写道：
> Hi Haoran,
> 
> On Wed, May 28, 2025 at 6:40 PM Haoran Jiang <
> jianghaoran@kylinos.cn
> > wrote:
> > For a ebpf subprog JIT，the last call bpf_int_jit_compile
> > function will
> > directly enter the skip_init_ctx process. At this point,
> > out_offset = -1,
> > the jmp_offset in emit_bpf_tail_call is calculated
> > by #define jmp_offset (out_offset - (cur_offset)) is a negative
> > number,
> > which does not meet expectations.The final generated assembly
> > as follow.
> > 
> > 54:     bgeu            $a2, $t1, -8        # 0x0000004c
> > 58:     addi.d          $a6, $s5, -1
> > 5c:     bltz            $a6, -16            # 0x0000004c
> > 60:     alsl.d          $t2, $a2, $a1, 0x3
> > 64:     ld.d            $t2, $t2, 264
> > 68:     beq             $t2, $zero, -28     # 0x0000004c
> > 
> > Before apply this patch, the follow test case will reveal soft
> > lock issues.
> > 
> > cd tools/testing/selftests/bpf/
> > ./test_progs --allow=tailcalls/tailcall_bpf2bpf_1
> > 
> > dmesg:
> > watchdog: BUG: soft lockup - CPU#2 stuck for 26s!
> > [test_progs:25056]
> > 
> 
> This is a known issue. Does this change pass all tailcall tests ?
> If not, please refer to the tailcall hierarchy patchset([1]).
> We should address it once and for all. Thanks.
> 
>   [1]: 
> https://lore.kernel.org/bpf/20240714123902.32305-1-hffilwlqm@gmail.com/
> 
> Thanks,I'll keep looking into these patches.
> > Signed-off-by: Haoran Jiang <
> > jianghaoran@kylinos.cn
> > >
> > ---
> >  arch/loongarch/net/bpf_jit.c | 28 +++++++++-------------------
> >  1 file changed, 9 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/loongarch/net/bpf_jit.c
> > b/arch/loongarch/net/bpf_jit.c
> > index fa1500d4aa3e..d85490e7de89 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
> >         return true;
> >  }
> > 
> > -/* initialized on the first pass of build_body() */
> > -static int out_offset = -1;
> > -static int emit_bpf_tail_call(struct jit_ctx *ctx)
> > +static int emit_bpf_tail_call(int insn, struct jit_ctx *ctx)
> >  {
> >         int off;
> >         u8 tcc = tail_call_reg(ctx);
> > @@ -220,9 +218,8 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >         u8 t2 = LOONGARCH_GPR_T2;
> >         u8 t3 = LOONGARCH_GPR_T3;
> >         const int idx0 = ctx->idx;
> > -
> > -#define cur_offset (ctx->idx - idx0)
> > -#define jmp_offset (out_offset - (cur_offset))
> > +       int tc_ninsn = 0;
> > +       int jmp_offset = 0;
> > 
> >         /*
> >          * a0: &ctx
> > @@ -232,8 +229,11 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >          * if (index >= array->map.max_entries)
> >          *       goto out;
> >          */
> > +       tc_ninsn = insn ? ctx->offset[insn+1] - ctx-
> > >offset[insn] :
> > +               ctx->offset[0];
> >         off = offsetof(struct bpf_array, map.max_entries);
> >         emit_insn(ctx, ldwu, t1, a1, off);
> > +       jmp_offset = tc_ninsn - (ctx->idx - idx0);
> >         /* bgeu $a2, $t1, jmp_offset */
> >         if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset)
> > < 0)
> >                 goto toofar;
> > @@ -243,6 +243,7 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >          *       goto out;
> >          */
> >         emit_insn(ctx, addid, REG_TCC, tcc, -1);
> > +       jmp_offset = tc_ninsn - (ctx->idx - idx0);
> >         if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC,
> > LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> >                 goto toofar;
> > 
> > @@ -254,6 +255,7 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >         emit_insn(ctx, alsld, t2, a2, a1, 2);
> >         off = offsetof(struct bpf_array, ptrs);
> >         emit_insn(ctx, ldd, t2, t2, off);
> > +       jmp_offset = tc_ninsn - (ctx->idx - idx0);
> >         /* beq $t2, $zero, jmp_offset */
> >         if (emit_tailcall_jmp(ctx, BPF_JEQ, t2,
> > LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> >                 goto toofar;
> > @@ -263,22 +265,11 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >         emit_insn(ctx, ldd, t3, t2, off);
> >         __build_epilogue(ctx, true);
> > 
> > -       /* out: */
> > -       if (out_offset == -1)
> > -               out_offset = cur_offset;
> > -       if (cur_offset != out_offset) {
> > -               pr_err_once("tail_call out_offset = %d,
> > expected %d!\n",
> > -                           cur_offset, out_offset);
> > -               return -1;
> > -       }
> > -
> >         return 0;
> > 
> >  toofar:
> >         pr_info_once("tail_call: jump too far\n");
> >         return -1;
> > -#undef cur_offset
> > -#undef jmp_offset
> >  }
> > 
> >  static void emit_atomic(const struct bpf_insn *insn, struct
> > jit_ctx *ctx)
> > @@ -916,7 +907,7 @@ static int build_insn(const struct bpf_insn
> > *insn, struct jit_ctx *ctx, bool ext
> >         /* tail call */
> >         case BPF_JMP | BPF_TAIL_CALL:
> >                 mark_tail_call(ctx);
> > -               if (emit_bpf_tail_call(ctx) < 0)
> > +               if (emit_bpf_tail_call(i, ctx) < 0)
> >                         return -EINVAL;
> >                 break;
> > 
> > @@ -1342,7 +1333,6 @@ struct bpf_prog
> > *bpf_int_jit_compile(struct bpf_prog *prog)
> >         if (tmp_blinded)
> >                 bpf_jit_prog_release_other(prog, prog ==
> > orig_prog ? tmp : orig_prog);
> > 
> > -       out_offset = -1;
> > 
> >         return prog;
> > 
> > --
> > 2.43.0
> > 


