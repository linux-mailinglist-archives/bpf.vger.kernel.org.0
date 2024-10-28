Return-Path: <bpf+bounces-43325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21C9B3A3E
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1352283087
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C491EE02E;
	Mon, 28 Oct 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lfCHeHjO"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439F1E0B7B;
	Mon, 28 Oct 2024 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142679; cv=none; b=Cet0WR87WAIHMCs3N9Hv1gNZ5KXAIZzIG3ruZrxX41fDFebAVezChGb90Yre/M0JGoFNAXKpePDZGkkBFQX/Yx0yBDn1fLQEA0dhaZvYNFzC6MU58C0/KQxAHngHqmYeJvMgxrl5RO89UJ5y+Ar+nwpewhX5ewpvR9li+47yxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142679; c=relaxed/simple;
	bh=csBoq7DrfsGO+bhagDLyjpKpU4ToRC3SFP9oiq5xb2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCWiTOdXTDoFddDhTfDD10l6f72p7ofylFpT7Vv1BmoFFGVNwMaZ/S3QHAsHNYQo8CXFwW8nMrq3r/prYkIxO5E38AqDCcTyRd5ucQ89pcKO+ONOMn2LP2BPP7eVQ9h/SMlp8xb+otvGunpKBBefTnxlxnR9n2ozp+rakTx9a50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lfCHeHjO; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142675;
	bh=csBoq7DrfsGO+bhagDLyjpKpU4ToRC3SFP9oiq5xb2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfCHeHjO65vOZgGbL1De9X6TJLPOjYf6eff+2COHYPSmD8ZmhOY2t/AfMcduXwb/Y
	 kbbE9/7XY7vTflcI5hrDMSJiqvPNiBHsZbfp1IY+vQoYlObeQl8OoCoGjkQ9A7djEm
	 u5ivmpt7/p4kJagM2f1TS0nay9GwULol8BgbWK6NS84vEaLbSJ493lJTIpUuezPsoY
	 Yz/J1NyOZ8IcPVjmv5OjFN1baRBgSZ9X+jsDIlGi175KoLBXfv12hI3M4VWhylWr6l
	 cN1jk4EnHgPL0TKw/R7GpqNAFF0UgkgZh+apab/N5H6BfgWIvwjyTAGd3Psl87bKla
	 fcsfqAojJ7qQQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjfV5G5jzsfK;
	Mon, 28 Oct 2024 15:11:14 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [RFC PATCH v4 3/4] tracing: Fix syscall tracepoint use-after-free
Date: Mon, 28 Oct 2024 15:09:26 -0400
Message-Id: <20241028190927.648953-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
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
using the tracepoint_is_faultable() API.

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

Changes since v3:
- Use tracepoint_is_faultable().
---
 kernel/tracepoint.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 5658dc92f5b5..1848ce7e2976 100644
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
+		if (tracepoint_is_faultable(tp))
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


