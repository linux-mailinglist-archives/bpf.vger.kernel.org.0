Return-Path: <bpf+bounces-69039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF14BB8BB9C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B651C21DB6
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877C21C16A;
	Sat, 20 Sep 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyPxAAFE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04510227E83;
	Sat, 20 Sep 2025 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329980; cv=none; b=XA4l2hG6l9CR+8GTKuHacSZQY4I4WE+E2GJPYN1sJ4/1ry75LrSRzZ3bfA0KFP/bcNs+VA+EV3ByeCQcliRvEawQV59mrZ4k+sN3AA2DCcEHx5Yc/w2k/exufU+DTNIJX6o7Oe+G4ARW1BnR5Y1tqzCUvQhnWJnreJR6WZKco+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329980; c=relaxed/simple;
	bh=7nU5v03BftWPqTaAzZYbuDLW9wu1WkEYWzembEyvQ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIeEE6onWcv8T6IrJ7Bq9jmfkUQDIcFQtMZ8nqeUmpJ4ICy9jj2QiGhxVfJeMLagrBTa3GauvrCrM0pgyXaxMQLyZBWYq8/RGZMVxuqf6AKsbFsxKhR/AqIsvWNbQWJg54pJ/QyGzzljKpyfaqi1wNQu5k03lLAfdff63wCiDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyPxAAFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60609C4CEF5;
	Sat, 20 Sep 2025 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329979;
	bh=7nU5v03BftWPqTaAzZYbuDLW9wu1WkEYWzembEyvQ24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyPxAAFEjcc0Lw73Ydl8Y1nkHcqQkLZY/FGxqj/85OskGwDPgqn7W07x2QH1O9WXl
	 jPmu5VUn0t/mWzT5wf/D2dYPeo7isKdDIJq7bbYGePUuZqZUelIO6eNOa0z2WorN6C
	 v4yNRlWbCw7TWjYXAroRWNOeSw3ScuHjFviyudBrkMVtTpkB5XMmjHeLlLGOdvqEQX
	 ucwqFOzHQQak27H5MMUgliuMW+3Txb6ZTN8FLIfGf3fy6vUL7TloF7oi/IvN4MDbtv
	 i6bUXV3kYpS3X2sMxveMG1fqD4NnJ+iobQfH1R4NlUfs+fo4FRkgjA0lOCDZtDzDmH
	 WhtYJyRWTnsQQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/46] sched_ext: Add SCX_EFLAG_INITIALIZED to indicate successful ops.init()
Date: Fri, 19 Sep 2025 14:58:28 -1000
Message-ID: <20250920005931.2753828-6-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.exit() may be called even if the loading failed before ops.init()
finishes successfully. This is because ops.exit() allows rich exit info
communication. Add SCX_EFLAG_INITIALIZED flag to scx_exit_info.flags to
indicate whether ops.init() finished successfully.

This enables BPF schedulers to distinguish between exit scenarios and
handle cleanup appropriately based on initialization state.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          |  1 +
 kernel/sched/ext_internal.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5801ac676d59..d131e98156ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4554,6 +4554,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			scx_error(sch, "ops.init() failed (%d)", ret);
 			goto err_disable;
 		}
+		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
 	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 1a80d01b1f0c..b3617abed510 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -62,6 +62,16 @@ enum scx_exit_code {
 	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
 };
 
+enum scx_exit_flags {
+	/*
+	 * ops.exit() may be called even if the loading failed before ops.init()
+	 * finishes successfully. This is because ops.exit() allows rich exit
+	 * info communication. The following flag indicates whether ops.init()
+	 * finished successfully.
+	 */
+	SCX_EFLAG_INITIALIZED,
+};
+
 /*
  * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
  * being disabled.
@@ -73,6 +83,9 @@ struct scx_exit_info {
 	/* exit code if gracefully exiting */
 	s64			exit_code;
 
+	/* %SCX_EFLAG_* */
+	u64			flags;
+
 	/* textual representation of the above */
 	const char		*reason;
 
-- 
2.51.0


