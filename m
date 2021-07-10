Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C013C34FB
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhGJO6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 10:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhGJO6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 10:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4175E6135F;
        Sat, 10 Jul 2021 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625928959;
        bh=WBITSPMuY2SOSls7QrDZOVrbCRn44hMD3p0v4j9HBsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnqDATi3pPFuxU6TEQsjioWw0P1ujJODwYAXGPHnLDUHBTWK/fO+ook3ORb5ilys5
         1ev+Yrt4yMh/OenrTENH8cWrHp6SzhdkxUYGrj5etPeHdyt5p7tx8t5XrbE5iMnjAA
         ww4M0PrACdYRL0TF18H9IdKv2tDH43M5nguLTmmFoO7aStGBNiECoqRwVmdi8F0D0x
         Ve/9l++nO22RM9SftjdNyLboPyMwHXkcJ9yWc42OcZFwqNdyY2MBh569sVnCC5bUN/
         vF7+uRA3IkbcgerE4pAWEn0PI33krw29eYuXz2W7zrvj3Ghn2XdcM8xYxhsEybI98L
         rFDzLFavygX9A==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip 4/6] kprobes: Add assertions for required lock
Date:   Sat, 10 Jul 2021 23:55:56 +0900
Message-Id: <162592895578.1158485.13184803960968132997.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162592891873.1158485.768824457210707916.stgit@devnote2>
References: <162592891873.1158485.768824457210707916.stgit@devnote2>
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
index e5e1400072c8..a99fd840b5c9 100644
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
 
@@ -1056,12 +1060,13 @@ static int prepare_kprobe(struct kprobe *p)
 	return arch_prepare_kprobe_ftrace(p);
 }
 
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
@@ -1093,12 +1098,13 @@ static int arm_kprobe_ftrace(struct kprobe *p)
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
@@ -1138,7 +1144,6 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-/* Arm a kprobe with 'text_mutex'. */
 static int arm_kprobe(struct kprobe *kp)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1153,7 +1158,6 @@ static int arm_kprobe(struct kprobe *kp)
 	return 0;
 }
 
-/* Disarm a kprobe with 'text_mutex'. */
 static int disarm_kprobe(struct kprobe *kp, bool reopt)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1696,12 +1700,13 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
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

