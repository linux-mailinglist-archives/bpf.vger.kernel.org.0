Return-Path: <bpf+bounces-43242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348F9B1995
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329AC1C20FD6
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39C1D6DC4;
	Sat, 26 Oct 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WkI243QA"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9817082C;
	Sat, 26 Oct 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957699; cv=none; b=YLSyYuf1jGh4LU/UaECecOhl5h/OrsP7QmAlGnjh64SiCuUOW7/jIhnXozpkKr8AiyeU1ruW+lPkXlrnylEtFXF/bTDU3L6/NlKtZ/fetHcZVd4i4bU11L+ntZjYwNxUssEOPiXeAdzbIHgJvX1GEF5aKwN73YfXPN5NuM68Ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957699; c=relaxed/simple;
	bh=mP2SnazjhRJn11GZWVw23pPFqpTRRLfPTVW/ACXPM/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEtIg0YXEtC8V6EPR8n/TDdmSZq8rBf3SJZqbOT0ePNz6zTgTvRY7/J7L1ui6qH98ccTurEMXWU2betgZR0TYBV12FRzeE8SjhNV2JrX2r5t4aDzIDKp+qFK7Ok75lcDwRnTZAvHA/BKMevgu6CT5vPD1CXPFcAfctP+SPnmatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WkI243QA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729957694;
	bh=mP2SnazjhRJn11GZWVw23pPFqpTRRLfPTVW/ACXPM/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkI243QAgP/1+HAbl6jg9BO3I5WlscoGIdV+jSAB8hajaCAOu+FtOoHqVZD9gzhiX
	 tnFRi49Bl/2BnJXVagz/TxtZEmRyflC9GrbbyTs4OE2WBcJmgAWltaa4x5MlYIdFF+
	 59Cblqrf5VojmZnZM8dQogtSziWXotcgCIxZQLFM/bkaoSWqDiYzwq3MpZ6kQ3n9mh
	 VRL1mRTxs6MX675IKU+b7xPB0mQ2nMJkC6BlXLOYJPhMIngHEb8B44HZ3CCvUOTP46
	 W7Z3JSuuMlkJKmkvG9p49u8IvJHDdiRPMYNW2rNMWD/B5JWYgbaifnToiqcHFNJKkF
	 6AUmJwOzqt9HQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XbPFB126RzNmP;
	Sat, 26 Oct 2024 11:48:14 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Jordan Rife <jrife@google.com>,
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Subject: [RFC PATCH v3 3/3] tracing: Fix syscall tracepoint use-after-free
Date: Sat, 26 Oct 2024 11:46:29 -0400
Message-Id: <20241026154629.593041-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
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

Fix this by using the appropriate call_rcu() or call_rcu_tasks_trace()
before invoking the rcu_free_old_probes callback. This can be chosen
using the tracepoint_is_syscall() API.

A similar issue exists in bpf use of call_rcu(). Fixing this is left to
a separate change.

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

Changes since v2:
- Do not cover bpf changes in the same commit, let bpf developers
  implement it.
---
 kernel/tracepoint.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 5658dc92f5b5..47569fb06596 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -106,13 +106,16 @@ static void rcu_free_old_probes(struct rcu_head *head)
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
-static inline void release_probes(struct tracepoint_func *old)
+static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
-		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
+		if (tracepoint_is_syscall(tp))
+			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
+		else
+			call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
 
@@ -334,7 +337,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 		break;
 	}
 
-	release_probes(old);
+	release_probes(tp, old);
 	return 0;
 }
 
@@ -405,7 +408,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	release_probes(old);
+	release_probes(tp, old);
 	return 0;
 }
 
-- 
2.39.5


