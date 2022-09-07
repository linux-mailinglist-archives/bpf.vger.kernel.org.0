Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFA5AF939
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIGAzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIGAzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 20:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5406CF4D;
        Tue,  6 Sep 2022 17:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D9661738;
        Wed,  7 Sep 2022 00:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD1C433D7;
        Wed,  7 Sep 2022 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662512135;
        bh=se/afEWZU+1U6axFk6aOj2YfAlp97jvdlbAVZU/vgKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCF4VYzOLWrXvWtPxzp1bA2kjumy/lT2NtuXJkaibzWjQo4ThXymOm7ujIeaY3lIC
         X7PfqjW3K8o+dttODAxuWTSZjaEnSQkxbCKUPQPoCAeIb6eGtZMN5UmoENWrZz8JjG
         2s2NyDmLWO4OR7nE5J9N5BBsxngt5UUrE7tvmr4TB7339cHMIQo24wHClpUcwFPDWg
         xdPjbpVyE+WPqnHYSA+6ZBXBeQz2fR7qyTG7UYK/1xdNYLeNloP98Pg/OUZnDeZ2MP
         51qMctFRTEfliB48H+LyXFkkd9FlE5iGrE48oooQ6tjE4YiZur0X2opq5Eh1HFSVpU
         lHXpBBWf6evzg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH 2/2] x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
Date:   Wed,  7 Sep 2022 09:55:31 +0900
Message-Id: <166251213122.632004.14890772161914623561.stgit@devnote2>
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
RET instruction, kprobe jump optimization always fails on the functions
with INT3 padding inside the function body. (It already checks the INT3
padding between functions, but not inside the function)

To avoid this issue, when it finds an INT3, read following bytes and
find the next non-INT3 instruction, and decode the function again to
search a branch which jumps to that address. If it can not find such
branch instruction, it thinks that INT3 does not come from RETHUNK or
SLS.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/opt.c |   70 +++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 2e41850cab06..ed77eeeef4ed 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -260,25 +260,12 @@ static int insn_is_indirect_jump(struct insn *insn)
 	return ret;
 }
 
-static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
-{
-	unsigned char ops;
-
-	for (; addr < eaddr; addr++) {
-		if (get_kernel_nofault(ops, (void *)addr) < 0 ||
-		    ops != INT3_INSN_OPCODE)
-			return false;
-	}
-
-	return true;
-}
-
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
-	unsigned long addr, size = 0, offset = 0;
-	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
+	unsigned long size = 0, offset = 0;
+	struct insn insn;
 
 	/* Lookup symbol including addr */
 	if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
@@ -296,11 +283,9 @@ static int can_optimize(unsigned long paddr)
 	if (size - offset < JMP32_INSN_SIZE)
 		return 0;
 
-	/* Decode instructions */
-	addr = paddr - offset;
-	while (addr < paddr - offset + size) { /* Decode until function end */
-		unsigned long recovered_insn;
-		int ret;
+	/* Decode all instructions in the function */
+	for_each_insn(&insn, paddr - offset, paddr - offset + size, buf) {
+		unsigned long addr = (unsigned long)insn.kaddr;
 
 		if (search_exception_tables(addr))
 			/*
@@ -308,31 +293,42 @@ static int can_optimize(unsigned long paddr)
 			 * we can't optimize kprobe in this function.
 			 */
 			return 0;
-		recovered_insn = recover_probed_instruction(buf, addr);
-		if (!recovered_insn)
-			return 0;
 
-		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
-		if (ret < 0)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE) {
+			addr = skip_padding_int3(addr);
+			if (!addr)
+				return 0;
+			/*
+			 * If addr becomes the next function entry, this is
+			 * the INT3 padding between functions.
+			 */
+			if (addr - 1 == paddr - offset + size)
+				return 1;
+
+			/*
+			 * This can be padding INT3 for CONFIG_RETHUNK or
+			 * CONFIG_SLS. If a branch jumps to the address next
+			 * to the INT3 sequence, this is just for padding,
+			 * then we can continue decoding.
+			 */
+			for_each_insn(&insn, paddr - offset, addr, buf) {
+				if (insn_get_branch_addr(&insn) == addr)
+					goto found;
+			}
+
+			/* This INT3 can not be decoded safely. */
 			return 0;
+found:
+			/* Set loop cursor */
+			insn.next_byte = (void *)addr;
+			continue;
+		}
 
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
 		/* Check any instructions don't jump into target */
 		if (insn_is_indirect_jump(&insn) ||
 		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
 					 DISP32_SIZE))
 			return 0;
-		addr += insn.length;
 	}
 
 	return 1;

