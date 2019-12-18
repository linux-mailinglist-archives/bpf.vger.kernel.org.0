Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC3124CE8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLRQOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 11:14:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727124AbfLRQOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 11:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576685659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zfbcmFuSpfWV7fg9x3i6ReTKe4sbKiVNU9CGkAo4OE=;
        b=URxXMb1ze2mdX0K7C23ZEOBetCp35neI7xo33ZI4un/oMgAgCtyO35rjyfF99qDIAqt4hY
        JCJPQ4X2DsO/uDD+qnJNbniWELiRZNkH+R8Fx4v4xRyog0Iqn4FnVfpu9cBI6KTu1kX5BS
        aJXC6veLPb7A/J1lYVXUGI72zPCoVd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-0qB5ntsMNnytWYoOKngWqQ-1; Wed, 18 Dec 2019 11:14:15 -0500
X-MC-Unique: 0qB5ntsMNnytWYoOKngWqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D933A184BECD;
        Wed, 18 Dec 2019 16:14:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D60E60C18;
        Wed, 18 Dec 2019 16:14:04 +0000 (UTC)
Date:   Wed, 18 Dec 2019 17:14:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [RFC] btf: Some structs are doubled because of struct ring_buffer
Message-ID: <20191218161401.GC15571@krava>
References: <20191213153553.GE20583@krava>
 <20191213112438.773dff35@gandalf.local.home>
 <20191213165155.vimm27wo7brkh3yu@ast-mbp.dhcp.thefacebook.com>
 <20191213121118.236f55b8@gandalf.local.home>
 <20191213180223.GE2844@hirez.programming.kicks-ass.net>
 <20191213132941.6fa2d1bd@gandalf.local.home>
 <20191213184621.GG2844@hirez.programming.kicks-ass.net>
 <20191213140349.5a42a8af@gandalf.local.home>
 <20191213140531.116b3200@gandalf.local.home>
 <20191214113510.GB12440@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214113510.GB12440@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 14, 2019 at 12:35:10PM +0100, Jiri Olsa wrote:
> On Fri, Dec 13, 2019 at 02:05:31PM -0500, Steven Rostedt wrote:
> 
> SNIP
> 
> >  	struct trace_array *tr = filp->private_data;
> > -	struct ring_buffer *buffer = tr->trace_buffer.buffer;
> > +	struct trace_buffer *buffer = tr->trace_buffer.buffer;
> >  	unsigned long val;
> >  	int ret;
> >  
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 63bf60f79398..308fcd673102 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -178,7 +178,7 @@ struct trace_option_dentry;
> >  
> >  struct trace_buffer {
> >  	struct trace_array		*tr;
> > -	struct ring_buffer		*buffer;
> > +	struct trace_buffer		*buffer;
> 
> perf change is fine, but 'trace_buffer' won't work because
> we already have 'struct trace_buffer' defined in here
> 
> maybe we could change this name to trace_buffer_array?

..like in patch below? it's independent of your previous changes

jirka


---
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4c6e15605766..05588dafd3dc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -79,7 +79,7 @@ struct trace_entry {
 struct trace_iterator {
 	struct trace_array	*tr;
 	struct tracer		*trace;
-	struct trace_buffer	*trace_buffer;
+	struct trace_buffer_array *trace_buffer;
 	void			*private;
 	int			cpu_file;
 	struct mutex		mutex;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23459d53d576..9abee8bf831c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -603,7 +603,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 	return read;
 }
 
-static u64 buffer_ftrace_now(struct trace_buffer *buf, int cpu)
+static u64 buffer_ftrace_now(struct trace_buffer_array *buf, int cpu)
 {
 	u64 ts;
 
@@ -1036,9 +1036,9 @@ void *tracing_cond_snapshot_data(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
 
-static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
-					struct trace_buffer *size_buf, int cpu_id);
-static void set_buffer_entries(struct trace_buffer *buf, unsigned long val);
+static int resize_buffer_duplicate_size(struct trace_buffer_array *trace_buf,
+					struct trace_buffer_array *size_buf, int cpu_id);
+static void set_buffer_entries(struct trace_buffer_array *buf, unsigned long val);
 
 int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
@@ -1590,8 +1590,8 @@ void latency_fsnotify(struct trace_array *tr)
 static void
 __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 {
-	struct trace_buffer *trace_buf = &tr->trace_buffer;
-	struct trace_buffer *max_buf = &tr->max_buffer;
+	struct trace_buffer_array *trace_buf = &tr->trace_buffer;
+	struct trace_buffer_array *max_buf = &tr->max_buffer;
 	struct trace_array_cpu *data = per_cpu_ptr(trace_buf->data, cpu);
 	struct trace_array_cpu *max_data = per_cpu_ptr(max_buf->data, cpu);
 
@@ -1962,7 +1962,7 @@ int __init register_tracer(struct tracer *type)
 	return ret;
 }
 
-static void tracing_reset_cpu(struct trace_buffer *buf, int cpu)
+static void tracing_reset_cpu(struct trace_buffer_array *buf, int cpu)
 {
 	struct ring_buffer *buffer = buf->buffer;
 
@@ -1978,7 +1978,7 @@ static void tracing_reset_cpu(struct trace_buffer *buf, int cpu)
 	ring_buffer_record_enable(buffer);
 }
 
-void tracing_reset_online_cpus(struct trace_buffer *buf)
+void tracing_reset_online_cpus(struct trace_buffer_array *buf)
 {
 	struct ring_buffer *buffer = buf->buffer;
 	int cpu;
@@ -3602,7 +3602,7 @@ static void s_stop(struct seq_file *m, void *p)
 }
 
 static void
-get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
+get_total_entries_cpu(struct trace_buffer_array *buf, unsigned long *total,
 		      unsigned long *entries, int cpu)
 {
 	unsigned long count;
@@ -3624,7 +3624,7 @@ get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
 }
 
 static void
-get_total_entries(struct trace_buffer *buf,
+get_total_entries(struct trace_buffer_array *buf,
 		  unsigned long *total, unsigned long *entries)
 {
 	unsigned long t, e;
@@ -3676,7 +3676,7 @@ static void print_lat_help_header(struct seq_file *m)
 		    "#     \\   /      |||||  \\    |   /         \n");
 }
 
-static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
+static void print_event_info(struct trace_buffer_array *buf, struct seq_file *m)
 {
 	unsigned long total;
 	unsigned long entries;
@@ -3687,7 +3687,7 @@ static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
 	seq_puts(m, "#\n");
 }
 
-static void print_func_help_header(struct trace_buffer *buf, struct seq_file *m,
+static void print_func_help_header(struct trace_buffer_array *buf, struct seq_file *m,
 				   unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
@@ -3698,7 +3698,7 @@ static void print_func_help_header(struct trace_buffer *buf, struct seq_file *m,
 	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
 }
 
-static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file *m,
+static void print_func_help_header_irq(struct trace_buffer_array *buf, struct seq_file *m,
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
@@ -3720,7 +3720,7 @@ void
 print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 {
 	unsigned long sym_flags = (global_trace.trace_flags & TRACE_ITER_SYM_MASK);
-	struct trace_buffer *buf = iter->trace_buffer;
+	struct trace_buffer_array *buf = iter->trace_buffer;
 	struct trace_array_cpu *data = per_cpu_ptr(buf->data, buf->cpu);
 	struct tracer *type = iter->trace;
 	unsigned long entries;
@@ -4357,7 +4357,7 @@ static int tracing_open(struct inode *inode, struct file *file)
 	/* If this file was open for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		int cpu = tracing_get_cpu(inode);
-		struct trace_buffer *trace_buf = &tr->trace_buffer;
+		struct trace_buffer_array *trace_buf = &tr->trace_buffer;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 		if (tr->current_trace->print_max)
@@ -5532,7 +5532,7 @@ int tracer_init(struct tracer *t, struct trace_array *tr)
 	return t->init(tr);
 }
 
-static void set_buffer_entries(struct trace_buffer *buf, unsigned long val)
+static void set_buffer_entries(struct trace_buffer_array *buf, unsigned long val)
 {
 	int cpu;
 
@@ -5542,8 +5542,8 @@ static void set_buffer_entries(struct trace_buffer *buf, unsigned long val)
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 /* resize @tr's buffer to the size of @size_tr's entries */
-static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
-					struct trace_buffer *size_buf, int cpu_id)
+static int resize_buffer_duplicate_size(struct trace_buffer_array *trace_buf,
+					struct trace_buffer_array *size_buf, int cpu_id)
 {
 	int cpu, ret = 0;
 
@@ -7607,7 +7607,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 {
 	struct inode *inode = file_inode(filp);
 	struct trace_array *tr = inode->i_private;
-	struct trace_buffer *trace_buf = &tr->trace_buffer;
+	struct trace_buffer_array *trace_buf = &tr->trace_buffer;
 	int cpu = tracing_get_cpu(inode);
 	struct trace_seq *s;
 	unsigned long cnt;
@@ -8354,7 +8354,7 @@ static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
 static int
-allocate_trace_buffer(struct trace_array *tr, struct trace_buffer *buf, int size)
+allocate_trace_buffer(struct trace_array *tr, struct trace_buffer_array *buf, int size)
 {
 	enum ring_buffer_flags rb_flags;
 
@@ -8409,7 +8409,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	return 0;
 }
 
-static void free_trace_buffer(struct trace_buffer *buf)
+static void free_trace_buffer(struct trace_buffer_array *buf)
 {
 	if (buf->buffer) {
 		ring_buffer_free(buf->buffer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63bf60f79398..01d0ab7de131 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -176,7 +176,7 @@ struct trace_array_cpu {
 struct tracer;
 struct trace_option_dentry;
 
-struct trace_buffer {
+struct trace_buffer_array {
 	struct trace_array		*tr;
 	struct ring_buffer		*buffer;
 	struct trace_array_cpu __percpu	*data;
@@ -247,9 +247,9 @@ struct cond_snapshot {
  * They have on/off state as well:
  */
 struct trace_array {
-	struct list_head	list;
-	char			*name;
-	struct trace_buffer	trace_buffer;
+	struct list_head		list;
+	char				*name;
+	struct trace_buffer_array	trace_buffer;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	/*
 	 * The max_buffer is used to snapshot the trace when a maximum
@@ -262,8 +262,8 @@ struct trace_array {
 	 * with the buffer of the trace_buffer and the buffers are reset for
 	 * the trace_buffer so the tracing can continue.
 	 */
-	struct trace_buffer	max_buffer;
-	bool			allocated_snapshot;
+	struct trace_buffer_array	max_buffer;
+	bool				allocated_snapshot;
 #endif
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
 	unsigned long		max_latency;
@@ -685,7 +685,7 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
-void tracing_reset_online_cpus(struct trace_buffer *buf);
+void tracing_reset_online_cpus(struct trace_buffer_array *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 69ee8ef12cee..d9fc1e0cd8d1 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -23,7 +23,7 @@ static inline int trace_valid_entry(struct trace_entry *entry)
 	return 0;
 }
 
-static int trace_test_buffer_cpu(struct trace_buffer *buf, int cpu)
+static int trace_test_buffer_cpu(struct trace_buffer_array *buf, int cpu)
 {
 	struct ring_buffer_event *event;
 	struct trace_entry *entry;
@@ -60,7 +60,7 @@ static int trace_test_buffer_cpu(struct trace_buffer *buf, int cpu)
  * Test the trace buffer to see if all the elements
  * are still sane.
  */
-static int __maybe_unused trace_test_buffer(struct trace_buffer *buf, unsigned long *count)
+static int __maybe_unused trace_test_buffer(struct trace_buffer_array *buf, unsigned long *count)
 {
 	unsigned long flags, cnt = 0;
 	int cpu, ret = 0;

