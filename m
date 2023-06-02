Return-Path: <bpf+bounces-1633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30EF71F71C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F13B2818C2
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28475ED8;
	Fri,  2 Jun 2023 00:26:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CB816
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 00:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E0C433D2;
	Fri,  2 Jun 2023 00:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685665582;
	bh=p0jJDn6spmezGwjUHtzPF+Q+lQt+kfSEdVKqrj8rSA8=;
	h=From:To:Cc:Subject:Date:From;
	b=KHpp9HLYp+xLSEZIeRkpEzynpg2KqikgUefbhJ/hrONx6659ZcBkAlDC57qNyghg/
	 BfDKGnCAGxsEEDHJRbLy8Yx4T9WLbLnIxrrP0rk5JJ7QPaKiMoZsT6vxjbaNk1mQ/Q
	 JnAaafo2vwIhNeBPNYSRs/gkoP0Hg4amuVRSoktYxBroASvB6bR/J3fRngvZfD4Ld+
	 /iOPcsszrdRimOzUwFq8/9o/Dch3VtfkL0f39mA2yh6oh3kbyN6Tmj3KGMSuqp8KOj
	 0uFSKdf0ZOAyy8FNGMzTHMq/uz195aBR1oIqhkN94TaHza7Yd7Oh7W/oVNujlBclYs
	 CFNf8CccTs0qw==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	ast@kernel.org,
	songliubraving@fb.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Kuba Piecuch <jpiecuch@google.com>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf v2] bpf: Fix UAF in task local storage
Date: Fri,  2 Jun 2023 02:26:12 +0200
Message-ID: <20230602002612.1117381-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When task local storage was generalized for tracing programs, the
bpf_task_local_storage callback was moved from a BPF LSM hook
callback for security_task_free LSM hook to it's own callback. But a
failure case in bad_fork_cleanup_security was missed which, when
triggered, led to a dangling task owner pointer and a subsequent
use-after-free. Move the bpf_task_storage_free to the very end of
free_task to handle all failure cases.

This issue was noticed when a BPF LSM program was attached to the
task_alloc hook on a kernel with KASAN enabled. The program used
bpf_task_storage_get to copy the task local storage from the current
task to the new task being created.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Reported-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---

* v1 -> v2

Move the bpf_task_storage_free to free_task as suggested by Martin

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..cb20f9f596d3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -627,6 +627,7 @@ void free_task(struct task_struct *tsk)
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
+	bpf_task_storage_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -979,7 +980,6 @@ void __put_task_struct(struct task_struct *tsk)
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
-	bpf_task_storage_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
-- 
2.41.0.rc0.172.g3f132b7071-goog


