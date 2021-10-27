Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2343C5D9
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhJ0JBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbhJ0JA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC9C061767
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XnHyvCjWZuoXOXwR/K4DYoNsc0TKhgQu19TUaAyUoqY=; b=PrHVG8vsyJxCaDk8r37yzg+baO
        JmjKMMVmKzPyLYzZ480STEaRLZDk6S/nUUBWZOkx2ci8xKbw5sFTS7HbxERXA/0evFSFZ1iyvmpJ6
        I4mUWZFopHoxx8ixH3nKpm/SfASwhXSsVhCvvQq6Dtl2UAS/Ei/kXjVQ2JRfkiDGqQxoYT8yDBCCY
        bQwbVAG2kFKlMWXaEEgQmE3nVi9qF8ohofdnG06TFL/haCL6bEpEbdO6f+a56u+cgzdD05qgBB2cY
        n1BELPeYwoZJYzjkH2ZtbEkK8i8AriUinCFRoiTiWJ3WEFSAWnLKOoxRGUn7hsmFZI5OeYif9nCUV
        /ASXJ8EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelQ-00CWWA-5B
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A743A30198B
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 97FE5236E43D7; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.756157312@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 11/17] x86/alternative: Implement .retpoline_sites support
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rewrite retpoline thunk call sites to be indirect calls for
spectre_v2=off. This ensures spectre_v2=off is as near to a
RETPOLINE=n build as possible.

This is the replacement for objtool writing alternative entries to
ensure the same and achieves feature-parity with the previous
approach.

One noteworthy feature is that it relies on the thunks to be in
machine order to compute the register index.

Specifically, this does not yet address the Jcc __x86_indirect_thunk_*
calls generated by clang, a future patch will add this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c           |    4 +
 arch/x86/include/asm/alternative.h |    1 
 arch/x86/kernel/alternative.c      |  141 +++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/module.c           |    9 ++
 4 files changed, 150 insertions(+), 5 deletions(-)

--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -421,6 +421,10 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
 
+void apply_retpolines(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -75,6 +75,7 @@ extern int alternatives_patched;
 
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+extern void apply_retpolines(s32 *start, s32 *end);
 
 struct module;
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
+#include <asm/asm-prototypes.h>
 
 int __read_mostly alternatives_patched;
 
@@ -113,6 +114,7 @@ static void __init_or_module add_nops(vo
 	}
 }
 
+extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -221,7 +223,7 @@ static __always_inline int optimize_nops
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
+static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 {
 	struct insn insn;
 	int i = 0;
@@ -239,11 +241,11 @@ static void __init_or_module noinline op
 		 * optimized.
 		 */
 		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			i += optimize_nops_range(instr, a->instrlen, i);
+			i += optimize_nops_range(instr, len, i);
 		else
 			i += insn.length;
 
-		if (i >= a->instrlen)
+		if (i >= len)
 			return;
 	}
 }
@@ -331,10 +333,135 @@ void __init_or_module noinline apply_alt
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
 next:
-		optimize_nops(a, instr);
+		optimize_nops(instr, a->instrlen);
 	}
 }
 
+#if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
+
+/*
+ * CALL/JMP *%\reg
+ */
+static int emit_indirect(int op, int reg, u8 *bytes)
+{
+	int i = 0;
+	u8 modrm;
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		modrm = 0x10; /* Reg = 2; CALL r/m */
+		break;
+
+	case JMP32_INSN_OPCODE:
+		modrm = 0x20; /* Reg = 4; JMP r/m */
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		return -1;
+	}
+
+	if (reg >= 8) {
+		bytes[i++] = 0x41; /* REX.B prefix */
+		reg -= 8;
+	}
+
+	modrm |= 0xc0; /* Mod = 3 */
+	modrm += reg;
+
+	bytes[i++] = 0xff; /* opcode */
+	bytes[i++] = modrm;
+
+	return i;
+}
+
+/*
+ * Rewrite the compiler generated retpoline thunk calls.
+ *
+ * For spectre_v2=off (!X86_FEATURE_RETPOLINE), rewrite them into immediate
+ * indirect instructions, avoiding the extra indirection.
+ *
+ * For example, convert:
+ *
+ *   CALL __x86_indirect_thunk_\reg
+ *
+ * into:
+ *
+ *   CALL *%\reg
+ *
+ */
+static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
+{
+	retpoline_thunk_t *target;
+	int reg, i = 0;
+
+	target = addr + insn->length + insn->immediate.value;
+	reg = target - __x86_indirect_thunk_array;
+
+	if (WARN_ON_ONCE(reg & ~0xf))
+		return -1;
+
+	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
+	BUG_ON(reg == 4);
+
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+		return -1;
+
+	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
+	if (i < 0)
+		return i;
+
+	for (; i < insn->length;)
+		bytes[i++] = BYTES_NOP1;
+
+	return i;
+}
+
+/*
+ * Generated by 'objtool --retpoline'.
+ */
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		struct insn insn;
+		int len, ret;
+		u8 bytes[16];
+		u8 op1, op2;
+
+		ret = insn_decode_kernel(&insn, addr);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op1 = insn.opcode.bytes[0];
+		op2 = insn.opcode.bytes[1];
+
+		switch (op1) {
+		case CALL_INSN_OPCODE:
+		case JMP32_INSN_OPCODE:
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		len = patch_retpoline(addr, &insn, bytes);
+		if (len == insn.length) {
+			optimize_nops(bytes, len);
+			text_poke_early(addr, bytes, len);
+		}
+	}
+}
+
+#else /* !RETPOLINES || !CONFIG_STACK_VALIDATION */
+
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
+
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
 				  u8 *text, u8 *text_end)
@@ -643,6 +770,12 @@ void __init alternative_instructions(voi
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	/*
+	 * Rewrite the retpolines, must be done before alternatives since
+	 * those can rewrite the retpoline thunks.
+	 */
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
+
+	/*
 	 * Then patch alternatives, such that those paravirt calls that are in
 	 * alternatives can be overwritten by their immediate fragments.
 	 */
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,7 +251,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL;
+		*para = NULL, *orc = NULL, *orc_ip = NULL,
+		*retpolines = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -267,8 +268,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
 			orc_ip = s;
+		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
+			retpolines = s;
 	}
 
+	if (retpolines) {
+		void *rseg = (void *)retpolines->sh_addr;
+		apply_retpolines(rseg, rseg + retpolines->sh_size);
+	}
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg = (void *)alt->sh_addr;


