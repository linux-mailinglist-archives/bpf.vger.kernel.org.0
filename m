Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6135A5AF937
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 02:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIGAzc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIGAzb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 20:55:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A486CF7D;
        Tue,  6 Sep 2022 17:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34704B81ADB;
        Wed,  7 Sep 2022 00:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8CC43470;
        Wed,  7 Sep 2022 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662512125;
        bh=9qMDnC2buKP4UgClMUvu+xZbN9+LPObN7qc5Fphlt5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ok4mh7/paLtWrv7GTc1p9anKETp0eOf46AklpH9DLHqKcHmTETuRS7mgH8RzOd8us
         KEfHdaCu0luR16C7NwhmdToOQWBMdBUgD4pvGXwshIUphBUQgx2uO+Z0nLNiX9R1Q7
         gxsBVpChlG/U3yDzRlBp/ZFfr69/wnF//CH5O11Nr8TJX9YmFhywAPZE5MXPZ65KIr
         eI2rfVfxnen0Qp20/LTAQmCsWZHiKnfZ38lNdpGnqa2wh9bR/ulSrqmpB0UsmvyZ3K
         gqz2vWpyzL3xEy4KWePajsdMZl1cYFa0BhiXRbKAW/1zCF5C8Uh1gvBvTmvd7iKZV7
         1TH6Ql2rvh4zA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
Date:   Wed,  7 Sep 2022 09:55:21 +0900
Message-Id: <166251212072.632004.16078953024905883328.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166251211081.632004.1842371136165709807.stgit@devnote2>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
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

Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for padding after
RET instruction, kprobes always failes to check the probed instruction
boundary by decoding the function body if the probed address is after
such paddings (Note that some conditional code blocks will be placed
after RET instruction, if compiler decides it is not on the hot path.)
This is because kprobes expects someone (e.g. kgdb) puts the INT3 as
a software breakpoint and it will replace the original instruction.
But There are INT3 just for padding in the function, it doesn't need
to recover the original instruction.

To avoid this issue, if kprobe finds an INT3, it gets the address of
next non-INT3 byte, and search a branch which jumps to the address.
If there is the branch, these INT3 will be for padding, so it can be
skipped.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/common.h |   67 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/core.c   |   57 ++++++++++++++++++--------------
 arch/x86/kernel/kprobes/opt.c    |   23 +------------
 3 files changed, 100 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index c993521d4933..2adb36eaf366 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -92,6 +92,73 @@ extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
 extern void synthesize_reljump(void *dest, void *from, void *to);
 extern void synthesize_relcall(void *dest, void *from, void *to);
 
+/* Return the jump target address or 0 */
+static inline unsigned long insn_get_branch_addr(struct insn *insn)
+{
+	switch (insn->opcode.bytes[0]) {
+	case 0xe0:	/* loopne */
+	case 0xe1:	/* loope */
+	case 0xe2:	/* loop */
+	case 0xe3:	/* jcxz */
+	case 0xe9:	/* near relative jump */
+	case 0xeb:	/* short relative jump */
+		break;
+	case 0x0f:
+		if ((insn->opcode.bytes[1] & 0xf0) == 0x80) /* jcc near */
+			break;
+		return 0;
+	default:
+		if ((insn->opcode.bytes[0] & 0xf0) == 0x70) /* jcc short */
+			break;
+		return 0;
+	}
+	return (unsigned long)insn->next_byte + insn->immediate.value;
+}
+
+static inline void __decode_insn(struct insn *insn, kprobe_opcode_t *buf,
+				 unsigned long addr)
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
+	}
+}
+
+/* Iterate instructions in [saddr, eaddr), insn->next_byte is loop cursor. */
+#define for_each_insn(insn, saddr, eaddr, buf)				\
+	for (__decode_insn(insn, buf, saddr);				\
+	     (insn)->kaddr && (unsigned long)(insn)->next_byte < eaddr;	\
+	     __decode_insn(insn, buf, (unsigned long)(insn)->next_byte))
+
+/* Return next non-INT3 address, or 0 if failed to access */
+static inline unsigned long skip_padding_int3(unsigned long addr)
+{
+	unsigned char ops;
+
+	while (get_kernel_nofault(ops, (void *)addr) == 0) {
+		if (ops != INT3_INSN_OPCODE)
+			return addr;
+		addr++;
+	}
+
+	return 0;
+}
+
 #ifdef	CONFIG_OPTPROBES
 extern int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter);
 extern unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4c3c27b6aea3..b20484cc0025 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -255,44 +255,49 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 /* Check if paddr is at an instruction boundary */
 static int can_probe(unsigned long paddr)
 {
-	unsigned long addr, __addr, offset = 0;
-	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	unsigned long addr, offset = 0;
+	struct insn insn;
 
 	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
 		return 0;
 
-	/* Decode instructions */
-	addr = paddr - offset;
-	while (addr < paddr) {
-		int ret;
+	/* The first address must be instruction boundary. */
+	if (!offset)
+		return 1;
 
+	/* Decode instructions */
+	for_each_insn(&insn, paddr - offset, paddr, buf) {
 		/*
-		 * Check if the instruction has been modified by another
-		 * kprobe, in which case we replace the breakpoint by the
-		 * original instruction in our buffer.
-		 * Also, jump optimization will change the breakpoint to
-		 * relative-jump. Since the relative-jump itself is
-		 * normally used, we just go through if there is no kprobe.
+		 * CONFIG_RETHUNK or CONFIG_SLS or another debug feature
+		 * may install INT3.
 		 */
-		__addr = recover_probed_instruction(buf, addr);
-		if (!__addr)
-			return 0;
-
-		ret = insn_decode_kernel(&insn, (void *)__addr);
-		if (ret < 0)
-			return 0;
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE) {
+			/* Find the next non-INT3 instruction address */
+			addr = skip_padding_int3((unsigned long)insn.kaddr);
+			if (!addr)
+				return 0;
+			/*
+			 * This can be a padding INT3 for CONFIG_RETHUNK or
+			 * CONFIG_SLS. If a branch jumps to the address next
+			 * to the INT3 sequence, this is just for padding,
+			 * then we can continue decoding.
+			 */
+			for_each_insn(&insn, paddr - offset, addr, buf) {
+				if (insn_get_branch_addr(&insn) == addr)
+					goto found;
+			}
 
-		/*
-		 * Another debugging subsystem might insert this breakpoint.
-		 * In that case, we can't recover it.
-		 */
-		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
+			/* This INT3 can not be decoded safely. */
 			return 0;
-		addr += insn.length;
+found:
+			/* Set loop cursor */
+			insn.next_byte = (void *)addr;
+			continue;
+		}
 	}
 
-	return (addr == paddr);
+	return ((unsigned long)insn.next_byte == paddr);
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

