Return-Path: <bpf+bounces-65710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C53B2782B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 07:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE160353B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 05:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13A23E347;
	Fri, 15 Aug 2025 05:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0523C4F4
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 05:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234756; cv=none; b=Uda/Ajdno+QMSb7qAyLI8YyV/iQTek12AypHi56TsSRG68VKPSJ4h/a1za3fG7xFkE7UlWpLESNroTvGxXKuDi+4I+EblmqbGXgPTFHK6WRoBYBxTLaBJ4KgemunO9QHSf2MnRmPPVISQFSNJjgP4z6NpBcYPiN+cIYkLmVDIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234756; c=relaxed/simple;
	bh=Dog3exO/aorcCvMabWNce1Bw7sN1SVblVpBToXmN65w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xu3xUH9ah/BGq1DAi5iue5dljrAnvH90r/TJVfJ1TArQqfsgJClGs3rX+C+Rw7y6WqFqcTIifb6YQYvZK0vl+/pMrUdMV4/Onqbcjgtlc0DlL2R621ze7Fx+iiCXWY7HwxOwclVHvaIj9sgyGdXeOuiMCl3tC0ZAl8qIlqen2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e75aaa6799611f0b29709d653e92f7d-20250815
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:aacd1591-9f86-44e3-a07f-df347ace9505,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:aacd1591-9f86-44e3-a07f-df347ace9505,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:70a2e57db8071772f045b94b1d89fda0,BulkI
	D:250815131227VPEW2MCW,BulkQuantity:0,Recheck:0,SF:10|24|38|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 6e75aaa6799611f0b29709d653e92f7d-20250815
X-User: jianghaoran@kylinos.cn
Received: from [172.30.70.212] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1340635349; Fri, 15 Aug 2025 13:12:25 +0800
Message-ID: <b71005cd990afe99895ca194c20bf3b3ddb75e82.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH=5D?= LoongArch: BPF: Fix
 incorrect return pointer value in the eBPF program
From: jianghaoran <jianghaoran@kylinos.cn>
To: Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org, kernel@xen0n.name, chenhuacai@kernel.org, 
 hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com,  sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com,  yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev,  andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
Date: Fri, 15 Aug 2025 13:11:11 +0800
In-Reply-To: <2e3f565b-0c5a-76d0-697f-31f0725de834@loongson.cn>
References: <20250814013412.108668-1-jianghaoran@kylinos.cn>
	 <2e3f565b-0c5a-76d0-697f-31f0725de834@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


在 2025-08-14星期四的 20:59 +0800，Jinyang He写道：
> On 2025-08-14 09:34, Haoran Jiang wrote:
> 
> > In some eBPF programs, the return value is a pointer.
> > When the kernel call an eBPF program (such as struct_ops),
> > it expects a 64-bit address to be returned, but instead a 32-
> > bit value.
> > 
> > Before applying this patch:
> > ./test_progs -a ns_bpf_qdisc
> > CPU 7 Unable to handle kernel paging request at virtual
> > address 0000000010440158.
> > 
> > As shown in the following test case,
> > bpf_fifo_dequeue return value is a pointer.
> > progs/bpf_qdisc_fifo.c
> > 
> > SEC("struct_ops/bpf_fifo_dequeue")
> > struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
> > {
> > 	struct sk_buff *skb = NULL;
> > 	........
> > 	skb = bpf_kptr_xchg(&skbn->skb, skb);
> > 	........
> > 	return skb;
> > }
> > 
> > kernel call bpf_fifo_dequeue：
> > net/sched/sch_generic.c
> > 
> > static struct sk_buff *dequeue_skb(struct Qdisc *q, bool
> > *validate,
> > 				   int *packets)
> > {
> > 	struct sk_buff *skb = NULL;
> > 	........
> > 	skb = q->dequeue(q);
> > 	.........
> > }
> > When accessing the skb, an address exception error will occur.
> > because the value returned by q->dequeue at this point is a 32-
> > bit
> > address rather than a 64-bit address.
> > 
> > After applying the patch：
> > ./test_progs -a ns_bpf_qdisc
> > Warning: sch_htb: quantum of class 10001 is small. Consider r2q
> > change.
> > 213/1   ns_bpf_qdisc/fifo:OK
> > 213/2   ns_bpf_qdisc/fq:OK
> > 213/3   ns_bpf_qdisc/attach to mq:OK
> > 213/4   ns_bpf_qdisc/attach to non root:OK
> > 213/5   ns_bpf_qdisc/incompl_ops:OK
> > 213     ns_bpf_qdisc:OK
> > Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return
> > values")
> > Signed-off-by: Haoran Jiang <
> > jianghaoran@kylinos.cn
> > >
> > ---
> >   arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/loongarch/net/bpf_jit.c
> > b/arch/loongarch/net/bpf_jit.c
> > index abfdb6bb5c38..7df067a42f36 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -229,8 +229,24 @@ static void __build_epilogue(struct
> > jit_ctx *ctx, bool is_tail_call)
> >   	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,
> > stack_adjust);
> >   
> >   	if (!is_tail_call) {
> > -		/* Set return value */
> > +		/*
> > +		 *  Set return value
> > +		 *  Check if the 64th bit in regmap[BPF_REG_0] is
> > 1. If it is,
> > +		 *  the value in regmap[BPF_REG_0] is a kernel-
> > space address.
> > +		 *
> > +		 *  t1 = regmap[BPF_REG_0] >> 63
> > +		 *  t2 = 1
> > +		 *  if(t2 == t1)
> > +		 *	move a0 <- regmap[BPF_REG_0]
> > +		 *  else
> > +		 *	addiw a0 <- regmap[BPF_REG_0] + 0
> > +		 */
> > +		emit_insn(ctx, srlid, LOONGARCH_GPR_T1,
> > regmap[BPF_REG_0], 63);
> > +		emit_insn(ctx, addid, LOONGARCH_GPR_T2,
> > LOONGARCH_GPR_ZERO, 0x1);
> > +		emit_cond_jmp(ctx, BPF_JEQ, LOONGARCH_GPR_T1,
> > LOONGARCH_GPR_T2, 3);
> 
> Hi, Haoran,
> 
> Just for codegen, we have many ways to avoid branch. Follows is
> a 
> possible way.
> 
> long long val = regmap[BPF_REG_0];
> int shift = 0 < val ? 32 : 0;
> return (val << shift) >> shift;
> 
> slt    t0, zero, BPF_REG_0
> slli.d t0, t0, 5
> sll.d  BPF_REG_0, BPF_REG_0, t0
> sra.d  BPF_REG_0, BPF_REG_0, t0

Thanks, this code is better.

> >   		emit_insn(ctx, addiw, LOONGARCH_GPR_A0,
> > regmap[BPF_REG_0], 0);
> > +		emit_uncond_jmp(ctx, 2);
> > +		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> >   		/* Return to the caller */
> >   		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO,
> > LOONGARCH_GPR_RA, 0);
> >   	} else {


