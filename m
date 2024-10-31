Return-Path: <bpf+bounces-43649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6C9B7E44
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA8CB22B06
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2631A705B;
	Thu, 31 Oct 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DEtrtf9+"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A219EEB4;
	Thu, 31 Oct 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388161; cv=none; b=nLss5lFAyZjT1hY8lg0cH9i+kZpKSiQkYU70fTkgcXREib8keE3v6D4wGOQf4RkAdiPVA1jS4f4WPWbNgMGQCGLDmAQqj0r8eA3u+coY4eu/YSkNNiT6HExU0H5dHPOk6urwHi5JVVNIpwhGSsrAEH0oDXWnTr4LkCtaTxXdmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388161; c=relaxed/simple;
	bh=uEN1AqlrH2AWDEp9Cb8CU/xKYKWeooS7jJG9/x9li3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJRRQLdoxCEmnzHGELD5LPYlvkLrzQxgtRlNnDfZJCRP/OGtHyVCkteY9O/QGF8p20UiEBtStMCcUVRofN32KNvBenIwqOVYk1dX9Tub0BvT4iZIWL8+rETwoy6KGS87KH67969pdxUgPyhLj556KPWjDwYNEFi0ZkZWDWJ23V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DEtrtf9+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730388157;
	bh=uEN1AqlrH2AWDEp9Cb8CU/xKYKWeooS7jJG9/x9li3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEtrtf9+GE+0DmEuMyebNd1qutvYd8f3Q+GtpFtEZNzdG031NcrDmVnwQrWBrf0Dg
	 V4UpaHjzUe1mJEbEL3hHvXfhkQgb9XoAPxEi7EZzly2eqAPBUx54Q3lPGP5Xnaafci
	 NnMqx786t/ifHWPJLqJF0nFeM9E2E4UrXaAtA3n1eCW6xyXwL9Hwu82/8yc+MBpHFB
	 bzxo0FahcmMI24aaDtxeNhci1pzk6uA7Tc7Yvj8aTxmuXXcwwhf2mUXFGs8WYUCYuc
	 2gfnG44dtbZXn8b9qcDBtwuWoqm0KQ5PMQhmIzV+3oZfQ6NS77ZFJc8NLyAhDeFpSF
	 Joqjoq6V+IWpg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSRK491WzZ6R;
	Thu, 31 Oct 2024 11:22:37 -0400 (EDT)
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
	linux-trace-kernel@vger.kernel.org,
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Subject: [PATCH v5 resend 3/4] tracing: Fix syscall tracepoint use-after-free
Date: Thu, 31 Oct 2024 11:20:55 -0400
Message-Id: <20241031152056.744137-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
References: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
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
Tested-by: Jordan Rife <jrife@google.com>
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
Cc: linux-trace-kernel@vger.kernel.org
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


