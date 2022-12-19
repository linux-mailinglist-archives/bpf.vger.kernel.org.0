Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA9650D6C
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiLSOft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiLSOfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 09:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E94BAA;
        Mon, 19 Dec 2022 06:35:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AC48B80E47;
        Mon, 19 Dec 2022 14:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AABEC433F1;
        Mon, 19 Dec 2022 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460523;
        bh=EnQDCn6+DxnGRVKzzZhsuaX7OEoKlrHh00hQOt+anfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKmyNk/GF2R5MK37W+xC38LM2qUuhTaDb71eCE6vtpI9dfYwRmRU7RYbCmx58dvAG
         QwEL1oxHSD9VkHZXbP7ljFFQyJNunM7ngpwu/p0KeBbFv05ogAC55baunB1j6psxqa
         IqS6WMY0krA6NnijbgbFlRqbHcOpHebwOBNY8qSq6JtME6suudObOr+8ghvO+vWR2h
         sVu+Neo38H+y9nuEGTg6MCDBD5vV8BPAYUu7G4+0Fzgq2g759rIyz1FghlzegeG6pN
         MbvmHiczzYmBqjxAVq96B+VGYT27+QIJH7Lon6pZjIu0GFyCjzkaA9sgINx9xLdLOv
         k/c4A9txaI27A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     x86@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH -tip v4 2/2] x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
Date:   Mon, 19 Dec 2022 23:35:19 +0900
Message-Id: <167146051929.1374301.7419382929328081706.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <167146050052.1374301.10407562178447545337.stgit@devnote3>
References: <167146050052.1374301.10407562178447545337.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To avoid this issue, as same as kprobes, check whether the INT3 comes
from kgdb or not, and if so, stop decoding and make it fail. The other
INT3 will come from CONFIG_RETHUNK/CONFIG_SLS and those can be
treated as a one-byte instruction.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/opt.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index e6b8c5362b94..e57e07b0edb6 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -15,6 +15,7 @@
 #include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 #include <linux/ftrace.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
@@ -279,19 +280,6 @@ static int insn_is_indirect_jump(struct insn *insn)
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
@@ -334,15 +322,15 @@ static int can_optimize(unsigned long paddr)
 		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
 		if (ret < 0)
 			return 0;
-
+#ifdef CONFIG_KGDB
 		/*
-		 * In the case of detecting unknown breakpoint, this could be
-		 * a padding INT3 between functions. Let's check that all the
-		 * rest of the bytes are also INT3.
+		 * If there is a dynamically installed kgdb sw breakpoint,
+		 * this function should not be probed.
 		 */
-		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
-			return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
-
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE &&
+		    kgdb_has_hit_break(addr))
+			return 0;
+#endif
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);

