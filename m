Return-Path: <bpf+bounces-77354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D10CD873E
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6507D3021F9C
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F331BCA3;
	Tue, 23 Dec 2025 08:33:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450772B2DA;
	Tue, 23 Dec 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766478822; cv=none; b=V3ss2r5lBMh+MllaCbQ37TH82v2uvPYhgs1gk2Rg2Kq6Fz6L17MrDWmNVunOMV/mu/t+HMBPSe5yjh8tHpSnvS9av5Uoa1Zr5RNPTbDh9uX/hyW/HoA79w1Cvu4ilFv7o/ID0OG1jpy9vMY4Cy10DPfK2T9WKeJ/4uoz7catl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766478822; c=relaxed/simple;
	bh=6xaY6hI1U4HlIqtU/zt5SahfttxCtUrpTogrEIBssBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUKKBeC5rkrXIAi7J6cQfiGEMnymFp/G7UiHH4sxgs0wwkl5zJDrJgN/I9JRnaQR0vq24hIzmW3lv6H2o0yD2sgUSjOW3zwE8TDcmick7uyPE8DmbH1cMp/zoRRhBIfh5AocYLtjRCdc+E54L+Ln7C/JRGgFKUMNocHD7xV1JXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4db7Yf16lLzYQts9;
	Tue, 23 Dec 2025 16:32:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CD79A4057D;
	Tue, 23 Dec 2025 16:33:30 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgDXhfbXU0ppvZy9BA--.25182S2;
	Tue, 23 Dec 2025 16:33:28 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at indirect jump targets
Date: Tue, 23 Dec 2025 16:54:47 +0800
Message-ID: <20251223085447.139301-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXhfbXU0ppvZy9BA--.25182S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyxtw4xJrWkKry5CF45Wrg_yoW3AFW3pF
	4DJ34jyr4rWr4xXr4DJa18C343tF4kKas8GFZ3t3ySvFyYqr95GayrKFnIyF1YgrWUAr1x
	ZF4j9ry8W3yUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 bpf_prog_run_pin_on_cpu+0x140/0x464
 bpf_prog_test_run_syscall+0x274/0x3ac
 bpf_prog_test_run+0x224/0x2b0
 __sys_bpf+0x4cc/0x5c8
 __arm64_sys_bpf+0x7c/0x94
 invoke_syscall+0x78/0x20c
 el0_svc_common+0x11c/0x1c0
 do_el0_svc+0x48/0x58
 el0_svc+0x54/0x19c
 el0t_64_sync_handler+0x84/0x12c
 el0t_64_sync+0x198/0x19c

This happens because no BTI instruction is generated by the JIT for
indirect jump targets.

Fix it by emitting BTI instruction for every possible indirect jump
targets when BTI is enabled. The targets are identified by traversing
all instruction arrays of jump table type used by the BPF program,
since indirect jump targets can only be read from instruction arrays
of jump table type.

Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
v2:
- Exclude instruction arrays not used for indirect jumps (Anton Protopopov)

v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
---
 arch/arm64/net/bpf_jit_comp.c | 20 +++++++++++
 include/linux/bpf.h           | 19 +++++++++++
 kernel/bpf/bpf_insn_array.c   | 63 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c         |  6 ++++
 4 files changed, 108 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c4d44bcfbf4..f08f0f9fa04e 100644
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
 
+static bool is_indirect_target(int insn_off, unsigned long *targets_bitmap)
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
 
+	if (is_indirect_target(i, ctx->indirect_targets))
+		emit_bti(A64_BTI_J, ctx);
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
@@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
 
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_jump_table(prog)) {
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
index da6a00dd313f..a3a89d4b4dae 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3875,13 +3875,32 @@ void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
+enum bpf_insn_array_type {
+	BPF_INSN_ARRAY_VOID,
+	BPF_INSN_ARRAY_JUMP_TABLE,
+};
+
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
+void bpf_prog_set_insn_array_type(struct bpf_map *map, int type);
+bool bpf_prog_has_jump_table(const struct bpf_prog *prog);
 #else
 static inline void
 bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 {
 }
+static inline void
+bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
+{
+}
+static inline void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
+{
+}
+static inline bool bpf_prog_has_jump_table(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index c96630cb75bf..fbffc865feab 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -5,6 +5,7 @@
 
 struct bpf_insn_array {
 	struct bpf_map map;
+	int type;
 	atomic_t used;
 	long *ips;
 	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
@@ -159,6 +160,17 @@ static bool is_insn_array(const struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_INSN_ARRAY;
 }
 
+static bool is_jump_table(const struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array;
+
+	if (!is_insn_array(map))
+		return false;
+
+	insn_array = cast_insn_array(map);
+	return insn_array->type == BPF_INSN_ARRAY_JUMP_TABLE;
+}
+
 static inline bool valid_offsets(const struct bpf_insn_array *insn_array,
 				 const struct bpf_prog *prog)
 {
@@ -302,3 +314,54 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 		}
 	}
 }
+
+bool bpf_prog_has_jump_table(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		if (is_jump_table(prog->aux->used_maps[i]))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This function collects possible indirect jump targets in a BPF program. Since indirect jump
+ * targets can only be read from indirect arrays used as jump table, it traverses all jump
+ * tables used by @prog. For each instruction found in the jump tables, it sets the corresponding
+ * bit in @bitmap.
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
+		if (!is_jump_table(map))
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
+
+void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+
+	insn_array->type = type;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6b8a77fbe3b..ee6f4ddfbb79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20288,6 +20288,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	/*
+	 * Explicitly mark this map as a jump table such that it can be
+	 * distinguished later from other instruction arrays
+	 */
+	bpf_prog_set_insn_array_type(map, BPF_INSN_ARRAY_JUMP_TABLE);
+
 	for (i = 0; i < n - 1; i++) {
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
 					  env->insn_idx, env->cur_state->speculative);
-- 
2.47.3


