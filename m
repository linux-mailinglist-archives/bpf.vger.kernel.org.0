Return-Path: <bpf+bounces-31319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE398FB5DE
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CA528309D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07CF1494BB;
	Tue,  4 Jun 2024 14:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD09149001;
	Tue,  4 Jun 2024 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512136; cv=none; b=U/kC7pNn6WSQnO5cyDJ7kap3y58Ehyfiqajfu2gFF0onUtUD09/uhPlgalwFD44HSlxNreJ89Wu87N/1lD2x2Uh/1pN3geeCg44yimTCZGzC8oEBe2hv7vSTVftdsddqx1x8/1Ao2DZ829e1a3YXQKceNiIUDPkUb906N6Jdgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512136; c=relaxed/simple;
	bh=CM1DT/bEys/OkYDAVIqBWYLjcFkpkJmrI4R5bPgXFgk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mkEJHE5tqQPk/v204tDe+FcNEnzk+Ej5UfbCRaGT90khOx1lRsgEjtmcCCf+Sq2Sxr4E8k89zoiT0VuPSzWHcK/VB0OS9j6L7Qe2Alf7eONJAqJjjJ3VO6kug65Ivyx+bIY9xUzbLYdspfHBjEybc7VsSMHL/6gMGrjD+b/s/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16ADC4AF1B;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMd-00000000Yy1-30Wu;
	Tue, 04 Jun 2024 10:42:15 -0400
Message-ID: <20240604144215.576895926@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [for-next][PATCH 10/27] ftrace: Add subops logic to allow one ops to manage many
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There are cases where a single system will use a single function callback
to handle multiple users. For example, to allow function_graph tracer to
have multiple users where each can trace their own set of functions, it is
useful to only have one ftrace_ops registered to ftrace that will call a
function by the function_graph tracer to handle the multiplexing with the
different registered  function_graph tracers.

Add a "subop_list" to the ftrace_ops that will hold a list of other
ftrace_ops that the top ftrace_ops will manage.

The function ftrace_startup_subops() that takes the manager ftrace_ops and
a subop ftrace_ops it will manage. If there are no subops with the
ftrace_ops yet, it will copy the ftrace_ops subop filters to the manager
ftrace_ops and register that with ftrace_startup(), and adds the subop to
its subop_list. If the manager ops already has something registered, it
will then merge the new subop filters with what it has and enable the new
functions that covers all the subops it has.

To remove a subop, ftrace_shutdown_subops() is called which will use the
subop_list of the manager ops to rebuild all the functions it needs to
trace, and update the ftrace records to only call the functions it now has
registered. If there are no more functions registered, it will then call
ftrace_shutdown() to disable itself completely.

Note, it is up to the manager ops callback to always make sure that the
subops callbacks are called if its filter matches, as there are times in
the update where the callback could be calling more functions than those
that are currently registered.

This could be updated to handle other systems other than function_graph,
for example, fprobes could use this (but will need an interface to call
ftrace_startup_subops()).

Link: https://lore.kernel.org/linux-trace-kernel/20240603190822.508431129@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h         |   1 +
 kernel/trace/fgraph.c          |   3 +-
 kernel/trace/ftrace.c          | 401 ++++++++++++++++++++++++++++++++-
 kernel/trace/ftrace_internal.h |   1 +
 kernel/trace/trace.h           |   1 +
 5 files changed, 405 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 586018744785..978a1d3b270a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -334,6 +334,7 @@ struct ftrace_ops {
 	unsigned long			trampoline;
 	unsigned long			trampoline_size;
 	struct list_head		list;
+	struct list_head		subop_list;
 	ftrace_ops_func_t		ops_func;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	unsigned long			direct_call;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 54ed2ed2036b..e39042c40937 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -21,7 +21,8 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ASSIGN_OPS_HASH(opsname, val) \
 	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
+	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
 #else
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b85f00b0ffe7..63b8d1fe1dd8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -74,7 +74,8 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
+	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -161,6 +162,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
 		mutex_init(&ops->local_hash.regex_lock);
+		INIT_LIST_HEAD(&ops->subop_list);
 		ops->func_hash = &ops->local_hash;
 		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
 	}
@@ -3164,6 +3166,403 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	return 0;
 }
 
+/* Simply make a copy of @src and return it */
+static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
+{
+	if (ftrace_hash_empty(src))
+		return EMPTY_HASH;
+
+	return alloc_and_copy_ftrace_hash(src->size_bits, src);
+}
+
+/*
+ * Append @new_hash entries to @hash:
+ *
+ *  If @hash is the EMPTY_HASH then it traces all functions and nothing
+ *  needs to be done.
+ *
+ *  If @new_hash is the EMPTY_HASH, then make *hash the EMPTY_HASH so
+ *  that it traces everything.
+ *
+ *  Otherwise, go through all of @new_hash and add anything that @hash
+ *  doesn't already have, to @hash.
+ *
+ *  The filter_hash updates uses just the append_hash() function
+ *  and the notrace_hash does not.
+ */
+static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
+{
+	struct ftrace_func_entry *entry;
+	int size;
+	int i;
+
+	/* An empty hash does everything */
+	if (ftrace_hash_empty(*hash))
+		return 0;
+
+	/* If new_hash has everything make hash have everything */
+	if (ftrace_hash_empty(new_hash)) {
+		free_ftrace_hash(*hash);
+		*hash = EMPTY_HASH;
+		return 0;
+	}
+
+	size = 1 << new_hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &new_hash->buckets[i], hlist) {
+			/* Only add if not already in hash */
+			if (!__ftrace_lookup_ip(*hash, entry->ip) &&
+			    add_hash_entry(*hash, entry->ip) == NULL)
+				return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Add to @hash only those that are in both @new_hash1 and @new_hash2
+ *
+ * The notrace_hash updates uses just the intersect_hash() function
+ * and the filter_hash does not.
+ */
+static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash1,
+			  struct ftrace_hash *new_hash2)
+{
+	struct ftrace_func_entry *entry;
+	int size;
+	int i;
+
+	/*
+	 * If new_hash1 or new_hash2 is the EMPTY_HASH then make the hash
+	 * empty as well as empty for notrace means none are notraced.
+	 */
+	if (ftrace_hash_empty(new_hash1) || ftrace_hash_empty(new_hash2)) {
+		free_ftrace_hash(*hash);
+		*hash = EMPTY_HASH;
+		return 0;
+	}
+
+	size = 1 << new_hash1->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &new_hash1->buckets[i], hlist) {
+			/* Only add if in both @new_hash1 and @new_hash2 */
+			if (__ftrace_lookup_ip(new_hash2, entry->ip) &&
+			    add_hash_entry(*hash, entry->ip) == NULL)
+				return -ENOMEM;
+		}
+	}
+	/* If nothing intersects, make it the empty set */
+	if (ftrace_hash_empty(*hash)) {
+		free_ftrace_hash(*hash);
+		*hash = EMPTY_HASH;
+	}
+	return 0;
+}
+
+/* Return a new hash that has a union of all @ops->filter_hash entries */
+static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
+{
+	struct ftrace_hash *new_hash;
+	struct ftrace_ops *subops;
+	int ret;
+
+	new_hash = alloc_ftrace_hash(ops->func_hash->filter_hash->size_bits);
+	if (!new_hash)
+		return NULL;
+
+	list_for_each_entry(subops, &ops->subop_list, list) {
+		ret = append_hash(&new_hash, subops->func_hash->filter_hash);
+		if (ret < 0) {
+			free_ftrace_hash(new_hash);
+			return NULL;
+		}
+		/* Nothing more to do if new_hash is empty */
+		if (ftrace_hash_empty(new_hash))
+			break;
+	}
+	return new_hash;
+}
+
+/* Make @ops trace evenything except what all its subops do not trace */
+static struct ftrace_hash *intersect_hashes(struct ftrace_ops *ops)
+{
+	struct ftrace_hash *new_hash = NULL;
+	struct ftrace_ops *subops;
+	int size_bits;
+	int ret;
+
+	list_for_each_entry(subops, &ops->subop_list, list) {
+		struct ftrace_hash *next_hash;
+
+		if (!new_hash) {
+			size_bits = subops->func_hash->notrace_hash->size_bits;
+			new_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->notrace_hash);
+			if (!new_hash)
+				return NULL;
+			continue;
+		}
+		size_bits = new_hash->size_bits;
+		next_hash = new_hash;
+		new_hash = alloc_ftrace_hash(size_bits);
+		ret = intersect_hash(&new_hash, next_hash, subops->func_hash->notrace_hash);
+		free_ftrace_hash(next_hash);
+		if (ret < 0) {
+			free_ftrace_hash(new_hash);
+			return NULL;
+		}
+		/* Nothing more to do if new_hash is empty */
+		if (ftrace_hash_empty(new_hash))
+			break;
+	}
+	return new_hash;
+}
+
+static bool ops_equal(struct ftrace_hash *A, struct ftrace_hash *B)
+{
+	struct ftrace_func_entry *entry;
+	int size;
+	int i;
+
+	if (ftrace_hash_empty(A))
+		return ftrace_hash_empty(B);
+
+	if (ftrace_hash_empty(B))
+		return ftrace_hash_empty(A);
+
+	if (A->count != B->count)
+		return false;
+
+	size = 1 << A->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &A->buckets[i], hlist) {
+			if (!__ftrace_lookup_ip(B, entry->ip))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
+					   struct ftrace_hash **orig_hash,
+					   struct ftrace_hash *hash,
+					   int enable);
+
+static int ftrace_update_ops(struct ftrace_ops *ops, struct ftrace_hash *filter_hash,
+			     struct ftrace_hash *notrace_hash)
+{
+	int ret;
+
+	if (!ops_equal(filter_hash, ops->func_hash->filter_hash)) {
+		ret = ftrace_hash_move_and_update_ops(ops, &ops->func_hash->filter_hash,
+						      filter_hash, 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!ops_equal(notrace_hash, ops->func_hash->notrace_hash)) {
+		ret = ftrace_hash_move_and_update_ops(ops, &ops->func_hash->notrace_hash,
+						      notrace_hash, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ftrace_startup_subops - enable tracing for subops of an ops
+ * @ops: Manager ops (used to pick all the functions of its subops)
+ * @subops: A new ops to add to @ops
+ * @command: Extra commands to use to enable tracing
+ *
+ * The @ops is a manager @ops that has the filter that includes all the functions
+ * that its list of subops are tracing. Adding a new @subops will add the
+ * functions of @subops to @ops.
+ */
+int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	struct ftrace_hash *filter_hash;
+	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *save_filter_hash;
+	struct ftrace_hash *save_notrace_hash;
+	int size_bits;
+	int ret;
+
+	if (unlikely(ftrace_disabled))
+		return -ENODEV;
+
+	ftrace_ops_init(ops);
+	ftrace_ops_init(subops);
+
+	if (WARN_ON_ONCE(subops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EBUSY;
+
+	/* Make everything canonical (Just in case!) */
+	if (!ops->func_hash->filter_hash)
+		ops->func_hash->filter_hash = EMPTY_HASH;
+	if (!ops->func_hash->notrace_hash)
+		ops->func_hash->notrace_hash = EMPTY_HASH;
+	if (!subops->func_hash->filter_hash)
+		subops->func_hash->filter_hash = EMPTY_HASH;
+	if (!subops->func_hash->notrace_hash)
+		subops->func_hash->notrace_hash = EMPTY_HASH;
+
+	/* For the first subops to ops just enable it normally */
+	if (list_empty(&ops->subop_list)) {
+		/* Just use the subops hashes */
+		filter_hash = copy_hash(subops->func_hash->filter_hash);
+		notrace_hash = copy_hash(subops->func_hash->notrace_hash);
+		if (!filter_hash || !notrace_hash) {
+			free_ftrace_hash(filter_hash);
+			free_ftrace_hash(notrace_hash);
+			return -ENOMEM;
+		}
+
+		save_filter_hash = ops->func_hash->filter_hash;
+		save_notrace_hash = ops->func_hash->notrace_hash;
+
+		ops->func_hash->filter_hash = filter_hash;
+		ops->func_hash->notrace_hash = notrace_hash;
+		list_add(&subops->list, &ops->subop_list);
+		ret = ftrace_startup(ops, command);
+		if (ret < 0) {
+			list_del(&subops->list);
+			ops->func_hash->filter_hash = save_filter_hash;
+			ops->func_hash->notrace_hash = save_notrace_hash;
+			free_ftrace_hash(filter_hash);
+			free_ftrace_hash(notrace_hash);
+		} else {
+			free_ftrace_hash(save_filter_hash);
+			free_ftrace_hash(save_notrace_hash);
+			subops->flags |= FTRACE_OPS_FL_ENABLED;
+		}
+		return ret;
+	}
+
+	/*
+	 * Here there's already something attached. Here are the rules:
+	 *   o If either filter_hash is empty then the final stays empty
+	 *      o Otherwise, the final is a superset of both hashes
+	 *   o If either notrace_hash is empty then the final stays empty
+	 *      o Otherwise, the final is an intersection between the hashes
+	 */
+	if (ftrace_hash_empty(ops->func_hash->filter_hash) ||
+	    ftrace_hash_empty(subops->func_hash->filter_hash)) {
+		filter_hash = EMPTY_HASH;
+	} else {
+		size_bits = max(ops->func_hash->filter_hash->size_bits,
+				subops->func_hash->filter_hash->size_bits);
+		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
+		if (!filter_hash)
+			return -ENOMEM;
+		ret = append_hash(&filter_hash, subops->func_hash->filter_hash);
+		if (ret < 0) {
+			free_ftrace_hash(filter_hash);
+			return ret;
+		}
+	}
+
+	if (ftrace_hash_empty(ops->func_hash->notrace_hash) ||
+	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
+		notrace_hash = EMPTY_HASH;
+	} else {
+		size_bits = max(ops->func_hash->filter_hash->size_bits,
+				subops->func_hash->filter_hash->size_bits);
+		notrace_hash = alloc_ftrace_hash(size_bits);
+		if (!notrace_hash) {
+			free_ftrace_hash(filter_hash);
+			return -ENOMEM;
+		}
+
+		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
+				     subops->func_hash->filter_hash);
+		if (ret < 0) {
+			free_ftrace_hash(filter_hash);
+			free_ftrace_hash(notrace_hash);
+			return ret;
+		}
+	}
+
+	list_add(&subops->list, &ops->subop_list);
+
+	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
+	free_ftrace_hash(filter_hash);
+	free_ftrace_hash(notrace_hash);
+	if (ret < 0)
+		list_del(&subops->list);
+	else
+		subops->flags |= FTRACE_OPS_FL_ENABLED;
+
+	return ret;
+}
+
+/**
+ * ftrace_shutdown_subops - Remove a subops from a manager ops
+ * @ops: A manager ops to remove @subops from
+ * @subops: The subops to remove from @ops
+ * @command: Any extra command flags to add to modifying the text
+ *
+ * Removes the functions being traced by the @subops from @ops. Note, it
+ * will not affect functions that are being traced by other subops that
+ * still exist in @ops.
+ *
+ * If the last subops is removed from @ops, then @ops is shutdown normally.
+ */
+int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	struct ftrace_hash *filter_hash;
+	struct ftrace_hash *notrace_hash;
+	int ret;
+
+	if (unlikely(ftrace_disabled))
+		return -ENODEV;
+
+	if (WARN_ON_ONCE(!(subops->flags & FTRACE_OPS_FL_ENABLED)))
+		return -EINVAL;
+
+	list_del(&subops->list);
+
+	if (list_empty(&ops->subop_list)) {
+		/* Last one, just disable the current ops */
+
+		ret = ftrace_shutdown(ops, command);
+		if (ret < 0) {
+			list_add(&subops->list, &ops->subop_list);
+			return ret;
+		}
+
+		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
+
+		free_ftrace_hash(ops->func_hash->filter_hash);
+		free_ftrace_hash(ops->func_hash->notrace_hash);
+		ops->func_hash->filter_hash = EMPTY_HASH;
+		ops->func_hash->notrace_hash = EMPTY_HASH;
+
+		return 0;
+	}
+
+	/* Rebuild the hashes without subops */
+	filter_hash = append_hashes(ops);
+	notrace_hash = intersect_hashes(ops);
+	if (!filter_hash || !notrace_hash) {
+		free_ftrace_hash(filter_hash);
+		free_ftrace_hash(notrace_hash);
+		list_add(&subops->list, &ops->subop_list);
+		return -ENOMEM;
+	}
+
+	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
+	if (ret < 0)
+		list_add(&subops->list, &ops->subop_list);
+	else
+		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
+
+	free_ftrace_hash(filter_hash);
+	free_ftrace_hash(notrace_hash);
+	return ret;
+}
+
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
 unsigned long		ftrace_number_of_pages;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 19eddcb91584..cdfd12c44ab4 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -15,6 +15,7 @@ extern struct ftrace_ops global_ops;
 int ftrace_startup(struct ftrace_ops *ops, int command);
 int ftrace_shutdown(struct ftrace_ops *ops, int command);
 int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
+int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a5070f9b977b..9a70beb2cc46 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1136,6 +1136,7 @@ extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 			     int len, int reset);
 extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
 			      int len, int reset);
+extern int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 #else
 struct ftrace_func_command;
 
-- 
2.43.0



