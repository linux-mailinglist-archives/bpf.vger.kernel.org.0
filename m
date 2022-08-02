Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CBE5876F3
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 08:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiHBGEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 02:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGEZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 02:04:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C4286CA;
        Mon,  1 Aug 2022 23:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED0F6B8188E;
        Tue,  2 Aug 2022 06:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C8C433D6;
        Tue,  2 Aug 2022 06:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659420261;
        bh=+6zmFLLHIbJjwGJi7DLWYs/CmADKhX1mr48SeyTUrIo=;
        h=From:To:Cc:Subject:Date:From;
        b=aeruu50D6SHH/8KwA8HlbirGEEbEVb4Yc7tDp7GvSxj+mro9TLsGOJ4hCsNlrQFEI
         Xr1tVk9OHK4TL7duNeBfqUs5QJn66jYswheoV+rBrtehtmXO9jdgJDmM4kG9rA7qUX
         WD9gOsOpO9hq6UsRiurX2SQWcZNRqbJFeldyHWVspLHOJbbpzbC1nnrWCPjTlRFa66
         T3GReenx/W5HCplPFWI2NkYSxHUFtGWDSEqK8ZAQKedL1TVfookKjNuqiqBvpwzh+s
         kzEKoxXQ7i3OOAfdbxaGATn4wkA4VN2OMoon+FuGlIRdxeN2zyPzqV4TjMcYKX/yqt
         yHw5v86Qj8wbA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
Subject: [PATCH] x86/kprobes: Fix to update kcb status flag after singlestepping
Date:   Tue,  2 Aug 2022 15:04:16 +0900
Message-Id: <165942025658.342061.12452378391879093249.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix kprobes to update kcb (kprobes control block) status flag to
KPROBE_HIT_SSDONE even if the kp->post_handler is not set.
This may cause a kernel panic if another int3 user runs right
after kprobes because kprobe_int3_handler() misunderstands the
int3 is kprobe's single stepping int3.

Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Daniel Müller <deso@posteo.net>
Tested-by: Daniel Müller <deso@posteo.net>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20220727210136.jjgc3lpqeq42yr3m@muellerd-fedora-PC2BDTX9
---
 arch/x86/kernel/kprobes/core.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7c4ab8870da4..74167dc5f55e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -814,16 +814,20 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
 			       struct kprobe_ctlblk *kcb)
 {
-	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		cur->post_handler(cur, regs, 0);
-	}
-
 	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER)
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		/* This will restore both kcb and current_kprobe */
 		restore_previous_kprobe(kcb);
-	else
+	} else {
+		/*
+		 * Always update the kcb status because
+		 * reset_curent_kprobe() doesn't update kcb.
+		 */
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (cur->post_handler)
+			cur->post_handler(cur, regs, 0);
 		reset_current_kprobe();
+	}
 }
 NOKPROBE_SYMBOL(kprobe_post_process);
 

