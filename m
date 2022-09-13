Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B55B67DE
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 08:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIMGYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIMGYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 02:24:34 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A3CE37;
        Mon, 12 Sep 2022 23:24:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MRYKQ6963z6R5FL;
        Tue, 13 Sep 2022 14:22:18 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgCHSYkDIiBjT3sKAw--.4735S4;
        Tue, 13 Sep 2022 14:24:09 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 2/4] arm64: ftrace: Support long jump for ftrace direct call
Date:   Tue, 13 Sep 2022 02:31:44 -0400
Message-Id: <20220913063146.74750-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913063146.74750-1-xukuohai@huaweicloud.com>
References: <20220913063146.74750-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHSYkDIiBjT3sKAw--.4735S4
X-Coremail-Antispam: 1UD129KBjvAXoW3CF1xuw1xGw43ZF43GrWUCFg_yoW8ArW3Ko
        WfCa1qqr48GayxKa1FkayUKryUXas5KrnYvw4rAr45Wa1DtryaqrWS93Wvy3ZxX3Z8KFWf
        uFyfXa4UGF1Iyr9xn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
        xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Add long jump support to fentry, so dynamically allocated trampolines
like bpf trampoline can be called from fentry directly, as these
trampoline addresses may be out of the range that a single bl
instruction can jump to.

The scheme used here is basically the same as commit b2ad54e1533e
("bpf, arm64: Implement bpf_arch_text_poke() for arm64").

1. At compile time, we use -fpatchable-function-entry=7,5 to insert 5
   NOPs before function entry and 2 NOPs after function entry:

		NOP
		NOP
		NOP
		NOP
		NOP
	func:
		BTI C	// if BTI
		NOP
		NOP

   The reason for inserting 5 NOPs before the function entry is that
   2 NOPs are patched to LDR and BR instructions, 2 NOPs are used to
   store the destination jump address, and 1 NOP is used to adjust
   alignment to ensure the destination jump address is stored in 8-byte
   aligned memory, which is required by atomic store and load.

2. When there is no trampoline attached, the callsite is patched to:

                NOP	// extra NOP if func is 8-byte aligned
        literal:
                .quad ftrace_dummy_tramp
                NOP	// extra NOP if func is NOT 8-byte aligned
        literal_call:
                LDR X16, literal
                BR X16
        func:
                BTI C	// if BTI
                MOV X9, LR
                NOP

3. When long jump trampoline is attached, the callsite is patched to:

                NOP	// extra NOP if func is 8-byte aligned
        literal:
                .quad <long-jump-trampoline>
                NOP	// extra NOP if func is NOT 8-byte aligned
        literal_call:
                LDR X16, literal
                BR X16
        func:
                BTI C	// if BTI
                MOV X9, LR
                BL literal_call

4. When short jump trampoline is attached, the callsite is patched to:

                NOP	// extra NOP if func is 8-byte aligned
        literal:
                .quad ftrace_dummy_tramp
                NOP	// extra NOP if func is NOT 8-byte aligned
        literal_call:
                LDR X16, literal
                BR X16
        func:
                BTI C	// if BTI
                MOV X9, LR
                BL <short-jump-trampoline>

Note that there is always a valid jump address in literal, either custom
trampoline address or the dummy trampoline address, which ensures
that we'll never jump from callsite to an unknown place.

Also note that the callsite is only ensured to be patched atomically and
securely. Whether the custom trampoline can be freed should be checked
by the trampoline user. For example, bpf uses refcnt and task based rcu
to ensure bpf trampoline could be freed safely.

In my environment, before this patch, there are 2 NOPs inserted in function
entry, and the generated vmlinux size is 463,649,280 bytes, while after
this patch, the vmlinux size is 465,069,368 bytes, increased 1,420,088
bytes, about 0.3%. In vmlinux, there are 14,376 8-byte aligned functions
and 41,847 unaligned functions. For each aligned function, one of the
five NOPs before the function entry is unnecessary, wasting 57,504 bytes.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/Makefile               |   4 +
 arch/arm64/include/asm/ftrace.h   |  27 ++--
 arch/arm64/include/asm/patching.h |   2 +
 arch/arm64/kernel/entry-ftrace.S  |  21 +++-
 arch/arm64/kernel/ftrace.c        | 198 ++++++++++++++++++++++++++++--
 arch/arm64/kernel/patching.c      |  14 +++
 arch/arm64/net/bpf_jit_comp.c     |   4 +
 kernel/trace/ftrace.c             |  10 +-
 8 files changed, 252 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..e540b50db5b8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -130,7 +130,11 @@ CHECKFLAGS	+= -D__aarch64__
 
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS),y)
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=7,5
+  else
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  endif
 endif
 
 # Default value
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dbc45a4157fa..40e63435965b 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,27 +56,16 @@ extern void _mcount(unsigned long);
 extern void *return_address(unsigned int);
 
 struct dyn_arch_ftrace {
-	/* No extra data needed for arm64 */
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long func; /* start address of function */
+#endif
 };
 
 extern unsigned long ftrace_graph_call;
 
 extern void return_to_handler(void);
 
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	/*
-	 * Adjust addr to point at the BL in the callsite.
-	 * See ftrace_init_nop() for the callsite sequence.
-	 */
-	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
-		return addr + AARCH64_INSN_SIZE;
-	/*
-	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
-	 */
-	return addr;
-}
+unsigned long ftrace_call_adjust(unsigned long addr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct dyn_ftrace;
@@ -121,6 +110,14 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	 */
 	return !strcmp(sym + 8, name);
 }
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
+#define ftrace_dummy_tramp ftrace_dummy_tramp
+extern void ftrace_dummy_tramp(void);
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index 6bf5adc56295..b9077205e6b2 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -10,4 +10,6 @@ int aarch64_insn_write(void *addr, u32 insn);
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
+void aarch64_literal64_write(void *addr, u64 data);
+
 #endif	/* __ASM_PATCHING_H */
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index bd5df50e4643..0bebe3ffdb58 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -14,14 +14,16 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /*
- * Due to -fpatchable-function-entry=2, the compiler has placed two NOPs before
- * the regular function prologue. For an enabled callsite, ftrace_init_nop() and
- * ftrace_make_call() have patched those NOPs to:
+ * Due to -fpatchable-function-entry=2 or -fpatchable-function-entry=7,5, the
+ * compiler has placed two NOPs before the regular function prologue. For an
+ * enabled callsite, ftrace_init_nop() and ftrace_make_call() have patched those
+ * NOPs to:
  *
  * 	MOV	X9, LR
  * 	BL	<entry>
  *
- * ... where <entry> is either ftrace_caller or ftrace_regs_caller.
+ * ... where <entry> is ftrace_caller or ftrace_regs_caller or custom
+ * trampoline.
  *
  * Each instrumented function follows the AAPCS, so here x0-x8 and x18-x30 are
  * live (x18 holds the Shadow Call Stack pointer), and x9-x17 are safe to
@@ -327,3 +329,14 @@ SYM_CODE_START(return_to_handler)
 	ret
 SYM_CODE_END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_FUNC_START(ftrace_dummy_tramp)
+#if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
+	bti j /* ftrace_dummy_tramp is called via "br x10" */
+#endif
+	mov x10, x30
+	mov x30, x9
+	ret x10
+SYM_FUNC_END(ftrace_dummy_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index ea5dc7c90f46..85d65dd7c71b 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -77,6 +77,123 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 	return NULL;
 }
 
+enum ftrace_callsite_action {
+	FC_INIT,
+	FC_REMOVE_CALL,
+	FC_ADD_CALL,
+	FC_REPLACE_CALL,
+};
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
+/*
+ * When func is 8-byte aligned, literal_call is located at func - 8 and literal
+ * is located at func - 16:
+ *
+ *              NOP
+ *      literal:
+ *              .quad ftrace_dummy_tramp
+ *	literal_call:
+ *              LDR X16, literal
+ *              BR X16
+ *      func:
+ *              BTI C   // if BTI
+ *              MOV X9, LR
+ *              NOP
+ *
+ * When func is not 8-byte aligned, literal_call is located at func - 8 and
+ * literal is located at func - 20:
+ *
+ *      literal:
+ *              .quad ftrace_dummy_tramp
+ *              NOP
+ *	literal_call:
+ *              LDR X16, literal
+ *              BR X16
+ *      func:
+ *              BTI C   // if BTI
+ *              MOV X9, LR
+ *              NOP
+ */
+
+static unsigned long ftrace_literal_call_addr(struct dyn_ftrace *rec)
+{
+	return rec->arch.func - 2 * AARCH64_INSN_SIZE;
+}
+
+static unsigned long ftrace_literal_addr(struct dyn_ftrace *rec)
+{
+	unsigned long addr = 0;
+
+	addr = ftrace_literal_call_addr(rec);
+	if (addr % sizeof(long))
+		addr -= 3 * AARCH64_INSN_SIZE;
+	else
+		addr -= 2 * AARCH64_INSN_SIZE;
+
+	return addr;
+}
+
+static void ftrace_update_literal(unsigned long literal_addr, unsigned long call_target,
+				 int action)
+{
+	unsigned long dummy_tramp = (unsigned long)&ftrace_dummy_tramp;
+
+	if (action == FC_INIT || action == FC_REMOVE_CALL)
+		aarch64_literal64_write((void *)literal_addr, dummy_tramp);
+	else if (action == FC_ADD_CALL)
+		aarch64_literal64_write((void *)literal_addr, call_target);
+}
+
+static int ftrace_init_literal(struct module *mod, struct dyn_ftrace *rec)
+{
+	int ret;
+	u32 old, new;
+	unsigned long addr;
+	unsigned long pc = rec->ip - AARCH64_INSN_SIZE;
+
+	old = aarch64_insn_gen_nop();
+
+	addr = ftrace_literal_addr(rec);
+	ftrace_update_literal(addr, 0, FC_INIT);
+
+	pc = ftrace_literal_call_addr(rec);
+	new = aarch64_insn_gen_load_literal(pc, addr, AARCH64_INSN_REG_16,
+					    true);
+	ret = ftrace_modify_code(pc, old, new, true);
+	if (ret)
+		return ret;
+
+	pc += AARCH64_INSN_SIZE;
+	new = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
+					  AARCH64_INSN_BRANCH_NOLINK);
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+#else
+
+static unsigned long ftrace_literal_addr(struct dyn_ftrace *rec)
+{
+	return 0;
+}
+
+static unsigned long ftrace_literal_call_addr(struct dyn_ftrace *rec)
+{
+	return 0;
+}
+
+static void ftrace_update_literal(unsigned long literal_addr, unsigned long call_target,
+				 int action)
+{
+}
+
+static int ftrace_init_literal(struct module *mod, struct dyn_ftrace *rec)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 /*
  * Find the address the callsite must branch to in order to reach '*addr'.
  *
@@ -88,7 +205,8 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
  */
 static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 				      struct module *mod,
-				      unsigned long *addr)
+				      unsigned long *addr,
+				      int action)
 {
 	unsigned long pc = rec->ip;
 	long offset = (long)*addr - (long)pc;
@@ -101,6 +219,15 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (offset >= -SZ_128M && offset < SZ_128M)
 		return true;
 
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)) {
+		unsigned long literal_addr;
+
+		literal_addr = ftrace_literal_addr(rec);
+		ftrace_update_literal(literal_addr, *addr, action);
+		*addr = ftrace_literal_call_addr(rec);
+		return true;
+	}
+
 	/*
 	 * When the target is outside of the range of a 'BL' instruction, we
 	 * must use a PLT to reach it. We can only place PLTs for modules, and
@@ -145,7 +272,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned long pc = rec->ip;
 	u32 old, new;
 
-	if (!ftrace_find_callable_addr(rec, NULL, &addr))
+	if (!ftrace_find_callable_addr(rec, NULL, &addr, FC_ADD_CALL))
 		return -EINVAL;
 
 	old = aarch64_insn_gen_nop();
@@ -161,9 +288,9 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	unsigned long pc = rec->ip;
 	u32 old, new;
 
-	if (!ftrace_find_callable_addr(rec, NULL, &old_addr))
+	if (!ftrace_find_callable_addr(rec, NULL, &old_addr, FC_REPLACE_CALL))
 		return -EINVAL;
-	if (!ftrace_find_callable_addr(rec, NULL, &addr))
+	if (!ftrace_find_callable_addr(rec, NULL, &addr, FC_ADD_CALL))
 		return -EINVAL;
 
 	old = aarch64_insn_gen_branch_imm(pc, old_addr,
@@ -188,18 +315,26 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
  * | NOP      | MOV X9, LR | MOV X9, LR |
  * | NOP      | NOP        | BL <entry> |
  *
- * The LR value will be recovered by ftrace_regs_entry, and restored into LR
- * before returning to the regular function prologue. When a function is not
- * being traced, the MOV is not harmful given x9 is not live per the AAPCS.
+ * The LR value will be recovered by ftrace_regs_entry or custom trampoline,
+ * and restored into LR before returning to the regular function prologue.
+ * When a function is not being traced, the MOV is not harmful given x9 is
+ * not live per the AAPCS.
  *
  * Note: ftrace_process_locs() has pre-adjusted rec->ip to be the address of
  * the BL.
  */
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
+	int ret;
 	unsigned long pc = rec->ip - AARCH64_INSN_SIZE;
 	u32 old, new;
 
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)) {
+		ret = ftrace_init_literal(mod, rec);
+		if (ret)
+			return ret;
+	}
+
 	old = aarch64_insn_gen_nop();
 	new = aarch64_insn_gen_move_reg(AARCH64_INSN_REG_9,
 					AARCH64_INSN_REG_LR,
@@ -208,6 +343,45 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 }
 #endif
 
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)) {
+		u32 insn;
+		u32 nop = aarch64_insn_gen_nop();
+
+		/* Skip the first 5 NOPS */
+		addr += 5 * AARCH64_INSN_SIZE;
+
+		if (aarch64_insn_read((void *)addr, &insn))
+			return 0;
+
+		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)) {
+			if (insn != nop) {
+				addr += AARCH64_INSN_SIZE;
+				if (aarch64_insn_read((void *)addr, &insn))
+					return 0;
+			}
+		}
+
+		if (WARN_ON_ONCE(insn != nop))
+			return 0;
+
+		return addr + AARCH64_INSN_SIZE;
+	} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS)) {
+		/*
+		 * Adjust addr to point at the BL in the callsite.
+		 * See ftrace_init_nop() for the callsite sequence.
+		 */
+		return addr + AARCH64_INSN_SIZE;
+	}
+
+	/*
+	 * addr is the address of the mcount call instruction.
+	 * recordmcount does the necessary offset calculation.
+	 */
+	return addr;
+}
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
@@ -217,7 +391,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	unsigned long pc = rec->ip;
 	u32 old = 0, new;
 
-	if (!ftrace_find_callable_addr(rec, mod, &addr))
+	if (!ftrace_find_callable_addr(rec, mod, &addr, FC_REMOVE_CALL))
 		return -EINVAL;
 
 	old = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
@@ -231,6 +405,14 @@ void arch_ftrace_update_code(int command)
 	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
 }
+
+void __init ftrace_rec_arch_init(struct dyn_ftrace *rec, unsigned long func)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	rec->arch.func = func + 5 * AARCH64_INSN_SIZE;
+#endif
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 33e0fabc0b79..3a4326c1ca80 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -83,6 +83,20 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 	return ret;
 }
 
+void __kprobes aarch64_literal64_write(void *addr, u64 data)
+{
+	u64 *waddr;
+	unsigned long flags = 0;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	WRITE_ONCE(*waddr, data);
+
+	patch_unmap(FIX_TEXT_POKE0);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+}
+
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
 	return __aarch64_insn_write(addr, cpu_to_le32(insn));
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 34d78ca16beb..e42955b78174 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -625,6 +625,9 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	return 0;
 }
 
+#ifdef ftrace_dummy_tramp
+#define dummy_tramp ftrace_dummy_tramp
+#else
 void dummy_tramp(void);
 
 asm (
@@ -641,6 +644,7 @@ asm (
 "	.size dummy_tramp, .-dummy_tramp\n"
 "	.popsection\n"
 );
+#endif
 
 /* build a plt initialized like this:
  *
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..c7c8fade89f2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6664,6 +6664,11 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+void __init __weak ftrace_rec_arch_init(struct dyn_ftrace *rec,
+					unsigned long addr)
+{
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6726,7 +6731,9 @@ static int ftrace_process_locs(struct module *mod,
 	pg = start_pg;
 	while (p < end) {
 		unsigned long end_offset;
-		addr = ftrace_call_adjust(*p++);
+		unsigned long nop_addr = *p++;
+
+		addr = ftrace_call_adjust(nop_addr);
 		/*
 		 * Some architecture linkers will pad between
 		 * the different mcount_loc sections of different
@@ -6746,6 +6753,7 @@ static int ftrace_process_locs(struct module *mod,
 
 		rec = &pg->records[pg->index++];
 		rec->ip = addr;
+		ftrace_rec_arch_init(rec, nop_addr);
 	}
 
 	/* We should have used all pages */
-- 
2.30.2

