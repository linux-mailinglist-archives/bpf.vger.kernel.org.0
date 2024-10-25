Return-Path: <bpf+bounces-43180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3BA9B0D1A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281C228671F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948AD1E3DE0;
	Fri, 25 Oct 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="psNYaANH"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB318C90E;
	Fri, 25 Oct 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880631; cv=none; b=eQ+83UJ2pdzf903+8frIPDNE/ZxlNZKxXh/kghjVZtzmDbEbWtuFDFOw9DvSNZIdSoOLzRduN0NLbjRijdh+uTb+AH8igw6kGAGWeERaiaT8gY9D/4MOcPmDwsB9qbbJAJ3INOgYDoy8RTOHcanMxBf+rfsjY0vos1FihfWDSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880631; c=relaxed/simple;
	bh=YEYc5xZ5l1SCu9KmKUt2XN5rNzlOGvWAxEYlD7n/SgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kH7MLjbqptFe+HKECHclb0pNryBADxkPHR4yHa8gNIV2L3EsSWgRL77ECjAadJRHOogSJuYKTpT547hSjwcS30CiSldqJAP15O2iIxqKmRn6Qrz4abpSI0Cxwbd0FG28zs975jHdsBkPuVuaGYu6BWA71CK+Fw1dRJoBEbL9sfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=psNYaANH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729880619;
	bh=YEYc5xZ5l1SCu9KmKUt2XN5rNzlOGvWAxEYlD7n/SgA=;
	h=From:To:Cc:Subject:Date:From;
	b=psNYaANHDkNN4V13jxFO7Z15fCFgqANPKnfc3E5mADzIUcFqq+J33eS5EeOYN7rWd
	 UCCNC5xjCiDqacHI9h0k8O0G5j0Q+OlKzPGjoeYk3PtcdZj7kcP6rRCR31m5vSNEDz
	 xI4F2N/MlYCctfFGpFvhv2Pjv4/WKq8l9Av/sX7hjzXU9XokcLz9uVNBqNXuIo1uP7
	 NS5f2giwtg6Nj4R/nu2DBRB8J8BRGCS4edeNrTNieqlH44MpBMzDJ3jocD532TJ60V
	 1AZE1KaBxVVwuhE0tnFtYhnzVjP8C0BfxxnVCKjjaBvROYaQxUmv1wDdhldXjo9C+J
	 KT5sGAzyIa5gA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XZrkz4Nfwz18fy;
	Fri, 25 Oct 2024 14:23:39 -0400 (EDT)
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
Subject: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
Date: Fri, 25 Oct 2024 14:21:49 -0400
Message-Id: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
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
well, which has the same problem for syscall tracepoints.

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
---
 include/linux/tracepoint.h |  9 +++++++++
 kernel/bpf/syscall.c       | 23 +++++++++++++++--------
 kernel/tracepoint.c        | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 12 deletions(-)

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
index 59de664e580d..1191dc1d4206 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3006,14 +3006,21 @@ static void bpf_link_free(struct bpf_link *link)
 		bpf_prog_put(link->prog);
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
+		if (link->type == BPF_LINK_TYPE_RAW_TRACEPOINT) {
+		        struct bpf_raw_tp_link *raw_tp =
+				container_of(link, struct bpf_raw_tp_link, link);
+
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


