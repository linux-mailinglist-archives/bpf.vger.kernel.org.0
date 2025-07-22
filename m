Return-Path: <bpf+bounces-64008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E31B0D608
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B23BA947
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC32DCBFA;
	Tue, 22 Jul 2025 09:34:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6587239E8B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176891; cv=none; b=fwWYPTx3FbWYdVZT1EAWFzDm5CAXGKPpS8aJ3bxHOL7aEfNTps2/Xbu4VcidnzxoYBb7SDciyQjHXW8k06eLTXtu2JEOeND9sJjh59UBlsrTQnomUmM3oSY+8GjE0Gp+dG3+y2hAqCdTPM8NL0fTk31PEam3TSU62ml+lQXg9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176891; c=relaxed/simple;
	bh=iFKePA9680XzRjV70hdBXc62Hpz8lkQ7fU85KVFrFy0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldO3wn+mVlxsSe1gtCjOmnRxSPJGvFsH5d1YgIUiWoJSc3Ul4xYGFxgldkGzakkumSQiX1AHT2Xc/HKnDJckP+Nz4NVR156P6ehxrgLgR6CmwJEP6gb+YoDJpmC1aB4GQ2BeOf564bsxpthV6T4/pEGuM4QIo2ROzvKCN8SAhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 18955a6066df11f0b29709d653e92f7d-20250722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1e3a7a24-7a6d-406e-a4ea-fac57fd3d0f4,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:1e3a7a24-7a6d-406e-a4ea-fac57fd3d0f4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:b991f3ddc67df1f5aacca9efeaa9fb13,BulkI
	D:250722173443WLR6NJDC,BulkQuantity:0,Recheck:0,SF:10|24|44|64|66|78|80|81
	|82|83|102|841,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 18955a6066df11f0b29709d653e92f7d-20250722
X-User: jianghaoran@kylinos.cn
Received: from [192.168.31.67] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 733763614; Tue, 22 Jul 2025 17:34:42 +0800
Message-ID: <4443b6e55d74fd2b78e6790b0719b32e70a0df00.camel@kylinos.cn>
Subject: =?gb2312?Q?re=A3=BA=5BPATCH?= v2 1/2] LoongArch: BPF: Optimize the
 calculation method of jmp_offset in the emit_bpf_tail_call function
From: jianghaoran <jianghaoran@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
 chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com,  sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com,  yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev,  andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
Date: Tue, 22 Jul 2025 17:34:37 +0800
In-Reply-To: <CAEyhmHRUQV5JROOO+PyuZoLuFRrVJ-eeYH5hMf9gtVXW18aa8w@mail.gmail.com>
References: <20250708071840.556686-1-jianghaoran@kylinos.cn>
	 <20250708071840.556686-2-jianghaoran@kylinos.cn>
	 <CAEyhmHRUQV5JROOO+PyuZoLuFRrVJ-eeYH5hMf9gtVXW18aa8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit





在 2025-07-16星期三的 09:31 +0800，Hengqi Chen写道：
> Hi Haoran,
> 
> On Tue, Jul 8, 2025 at 3:19 PM Haoran Jiang <
jianghaoran@kylinos.cn> > wrote:
> > 
> > The extra pass of bpf_int_jit_compile() skips JIT context initialization
> > which essentially skips offset calculation leaving out_offset = -1,
> > the jmp_offset in emit_bpf_tail_call is calculated
> > by #define jmp_offset (out_offset - (cur_offset)) is a negative number,
> > which does not meet expectations.The final generated assembly as follow.
> > 
> 
> "does not meet expectations" ? Simply "is wrong" ?
> 
> The subject line should be something like:
>   Fix jump offset calculation in tailcall
> 
> It's a fix, not optimization.
> 
> Other than that, feel free to add:
> Reviewed-by: Hengqi Chen <
hengqi.chen@gmail.com> >
I will make the modification in the next version.

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
> > Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > Signed-off-by: Haoran Jiang <
> > jianghaoran@kylinos.cn
> > >
> > ---
> >  arch/loongarch/net/bpf_jit.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/loongarch/net/bpf_jit.c
> > b/arch/loongarch/net/bpf_jit.c
> > index fa1500d4aa3e..5061bfc978f2 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
> >         return true;
> >  }
> > 
> > -/* initialized on the first pass of build_body() */
> > -static int out_offset = -1;
> > -static int emit_bpf_tail_call(struct jit_ctx *ctx)
> > +static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
> >  {
> >         int off;
> >         u8 tcc = tail_call_reg(ctx);
> > @@ -220,9 +218,10 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >         u8 t2 = LOONGARCH_GPR_T2;
> >         u8 t3 = LOONGARCH_GPR_T3;
> >         const int idx0 = ctx->idx;
> > +       int tc_ninsn = 0;
> > 
> >  #define cur_offset (ctx->idx - idx0)
> > -#define jmp_offset (out_offset - (cur_offset))
> > +#define jmp_offset (tc_ninsn - (cur_offset))
> > 
> >         /*
> >          * a0: &ctx
> > @@ -232,6 +231,8 @@ static int emit_bpf_tail_call(struct
> > jit_ctx *ctx)
> >          * if (index >= array->map.max_entries)
> >          *       goto out;
> >          */
> > +       tc_ninsn = insn ? ctx->offset[insn+1] - ctx-
> > >offset[insn] :
> > +               ctx->offset[0];
> >         off = offsetof(struct bpf_array, map.max_entries);
> >         emit_insn(ctx, ldwu, t1, a1, off);
> >         /* bgeu $a2, $t1, jmp_offset */
> > @@ -263,15 +264,6 @@ static int emit_bpf_tail_call(struct
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
> > @@ -916,7 +908,7 @@ static int build_insn(const struct bpf_insn
> > *insn, struct jit_ctx *ctx, bool ext
> >         /* tail call */
> >         case BPF_JMP | BPF_TAIL_CALL:
> >                 mark_tail_call(ctx);
> > -               if (emit_bpf_tail_call(ctx) < 0)
> > +               if (emit_bpf_tail_call(ctx, i) < 0)
> >                         return -EINVAL;
> >                 break;
> > 
> > @@ -1342,7 +1334,6 @@ struct bpf_prog
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
> > 


