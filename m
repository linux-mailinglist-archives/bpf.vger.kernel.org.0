Return-Path: <bpf+bounces-68146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA8B536C3
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478C75A35D3
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BDB34A323;
	Thu, 11 Sep 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab6nM6GG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB7345735
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602706; cv=none; b=SJNv+UNLiMBDzeWTbZY5IWnAj62OZL5sfGM3MjFHEf1G/CQeHgDUMFE9CBX3OjVYrA9ek1EyCQ71ir+5pyi1JsYDSs3dIRYP/Sa0LmPeSXGfRm7W0WVCWn3fhFFRI3rwLwqfWIW6164HmR+8f2rRZio1ohLppkRacqz7NpUaVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602706; c=relaxed/simple;
	bh=ewcj0nP15X57zNnuaBt6nrEpgBnCVZPA4aqifJT8znM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUivT5PiHig5xsHPhiflFE2mr3osxDvWO3lu56NCXaT0ecBjjXms7oxSdnF5Ax+hWcIldAegfr0nOymDzoWhSBeYdcEC1IOmTVY246LHIKy7LJhcL23WmM9hO81//kMkCAahS2F0Zqg2v9JmY8X82BFF3aUcXOPZXNs7RqZ8IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab6nM6GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F04C4CEF5;
	Thu, 11 Sep 2025 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602706;
	bh=ewcj0nP15X57zNnuaBt6nrEpgBnCVZPA4aqifJT8znM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ab6nM6GGrt2tIk+YbkH0JqaPw7BtMLBbECJXs9tCB0AqADWygKfbnb4dAyyGTnFWQ
	 D/AonL4EfC7C06OhSit6s3R2NPDRI/3hBSjBbVe6w2kjkahJLmHF5zORQTzRes+6jy
	 jbvDVriROGsDxD/RGleuXzSSBjo1vAmIuLZhZS17zf7OoUks5kayvzEgP86rEhaCNG
	 vmP8ljvKsIanb6COGrXqZRlWuM3Z9oF22ky0VaYyMz0QTQptyHugleYIjkPd+s9HxR
	 7AUNfczuOyXqaypzkObweA92+4t1pvS9zp0mOWcLgYJRXrac+5850EFDiZf6GUiklr
	 bRvfe2KBO2Hvw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v7 3/6] bpf: Report arena faults to BPF stderr
Date: Thu, 11 Sep 2025 14:58:02 +0000
Message-ID: <20250911145808.58042-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Begin reporting arena page faults and the faulting address to BPF
program's stderr, this patch adds support in the arm64 and x86-64 JITs,
support for other archs can be added later.

The fault handlers receive the 32 bit address in the arena region so
the upper 32 bits of user_vm_start is added to it before printing the
address. This is what the user would expect to see as this is what is
printed by bpf_printk() is you pass it an address returned by
bpf_arena_alloc_pages();

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 60 +++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   | 85 ++++++++++++++++++++++++++++++++---
 include/linux/bpf.h           |  6 +++
 kernel/bpf/arena.c            | 30 +++++++++++++
 4 files changed, 176 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e6d1fdc1e6f5..008273a53e04 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1066,6 +1066,30 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	emit(A64_RET(A64_LR), ctx);
 }
 
+/*
+ * Metadata encoding for exception handling in JITed code.
+ *
+ * Format of `fixup` field in `struct exception_table_entry`:
+ *
+ * Bit layout of `fixup` (32-bit):
+ *
+ * +-----------+--------+-----------+-----------+----------+
+ * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
+ * |           |        |           |           |          |
+ * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
+ * +-----------+--------+-----------+-----------+----------+
+ *
+ * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
+ * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
+ *                       accessing the arena region.
+ * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
+ * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
+ *                       DONT_CLEAR if it is a store instruction.
+ */
+
+#define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
+#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
+#define BPF_ARENA_ACCESS           BIT(21)
 #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
 #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
 
@@ -1073,11 +1097,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
 {
 	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
+	s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
+	int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
+	bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
+	bool is_write = (dst_reg == DONT_CLEAR);
+	unsigned long addr;
+
+	if (is_arena) {
+		addr = regs->regs[arena_reg] + off;
+		bpf_prog_report_arena_violation(is_write, addr, regs->pc);
+	}
 
 	if (dst_reg != DONT_CLEAR)
 		regs->regs[dst_reg] = 0;
 	/* Skip the faulting instruction */
 	regs->pc += AARCH64_INSN_SIZE;
+
 	return true;
 }
 
@@ -1087,6 +1122,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				 int dst_reg)
 {
 	off_t ins_offset;
+	s16 off = insn->off;
+	bool is_arena;
+	int arena_reg;
 	unsigned long pc;
 	struct exception_table_entry *ex;
 
@@ -1100,6 +1138,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
 				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
+	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
+		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
+
 	if (!ctx->prog->aux->extable ||
 	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
 		return -EINVAL;
@@ -1131,6 +1172,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
+	if (is_arena) {
+		ex->fixup |= BPF_ARENA_ACCESS;
+		/*
+		 * insn->src_reg/dst_reg holds the address in the arena region with upper 32-bits
+		 * being zero because of a preceding addr_space_cast(r<n>, 0x0, 0x1) instruction.
+		 * This address is adjusted with the addition of arena_vm_start (see the
+		 * implementation of BPF_PROBE_MEM32 and BPF_PROBE_ATOMIC) before being used for the
+		 * memory access. Pass the reg holding the unmodified 32-bit address to
+		 * ex_handler_bpf.
+		 */
+		if (BPF_CLASS(insn->code) == BPF_LDX)
+			arena_reg = bpf2a64[insn->src_reg];
+		else
+			arena_reg = bpf2a64[insn->dst_reg];
+
+		ex->fixup |=  FIELD_PREP(BPF_FIXUP_OFFSET_MASK, off) |
+			      FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
+	}
+
 	ex->type = EX_TYPE_BPF;
 
 	ctx->exentry_idx++;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7e3fca164620..8d34a9400a5e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
+#include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
@@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 	return 0;
 }
 
+/*
+ * Metadata encoding for exception handling in JITed code.
+ *
+ * Format of `fixup` and `data` fields in `struct exception_table_entry`:
+ *
+ * Bit layout of `fixup` (32-bit):
+ *
+ * +-----------+--------+-----------+---------+----------+
+ * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
+ * |           |        |           |         |          |
+ * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
+ * +-----------+--------+-----------+---------+----------+
+ *
+ * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
+ * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
+ *                      This is set to DONT_CLEAR if the insn is a store.
+ * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
+ *                       address for load/store when accessing the arena region.
+ * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
+ *
+ * Bit layout of `data` (32-bit):
+ *
+ * +--------------+--------+--------------+
+ * |	31-16	  |  15-8  |     7-0      |
+ * |              |	   |              |
+ * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
+ * +--------------+--------+--------------+
+ *
+ * - ARENA_OFFSET (16 bits): Offset used to calculate the address for load/store when
+ *                           accessing the arena region.
+ */
+
 #define DONT_CLEAR 1
+#define FIXUP_INSN_LEN_MASK	GENMASK(7, 0)
+#define FIXUP_REG_MASK		GENMASK(15, 8)
+#define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
+#define FIXUP_ARENA_ACCESS	BIT(31)
+#define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
 
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
-	u32 reg = x->fixup >> 8;
+	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
+	u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
+	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
+	bool is_write = (reg == DONT_CLEAR);
+	unsigned long addr;
+	s16 off;
+	u32 arena_reg;
+
+	if (is_arena) {
+		arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
+		off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
+		addr = *(unsigned long *)((void *)regs + arena_reg) + off;
+		bpf_prog_report_arena_violation(is_write, addr, regs->ip);
+	}
 
 	/* jump over faulting load and clear dest register */
 	if (reg != DONT_CLEAR)
 		*(unsigned long *)((void *)regs + reg) = 0;
-	regs->ip += x->fixup & 0xff;
+	regs->ip += insn_len;
+
 	return true;
 }
 
@@ -2070,6 +2122,7 @@ st:			if (is_imm8(insn->off))
 			{
 				struct exception_table_entry *ex;
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
+				u32 arena_reg, fixup_reg;
 				s64 delta;
 
 				if (!bpf_prog->aux->extable)
@@ -2089,8 +2142,29 @@ st:			if (is_imm8(insn->off))
 
 				ex->data = EX_TYPE_BPF;
 
-				ex->fixup = (prog - start_of_ldx) |
-					((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
+				/*
+				 * src_reg/dst_reg holds the address in the arena region with upper
+				 * 32-bits being zero because of a preceding addr_space_cast(r<n>,
+				 * 0x0, 0x1) instruction. This address is adjusted with the addition
+				 * of arena_vm_start (see the implementation of BPF_PROBE_MEM32 and
+				 * BPF_PROBE_ATOMIC) before being used for the memory access. Pass
+				 * the reg holding the unmodified 32-bit address to
+				 * ex_handler_bpf().
+				 */
+				if (BPF_CLASS(insn->code) == BPF_LDX) {
+					arena_reg = reg2pt_regs[src_reg];
+					fixup_reg = reg2pt_regs[dst_reg];
+				} else {
+					arena_reg = reg2pt_regs[dst_reg];
+					fixup_reg = DONT_CLEAR;
+				}
+
+				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
+					    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
+					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
+				ex->fixup |= FIXUP_ARENA_ACCESS;
+
+				ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
 			}
 			break;
 
@@ -2208,7 +2282,8 @@ st:			if (is_imm8(insn->off))
 				 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
 				 * of 4 bytes will be ignored and rbx will be zero inited.
 				 */
-				ex->fixup = (prog - start_of_ldx) | (reg2pt_regs[dst_reg] << 8);
+				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
+					    FIELD_PREP(FIXUP_REG_MASK, reg2pt_regs[dst_reg]);
 			}
 			break;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d133171c4d2a..41f776071ff5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2881,6 +2881,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
+void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
@@ -3168,6 +3169,11 @@ static inline void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 {
 }
+
+static inline void bpf_prog_report_arena_violation(bool write, unsigned long addr,
+						   unsigned long fault_ip)
+{
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 static __always_inline int
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 5b37753799d2..1074ac4459f2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -633,3 +633,33 @@ static int __init kfunc_init(void)
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
 }
 late_initcall(kfunc_init);
+
+void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+	u64 user_vm_start;
+
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it will not
+	 * disappear while we are handling the fault.
+	 */
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(fault_ip);
+	rcu_read_unlock();
+	if (!prog)
+		return;
+
+	/* Use main prog for stream access */
+	prog = prog->aux->main_prog_aux->prog;
+
+	user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	addr += clear_lo32(user_vm_start);
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Arena %s access at unmapped address 0x%lx\n",
+				  write ? "WRITE" : "READ", addr);
+		bpf_stream_dump_stack(ss);
+	}));
+}
-- 
2.47.3


