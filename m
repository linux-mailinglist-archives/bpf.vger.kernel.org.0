Return-Path: <bpf+bounces-31121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7846F8D7352
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D6281F1A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC397374EA;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BD2BD0F;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299446; cv=none; b=ZD50P8bYP328sZ9Tg4oWYhNmLbtYMgU1jR/6SEoJAAIvM+xDbWAs7w+EyXBjtJf1CWokhPi2iaviOV+M6blYauoQ7UgvID0xDcQ+NPEr4b1tWRFGB0w41/iRJfKqZ07X7JzjWzMy29xBXI8LvDLOoOy5oEOFJyMKsvkUms9eDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299446; c=relaxed/simple;
	bh=RcRavuCzGHOOIG2b1OsJuToXe82mFmzkJ0VhaZCnWqg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TRDULX41v/+4AYfSFmJiHUQi2xv9EYwFprgldhVB9rzybwG0HUH5u0lvGzwDaxkCAJnFX+odAERYyYWy7FD0o2rXKp8UzrrgXA5FnWzOk54mbI6ku4yy89UyvauDZ+F/55NcFG0CRqvaOLJtMYtWTjhA5QCv2ygX0GLjD9noRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA666C4AF0E;
	Sun,  2 Jun 2024 03:37:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3F-000000094OQ-02Z0;
	Sat, 01 Jun 2024 23:38:33 -0400
Message-ID: <20240602033832.870736657@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
Subject: [PATCH v2 11/27] ftrace: Allow subops filtering to be modified
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The subops filters use a "manager" ops to enable and disable its filters.
The manager ops can handle more than one subops, and its filter is what
controls what functions get set. Add a ftrace_hash_move_and_update_subops()
function that will update the manager ops when the subops filters change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  3 ++
 kernel/trace/ftrace.c  | 96 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 978a1d3b270a..63238a9a9270 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -227,6 +227,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  *             ftrace_enabled.
  * DIRECT - Used by the direct ftrace_ops helper for direct functions
  *            (internal ftrace only, should not be used by others)
+ * SUBOP  - Is controlled by another op in field managed.
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= BIT(0),
@@ -247,6 +248,7 @@ enum {
 	FTRACE_OPS_FL_TRACE_ARRAY		= BIT(15),
 	FTRACE_OPS_FL_PERMANENT                 = BIT(16),
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
+	FTRACE_OPS_FL_SUBOP			= BIT(18),
 };
 
 #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
@@ -336,6 +338,7 @@ struct ftrace_ops {
 	struct list_head		list;
 	struct list_head		subop_list;
 	ftrace_ops_func_t		ops_func;
+	struct ftrace_ops		*managed;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	unsigned long			direct_call;
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 38fb2a634b04..e447b04c0c9c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3424,7 +3424,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 		} else {
 			free_ftrace_hash(save_filter_hash);
 			free_ftrace_hash(save_notrace_hash);
-			subops->flags |= FTRACE_OPS_FL_ENABLED;
+			subops->flags |= FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP;
+			subops->managed = ops;
 		}
 		return ret;
 	}
@@ -3478,11 +3479,12 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
 	free_ftrace_hash(filter_hash);
 	free_ftrace_hash(notrace_hash);
-	if (ret < 0)
+	if (ret < 0) {
 		list_del(&subops->list);
-	else
-		subops->flags |= FTRACE_OPS_FL_ENABLED;
-
+	} else {
+		subops->flags |= FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP;
+		subops->managed = ops;
+	}
 	return ret;
 }
 
@@ -3527,6 +3529,8 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 		free_ftrace_hash(ops->func_hash->notrace_hash);
 		ops->func_hash->filter_hash = EMPTY_HASH;
 		ops->func_hash->notrace_hash = EMPTY_HASH;
+		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
+		subops->managed = NULL;
 
 		return 0;
 	}
@@ -3542,16 +3546,65 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	}
 
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
-	if (ret < 0)
+	if (ret < 0) {
 		list_add(&subops->list, &ops->subop_list);
-	else
-		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
-
+	} else {
+		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
+		subops->managed = NULL;
+	}
 	free_ftrace_hash(filter_hash);
 	free_ftrace_hash(notrace_hash);
 	return ret;
 }
 
+static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
+					      struct ftrace_hash **orig_subhash,
+					      struct ftrace_hash *hash,
+					      int enable)
+{
+	struct ftrace_ops *ops = subops->managed;
+	struct ftrace_hash **orig_hash;
+	struct ftrace_hash *save_hash;
+	struct ftrace_hash *new_hash;
+	int ret;
+
+	/* Manager ops can not be subops (yet) */
+	if (WARN_ON_ONCE(!ops || ops->flags & FTRACE_OPS_FL_SUBOP))
+		return -EINVAL;
+
+	/* Move the new hash over to the subops hash */
+	save_hash = *orig_subhash;
+	*orig_subhash = __ftrace_hash_move(hash);
+	if (!*orig_subhash) {
+		*orig_subhash = save_hash;
+		return -ENOMEM;
+	}
+
+	/* Create a new_hash to hold the ops new functions */
+	if (enable) {
+		orig_hash = &ops->func_hash->filter_hash;
+		new_hash = append_hashes(ops);
+	} else {
+		orig_hash = &ops->func_hash->notrace_hash;
+		new_hash = intersect_hashes(ops);
+	}
+
+	/* Move the hash over to the new hash */
+	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);
+
+	free_ftrace_hash(new_hash);
+
+	if (ret) {
+		/* Put back the original hash */
+		free_ftrace_hash_rcu(*orig_subhash);
+		*orig_subhash = save_hash;
+	} else {
+		free_ftrace_hash_rcu(save_hash);
+	}
+	return ret;
+}
+
+
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
 unsigned long		ftrace_number_of_pages;
@@ -4770,8 +4823,33 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 {
 	struct ftrace_ops_hash old_hash_ops;
 	struct ftrace_hash *old_hash;
+	struct ftrace_ops *op;
 	int ret;
 
+	if (ops->flags & FTRACE_OPS_FL_SUBOP)
+		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash, enable);
+
+	/*
+	 * If this ops is not enabled, it could be sharing its filters
+	 * with a subop. If that's the case, update the subop instead of
+	 * this ops. Shared filters are only allowed to have one ops set
+	 * at a time, and if we update the ops that is not enabled,
+	 * it will not affect subops that share it.
+	 */
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED)) {
+		/* Check if any other manager subops maps to this hash */
+		do_for_each_ftrace_op(op, ftrace_ops_list) {
+			struct ftrace_ops *subops;
+
+			list_for_each_entry(subops, &op->subop_list, list) {
+				if ((subops->flags & FTRACE_OPS_FL_ENABLED) &&
+				     subops->func_hash == ops->func_hash) {
+					return ftrace_hash_move_and_update_subops(subops, orig_hash, hash, enable);
+				}
+			}
+		} while_for_each_ftrace_op(op);
+	}
+
 	old_hash = *orig_hash;
 	old_hash_ops.filter_hash = ops->func_hash->filter_hash;
 	old_hash_ops.notrace_hash = ops->func_hash->notrace_hash;
-- 
2.43.0



