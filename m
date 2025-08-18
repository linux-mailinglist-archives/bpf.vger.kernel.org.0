Return-Path: <bpf+bounces-65901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7AB2AEDB
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF953582167
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40234575C;
	Mon, 18 Aug 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z2Iw0gpu"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DD3469FC
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536522; cv=none; b=l+89gxEGsEJjuESf2r9XXfm4FlFCuW46f2IwZZlNIzzzwfymFEu4Z4ZLo992aQ9eJ5/HndiTBz59ZEmmvOvEvyrMMAbDdC+XzCK5V0GShvrgNZJ8X8LxqOb2Mb7oEVWlFRh/nAg7FmGUEHJeYo9PDJvCFs31Q8GFum0D290+Mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536522; c=relaxed/simple;
	bh=VmVEbFLEnyWhw3pWoNq/VuyY2/MD0Sg3ccZdi1IaiWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsngr0e+oNT5ZJ7IhxXem8/KCde8kchhQp7pSnuwV3coVFZauyF9roQYv4v2rI0jWTUYyzY39F1wt0xE70Ok0TpfdJ6MVw48OLTz6ghD0FGbmsmaJ2pNglQ0kMxaUw/+QchozvBcoBPKuzB5c8vrdEcZZons/21UKp+jBBYxQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z2Iw0gpu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4x/oF580ZECIilVQBke49Y0d4JocMOGaoYxAcI7yCk=;
	b=Z2Iw0gput+/1fflbYf2ysFeYgnLOuo3q4kzRyb0+67lL+EX7r6p97LEJYkWsfd7bCEAx5J
	1hWjzQB4MXsokOE7orCwLZNINuFfdXPIqQdMjjNWV5dDpCNH8gDSOxB4hx49h8ecYAevuZ
	gmlq3d8JVscbFimgiJC+HXmEhEVEYp8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 03/14] mm: introduce bpf_oom_kill_process() bpf kfunc
Date: Mon, 18 Aug 2025 10:01:25 -0700
Message-ID: <20250818170136.209169-4-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
to be used by bpf OOM programs. It allows to kill a process
in exactly the same way the OOM killer does: using the OOM reaper,
bumping corresponding memcg and global statistics, respecting
memory.oom.group etc.

On success, it sets om_control's bpf_memory_freed field to true,
enabling the bpf program to bypass the kernel OOM killer.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ad7bd65061d6..25fc5e744e27 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1282,3 +1282,70 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_kfunc_start_defs();
+/**
+ * bpf_oom_kill_process - Kill a process as OOM killer
+ * @oc: pointer to oom_control structure, describes OOM context
+ * @task: task to be killed
+ * @message__str: message to print in dmesg
+ *
+ * Kill a process in a way similar to the kernel OOM killer.
+ * This means dump the necessary information to dmesg, adjust memcg
+ * statistics, leverage the oom reaper, respect memory.oom.group etc.
+ *
+ * bpf_oom_kill_process() marks the forward progress by setting
+ * oc->bpf_memory_freed. If the progress was made, the bpf program
+ * is free to decide if the kernel oom killer should be invoked.
+ * Otherwise it's enforced, so that a bad bpf program can't
+ * deadlock the machine on memory.
+ */
+__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
+				     struct task_struct *task,
+				     const char *message__str)
+{
+	if (oom_unkillable_task(task))
+		return -EPERM;
+
+	/* paired with put_task_struct() in oom_kill_process() */
+	task = tryget_task_struct(task);
+	if (!task)
+		return -EINVAL;
+
+	oc->chosen = task;
+
+	oom_kill_process(oc, message__str);
+
+	oc->chosen = NULL;
+	oc->bpf_memory_freed = true;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_oom_kfuncs)
+BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_oom_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_kfuncs,
+};
+
+static int __init bpf_oom_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_oom_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf oom kfuncs: %d", err);
+
+	return err;
+}
+late_initcall(bpf_oom_init);
+
+#endif
-- 
2.50.1


