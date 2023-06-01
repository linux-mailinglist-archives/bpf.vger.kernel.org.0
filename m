Return-Path: <bpf+bounces-1586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F8719C14
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51012816ED
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2509BA2F;
	Thu,  1 Jun 2023 12:26:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C123404
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 12:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F74FC4339C;
	Thu,  1 Jun 2023 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685622396;
	bh=QqQzQ7NZnj7EXE4Ap4NPU/RPq4MNdjLXz0fnp5miIKU=;
	h=From:To:Cc:Subject:Date:From;
	b=qsNBGFLvMEDNTIOhw/vuLdAXTEJA5VyLw/QHUReyPrXw+nTcfp/kQvP4TjegXlceK
	 bAMOo82/o9gcfWVn4b4P9uo2UotN814i+Hw4c/c8HMmjgH8a56fCAvjy4HTVvqIPh8
	 iBm26/UQPJgx1Y0Gjj4GbthS8O0Cy0kpTy0DLhujt4m/lTGtTr6xja8f/xrDP1vJmX
	 yLng75tpNl4NVJsut4nK+g1Xgn3hxhy0Xwvs14xvYXjtAclKMSPKzzfVxfcWZ6f4WZ
	 HqArpd79T5sTLEHGN2efI6ED+TS7xY6+EiRiKkaGM5CUVjOEmqpN9XpvKGan4oBFUJ
	 FANYt4HPosy5Q==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	ast@kernel.org,
	songliubraving@fb.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Kuba Piecuch <jpiecuch@google.com>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf] bpf: Fix UAF in task local storage
Date: Thu,  1 Jun 2023 14:26:22 +0200
Message-ID: <20230601122622.513140-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the the task local storage was generalized for tracing programs, the
bpf_task_local_storage callback was moved from a BPF LSM hook callback
for security_task_free LSM hook to it's own callback. But a failure case
in bad_fork_cleanup_security was missed which, when triggered, led to a dangling
task owner pointer and a subsequent use-after-free.

This issue was noticed when a BPF LSM program was attached to the
task_alloc hook on a kernel with KASAN enabled. The program used
bpf_task_storage_get to copy the task local storage from the current
task to the new task being created.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Reported-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---

This fixes the regression from the LSM blob based implementation, we can
still have UAFs, if bpf_task_storage_get is invoked after bpf_task_storage_free
in the cleanup path.

 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..112d85091ae6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2781,6 +2781,7 @@ __latent_entropy struct task_struct *copy_process(
 	exit_sem(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
+	bpf_task_storage_free(p);
 bad_fork_cleanup_audit:
 	audit_free(p);
 bad_fork_cleanup_perf:
-- 
2.41.0.rc0.172.g3f132b7071-goog


