Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F86F3C03
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjEBCRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 22:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjEBCRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 22:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A740F9;
        Mon,  1 May 2023 19:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37CA961FF6;
        Tue,  2 May 2023 02:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D0EC4339B;
        Tue,  2 May 2023 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682993860;
        bh=53Iwo9yaolfWQgcC9CShnGcZ95vPLha6RhbZjE/l2yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxchMVlWbAFCPMxhODAVteRycVvFoICUrWfAgvmmUy3IbncctytsiPnYIP2yYwgW0
         6P//5dtXXexg8PhKCHrAtdS/oPMPwW7r4PVeKFVwFvdLZq9q1DOOSmlvZ8xU5NJmkk
         FIfLg/SQ7BYEvUwh4CsNxnhf0rLoQkhzX3vbD7Tt12WXMCuBVPTAQwGj+F+EtgteGF
         1cuF36UaklHWe5Ww+UGUzHOzpvOiiQj6vpWuB/zQdJLpbXqwrctiWh/9nIcUL2YSpG
         wWBV4RMrcIGrX2/4lHT9hKlVRm1Y9ul9iDcbOhhLQSN+tZtwCUGFRKqugW/GEiTqOc
         Lir6UMxWvIiiA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v9.1 02/11] tracing/probes: Add fprobe events for tracing function entry and exit.
Date:   Tue,  2 May 2023 11:17:36 +0900
Message-ID:  <168299385687.3242086.18384268741128867952.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To:  <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
References:  <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add fprobe events for tracing function entry and exit instead of kprobe
events. With this change, we can continue to trace function entry/exit
even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
it is not available if the architecture only supports
CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
probe function entry/exit effectively on such architecture.
But this can be solved if the dynamic events supports fprobe events.

The fprobe event is a new dynamic events which is only for the function
(symbol) entry and exit. This event accepts non register fetch arguments
so that user can trace the function arguments and return values.

The fprobe events syntax is here;

 f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
 f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

E.g.

 # echo 'f vfs_read $arg1'  >> dynamic_events
 # echo 'f vfs_read%return $retval'  >> dynamic_events
 # cat dynamic_events
 f:fprobes/vfs_read__entry vfs_read arg1=$arg1
 f:fprobes/vfs_read__exit vfs_read%return arg1=$retval
 # echo 1 > events/fprobes/enable
 # head -n 20 trace | tail
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
              sh-142     [005] ...1.   448.386420: vfs_read__entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386436: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.386451: vfs_read__entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386458: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.386469: vfs_read__entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.386476: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
              sh-142     [005] ...1.   448.602073: vfs_read__entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
              sh-142     [005] .....   448.602089: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1


Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202302011530.7vm4O8Ro-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v6:
 - Drop bpf-prog call because it is not supported on fprobe events.
Changes in v5:
 - Sort header files alphabetically.
 - Fix typo.
 - Change default event name with '__<place>' suffix.
 - Change common error name MAXACT_NO_KPROBE to BAD_MAXACT_TYPE
 - Fix to show README entry correctly
---
 include/linux/fprobe.h                             |    5 
 include/linux/trace_events.h                       |    3 
 kernel/trace/Kconfig                               |   14 
 kernel/trace/Makefile                              |    1 
 kernel/trace/fprobe.c                              |   11 
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace.h                               |   11 
 kernel/trace/trace_fprobe.c                        | 1053 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |    2 
 kernel/trace/trace_probe.c                         |    4 
 kernel/trace/trace_probe.h                         |    5 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 
 12 files changed, 1110 insertions(+), 9 deletions(-)
 create mode 100644 kernel/trace/trace_fprobe.c

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 134f0f59ffa8..3e03758151f4 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -66,6 +66,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
 int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
 int unregister_fprobe(struct fprobe *fp);
+bool fprobe_is_registered(struct fprobe *fp);
 #else
 static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
@@ -83,6 +84,10 @@ static inline int unregister_fprobe(struct fprobe *fp)
 {
 	return -EOPNOTSUPP;
 }
+static inline bool fprobe_is_registered(struct fprobe *fp)
+{
+	return false;
+}
 #endif
 
 /**
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0e373222a6df..fcdc1f0bed23 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -318,6 +318,7 @@ enum {
 	TRACE_EVENT_FL_KPROBE_BIT,
 	TRACE_EVENT_FL_UPROBE_BIT,
 	TRACE_EVENT_FL_EPROBE_BIT,
+	TRACE_EVENT_FL_FPROBE_BIT,
 	TRACE_EVENT_FL_CUSTOM_BIT,
 };
 
@@ -332,6 +333,7 @@ enum {
  *  KPROBE        - Event is a kprobe
  *  UPROBE        - Event is a uprobe
  *  EPROBE        - Event is an event probe
+ *  FPROBE        - Event is an function probe
  *  CUSTOM        - Event is a custom event (to be attached to an exsiting tracepoint)
  *                   This is set when the custom event has not been attached
  *                   to a tracepoint yet, then it is cleared when it is.
@@ -346,6 +348,7 @@ enum {
 	TRACE_EVENT_FL_KPROBE		= (1 << TRACE_EVENT_FL_KPROBE_BIT),
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
 	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
+	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
 	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
 };
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8cf97fa4a4b3..8e10a9453c96 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -650,6 +650,20 @@ config BLK_DEV_IO_TRACE
 
 	  If unsure, say N.
 
+config FPROBE_EVENTS
+	depends on FPROBE
+	depends on HAVE_REGS_AND_STACK_ACCESS_API
+	bool "Enable fprobe-based dynamic events"
+	select TRACING
+	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
+	default y
+	help
+	  This allows user to add tracing events on the function entry and
+	  exit via ftrace interface. The syntax is same as the kprobe events
+	  and the kprobe events on function entry and exit will be
+	  transparently converted to this fprobe events.
+
 config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c6651e16b557..64b61f67a403 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
+obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 973bc664fcc1..1cfd4edcd579 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -305,6 +305,14 @@ int register_fprobe_syms(struct fprobe *fp, const char **syms, int num)
 }
 EXPORT_SYMBOL_GPL(register_fprobe_syms);
 
+bool fprobe_is_registered(struct fprobe *fp)
+{
+	if (!fp || (fp->ops.saved_func != fprobe_handler &&
+		    fp->ops.saved_func != fprobe_kprobe_handler))
+		return false;
+	return true;
+}
+
 /**
  * unregister_fprobe() - Unregister fprobe from ftrace
  * @fp: A fprobe data structure to be unregistered.
@@ -317,8 +325,7 @@ int unregister_fprobe(struct fprobe *fp)
 {
 	int ret;
 
-	if (!fp || (fp->ops.saved_func != fprobe_handler &&
-		    fp->ops.saved_func != fprobe_kprobe_handler))
+	if (!fprobe_is_registered(fp))
 		return -EINVAL;
 
 	/*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 427da2341bf0..d595cef93122 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5644,10 +5644,16 @@ static const char readme_msg[] =
 	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
-#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
+#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
+    defined(CONFIG_FPROBE_EVENTS)
 	"\t  accepts: event-definitions (one definition per line)\n"
+#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
+#endif
+#ifdef CONFIG_FPROBE_EVENTS
+	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+#endif
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79bdefe9261b..b5ab5479f9e3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -148,6 +148,17 @@ struct kretprobe_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
+struct fentry_trace_entry_head {
+	struct trace_entry	ent;
+	unsigned long		ip;
+};
+
+struct fexit_trace_entry_head {
+	struct trace_entry	ent;
+	unsigned long		func;
+	unsigned long		ret_ip;
+};
+
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
new file mode 100644
index 000000000000..0049d9ef2402
--- /dev/null
+++ b/kernel/trace/trace_fprobe.c
@@ -0,0 +1,1053 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fprobe-based tracing events
+ * Copyright (C) 2022 Google LLC.
+ */
+#define pr_fmt(fmt)	"trace_fprobe: " fmt
+
+#include <linux/fprobe.h>
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
+#include <linux/uaccess.h>
+
+#include "trace_dynevent.h"
+#include "trace_probe.h"
+#include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
+
+#define FPROBE_EVENT_SYSTEM "fprobes"
+#define RETHOOK_MAXACTIVE_MAX 4096
+
+static int trace_fprobe_create(const char *raw_command);
+static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_fprobe_release(struct dyn_event *ev);
+static bool trace_fprobe_is_busy(struct dyn_event *ev);
+static bool trace_fprobe_match(const char *system, const char *event,
+			int argc, const char **argv, struct dyn_event *ev);
+
+static struct dyn_event_operations trace_fprobe_ops = {
+	.create = trace_fprobe_create,
+	.show = trace_fprobe_show,
+	.is_busy = trace_fprobe_is_busy,
+	.free = trace_fprobe_release,
+	.match = trace_fprobe_match,
+};
+
+/*
+ * Fprobe event core functions
+ */
+struct trace_fprobe {
+	struct dyn_event	devent;
+	struct fprobe		fp;
+	const char		*symbol;
+	struct trace_probe	tp;
+};
+
+static bool is_trace_fprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_fprobe_ops;
+}
+
+static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_fprobe, devent);
+}
+
+/**
+ * for_each_trace_fprobe - iterate over the trace_fprobe list
+ * @pos:	the struct trace_fprobe * for each entry
+ * @dpos:	the struct dyn_event * to use as a loop cursor
+ */
+#define for_each_trace_fprobe(pos, dpos)	\
+	for_each_dyn_event(dpos)		\
+		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
+
+static bool trace_fprobe_is_return(struct trace_fprobe *tf)
+{
+	return tf->fp.exit_handler != NULL;
+}
+
+static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
+{
+	return tf->symbol ? tf->symbol : "unknown";
+}
+
+static bool trace_fprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_fprobe *tf = to_trace_fprobe(ev);
+
+	return trace_probe_is_enabled(&tf->tp);
+}
+
+static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
+					    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+
+	if (!argc)
+		return true;
+
+	snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
+	if (strcmp(buf, argv[0]))
+		return false;
+	argc--; argv++;
+
+	return trace_probe_match_command_args(&tf->tp, argc, argv);
+}
+
+static bool trace_fprobe_match(const char *system, const char *event,
+			int argc, const char **argv, struct dyn_event *ev)
+{
+	struct trace_fprobe *tf = to_trace_fprobe(ev);
+
+	return (event[0] == '\0' ||
+		strcmp(trace_probe_name(&tf->tp), event) == 0) &&
+	    (!system || strcmp(trace_probe_group_name(&tf->tp), system) == 0) &&
+	    trace_fprobe_match_command_head(tf, argc, argv);
+}
+
+static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
+{
+	return fprobe_is_registered(&tf->fp);
+}
+
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
+		   void *base)
+{
+	struct pt_regs *regs = rec;
+	unsigned long val;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_REG:
+		val = regs_get_register(regs, code->param);
+		break;
+	case FETCH_OP_STACK:
+		val = regs_get_kernel_stack_nth(regs, code->param);
+		break;
+	case FETCH_OP_STACKP:
+		val = kernel_stack_pointer(regs);
+		break;
+	case FETCH_OP_RETVAL:
+		val = regs_return_value(regs);
+		break;
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	case FETCH_OP_ARG:
+		val = regs_get_kernel_argument(regs, code->param);
+		break;
+#endif
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
+/* function entry handler */
+static nokprobe_inline void
+__fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
+		    struct pt_regs *regs,
+		    struct trace_event_file *trace_file)
+{
+	struct fentry_trace_entry_head *entry;
+	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
+	struct trace_event_buffer fbuffer;
+	int dsize;
+
+	WARN_ON(call != trace_file->event_call);
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	dsize = __get_data_size(&tf->tp, regs);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tf->tp.size + dsize);
+	if (!entry)
+		return;
+
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
+	entry->ip = entry_ip;
+	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void
+fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
+		  struct pt_regs *regs)
+{
+	struct event_file_link *link;
+
+	trace_probe_for_each_link_rcu(link, &tf->tp)
+		__fentry_trace_func(tf, entry_ip, regs, link->file);
+}
+NOKPROBE_SYMBOL(fentry_trace_func);
+
+/* Kretprobe handler */
+static nokprobe_inline void
+__fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
+		   unsigned long ret_ip, struct pt_regs *regs,
+		   struct trace_event_file *trace_file)
+{
+	struct fexit_trace_entry_head *entry;
+	struct trace_event_buffer fbuffer;
+	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
+	int dsize;
+
+	WARN_ON(call != trace_file->event_call);
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	dsize = __get_data_size(&tf->tp, regs);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tf->tp.size + dsize);
+	if (!entry)
+		return;
+
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
+	entry->func = entry_ip;
+	entry->ret_ip = ret_ip;
+	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void
+fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
+		 unsigned long ret_ip, struct pt_regs *regs)
+{
+	struct event_file_link *link;
+
+	trace_probe_for_each_link_rcu(link, &tf->tp)
+		__fexit_trace_func(tf, entry_ip, ret_ip, regs, link->file);
+}
+NOKPROBE_SYMBOL(fexit_trace_func);
+
+#ifdef CONFIG_PERF_EVENTS
+
+static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
+			    struct pt_regs *regs)
+{
+	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
+	struct fentry_trace_entry_head *entry;
+	struct hlist_head *head;
+	int size, __size, dsize;
+	int rctx;
+
+	head = this_cpu_ptr(call->perf_events);
+	if (hlist_empty(head))
+		return 0;
+
+	dsize = __get_data_size(&tf->tp, regs);
+	__size = sizeof(*entry) + tf->tp.size + dsize;
+	size = ALIGN(__size + sizeof(u32), sizeof(u64));
+	size -= sizeof(u32);
+
+	entry = perf_trace_buf_alloc(size, NULL, &rctx);
+	if (!entry)
+		return 0;
+
+	entry->ip = entry_ip;
+	memset(&entry[1], 0, dsize);
+	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
+			      head, NULL);
+	return 0;
+}
+NOKPROBE_SYMBOL(fentry_perf_func);
+
+static void
+fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
+		unsigned long ret_ip, struct pt_regs *regs)
+{
+	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
+	struct fexit_trace_entry_head *entry;
+	struct hlist_head *head;
+	int size, __size, dsize;
+	int rctx;
+
+	head = this_cpu_ptr(call->perf_events);
+	if (hlist_empty(head))
+		return;
+
+	dsize = __get_data_size(&tf->tp, regs);
+	__size = sizeof(*entry) + tf->tp.size + dsize;
+	size = ALIGN(__size + sizeof(u32), sizeof(u64));
+	size -= sizeof(u32);
+
+	entry = perf_trace_buf_alloc(size, NULL, &rctx);
+	if (!entry)
+		return;
+
+	entry->func = entry_ip;
+	entry->ret_ip = ret_ip;
+	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
+			      head, NULL);
+}
+NOKPROBE_SYMBOL(fexit_perf_func);
+#endif	/* CONFIG_PERF_EVENTS */
+
+static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
+			     unsigned long ret_ip, struct pt_regs *regs,
+			     void *entry_data)
+{
+	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	int ret = 0;
+
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+		fentry_trace_func(tf, entry_ip, regs);
+#ifdef CONFIG_PERF_EVENTS
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+		ret = fentry_perf_func(tf, entry_ip, regs);
+#endif
+	return ret;
+}
+NOKPROBE_SYMBOL(fentry_dispatcher);
+
+static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
+			     unsigned long ret_ip, struct pt_regs *regs,
+			     void *entry_data)
+{
+	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+		fexit_trace_func(tf, entry_ip, ret_ip, regs);
+#ifdef CONFIG_PERF_EVENTS
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+		fexit_perf_func(tf, entry_ip, ret_ip, regs);
+#endif
+}
+NOKPROBE_SYMBOL(fexit_dispatcher);
+
+static void free_trace_fprobe(struct trace_fprobe *tf)
+{
+	if (tf) {
+		trace_probe_cleanup(&tf->tp);
+		kfree(tf->symbol);
+		kfree(tf);
+	}
+}
+
+/*
+ * Allocate new trace_probe and initialize it (including fprobe).
+ */
+static struct trace_fprobe *alloc_trace_fprobe(const char *group,
+					       const char *event,
+					       const char *symbol,
+					       int maxactive,
+					       int nargs, bool is_return)
+{
+	struct trace_fprobe *tf;
+	int ret = -ENOMEM;
+
+	tf = kzalloc(struct_size(tf, tp.args, nargs), GFP_KERNEL);
+	if (!tf)
+		return ERR_PTR(ret);
+
+	tf->symbol = kstrdup(symbol, GFP_KERNEL);
+	if (!tf->symbol)
+		goto error;
+
+	if (is_return)
+		tf->fp.exit_handler = fexit_dispatcher;
+	else
+		tf->fp.entry_handler = fentry_dispatcher;
+
+	tf->fp.nr_maxactive = maxactive;
+
+	ret = trace_probe_init(&tf->tp, event, group, false);
+	if (ret < 0)
+		goto error;
+
+	dyn_event_init(&tf->devent, &trace_fprobe_ops);
+	return tf;
+error:
+	free_trace_fprobe(tf);
+	return ERR_PTR(ret);
+}
+
+static struct trace_fprobe *find_trace_fprobe(const char *event,
+					      const char *group)
+{
+	struct dyn_event *pos;
+	struct trace_fprobe *tf;
+
+	for_each_trace_fprobe(tf, pos)
+		if (strcmp(trace_probe_name(&tf->tp), event) == 0 &&
+		    strcmp(trace_probe_group_name(&tf->tp), group) == 0)
+			return tf;
+	return NULL;
+}
+
+static inline int __enable_trace_fprobe(struct trace_fprobe *tf)
+{
+	if (trace_fprobe_is_registered(tf))
+		enable_fprobe(&tf->fp);
+
+	return 0;
+}
+
+static void __disable_trace_fprobe(struct trace_probe *tp)
+{
+	struct trace_fprobe *tf;
+
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
+		if (!trace_fprobe_is_registered(tf))
+			continue;
+		disable_fprobe(&tf->fp);
+	}
+}
+
+/*
+ * Enable trace_probe
+ * if the file is NULL, enable "perf" handler, or enable "trace" handler.
+ */
+static int enable_trace_fprobe(struct trace_event_call *call,
+			       struct trace_event_file *file)
+{
+	struct trace_probe *tp;
+	struct trace_fprobe *tf;
+	bool enabled;
+	int ret = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+	enabled = trace_probe_is_enabled(tp);
+
+	/* This also changes "enabled" state */
+	if (file) {
+		ret = trace_probe_add_file(tp, file);
+		if (ret)
+			return ret;
+	} else
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
+
+	if (!enabled) {
+		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
+			/* TODO: check the fprobe is gone */
+			__enable_trace_fprobe(tf);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Disable trace_probe
+ * if the file is NULL, disable "perf" handler, or disable "trace" handler.
+ */
+static int disable_trace_fprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
+{
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	if (file) {
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
+			goto out;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
+	} else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+
+	if (!trace_probe_is_enabled(tp))
+		__disable_trace_fprobe(tp);
+
+ out:
+	if (file)
+		/*
+		 * Synchronization is done in below function. For perf event,
+		 * file == NULL and perf_trace_event_unreg() calls
+		 * tracepoint_synchronize_unregister() to ensure synchronize
+		 * event. We don't need to care about it.
+		 */
+		trace_probe_remove_file(tp, file);
+
+	return 0;
+}
+
+/* Event entry printers */
+static enum print_line_t
+print_fentry_event(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct fentry_trace_entry_head *field;
+	struct trace_seq *s = &iter->seq;
+	struct trace_probe *tp;
+
+	field = (struct fentry_trace_entry_head *)iter->ent;
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
+	if (WARN_ON_ONCE(!tp))
+		goto out;
+
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
+
+	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+		goto out;
+
+	trace_seq_putc(s, ')');
+
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
+
+	trace_seq_putc(s, '\n');
+ out:
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+print_fexit_event(struct trace_iterator *iter, int flags,
+		  struct trace_event *event)
+{
+	struct fexit_trace_entry_head *field;
+	struct trace_seq *s = &iter->seq;
+	struct trace_probe *tp;
+
+	field = (struct fexit_trace_entry_head *)iter->ent;
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
+	if (WARN_ON_ONCE(!tp))
+		goto out;
+
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
+
+	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER_SYM_OFFSET))
+		goto out;
+
+	trace_seq_puts(s, " <- ");
+
+	if (!seq_print_ip_sym(s, field->func, flags & ~TRACE_ITER_SYM_OFFSET))
+		goto out;
+
+	trace_seq_putc(s, ')');
+
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
+
+	trace_seq_putc(s, '\n');
+
+ out:
+	return trace_handle_return(s);
+}
+
+static int fentry_event_define_fields(struct trace_event_call *event_call)
+{
+	int ret;
+	struct fentry_trace_entry_head field;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(event_call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENOENT;
+
+	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
+
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
+}
+
+static int fexit_event_define_fields(struct trace_event_call *event_call)
+{
+	int ret;
+	struct fexit_trace_entry_head field;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(event_call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENOENT;
+
+	DEFINE_FIELD(unsigned long, func, FIELD_STRING_FUNC, 0);
+	DEFINE_FIELD(unsigned long, ret_ip, FIELD_STRING_RETIP, 0);
+
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
+}
+
+static struct trace_event_functions fentry_funcs = {
+	.trace		= print_fentry_event
+};
+
+static struct trace_event_functions fexit_funcs = {
+	.trace		= print_fexit_event
+};
+
+static struct trace_event_fields fentry_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = fentry_event_define_fields },
+	{}
+};
+
+static struct trace_event_fields fexit_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = fexit_event_define_fields },
+	{}
+};
+
+static int fprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data);
+
+static inline void init_trace_event_call(struct trace_fprobe *tf)
+{
+	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
+
+	if (trace_fprobe_is_return(tf)) {
+		call->event.funcs = &fexit_funcs;
+		call->class->fields_array = fexit_fields_array;
+	} else {
+		call->event.funcs = &fentry_funcs;
+		call->class->fields_array = fentry_fields_array;
+	}
+
+	call->flags = TRACE_EVENT_FL_FPROBE;
+	call->class->reg = fprobe_register;
+}
+
+static int register_fprobe_event(struct trace_fprobe *tf)
+{
+	init_trace_event_call(tf);
+
+	return trace_probe_register_event_call(&tf->tp);
+}
+
+static int unregister_fprobe_event(struct trace_fprobe *tf)
+{
+	return trace_probe_unregister_event_call(&tf->tp);
+}
+
+/* Internal register function - just handle fprobe and flags */
+static int __register_trace_fprobe(struct trace_fprobe *tf)
+{
+	int i, ret;
+
+	/* Should we need new LOCKDOWN flag for fprobe? */
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
+	if (trace_fprobe_is_registered(tf))
+		return -EINVAL;
+
+	for (i = 0; i < tf->tp.nr_args; i++) {
+		ret = traceprobe_update_arg(&tf->tp.args[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Set/clear disabled flag according to tp->flag */
+	if (trace_probe_is_enabled(&tf->tp))
+		tf->fp.flags &= ~FPROBE_FL_DISABLED;
+	else
+		tf->fp.flags |= FPROBE_FL_DISABLED;
+
+	/* TODO: handle filter, nofilter or symbol list */
+	return register_fprobe(&tf->fp, tf->symbol, NULL);
+}
+
+/* Internal unregister function - just handle fprobe and flags */
+static void __unregister_trace_fprobe(struct trace_fprobe *tf)
+{
+	if (trace_fprobe_is_registered(tf)) {
+		unregister_fprobe(&tf->fp);
+		memset(&tf->fp, 0, sizeof(tf->fp));
+	}
+}
+
+/* TODO: make this trace_*probe common function */
+/* Unregister a trace_probe and probe_event */
+static int unregister_trace_fprobe(struct trace_fprobe *tf)
+{
+	/* If other probes are on the event, just unregister fprobe */
+	if (trace_probe_has_sibling(&tf->tp))
+		goto unreg;
+
+	/* Enabled event can not be unregistered */
+	if (trace_probe_is_enabled(&tf->tp))
+		return -EBUSY;
+
+	/* If there's a reference to the dynamic event */
+	if (trace_event_dyn_busy(trace_probe_event_call(&tf->tp)))
+		return -EBUSY;
+
+	/* Will fail if probe is being used by ftrace or perf */
+	if (unregister_fprobe_event(tf))
+		return -EBUSY;
+
+unreg:
+	__unregister_trace_fprobe(tf);
+	dyn_event_remove(&tf->devent);
+	trace_probe_unlink(&tf->tp);
+
+	return 0;
+}
+
+static bool trace_fprobe_has_same_fprobe(struct trace_fprobe *orig,
+					 struct trace_fprobe *comp)
+{
+	struct trace_probe_event *tpe = orig->tp.event;
+	int i;
+
+	list_for_each_entry(orig, &tpe->probes, tp.list) {
+		if (strcmp(trace_fprobe_symbol(orig),
+			   trace_fprobe_symbol(comp)))
+			continue;
+
+		/*
+		 * trace_probe_compare_arg_type() ensured that nr_args and
+		 * each argument name and type are same. Let's compare comm.
+		 */
+		for (i = 0; i < orig->tp.nr_args; i++) {
+			if (strcmp(orig->tp.args[i].comm,
+				   comp->tp.args[i].comm))
+				break;
+		}
+
+		if (i == orig->tp.nr_args)
+			return true;
+	}
+
+	return false;
+}
+
+static int append_trace_fprobe(struct trace_fprobe *tf, struct trace_fprobe *to)
+{
+	int ret;
+
+	if (trace_fprobe_is_return(tf) != trace_fprobe_is_return(to)) {
+		trace_probe_log_set_index(0);
+		trace_probe_log_err(0, DIFF_PROBE_TYPE);
+		return -EEXIST;
+	}
+	ret = trace_probe_compare_arg_type(&tf->tp, &to->tp);
+	if (ret) {
+		/* Note that argument starts index = 2 */
+		trace_probe_log_set_index(ret + 1);
+		trace_probe_log_err(0, DIFF_ARG_TYPE);
+		return -EEXIST;
+	}
+	if (trace_fprobe_has_same_fprobe(to, tf)) {
+		trace_probe_log_set_index(0);
+		trace_probe_log_err(0, SAME_PROBE);
+		return -EEXIST;
+	}
+
+	/* Append to existing event */
+	ret = trace_probe_append(&tf->tp, &to->tp);
+	if (ret)
+		return ret;
+
+	ret = __register_trace_fprobe(tf);
+	if (ret)
+		trace_probe_unlink(&tf->tp);
+	else
+		dyn_event_add(&tf->devent, trace_probe_event_call(&tf->tp));
+
+	return ret;
+}
+
+/* Register a trace_probe and probe_event */
+static int register_trace_fprobe(struct trace_fprobe *tf)
+{
+	struct trace_fprobe *old_tf;
+	int ret;
+
+	mutex_lock(&event_mutex);
+
+	old_tf = find_trace_fprobe(trace_probe_name(&tf->tp),
+				   trace_probe_group_name(&tf->tp));
+	if (old_tf) {
+		ret = append_trace_fprobe(tf, old_tf);
+		goto end;
+	}
+
+	/* Register new event */
+	ret = register_fprobe_event(tf);
+	if (ret) {
+		if (ret == -EEXIST) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, EVENT_EXIST);
+		} else
+			pr_warn("Failed to register probe event(%d)\n", ret);
+		goto end;
+	}
+
+	/* Register fprobe */
+	ret = __register_trace_fprobe(tf);
+	if (ret < 0)
+		unregister_fprobe_event(tf);
+	else
+		dyn_event_add(&tf->devent, trace_probe_event_call(&tf->tp));
+
+end:
+	mutex_unlock(&event_mutex);
+	return ret;
+}
+
+static int __trace_fprobe_create(int argc, const char *argv[])
+{
+	/*
+	 * Argument syntax:
+	 *  - Add fentry probe:
+	 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
+	 *  - Add fexit probe:
+	 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
+	 *
+	 * Fetch args:
+	 *  $retval	: fetch return value
+	 *  $stack	: fetch stack address
+	 *  $stackN	: fetch Nth entry of stack (N:0-)
+	 *  $argN	: fetch Nth argument (N:1-)
+	 *  $comm       : fetch current task comm
+	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
+	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
+	 * Dereferencing memory fetch:
+	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
+	 * Alias name of args:
+	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
+	 * Type of args:
+	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
+	 */
+	struct trace_fprobe *tf = NULL;
+	int i, len, ret = 0;
+	bool is_return = false;
+	char *symbol = NULL, *tmp = NULL;
+	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
+	int maxactive = 0;
+	char buf[MAX_EVENT_NAME_LEN];
+	char gbuf[MAX_EVENT_NAME_LEN];
+	unsigned int flags = TPARG_FL_KERNEL;
+
+	if (argv[0][0] != 'f' || argc < 2)
+		return -ECANCELED;
+
+	trace_probe_log_init("trace_fprobe", argc, argv);
+
+	event = strchr(&argv[0][1], ':');
+	if (event)
+		event++;
+
+	if (isdigit(argv[0][1])) {
+		if (event)
+			len = event - &argv[0][1] - 1;
+		else
+			len = strlen(&argv[0][1]);
+		if (len > MAX_EVENT_NAME_LEN - 1) {
+			trace_probe_log_err(1, BAD_MAXACT);
+			goto parse_error;
+		}
+		memcpy(buf, &argv[0][1], len);
+		buf[len] = '\0';
+		ret = kstrtouint(buf, 0, &maxactive);
+		if (ret || !maxactive) {
+			trace_probe_log_err(1, BAD_MAXACT);
+			goto parse_error;
+		}
+		/* fprobe rethook instances are iterated over via a list. The
+		 * maximum should stay reasonable.
+		 */
+		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
+			trace_probe_log_err(1, MAXACT_TOO_BIG);
+			goto parse_error;
+		}
+	}
+
+	trace_probe_log_set_index(1);
+
+	/* a symbol specified */
+	symbol = kstrdup(argv[1], GFP_KERNEL);
+	if (!symbol)
+		return -ENOMEM;
+
+	tmp = strchr(symbol, '%');
+	if (tmp) {
+		if (!strcmp(tmp, "%return")) {
+			*tmp = '\0';
+			is_return = true;
+		} else {
+			trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
+			goto parse_error;
+		}
+	}
+	if (!is_return && maxactive) {
+		trace_probe_log_set_index(0);
+		trace_probe_log_err(1, BAD_MAXACT_TYPE);
+		goto parse_error;
+	}
+
+	flags |= TPARG_FL_FENTRY;
+	if (is_return)
+		flags |= TPARG_FL_RETURN;
+
+	trace_probe_log_set_index(0);
+	if (event) {
+		ret = traceprobe_parse_event_name(&event, &group, gbuf,
+						  event - argv[0]);
+		if (ret)
+			goto parse_error;
+	}
+
+	if (!event) {
+		/* Make a new event name */
+		snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
+			 is_return ? "exit" : "entry");
+		sanitize_event_name(buf);
+		event = buf;
+	}
+
+	/* setup a probe */
+	tf = alloc_trace_fprobe(group, event, symbol, maxactive,
+				argc - 2, is_return);
+	if (IS_ERR(tf)) {
+		ret = PTR_ERR(tf);
+		/* This must return -ENOMEM, else there is a bug */
+		WARN_ON_ONCE(ret != -ENOMEM);
+		goto out;	/* We know tf is not allocated */
+	}
+	argc -= 2; argv += 2;
+
+	/* parse arguments */
+	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+		trace_probe_log_set_index(i + 2);
+		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], flags);
+		if (ret)
+			goto error;	/* This can be -ENOMEM */
+	}
+
+	ret = traceprobe_set_print_fmt(&tf->tp,
+			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
+	if (ret < 0)
+		goto error;
+
+	ret = register_trace_fprobe(tf);
+	if (ret) {
+		trace_probe_log_set_index(1);
+		if (ret == -EILSEQ)
+			trace_probe_log_err(0, BAD_INSN_BNDRY);
+		else if (ret == -ENOENT)
+			trace_probe_log_err(0, BAD_PROBE_ADDR);
+		else if (ret != -ENOMEM && ret != -EEXIST)
+			trace_probe_log_err(0, FAIL_REG_PROBE);
+		goto error;
+	}
+
+out:
+	trace_probe_log_clear();
+	kfree(symbol);
+	return ret;
+
+parse_error:
+	ret = -EINVAL;
+error:
+	free_trace_fprobe(tf);
+	goto out;
+}
+
+static int trace_fprobe_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_fprobe_create);
+}
+
+static int trace_fprobe_release(struct dyn_event *ev)
+{
+	struct trace_fprobe *tf = to_trace_fprobe(ev);
+	int ret = unregister_trace_fprobe(tf);
+
+	if (!ret)
+		free_trace_fprobe(tf);
+	return ret;
+}
+
+static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct trace_fprobe *tf = to_trace_fprobe(ev);
+	int i;
+
+	seq_putc(m, 'f');
+	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
+		seq_printf(m, "%d", tf->fp.nr_maxactive);
+	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
+				trace_probe_name(&tf->tp));
+
+	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
+			       trace_fprobe_is_return(tf) ? "%return" : "");
+
+	for (i = 0; i < tf->tp.nr_args; i++)
+		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+/*
+ * called by perf_trace_init() or __ftrace_set_clr_event() under event_mutex.
+ */
+static int fprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return enable_trace_fprobe(event, file);
+	case TRACE_REG_UNREGISTER:
+		return disable_trace_fprobe(event, file);
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return enable_trace_fprobe(event, NULL);
+	case TRACE_REG_PERF_UNREGISTER:
+		return disable_trace_fprobe(event, NULL);
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+/*
+ * Register dynevent at core_initcall. This allows kernel to setup fprobe
+ * events in postcore_initcall without tracefs.
+ */
+static __init int init_fprobe_trace_early(void)
+{
+	int ret;
+
+	ret = dyn_event_register(&trace_fprobe_ops);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+core_initcall(init_fprobe_trace_early);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..38e34ed89d55 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -764,7 +764,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 
 	if (isdigit(argv[0][1])) {
 		if (!is_return) {
-			trace_probe_log_err(1, MAXACT_NO_KPROBE);
+			trace_probe_log_err(1, BAD_MAXACT_TYPE);
 			goto parse_error;
 		}
 		if (event)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 20d0c4a97633..8646b097d56c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -393,8 +393,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 
 	case '%':	/* named register */
-		if (flags & TPARG_FL_TPOINT) {
-			/* eprobes do not handle registers */
+		if (flags & (TPARG_FL_TPOINT | TPARG_FL_FPROBE)) {
+			/* eprobe and fprobe do not handle registers */
 			trace_probe_log_err(offs, BAD_VAR);
 			break;
 		}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ef8ed3b65d05..a2ee6d336bd8 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -362,7 +362,8 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 #define TPARG_FL_FENTRY BIT(2)
 #define TPARG_FL_TPOINT BIT(3)
 #define TPARG_FL_USER   BIT(4)
-#define TPARG_FL_MASK	GENMASK(4, 0)
+#define TPARG_FL_FPROBE BIT(5)
+#define TPARG_FL_MASK	GENMASK(5, 0)
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
@@ -404,7 +405,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(REFCNT_OPEN_BRACE,	"Reference counter brace is not closed"), \
 	C(BAD_REFCNT_SUFFIX,	"Reference counter has wrong suffix"),	\
 	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
-	C(MAXACT_NO_KPROBE,	"Maxactive is not for kprobe"),		\
+	C(BAD_MAXACT_TYPE,	"Maxactive is only for function exit"),	\
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 9e85d3019ff0..97c08867490a 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -8,7 +8,7 @@ check_error() { # command-with-error-pos-by-^
 }
 
 if grep -q 'r\[maxactive\]' README; then
-check_error 'p^100 vfs_read'		# MAXACT_NO_KPROBE
+check_error 'p^100 vfs_read'		# BAD_MAXACT_TYPE
 check_error 'r^1a111 vfs_read'		# BAD_MAXACT
 check_error 'r^100000 vfs_read'		# MAXACT_TOO_BIG
 fi

