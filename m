Return-Path: <bpf+bounces-2344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B4572B1EC
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC79281310
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A279DF;
	Sun, 11 Jun 2023 13:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0733F1
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 13:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E93EC433EF;
	Sun, 11 Jun 2023 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686488434;
	bh=w5GEviuZiSz6ulTNLoenUvOQvB5v/kxoYUOgOfhqU7g=;
	h=From:To:Cc:Subject:Date:From;
	b=BaAM7/6YXRn1g/lvATq61O+eRKqA4Ls7KaD2s8I4X4LfW6PIVpQMOgvdMYPf0m3a7
	 2gqzhFQFGsOnbRKivcBIk/nbuRPCTG0LqhTvg6bpgg3wTQ6gfeVcfoq8dWEAxS57Vk
	 lAYLfx27JXewKrZoeb9Yw6fDI6X0eRbBuXuLKxVKgjn94EZ0B2MFXwSdLXh4Yfgjbj
	 DIKMMNt3ZVLWNSM03fWoOvbRB5/Ylg4EA7CYqbaA1g9dQCgT+9IX15+7E+hDRGdqaD
	 MTMmTgMu+NAhOlzgRev/LeMRlxLQTh0cFoO1hzase3lwL9em0DrZsiyqGLYbLxecv5
	 7567EaTg46pfA==
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
Subject: [PATCHv2] ftrace: Show all functions with addresses in available_filter_functions_addrs
Date: Sun, 11 Jun 2023 15:00:29 +0200
Message-Id: <20230611130029.1202298-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new available_filter_functions_addrs file that shows all available
functions (same as available_filter_functions) together with addresses,
like:

  # cat available_filter_functions_addrs | head
  ffffffff81000770 __traceiter_initcall_level
  ffffffff810007c0 __traceiter_initcall_start
  ffffffff81000810 __traceiter_initcall_finish
  ffffffff81000860 trace_initcall_finish_cb
  ...

Note displayed address is the patch-site address and can differ from
/proc/kallsyms address.

It's useful to have address avilable for traceable symbols, so we don't
need to allways cross check kallsyms with available_filter_functions
(or the other way around) and have all the data in single file.

For backwards compatibility reasons we can't change the existing
available_filter_functions file output, but we need to add new file.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/trace/ftrace.rst |  6 ++++++
 include/linux/ftrace.h         |  1 +
 kernel/trace/ftrace.c          | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

v2 changes:
  - simplified address print [Steven]
  - added doc entry for the new file

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 027437b745a0..e97573e3fc4a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -324,6 +324,12 @@ of ftrace. Here is a list of some of the key files:
 	"set_graph_function", or "set_graph_notrace".
 	(See the section "dynamic ftrace" below for more details.)
 
+  available_filter_functions_addrs:
+
+	Similar to available_filter_functions, but with address displayed
+	for each function. The displayed address is the patch-site address
+	and can differ from /proc/kallsyms address.
+
   dyn_ftrace_total_info:
 
 	This file is for debugging purposes. The number of functions that
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
index 764668467155..b24c573934af 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3861,6 +3861,9 @@ static int t_show(struct seq_file *m, void *v)
 	if (!rec)
 		return 0;
 
+	if (iter->flags & FTRACE_ITER_ADDRS)
+		seq_printf(m, "%lx ", rec->ip);
+
 	if (print_rec(m, rec->ip)) {
 		/* This should only happen when a rec is disabled */
 		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
@@ -3996,6 +3999,30 @@ ftrace_touched_open(struct inode *inode, struct file *file)
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
@@ -5916,6 +5943,13 @@ static const struct file_operations ftrace_touched_fops = {
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
@@ -6377,6 +6411,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
+	trace_create_file("available_filter_functions_addrs", TRACE_MODE_READ,
+			d_tracer, NULL, &ftrace_avail_addrs_fops);
+
 	trace_create_file("enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
-- 
2.40.1


