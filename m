Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3D13DDD1
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPOpT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPOpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:18 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C702075B;
        Thu, 16 Jan 2020 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185918;
        bh=av/dEcA/sXTt3eARj4QuByAAuTkVtu1gXciMKX8ZVoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeDWQFx123BbDcVQ5H1xHdKek8/W9Fb2stCraYpC/+wtM9Zqyfnl8t6cQ9yR2SHpP
         5+6QvMP8WEe1NQuCA/REtaH6wPmKlP+SVkMbeodeeAfKdGekVAlRifHj43TERvia+e
         wYal5mGic1h9CriEiA2+mLVH2BuOG3pfACWIgaRU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 06/13] kprobes: Enable kprobe-booster with CONFIG_PREEMPT=y
Date:   Thu, 16 Jan 2020 23:45:12 +0900
Message-Id: <157918591239.29301.2563999389420824545.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As we did in commit a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks()
for optprobe with CONFIG_PREEMPT=y"), we can also enable kprobe-
booster which depends on trampoline execution buffer as same as
optprobe. Before releasing the trampoline buffer (kprobe_insn_page),
the garbage collector waits for all potentially preempted tasks on
the trampoline bufer using synchronize_rcu_tasks() instead of
synchronize_rcu().

This requires to enable CONFIG_TASKS_RCU=y too, so this also
introduces HAVE_KPROBES_BOOSTER for the archs which supports
kprobe-booster (currently only x86 and ia64.)

If both of CONFIG_PREEMPTION and HAVE_KPROBES_BOOSTER is y,
CONFIG_KPROBES selects CONFIG_TASKS_RCU=y.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/Kconfig                   |    4 ++++
 arch/ia64/Kconfig              |    1 +
 arch/ia64/kernel/kprobes.c     |    3 +--
 arch/x86/Kconfig               |    1 +
 arch/x86/kernel/kprobes/core.c |    2 --
 kernel/kprobes.c               |    4 ++--
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 48b5e103bdb0..ead87084c8bf 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -64,6 +64,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
+	select TASKS_RCU if PREEMPTION && HAVE_KPROBES_BOOSTER
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -189,6 +190,9 @@ config HAVE_KPROBES
 config HAVE_KRETPROBES
 	bool
 
+config HAVE_KPROBES_BOOSTER
+	bool
+
 config HAVE_OPTPROBES
 	bool
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bab7cd878464..341f9ca8a745 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -25,6 +25,7 @@ config IA64
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
+	select HAVE_KPROBES_BOOSTER
 	select HAVE_KRETPROBES
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE if (!ITANIUM)
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index a6d6a0556f08..1680a10c9f49 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -841,7 +841,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		return 1;
 	}
 
-#if !defined(CONFIG_PREEMPTION)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		ia64_psr(regs)->ri = p->ainsn.slot;
@@ -853,7 +852,7 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		preempt_enable_no_resched();
 		return 1;
 	}
-#endif
+
 	prepare_ss(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e5800e52a59a..d509578d824b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,6 +181,7 @@ config X86
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES
+	select HAVE_KPROBES_BOOSTER
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4d7022a740ab..7aba45037885 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -587,7 +587,6 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 	if (setup_detour_execution(p, regs, reenter))
 		return;
 
-#if !defined(CONFIG_PREEMPTION)
 	if (p->ainsn.boostable && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)
@@ -600,7 +599,6 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->ip = (unsigned long)p->ainsn.insn;
 		return;
 	}
-#endif
 	if (reenter) {
 		save_previous_kprobe(kcb);
 		set_current_kprobe(p, regs, kcb);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9c6e230852ad..848c14e92ccc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -220,8 +220,8 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
 {
 	struct kprobe_insn_page *kip, *next;
 
-	/* Ensure no-one is interrupted on the garbages */
-	synchronize_rcu();
+	/* Ensure no-one is running on the garbages. */
+	synchronize_rcu_tasks();
 
 	list_for_each_entry_safe(kip, next, &c->pages, list) {
 		int i;

