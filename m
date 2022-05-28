Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A510536D8E
	for <lists+bpf@lfdr.de>; Sat, 28 May 2022 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiE1Pm6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 May 2022 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiE1Pm5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 May 2022 11:42:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12188183A3;
        Sat, 28 May 2022 08:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 252BCB800C1;
        Sat, 28 May 2022 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2784C34100;
        Sat, 28 May 2022 15:42:49 +0000 (UTC)
Date:   Sat, 28 May 2022 11:42:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH v7] ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding
 weak function
Message-ID: <20220528114248.31cf36d4@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If an unused weak function was traced, it's call to fentry will still
exist, which gets added into the __mcount_loc table. Ftrace will use
kallsyms to retrieve the name for each location in __mcount_loc to display
it in the available_filter_functions and used to enable functions via the
name matching in set_ftrace_filter/notrace. Enabling these functions do
nothing but enable an unused call to ftrace_caller. If a traced weak
function is overridden, the symbol of the function would be used for it,
which will either created duplicate names, or if the previous function was
not traced, it would be incorrectly be listed in available_filter_functions
as a function that can be traced.

This became an issue with BPF[1] as there are tooling that enables the
direct callers via ftrace but then checks to see if the functions were
actually enabled. The case of one function that was marked notrace, but
was followed by an unused weak function that was traced. The unused
function's call to fentry was added to the __mcount_loc section, and
kallsyms retrieved the untraced function's symbol as the weak function was
overridden. Since the untraced function would not get traced, the BPF
check would detect this and fail.

The real fix would be to fix kallsyms to not show addresses of weak
functions as the function before it. But that would require adding code in
the build to add function size to kallsyms so that it can know when the
function ends instead of just using the start of the next known symbol.

In the mean time, this is a work around. Add a FTRACE_MCOUNT_MAX_OFFSET
macro that if defined, ftrace will ignore any function that has its call
to fentry/mcount that has an offset from the symbol that is greater than
FTRACE_MCOUNT_MAX_OFFSET.

If CONFIG_HAVE_FENTRY is defined for x86, define FTRACE_MCOUNT_MAX_OFFSET
to zero (unless IBT is enabled), which will have ftrace ignore all locations
that are not at the start of the function (or one after the ENDBR
instruction).

A worker thread is added at boot up to scan all the ftrace record entries,
and will mark any that fail the FTRACE_MCOUNT_MAX_OFFSET test as disabled.
They will still appear in the available_filter_functions file as:

  __ftrace_invalid_address___<invalid-offset>

(showing the offset that caused it to be invalid).

This is required for tools that use libtracefs (like trace-cmd does) that
scan the available_filter_functions and enable set_ftrace_filter and
set_ftrace_notrace using indexes of the function listed in the file (this
is a speedup, as enabling thousands of files via names is an O(n^2)
operation and can take minutes to complete, where the indexing takes less
than a second).

The invalid functions cannot be removed from available_filter_functions as
the names there correspond to the ftrace records in the array that manages
them (and the indexing depends on this).

[1] https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v6: https://lore.kernel.org/all/20220527234003.2719e6c6@gandalf.local.home/
 - Clear all flags set in the weak record for modules other than 
   the DISABLED flag. Also, move the check before doing the reference
   counting.

 arch/x86/include/asm/ftrace.h |   7 ++
 kernel/trace/ftrace.c         | 141 +++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 024d9797646e..b5ef474be858 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -9,6 +9,13 @@
 # define MCOUNT_ADDR		((unsigned long)(__fentry__))
 #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
 
+/* Ignore unused weak functions which will have non zero offsets */
+#ifdef CONFIG_HAVE_FENTRY
+# include <asm/ibt.h>
+/* Add offset for endbr64 if IBT enabled */
+# define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d653ef4febc5..c5088c76a108 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -45,6 +45,8 @@
 #include "trace_output.h"
 #include "trace_stat.h"
 
+#define FTRACE_INVALID_FUNCTION		"__ftrace_invalid_address__"
+
 #define FTRACE_WARN_ON(cond)			\
 	({					\
 		int ___r = cond;		\
@@ -3654,6 +3656,105 @@ static void add_trampoline_func(struct seq_file *m, struct ftrace_ops *ops,
 		seq_printf(m, " ->%pS", ptr);
 }
 
+#ifdef FTRACE_MCOUNT_MAX_OFFSET
+/*
+ * Weak functions can still have an mcount/fentry that is saved in
+ * the __mcount_loc section. These can be detected by having a
+ * symbol offset of greater than FTRACE_MCOUNT_MAX_OFFSET, as the
+ * symbol found by kallsyms is not the function that the mcount/fentry
+ * is part of. The offset is much greater in these cases.
+ *
+ * Test the record to make sure that the ip points to a valid kallsyms
+ * and if not, mark it disabled.
+ */
+static int test_for_valid_rec(struct dyn_ftrace *rec)
+{
+	char str[KSYM_SYMBOL_LEN];
+	unsigned long offset;
+	const char *ret;
+
+	ret = kallsyms_lookup(rec->ip, NULL, &offset, NULL, str);
+
+	/* Weak functions can cause invalid addresses */
+	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
+		rec->flags |= FTRACE_FL_DISABLED;
+		return 0;
+	}
+	return 1;
+}
+
+static struct workqueue_struct *ftrace_check_wq __initdata;
+static struct work_struct ftrace_check_work __initdata;
+
+/*
+ * Scan all the mcount/fentry entries to make sure they are valid.
+ */
+static __init void ftrace_check_work_func(struct work_struct *work)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec;
+
+	mutex_lock(&ftrace_lock);
+	do_for_each_ftrace_rec(pg, rec) {
+		test_for_valid_rec(rec);
+	} while_for_each_ftrace_rec();
+	mutex_unlock(&ftrace_lock);
+}
+
+static int __init ftrace_check_for_weak_functions(void)
+{
+	INIT_WORK(&ftrace_check_work, ftrace_check_work_func);
+
+	ftrace_check_wq = alloc_workqueue("ftrace_check_wq", WQ_UNBOUND, 0);
+
+	queue_work(ftrace_check_wq, &ftrace_check_work);
+	return 0;
+}
+
+static int __init ftrace_check_sync(void)
+{
+	/* Make sure the ftrace_check updates are finished */
+	if (ftrace_check_wq)
+		destroy_workqueue(ftrace_check_wq);
+	return 0;
+}
+
+late_initcall_sync(ftrace_check_sync);
+subsys_initcall(ftrace_check_for_weak_functions);
+
+static int print_rec(struct seq_file *m, unsigned long ip)
+{
+	unsigned long offset;
+	char str[KSYM_SYMBOL_LEN];
+	char *modname;
+	const char *ret;
+
+	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
+	/* Weak functions can cause invalid addresses */
+	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
+		snprintf(str, KSYM_SYMBOL_LEN, "%s_%ld",
+			 FTRACE_INVALID_FUNCTION, offset);
+		ret = NULL;
+	}
+
+	seq_puts(m, str);
+	if (modname)
+		seq_printf(m, " [%s]", modname);
+	return ret == NULL ? -1 : 0;
+}
+#else
+static inline int test_for_valid_rec(struct dyn_ftrace *rec)
+{
+	return 1;
+}
+
+static inline int print_rec(struct seq_file *m, unsigned long ip)
+{
+	seq_printf(m, "%ps", (void *)ip);
+	return 0;
+}
+#endif
+
 static int t_show(struct seq_file *m, void *v)
 {
 	struct ftrace_iterator *iter = m->private;
@@ -3678,7 +3779,13 @@ static int t_show(struct seq_file *m, void *v)
 	if (!rec)
 		return 0;
 
-	seq_printf(m, "%ps", (void *)rec->ip);
+	if (print_rec(m, rec->ip)) {
+		/* This should only happen when a rec is disabled */
+		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
+		seq_putc(m, '\n');
+		return 0;
+	}
+
 	if (iter->flags & FTRACE_ITER_ENABLED) {
 		struct ftrace_ops *ops;
 
@@ -3996,6 +4103,24 @@ add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 	return 0;
 }
 
+#ifdef FTRACE_MCOUNT_MAX_OFFSET
+static int lookup_ip(unsigned long ip, char **modname, char *str)
+{
+	unsigned long offset;
+
+	kallsyms_lookup(ip, NULL, &offset, modname, str);
+	if (offset > FTRACE_MCOUNT_MAX_OFFSET)
+		return -1;
+	return 0;
+}
+#else
+static int lookup_ip(unsigned long ip, char **modname, char *str)
+{
+	kallsyms_lookup(ip, NULL, NULL, modname, str);
+	return 0;
+}
+#endif
+
 static int
 ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 		struct ftrace_glob *mod_g, int exclude_mod)
@@ -4003,7 +4128,12 @@ ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 	char str[KSYM_SYMBOL_LEN];
 	char *modname;
 
-	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str);
+	if (lookup_ip(rec->ip, &modname, str)) {
+		/* This should only happen when a rec is disabled */
+		WARN_ON_ONCE(system_state == SYSTEM_RUNNING &&
+			     !(rec->flags & FTRACE_FL_DISABLED));
+		return 0;
+	}
 
 	if (mod_g) {
 		int mod_matches = (modname) ? ftrace_match(modname, mod_g) : 0;
@@ -6819,6 +6949,13 @@ void ftrace_module_enable(struct module *mod)
 		    !within_module_init(rec->ip, mod))
 			break;
 
+		/* Weak functions should still be ignored */
+		if (!test_for_valid_rec(rec)) {
+			/* Clear all other flags. Should not be enabled anyway */
+			rec->flags = FTRACE_FL_DISABLED;
+			continue;
+		}
+
 		cnt = 0;
 
 		/*
-- 
2.35.1

