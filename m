Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C83D91F6
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhG1PaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 11:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237349AbhG1PaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 11:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F6006100A;
        Wed, 28 Jul 2021 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486201;
        bh=LeW+FpjWCoF8S7HB9VLImulpdbgkWfK0a1HfGP8n+lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiV6tlH5OfxKCUqxaXdXzGAW7XbuCa/yAB1XbhJyqqV/u/0J2v9CxNUazFj/B6GrP
         SJY/egihaxhDAIrFvTqIKLu91bg+XN5Qy0/rOvgCdLq4iLToyoeRyGRz6NvYS1KYJY
         cLaFHC8MhFrIFvpIvUo77ulIkzaG4hVXkhJN25Sev9BmjYJ4TbE3QKca8CvjqlQeFf
         rL4z6WcdgJ3Djuzt2YvChsQnzrLrTyqu8EKO07CB3JoqpZ0qdwsBfXznBByC1D/EMd
         h2VJ5IfpMYU+6a8IUitoo64Uay5p3vVTJ8omlSER9Dv/Un94pEjjriSKVnugdK9KbN
         xhm/wSUOZzeSg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH -tip v3 4/6] kprobes: Add assertions for required lock
Date:   Thu, 29 Jul 2021 00:29:57 +0900
Message-Id: <162748619699.59465.2846200321698832302.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162748615977.59465.13262421617578791515.stgit@devnote2>
References: <162748615977.59465.13262421617578791515.stgit@devnote2>
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

