Return-Path: <bpf+bounces-66874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B819DB3A97B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D55BA03B9D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FDE270EBC;
	Thu, 28 Aug 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpaTHhyO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AF26E143;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404217; cv=none; b=TkOJPQiIAb11m18h3Itg4V96rUlM1NHZVe9MKgGdoQnCp/8mwutm4tDQMGO2uJLO6HJjQ9/2uKyokKlbQGXMWnvIxZ13ig0PmYOqsuZ8YBlNCtgRDWc0d+Y9DZmWtGjcqLbQaDFNYLOZk47/L8+v0UzMm2DBRcVFAYsT5asVBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404217; c=relaxed/simple;
	bh=TcYMw4TZuj8n6gPvf25Za15ZY5i9wM2Tt/cm2PhH12g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SztjPftQM5Q8wd1/zx9VcXTer4PeQTdHQknPx0kGPFlIoLf7Jpov9V/QiLeK3x5Ndk60rfArRuswuONO2ov8NOBOw2khc2J4YMsIG/II654Gux0oAxT7/vE0FIrNCTspIwbZnybCHOif6brcZP2+n/5tnp5/njTJ+t7ZrYlKmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpaTHhyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445DC4CEF4;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404216;
	bh=TcYMw4TZuj8n6gPvf25Za15ZY5i9wM2Tt/cm2PhH12g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=YpaTHhyOZ1cenbrU2SF3pXIr3ko+8DibORAn8ukh8yG0ybAFyXbhdA/t4ZZ8I2gRo
	 9O2BGtIepXroU2uBR7VsCFjN3PJNYCCUH9WSqfGe4Z/ElYkYEZE7WeM5t9dr0HJSs6
	 +EQkaSefl9BXX0ghuhth7Bh9CFiHVpcKpObv9HlDbGn7sIe2ll4uFUOTu/vMKHaDO2
	 +mLJsouGjqQZjvtEAjWpiwdxc8Fzmb3wHy6uWC3Ovw4aQcGNp5meuyqDn/tmt08wTy
	 HwXqsT3mhYSM2o9E55QHqpKJNMhMM95ILbqu6ZtEzxd0YYNPkt4jIACZrMW98YIK2z
	 tWlilMQs/XAjQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgyb-00000004GDk-2Hxh;
	Thu, 28 Aug 2025 14:03:57 -0400
Message-ID: <20250828180357.394699143@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v6 6/6] tracing: Add an event to map the inodes to their file names
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The userstacktrace_delay stack trace shows for each frame of the listed
stack, the address in the file of the code, the inode number of the file,
and the device number of the file. This can be used by a user space tool
to find exactly where the stack walk is in the source code. But the issue
with this is that it also requires the tool to find the application on
disk from its device number and inode. This can take a bit of time.

The output of the usestacktrace_delay looks like this:

       trace-cmd-1053    [007] .....  1290.400226: <user stack unwind>
cookie=300000008
 =>  <000000000008f687> : 1340007 : 254:3
 =>  <0000000000014560> : 1488818 : 254:3
 =>  <000000000001f94a> : 1488818 : 254:3
 =>  <000000000001fc9e> : 1488818 : 254:3
 =>  <000000000001fcfa> : 1488818 : 254:3
 =>  <000000000000ebae> : 1488818 : 254:3
 =>  <0000000000029ca8> : 1340007 : 254:3

To help out, create a "inode_cache" that maps the device/inode to the path
of the file. Use a rhashtable to store the device/inode as a key, and
every time a new inode is added, it triggers a trace event that prints the
device, inode and the path. A tool can use this trace event to find the
paths without having to look for them on the device:

 trace-cmd start -B map -e inode_cache
[..]
 trace-cmd show -B map
[..]
       trace-cmd-1053    [007] ...1.  1290.400956: inode_cache: inode=1340007 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libc.so.6
       trace-cmd-1053    [007] ...1.  1290.401175: inode_cache: inode=1488818 dev=[254:3] path=/usr/local/bin/trace-cmd
       trace-cmd-1053    [007] ...1.  1290.401249: inode_cache: inode=1308544 dev=[254:3] path=/usr/local/lib64/libtracefs.so.1.8.2
       trace-cmd-1053    [007] ...1.  1290.401288: inode_cache: inode=1319848 dev=[254:3] path=/usr/local/lib64/libtraceevent.so.1.8.4
       trace-cmd-1053    [007] ...1.  1290.401338: inode_cache: inode=1311769 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7
            bash-1044    [006] ...1.  1290.402620: inode_cache: inode=1308405 dev=[254:3] path=/usr/bin/bash
            bash-1044    [006] ...1.  1293.945511: inode_cache: inode=1309170 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libtinfo.so.6.5
       trace-cmd-1054    [001] ...1.  1293.956178: inode_cache: inode=1339989 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
            less-1055    [000] ...1.  1293.962161: inode_cache: inode=1309556 dev=[254:3] path=/usr/bin/less
       trace-cmd-1054    [001] ...1.  1293.963118: inode_cache: inode=1309303 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/libz.so.1.3.1
  NetworkManager-592     [000] ...1.  1296.802760: inode_cache: inode=1310774 dev=[254:3] path=/usr/sbin/NetworkManager
   systemd-udevd-323     [002] ...1.  1327.342209: inode_cache: inode=1308579 dev=[254:3] path=/usr/lib/x86_64-linux-gnu/systemd/libsystemd-shared-257.so
    sshd-session-1041    [001] ...1.  1352.996159: inode_cache: inode=1570224 dev=[254:3] path=/usr/lib/openssh/sshd-session

The event is only triggered when a new inode device combo is added to the
rhashtable. To help make sure new tracing can read this event, every time
the trace starts and stops and some other changes to the tracing system
occur, the cache is cleared so that it will show the paths again.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Makefile            |   3 +
 kernel/trace/inode_cache.c       | 144 +++++++++++++++++++++++++++++++
 kernel/trace/trace.c             |  15 +++-
 kernel/trace/trace.h             |  10 +++
 kernel/trace/trace_inode_cache.h |  42 +++++++++
 5 files changed, 212 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/inode_cache.c
 create mode 100644 kernel/trace/trace_inode_cache.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index dcb4e02afc5f..c13f8ec48dc2 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
+obj-$(CONFIG_UNWIND_USER) += inode_cache.o
 ifeq ($(CONFIG_BLOCK),y)
 obj-$(CONFIG_EVENT_TRACING) += blktrace.o
 endif
@@ -110,4 +111,6 @@ obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
 
+CFLAGS_inode_cache.o := -I$(src)
+
 libftrace-y := ftrace.o
diff --git a/kernel/trace/inode_cache.c b/kernel/trace/inode_cache.c
new file mode 100644
index 000000000000..bf177f7a5dad
--- /dev/null
+++ b/kernel/trace/inode_cache.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Google, author: Steven Rostedt <rostedt@goodmis.org>
+ */
+#include <linux/rhashtable.h>
+#include "trace.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace_inode_cache.h"
+
+struct inode_cache_key {
+	unsigned long		inode_nr;
+	unsigned long		dev_nr;
+};
+
+struct inode_cache {
+	struct rhash_head	rh;
+	struct inode_cache_key	key;
+};
+
+struct inode_cache_hash {
+	struct rhashtable	rhash;
+	struct rcu_head		rcu;
+};
+
+static const struct rhashtable_params inode_cache_params = {
+	.nelem_hint		= 32,
+	.key_len		= sizeof(struct inode_cache_key),
+	.key_offset		= offsetof(struct inode_cache, key),
+	.head_offset		= offsetof(struct inode_cache, rh),
+};
+
+static DEFINE_MUTEX(inode_cache_mutex);
+static struct inode_cache_hash	*imhash;
+
+static void free_inode_cache(void *ptr, void *arg)
+{
+	kfree(ptr);
+}
+
+static const char *get_vma_name(struct vm_area_struct *vma, char *buf, int size)
+{
+	struct anon_vma_name *anon_name = anon_vma_name(vma);
+	const struct path *path;
+
+	if (anon_name)
+		return anon_name->name;
+
+	path = file_user_path(vma->vm_file);
+
+	return d_path(path, buf, size);
+}
+
+#define PATH_BUF_SZ 128
+
+static void print_inode_vma(struct vm_area_struct *vma,
+			 unsigned long inode, unsigned int dev)
+{
+	static char buf[PATH_BUF_SZ];
+	const char *name;
+
+	lockdep_assert_held(&inode_cache_mutex);
+
+	name = get_vma_name(vma, buf, PATH_BUF_SZ);
+
+	trace_inode_cache(inode, dev, name);
+}
+
+/**
+ * trace_inode_cache_add - Add a inode/dev to the cache and trigger path trace
+ * @vma: The vma that maps to the inode/dev
+ * @inode: The inode number of the vma->vm_file
+ * @dev: The device number of the vma->vm_file
+ *
+ * This is used to trigger the inode_cache trace event when a new inode/dev
+ * is added. This only gets called when that trace event is active.
+ * Whenever a inode/dev is added to the userstacktrace, this function
+ * gets called with the associated @vma and if it wasn't added before, it
+ * triggers the trace event that will write the @inode, @dev and lookup
+ * the file it is associated with. This can be used by user space tools to
+ * map the inode/dev in the userspace stack traces to their corresponding
+ * files.
+ *
+ * This gets reset when certain events happen in the tracefs system, such as,
+ * enabling or disabling tracing, or enabling or disabling the deferred user
+ * space stack tracing. This is done to not miss events.
+ */
+void trace_inode_cache_add(struct vm_area_struct *vma,
+			 unsigned long inode, unsigned int dev)
+{
+	struct inode_cache_hash *rht = READ_ONCE(imhash);
+	struct inode_cache_key key;
+	struct inode_cache *item;
+
+	if (!vma->vm_file)
+		return;
+
+	key.inode_nr = inode;
+	key.dev_nr = dev;
+
+	/* First check if the inode, dev exist already */
+	if (rht && rhashtable_lookup_fast(&rht->rhash, &key, inode_cache_params) != NULL)
+		return;
+
+	guard(mutex)(&inode_cache_mutex);
+
+	rht = imhash;
+
+	/* Make sure it wasn't added between the lookup and taking the lock */
+	if (rht && rhashtable_lookup_fast(&rht->rhash, &key, inode_cache_params) != NULL)
+		return;
+
+	if (!rht) {
+		rht = kmalloc(sizeof(*rht), GFP_KERNEL);
+		if (!rht)
+			goto print;
+		if (rhashtable_init(&rht->rhash, &inode_cache_params) < 0) {
+			kfree(rht);
+			goto print;
+		}
+		imhash = rht;
+	}
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		goto print;
+
+	item->key = key;
+
+	rhashtable_insert_fast(&rht->rhash, &item->rh, inode_cache_params);
+
+ print:
+	print_inode_vma(vma, inode, dev);
+}
+
+void trace_inode_cache_reset(void)
+{
+	guard(mutex)(&inode_cache_mutex);
+	if (!imhash)
+		return;
+	rhashtable_free_and_destroy(&imhash->rhash, free_inode_cache, NULL);
+	kfree_rcu(imhash, rcu);
+	imhash = NULL;
+}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c6e1471e4615..983b885fee88 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -57,6 +57,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_inode_cache.h"
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
@@ -3203,6 +3204,9 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 		if (vma->vm_file && vma->vm_file->f_inode) {
 			inodes[i] = vma->vm_file->f_inode->i_ino;
 			devs[i] = vma->vm_file->f_inode->i_sb->s_dev;
+
+			if (trace_inode_cache_enabled())
+				trace_inode_cache_add(vma, inodes[i], devs[i]);
 		} else {
 			inodes[i] = 0;
 			devs[i] = 0;
@@ -4979,9 +4983,10 @@ static int tracing_open(struct inode *inode, struct file *file)
 			trace_buf = &tr->max_buffer;
 #endif
 
-		if (cpu == RING_BUFFER_ALL_CPUS)
+		if (cpu == RING_BUFFER_ALL_CPUS) {
 			tracing_reset_online_cpus(trace_buf);
-		else
+			trace_inode_cache_reset();
+		} else
 			tracing_reset_cpu(trace_buf, cpu);
 	}
 
@@ -5324,6 +5329,7 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 
 static int update_unwind_deferred(struct trace_array *tr, int enabled)
 {
+	trace_inode_cache_reset();
 	if (enabled) {
 		return unwind_deferred_init(&tr->unwinder,
 					    trace_user_unwind_callback);
@@ -6041,6 +6047,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	trace_inode_cache_reset();
 	return t->init(tr);
 }
 
@@ -7518,6 +7525,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	 * Reset the buffer so that it doesn't have incomparable timestamps.
 	 */
 	tracing_reset_online_cpus(&tr->array_buffer);
+	trace_inode_cache_reset();
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (tr->max_buffer.buffer)
@@ -9478,6 +9486,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		return ret;
 
+	/* Cleare the inode cache whenever tracing starts or stops */
+	trace_inode_cache_reset();
+
 	if (buffer) {
 		guard(mutex)(&trace_types_lock);
 		if (!!val == tracer_tracing_is_on(tr)) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 940107ba618a..d04563f088bf 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -450,6 +450,16 @@ struct trace_array {
 	bool ring_buffer_expanded;
 };
 
+#ifdef CONFIG_UNWIND_USER
+void trace_inode_cache_add(struct vm_area_struct *vma,
+			 unsigned long inode, unsigned int dev);
+void trace_inode_cache_reset(void);
+#else
+static inline void trace_inode_cache_add(struct vm_area_struct *vma,
+				       unsigned long inode, unsigned int dev) {}
+static inline void trace_inode_cache_reset(void) {}
+#endif
+
 enum {
 	TRACE_ARRAY_FL_GLOBAL		= BIT(0),
 	TRACE_ARRAY_FL_BOOT		= BIT(1),
diff --git a/kernel/trace/trace_inode_cache.h b/kernel/trace/trace_inode_cache.h
new file mode 100644
index 000000000000..3a71d0104fbb
--- /dev/null
+++ b/kernel/trace/trace_inode_cache.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef CONFIG_UNWIND_USER
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM inode_cache
+
+#if !defined(_TRACE_inode_cache_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_inode_cache_H
+
+TRACE_EVENT(inode_cache,
+
+	TP_PROTO(unsigned long inode, unsigned int dev, const char *path),
+
+	TP_ARGS(inode, dev, path),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	inode		)
+		__field(	unsigned int,	dev		)
+		__string(	path,		path		)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+		__entry->dev = dev;
+		__assign_str(path);
+	),
+	TP_printk("inode=%lu dev=[%u:%u] path=%s",
+		  __entry->inode, MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __get_str(path))
+);
+
+
+#endif /* if !defined(_TRACE_inode_cache_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_inode_cache
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
+#else /* CONFIG_UNWIND_USER */
+static inline bool trace_inode_cache_enabled(void) { return false; }
+#endif /* !CONFIG_UNWIND_USER */
-- 
2.50.1



