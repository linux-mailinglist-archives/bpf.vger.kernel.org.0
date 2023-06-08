Return-Path: <bpf+bounces-2157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99A728A3E
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849162817DE
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37634CF1;
	Thu,  8 Jun 2023 21:26:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4461DCDC
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 21:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DCCC433EF;
	Thu,  8 Jun 2023 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686259574;
	bh=ITtbb2m5joG2PhMvkk68U8ttOkLZ/iKTC5sxkONv3mY=;
	h=From:To:Cc:Subject:Date:From;
	b=l+JXQ8Os5oW8XuYO/N7ZWh3xTXCZtjccXlQESFcDSdzmUS19fWjqkYv+SbpGSthy0
	 3xAvaklhjyYof3kCn7k6ozpzixT3maFiicfTegCQf3uEZyFdsLl8ANpzfVFrm3Yubu
	 LqMniL3M9n7kbhBvramj1K+q92Qftp29SAHKcf8vV5rMPiSdKlClH4Ej3lqEdOeP3r
	 RVqwZpTJQJCOLgYMUNVBYpGnlialAFgOowU3+tr5pjZ5Z++szZlxJlqwmSJ9xNMeJT
	 8daZgIJI/OZka3MEPvAnxq2plHMi0f3qb29mgb7/LJR0P+izRh4bn92n2axCFaLfCJ
	 YKjuuvdBrqtnw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jackie Liu <liu.yun@linux.dev>
Subject: [PATCH RFC] ftrace: Show all functions with addresses in available_filter_functions_addrs
Date: Thu,  8 Jun 2023 14:26:13 -0700
Message-Id: <20230608212613.424070-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


hi,
when ftrace based tracers we need to cross check available_filter_functions
with /proc/kallsyms. For example for kprobe_multi bpf link (based on fprobe)
we need to make sure that symbol regex resolves to traceable symbols and
that we get proper addresses for them.

Looks like on the last last LSF/MM/BPF there was an agreement to add new
file that will have available_filter_functions symbols plus addresses.

This RFC is to kick off the discussion, I'm not sure Steven wants to do
that differently ;-)

thanks,
jirka


---
Adding new available_filter_functions_addrs file that shows all available
functions (same as available_filter_functions) together with addresses,
like:

  # cat available_filter_functions_addrs | head
  ffffffff81000770 __traceiter_initcall_level
  ffffffff810007c0 __traceiter_initcall_start
  ffffffff81000810 __traceiter_initcall_finish
  ffffffff81000860 trace_initcall_finish_cb
  ...

It's useful to have address avilable for traceable symbols, so we don't
need to allways cross check kallsyms with available_filter_functions
(or the other way around) and have all the data in single file.

For backwards compatibility reasons we can't change the existing
available_filter_functions file output, but we need to add new file.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 52 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b23bdd414394..6e372575a8e9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -633,6 +633,7 @@ enum {
 	FTRACE_ITER_MOD		= (1 << 5),
 	FTRACE_ITER_ENABLED	= (1 << 6),
 	FTRACE_ITER_TOUCHED	= (1 << 7),
+	FTRACE_ITER_ADDRS	= (1 << 8),
 };
 
 void arch_ftrace_update_code(int command);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 764668467155..1f33e1f04834 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3804,7 +3804,7 @@ static int __init ftrace_check_sync(void)
 late_initcall_sync(ftrace_check_sync);
 subsys_initcall(ftrace_check_for_weak_functions);
 
-static int print_rec(struct seq_file *m, unsigned long ip)
+static int print_rec(struct seq_file *m, unsigned long ip, bool print_addr)
 {
 	unsigned long offset;
 	char str[KSYM_SYMBOL_LEN];
@@ -3819,7 +3819,11 @@ static int print_rec(struct seq_file *m, unsigned long ip)
 		ret = NULL;
 	}
 
-	seq_puts(m, str);
+	if (print_addr)
+		seq_printf(m, "%lx %s", ip, str);
+	else
+		seq_puts(m, str);
+
 	if (modname)
 		seq_printf(m, " [%s]", modname);
 	return ret == NULL ? -1 : 0;
@@ -3830,9 +3834,13 @@ static inline int test_for_valid_rec(struct dyn_ftrace *rec)
 	return 1;
 }
 
-static inline int print_rec(struct seq_file *m, unsigned long ip)
+static inline int print_rec(struct seq_file *m, unsigned long ip, bool print_addr)
 {
-	seq_printf(m, "%ps", (void *)ip);
+	if (print_addr)
+		seq_printf(m, "%lx %ps", ip, (void *)ip);
+	else
+		seq_printf(m, "%ps", (void *)ip);
+
 	return 0;
 }
 #endif
@@ -3861,7 +3869,7 @@ static int t_show(struct seq_file *m, void *v)
 	if (!rec)
 		return 0;
 
-	if (print_rec(m, rec->ip)) {
+	if (print_rec(m, rec->ip, iter->flags & FTRACE_ITER_ADDRS)) {
 		/* This should only happen when a rec is disabled */
 		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
 		seq_putc(m, '\n');
@@ -3996,6 +4004,30 @@ ftrace_touched_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int
+ftrace_avail_addrs_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_iterator *iter;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if (unlikely(ftrace_disabled))
+		return -ENODEV;
+
+	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
+	if (!iter)
+		return -ENOMEM;
+
+	iter->pg = ftrace_pages_start;
+	iter->flags = FTRACE_ITER_ADDRS;
+	iter->ops = &global_ops;
+
+	return 0;
+}
+
 /**
  * ftrace_regex_open - initialize function tracer filter files
  * @ops: The ftrace_ops that hold the hash filters
@@ -5916,6 +5948,13 @@ static const struct file_operations ftrace_touched_fops = {
 	.release = seq_release_private,
 };
 
+static const struct file_operations ftrace_avail_addrs_fops = {
+	.open = ftrace_avail_addrs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
 static const struct file_operations ftrace_filter_fops = {
 	.open = ftrace_filter_open,
 	.read = seq_read,
@@ -6377,6 +6416,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
+	trace_create_file("available_filter_functions_addrs", TRACE_MODE_READ,
+			d_tracer, NULL, &ftrace_avail_addrs_fops);
+
 	trace_create_file("enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
-- 
2.40.1


