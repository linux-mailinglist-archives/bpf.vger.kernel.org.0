Return-Path: <bpf+bounces-43719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77709B8F62
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603A928361B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5C1AA78F;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2741A726B;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457370; cv=none; b=pfpQVJm7XBc+428OxjEFyfEcInuVkZ1IfmxYI3/KqtZzh14qCWGS4c92/lVRsY445IK6nyqTF8+UX+7PQ6lFfNhrXGboP/9ReXJ2KkwbY+kgoJ1aSm0eLVZiyQ2ZyzYi6823w4aenV1I6LGCZrofickQVnnGmJAIltVM2sEFLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457370; c=relaxed/simple;
	bh=xxPVhVtwZlCs28URhdLLLEJa8UByNgRj/zGcg84wWvA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PR6A1c+OPKpwq1yQ1jBLW4FD6NPMpz1wdKt1ufI74IIXmr1yjDwHM0Z+/vGX/U2P/wFeYgO1T1Cc//tGwmfJytiRQgjBKWkHJDkVrJNyMhfU4SS1y6pfXG13g2xlrIFI8rFcG8KI4nABn71N4rBxXQ12Tx3TdABAjrtu0Ys6WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349BC4CEDA;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1g-00000005S8Y-1fDO;
	Fri, 01 Nov 2024 06:37:08 -0400
Message-ID: <20241101103708.252744660@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Jordan Rife <jrife@google.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>,
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 09/11] tracing: Fix syscall tracepoint use-after-free
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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
Tested-by: Jordan Rife <jrife@google.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Cc: linux-trace-kernel@vger.kernel.org
Link: https://lore.kernel.org/20241031152056.744137-4-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.45.2



