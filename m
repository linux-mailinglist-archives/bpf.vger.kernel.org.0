Return-Path: <bpf+bounces-23276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E615F86F651
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CF01C21F20
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2106676033;
	Sun,  3 Mar 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnMrJwx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10177605C;
	Sun,  3 Mar 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485356; cv=none; b=mifaT6IAS47sWiT+5XEPoV0X1FhdQnHMrYi9tJ7un/5hxV8vMug6mwaS0KHJ392pmCdcKDb0t88lMUQgwGig/Cka5bpy0+Ccfc3vmDC4zMYYRbYRZbVrqpldSQ5se4D+UldybrRDbzu/wtrAQ/F1vK5NlzcnCBHJUnfC0rZIJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485356; c=relaxed/simple;
	bh=bGHtDI88aurhaVpzL5uYA7j0CttZfxNdb0fHFr6fK8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpTwGpa5MdKZsWivul9hQ6k9tk76az1X3qi8CFh3mEBlxMg4OA3JkLJs82dsj9lc3+6KN1TjH7VqZwDCZXviNfMvLQBt8qSr01mIzFdFX7QzDDiGTi2NCbVBHB/zvpY3QiG4bYUmg2ooDmm9oevBsdWUp4p/KX+ZOFJFOWH2xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnMrJwx4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412da818207so8016775e9.1;
        Sun, 03 Mar 2024 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709485353; x=1710090153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvYc8g3GAZbsuJfmgAAHT+2DTfmiAjpZz4+d9N2kLPQ=;
        b=lnMrJwx4j+afU7QzMFFzJx1hVHLj1HGsMMlvrZwgj7PuSUrrSHp9a8xndPEG2gwrvg
         3k1Z/oa83udKWczvPLdzAYVKPL5ahfJPwCW144aqswFHLQgR8jWfcBKBqM4On72t5xQw
         Vv5dXRX48wwlvy46eLNIziqptNtmmzevGy618u792k50m+uTbTyeW5bZEmzf4YW5USRJ
         Ys4sM6X4DN1Mt6lbDhu4InOCbCPoV6CuylXOfT8uZlqgyGz0Efa02MN+ywvl4hrCu8/x
         bFDtkBNZ70795VhbUj67sfIHMZucfB8Ft/82TaysndvX/L+1F53zRkLf2ELh4ABI5wed
         KKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709485353; x=1710090153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvYc8g3GAZbsuJfmgAAHT+2DTfmiAjpZz4+d9N2kLPQ=;
        b=IxZz1Kg1Vp0dd0kbsFK5Muxmht8ZFeIdW7P/qcOpV8dYASW21dM60hYO18Kudf5Mt4
         j+HIO8FYyZZpuVKGnzKMbqxEHpdCv2srkOyei5D02vM+QxGyY4gnpZa6nudK4KYvnpWC
         LELGvTeLFKgEzfulADVbHEY+2JVVXrc1Rct+LLvKYKv3JfOGmWE4e1bklorLjrF1KxNA
         LSNmyji05GjpzPeE7QCvGHrlbbH4X4cHDVxn8e3J5Dy/G2aHqa5fmcoXANX5i8B6UHlH
         k08Dd+xkvH28szNUt8B+fT/le/HFEztb7lzl4/KFuXmwPYeH99UUpxlRPFSrWRLZ1pKd
         yA0g==
X-Forwarded-Encrypted: i=1; AJvYcCVAWqFvyZOnvO16icXPTA9lCYji0m27KuFXZmyLmjRejQDmdNdAuGvdgGFD8g8I5O0Cmt1aauYYwdCekt20Wxvfd1u+0+JKyOupLX1Mu0R1Wc0QrvgSju0+EdDYyLabkcoH
X-Gm-Message-State: AOJu0Ywh05qXWByEIivvTCdSEZDtUaTBUSdx0gcfCpGicS16kQmdi4PC
	TIYkmPl+oZM7vORbwYBVkrwqAcKbnAqDRn1ggEPed68HyfgsmI0cDjAncsijGA7isA==
X-Google-Smtp-Source: AGHT+IHJ+kih4UsJQo56MpsvIUJ3v8P1m2BcJuEmo2XUFkGvKZbzm054All7iuXcvH7RlNtO90NwfQ==
X-Received: by 2002:a05:600c:5253:b0:40e:d30b:6129 with SMTP id fc19-20020a05600c525300b0040ed30b6129mr6014089wmb.13.1709485352899;
        Sun, 03 Mar 2024 09:02:32 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b00412e221d260sm1386813wmb.2.2024.03.03.09.02.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2024 09:02:32 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 1/1] riscv64/cfi,bpf: Support kCFI + BPF on riscv64
Date: Sun,  3 Mar 2024 17:02:07 +0000
Message-Id: <20240303170207.82201-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303170207.82201-1-puranjay12@gmail.com>
References: <20240303170207.82201-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv BPF JIT doesn't emit proper kCFI prologues for BPF programs
and struct_ops trampolines when CONFIG_CFI_CLANG is enabled.

This causes CFI failures when calling BPF programs and can even crash
the kernel due to invalid memory accesses.

Example crash:

root@rv-selftester:~/bpf# ./test_progs -a dummy_st_ops

 Unable to handle kernel paging request at virtual address ffffffff78204ffc
 Oops [#1]
 Modules linked in: bpf_testmod(OE) [....]
 CPU: 3 PID: 356 Comm: test_progs Tainted: P           OE      6.8.0-rc1 #1
 Hardware name: riscv-virtio,qemu (DT)
 epc : bpf_struct_ops_test_run+0x28c/0x5fc
  ra : bpf_struct_ops_test_run+0x26c/0x5fc
 epc : ffffffff82958010 ra : ffffffff82957ff0 sp : ff200000007abc80
  gp : ffffffff868d6218 tp : ff6000008d87b840 t0 : 000000000000000f
  t1 : 0000000000000000 t2 : 000000002005793e s0 : ff200000007abcf0
  s1 : ff6000008a90fee0 a0 : 0000000000000000 a1 : 0000000000000000
  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
  a5 : ffffffff868dba26 a6 : 0000000000000001 a7 : 0000000052464e43
  s2 : 00007ffffc0a95f0 s3 : ff6000008a90fe80 s4 : ff60000084c24c00
  s5 : ffffffff78205000 s6 : ff60000088750648 s7 : ff20000000035008
  s8 : fffffffffffffff4 s9 : ffffffff86200610 s10: 0000000000000000
  s11: 0000000000000000 t3 : ffffffff8483dc30 t4 : ffffffff8483dc10
  t5 : ffffffff8483dbf0 t6 : ffffffff8483dbd0
 status: 0000000200000120 badaddr: ffffffff78204ffc cause: 000000000000000d
 [<ffffffff82958010>] bpf_struct_ops_test_run+0x28c/0x5fc
 [<ffffffff805083ee>] bpf_prog_test_run+0x170/0x548
 [<ffffffff805029c8>] __sys_bpf+0x2d2/0x378
 [<ffffffff804ff570>] __riscv_sys_bpf+0x5c/0x120
 [<ffffffff8000e8fe>] syscall_handler+0x62/0xe4
 [<ffffffff83362df6>] do_trap_ecall_u+0xc6/0x27c
 [<ffffffff833822c4>] ret_from_exception+0x0/0x64
 Code: b603 0109 b683 0189 b703 0209 8493 0609 157d 8d65 (a303) ffca
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs

Implement proper kCFI prologues for the BPF programs and callbacks and
drop __nocfi for riscv64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/include/asm/cfi.h    | 17 +++++++++++
 arch/riscv/kernel/cfi.c         | 53 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit.h        |  2 +-
 arch/riscv/net/bpf_jit_comp32.c |  2 +-
 arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++-
 arch/riscv/net/bpf_jit_core.c   |  9 +++---
 6 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
index 8f7a62257044..fb9696d7a3f2 100644
--- a/arch/riscv/include/asm/cfi.h
+++ b/arch/riscv/include/asm/cfi.h
@@ -13,11 +13,28 @@ struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+#define __bpfcall
+static inline int cfi_get_offset(void)
+{
+	return 4;
+}
+
+#define cfi_get_offset cfi_get_offset
+extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
+extern u32 cfi_get_func_hash(void *func);
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
+
+#define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
+static inline u32 cfi_get_func_hash(void *func)
+{
+	return 0;
+}
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_RISCV_CFI_H */
diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 6ec9dbd7292e..64bdd3e1ab8c 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -75,3 +75,56 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 
 	return report_cfi_failure(regs, regs->epc, &target, type);
 }
+
+#ifdef CONFIG_CFI_CLANG
+struct bpf_insn;
+
+/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
+extern unsigned int __bpf_prog_runX(const void *ctx,
+				    const struct bpf_insn *insn);
+
+/*
+ * Force a reference to the external symbol so the compiler generates
+ * __kcfi_typid.
+ */
+__ADDRESSABLE(__bpf_prog_runX);
+
+/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_hash,@object				\n"
+"	.globl	cfi_bpf_hash					\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_hash:							\n"
+"	.word	__kcfi_typeid___bpf_prog_runX			\n"
+"	.size	cfi_bpf_hash, 4					\n"
+"	.popsection						\n"
+);
+
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+
+__ADDRESSABLE(__bpf_callback_fn);
+
+/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_subprog_hash,@object			\n"
+"	.globl	cfi_bpf_subprog_hash				\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_subprog_hash:						\n"
+"	.word	__kcfi_typeid___bpf_callback_fn			\n"
+"	.size	cfi_bpf_subprog_hash, 4				\n"
+"	.popsection						\n"
+);
+
+u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
+}
+#endif
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 8b35f12a4452..f4b6b3b9edda 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1223,7 +1223,7 @@ static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
 
 #endif /* __riscv_xlen == 64 */
 
-void bpf_jit_build_prologue(struct rv_jit_context *ctx);
+void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog);
 void bpf_jit_build_epilogue(struct rv_jit_context *ctx);
 
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 529a83b85c1c..f5ba73bb153d 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -1301,7 +1301,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	return 0;
 }
 
-void bpf_jit_build_prologue(struct rv_jit_context *ctx)
+void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
 	const s8 *fp = bpf2rv32[BPF_REG_FP];
 	const s8 *r1 = bpf2rv32[BPF_REG_1];
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 869e4282a2c4..aac190085472 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -11,6 +11,7 @@
 #include <linux/memory.h>
 #include <linux/stop_machine.h>
 #include <asm/patch.h>
+#include <asm/cfi.h>
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
@@ -455,6 +456,12 @@ static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 	return emit_jump_and_link(RV_REG_RA, off, fixed_addr, ctx);
 }
 
+static inline void emit_kcfi(u32 hash, struct rv_jit_context *ctx)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG))
+		emit(hash, ctx);
+}
+
 static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 			struct rv_jit_context *ctx)
 {
@@ -869,6 +876,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_FP, ctx);
 		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
 	} else {
+		/* emit kcfi hash */
+		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
 		/* For the trampoline called directly, just handle
 		 * the frame of trampoline.
 		 */
@@ -1711,7 +1720,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	return 0;
 }
 
-void bpf_jit_build_prologue(struct rv_jit_context *ctx)
+void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 
@@ -1740,6 +1749,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 
 	store_offset = stack_adjust - 8;
 
+	/* emit kcfi type preamble immediately before the  first insn */
+	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
+
 	/* nops reserved for auipc+jalr pair */
 	for (i = 0; i < RV_FENTRY_NINSNS; i++)
 		emit(rv_nop(), ctx);
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 7b70ccb7fec3..6b3acac30c06 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -10,6 +10,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <asm/patch.h>
+#include <asm/cfi.h>
 #include "bpf_jit.h"
 
 /* Number of iterations to try until offsets converge. */
@@ -100,7 +101,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		pass++;
 		ctx->ninsns = 0;
 
-		bpf_jit_build_prologue(ctx);
+		bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
 		ctx->prologue_len = ctx->ninsns;
 
 		if (build_body(ctx, extra_pass, ctx->offset)) {
@@ -160,7 +161,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx->ninsns = 0;
 	ctx->nexentries = 0;
 
-	bpf_jit_build_prologue(ctx);
+	bpf_jit_build_prologue(ctx, bpf_is_subprog(prog));
 	if (build_body(ctx, extra_pass, NULL)) {
 		prog = orig_prog;
 		goto out_free_hdr;
@@ -170,9 +171,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
 
-	prog->bpf_func = (void *)ctx->ro_insns;
+	prog->bpf_func = (void *)ctx->ro_insns + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
-- 
2.40.1


