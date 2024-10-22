Return-Path: <bpf+bounces-42787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548149AB204
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138A228151B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6E1A38E4;
	Tue, 22 Oct 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sD4EGUzp"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20931A302E;
	Tue, 22 Oct 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610869; cv=none; b=MOIz5Xn/C+8v9SJHbeAMEpL5XRooosBH/FOFcuPrvf/zFLgVWXKeAGL7SvkXyJ4yWkB7k/wcwSqVqRSTJp3timr7NpS1SRylPQNvuNrO5mQMPI1nHw+0+qWDX/8LQZTXPrykAfspaPEqCmfE8Mr4xPEpggdmDFV2hccHtkrEbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610869; c=relaxed/simple;
	bh=2Mc2SXCOUMQ4Ki2MnPZxCewU6q9Ys7A8xNvKGEr0b3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZVM5GkZtJydfVEhRluB5x3rznH2dDNA9YZQKGsJMRh3Z81lTNr55x3jou0ZzTMVIBgfNwl+7BGPEQC1I+U5mGT8I1v/dD++BhrFBlzMtXVCUYyjHi1F3gbyfwQQmVdkSRsPDB/VwyPAgd3mam8LOf1s8tu5ILeYt91Pn4kGLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sD4EGUzp; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729610396;
	bh=2Mc2SXCOUMQ4Ki2MnPZxCewU6q9Ys7A8xNvKGEr0b3s=;
	h=From:To:Cc:Subject:Date:From;
	b=sD4EGUzp9bdumubR71lH2R2EessL9X6lGsbBllRzjpunBtHbxzUaq4jnTawn1fe0i
	 wgZL+94vLo6Wa5zJDvv2DIu5tQcb6e/JiY+VuWV7Y3PhMRffwhtjItmExexYODlU7V
	 4JYpER08hp9WC6mRDfS8VRKVLEh3vDf+SADVkq620M+rJuYVHLWHdUWeIEjfNTqT0B
	 HLrGE1WDf9WhXjpuTcWkx+wh+2F8KcOANk9TApq4zm4U7XLJkfpXFG0k8LANOaNIYd
	 F7A9dUXMiCWdqluulGE4vSIpe4Si359oIXbuofGQnEO73bov5uhMsxwY/6ddSAXh05
	 h33msiKCUsFHw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XXwpM6vC9zQmW;
	Tue, 22 Oct 2024 11:19:55 -0400 (EDT)
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
Subject: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
Date: Tue, 22 Oct 2024 11:18:04 -0400
Message-Id: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
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

This causes use-after-free issues reproduced with syzkaller.

Fix this by introducing the following call_rcu chaining:

   call_rcu() -> rcu_free_old_probes -> call_rcu_tasks_trace() -> rcu_tasks_trace_free_old_probes.

Just like it was done when SRCU was used.

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
 kernel/tracepoint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6474e2cf22c9..33f6fa94d383 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -101,11 +101,16 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void rcu_tasks_trace_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
-- 
2.39.5


