Return-Path: <bpf+bounces-2502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3972E43C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C31C281226
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABE34CC2;
	Tue, 13 Jun 2023 13:36:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D3522B
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 13:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276A3C433F0;
	Tue, 13 Jun 2023 13:36:08 +0000 (UTC)
Date: Tue, 13 Jun 2023 09:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jackie
 Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230613093606.069a70da@gandalf.local.home>
In-Reply-To: <4c87727b-0b3f-ffc1-d55b-90e75dcae52b@meta.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
	<20230611225407.3e9b8ad2@gandalf.local.home>
	<20230611225754.01350a50@gandalf.local.home>
	<d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
	<20230612110222.50c254f3@gandalf.local.home>
	<ZId/UL/iujOdgel+@krava>
	<4c87727b-0b3f-ffc1-d55b-90e75dcae52b@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jun 2023 22:04:28 -0700
Yonghong Song <yhs@meta.com> wrote:

> Thanks for explanation! It would be great if we can put more details in
> this email into the commit message!

I agree.

This is the patch I just pulled into my queue:

From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Jun 2023 15:00:29 +0200
Subject: [PATCH] ftrace: Show all functions with addresses in
 available_filter_functions_addrs

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

The problem is that we need to do 2 passes:

 - through available_filter_functions and find out if the function is traceable
 - through /proc/kallsyms to get the address for traceable function

Having available_filter_functions symbols together with addresses allow
us to skip the kallsyms step and we are ok with the address in
available_filter_functions_addr not being the function entry, because
kprobe_multi uses fprobe and that handles both entry and patch-site
address properly.

We have 2 interfaces how to create kprobe_multi link:

  a) passing symbols to kernel

     1) user gathers symbols and need to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) kernel takes those symbols and translates them to addresses
        through kallsyms api

     3) addresses are passed to fprobe/ftrace through:

         register_fprobe_ips
         -> ftrace_set_filter_ips

  b) passing addresses to kernel

     1) user gathers symbols and needs to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) user takes those symbols and translates them to addresses
       through /proc/kallsyms

     3) addresses are passed to the kernel and kernel calls:

         register_fprobe_ips
         -> ftrace_set_filter_ips

The new available_filter_functions_addrs file helps us with option b),
because we can make 'b 1' and 'b 2' in one step - while filtering traceable
functions, we get the address directly.

Link: https://lore.kernel.org/linux-trace-kernel/20230611130029.1202298-1-jolsa@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |  6 ++++++
 include/linux/ftrace.h         |  1 +
 kernel/trace/ftrace.c          | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index df2d3e57a83f..b7308ab10c0e 100644
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
index 49f279f4c3a1..8e59bd954153 100644
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
2.39.2


