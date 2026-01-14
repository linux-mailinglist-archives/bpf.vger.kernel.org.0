Return-Path: <bpf+bounces-78856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4658D1D770
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 011AF300EE55
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57B389455;
	Wed, 14 Jan 2026 09:19:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63937F732;
	Wed, 14 Jan 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382382; cv=none; b=bpXiZJemrinaigmCa6Hm+LOA5QCZ1CUU9Dya2rPhUgrjYkZQW2eJt6t48wM0I+c1wm1y9BZsehv6NecklbtVo49+yGK6k4J/U8IREiRkugXJt7TwyVDtVqf4+GMHygg5KL6MbuF0hEW/lcOrQrsn9qmqQWrftEOXDvKwEgp5rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382382; c=relaxed/simple;
	bh=c8YoUE4ujbZcNATjKXA/sAyyBDxZVcJjqtu9JZ9t+O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYC3EtPMuOsJL90jWdV66gDbJKhhuxrFhQ+bBeh180hsiv7HgdFiLWFzXlaT3Yo42GqN9btbOpfawlykiT5U4Ervu6SbjcJFboXBpzML8uawV15lC78kSzc0aVvdh/YC/MB8vRA/vLZ4X+qEyA1po74+/siqT2m32pIW4okqP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4drgXG2Vl4zKHMSk;
	Wed, 14 Jan 2026 17:18:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2B16E40576;
	Wed, 14 Jan 2026 17:19:30 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgCXsYCfX2dpDhLdDg--.16789S5;
	Wed, 14 Jan 2026 17:19:30 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v4 3/4] bpf, x86: Emit ENDBR for indirect jump targets
Date: Wed, 14 Jan 2026 17:39:13 +0800
Message-ID: <20260114093914.2403982-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXsYCfX2dpDhLdDg--.16789S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DXF1DAFW8JrWfur1Dtrb_yoW5CF1Upa
	9xArySvrZ8Wr4qyrnrXF47Ary7AF4qgryxXF4ft3yfZwsxWryagF1aga4SqFy5JryfArs3
	Xa4UAF1Du3WkuwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8D5r7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

On CPUs that support CET/IBT, the indirect jump selftest triggers
a kernel panic because the indirect jump targets lack ENDBR
instructions.

To fix it, emit an ENDBR instruction to each indirect jump target. Since
the ENDBR instruction shifts the position of original jited instructions,
fix the instruction address calculation wherever the addresses are used.

For reference, below is a sample panic log.

 Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
 ------------[ cut here ]------------
 kernel BUG at arch/x86/kernel/cet.c:133!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI

 ...

  ? 0xffffffffc00fb258
  ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
  bpf_prog_test_run_syscall+0x110/0x2f0
  ? fdget+0xba/0xe0
  __sys_bpf+0xe4b/0x2590
  ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
  ? bpf_prog_test_run_syscall+0x215/0x2f0
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0x85/0x620
  ? bpf_prog_test_run_syscall+0x1e2/0x2f0

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..ef79baac42d7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1733,6 +1733,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				dst_reg = X86_REG_R9;
 		}
 
+		if (bpf_insn_is_indirect_target(bpf_prog, i - 1))
+			EMIT_ENDBR();
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2439,7 +2442,7 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
-			u8 *ip = image + addrs[i - 1];
+			u8 *ip = image + addrs[i - 1] + (prog - temp);
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -2464,7 +2467,8 @@ st:			if (is_imm8(insn->off))
 			if (imm32)
 				emit_bpf_tail_call_direct(bpf_prog,
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, image + addrs[i - 1],
+							  &prog,
+							  image + addrs[i - 1] + (prog - temp),
 							  callee_regs_used,
 							  stack_depth,
 							  ctx);
@@ -2473,7 +2477,7 @@ st:			if (is_imm8(insn->off))
 							    &prog,
 							    callee_regs_used,
 							    stack_depth,
-							    image + addrs[i - 1],
+							    image + addrs[i - 1] + (prog - temp),
 							    ctx);
 			break;
 
@@ -2638,7 +2642,8 @@ st:			if (is_imm8(insn->off))
 			break;
 
 		case BPF_JMP | BPF_JA | BPF_X:
-			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			emit_indirect_jump(&prog, insn->dst_reg,
+					   image + addrs[i - 1] + (prog - temp));
 			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
@@ -2728,7 +2733,7 @@ st:			if (is_imm8(insn->off))
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
-				u8 *ip = image + addrs[i - 1];
+				u8 *ip = image + addrs[i - 1] + (prog - temp);
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
 					return -EINVAL;
-- 
2.47.3


