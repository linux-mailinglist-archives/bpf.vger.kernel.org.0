Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE1650D67
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 15:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiLSOf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 09:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiLSOfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 09:35:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6FBAA;
        Mon, 19 Dec 2022 06:35:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E61BB80D1F;
        Mon, 19 Dec 2022 14:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F3AC433D2;
        Mon, 19 Dec 2022 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460514;
        bh=CX+kGVYhEAgwOekYRSqXxT9FLRH2V059fUkrpfVmAU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzUZIqGk0Qpyqy6ed2SvJAwBxMg5R0na6yBpRjjha/hhZFe54tf6YG6deFhSdfs/j
         k8jkOxEM9ai2AmBoNXNFy3SRs887HOK9WwPjpDp+euHmyoqGkNkIPy3KtiyJMFF+Fu
         TpMOiwkBsqyKZsvez6JPl4nAyRFN9OnW7lIwMWifNRUgTWHH0daRDZK39rGTp8S99P
         5JDh2dNR/bucDggHUJcE905yDr/CGK58hPy5UwggzZgWRVY/3KTreX4rST+kKZfDZs
         EY1H2E22G/O4jqjG+25ydmwb1qUdj5BhkDuKNrNkqPWqDzQCx8BOptn+7++ZNAtaCl
         jceaziZCHtQug==
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
Subject: [PATCH -tip v4 1/2] x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
Date:   Mon, 19 Dec 2022 23:35:10 +0900
Message-Id: <167146051026.1374301.392728975473572291.stgit@devnote3>
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
speculative execution after RET instruction, kprobes always failes to
check the probed instruction boundary by decoding the function body if
the probed address is after such sequence. (Note that some conditional
code blocks will be placed after function return, if compiler decides
it is not on the hot path.)

This is because kprobes expects kgdb puts the INT3 as a software
breakpoint and it will replace the original instruction.
But these INT3 are not such purpose, it doesn't need to recover the
original instruction.

To avoid this issue, kprobes checks whether the INT3 is owned by
kgdb or not, and if so, stop decoding and make it fail. The other
INT3 will come from CONFIG_RETHUNK/CONFIG_SLS and those can be
treated as a one-byte instruction.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 66299682b6b7..b36f3c367cb2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -37,6 +37,7 @@
 #include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 #include <linux/ftrace.h>
 #include <linux/kasan.h>
 #include <linux/moduleloader.h>
@@ -281,12 +282,15 @@ static int can_probe(unsigned long paddr)
 		if (ret < 0)
 			return 0;
 
+#ifdef CONFIG_KGDB
 		/*
-		 * Another debugging subsystem might insert this breakpoint.
-		 * In that case, we can't recover it.
+		 * If there is a dynamically installed kgdb sw breakpoint,
+		 * this function should not be probed.
 		 */
-		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE &&
+		    kgdb_has_hit_break(addr))
 			return 0;
+#endif
 		addr += insn.length;
 	}
 

