Return-Path: <bpf+bounces-21080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F6184793A
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F36E29115E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EB80624;
	Fri,  2 Feb 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2FYOM+i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171618061D
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900738; cv=none; b=ZPxlxH8BhQGLymDyJ4VoBNtwZo1whesFxYNivRx6BFj+KqJvilOZ6e4vCpgftNUz3P5MNWOgYxCl+SvD52gTX4Eu8Ekf9DEWDDL/Vd8yxIUfg395boP17tOl83CbC9eHEJvKV9VWsu57ahTFjAu6/aKyYigU+p1gI0ack98ZCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900738; c=relaxed/simple;
	bh=qLIuT+tqxzk7NiVcbR9Qeqe1gnvsHDjqUp7uVY9KBro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSfEj1QghiSfE+gbA0VwWFTemylZcXK2grL3yoZ742MFEu+5CIoJqh+cwh/pR5cY+Eablqo6XoKfBmKWL+LDIhVvTIWHBk4Jq7JlxuX+7qGfaCsmxjzJMmogyX0QELASCLmBA43cS0E1zoYok5763YvUu0dw69gGCE0iDdwu7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2FYOM+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B57C43390;
	Fri,  2 Feb 2024 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900737;
	bh=qLIuT+tqxzk7NiVcbR9Qeqe1gnvsHDjqUp7uVY9KBro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2FYOM+iCTdl8lLGw05oLOp/53B+cafJ0RlC5xn0q38sRAOLvy0CddF43YS29xs5+
	 0OAqnmUP2SMmmynOuK1brqrnm4zjpXHS/FaYuoyqEpnlmdeDQl9+SSHBJt56iXju+o
	 ugKvj7NUSpn+ik31/Ujxh9aGndwLaVi/5JZVnA27L8FrqpaHGN5nBJMAr9IB5l/gWY
	 k59ltvVNkkQvn/z89p5nxpeIwKWjiq5leH9ykvf2BCGQCZSUTOq0K1q/aJBRMMM1GW
	 /mhB3pGA3cmcErnpoZNwspeEHUBuylKyIYjWM6lmMcUMuywDZzcfuvA1Gc/LvCsSGj
	 z81OBJI+60KWA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] selftests/bpf: add more cases for __arg_trusted __arg_nullable args
Date: Fri,  2 Feb 2024 11:05:28 -0800
Message-Id: <20240202190529.2374377-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202190529.2374377-1-andrii@kernel.org>
References: <20240202190529.2374377-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra layer of global functions to ensure that passing around
(trusted) PTR_TO_BTF_ID_OR_NULL registers works as expected. We also
extend trusted_task_arg_nullable subtest to check three possible valid
argumements: known NULL, known non-NULL, and maybe NULL cases.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 484d6262363f..4ab0ef18d7eb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -19,15 +19,41 @@ __weak int subprog_trusted_task_nullable(struct task_struct *task __arg_trusted
 	return task->pid + task->tgid;
 }
 
-SEC("?kprobe")
+__weak int subprog_trusted_task_nullable_extra_layer(struct task_struct *task __arg_trusted __arg_nullable)
+{
+	return subprog_trusted_task_nullable(task) + subprog_trusted_task_nullable(NULL);
+}
+
+SEC("?tp_btf/task_newtask")
 __success __log_level(2)
 __msg("Validating subprog_trusted_task_nullable() func#1...")
 __msg(": R1=trusted_ptr_or_null_task_struct(")
 int trusted_task_arg_nullable(void *ctx)
 {
-	struct task_struct *t = bpf_get_current_task_btf();
+	struct task_struct *t1 = bpf_get_current_task_btf();
+	struct task_struct *t2 = bpf_task_acquire(t1);
+	int res = 0;
 
-	return subprog_trusted_task_nullable(t) + subprog_trusted_task_nullable(NULL);
+	/* known NULL */
+	res += subprog_trusted_task_nullable(NULL);
+
+	/* known non-NULL */
+	res += subprog_trusted_task_nullable(t1);
+	res += subprog_trusted_task_nullable_extra_layer(t1);
+
+	/* unknown if NULL or not */
+	res += subprog_trusted_task_nullable(t2);
+	res += subprog_trusted_task_nullable_extra_layer(t2);
+
+	if (t2) {
+		/* known non-NULL after explicit NULL check, just in case */
+		res += subprog_trusted_task_nullable(t2);
+		res += subprog_trusted_task_nullable_extra_layer(t2);
+
+		bpf_task_release(t2);
+	}
+
+	return res;
 }
 
 __weak int subprog_trusted_task_nonnull(struct task_struct *task __arg_trusted)
-- 
2.34.1


