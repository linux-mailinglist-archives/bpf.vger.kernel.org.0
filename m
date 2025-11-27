Return-Path: <bpf+bounces-75642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA7C8E848
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 14:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90983B1415
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5F27F163;
	Thu, 27 Nov 2025 13:41:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BE2798E6
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250881; cv=none; b=YPQHrwPy8vP7cHDu1VXmn8PPO9grhbhioE54TklKUkCUgFSXu9Q3yBYCXikEPJe3Xp6GoUYFu/Gtwe+iIbgNHyPJFLYibCdHPrxpK5WDlZhrPRxYz6sXvtAPiBT2J+pGnwul8S3oYmGGshL6Gk6or8895IoSiSf6rX/d+fcg4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250881; c=relaxed/simple;
	bh=vGd+OastrpMAF+vCqKyI/dIztU44IrXbnn/GPmmO8O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLZhC1b5GzJSC3KozGRIFEtnsD1jklX+dkS0XqNffiSU6eFA6s4r3S5yu6TLDtDFdn4321EWhBQXqfvs2XQAmispBbR4r/9CilAfXNcKuiDbYUsYfUsWuCwi7oU6YG5IUVtU/ZCnmR1fei37m8VR6k3G4t/RVFWtKYvo9Pm6of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dHHcP22CDzYQtjG
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 21:40:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E6AB61A07E8
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 21:41:14 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgC3PUf5VChplyK6CA--.43834S2;
	Thu, 27 Nov 2025 21:41:14 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yhs@fb.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next] bpf: arm64: Fix panic due to missing BTI at indirect jump targets
Date: Thu, 27 Nov 2025 22:03:18 +0800
Message-ID: <20251127140318.3944249-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3PUf5VChplyK6CA--.43834S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyxtr1kZw4xCw48uF4kWFg_yoW7ZF4fpF
	WDG345ArW0grWxWrnrJa18Ary3JF4kG3ZxKFWfK3yS93WYqr95GayrKFsIyF13GryUCF1f
	XF4q9ryrW3yUX37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When BTI is enabled, the indirect jump selftest triggers BTI exception:

Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
...
Call trace:
 bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
 bpf_prog_run_pin_on_cpu+0x140/0x468
 bpf_prog_test_run_syscall+0x280/0x3b8
 bpf_prog_test_run+0x22c/0x2c0
 __sys_bpf+0x4d8/0x5c8
 __arm64_sys_bpf+0x88/0xa8
 invoke_syscall+0x80/0x220
 el0_svc_common+0x160/0x1d0
 do_el0_svc+0x54/0x70
 el0_svc+0x54/0x188
 el0t_64_sync_handler+0x84/0x130
 el0t_64_sync+0x198/0x1a0

This happens because no BTI instruction is generated by the JIT for
indirect jump targets.

Fix it by emitting BTI instruction for every possible indirect jump
targets when BTI is enabled. The targets are identified by traversing
all instruction arrays used by the BPF program, since indirect jump
targets can only be read from instruction arrays.

Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++
 include/linux/bpf.h           | 12 ++++++++++
 kernel/bpf/bpf_insn_array.c   | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 929123a5431a..f546df886049 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -78,6 +78,7 @@ static const int bpf2a64[] = {
 
 struct jit_ctx {
 	const struct bpf_prog *prog;
+	unsigned long *indirect_targets;
 	int idx;
 	int epilogue_offset;
 	int *offset;
@@ -1199,6 +1200,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+static bool maybe_indirect_target(int insn_off, unsigned long *targets_bitmap)
+{
+	return targets_bitmap && test_bit(insn_off, targets_bitmap);
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1231,6 +1237,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	int ret;
 	bool sign_extend;
 
+	if (maybe_indirect_target(i, ctx->indirect_targets))
+		emit_bti(A64_BTI_J, ctx);
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
@@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
 
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_insn_array(prog)) {
+		ctx.indirect_targets = kvcalloc(BITS_TO_LONGS(prog->len), sizeof(unsigned long),
+						GFP_KERNEL);
+		if (ctx.indirect_targets == NULL) {
+			prog = orig_prog;
+			goto out_off;
+		}
+		bpf_prog_collect_indirect_targets(prog, ctx.indirect_targets);
+	}
+
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
 	if (ctx.offset == NULL) {
 		prog = orig_prog;
@@ -2248,6 +2267,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.indirect_targets);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a9b788c7b4aa..c81eb54f7b26 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3822,11 +3822,23 @@ void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
+bool bpf_prog_has_insn_array(const struct bpf_prog *prog);
 #else
 static inline void
 bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 {
 }
+
+static inline bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
+{
+	return false;
+}
+
+static inline void
+bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
+{
+}
 #endif
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 61ce52882632..ed20b186a1f5 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 		}
 	}
 }
+
+bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		if (is_insn_array(prog->aux->used_maps[i]))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This function collects possible indirect jump targets in a BPF program. Since indirect jump
+ * targets can only be read from instruction arrays, it traverses all instruction arrays used
+ * by @prog. For each instruction in the arrays, it sets the corresponding bit in @bitmap.
+ */
+void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
+{
+	struct bpf_insn_array *insn_array;
+	struct bpf_map *map;
+	u32 xlated_off;
+	int i, j;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (!is_insn_array(map))
+			continue;
+
+		insn_array = cast_insn_array(map);
+		for (j = 0; j < map->max_entries; j++) {
+			xlated_off = insn_array->values[j].xlated_off;
+			if (xlated_off == INSN_DELETED)
+				continue;
+			if (xlated_off < prog->aux->subprog_start)
+				continue;
+			xlated_off -= prog->aux->subprog_start;
+			if (xlated_off >= prog->len)
+				continue;
+			__set_bit(xlated_off, bitmap);
+		}
+	}
+}
-- 
2.47.3


