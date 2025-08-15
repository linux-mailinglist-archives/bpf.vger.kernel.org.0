Return-Path: <bpf+bounces-65736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C4B27B0B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88265C77E2
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7A24729D;
	Fri, 15 Aug 2025 08:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C020F087
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246622; cv=none; b=aH5ftVkCOfuh4/m1te9UZu2jfzzt/kD5CdzMps3HC2cDbgGM5+/ZGYyTiCMJyOdAQ7kus5DBfSiEF6iZO3JTqCp1kR8nFxOhPam7Xk3xnX2Jucw1pT3sPz/VlWQ6Cp7pWk2Qb/G6BJpuorjWww5Jvn/E2nWhKajWQEiGAlyYYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246622; c=relaxed/simple;
	bh=xdScbArZyDvCizwzEcKsOWBk4+hm00etp3Piahm2JvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hMMiTbbt1fxR2ceXwu7ISOuJCZQ8S1ppgMbxgxwENJJ0HMeebuhzv6WYut/pH7Y/ZCAQK5C6yz2Dqf9o4EbxUne83UL282BE8O9ZBHvT5CbtmlBoxs7G5aVJkrekgPh+DwvwPAQ3Vtc0FFPZMOKeirZfw5qjKidSnCtOBUp+ZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1006923e79b211f0b29709d653e92f7d-20250815
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e9a5f244-8b51-4764-ba9b-8bdb80bff79a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-INFO: VERSION:1.1.45,REQID:e9a5f244-8b51-4764-ba9b-8bdb80bff79a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:1f90c40ad946df675a3ec111a452a776,BulkI
	D:250815163015LSX0GZ51,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|102,TC:n
	il,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 1006923e79b211f0b29709d653e92f7d-20250815
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1480246910; Fri, 15 Aug 2025 16:30:12 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v2] LoongArch: BPF: Fix incorrect return pointer value in the eBPF program
Date: Fri, 15 Aug 2025 16:29:31 +0800
Message-Id: <20250815082931.875216-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some eBPF programs, the return value is a pointer.
When the kernel call an eBPF program (such as struct_ops),
it expects a 64-bit address to be returned, but instead a 32-bit value.

Before applying this patch:
./test_progs -a ns_bpf_qdisc
CPU 7 Unable to handle kernel paging request at virtual
address 0000000010440158.

As shown in the following test case,
bpf_fifo_dequeue return value is a pointer.
progs/bpf_qdisc_fifo.c

SEC("struct_ops/bpf_fifo_dequeue")
struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
{
	struct sk_buff *skb = NULL;
	........
	skb = bpf_kptr_xchg(&skbn->skb, skb);
	........
	return skb;
}

kernel call bpf_fifo_dequeue：
net/sched/sch_generic.c

static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
				   int *packets)
{
	struct sk_buff *skb = NULL;
	........
	skb = q->dequeue(q);
	.........
}
When accessing the skb, an address exception error will occur.
because the value returned by q->dequeue at this point is a 32-bit
address rather than a 64-bit address.

After applying the patch：
./test_progs -a ns_bpf_qdisc
Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
213/1   ns_bpf_qdisc/fifo:OK
213/2   ns_bpf_qdisc/fq:OK
213/3   ns_bpf_qdisc/attach to mq:OK
213/4   ns_bpf_qdisc/attach to non root:OK
213/5   ns_bpf_qdisc/incompl_ops:OK
213     ns_bpf_qdisc:OK
Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED

Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>

----------
v2:
1,add emit_slt* helpers
2,Use slt/slld/srad instructions to avoid branch
---
 arch/loongarch/include/asm/inst.h |  8 ++++++++
 arch/loongarch/net/bpf_jit.c      | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 277d2140676b..20f4fc745bea 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -92,6 +92,8 @@ enum reg2i6_op {
 };
 
 enum reg2i12_op {
+	slti_op         = 0x08,
+	sltui_op        = 0x09,
 	addiw_op	= 0x0a,
 	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
@@ -148,6 +150,8 @@ enum reg3_op {
 	addd_op		= 0x21,
 	subw_op		= 0x22,
 	subd_op		= 0x23,
+	slt_op          = 0x24,
+	sltu_op         = 0x25,
 	nor_op		= 0x28,
 	and_op		= 0x29,
 	or_op		= 0x2a,
@@ -629,6 +633,8 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 	insn->reg2i12_format.rj = rj;					\
 }
 
+DEF_EMIT_REG2I12_FORMAT(slti, slti_op)
+DEF_EMIT_REG2I12_FORMAT(sltui, sltui_op)
 DEF_EMIT_REG2I12_FORMAT(addiw, addiw_op)
 DEF_EMIT_REG2I12_FORMAT(addid, addid_op)
 DEF_EMIT_REG2I12_FORMAT(lu52id, lu52id_op)
@@ -729,6 +735,8 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 DEF_EMIT_REG3_FORMAT(addw, addw_op)
 DEF_EMIT_REG3_FORMAT(addd, addd_op)
 DEF_EMIT_REG3_FORMAT(subd, subd_op)
+DEF_EMIT_REG3_FORMAT(slt, slt_op)
+DEF_EMIT_REG3_FORMAT(sltu, sltu_op)
 DEF_EMIT_REG3_FORMAT(muld, muld_op)
 DEF_EMIT_REG3_FORMAT(divd, divd_op)
 DEF_EMIT_REG3_FORMAT(modd, modd_op)
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..50067be79c4f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -229,8 +229,21 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (!is_tail_call) {
-		/* Set return value */
-		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
+		/*
+		 *  Set return value
+		 *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If it is,
+		 *  the value in regmap[BPF_REG_0] is a kernel-space address.
+
+		 *  long long val = regmap[BPF_REG_0];
+		 *  int shift = 0 < val ? 32 : 0;
+		 *  return (val << shift) >> shift;
+		 */
+		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
+		emit_insn(ctx, slt, LOONGARCH_GPR_T0, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_A0);
+		emit_insn(ctx, sllid, LOONGARCH_GPR_T0, LOONGARCH_GPR_T0, 5);
+		emit_insn(ctx, slld, LOONGARCH_GPR_A0, LOONGARCH_GPR_A0, LOONGARCH_GPR_T0);
+		emit_insn(ctx, srad, LOONGARCH_GPR_A0, LOONGARCH_GPR_A0, LOONGARCH_GPR_T0);
+
 		/* Return to the caller */
 		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
 	} else {
-- 
2.43.0


