Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B04F8B73
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiDHAxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiDHAxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 20:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD61108550;
        Thu,  7 Apr 2022 17:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E06618D9;
        Fri,  8 Apr 2022 00:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92372C385A9;
        Fri,  8 Apr 2022 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649379066;
        bh=qU7NQO8a/GNTqpF3kK+hxQlG2bDuw47+HzlGrFENsk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOQSPJ8bHkuyeDVLE6PnkAGeUamFLQFl8cos02fJ8bIyktW4ZeXboUeddgG/NMIa2
         CaNnuHS++W12Ut17ouCCXqwYJ+xzcmWBztMK5sTWcpSG2jxXAhAPiqn3n3qyVGs5RI
         DEX5EtMR9GxZz4fdnpitv3nanTaZj3/2+A6vWsYXPUWdbqzEHpBZmqz6Zntz34tHA7
         C5LMwWG4dgQH311WFakZVAhou+Sh0SvqdPRsCt6Y3c6wmsRt18XcHRxwCox1tw8pDO
         criUsaXqR8aM7fK2H+qWAIoPJsfFGnFNwrCMX4p5DabHPNtmE4VZMAFZZAQqElfIOi
         92WbAySEbNahQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf v2 2/4] rethook,fprobe,kprobes: Check a failure in the rethook_hook()
Date:   Fri,  8 Apr 2022 09:51:00 +0900
Message-Id: <164937905999.1272679.6572597960911139308.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164937903547.1272679.7244379141135199176.stgit@devnote2>
References: <164937903547.1272679.7244379141135199176.stgit@devnote2>
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

Since there are possible to fail to hook the function return (depends on
archtecutre implememtation), rethook_hook() should return the error
in that case and caller must check it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/rethook.c |    4 +++-
 include/linux/rethook.h   |    4 ++--
 kernel/kprobes.c          |    8 +++++---
 kernel/trace/fprobe.c     |    5 ++++-
 kernel/trace/rethook.c    |   12 ++++++++++--
 5 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..c92b4875e3b9 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -114,7 +114,7 @@ void arch_rethook_fixup_return(struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+int arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
 {
 	unsigned long *stack = (unsigned long *)regs->sp;
 
@@ -123,5 +123,7 @@ void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mc
 
 	/* Replace the return addr with trampoline addr */
 	stack[0] = (unsigned long) arch_rethook_trampoline;
+
+	return 0;
 }
 NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..07b9c6663b8e 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -63,12 +63,12 @@ void rethook_free(struct rethook *rh);
 void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
 void rethook_recycle(struct rethook_node *node);
-void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
+int rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
 unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame,
 				    struct llist_node **cur);
 
 /* Arch dependent code must implement arch_* and trampoline code */
-void arch_rethook_prepare(struct rethook_node *node, struct pt_regs *regs, bool mcount);
+int arch_rethook_prepare(struct rethook_node *node, struct pt_regs *regs, bool mcount);
 void arch_rethook_trampoline(void);
 
 /**
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dbe57df2e199..7fd7f1195bde 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2109,10 +2109,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 	ri = container_of(rhn, struct kretprobe_instance, node);
 
-	if (rp->entry_handler && rp->entry_handler(ri, regs))
+	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
 		rethook_recycle(rhn);
-	else
-		rethook_hook(rhn, regs, kprobe_ftrace(p));
+	} else if (rethook_hook(rhn, regs, kprobe_ftrace(p)) < 0) {
+		rethook_recycle(rhn);
+		rp->nmissed++;
+	}
 
 	return 0;
 }
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 89d9f994ebb0..d3b13294d545 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -48,7 +48,10 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
-		rethook_hook(rh, ftrace_get_regs(fregs), true);
+		if (rethook_hook(rh, ftrace_get_regs(fregs), true) < 0) {
+			rethook_recycle(rh);
+			fp->nmissed++;
+		}
 	}
 
 out:
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index b56833700d23..e7db83438e45 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -174,11 +174,19 @@ NOKPROBE_SYMBOL(rethook_try_get);
  * from ftrace (mcount) callback, @mcount must be set true. If this is called
  * from the real function entry (e.g. kprobes) @mcount must be set false.
  * This is because the way to hook the function return depends on the context.
+ * This returns 0 if succeeded to hook the function return, or -errno if
+ * failed.
  */
-void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
+int rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
 {
-	arch_rethook_prepare(node, regs, mcount);
+	int ret;
+
+	ret = arch_rethook_prepare(node, regs, mcount);
+	if (ret < 0)
+		return ret;
+
 	__llist_add(&node->llist, &current->rethooks);
+	return 0;
 }
 NOKPROBE_SYMBOL(rethook_hook);
 

