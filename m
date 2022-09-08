Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37035B1220
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIHBez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 21:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIHBex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 21:34:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FF43603;
        Wed,  7 Sep 2022 18:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9152BB81F77;
        Thu,  8 Sep 2022 01:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E3C433D7;
        Thu,  8 Sep 2022 01:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662600888;
        bh=OiNfA3lk8zAaDJyzN7XkwjWEGvox13FiJDrxDrD4L+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFOIFuAKOhlaLC2Jv+qXzJwx1SN51GeMSPHIo7y4EYgJH/HQpY3tt7GzVqqpZV5Oo
         96urGXj9m4KWKblMl/vyw3fwdCGECbp9Rht2XW6N7l/1BnZfJNpB+u5vCzacUSFXCE
         Gk2i6qpVuFCSgAKG3a3Y922F+u8rT9KlWWtoHGRlR5/hPNwrdc478KUvDmKaNgP0Z4
         1fjvcFf1LSoinaPq/ySlw1Fpq8M2a1Eji6z3+NogirJYk5addmbfj4zO9KB3qtdBqY
         csuYNC59SaW8pf5DZ7a/Ia9tsXz9LYshXO/x0X0+wUD0/2zadc8UftjIDNNky8N+4y
         yyLaQoN8YXTnQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH v2 1/2] x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
Date:   Thu,  8 Sep 2022 10:34:43 +0900
Message-Id: <166260088298.759381.11727280480035568118.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166260087224.759381.4170102827490658262.stgit@devnote2>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
speculative execution after RET instruction, kprobes always failes to
check the probed instruction boundary by decoding the function body if
the probed address is after such sequence. (Note that some conditional
code blocks will be placed after function return, if compiler decides
it is not on the hot path.)

This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
a software breakpoint and it will replace the original instruction.
But these INT3 are not such purpose, it doesn't need to recover the
original instruction.

To avoid this issue, memorize the branch target address during decoding
and if there is INT3, restart decoding from unchecked target address.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
Cc: stable@vger.kernel.org
---
 Changes in v2:
  - Use GNU AS names for mnemonic in comments
  - Decode all code blocks in the function to find the instruction boundary
  - Update Fixes tag to specify CONFIG_SLS.
---
 arch/x86/kernel/kprobes/common.h |   28 +++++
 arch/x86/kernel/kprobes/core.c   |  227 +++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/kprobes/opt.c    |   23 ----
 3 files changed, 225 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index c993521d4933..c0505e22c0db 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -92,6 +92,34 @@ extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
 extern void synthesize_reljump(void *dest, void *from, void *to);
 extern void synthesize_relcall(void *dest, void *from, void *to);
 
+/* Return the jump target address or 0 */
+static inline unsigned long insn_get_branch_addr(struct insn *insn)
+{
+	switch (insn->opcode.bytes[0]) {
+	case 0xe0:	/* loopne */
+	case 0xe1:	/* loope */
+	case 0xe2:	/* loop */
+	case 0xe3:	/* Jcxz */
+	case 0xe9:	/* JMP.d32 */
+	case 0xeb:	/* JMP.d8 */
+		break;
+	case 0x0f:
+		if ((insn->opcode.bytes[1] & 0xf0) == 0x80) /* Jcc.d32 */
+			break;
+		return 0;
+	case 0x70 ... 0x7f: /* Jcc.d8 */
+		break;
+
+	default:
+		return 0;
+	}
+	return (unsigned long)insn->next_byte + insn->immediate.value;
+}
+
+int every_insn_in_func(unsigned long faddr,
+		       int (*callback)(struct insn *, void *),
+		       void *data);
+
 #ifdef	CONFIG_OPTPROBES
 extern int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter);
 extern unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4c3c27b6aea3..36e8a3de8f92 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -252,47 +252,210 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 	return __recover_probed_insn(buf, addr);
 }
 
-/* Check if paddr is at an instruction boundary */
-static int can_probe(unsigned long paddr)
+/* Code block queue */
+struct cbqueue {
+	int size;
+	int next;
+	unsigned long *addr;
+};
+#define INIT_CBQ_SIZE	32
+/* The top most bit is used for unchecked bit. */
+#define CBQ_ADDR_MASK	((-1UL) >> 1)
+#define CBQ_UNCHK_BIT	(~CBQ_ADDR_MASK)
+
+static struct cbqueue *cbq_alloc(int size)
 {
-	unsigned long addr, __addr, offset = 0;
-	struct insn insn;
-	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	struct cbqueue *q;
 
-	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
-		return 0;
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return NULL;
+	q->size = size;
+	q->addr = kcalloc(size, sizeof(unsigned long), GFP_KERNEL);
+	if (!q->addr) {
+		kfree(q);
+		return NULL;
+	}
+	return q;
+}
 
-	/* Decode instructions */
-	addr = paddr - offset;
-	while (addr < paddr) {
-		int ret;
+static void cbq_free(struct cbqueue *q)
+{
+	kfree(q->addr);
+	kfree(q);
+}
 
-		/*
-		 * Check if the instruction has been modified by another
-		 * kprobe, in which case we replace the breakpoint by the
-		 * original instruction in our buffer.
-		 * Also, jump optimization will change the breakpoint to
-		 * relative-jump. Since the relative-jump itself is
-		 * normally used, we just go through if there is no kprobe.
-		 */
-		__addr = recover_probed_instruction(buf, addr);
-		if (!__addr)
-			return 0;
+static int cbq_expand(struct cbqueue *q, int newsize)
+{
+	if (q->size > newsize)
+		return -ENOSPC;
 
-		ret = insn_decode_kernel(&insn, (void *)__addr);
-		if (ret < 0)
-			return 0;
+	q->addr = krealloc_array(q->addr,
+			newsize, sizeof(unsigned long), GFP_KERNEL);
+	if (!q->addr)
+		return -ENOMEM;
+	q->size = newsize;
+	return 0;
+}
 
-		/*
-		 * Another debugging subsystem might insert this breakpoint.
-		 * In that case, we can't recover it.
-		 */
-		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
+/* Add a new code block address */
+static int cbq_push(struct cbqueue *q, unsigned long addr)
+{
+	int i;
+
+	/* Check the addr exists */
+	for (i = 0; i < q->next; i++)
+		if ((CBQ_ADDR_MASK & (q->addr[i] ^ addr)) == 0)
 			return 0;
-		addr += insn.length;
+
+	if (q->next == q->size &&
+	    cbq_expand(q, q->size * 2) < 0)
+		return -ENOMEM;
+
+	WARN_ON_ONCE(!(CBQ_UNCHK_BIT & addr));
+	q->addr[q->next++] = addr;
+	return 0;
+}
+
+/* Return the first unchecked code block address */
+static unsigned long cbq_pop(struct cbqueue *q)
+{
+	unsigned long addr = 0;
+	int i;
+
+	for (i = 0; i < q->next; i++) {
+		if (CBQ_UNCHK_BIT & q->addr[i]) {
+			addr = q->addr[i];
+			q->addr[i] &= CBQ_ADDR_MASK;
+			break;
+		}
+	}
+
+	return addr;
+}
+
+/* Mark the address is checked, and return true if it is already checked. */
+static bool cbq_check(struct cbqueue *q, unsigned long addr)
+{
+	int i;
+
+	for (i = 0; i < q->next; i++) {
+		if ((CBQ_ADDR_MASK & (q->addr[i] ^ addr)) == 0) {
+			if (!(CBQ_UNCHK_BIT & q->addr[i]))
+				return true;
+			q->addr[i] &= CBQ_ADDR_MASK;
+			break;
+		}
+	}
+	return false;
+}
+
+static void __decode_insn(struct insn *insn, kprobe_opcode_t *buf,
+			  unsigned long addr)
+{
+	unsigned long recovered_insn;
+
+	/*
+	 * Check if the instruction has been modified by another
+	 * kprobe, in which case we replace the breakpoint by the
+	 * original instruction in our buffer.
+	 * Also, jump optimization will change the breakpoint to
+	 * relative-jump. Since the relative-jump itself is
+	 * normally used, we just go through if there is no kprobe.
+	 */
+	recovered_insn = recover_probed_instruction(buf, addr);
+	if (!recovered_insn ||
+	    insn_decode_kernel(insn, (void *)recovered_insn) < 0) {
+		insn->kaddr = NULL;
+	} else {
+		/* Recover address */
+		insn->kaddr = (void *)addr;
+		insn->next_byte = (void *)(addr + insn->length);
 	}
+}
+
+/* Iterate instructions in [saddr, eaddr), insn->next_byte is loop cursor. */
+#define for_each_insn(insn, saddr, eaddr, buf)				\
+	for (__decode_insn(insn, buf, saddr);				\
+	     (insn)->kaddr && (unsigned long)(insn)->next_byte < eaddr;	\
+	     __decode_insn(insn, buf, (unsigned long)(insn)->next_byte))
+
+/**
+ * every_insn_in_func - iterate every instructions in the function
+ * @faddr:    Address in the target function (no need to be the entry address)
+ * @callback: Callback function on each instruction
+ * @data:     Data to be passed to @callback
+ *
+ * Return 0, an error (< 0), or @callback returned value.
+ * If @callback returns !0, this stops decoding and return that value.
+ * The decoding address order is not always incremental because it follows
+ * branch targets in the function.
+ */
+int every_insn_in_func(unsigned long faddr,
+		       int (*callback)(struct insn *, void *),
+		       void *data)
+{
+	unsigned long start, entry, end, dest, offset = 0, size = 0;
+	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	struct cbqueue *q;
+	struct insn insn;
+	int ret;
+
+	ret = kallsyms_lookup_size_offset(faddr, &size, &offset);
+	if (ret < 0)
+		return ret;
 
-	return (addr == paddr);
+	q = cbq_alloc(INIT_CBQ_SIZE);
+	if (!q)
+		return -ENOMEM;
+
+	entry = faddr - offset;
+	end = faddr - offset + size;
+	cbq_push(q, entry);
+
+	while ((start = cbq_pop(q))) {
+		for_each_insn(&insn, start, end, buf) {
+			/*
+			 * If this instruction is already checked, decode
+			 * other unchecked code blocks.
+			 */
+			if (start != (unsigned long)insn.kaddr &&
+			    cbq_check(q, (unsigned long)insn.kaddr))
+				break;
+
+			ret = callback(&insn, data);
+			if (ret)
+				goto end;
+
+			dest = insn_get_branch_addr(&insn);
+			if (entry < dest && dest < end)
+				cbq_push(q, dest);
+
+			/*
+			 * Hit an INT3, which can not be decoded because it
+			 * might be installed by other debug features or it
+			 * just for trapping speculative execution.
+			 * So, let's decode other unchecked code blocks.
+			 */
+			if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
+				break;
+		}
+	}
+	ret = 0;
+end:
+	cbq_free(q);
+	return ret;
+}
+
+static int insn_boundary_cb(struct insn *insn, void *paddr)
+{
+	return insn->kaddr == paddr;
+}
+
+/* Check if paddr is at an instruction boundary */
+static int can_probe(unsigned long paddr)
+{
+	return !(every_insn_in_func(paddr, insn_boundary_cb, (void *)paddr) <= 0);
 }
 
 /* If x86 supports IBT (ENDBR) it must be skipped. */
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index e6b8c5362b94..2e41850cab06 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -235,28 +235,9 @@ static int __insn_is_indirect_jump(struct insn *insn)
 /* Check whether insn jumps into specified address range */
 static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
 {
-	unsigned long target = 0;
-
-	switch (insn->opcode.bytes[0]) {
-	case 0xe0:	/* loopne */
-	case 0xe1:	/* loope */
-	case 0xe2:	/* loop */
-	case 0xe3:	/* jcxz */
-	case 0xe9:	/* near relative jump */
-	case 0xeb:	/* short relative jump */
-		break;
-	case 0x0f:
-		if ((insn->opcode.bytes[1] & 0xf0) == 0x80) /* jcc near */
-			break;
-		return 0;
-	default:
-		if ((insn->opcode.bytes[0] & 0xf0) == 0x70) /* jcc short */
-			break;
-		return 0;
-	}
-	target = (unsigned long)insn->next_byte + insn->immediate.value;
+	unsigned long target = insn_get_branch_addr(insn);
 
-	return (start <= target && target <= start + len);
+	return target ? (start <= target && target <= start + len) : 0;
 }
 
 static int insn_is_indirect_jump(struct insn *insn)

