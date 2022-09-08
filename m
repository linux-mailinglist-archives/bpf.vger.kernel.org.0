Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146B5B2175
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiIHPBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiIHPBo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 11:01:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8EED9B1;
        Thu,  8 Sep 2022 08:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13B29B82124;
        Thu,  8 Sep 2022 15:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56845C433C1;
        Thu,  8 Sep 2022 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662649297;
        bh=EnQDCn6+DxnGRVKzzZhsuaX7OEoKlrHh00hQOt+anfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9X9G4T/J2ADevyxRvIJG1T96e7j6dgfn8qxN2GB1PYwDKwtN84K7hCup+P58Bevp
         FSHBLBpnc9NYt1Yxer9GMApEhxsIo4/YGvTmZRTYcatFt0sivsI3Nx+aUUjTQ/6Kyw
         L2z94AKYSwoUAxTCimgVdPfyUeRY5GcMv2ggaNaizbFFPbEo9L/ELezbW6JZFOpMIT
         hPTCtpvZMkhgu96qiFLGpCprJbrrr8v+vmE95WUyHuOJuBN0QbNXd0pUnFFLfdMHTA
         Nxuoomze5klrf0CoBaafjk53BO4rEnVsXrU+1PNirDJg6HgGmeyuJs5i+dR3n5J0aH
         a3y/40uqZdwsg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH v3 2/2] x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
Date:   Fri,  9 Sep 2022 00:01:32 +0900
Message-Id: <166264929259.775585.14768855667710290362.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166264927154.775585.16570756675363838701.stgit@devnote2>
References: <166264927154.775585.16570756675363838701.stgit@devnote2>
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

