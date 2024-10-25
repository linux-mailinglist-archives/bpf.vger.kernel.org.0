Return-Path: <bpf+bounces-43185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB99B0F49
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557531C21FA2
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DE20EA59;
	Fri, 25 Oct 2024 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="awXnidT5"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84920EA4A;
	Fri, 25 Oct 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885319; cv=none; b=WLLca6+8Cdb3nS0siRXqiI4x9kmzggZa7qQ5EZQj7ewVR6w5aBzSbEp5bIV/SlUta+Y8bcAf11gvsDRMSFmhh5hJAgqoZvgW/k60oiD7yT0u+H/UoJbNrlIjH77CrN2X+arTJ4KuVsTBigy1Wy76TYlj7KjaKGT3k3cfk9f1lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885319; c=relaxed/simple;
	bh=dppblIz1pBp4r1wgur1T1P7Xk4sFCLPXO+HIzohymS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVofEtytwLYncDCHKMRvcLcEVrPf1MQUXOFDyxkbfFnn8o7gtCsAPdrD9ZmN3bJrgAwg9XQo/5K9ZtKDl9oDwPxgDHEb0WCESLRQzyDEM7Tz7iosNTNEZg0YDqFavENrBP1diljPmYsYbVCxastHPFGvmpp7glCSgGETC1ucEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=awXnidT5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729885315;
	bh=dppblIz1pBp4r1wgur1T1P7Xk4sFCLPXO+HIzohymS8=;
	h=From:To:Cc:Subject:Date:From;
	b=awXnidT52OTcWAI3S75BOHN8HYktUCwd6gTXgOmoeBs61ugdt+cxn/JDKK1/iOrRd
	 8Jo7HlxLjkHOOUPoXmJi9ufiLUHqQzTOeGxY8miKmDV5gSY6hpy5Hp+YO3QQh/gur2
	 QiIBZQmeSJpoGimI7MqsEsJekK+m0f7O93HSb/d/sXF/PulIwBn1zVqzpd/UDGdO+a
	 oqAds6N3XysQ+4TOY+Gho8KyqjnULh4y5GinMLjP/+U/RTVsbEALQP7iD6By2KFrxc
	 cqHBz7Iaw4k7coMW9gJwomOBOiUPfptRzC9T6Li9MVS7skjxGBdiU+7LoPTzb4tzk3
	 0AUQluecnrHHQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XZtTH4vBqz19L5;
	Fri, 25 Oct 2024 15:41:55 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>
Subject: [RFC PATCH v2] tracing: Fix syscall tracepoint use-after-free
Date: Fri, 25 Oct 2024 15:40:10 -0400
Message-Id: <20241025194010.515253-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The grace period used internally within tracepoint.c:release_probes()
uses call_rcu() to batch waiting for quiescence of old probe arrays,
rather than using the tracepoint_synchronize_unregister() which blocks
while waiting for quiescence.

With the introduction of faultable syscall tracepoints, this causes
use-after-free issues reproduced with syzkaller.

Fix this by introducing tracepoint_call_rcu(), which uses the
appropriate call_rcu() or call_rcu_tasks_trace() before invoking the
rcu_free_old_probes callback.

Use tracepoint_call_rcu() in bpf_link_free() for raw tracepoints as
well, which has the same problem for syscall tracepoints. Ditto for
bpf_prog_put().

Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jordan Rife <jrife@google.com>
---
Changes since v0:
- Introduce tracepoint_call_rcu(),
- Fix bpf_link_free() use of call_rcu as well.

Changes since v1:
- Use tracepoint_call_rcu() for bpf_prog_put as well.
---
 include/linux/tracepoint.h |  9 +++++++++
 kernel/bpf/syscall.c       | 36 +++++++++++++++++++++++++++---------
 kernel/tracepoint.c        | 22 ++++++++++++++++++----
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0dc67fad706c..45025d6b2dd6 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -104,6 +104,8 @@ void for_each_tracepoint_in_module(struct module *mod,
  * tracepoint_synchronize_unregister must be called between the last tracepoint
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
+ * An alternative to tracepoint_synchronize_unregister() is to use
+ * tracepoint_call_rcu() for batched reclaim.
  */
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
@@ -111,9 +113,16 @@ static inline void tracepoint_synchronize_unregister(void)
 	synchronize_rcu_tasks_trace();
 	synchronize_rcu();
 }
+
+void tracepoint_call_rcu(struct tracepoint *tp, struct rcu_head *head,
+			 void (*callback)(struct rcu_head *head));
+
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
+static inline void tracepoint_call_rcu(struct tracepoint *tp, struct rcu_head *head,
+				       void (*callback)(struct rcu_head *head))
+{ }
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 59de664e580d..f21000f33a61 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2992,28 +2992,46 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
 }
 
+static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
+{
+	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
+
+	bpf_prog_put(aux->prog);
+}
+
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
 	const struct bpf_link_ops *ops = link->ops;
+	struct bpf_raw_tp_link *raw_tp = NULL;
 	bool sleepable = false;
 
+	if (link->type == BPF_LINK_TYPE_RAW_TRACEPOINT)
+		raw_tp = container_of(link, struct bpf_raw_tp_link, link);
 	bpf_link_free_id(link->id);
 	if (link->prog) {
 		sleepable = link->prog->sleepable;
 		/* detach BPF program, clean up used resources */
 		ops->release(link);
-		bpf_prog_put(link->prog);
+		if (raw_tp)
+			tracepoint_call_rcu(raw_tp->btp->tp, &link->prog->aux->rcu,
+					    bpf_link_defer_bpf_prog_put);
+		else
+			bpf_prog_put(link->prog);
 	}
 	if (ops->dealloc_deferred) {
-		/* schedule BPF link deallocation; if underlying BPF program
-		 * is sleepable, we need to first wait for RCU tasks trace
-		 * sync, then go through "classic" RCU grace period
-		 */
-		if (sleepable)
-			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
-		else
-			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
+		if (raw_tp) {
+			tracepoint_call_rcu(raw_tp->btp->tp, &link->rcu, bpf_link_defer_dealloc_rcu_gp);
+		} else {
+			/* schedule BPF link deallocation; if underlying BPF program
+			 * is sleepable, we need to first wait for RCU tasks trace
+			 * sync, then go through "classic" RCU grace period
+			 */
+			if (sleepable)
+				call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+			else
+				call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
+		}
 	} else if (ops->dealloc)
 		ops->dealloc(link);
 }
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6474e2cf22c9..ef60c5484eda 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -106,13 +106,27 @@ static void rcu_free_old_probes(struct rcu_head *head)
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
-static inline void release_probes(struct tracepoint_func *old)
+static bool tracepoint_is_syscall(struct tracepoint *tp)
+{
+	return !strcmp(tp->name, "sys_enter") || !strcmp(tp->name, "sys_exit");
+}
+
+void tracepoint_call_rcu(struct tracepoint *tp, struct rcu_head *head,
+			 void (*callback)(struct rcu_head *head))
+{
+	if (tracepoint_is_syscall(tp))
+		call_rcu_tasks_trace(head, callback);
+	else
+		call_rcu(head, callback);
+}
+
+static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
-		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
+		tracepoint_call_rcu(tp, &tp_probes->rcu, rcu_free_old_probes);
 	}
 }
 
@@ -334,7 +348,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 		break;
 	}
 
-	release_probes(old);
+	release_probes(tp, old);
 	return 0;
 }
 
@@ -406,7 +420,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	release_probes(old);
+	release_probes(tp, old);
 	return 0;
 }
 
-- 
2.39.5


