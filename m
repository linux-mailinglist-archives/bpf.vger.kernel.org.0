Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9640B183
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhINOmM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhINOlS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C605C610E6;
        Tue, 14 Sep 2021 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630401;
        bh=LeW+FpjWCoF8S7HB9VLImulpdbgkWfK0a1HfGP8n+lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOz28LWDlX0b6eeoTS5bcIurHSaAI5lRXlb1YVvTI4XGwGA+TaTM2xMCc5arQPcZO
         +cQ7vwmJhaZbqhfU3/OfpNFV1pzPn+IHYAVWWP0RTyz9u974wVdhbgoCq2bCRD+e//
         SB+1psdR3aWpMMgbAPLyRO0mWLezNk0BXfh70QqZH1LHNMyelueWLlpJ+6aDIRFJGX
         V21/bLg2E0Um6hZswymx9yckupKxqqGDlkLzfk8GNHSBuWWpFY/lzkrTe2YKOk6eAc
         aaeJeolLatp1XAMeszcb03Veri4O2C/CabKAQXjd8cP/ukR34zggtsIacDNoKyB0jm
         HHCz52DnvKNZw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 09/27] kprobes: Add assertions for required lock
Date:   Tue, 14 Sep 2021 23:39:55 +0900
Message-Id: <163163039572.489837.18011973177537476885.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add assertions for required locks instead of comment it
so that the lockdep can inspect locks automatically.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ad39eeaa4371..ec3d97fd8c6b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -959,11 +959,13 @@ int proc_kprobes_optimization_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_SYSCTL */
 
-/* Put a breakpoint for a probe. Must be called with 'text_mutex' locked. */
+/* Put a breakpoint for a probe. */
 static void __arm_kprobe(struct kprobe *p)
 {
 	struct kprobe *_p;
 
+	lockdep_assert_held(&text_mutex);
+
 	/* Find the overlapping optimized kprobes. */
 	_p = get_optimized_kprobe((unsigned long)p->addr);
 	if (unlikely(_p))
@@ -974,11 +976,13 @@ static void __arm_kprobe(struct kprobe *p)
 	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
 }
 
-/* Remove the breakpoint of a probe. Must be called with 'text_mutex' locked. */
+/* Remove the breakpoint of a probe. */
 static void __disarm_kprobe(struct kprobe *p, bool reopt)
 {
 	struct kprobe *_p;
 
+	lockdep_assert_held(&text_mutex);
+
 	/* Try to unoptimize */
 	unoptimize_kprobe(p, kprobes_all_disarmed);
 
@@ -1047,12 +1051,13 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Caller must lock 'kprobe_mutex' */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
 {
 	int ret = 0;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
 	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
 		return ret;
@@ -1084,12 +1089,13 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 
-/* Caller must lock 'kprobe_mutex'. */
 static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 				  int *cnt)
 {
 	int ret = 0;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);
 		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (error %d)\n", ret))
@@ -1133,7 +1139,6 @@ static int prepare_kprobe(struct kprobe *p)
 	return arch_prepare_kprobe(p);
 }
 
-/* Arm a kprobe with 'text_mutex'. */
 static int arm_kprobe(struct kprobe *kp)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1148,7 +1153,6 @@ static int arm_kprobe(struct kprobe *kp)
 	return 0;
 }
 
-/* Disarm a kprobe with 'text_mutex'. */
 static int disarm_kprobe(struct kprobe *kp, bool reopt)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1691,12 +1695,13 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 	return 1;
 }
 
-/* Disable one kprobe: Make sure called under 'kprobe_mutex' is locked. */
 static struct kprobe *__disable_kprobe(struct kprobe *p)
 {
 	struct kprobe *orig_p;
 	int ret;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	/* Get an original kprobe for return */
 	orig_p = __get_valid_kprobe(p);
 	if (unlikely(orig_p == NULL))

