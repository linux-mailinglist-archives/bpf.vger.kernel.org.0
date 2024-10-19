Return-Path: <bpf+bounces-42500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769D9A4C7A
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58F6283DD3
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149A1DE4D9;
	Sat, 19 Oct 2024 09:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEA18D645
	for <bpf@vger.kernel.org>; Sat, 19 Oct 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329322; cv=none; b=Fjtb6M9Vugq1ZbSccWOBmYToBQRlqqarsMRZfzShfkWFWBzOF4Wx25JECNTW+wMgNGymhgX0LfG4CG5it6K5IxcfYeo47nlm7MFWpMnW+DYXcKnLDukUTvX7e7gXu8b0RMfiXgQEkGTfG7MUXTOYLCPZegvJhHU8oCqbJkQfhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329322; c=relaxed/simple;
	bh=fw/sWlH+obU7YLvSndcbTehqytPOO/8XiKYUce3robo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uib9iokVNCS6R0SsIX8l7rIeVqCiCFZv+PVQIvkoQf2wb/gvAr/Xy1luFmYdqHd7IhgKNnN7uLc2EaiYN1wdMHCMMZ1MYA8V3gbu+xgRx34vXwUkC1V1uD4TOWEE38bMjc/PLMqtnK98l6WDP64qXZxqfkyEQ8gDL/q/X9KCrGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XVwrX2xNbz4f3jM1
	for <bpf@vger.kernel.org>; Sat, 19 Oct 2024 17:14:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A87251A092F
	for <bpf@vger.kernel.org>; Sat, 19 Oct 2024 17:15:09 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgAnniqceBNnwk6REQ--.26035S2;
	Sat, 19 Oct 2024 17:15:09 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf] bpf, arm64: Fix stack frame construction for struct_ops trampoline
Date: Sat, 19 Oct 2024 17:27:09 +0800
Message-Id: <20241019092709.128359-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnniqceBNnwk6REQ--.26035S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr17XF1fXrWfCryxtry8AFb_yoWrGw1rpr
	1fCry5AF4xXr45XF9Ygr4xAF1Fyan7tw1UKFWUC3yrCa4FvrW3KF18trWjyrZ3XryfCw17
	uFWjyrn7CryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	mjg7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The callsite layout for arm64 fentry is:

mov x9, lr
nop

When a bpf prog is attached, the nop instruction is patched to a call
to bpf trampoline:

mov x9, lr
bl <bpf trampoline>

This passes two return addresses to bpf trampoline: the return address
for the traced function/prog, stored in x9, and the return address for
the bpf trampoline, stored in lr. To ensure stacktrace works properly,
the bpf trampoline constructs two fake function stack frames using x9
and lr.

However, struct_ops progs are used as function callbacks and are invoked
directly, without x9 being set as the fentry callsite does. Therefore,
only one stack frame should be constructed using lr for struct_ops.

Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 47 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8bbd0b20136a..f8fec244c0c2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2094,6 +2094,12 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
 	}
 }
 
+static bool is_struct_ops_tramp(const struct bpf_tramp_links *fentry_links)
+{
+	return fentry_links->nr_links == 1 &&
+		fentry_links->links[0]->link.type == BPF_LINK_TYPE_STRUCT_OPS;
+}
+
 /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
  *
  * bpf prog and function entry before bpf trampoline hooked:
@@ -2123,6 +2129,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	bool save_ret;
 	__le32 **branches = NULL;
+	bool is_struct_ops = is_struct_ops_tramp(fentry);
 
 	/* trampoline stack layout:
 	 *                  [ parent ip         ]
@@ -2191,11 +2198,14 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 */
 	emit_bti(A64_BTI_JC, ctx);
 
-	/* frame for parent function */
-	emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
-	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
+	/* x9 is not set for struct_ops */
+	if (!is_struct_ops) {
+		/* frame for parent function */
+		emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
+		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
+	}
 
-	/* frame for patched function */
+	/* frame for patched function for tracing, or caller for struct_ops */
 	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
 	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
 
@@ -2281,19 +2291,24 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* reset SP  */
 	emit(A64_MOV(1, A64_SP, A64_FP), ctx);
 
-	/* pop frames  */
-	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
-	emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
-
-	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
-		/* skip patched function, return to parent */
-		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
-		emit(A64_RET(A64_R(9)), ctx);
+	if (is_struct_ops) {
+		emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
+		emit(A64_RET(A64_LR), ctx);
 	} else {
-		/* return to patched function */
-		emit(A64_MOV(1, A64_R(10), A64_LR), ctx);
-		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
-		emit(A64_RET(A64_R(10)), ctx);
+		/* pop frames */
+		emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
+		emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
+
+		if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+			/* skip patched function, return to parent */
+			emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
+			emit(A64_RET(A64_R(9)), ctx);
+		} else {
+			/* return to patched function */
+			emit(A64_MOV(1, A64_R(10), A64_LR), ctx);
+			emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
+			emit(A64_RET(A64_R(10)), ctx);
+		}
 	}
 
 	kfree(branches);
-- 
2.43.0


