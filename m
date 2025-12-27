Return-Path: <bpf+bounces-77452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C6CDF523
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 08:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F000300C6EF
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E324CEEA;
	Sat, 27 Dec 2025 07:49:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC01C5D44;
	Sat, 27 Dec 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821793; cv=none; b=L/K0G6qg7Rka0IdLhfah10jp3rglR80sy53X+gIWZcC3kL4CHitYhsPmPeg3hZhTKsWpY9CIFb7RPme3UDkvjXSMVT97ZibakAyz7ak2uoR+zr22d7kntNwgpZbbtRuOm6uSE1vJx0lFepL60dSgrA1fijF3Er9neuEU9++fRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821793; c=relaxed/simple;
	bh=c9jKoOVlt2xG4PZiemq2D8a1/FGoWtb/udCUb3gcK1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyJ++2ZClJ0GlP6DrA/sboOjRSHsCmEF4bns3IbxLZ2w2YnxXkXi5YeyuXypj5dSLaQmyYvIVeTm3zL6qtC9KrqWOLZI/tywaP2lLOeQi2M3+aNaIQqjeh2AV6+MI/shpe6SLTuRXZZxEi5S8x7t868kfdUN4n7AITesDZWQGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ddZP65btZzYQv0q;
	Sat, 27 Dec 2025 15:48:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 27A0A4058C;
	Sat, 27 Dec 2025 15:49:42 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDXROqSj09pm1B_Bg--.42328S2;
	Sat, 27 Dec 2025 15:49:40 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at indirect jump targets
Date: Sat, 27 Dec 2025 16:10:33 +0800
Message-ID: <20251227081033.240336-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXROqSj09pm1B_Bg--.42328S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyxtw4xJrWkKry5WFyDJrb_yoW3GFykpF
	4DG34jyr4Fgr4xWrsrJa10kry3tr4kKwnxGFWft3yF9a4Yqr95WayrKFnIyFn8Kry5Cr1f
	XF4j9ryUW3yUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8hNVDUUUUU==
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
v3:
- Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov)

v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicloud.com/
- Exclude instruction arrays not used for indirect jumps (Anton Protopopov)

v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
---
 arch/arm64/net/bpf_jit_comp.c | 20 +++++++++++
 include/linux/bpf.h           | 14 ++++++++
 kernel/bpf/bpf_insn_array.c   | 63 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c         |  6 ++++
 4 files changed, 103 insertions(+)

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
index 4e7d72dfbcd4..4a26346263bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3893,11 +3893,25 @@ void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
+void bpf_prog_mark_jump_table(struct bpf_map *map);
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
+static inline void bpf_prog_mark_jump_table(struct bpf_map *map)
+{
+}
+static inline bool bpf_prog_has_jump_table(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index c96630cb75bf..b9b43fdbe8e3 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -6,6 +6,7 @@
 struct bpf_insn_array {
 	struct bpf_map map;
 	atomic_t used;
+	bool is_jump_table;
 	long *ips;
 	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
 };
@@ -302,3 +303,65 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 		}
 	}
 }
+
+void bpf_prog_mark_jump_table(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+
+	insn_array->is_jump_table = true;
+}
+
+static bool is_jump_table(const struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array;
+
+	if (!is_insn_array(map))
+		return false;
+
+	insn_array = cast_insn_array(map);
+	return insn_array->is_jump_table;
+}
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2de1a736ef69..bc4a269ed06e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20292,6 +20292,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	/*
+	 * Explicitly mark this map as a jump table such that it can be
+	 * distinguished later from other instruction arrays
+	 */
+	bpf_prog_mark_jump_table(map);
+
 	for (i = 0; i < n - 1; i++) {
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
 					  env->insn_idx, env->cur_state->speculative);
-- 
2.47.3


