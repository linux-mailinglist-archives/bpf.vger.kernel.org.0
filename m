Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F45B1221
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 03:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIHBfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIHBfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 21:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9467CBE;
        Wed,  7 Sep 2022 18:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DAD561B10;
        Thu,  8 Sep 2022 01:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6123DC433C1;
        Thu,  8 Sep 2022 01:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662600898;
        bh=MpUk5QfiMA/Z+tpHnijA0kfP6Xyxn9kenfT4ovmWpf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5qEx7wnEb4iBJV7P0HSs5GDB0/Z1xs3eEU+9YDf8N2NvXK/fzrxy9vWN/JhU1FXC
         10sxNkgyH7JzZeEgyzJtHheIFRfg/XWGDX+HLMUCz4bDZh+RcLSg/XnAgKDsFAnA16
         H7WN0xy4hfb13vLz6Me/pn/Dfo2wHtj2xwgQhkXQWmPps+gt2sjva3DQkANPzmS4KP
         EavP/2vP/DcO+ZELQJ/W0zAscWmkRuLbpoJHBNifzQy3SiB4QMsTPJU0ZkCsziiH6P
         oRnH9b/dnWeXgwwO5W/+cLsWPdi/Vvwzg6a5dT/OGHUusS0yevforDHPGX9dWQ0Av/
         yVQ6MzDZ0uPhw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH v2 2/2] x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
Date:   Thu,  8 Sep 2022 10:34:53 +0900
Message-Id: <166260089342.759381.9286474206764020934.stgit@devnote2>
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
speculative execution after function return, kprobe jump optimization
always fails on the functions with such INT3 inside the function body.
(It already checks the INT3 padding between functions, but not inside
 the function)

To avoid this issue, as same as kprobes, decoding the all code blocks
in the function to check the kprobe can be optimized.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
Cc: stable@vger.kernel.org
---
 Changes in v2:
  - Reuse the kprobes decoding function.
---
 arch/x86/kernel/kprobes/opt.c |   73 +++++++++++++----------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 2e41850cab06..14f8d2c6630a 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -260,25 +260,36 @@ static int insn_is_indirect_jump(struct insn *insn)
 	return ret;
 }
 
-static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
+static int optimize_check_cb(struct insn *insn, void *data)
 {
-	unsigned char ops;
+	unsigned long paddr = (unsigned long)data;
 
-	for (; addr < eaddr; addr++) {
-		if (get_kernel_nofault(ops, (void *)addr) < 0 ||
-		    ops != INT3_INSN_OPCODE)
-			return false;
-	}
+	if (search_exception_tables((unsigned long)insn->kaddr))
+		/*
+		 * Since some fixup code will jumps into this function,
+		 * we can't optimize kprobe in this function.
+		 */
+		return 1;
+
+	/* Check any instructions don't jump into target */
+	if (insn_is_indirect_jump(insn) ||
+	    insn_jump_into_range(insn, paddr + INT3_INSN_SIZE,
+				 DISP32_SIZE))
+		return 1;
+
+	/* Check whether an INT3 is involved. */
+	if (insn->opcode.bytes[0] == INT3_INSN_OPCODE &&
+	    paddr <= (unsigned long)insn->kaddr &&
+	    (unsigned long)insn->kaddr <= paddr + JMP32_INSN_SIZE)
+		return 1;
 
-	return true;
+	return 0;
 }
 
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
-	unsigned long addr, size = 0, offset = 0;
-	struct insn insn;
-	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	unsigned long size = 0, offset = 0;
 
 	/* Lookup symbol including addr */
 	if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
@@ -296,44 +307,8 @@ static int can_optimize(unsigned long paddr)
 	if (size - offset < JMP32_INSN_SIZE)
 		return 0;
 
-	/* Decode instructions */
-	addr = paddr - offset;
-	while (addr < paddr - offset + size) { /* Decode until function end */
-		unsigned long recovered_insn;
-		int ret;
-
-		if (search_exception_tables(addr))
-			/*
-			 * Since some fixup code will jumps into this function,
-			 * we can't optimize kprobe in this function.
-			 */
-			return 0;
-		recovered_insn = recover_probed_instruction(buf, addr);
-		if (!recovered_insn)
-			return 0;
-
-		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
-		if (ret < 0)
-			return 0;
-
-		/*
-		 * In the case of detecting unknown breakpoint, this could be
-		 * a padding INT3 between functions. Let's check that all the
-		 * rest of the bytes are also INT3.
-		 */
-		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
-			return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
-
-		/* Recover address */
-		insn.kaddr = (void *)addr;
-		insn.next_byte = (void *)(addr + insn.length);
-		/* Check any instructions don't jump into target */
-		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
-					 DISP32_SIZE))
-			return 0;
-		addr += insn.length;
-	}
+	if (every_insn_in_func(paddr, optimize_check_cb, (void *)paddr))
+		return 0;
 
 	return 1;
 }

