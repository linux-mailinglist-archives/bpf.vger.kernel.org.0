Return-Path: <bpf+bounces-65593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3BB25927
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 03:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F47AF77A
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 01:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5501F4262;
	Thu, 14 Aug 2025 01:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2817A2E1
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135281; cv=none; b=PnT5ey9Gqy0E4Wf8BSJrtjLWmktyBPitWWx5/UeI1P4OxjGgvhtQh9H4saNFsDX2YXklY6pxjNQdXFlrNTP6XyoZPTdeulvxoAqAg+jew7aI6KCt8P+HGyfZJ5zOr2JVEjc9okmRBL3tmeVixJih9QHub/+x5GPAVYh3G7f3+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135281; c=relaxed/simple;
	bh=kShqBeuqD5iArWlk+7X8fUPlsDhhwjtxDG+BgMQwJNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JmK5oQENNJeGjenZ/9IS2EKKtii0aubLk2Tvp6V2hAc0QiJtGXSMRyV+nWbRc5LjC5Z20NLWVUCbPnDY2xt2h0TFvbvXxvoUwXN8S5DLOvFhQfCndD5UzakmM1sUVqQMufgbUjDDASJljMYYxmgYcdfhh+gl2lGq2QoWrCMOUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d4e66c5078ae11f0b29709d653e92f7d-20250814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ce6aab69-ac94-41bd-8d04-2c85f21ce708,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:ce6aab69-ac94-41bd-8d04-2c85f21ce708,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:e4415ac137068210346248d78d3fa50a,BulkI
	D:250814093435CO38H19R,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|102,TC:n
	il,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: d4e66c5078ae11f0b29709d653e92f7d-20250814
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1602437645; Thu, 14 Aug 2025 09:34:33 +0800
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
	ast@kernel.org
Subject: [PATCH] LoongArch: BPF: Fix incorrect return pointer value in the eBPF program
Date: Thu, 14 Aug 2025 09:34:12 +0800
Message-Id: <20250814013412.108668-1-jianghaoran@kylinos.cn>
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
Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..7df067a42f36 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -229,8 +229,24 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (!is_tail_call) {
-		/* Set return value */
+		/*
+		 *  Set return value
+		 *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If it is,
+		 *  the value in regmap[BPF_REG_0] is a kernel-space address.
+		 *
+		 *  t1 = regmap[BPF_REG_0] >> 63
+		 *  t2 = 1
+		 *  if(t2 == t1)
+		 *	move a0 <- regmap[BPF_REG_0]
+		 *  else
+		 *	addiw a0 <- regmap[BPF_REG_0] + 0
+		 */
+		emit_insn(ctx, srlid, LOONGARCH_GPR_T1, regmap[BPF_REG_0], 63);
+		emit_insn(ctx, addid, LOONGARCH_GPR_T2, LOONGARCH_GPR_ZERO, 0x1);
+		emit_cond_jmp(ctx, BPF_JEQ, LOONGARCH_GPR_T1, LOONGARCH_GPR_T2, 3);
 		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
+		emit_uncond_jmp(ctx, 2);
+		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
 		/* Return to the caller */
 		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
 	} else {
-- 
2.43.0


